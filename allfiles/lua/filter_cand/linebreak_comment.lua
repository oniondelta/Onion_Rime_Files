--- comment 含有分號「;」且過長轉換為多行（換行）

----------------------------------------------------------------------------------------
-- local utf8_sub = require("f_components/f_utf8_sub")
----------------------------------------------------------------------------------------
local function split_semicolon(text, length)

  i = 0
  while string.find(text, "\n[^\n;]+;") do
    a, b = string.find(text, "\n[^\n;]+;")
    local front_part = b and string.sub(text, 1, b) or ""
    local back_part = b and string.sub(text, b+1, -1) or ""
    -- n = a and b-a or 0
    n = b and utf8.len(string.sub(front_part, a+1, b)) or 0  -- utf8.len(string.sub(front_part, a+1, -1))
    if n == 0 then
      break
    elseif n > length then
      text = string.gsub(front_part, ";$", "@\n") .. back_part
    else
      text = string.gsub(front_part, ";$", "@") .. back_part
    end
    i = i + 1
    if i > 7 then  -- 防無限迴圈崩潰！（可處理 x+1 次分號）
      break
    end
  end
  -- local text = i ~= 0 and string.gsub(text, "@", ";") or text -- .. "TEST@@"  -- 測試用。

  return i == 0 and text or string.gsub(text, "@", ";")
end


local function linebreak_comment(comment)
  local MAX_LENGTH = 50  -- 多少個 comment 總字數（含：Unicode字、字母、空格）始執行「;」分段。
  local MAX_SEMICOLON_LENGTH = 10  -- 每行「\n」到「;」間多少個字（含：Unicode字、字母、空格）始執行「;」分段。
----------------------------------------------------------------
  -- -- 引入原 comment 為「\n」，測試不需根據 os 轉換「\n」和「\r」？
  -- local gsub_fmt = string.sub(package.config, 1,1) == "/" and "\n" or "\r"
  -- local gsub_fmt = os_name == 2 and "\n" or
  --                  os_name == 170 and "\n" or
  --                  "\r"
  -- local comment = string.gsub(comment, "\n", gsub_fmt)
----------------------------------------------------------------
  -- if #comment > MAX_LENGTH then
  if utf8.len(comment) > MAX_LENGTH then
    -- comment = string.gsub(comment, ";", ";" .. "\n" )  -- 碰到「;」就直接換行。
    comment = split_semicolon(comment, MAX_SEMICOLON_LENGTH)
  end
  return comment
end

return linebreak_comment