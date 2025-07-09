--- 年

local function min_guo(mg)
  -- if mg == "" then return "" end
  -- local mg = tonumber(mg) - 1911
  local mg = tonumber(mg)
  if mg > 1911 then
    mg = mg - 1911
  elseif mg <= 1911 then
    -- mg = '前' .. 1912 - mg
    mg = 1912 - mg
  else
    mg = ""
  end
  return mg
end

local function jp_ymd(jpy, jpm, jpd)
  local jpa = tonumber(string.format("%02d", jpy) .. string.format("%02d", jpm) .. string.format("%02d", jpd))
  if jpa > 20190430 then
    ja = "令和" .. tostring( tonumber(jpy) - 2018 ) .. "年".. string.format("%02d", jpm) .. "月" .. string.format("%02d", jpd) .. "日"
    jy = "令和" .. tostring( tonumber(jpy) - 2018 ) .. "年"
  elseif 19890107 < jpa and jpa < 20190501 then
    ja = "平成" .. tostring( tonumber(jpy) - 1988 ) .. "年".. string.format("%02d", jpm) .. "月" .. string.format("%02d", jpd) .. "日"
    jy = "平成" .. tostring( tonumber(jpy) - 1988 ) .. "年"
  elseif 19261224 < jpa and jpa < 19890108 then
    ja = "昭和" .. tostring( tonumber(jpy) - 1925 ) .. "年".. string.format("%02d", jpm) .. "月" .. string.format("%02d", jpd) .. "日"
    jy = "昭和" .. tostring( tonumber(jpy) - 1925 ) .. "年"
  elseif 19120729 < jpa and jpa < 19261226 then
    ja = "大正" .. tostring( tonumber(jpy) - 1911 ) .. "年".. string.format("%02d", jpm) .. "月" .. string.format("%02d", jpd) .. "日"
    jy = "大正" .. tostring( tonumber(jpy) - 1911 ) .. "年"
  elseif 18681022 < jpa and jpa < 19120731 then
    ja = "明治" .. tostring( tonumber(jpy) - 1867 ) .. "年".. string.format("%02d", jpm) .. "月" .. string.format("%02d", jpd) .. "日"
    jy = "明治" .. tostring( tonumber(jpy) - 1867 ) .. "年"
  elseif 18681023 > jpa then
    ja = "明治前" .. string.format("%02d", jpm) .. "月" .. string.format("%02d", jpd) .. "日"
    jy = "明治前"
  else
    ja = ""
    jy = ""
  end
  return ja, jy
end

return { min_guo = min_guo, jp_ymd = jp_ymd }