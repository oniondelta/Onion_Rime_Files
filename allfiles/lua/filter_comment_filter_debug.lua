--- @@ comment_filter_debug
--[[
（）
註釋 debug 訊息
--]]
----------------

-- local change_comment = require("filter_cand/change_comment")
-- local change_preedit = require("filter_cand/change_preedit")

local tran_debug_comment = require("filter_cand/tran_debug_comment")
-- local debug_comment = require("filter_cand/debug_comment")
-- local debug_comment = require("filter_cand/debug_comment").debug_comment
-- local t_debug_comment = require("filter_cand/debug_comment").t_debug_comment

----------------
-- local M={}
-- local function init(env)
-- function M.init(env)
-- end

-- function M.fini(env)
-- end

local function tags_match(seg,env)
  local engine = env.engine
  local context = engine.context
  local d_c = context:get_option("debug_comment")
  return d_c
end

-- local function comment_filter_debug(inp,env)
local function filter(inp, env)
  -- local engine = env.engine
  -- local context = engine.context
  -- local tab={}

--------------------------------------------
---- 寫法一

  -- for cand in inp:iter() do
  --   local debugcomment = debug_comment(cand)
  --   -- local debugcomment = "【"..cand:get_dynamic_type()..":"..cand.type.."| $ "..string.format("%6.6f", cand.quality).." | ‸ "..cand.start.."~"..cand._end.." 】"
  --   -- -- local debugcomment = "【 "..cand:get_dynamic_type().."|"..cand.type.."┃q: "..string.format("%6.6f", cand.quality).."┃s: "..cand.start.." e: "..cand._end.." 】"

  --   -- local cand = change_comment(cand, debugcomment .. cand.comment)
  --   local cand = ShadowCandidate(cand, "shadow_debug", cand.text, debugcomment .. cand.comment)
  --   -- local cand = UniquifiedCandidate(cand, "uniq_debug", cand.text, debugcomment .. cand.comment)
  --   yield(cand)

  -- -- -- yield(change_comment(cand, ""))  -- 測試用
  -- -- -- yield( u_c and utf8.len(cand.text)==1 and change_comment(cand,"") or cand )

  -- end

--------------------------------------------
---- 寫法二

  -- for cand in inp:iter() do
  --   -- local debugcomment = debug_comment(cand)
  --   local cand_text = cand.text
  --   yield(UniquifiedCandidate(cand, "uniq_debug", cand_text, debug_comment(cand) .. cand.comment))
  --   --- 用 ShadowCandidate 某些狀況下，無法記憶
  --   -- yield(ShadowCandidate(cand, "shadow_debug", cand_text, debug_comment(cand) .. cand.comment))
  -- end

--------------------------------------------
---- 寫法三

  -- local tran = Translation(t_debug_comment, inp) or inp
  local tran = Translation(tran_debug_comment, inp) or inp
  for cand in tran:iter() do
    yield(cand)
  end

--------------------------------------------

end

----------------
-- return comment_filter_debug
return { func = filter , tags_match = tags_match }
-- return M
----------------