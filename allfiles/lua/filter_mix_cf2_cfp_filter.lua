--- @@ mix_cf2_cfp_filter
--[[
（dif1）
合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
--]]
local function mix_cf2_cfp_filter(input, env)
  local c_f2_s = env.engine.context:get_option("zh_tw")
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  -- local find_prefix = env.engine.context.input
  -- local pun1 = string.find(find_prefix, "^'/" )
  -- local pun2 = string.find(find_prefix, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.find(find_prefix, "[]\\[]+$" )
  -- local pun4 = string.find(find_prefix, "^[;|][;]?$" )
  if (c_f2_s) then
    for cand in input:iter() do
      if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) then
      -- if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
        yield(cand)
      elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) then
      -- elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  else
    if (not s_c_f_p_s) then
    -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
      for cand in input:iter() do
        yield(cand)
      end
    else
      for cand in input:iter() do
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  end
end

return mix_cf2_cfp_filter