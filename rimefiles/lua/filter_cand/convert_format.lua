--- 如同  comment_format

local function convert_format(...) -- patern  支援utf8
-- local function convert_format(p1, ...) -- patern  支援utf8
  local config_list = ConfigList()
  -- local format_set = {p1, ...}
  -- for i ,v in next, format_set do
  for i ,v in next, {...} do
    config_list:append(ConfigValue(v).element)
  end
  local proj = Projection()
  return proj:load(config_list) and proj or nil  -- load ok return proj  ng return nil
end

return convert_format