--[[
內碼輸入法，輸入 unicode 碼得出該碼字元
--]]
local function utf8_out(cp)
  --- 新增避免 error！
  if cp > 1048575 then
    cp = 0
    return cp
  end
  --- 以下為原碼開始
  local string_char = string.char
  if cp < 128 then
    return string_char(cp)
  end
  local suffix = cp % 64
  local c4 = 128 + suffix
  cp = (cp - suffix) / 64
  if cp < 32 then
    return string_char(192 + cp, c4)
  end
  suffix = cp % 64
  local c3 = 128 + suffix
  cp = (cp - suffix) / 64
  if cp < 16 then
    return string_char(224 + cp, c3, c4)
  end
  suffix = cp % 64
  cp = (cp - suffix) / 64
  return string_char(240 + cp, 128 + suffix, c3, c4)
end

return utf8_out