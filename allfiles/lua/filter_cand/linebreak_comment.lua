--- 過長 comment 換行

----------------------------------------------------------------------------------------
-- local utf8_sub = require("f_components/f_utf8_sub")
----------------------------------------------------------------------------------------
local function split_semicolon(text, length)

  i = 0
  while text:find("\n[^\n;]+;") do
    a, b = text:find("\n[^\n;]+;")
    local front_part = b and text:sub(1, b) or ""
    local back_part = b and text:sub(b+1, -1) or ""
    -- n = a and b-a or 0
    -- if n > length then
    if utf8.len(front_part) > length then
      text = front_part:gsub(";$", "@\n") .. back_part
    else
      text = front_part:gsub(";$", "@") .. back_part
    end
    if i > 9 then  -- 防無限迴圈崩潰！
      break
    end
    i = i + 1
  end
  -- local text = i ~= 0 and text:gsub("@",";") or text -- .. "TEST@@"  -- 測試用。

  return i == 0 and text or text:gsub("@",";")
end


local function linebreak_comment(comment)
  local MAX_LENGTH = 60 --50
  local MAX_SEMICOLON_LENGTH = 20  --18
----------------------------------------------------------------
  -- -- 原 comment 為「\n」，測試不需根據 os 轉換「\n」和「\r」？
  -- local gsub_fmt = package.config:sub(1,1) == "/" and "\n" or "\r"
  -- local gsub_fmt = os_name == 2 and "\n" or
  --                  os_name == 170 and "\n" or
  --                  "\r"
  -- local comment = comment:gsub("\n", gsub_fmt)
----------------------------------------------------------------
  -- if #comment > MAX_LENGTH then
  if utf8.len(comment) > MAX_LENGTH then
    -- comment = comment:gsub( ";", ";" .. "\n" )  -- 碰到「;」就直接換行。
    comment = split_semicolon(comment, MAX_SEMICOLON_LENGTH)
  end
  return comment
end

return linebreak_comment