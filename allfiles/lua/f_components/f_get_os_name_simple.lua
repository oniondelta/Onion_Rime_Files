--- 獲得 os 系統名稱（簡化版）


local function get_os_name_simple()
--------------------------------------------------------
-- 用 os.getenv('OS') 和 uname 判斷 os 系統名稱
--------------------------------------------------------

  -- local raw_os_name = ""
  -- if os.getenv("USERPROFILE") then
  --   -- Windows
  --   local env_OS = os.getenv('OS')
  --   if env_OS then
  --     raw_os_name = env_OS
  --   end
  -- else
  --   -- other platform, assume uname support and popen support
  --   raw_os_name = io.popen('uname -s','r'):read('*l') or ""
  -- end

  -- local raw_os_name = string.lower(raw_os_name)

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
  --   if string.match(raw_os_name, pattern) then
  --     os_name = name
  --     break
  --   end
  -- end

--------------------------------------------------------
-- 用當前用戶的家目錄路徑判斷 os 系統名稱
--------------------------------------------------------
  local os_name = os.getenv("USERPROFILE") and "Windows" or
                  os.getenv("HOME") and string.sub(os.getenv("HOME"), 1,7) == "/Users/" and "Mac" or
                  os.getenv("HOME") and string.sub(os.getenv("HOME"), 1,6) == "/home/" and "Linux" or
                  --------------------------------------------------------
                  -- string.match(raw_os_name, "windows$") and "Windows" or
                  -- string.match(raw_os_name, "linux$") and "Linux" or
                  -- string.match(raw_os_name, "osx$") and "Mac" or
                  -- string.match(raw_os_name, "mac") and "Mac" or
                  -- string.match(raw_os_name, "darwin") and "Mac" or
                  -- string.match(raw_os_name, "^mingw$") and "Windows" or
                  -- string.match(raw_os_name, "^cygwin$") and "Windows" or
                  -- string.match(raw_os_name, "bsd$") and "BSD" or
                  -- string.match(raw_os_name, "sunos") and "Solaris" or
                  --------------------------------------------------------
                  "unknown"
  -- 測試 Windows 之 os.getenv("HOME") 為 nil，但網路資訊說明某些 Win 版本不為 nil？
  -- os.getenv("USERPROFILE")只在 Win 不為 nil。
  -- os.getenv()可能為 nil，不可直接「sub()」或「lower()」，會報錯！
--------------------------------------------------------
--------------------------------------------------------

  return os_name
end


-- print(get_os_name_simple())
return get_os_name_simple