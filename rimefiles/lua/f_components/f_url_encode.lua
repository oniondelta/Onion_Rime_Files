
--[[
百分號編碼（英語：Percent-encoding），又稱：URL編碼（URL encoding）
從文字到編碼
--]]
local function url_encode(str_e)
  if (str_e) then
    str_e = string.gsub(str_e, "\n", "\r\n")
    -- str_e = string.gsub(str_e, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)  -- 網上很多版本使用參數，會轉義「_」。
    -- str_e = string.gsub(str_e, "([^%w%d%._%-%* ])", function(c) return string.format("%%%02X", string.byte(c)) end)  -- 標準 encode？
    str_e = string.gsub(str_e, "([^%w ])", function(c) return string.format("%%%02X", string.byte(c)) end)  -- 「%w」為字母數字[a-zA-Z0-9]。
    -- str_e = string.gsub(str_e, "([^ ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    str_e = string.gsub(str_e, "^ $", "%%20")
    str_e = string.gsub(str_e, " ", "+")
  end
  return str_e
end

return url_encode