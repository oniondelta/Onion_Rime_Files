--- @@ comment_filter_unicode
--[[
（）
註釋 Unicode 編碼
--]]
----------------

-- local change_comment = require("filter_cand/change_comment")
-- local change_preedit = require("filter_cand/change_preedit")
-- local url_encode = require("f_components/f_url_encode")

local tran_utf8_comment = require("filter_cand/tran_utf8_comment")
-- local utf8_comment = require("filter_cand/utf8_comment")
-- local utf8_comment = require("filter_cand/utf8_comment").utf8_comment
-- local t_utf8_comment = require("filter_cand/utf8_comment").t_utf8_comment

----------------
-- local M={}
local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local schema_id = config:get_string("schema/schema_id")
  -- local s_bo = string.match( schema_id, "^bo")
  local s_1 = string.match( schema_id, "^bo_mixin")
  local s_2 = string.match( schema_id, "^bopomo_onionplus")
  -- -- local s_3 = string.match( schema_id, "^bopomo_onion_double")
  -- -- local s_4 = string.match( schema_id, "^onion[-]array30") -- 開頭含有空碼「⎔」，選單會整個消失。
  -- local s_5 = string.match( schema_id, "^ocm_")
  -- local s_6 = string.match( schema_id, "^dif1")
  check_schema = function(input)
    -- if s_bo then
    if s_1 or s_2 then
      check_input = not string.match(input, "``?$") or string.match(input, "=``?$")
    else
      check_input = not string.match(input, "^;;?$")
    end
    return check_input
  end
end

-- function M.fini(env)
-- end

-- local function check_schema(input)
--   -- if s_bo then
--   if s_1 or s_2 then
--     check_input = not string.match(input, "``?$") or string.match(input, "=``?$")
--   else
--     check_input = not string.match(input, "^;;?$")
--   end
--   return check_input
-- end

local function tags_match(seg,env)
  local engine = env.engine
  local context = engine.context
  local u_c = context:get_option("unicode_comment")
  local seg_1 = seg:has_tag("mf_translator")
  local seg_2 = seg:has_tag("email_url_translator")
  local seg_3 = seg:has_tag("easy_en")
  local seg_4 = seg:has_tag("easy_en_upper")
  local exclude_seg = seg_1 or seg_2 or seg_3 or seg_4
  local c_input = context.input
  local check_inp = check_schema(c_input)
  local u_c2 = u_c and not exclude_seg and check_inp
  return u_c2
end




-- local function comment_filter_unicode(inp,env)
local function filter(inp, env)
  -- local engine = env.engine
  -- local context = engine.context
  -- local c_input = context.input
  -- local check_inp = check_schema(c_input)
  -- local tab={}

--------------------------------------------
---- 寫法一

  -- for cand in inp:iter() do
  --   local utf8comment = utf8_comment(cand.text)
  --   -- local utf8comment = "  U+" .. string.format("%X",utf8.codepoint(cand.text)) .. "  ( " .. url_encode(cand.text) .. " ）"

  --   if not exclude_seg and check_inp and utf8.len(cand.text) == 1 then
  --     -- local cand = change_comment(cand, utf8comment .. cand.comment)
  --     -- local cand = ShadowCandidate(cand, "shadow_unicode", cand.text, utf8comment .. cand.comment)
  --     local cand = UniquifiedCandidate(cand, "uniq_unicode", cand.text, utf8comment .. cand.comment)
  --     yield(cand)

  --     -- if tab[cand.text] then
  --     --   tab[cand.text]:append(cand)
  --     -- else
  --     --   tab[cand.text] = cand:to_uniquified_candidate("uniquified", cand.text, cand.type .. utf8comment .. cand.comment)
  --     --   yield(tab[cand.text])
  --     -- end

  --   -- if u_c and utf8.len(cand.text) == 1 and cand.type == "simplified" then
  --   --   local newpreedit = cand.preedit
  --   --   local _end2 = context:get_preedit().sel_end
  --   --   local cand = Candidate("simp_unicode", 0, _end2, cand.text, cand.type .. utf8comment .. cand.comment)
  --   --   yield(change_preedit(cand,newpreedit))
  --   --   yield(cand)
  --   -- elseif u_c and utf8.len(cand.text) == 1 then
  --   --   yield(change_comment(cand, cand.type .. utf8comment .. cand.comment ))
  --   --   -- yield(change_comment(cand, ""))  -- 測試用

  --   -- ----  u_c true 時
  --   -- -- yield( u_c and utf8.len(cand.text)==1 and change_comment(cand,"") or cand )

  --   else
  --     yield(cand)

  --   end
  -- end

--------------------------------------------
---- 寫法二

  -- for cand in inp:iter() do

  --   local cand_text = cand.text  -- cand.text ~= "" and cand.text or "〖空碼〗"
  --   -- local utf8comment = utf8_comment(cand_text)  -- 遮屏後，utf8.len(cand_text) == 1再跑
  --   yield(utf8.len(cand_text) == 1 -- 可改用 utf8_comment(cand_text) 內限定
  --         and UniquifiedCandidate(cand, "uniq_unicode", cand_text, utf8_comment(cand_text) .. cand.comment) or
  --         cand
  --         )  --check_inp and 

  --   -- local cand_text = cand.text
  --   -- if check_inp and utf8.len(cand_text) == 1 then -- 可改用 utf8_comment(cand_text) 內限定
  --   --   local utf8comment = utf8_comment(cand_text)
  --   --   yield(UniquifiedCandidate(cand, "uniq_unicode", cand_text, utf8comment .. cand.comment))
  --   -- else
  --   --   yield(cand)
  --   -- end

  -- end

--------------------------------------------
---- 寫法三

  -- local tran = check_inp and Translation(t_utf8_comment, inp) or inp
  local tran = Translation(tran_utf8_comment, inp) or inp  --check_inp and 
  for cand in tran:iter() do
    yield(cand)
  end

--------------------------------------------

end

----------------
-- return comment_filter_unicode
return { init = init , func = filter , tags_match = tags_match }
-- return M
----------------