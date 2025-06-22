--- 獲得 os 系統名稱（簡化版）
--[[
（用當前用戶的家目錄路徑判斷 os。）
（用 os.getenv('OS') 和 uname 判斷 os。）
--]]


local function get_os_name_simple()

  -- local raw_os_name = ""
  -- if os.getenv('OS') then
  --   -- Windows
  --   raw_os_name = os.getenv('OS') or ""
  -- else
  --   -- other platform, assume uname support and popen support
  --   raw_os_name = io.popen('uname -s','r'):read('*l') or ""
  -- end

  -- local raw_os_name = (raw_os_name):lower()

  local os_name = os.getenv("USERPROFILE") and "Windows" or  -- os.getenv("USERPROFILE")只在 Win 不為 nil
                  os.getenv("HOME") and os.getenv("HOME"):sub(1,7) == "/Users/" and "Mac" or  -- os.getenv()可能為 nil，不可直接「:sub()」，會報錯！
                  os.getenv("HOME") and os.getenv("HOME"):sub(1,6) == "/home/" and "Linux" or  -- os.getenv()可能為 nil，不可直接「:sub()」，會報錯！
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
  -- 承上測試 Windows 之 os.getenv("HOME") 為 nil，但網路資訊說明某些 Win 版本不為 nil？

  return os_name -- or "unknown"
end


-- print(get_os_name_simple())
return get_os_name_simple