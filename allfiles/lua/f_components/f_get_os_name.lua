--- 獲得 os 系統名稱

local function get_os_name()

  local raw_os_name = ''
  if package.config:sub(1,1) == '\\' then
    -- Windows
    local env_OS = os.getenv('OS')
    if env_OS then
        raw_os_name = env_OS
    end
  else
    -- other platform, assume uname support and popen support
    raw_os_name = io.popen('uname -s','r'):read('*l')
  end

  local raw_os_name = (raw_os_name):lower()

  local os_patterns = {
      ['windows']     = 'Windows',
      ['linux']       = 'Linux',
      ['osx']         = 'Mac',
      ['mac']         = 'Mac',
      ['darwin']      = 'Mac',
      ['^mingw']      = 'Windows',
      ['^cygwin']     = 'Windows',
      ['bsd$']        = 'BSD',
      ['sunos']       = 'Solaris',
  }

  local os_name = 'unknown'
  for pattern, name in pairs(os_patterns) do
    if raw_os_name:match(pattern) then
        os_name = name
        break
    end
  end

  return os_name or '' -- os_name
end

-- print(get_os_name())
return get_os_name