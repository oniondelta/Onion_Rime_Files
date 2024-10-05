--- 縮減 comment 防程式崩潰

----------------------------------------------------------------------------------------
local utf8_sub = require("f_components/f_utf8_sub")
----------------------------------------------------------------------------------------

local function truncate_comment(comment)
  local MAX_LENGTH = 50
  local gsub_fmt = package.config:sub(1,1) == "/" and "\n" or "\r"
  local result = comment:gsub("\\n",gsub_fmt)
  if #result > MAX_LENGTH then
    result = utf8_sub(result, 1, MAX_LENGTH) .. "……《略》"
  end
  return result
end

return truncate_comment