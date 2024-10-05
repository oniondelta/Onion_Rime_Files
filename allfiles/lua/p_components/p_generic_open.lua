--[[
開啟檔案/程式/網址
--]]

local function generic_open(dest)
  if os.execute('start "" ' .. dest) then
    return true
  elseif os.execute('open ' .. dest) then
    return true
  elseif os.execute('xdg-open ' .. dest) then
    return true
  end
end


return generic_open