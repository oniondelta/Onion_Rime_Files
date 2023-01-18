--- @@ mix_cf2_cfp_filter
--[[
（dif1）
合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
--]]
-- local function mix_cf2_cfp_filter(input, env)
--   local c_f2_s = env.engine.context:get_option("character_range_bhjm")
--   local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
--   -- local find_prefix = env.engine.context.input
--   -- local pun1 = string.match(find_prefix, "^'/" )
--   -- local pun2 = string.match(find_prefix, "==?[]`0-9-=';,./[]*$" )
--   -- local pun3 = string.match(find_prefix, "[]\\[]+$" )
--   -- local pun4 = string.match(find_prefix, "^[;|][;]?$" )
--   if (c_f2_s) then
--     for cand in input:iter() do
--       if (not string.match(cand.text, '᰼᰼' )) and (not s_c_f_p_s) then
--       -- if (not string.match(cand.text, '᰼᰼' )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
--         yield(cand)
--       elseif (not string.match(cand.text, '᰼᰼' )) and (s_c_f_p_s) then
--       -- elseif (not string.match(cand.text, '᰼᰼' )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
--         cand:get_genuine().comment = ""
--         yield(cand)
--       end
--     end
--   else
--     if (not s_c_f_p_s) then
--     -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
--       for cand in input:iter() do
--         yield(cand)
--       end
--     else
--       for cand in input:iter() do
--         cand:get_genuine().comment = ""
--         yield(cand)
--       end
--     end
--   end
-- end

---------------
local function drop_cand(tran,mstr)
  for cand in tran:iter() do
    if not cand.text:match(mstr) then
      yield(cand)
    end
  end
end
----------------
local function clear_comment(cand,comment)
  cand:get_genuine().comment = comment
  return cand
end

local function mix_cf2_cfp_filter(inp,env)
  local c_f2_s = env.engine.context:get_option("character_range_bhjm")
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  -- 當 c_f2_s true  去掉 cand.text 有'᰼᰼' 的cand
  local tran = c_f2_s and Translation(drop_cand, inp, '᰼᰼') or inp
  
  for cand in tran:iter() do
    --  s_c_f_p_s true 時 清除 comment
    yield( s_c_f_p_s and clear_comment(cand,"") or cand )
  end
end

return mix_cf2_cfp_filter
