--- @@ comment_filter_plus
--[[
（Mount_ocm）
去除後面編碼註釋
--]]


-- local function xform_c(cf)
--   if cf == "" then return "" end
--   cf = string.gsub(cf, "[ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ%s]+$", "zk")
--   return cf
-- end




--- 以下新的寫法

----------------

local change_comment = require("filter_cand/change_comment")

----------------
-- local M={}
-- local function init(env)
-- function M.init(env)
-- end

-- function M.fini(env)
-- end

-- local function comment_filter_plus(inp,env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local s_c_f_p_s = context:get_option("simplify_comment")
  for cand in inp:iter() do
    --  s_c_f_p_s true 時 清除 comment
    yield( s_c_f_p_s and change_comment(cand,"") or cand )
  end
end
----------------
-- return comment_filter_plus
return { func = filter }
-- return M
----------------





--- 以下舊的寫法
--[[
local function comment_filter_plus(input, env)
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  -- local c_input = env.engine.context.input
  -- local pun1 = string.match(c_input, "^'/" )
  -- local pun2 = string.match(c_input, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.match(c_input, "[]\\[]+$" )
  -- local pun4 = string.match(c_input, "^[;|][;]?$" )
  if (not s_c_f_p_s) then
  -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
  -- 使用 `iter()` 遍歷所有輸入候選項
    for cand in input:iter() do
      yield(cand)
    end
  else
    for cand in input:iter() do
    --   -- comment123 = cand.comment .. cand.text .. "open"
    --   -- comment123 = cand.comment
    --   -- comment123 = "kkk" .. comment123
    --   -- cand:get_genuine().comment = comment123 .." "
      cand:get_genuine().comment = ""
      yield(cand)
    end
  end
end

return comment_filter_plus
--]]