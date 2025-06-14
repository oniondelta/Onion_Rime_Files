--[[
開啟檔案/程式/網址
--]]


-- --- 最初的寫法
-- local function generic_open(dest)
--   if os.execute('start "" ' .. dest) then
--     return true
--   elseif os.execute('open ' .. dest) then
--     return true
--   elseif os.execute('xdg-open ' .. dest) then
--     return true
--   end
-- end


-- --- 最初的寫法(測試「會」辨別系統)
-- local function generic_open(dest)
--   if os.execute('start "" ' .. dest) then
--     return "trueWIN"
--   elseif os.execute('open ' .. dest) then
--     return "trueMAC"
--   elseif os.execute('xdg-open ' .. dest) then
--     return "trueLINUX"
--   end
-- end


-- --- 測試用寫法(測試「不會」辨別系統)
-- local function generic_open(dest)
--   -- 在 Windows 上使用 start 命令
--   local f_win = io.popen('start "" ' .. dest)
--   -- 在 macOS 上使用 open 命令
--   local f_mac = io.popen('open ' .. dest)
--   -- 在 Linux 上使用 xdg-open 命令
--   local f_linux = io.popen('xdg-open ' .. dest)
--   -- 讀取一下輸出，然後立即關閉檔案句柄
--   -- 這可能不會完全避免阻塞，因為 io.popen 會等待命令完成
--   -- 或者直到其輸出流被關閉。
--   if f_win then
--     -- f_win:read("*a") -- 讀取所有輸出
--     f_win:close()
--     return "trueWIN"
--   elseif f_mac then
--     -- f_mac:read("*a") -- 讀取所有輸出
--     f_mac:close()
--     return "trueMAC"
--   elseif f_linux then
--     -- f_linux:read("*a") -- 讀取所有輸出
--     f_linux:close()
--     return "trueLINUX"
--   else
--     return false
--   end
-- end


-- --- 新的寫法(以 os 判斷)
-- local get_os_name = require("f_components/f_get_os_name")
-- local os_name = get_os_name() or ""
-- local os_cmd = {
--                 ["Windows"] = 'start "" ',
--                 ["Mac"] = 'open ',
--                 ["Linux"] = 'xdg-open ',
--                 ["BSD"] = 'xdg-open ',
--                 ["Solaris"] = 'xdg-open ',
--                }
-- local function generic_open(dest)
--   local oscmd = os_cmd[os_name]
--   if oscmd ~= nil then
--     local f = io.popen( oscmd .. dest)
--     -- f:close()  -- 不能使用，於 0.17.0 以上之小狼毫會當機崩潰
--     f = nil
--     return true
--   end
-- end


--- 新的寫法(「三種 os 跑法」全跑一遍)
local function generic_open(dest)
  -- 在 Windows 上使用 start 命令
  local f = io.popen('start "" ' .. dest)
  -- 在 macOS 上使用 open 命令
  local f = io.popen('open ' .. dest)
  -- 在 Linux 上使用 xdg-open 命令
  local f = io.popen('xdg-open ' .. dest)
  -- f:close()  -- 不能使用，於 0.17.0 以上之小狼毫會當機崩潰
  f = nil
  -- --- 以下測試用
  -- if f == nil then
  --   return "false！！！"
  -- else
  --   return "true！！！"
  -- end
  return true
end


return generic_open