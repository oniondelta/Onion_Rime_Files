--- @@ symbols_mark_filter
--[[
（關，但 mix_cf2_cfp_smf_filter 有用到某元件，部分開啟）
候選項註釋符號、音標等屬性之提示碼(comment)（用 opencc 可實現，但無法合併其他提示碼(comment)，改用 Lua 來實現）
--]]

local ocmdb = ReverseDb("build/symbols-mark.reverse.bin")

local function xform_mark(inp)
  if inp == "" then return "" end
  inp = string.gsub(inp, "，", ", ")
  -- inp = string.gsub(inp, "^(〔.+〕)(〔.+〕)$", "%1")
  return inp
end

-- function symbols_mark_filter(input, env)
--   local b_k = env.engine.context:get_option("back_mark")
--   if (b_k) then
--     for cand in input:iter() do
--       cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
--       -- cand:get_genuine().comment = cand.comment .. ocmdb:lookup(cand.text)
--       yield(cand)
--     end
--   else
--     for cand in input:iter() do
--       yield(cand)
--     end
--   end
-- end




--- @@ mix_cf2_cfp_smf_filter
--[[
（ocm_mixin）
合併 charset_filter2 和 comment_filter_plus 和 symbols_mark_filter，三個 lua filter 太耗效能。
沒用到 ocm_mixin 方案時，ReverseDb("build/symbols-mark.reverse.bin")會找不到。
--]]
local function mix_cf2_cfp_smf_filter(input, env)
  local c_f2_s = env.engine.context:get_option("character_range_bhjm")
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  local b_k = env.engine.context:get_option("back_mark")
  -- local find_prefix = env.engine.context.input
  -- local pun1 = string.find(find_prefix, "^'/" )
  -- local pun2 = string.find(find_prefix, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.find(find_prefix, "[]\\[]+$" )
  -- local pun4 = string.find(find_prefix, "^[;|][;]?$" )
  if (c_f2_s) and (b_k) then
    for cand in input:iter() do
      if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) then
      -- if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
        cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
        -- cand:get_genuine().comment = cand.comment .. ocmdb:lookup(cand.text)
        yield(cand)
      elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) then
      -- elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
        cand:get_genuine().comment = ""
        cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
        -- cand:get_genuine().comment = cand.comment .. ocmdb:lookup(cand.text)
        yield(cand)
      end
    end
  elseif (not c_f2_s) and (b_k) then
    if (not s_c_f_p_s) then
    -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
      for cand in input:iter() do
        cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
        -- cand:get_genuine().comment = cand.comment .. ocmdb:lookup(cand.text)
        yield(cand)
      end
    else
      for cand in input:iter() do
        cand:get_genuine().comment = ""
        cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
        -- cand:get_genuine().comment = cand.comment .. ocmdb:lookup(cand.text)
        yield(cand)
      end
    end
  elseif (c_f2_s) and (not b_k) then
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
  elseif (not c_f2_s) and (not b_k) then
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

return { mix_cf2_cfp_smf_filter = mix_cf2_cfp_smf_filter }
-- return { filter = charset_filter } --可變更名稱
-- return mix_cf2_cfp_smf_filter -- 無法

--[[ 導出帶環境初始化的組件。
需要兩個屬性：
 - init: 指向初始化函數
 - func: 指向實際函數
--]]
-- return { init = init, func = filter }