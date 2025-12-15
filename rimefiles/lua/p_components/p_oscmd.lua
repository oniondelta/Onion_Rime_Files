--[[
依據 os 判斷 cmd 命令前綴為何
--]]

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
-- local oscmd = string.find(d_c_name, "Weasel") and 'start "" ' or  -- weasel
--               string.find(d_c_name, "windows") and 'start "" ' or  -- fcitx5-windows
--               string.find(d_c_name, "Squirrel") and 'open ' or  -- squirrel
--               string.find(d_c_name, "macos") and 'open ' or  -- fcitx5-macos
--               string.find(d_c_name, "ibus") and 'xdg-open ' or  -- ibus-rime
--               -- -- 以下防名稱有疏漏，且避免小狼毫問題當機！於此判定是否為 windows！
--               -- -- os.getenv()可能為 nil，不可直接「sub()」或「lower()」，會報錯！
--               os.getenv('OS') and string.match(string.lower(os.getenv('OS')), "windows") and 'start "" ' or
--               os.getenv('OS') and string.match(string.lower(os.getenv('OS')), "^mingw") and 'start "" ' or
--               os.getenv('OS') and string.match(string.lower(os.getenv('OS')), "^cygwin") and 'start "" ' or
--               -- string.sub(package.config, 1,1) == '\\' and 'start "" ' or  -- 該條目會拖慢呼叫速度！！！
--               'xdg-open '
---------------------------------------------------------------
-- --- 用 os.getenv 參數判斷 os
-- local oscmd = os.getenv("USERPROFILE") and 'start "" ' or  -- Windows
--               os.getenv("HOME") and string.sub(os.getenv("HOME"), 1,7) == '/Users/' and 'open ' or  -- Mac
--               os.getenv("HOME") and string.sub(os.getenv("HOME"), 1,6) == '/home/' and 'xdg-open ' or  -- Linux
--               'xdg-open '
--               -- nil  -- 設 nil 可使無法判斷之 os 不亂跑無效執行！
-- -- 測試 Windows 之 os.getenv("HOME") 為 nil，但網路資訊說明某些 Win 版本不為 nil？
-- -- os.getenv("USERPROFILE")只在 Win 不為 nil。
-- -- os.getenv()可能為 nil，不可直接「sub()」或「lower()」，會報錯！
---------------------------------------------------------------

return oscmd