-- 時區
local function utc_timezone(unformated)
  local sign, hours, minutes = string.match(unformated, "(-?)(%d%d)(%d%d)")
  local fraction_hours = tonumber(hours) + tonumber(minutes) / 60
  if (sign == "") then
    sign = "+"
  end
  local timezone = sign .. tostring(fraction_hours)
  local timezone1 = "UTC" .. string.gsub(timezone, "%.?0+$", "")
  local timezone2 = sign .. hours .. ":" .. minutes
  local timezone3 = sign .. hours
  local timezone4 = "GMT" .. string.gsub(timezone, "%.?0+$", "")
  return timezone1, timezone2, timezone3, timezone4
end

local function timezone_out()
  local timezone, timezone_2, timezone_3, timezone_4 = utc_timezone(os.date("%z"))
  local timezone_discrpt = os.date("%Z")
  -- local candidate = Candidate("timezone", seg.start, seg._end, timezone, timezone_discrpt)
  return {timezone, timezone_discrpt, timezone_2, timezone_3, timezone_4}
end

return timezone_out