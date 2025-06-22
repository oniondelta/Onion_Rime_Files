--[[
開啟檔案/程式/網址
--]]


-- ---- 最初的寫法
-- local function generic_open(dest)
--   if os.execute('start "" ' .. dest) then
--     return true
--   elseif os.execute('open ' .. dest) then
--     return true
--   elseif os.execute('xdg-open ' .. dest) then
--     return true
--   end
-- end


-- ---- 最初的寫法(測試「會」辨別系統)
-- local function generic_open(dest)
--   if os.execute('start "" ' .. dest) then
--     return "trueWIN"
--   elseif os.execute('open ' .. dest) then
--     return "trueMAC"
--   elseif os.execute('xdg-open ' .. dest) then
--     return "trueLINUX"
--   end
-- end


-- ---- 測試用寫法(測試「不會」辨別系統)
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


-- ---- 新的寫法(「三種 os 跑法」全跑一遍)
-- local function generic_open(dest)
--   -- 以下處理「-removeopen 」，為特此標示去移除開頭之「open和start等」，有些指令不能有開頭command！
--   if dest:match("^-removeopen ") then
--     local dest = dest:gsub("^-removeopen ", "")
--     -- local f = io.popen(dest)
--     -- f = nil
--     return io.popen(dest) and true or false
--   elseif dest ~= nil then
--     -- 在 Windows 上使用 start 命令
--     -- local f = io.popen('start "" ' .. dest)
--     -- 在 macOS 上使用 open 命令
--     -- local f = io.popen('open ' .. dest)
--     -- 在 Linux 上使用 xdg-open 命令
--     -- local f = io.popen('xdg-open ' .. dest)
--     -- f:close()  -- 不能使用，於 0.17.0 以上之小狼毫會當機崩潰
--     -- f = nil
--     -- --- 以下測試用
--     -- if f == nil then
--     --   return "false！！！"
--     -- else
--     --   return "true！！！"
--     -- end
--     --- 承上改寫
--     io.popen('start "" ' .. dest)
--     io.popen('open ' .. dest)
--     io.popen('xdg-open ' .. dest)
--     return true
--   end
--   return false
-- end


---- 新的寫法(以 os 判斷)
---------------------------------------------------------------
-- --- 用外部模塊判斷 os
-- local get_os_name = require("f_components/f_get_os_name")
-- local os_name = get_os_name() or ""
-- local cmd_table = {
--                 ["Windows"] = 'start "" ',
--                 ["Mac"] = 'open ',
--                 ["Linux"] = 'xdg-open ',
--                 ["BSD"] = 'xdg-open ',
--                 ["Solaris"] = 'xdg-open ',
--                }
-- local oscmd = cmd_table[os_name]
---------------------------------------------------------------
--- 用外部模塊判斷 os （判斷 os 為簡化版）
local get_os_name = require("f_components/f_get_os_name_simple")
local os_name = get_os_name() or "unknown"
local cmd_table = {
                ["Windows"] = 'start "" ',
                ["Mac"] = 'open ',
                ["Linux"] = 'xdg-open ',
                ["BSD"] = 'xdg-open ',
                ["Solaris"] = 'xdg-open ',
                ["unknown"] = 'xdg-open ',
               }
local oscmd = cmd_table[os_name]
-- local oscmd = os_name == "Windows" and 'start "" ' or
--               os_name == "Mac" and 'open ' or
--               os_name == "Linux" and 'xdg-open ' or
--               os_name == "BSD" and 'xdg-open ' or
--               os_name == "Solaris" and 'xdg-open ' or
--               'xdg-open '
--               -- nil  -- 設 nil 可使無法判斷之 os 不亂跑無效執行！
---------------------------------------------------------------
-- --- 用 Rime 名稱判斷 os（會有不知名 Rime 輸入法軟體無法辨識的問題）
-- local d_c_name = rime_api.get_distribution_code_name() or "none"
-- local oscmd = d_c_name:find("Weasel") and 'start "" ' or  -- weasel
--               d_c_name:find("windows") and 'start "" ' or  -- fcitx5-windows
--               d_c_name:find("Squirrel") and 'open ' or  -- squirrel
--               d_c_name:find("macos") and 'open ' or  -- fcitx5-macos
--               d_c_name:find("ibus") and 'xdg-open ' or  -- ibus-rime
--               -- -- 以下防名稱有疏漏，且避免小狼毫問題當機！於此判定是否為 windows！
--               -- -- os.getenv()可能為 nil，不可直接lower「:lower()」，會報錯！
--               os.getenv('OS') and os.getenv('OS'):lower():match("windows") and 'start "" ' or
--               os.getenv('OS') and os.getenv('OS'):lower():match("^mingw") and 'start "" ' or
--               os.getenv('OS') and os.getenv('OS'):lower():match("^cygwin") and 'start "" ' or
--               -- package.config:sub(1,1) == '\\' and 'start "" ' or  -- 該條目會拖慢呼叫速度！！！
--               'xdg-open '
---------------------------------------------------------------
-- --- 用 os.getenv 參數判斷 os
-- local oscmd = os.getenv("USERPROFILE") and 'start "" ' or  -- Windows
--               os.getenv("HOME") and os.getenv("HOME"):sub(1,7) == '/Users/' and 'open ' or  -- Mac
--               os.getenv("HOME") and os.getenv("HOME"):sub(1,6) == '/home/' and 'xdg-open ' or  -- Linux
--               'xdg-open '
--               -- nil  -- 設 nil 可使無法判斷之 os 不亂跑無效執行！
-- -- 測試 Windows 之 os.getenv("HOME") 為 nil，但網路資訊說明某些 Win 版本不為 nil？
-- -- os.getenv("USERPROFILE")只在 Win 不為 nil。
-- -- os.getenv()可能為 nil，不可直接「:sub()」或「lower()」，會報錯！
---------------------------------------------------------------
local function generic_open(dest)
  if oscmd ~= nil and not dest:match("^-removeopen ") then
    -- local f = io.popen( oscmd .. dest)
    -- f:close()  -- 不能使用，於 0.17.0 以上之小狼毫會當機崩潰
    -- f = nil
    return io.popen( oscmd .. dest) and true or false
  -- 以下處理「-removeopen 」，為特此標示去移除開頭之「open和start等」，有些指令不能有開頭command！
  elseif oscmd ~= nil then
    local dest = dest:gsub("^-removeopen ", "")
    -- local f = io.popen(dest)
    -- f:close()  -- 不能使用，於 0.17.0 以上之小狼毫會當機崩潰
    -- f = nil
    return io.popen(dest) and true or false
  end
  return false
end


return generic_open