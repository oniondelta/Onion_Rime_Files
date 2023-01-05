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

local function comment_filter_plus(input, env)
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  -- local find_prefix = env.engine.context.input
  -- local pun1 = string.match(find_prefix, "^'/" )
  -- local pun2 = string.match(find_prefix, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.match(find_prefix, "[]\\[]+$" )
  -- local pun4 = string.match(find_prefix, "^[;|][;]?$" )
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