--- 如同  comment_format

local function convert_format(p1,p2,p3,p4) -- patern  支援utf8
  local config_list = ConfigList()
  for i ,v in next, {p1,p2,p3,p4} do
    config_list:append(ConfigValue(v).element)
  end
  local proj = Projection()
  return proj:load(config_list) and proj or nil  -- load ok return proj  ng return nil
end

return convert_format