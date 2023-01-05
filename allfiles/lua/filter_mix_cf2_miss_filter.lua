--- @@ mix_cf2_miss_filter
--[[
（bopomo_onionplus 和 bo_mixin 全系列）
合併 charset_filter2 和 missing_mark_filter，兩個 lua filter 太耗效能。
--]]
local function mix_cf2_miss_filter(input, env)
  local c_f2_s = env.engine.context:get_option("character_range_bhjm")
  local p_key = env.engine.context.input
  local addcomment1 = string.match(p_key, '=%.$')
  local addcomment2 = string.match(p_key, '[][]$')
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
        if string.match(cand.text, '^。$') then
        -- if (dotend) then
        -- if (cand.text == '。') then
          cand:get_genuine().comment = "〔句點〕"
          yield(cand)
        elseif string.match(cand.text, '^〔$') or string.match(cand.text, '^〕$') then
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
        if string.match(cand.text, '^。$') then
        -- if (dotend) then
        -- if (cand.text == '。') then
          cand:get_genuine().comment = "〔句點〕"
          yield(cand)
        elseif string.match(cand.text, '^〔$') or string.match(cand.text, '^〕$') then
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