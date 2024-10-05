--- @@ mix_cf2_miss_filter
--[[
（bopomo_onionplus 和 bo_mixin 全系列）
合併 charset_filter2 和 missing_mark_filter，兩個 lua filter 太耗效能。
--]]




--- 以下新的寫法

----------------

local drop_cand = require("filter_cand/drop_cand")

local change_comment = require("filter_cand/change_comment")

-- local revise_preedit_by_os = require("filter_cand/revise_preedit_by_os")

--------------

-- -- local M={}
-- local function init(env)
-- -- function M.init(env)
--   local engine = env.engine
--   local schema = engine.schema
--   local config = schema.config
--   local schema_id = config:get_string("schema/schema_id") or ""
--   env.check_id = string.match(schema_id, "mixin") and true or false
-- end

-- function M.fini(env)
-- end

local function tags_match(seg,env)
  local engine = env.engine
  local context = engine.context
  c_f2_s = context:get_option("character_range_bhjm")
  o_ascii_punct = context:get_option("ascii_punct")
  c_input = context.input
  local seg_abc = seg:has_tag("abc")
  local seg_reverse = seg:has_tag("reverse2_lookup")
  seg_punct = seg:has_tag("punct")
  return seg_abc or seg_punct or seg_reverse
end

-- local function mix_cf2_miss_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  -- local engine = env.engine
  -- local context = engine.context
  -- local c_input = context.input
  -- local c_f2_s = context:get_option("character_range_bhjm")
  -- local o_ascii_punct = context:get_option("ascii_punct")
  -- -- local start = context:get_preedit().sel_start
  -- -- local _end = context:get_preedit().sel_end
  -- local addcomment1 = string.match(c_input, "=%.$")
  -- local addcomment2 = string.match(c_input, "[][]$")
  -- -- local addcand = string.match(c_input, "^'$")

  -- local tran = c_f2_s and Translation(drop_cand, inp, "᰼᰼") or inp

  -- if env.check_id then  -- 會覆蓋到不是abc的段落
  --   local p_1 = context:get_option("preedit_1")
  --   local p_2 = context:get_option("preedit_2")
  --   local p_3 = context:get_option("preedit_3")
  --   if p_1 then
  --     g_op = 1
  --   elseif p_2 then
  --     g_op = 2
  --   elseif p_3 then
  --     g_op = 3
  --   else
  --     g_op = 0
  --   end
  --   tran = Translation(revise_preedit_by_os, tran, g_op) or tran
  -- end

  -- for cand in tran:iter() do
  --   if addcomment1 then
  --     yield( cand.text == "。" and change_comment(cand,"〔句點〕") or cand )
  --     -- yield( string.match(cand.text, "^。$") and change_comment(cand,"〔句點〕") or cand )
  --   elseif addcomment2 then
  --     yield( (cand.text == "〔" or cand.text == "〕") and change_comment(cand,"〔六角括號〕")
  --         -- or cand.text == "〕" and change_comment(cand,"〔六角括號〕")
  --         or cand )
  --     -- yield( string.match(cand.text, "^〔$") and change_comment(cand,"〔六角括號〕")
  --     --     or string.match(cand.text, "^〕$") and change_comment(cand,"〔六角括號〕")
  --     --     or cand )
  --   elseif c_input == "'" and o_ascii_punct then
  --   -- elseif addcand and o_ascii_punct then
  --     local cand_add = Candidate("simp_apostrophe", 0, 1, "'", "")
  --     yield(cand_add)
  --     return
  --   else
  --     yield(cand)
  --   end
  -- end

  if not seg_punct then
  -- if seg_reverse or seg_reverse then
    local tran = c_f2_s and Translation(drop_cand, inp, "᰼᰼") or inp
    for cand in tran:iter() do
        yield(cand)
    end
  else
    for cand in inp:iter() do
      local cand_text = cand.text
      yield(cand_text == "。" and change_comment(cand,"〔句點〕") or
            (cand_text == "〔" or cand_text == "〕") and change_comment(cand,"〔六角括號〕") or
            o_ascii_punct and c_input == "'" and Candidate("simp_apostrophe", 0, 1, "'", "") or
            cand )
    end
  end

end
----------------
-- return mix_cf2_miss_filter
return { func = filter, tags_match = tags_match }
-- return { init = init, func = filter }
-- return M
----------------





--- 以下舊的寫法
--[[
local function mix_cf2_miss_filter(input, env)
  local c_f2_s = env.engine.context:get_option("character_range_bhjm")
  local c_input = env.engine.context.input
  local addcomment1 = string.match(c_input, '=%.$')
  local addcomment2 = string.match(c_input, '[][]$')
  if (c_f2_s) then
    for cand in input:iter() do
      -- local dnch = string.match(cand.text, '᰼᰼' )
      -- local dotend = string.match(cand.text, '。')
      -- local bracket1 = string.match(cand.text, '〔')
      -- local bracket2 = string.match(cand.text, '〕')
      if (not string.match(cand.text, '᰼᰼' )) and (not addcomment1) and (not addcomment2) then
      -- if (not dnch) and (not addcomment1) and (not addcomment2) then
      -- if (not string.match(cand.text, '.*᰼᰼.*' )) then
        yield(cand)
      elseif (addcomment1) or (addcomment2) then
      -- elseif (not dnch) and (addcomment1) or (addcomment2) then
      -- elseif (not string.match(cand.text, '᰼᰼' )) and (addcomment1) or (addcomment2) then
        if cand.text == "。" then
        -- if string.match(cand.text, '。') then
        -- if (dotend) then
        -- if (cand.text == '。') then
          cand:get_genuine().comment = "〔句點〕"
          yield(cand)
        elseif cand.text == "〔" or cand.text == "〕" then
        -- elseif string.match(cand.text, '^〔$') or string.match(cand.text, '^〕$') then
        -- elseif string.match(cand.text, "[〕〔]") then
        -- elseif (bracket1) or (bracket2) then
        -- elseif (cand.text == '〔') or (cand.text == '〕') then
          cand:get_genuine().comment = "〔六角括號〕"
          yield(cand)
        else
          yield(cand)
        end
      end
    end
  else
    if (addcomment1) or (addcomment2) then
      for cand in input:iter() do
        -- local dnch = string.match(cand.text, '᰼᰼' )
        -- local dotend = string.match(cand.text, '。')
        -- local bracket1 = string.match(cand.text, '〔')
        -- local bracket2 = string.match(cand.text, '〕')
        if cand.text == "。" then
        -- if string.match(cand.text, '。') then
        -- if (dotend) then
        -- if (cand.text == '。') then
          cand:get_genuine().comment = "〔句點〕"
          yield(cand)
        elseif cand.text == "〔" or cand.text == "〕" then
        -- elseif string.match(cand.text, '^〔$') or string.match(cand.text, '^〕$') then
        -- elseif string.match(cand.text, "[〕〔]") then
        -- elseif (bracket1) or (bracket2) then
        -- elseif (cand.text == '〔') or (cand.text == '〕') then
          cand:get_genuine().comment = "〔六角括號〕"
          yield(cand)
        else
          yield(cand)
        end
      end
    else
      for cand in input:iter() do
        yield(cand)
      end
    end
  end
end

return mix_cf2_miss_filter
--]]