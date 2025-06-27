--- 縮減 comment 防程式崩潰

----------------------------------------------------------------------------------------
local utf8_sub = require("f_components/f_utf8_sub")
----------------------------------------------------------------------------------------

local function truncate_comment(comment)
  local MAX_LENGTH = 50
----------------------------------------------------------------
  -- -- 引入原 comment 為「\n」，測試不需根據 os 轉換「\n」和「\r」？
  -- local gsub_fmt = string.sub(package.config, 1,1) == "/" and "\n" or "\r"
  -- local gsub_fmt = os_name == 2 and "\n" or
  --                  os_name == 170 and "\n" or
  --                  "\r"
  -- local comment = string.gsub(comment, "\n", gsub_fmt)
----------------------------------------------------------------
  if #comment > MAX_LENGTH then  -- 多少個 comment 總字串碼（Unicode字符一般佔3個）始執行縮減。
    comment = utf8_sub(comment, 1, MAX_LENGTH) .. "……《略》"
  end
  return comment
end

return truncate_comment