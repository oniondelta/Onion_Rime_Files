--- 獲得 os 系統名稱（簡化版）
--[[
（用 os.getenv('OS') 和 uname 判斷 os）
（用當前用戶的家目錄路徑判斷 os）
--]]


local function get_os_name_simple()

--------------------------------------------------------

  -- local raw_os_name = ""
  -- if os.getenv("USERPROFILE") then
  --   -- Windows
  --   if os.getenv('OS') then
  --     raw_os_name = os.getenv('OS') or ""
  --   end
  -- else
  --   -- other platform, assume uname support and popen support
  --   raw_os_name = io.popen('uname -s','r'):read('*l') or ""
  -- end

  -- local raw_os_name = (raw_os_name):lower()

--------------------------------------------------------

  -- local os_patterns = {
  --     ['windows']     = 'Windows',
  --     ['linux']       = 'Linux',
  --     ['osx']         = 'Mac',
  --     ['mac']         = 'Mac',
  --     ['darwin']      = 'Mac',
  --     ['^mingw']      = 'Windows',
  --     ['^cygwin']     = 'Windows',
  --     ['bsd$']        = 'BSD',
  --     ['sunos']       = 'Solaris',
  -- }

  -- local os_name = "unknown"
  -- for pattern, name in pairs(os_patterns) do
  --   if raw_os_name:match(pattern) then
  --     os_name = name
  --     break
  --   end
  -- end

--------------------------------------------------------
--------------------------------------------------------
  local os_name = os.getenv("USERPROFILE") and "Windows" or
                  os.getenv("HOME") and os.getenv("HOME"):sub(1,7) == "/Users/" and "Mac" or
                  os.getenv("HOME") and os.getenv("HOME"):sub(1,6) == "/home/" and "Linux" or
                  --------------------------------------------------------
                  -- raw_os_name:match("windows$") and "Windows" or
                  -- raw_os_name:match("linux$") and "Linux" or
                  -- raw_os_name:match("osx$") and "Mac" or
                  -- raw_os_name:match("mac") and "Mac" or
                  -- raw_os_name:match("darwin") and "Mac" or
                  -- raw_os_name:match("^mingw$") and "Windows" or
                  -- raw_os_name:match("^cygwin$") and "Windows" or
                  -- raw_os_name:match("bsd$") and "BSD" or
                  -- raw_os_name:match("sunos") and "Solaris" or
                  --------------------------------------------------------
                  "unknown"
  -- 測試 Windows 之 os.getenv("HOME") 為 nil，但網路資訊說明某些 Win 版本不為 nil？
  -- os.getenv("USERPROFILE")只在 Win 不為 nil。
  -- os.getenv()可能為 nil，不可直接「:sub()」或「lower()」，會報錯！
--------------------------------------------------------
--------------------------------------------------------

  return os_name
end


-- print(get_os_name_simple())
return get_os_name_simple