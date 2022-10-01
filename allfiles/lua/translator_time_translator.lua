--[[
從 lunar_calendar 資料夾匯入兩個農曆相關函數集合
--]]
local lc_1 = require("lunar_calendar/lunar_calendar_1")
local Dec2bin = lc_1.Dec2bin
local Date2LunarDate = lc_1.Date2LunarDate
local LunarDate2Date = lc_1.LunarDate2Date
local GetNextJQ = lc_1.GetNextJQ
local GetNowTimeJq = lc_1.GetNowTimeJq
local lunarJzl = lc_1.lunarJzl


local lc_2 = require("lunar_calendar/lunar_calendar_2")
local time_description_chinese = lc_2.time_description_chinese
local Moonphase_out1 = lc_2.Moonphase_out1
local Moonphase_out2 = lc_2.Moonphase_out2
local jieqi_out1 = lc_2.jieqi_out1




----------------------------------------------------------------------------------------
--[[
檢查版本
--]]
local function Version()
  local ver
  if rime_api.get_distribution_name then
    return 185
  elseif LevelDb then
    return 177
  elseif Opencc then
    return 147
  elseif KeySequence and KeySequence().repr then
    return 139
  elseif  ConfigMap and ConfigMap().keys then
    return 127
  elseif Projection then
    return 102
  elseif KeyEvent then
    return 100
  elseif Memory then
    return 80
  elseif rime_api.get_user_data_dir then
    return 9
  elseif log then
    return 9
  else
    return 0
  end
end

local function Ver_info_frontend()
  return string.format("%s %s %s",
  rime_api.get_distribution_name(),
  rime_api.get_distribution_code_name(),
  rime_api.get_distribution_version())
end

local function Ver_info_librime()
  return string.format("librime %s",
  rime_api.get_rime_version())
end

local function Ver_info_lua()
  return string.format("librime-lua %s    %s",
  Version() ,_VERSION )
end

local function Ver_info_id()
  return string.format("%s", rime_api.get_user_id())
end




--[[
數字日期字母各種轉寫
--]]
-- 日期轉大寫1
local function rqzdx1(a)
--a=1(二〇一九年)、2(六月)、3(二十三日)、12(二〇一九年六月)、23(六月二十三日)、其它為(二〇一九年六月二十三日)
-- 二〇一九年六月二十三日
  local result = ""
  local number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" }
  local year0=os.date("%Y")
  for i= 0, 9 do
    year0= string.gsub(year0,i,number[i])
  end
  local monthnumber = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" , "十", "十一", "十二"}
  local month0=monthnumber[os.date("%m")*1]
  local daynumber = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一" }
  local day0=daynumber[os.date("%d")*1]
  if a == 1 then
    result = year0.."年"
  elseif a == 2 then
    result = month0.."月"
  elseif a == 3 then
    result = day0.."日"
  elseif a == 12 then
    result = year0.."年"..month0.."月"
  elseif a == 23 then
    result = month0.."月"..day0.."日"
  else
    result = year0.."年"..month0.."月"..day0.."日"
  end
  return result;
end

-- 日期轉大寫2
local function rqzdx2(a)
-- 貳零零玖年零陸月貳拾參日
--a=1(貳零壹玖年)、2(零陸月)、3(貳拾參日)、12(貳零壹玖年零陸月)、23(零陸月貳拾參日)、其它為(貳零壹玖年零陸月貳拾參日)
  local result = ""
  local number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾" }
  local year0=os.date("%Y")
  for i= 0, 9 do
    year0= string.gsub(year0,i,number[i])
  end
-- for i= 1, 4 do
   -- year0=  string.gsub(year0,string.sub(year0,i,1),number[string.sub(year0,i,1)*1])
-- end
  local monthnumber = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳" }
  -- local monthnumber = { [0] = "零", "零壹", "零貳", "零參", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳" }
  local month0=monthnumber[os.date("%m")*1]
  -- local daynumber = { [0] = "零", "零壹", "零貳", "零參", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳", "壹拾參", "壹拾肆", "壹拾伍", "壹拾陸", "壹拾柒", "壹拾捌", "壹拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹" }
  local daynumber = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳", "拾參", "拾肆", "拾伍", "拾陸", "拾柒", "拾捌", "拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹" }
  local day0=daynumber[os.date("%d")*1]
  if a == 1 then
    result = year0.."年"
  elseif a == 2 then
    result = month0.."月"
  elseif a == 3 then
    result = day0.."日"
  elseif a == 12 then
    result = year0.."年"..month0.."月"
  elseif a == 23 then
    result = month0.."月"..day0.."日"
  else
    result = year0.."年"..month0.."月"..day0.."日"
  end
  return result;
end

--[[
以下日期數字轉寫函數
--]]
local function ch_y_date(a)
  if a == "" then return "" end
  local year_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" }
  for i= 0, 9 do
    a= string.gsub(a,i,year_number[i])
  end
  return a
end

local function ch_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" , "十", "十一", "十二"}
  local a=month_number[a*1]
  return a
end

local function ch_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一" }
  local a=day_number[a*1]
  return a
end

local function ch_h_date(a)
  if a == "" then return "" end
  local hour_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四" }
  local a=hour_number[a*1]
  return a
end

local function ch_minsec_date(a)
  if a == "" then return "" end
  local minsec_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一", "三十二", "三十三", "三十四", "三十五", "三十六", "三十七", "三十八", "三十九", "四十", "四十一", "四十二", "四十三", "四十四", "四十五", "四十六", "四十七", "四十八", "四十九", "五十", "五十一", "五十二", "五十三", "五十四", "五十五", "五十六", "五十七", "五十八", "五十九", "六十" }
  local a=minsec_number[a*1]
  return a
end

local function chb_y_date(a)
  if a == "" then return "" end
  local year_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾" }
  for i= 0, 9 do
    a= string.gsub(a,i,year_number[i])
  end
  return a
end

local function chb_m_date(a)
  if a == "" then return "" end
  -- local month_number = { [0] = "零", "零壹", "零貳", "零參", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳" }
  local month_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳" }
  local a=month_number[a*1]
  return a
end

local function chb_d_date(a)
  if a == "" then return "" end
  -- local day_number = { [0] = "零", "零壹", "零貳", "零參", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳", "壹拾參", "壹拾肆", "壹拾伍", "壹拾陸", "壹拾柒", "壹拾捌", "壹拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹" }
  local day_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳", "拾參", "拾肆", "拾伍", "拾陸", "拾柒", "拾捌", "拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹" }
  local a=day_number[a*1]
  return a
end

local function chb_h_date(a)
  if a == "" then return "" end
  local hour_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳", "拾參", "拾肆", "拾伍", "拾陸", "拾柒", "拾捌", "拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆" }
  local a=hour_number[a*1]
  return a
end

local function chb_minsec_date(a)
  if a == "" then return "" end
  local minsec_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳", "拾參", "拾肆", "拾伍", "拾陸", "拾柒", "拾捌", "拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹", "參拾貳", "參拾參", "參拾肆", "參拾伍", "參拾陸", "參拾柒", "參拾捌", "參拾玖", "肆拾", "肆拾壹", "肆拾貳", "肆拾參", "肆拾肆", "肆拾伍", "肆拾陸", "肆拾柒", "肆拾捌", "肆拾玖", "伍拾", "伍拾壹", "伍拾貳", "伍拾參", "伍拾肆", "伍拾伍", "伍拾陸", "伍拾柒", "伍拾捌", "伍拾玖", "陸拾" }
  local a=minsec_number[a*1]
  return a
end

local function jp_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "0月", "㋀", "㋁", "㋂", "㋃", "㋄", "㋅", "㋆", "㋇", "㋈", "㋉", "㋊", "㋋" }
  local a=month_number[a*1]
  return a
end

local function jp_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "0日", "㏠", "㏡", "㏢", "㏣", "㏤", "㏥", "㏦", "㏧", "㏨", "㏩", "㏪", "㏫", "㏬", "㏭", "㏮", "㏯", "㏰", "㏱", "㏲", "㏳", "㏴", "㏵", "㏶", "㏷", "㏸", "㏹", "㏺", "㏻", "㏼", "㏽", "㏾" }
  local a=day_number[a*1]
  return a
end

local function eng1_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "〇", "January", "February", "March", "April", "May", "June", "July", "August", "Septemper", "October", "November", "December" }
  local a=month_number[a*1]
  return a
end

local function eng2_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "〇", "Jan.", "Feb.", "Mar.", "Apr.", "May.", "Jun.", "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec." }
  local a=month_number[a*1]
  return a
end

local function eng3_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "〇", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }
  local a=month_number[a*1]
  return a
end

local function eng1_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "zero", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "egihteenth", "nineteenth", "twentieth", "twenty-first", "twenty-second", "twenty-third", "twenty-fouth", "twenty-fifth", "twenty-sixth", "twenty-seventh", "twenty-eighth", "twenty-ninth", "thirtieth", "thirty-first" }
  local a=day_number[a*1]
  return a
end

local function eng2_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "0", "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th", "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st" }
  local a=day_number[a*1]
  return a
end

local function eng3_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31" }
  local a=day_number[a*1]
  return a
end

local function eng4_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "0", "1ˢᵗ", "2ⁿᵈ", "3ʳᵈ", "4ᵗʰ", "5ᵗʰ", "6ᵗʰ", "7ᵗʰ", "8ᵗʰ", "9ᵗʰ", "10ᵗʰ", "11ᵗʰ", "12ᵗʰ", "13ᵗʰ", "14ᵗʰ", "15ᵗʰ", "16ᵗʰ", "17ᵗʰ", "18ᵗʰ", "19ᵗʰ", "20ᵗʰ", "21ˢᵗ", "22ⁿᵈ", "23ʳᵈ", "24ᵗʰ", "25ᵗʰ", "26ᵗʰ", "27ᵗʰ", "28ᵗʰ", "29ᵗʰ", "30ᵗʰ", "31ˢᵗ" }
  local a=day_number[a*1]
  return a
end




--[[
number_translator: 將 `'/` + 阿拉伯數字 和 英文字母 各種轉譯
--]]
local function formatnumberthousands(n3)
  local r3 = string.sub(n3, -3, -1)  -- 從後向前取三位
  local n3 = string.sub(n3, 1, -4)  -- 剩下的數字
  -- 每次循環從後向前取三位，拼接到結果前面
  -- 直到剩下數字為空
  while string.len(n3) > 0 do
    r3 = string.sub(n3, -3, -1) .. "," .. r3
    n3 = string.sub(n3, 1, -4)
  end
  -- 返回結果
  return r3
end

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

local function fullshape_number(fs)
  if fs == "" then return "" end
  fs = string.gsub(fs, "0", "０")
  fs = string.gsub(fs, "1", "１")
  fs = string.gsub(fs, "2", "２")
  fs = string.gsub(fs, "3", "３")
  fs = string.gsub(fs, "4", "４")
  fs = string.gsub(fs, "5", "５")
  fs = string.gsub(fs, "6", "６")
  fs = string.gsub(fs, "7", "７")
  fs = string.gsub(fs, "8", "８")
  fs = string.gsub(fs, "9", "９")
  return fs
end

local function math1_number(m1)
  if m1 == "" then return "" end
  m1 = string.gsub(m1, "0", "𝟎")
  m1 = string.gsub(m1, "1", "𝟏")
  m1 = string.gsub(m1, "2", "𝟐")
  m1 = string.gsub(m1, "3", "𝟑")
  m1 = string.gsub(m1, "4", "𝟒")
  m1 = string.gsub(m1, "5", "𝟓")
  m1 = string.gsub(m1, "6", "𝟔")
  m1 = string.gsub(m1, "7", "𝟕")
  m1 = string.gsub(m1, "8", "𝟖")
  m1 = string.gsub(m1, "9", "𝟗")
  return m1
end

local function math2_number(m2)
  if m2 == "" then return "" end
  m2 = string.gsub(m2, "0", "𝟘")
  m2 = string.gsub(m2, "1", "𝟙")
  m2 = string.gsub(m2, "2", "𝟚")
  m2 = string.gsub(m2, "3", "𝟛")
  m2 = string.gsub(m2, "4", "𝟜")
  m2 = string.gsub(m2, "5", "𝟝")
  m2 = string.gsub(m2, "6", "𝟞")
  m2 = string.gsub(m2, "7", "𝟟")
  m2 = string.gsub(m2, "8", "𝟠")
  m2 = string.gsub(m2, "9", "𝟡")
  return m2
end

local function circled1_number(c1)
  if c1 == "" then return "" end
  c1 = string.gsub(c1, "0", "⓪")
  c1 = string.gsub(c1, "1", "①")
  c1 = string.gsub(c1, "2", "②")
  c1 = string.gsub(c1, "3", "③")
  c1 = string.gsub(c1, "4", "④")
  c1 = string.gsub(c1, "5", "⑤")
  c1 = string.gsub(c1, "6", "⑥")
  c1 = string.gsub(c1, "7", "⑦")
  c1 = string.gsub(c1, "8", "⑧")
  c1 = string.gsub(c1, "9", "⑨")
  return c1
end

local function circled2_number(c2)
  if c2 == "" then return "" end
  c2 = string.gsub(c2, "0", "🄋")
  c2 = string.gsub(c2, "1", "➀")
  c2 = string.gsub(c2, "2", "➁")
  c2 = string.gsub(c2, "3", "➂")
  c2 = string.gsub(c2, "4", "➃")
  c2 = string.gsub(c2, "5", "➄")
  c2 = string.gsub(c2, "6", "➅")
  c2 = string.gsub(c2, "7", "➆")
  c2 = string.gsub(c2, "8", "➇")
  c2 = string.gsub(c2, "9", "➈")
  return c2
end

local function circled3_number(c3)
  if c3 == "" then return "" end
  c3 = string.gsub(c3, "0", "⓿")
  c3 = string.gsub(c3, "1", "❶")
  c3 = string.gsub(c3, "2", "❷")
  c3 = string.gsub(c3, "3", "❸")
  c3 = string.gsub(c3, "4", "❹")
  c3 = string.gsub(c3, "5", "❺")
  c3 = string.gsub(c3, "6", "❻")
  c3 = string.gsub(c3, "7", "❼")
  c3 = string.gsub(c3, "8", "❽")
  c3 = string.gsub(c3, "9", "❾")
  return c3
end

local function circled4_number(c4)
  if c4 == "" then return "" end
  c4 = string.gsub(c4, "0", "🄌")
  c4 = string.gsub(c4, "1", "➊")
  c4 = string.gsub(c4, "2", "➋")
  c4 = string.gsub(c4, "3", "➌")
  c4 = string.gsub(c4, "4", "➍")
  c4 = string.gsub(c4, "5", "➎")
  c4 = string.gsub(c4, "6", "➏")
  c4 = string.gsub(c4, "7", "➐")
  c4 = string.gsub(c4, "8", "➑")
  c4 = string.gsub(c4, "9", "➒")
  return c4
end

local function circled5_number(c5)
  if c5 == "" then return "" end
  c5 = string.gsub(c5, "0", "Ⓞ")
  c5 = string.gsub(c5, "1", "㊀")
  c5 = string.gsub(c5, "2", "㊁")
  c5 = string.gsub(c5, "3", "㊂")
  c5 = string.gsub(c5, "4", "㊃")
  c5 = string.gsub(c5, "5", "㊄")
  c5 = string.gsub(c5, "6", "㊅")
  c5 = string.gsub(c5, "7", "㊆")
  c5 = string.gsub(c5, "8", "㊇")
  c5 = string.gsub(c5, "9", "㊈")
  return c5
end

local function purech_number(ch)
  if ch == "" then return "" end
  ch = string.gsub(ch, "0", "〇")
  ch = string.gsub(ch, "1", "一")
  ch = string.gsub(ch, "2", "二")
  ch = string.gsub(ch, "3", "三")
  ch = string.gsub(ch, "4", "四")
  ch = string.gsub(ch, "5", "五")
  ch = string.gsub(ch, "6", "六")
  ch = string.gsub(ch, "7", "七")
  ch = string.gsub(ch, "8", "八")
  ch = string.gsub(ch, "9", "九")
  return ch
end

local function military_number(jn)
  if jn == "" then return "" end
  jn = string.gsub(jn, "0", "洞")
  jn = string.gsub(jn, "1", "么")
  jn = string.gsub(jn, "2", "兩")
  jn = string.gsub(jn, "3", "三")
  jn = string.gsub(jn, "4", "四")
  jn = string.gsub(jn, "5", "五")
  jn = string.gsub(jn, "6", "六")
  jn = string.gsub(jn, "7", "拐")
  jn = string.gsub(jn, "8", "八")
  jn = string.gsub(jn, "9", "勾")
  jn = string.gsub(jn, "%.", "點")
  return jn
end

local function little1_number(l1)
  if l1 == "" then return "" end
  l1 = string.gsub(l1, "0", "⁰")
  l1 = string.gsub(l1, "1", "¹")
  l1 = string.gsub(l1, "2", "²")
  l1 = string.gsub(l1, "3", "³")
  l1 = string.gsub(l1, "4", "⁴")
  l1 = string.gsub(l1, "5", "⁵")
  l1 = string.gsub(l1, "6", "⁶")
  l1 = string.gsub(l1, "7", "⁷")
  l1 = string.gsub(l1, "8", "⁸")
  l1 = string.gsub(l1, "9", "⁹")
  return l1
end

local function little2_number(l2)
  if l2 == "" then return "" end
  l2 = string.gsub(l2, "0", "₀")
  l2 = string.gsub(l2, "1", "₁")
  l2 = string.gsub(l2, "2", "₂")
  l2 = string.gsub(l2, "3", "₃")
  l2 = string.gsub(l2, "4", "₄")
  l2 = string.gsub(l2, "5", "₅")
  l2 = string.gsub(l2, "6", "₆")
  l2 = string.gsub(l2, "7", "₇")
  l2 = string.gsub(l2, "8", "₈")
  l2 = string.gsub(l2, "9", "₉")
  return l2
end

local function english_1(en1)
  if en1 == "" then return "" end
  en1 = string.gsub(en1, "a", "𝔸")
  en1 = string.gsub(en1, "b", "𝔹")
  en1 = string.gsub(en1, "c", "ℂ")
  en1 = string.gsub(en1, "d", "𝔻")
  en1 = string.gsub(en1, "e", "𝔼")
  en1 = string.gsub(en1, "f", "𝔽")
  en1 = string.gsub(en1, "g", "𝔾")
  en1 = string.gsub(en1, "h", "ℍ")
  en1 = string.gsub(en1, "i", "𝕀")
  en1 = string.gsub(en1, "j", "𝕁")
  en1 = string.gsub(en1, "k", "𝕂")
  en1 = string.gsub(en1, "l", "𝕃")
  en1 = string.gsub(en1, "m", "𝕄")
  en1 = string.gsub(en1, "n", "ℕ")
  en1 = string.gsub(en1, "o", "𝕆")
  en1 = string.gsub(en1, "p", "ℙ")
  en1 = string.gsub(en1, "q", "ℚ")
  en1 = string.gsub(en1, "r", "ℝ")
  en1 = string.gsub(en1, "s", "𝕊")
  en1 = string.gsub(en1, "t", "𝕋")
  en1 = string.gsub(en1, "u", "𝕌")
  en1 = string.gsub(en1, "v", "𝕍")
  en1 = string.gsub(en1, "w", "𝕎")
  en1 = string.gsub(en1, "x", "𝕏")
  en1 = string.gsub(en1, "y", "𝕐")
  en1 = string.gsub(en1, "z", "ℤ")
  return en1
end

local function english_2(en2)
  if en2 == "" then return "" end
  en2 = string.gsub(en2, "a", "𝕒")
  en2 = string.gsub(en2, "b", "𝕓")
  en2 = string.gsub(en2, "c", "𝕔")
  en2 = string.gsub(en2, "d", "𝕕")
  en2 = string.gsub(en2, "e", "𝕖")
  en2 = string.gsub(en2, "f", "𝕗")
  en2 = string.gsub(en2, "g", "𝕘")
  en2 = string.gsub(en2, "h", "𝕙")
  en2 = string.gsub(en2, "i", "𝕚")
  en2 = string.gsub(en2, "j", "𝕛")
  en2 = string.gsub(en2, "k", "𝕜")
  en2 = string.gsub(en2, "l", "𝕝")
  en2 = string.gsub(en2, "m", "𝕞")
  en2 = string.gsub(en2, "n", "𝕟")
  en2 = string.gsub(en2, "o", "𝕠")
  en2 = string.gsub(en2, "p", "𝕡")
  en2 = string.gsub(en2, "q", "𝕢")
  en2 = string.gsub(en2, "r", "𝕣")
  en2 = string.gsub(en2, "s", "𝕤")
  en2 = string.gsub(en2, "t", "𝕥")
  en2 = string.gsub(en2, "u", "𝕦")
  en2 = string.gsub(en2, "v", "𝕧")
  en2 = string.gsub(en2, "w", "𝕨")
  en2 = string.gsub(en2, "x", "𝕩")
  en2 = string.gsub(en2, "y", "𝕪")
  en2 = string.gsub(en2, "z", "𝕫")
  return en2
end

local function english_3(en3)
  if en3 == "" then return "" end
  en3 = string.gsub(en3, "a", "Ⓐ")
  en3 = string.gsub(en3, "b", "Ⓑ")
  en3 = string.gsub(en3, "c", "Ⓒ")
  en3 = string.gsub(en3, "d", "Ⓓ")
  en3 = string.gsub(en3, "e", "Ⓔ")
  en3 = string.gsub(en3, "f", "Ⓕ")
  en3 = string.gsub(en3, "g", "Ⓖ")
  en3 = string.gsub(en3, "h", "Ⓗ")
  en3 = string.gsub(en3, "i", "Ⓘ")
  en3 = string.gsub(en3, "j", "Ⓙ")
  en3 = string.gsub(en3, "k", "Ⓚ")
  en3 = string.gsub(en3, "l", "Ⓛ")
  en3 = string.gsub(en3, "m", "Ⓜ")
  en3 = string.gsub(en3, "n", "Ⓝ")
  en3 = string.gsub(en3, "o", "Ⓞ")
  en3 = string.gsub(en3, "p", "Ⓟ")
  en3 = string.gsub(en3, "q", "Ⓠ")
  en3 = string.gsub(en3, "r", "Ⓡ")
  en3 = string.gsub(en3, "s", "Ⓢ")
  en3 = string.gsub(en3, "t", "Ⓣ")
  en3 = string.gsub(en3, "u", "Ⓤ")
  en3 = string.gsub(en3, "v", "Ⓥ")
  en3 = string.gsub(en3, "w", "Ⓦ")
  en3 = string.gsub(en3, "x", "Ⓧ")
  en3 = string.gsub(en3, "y", "Ⓨ")
  en3 = string.gsub(en3, "z", "Ⓩ")
  return en3
end

local function english_4(en4)
  if en4 == "" then return "" end
  en4 = string.gsub(en4, "a", "ⓐ")
  en4 = string.gsub(en4, "b", "ⓑ")
  en4 = string.gsub(en4, "c", "ⓒ")
  en4 = string.gsub(en4, "d", "ⓓ")
  en4 = string.gsub(en4, "e", "ⓔ")
  en4 = string.gsub(en4, "f", "ⓕ")
  en4 = string.gsub(en4, "g", "ⓖ")
  en4 = string.gsub(en4, "h", "ⓗ")
  en4 = string.gsub(en4, "i", "ⓘ")
  en4 = string.gsub(en4, "j", "ⓙ")
  en4 = string.gsub(en4, "k", "ⓚ")
  en4 = string.gsub(en4, "l", "ⓛ")
  en4 = string.gsub(en4, "m", "ⓜ")
  en4 = string.gsub(en4, "n", "ⓝ")
  en4 = string.gsub(en4, "o", "ⓞ")
  en4 = string.gsub(en4, "p", "ⓟ")
  en4 = string.gsub(en4, "q", "ⓠ")
  en4 = string.gsub(en4, "r", "ⓡ")
  en4 = string.gsub(en4, "s", "ⓢ")
  en4 = string.gsub(en4, "t", "ⓣ")
  en4 = string.gsub(en4, "u", "ⓤ")
  en4 = string.gsub(en4, "v", "ⓥ")
  en4 = string.gsub(en4, "w", "ⓦ")
  en4 = string.gsub(en4, "x", "ⓧ")
  en4 = string.gsub(en4, "y", "ⓨ")
  en4 = string.gsub(en4, "z", "ⓩ")
  return en4
end

local function english_5(en5)
  if en5 == "" then return "" end
  en5 = string.gsub(en5, "a", "🄐")
  en5 = string.gsub(en5, "b", "🄑")
  en5 = string.gsub(en5, "c", "🄒")
  en5 = string.gsub(en5, "d", "🄓")
  en5 = string.gsub(en5, "e", "🄔")
  en5 = string.gsub(en5, "f", "🄕")
  en5 = string.gsub(en5, "g", "🄖")
  en5 = string.gsub(en5, "h", "🄗")
  en5 = string.gsub(en5, "i", "🄘")
  en5 = string.gsub(en5, "j", "🄙")
  en5 = string.gsub(en5, "k", "🄚")
  en5 = string.gsub(en5, "l", "🄛")
  en5 = string.gsub(en5, "m", "🄜")
  en5 = string.gsub(en5, "n", "🄝")
  en5 = string.gsub(en5, "o", "🄞")
  en5 = string.gsub(en5, "p", "🄟")
  en5 = string.gsub(en5, "q", "🄠")
  en5 = string.gsub(en5, "r", "🄡")
  en5 = string.gsub(en5, "s", "🄢")
  en5 = string.gsub(en5, "t", "🄣")
  en5 = string.gsub(en5, "u", "🄤")
  en5 = string.gsub(en5, "v", "🄥")
  en5 = string.gsub(en5, "w", "🄦")
  en5 = string.gsub(en5, "x", "🄧")
  en5 = string.gsub(en5, "y", "🄨")
  en5 = string.gsub(en5, "z", "🄩")
  return en5
end

local function english_6(en6)
  if en6 == "" then return "" end
  en6 = string.gsub(en6, "a", "⒜")
  en6 = string.gsub(en6, "b", "⒝")
  en6 = string.gsub(en6, "c", "⒞")
  en6 = string.gsub(en6, "d", "⒟")
  en6 = string.gsub(en6, "e", "⒠")
  en6 = string.gsub(en6, "f", "⒡")
  en6 = string.gsub(en6, "g", "⒢")
  en6 = string.gsub(en6, "h", "⒣")
  en6 = string.gsub(en6, "i", "⒤")
  en6 = string.gsub(en6, "j", "⒥")
  en6 = string.gsub(en6, "k", "⒦")
  en6 = string.gsub(en6, "l", "⒧")
  en6 = string.gsub(en6, "m", "⒨")
  en6 = string.gsub(en6, "n", "⒩")
  en6 = string.gsub(en6, "o", "⒪")
  en6 = string.gsub(en6, "p", "⒫")
  en6 = string.gsub(en6, "q", "⒬")
  en6 = string.gsub(en6, "r", "⒭")
  en6 = string.gsub(en6, "s", "⒮")
  en6 = string.gsub(en6, "t", "⒯")
  en6 = string.gsub(en6, "u", "⒰")
  en6 = string.gsub(en6, "v", "⒱")
  en6 = string.gsub(en6, "w", "⒲")
  en6 = string.gsub(en6, "x", "⒳")
  en6 = string.gsub(en6, "y", "⒴")
  en6 = string.gsub(en6, "z", "⒵")
  return en6
end

local function english_7(en7)
  if en7 == "" then return "" end
  en7 = string.gsub(en7, "a", "🄰")
  en7 = string.gsub(en7, "b", "🄱")
  en7 = string.gsub(en7, "c", "🄲")
  en7 = string.gsub(en7, "d", "🄳")
  en7 = string.gsub(en7, "e", "🄴")
  en7 = string.gsub(en7, "f", "🄵")
  en7 = string.gsub(en7, "g", "🄶")
  en7 = string.gsub(en7, "h", "🄷")
  en7 = string.gsub(en7, "i", "🄸")
  en7 = string.gsub(en7, "j", "🄹")
  en7 = string.gsub(en7, "k", "🄺")
  en7 = string.gsub(en7, "l", "🄻")
  en7 = string.gsub(en7, "m", "🄼")
  en7 = string.gsub(en7, "n", "🄽")
  en7 = string.gsub(en7, "o", "🄾")
  en7 = string.gsub(en7, "p", "🄿")
  en7 = string.gsub(en7, "q", "🅀")
  en7 = string.gsub(en7, "r", "🅁")
  en7 = string.gsub(en7, "s", "🅂")
  en7 = string.gsub(en7, "t", "🅃")
  en7 = string.gsub(en7, "u", "🅄")
  en7 = string.gsub(en7, "v", "🅅")
  en7 = string.gsub(en7, "w", "🅆")
  en7 = string.gsub(en7, "x", "🅇")
  en7 = string.gsub(en7, "y", "🅈")
  en7 = string.gsub(en7, "z", "🅉")
  return en7
end

local function english_8(en8)
  if en8 == "" then return "" end
  en8 = string.gsub(en8, "a", "🅐")
  en8 = string.gsub(en8, "b", "🅑")
  en8 = string.gsub(en8, "c", "🅒")
  en8 = string.gsub(en8, "d", "🅓")
  en8 = string.gsub(en8, "e", "🅔")
  en8 = string.gsub(en8, "f", "🅕")
  en8 = string.gsub(en8, "g", "🅖")
  en8 = string.gsub(en8, "h", "🅗")
  en8 = string.gsub(en8, "i", "🅘")
  en8 = string.gsub(en8, "j", "🅙")
  en8 = string.gsub(en8, "k", "🅚")
  en8 = string.gsub(en8, "l", "🅛")
  en8 = string.gsub(en8, "m", "🅜")
  en8 = string.gsub(en8, "n", "🅝")
  en8 = string.gsub(en8, "o", "🅞")
  en8 = string.gsub(en8, "p", "🅟")
  en8 = string.gsub(en8, "q", "🅠")
  en8 = string.gsub(en8, "r", "🅡")
  en8 = string.gsub(en8, "s", "🅢")
  en8 = string.gsub(en8, "t", "🅣")
  en8 = string.gsub(en8, "u", "🅤")
  en8 = string.gsub(en8, "v", "🅥")
  en8 = string.gsub(en8, "w", "🅦")
  en8 = string.gsub(en8, "x", "🅧")
  en8 = string.gsub(en8, "y", "🅨")
  en8 = string.gsub(en8, "z", "🅩")
  return en8
end

local function english_9(en9)
  if en9 == "" then return "" end
  en9 = string.gsub(en9, "a", "🅰")
  en9 = string.gsub(en9, "b", "🅱")
  en9 = string.gsub(en9, "c", "🅲")
  en9 = string.gsub(en9, "d", "🅳")
  en9 = string.gsub(en9, "e", "🅴")
  en9 = string.gsub(en9, "f", "🅵")
  en9 = string.gsub(en9, "g", "🅶")
  en9 = string.gsub(en9, "h", "🅷")
  en9 = string.gsub(en9, "i", "🅸")
  en9 = string.gsub(en9, "j", "🅹")
  en9 = string.gsub(en9, "k", "🅺")
  en9 = string.gsub(en9, "l", "🅻")
  en9 = string.gsub(en9, "m", "🅼")
  en9 = string.gsub(en9, "n", "🅽")
  en9 = string.gsub(en9, "o", "🅾")
  en9 = string.gsub(en9, "p", "🅿")
  en9 = string.gsub(en9, "q", "🆀")
  en9 = string.gsub(en9, "r", "🆁")
  en9 = string.gsub(en9, "s", "🆂")
  en9 = string.gsub(en9, "t", "🆃")
  en9 = string.gsub(en9, "u", "🆄")
  en9 = string.gsub(en9, "v", "🆅")
  en9 = string.gsub(en9, "w", "🆆")
  en9 = string.gsub(en9, "x", "🆇")
  en9 = string.gsub(en9, "y", "🆈")
  en9 = string.gsub(en9, "z", "🆉")
  return en9
end

local function english_f_u(en_f_u)
  if en_f_u == "" then return "" end
  en_f_u = string.gsub(en_f_u, "a", "Ａ")
  en_f_u = string.gsub(en_f_u, "b", "Ｂ")
  en_f_u = string.gsub(en_f_u, "c", "Ｃ")
  en_f_u = string.gsub(en_f_u, "d", "Ｄ")
  en_f_u = string.gsub(en_f_u, "e", "Ｅ")
  en_f_u = string.gsub(en_f_u, "f", "Ｆ")
  en_f_u = string.gsub(en_f_u, "g", "Ｇ")
  en_f_u = string.gsub(en_f_u, "h", "Ｈ")
  en_f_u = string.gsub(en_f_u, "i", "Ｉ")
  en_f_u = string.gsub(en_f_u, "j", "Ｊ")
  en_f_u = string.gsub(en_f_u, "k", "Ｋ")
  en_f_u = string.gsub(en_f_u, "l", "Ｌ")
  en_f_u = string.gsub(en_f_u, "m", "Ｍ")
  en_f_u = string.gsub(en_f_u, "n", "Ｎ")
  en_f_u = string.gsub(en_f_u, "o", "Ｏ")
  en_f_u = string.gsub(en_f_u, "p", "Ｐ")
  en_f_u = string.gsub(en_f_u, "q", "Ｑ")
  en_f_u = string.gsub(en_f_u, "r", "Ｒ")
  en_f_u = string.gsub(en_f_u, "s", "Ｓ")
  en_f_u = string.gsub(en_f_u, "t", "Ｔ")
  en_f_u = string.gsub(en_f_u, "u", "Ｕ")
  en_f_u = string.gsub(en_f_u, "v", "Ｖ")
  en_f_u = string.gsub(en_f_u, "w", "Ｗ")
  en_f_u = string.gsub(en_f_u, "x", "Ｘ")
  en_f_u = string.gsub(en_f_u, "y", "Ｙ")
  en_f_u = string.gsub(en_f_u, "z", "Ｚ")
  return en_f_u
end

local function english_f_l(en_f_l)
  if en_f_l == "" then return "" end
  en_f_l = string.gsub(en_f_l, "a", "ａ")
  en_f_l = string.gsub(en_f_l, "b", "ｂ")
  en_f_l = string.gsub(en_f_l, "c", "ｃ")
  en_f_l = string.gsub(en_f_l, "d", "ｄ")
  en_f_l = string.gsub(en_f_l, "e", "ｅ")
  en_f_l = string.gsub(en_f_l, "f", "ｆ")
  en_f_l = string.gsub(en_f_l, "g", "ｇ")
  en_f_l = string.gsub(en_f_l, "h", "ｈ")
  en_f_l = string.gsub(en_f_l, "i", "ｉ")
  en_f_l = string.gsub(en_f_l, "j", "ｊ")
  en_f_l = string.gsub(en_f_l, "k", "ｋ")
  en_f_l = string.gsub(en_f_l, "l", "ｌ")
  en_f_l = string.gsub(en_f_l, "m", "ｍ")
  en_f_l = string.gsub(en_f_l, "n", "ｎ")
  en_f_l = string.gsub(en_f_l, "o", "ｏ")
  en_f_l = string.gsub(en_f_l, "p", "ｐ")
  en_f_l = string.gsub(en_f_l, "q", "ｑ")
  en_f_l = string.gsub(en_f_l, "r", "ｒ")
  en_f_l = string.gsub(en_f_l, "s", "ｓ")
  en_f_l = string.gsub(en_f_l, "t", "ｔ")
  en_f_l = string.gsub(en_f_l, "u", "ｕ")
  en_f_l = string.gsub(en_f_l, "v", "ｖ")
  en_f_l = string.gsub(en_f_l, "w", "ｗ")
  en_f_l = string.gsub(en_f_l, "x", "ｘ")
  en_f_l = string.gsub(en_f_l, "y", "ｙ")
  en_f_l = string.gsub(en_f_l, "z", "ｚ")
  return en_f_l
end

local function english_s_u(en_s_u)
  if en_s_u == "" then return "" end
  en_s_u = string.gsub(en_s_u, "a", "ᴀ")
  en_s_u = string.gsub(en_s_u, "b", "ʙ")
  en_s_u = string.gsub(en_s_u, "c", "ᴄ")
  en_s_u = string.gsub(en_s_u, "d", "ᴅ")
  en_s_u = string.gsub(en_s_u, "e", "ᴇ")
  en_s_u = string.gsub(en_s_u, "f", "ꜰ")
  en_s_u = string.gsub(en_s_u, "g", "ɢ")
  en_s_u = string.gsub(en_s_u, "h", "ʜ")
  en_s_u = string.gsub(en_s_u, "i", "ɪ")
  en_s_u = string.gsub(en_s_u, "j", "ᴊ")
  en_s_u = string.gsub(en_s_u, "k", "ᴋ")
  en_s_u = string.gsub(en_s_u, "l", "ʟ")
  en_s_u = string.gsub(en_s_u, "m", "ᴍ")
  en_s_u = string.gsub(en_s_u, "n", "ɴ")
  en_s_u = string.gsub(en_s_u, "o", "ᴏ")
  en_s_u = string.gsub(en_s_u, "p", "ᴘ")
  en_s_u = string.gsub(en_s_u, "q", "ǫ")
  en_s_u = string.gsub(en_s_u, "r", "ʀ")
  en_s_u = string.gsub(en_s_u, "s", "s")
  en_s_u = string.gsub(en_s_u, "t", "ᴛ")
  en_s_u = string.gsub(en_s_u, "u", "ᴜ")
  en_s_u = string.gsub(en_s_u, "v", "ᴠ")
  en_s_u = string.gsub(en_s_u, "w", "ᴡ")
  en_s_u = string.gsub(en_s_u, "x", "x")
  en_s_u = string.gsub(en_s_u, "y", "ʏ")
  en_s_u = string.gsub(en_s_u, "z", "ᴢ")
  return en_s_u
end

local function english_1_2(en_1_2)
  if en_1_2 == "" then return "" end
  en_1_2 = english_1(string.sub(en_1_2,1,1)) .. english_2(string.sub(en_1_2,2,-1))
  return en_1_2
end

local function english_3_4(en_3_4)
  if en_3_4 == "" then return "" end
  en_3_4 = english_3(string.sub(en_3_4,1,1)) .. english_4(string.sub(en_3_4,2,-1))
  return en_3_4
end

local function english_5_6(en_5_6)
  if en_5_6 == "" then return "" end
  en_5_6 = english_5(string.sub(en_5_6,1,1)) .. english_6(string.sub(en_5_6,2,-1))
  return en_5_6
end

local function english_f_ul(en_ul)
  if en_ul == "" then return "" end
  en_ul = english_f_u(string.sub(en_ul,1,1)) .. english_f_l(string.sub(en_ul,2,-1))
  return en_ul
end

--[[
number_translator: 將 `'/` + 阿拉伯數字 翻譯為大小寫漢字
--]]
local confs = {
  {
    comment = "〔小寫中文數字〕",
    number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" },
    suffix1 = { [0] = "", "十", "百", "千" },
    suffix2 = { [0] = "", "萬", "億", "兆", "京" }
  },
  {
    comment = "〔大寫中文數字〕",
    number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖" },
    suffix1 = { [0] = "", "拾", "佰", "仟" },
    suffix2 = { [0] = "", "萬", "億", "兆", "京" }
  },
}

local function read_seg(conf, n)
  local s = ""
  local i = 0
  local zf = true
  while string.len(n) > 0 do
    local d = tonumber(string.sub(n, -1, -1))
    if d ~= 0 then
      s = conf.number[d] .. conf.suffix1[i] .. s
      zf = false
    else
      if not zf then
        s = conf.number[0] .. s
      end
      zf = true
    end
    i = i + 1
    n = string.sub(n, 1, -2)
  end
  return i < 4, s
end

local function read_number(conf, n)
  local s = ""
  local i = 0
  local zf = false
  n = string.gsub(n, "^0+", "")
  if n == "" then
    return conf.number[0]
  end
  while string.len(n) > 0 do
    local zf2, r = read_seg(conf, string.sub(n, -4, -1))
    if r ~= "" then
      if zf and s ~= "" then
        s = r .. conf.suffix2[i] .. conf.number[0] .. s
      else
        s = r .. conf.suffix2[i] .. s
      end
    end
    zf = zf2
    i = i + 1
    n = string.sub(n, 1, -5)
  end
  return s
end




----------------------------------------------------------------------------------------
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

local function timezone_out1()
  local timezone, timezone_2, timezone_3, timezone_4 = utc_timezone(os.date("%z"))
  local timezone_discrpt = os.date("%Z")
  -- local candidate = Candidate("timezone", seg.start, seg._end, timezone, timezone_discrpt)
  return {timezone, timezone_discrpt, timezone_2, timezone_3, timezone_4}
end

-- 上下午時間
local function time_out1()
  -- local time = os.time()
  -- local time_string = string.gsub(os.date("%H:%M", time), "^0+", "")
  -- local time_discrpt = time_description_chinese(time)
  -- local candidate = Candidate("time", seg.start, seg._end, time_string, time_discrpt)
  -- 時分（前面去零）
  local time_string = string.gsub(os.date("%I:%M %p"), "^0", "")
  local time_string_2 = string.gsub(time_string, "AM", "a.m.")
  local time_string_2 = string.gsub(time_string_2, "PM", "p.m.")
  local time_string_3 = string.gsub(time_string, "AM", "A.M.")
  local time_string_3 = string.gsub(time_string_3, "PM", "P.M.")
  local time_string_4 = string.gsub(time_string, "AM", "am")
  local time_string_4 = string.gsub(time_string_4, "PM", "pm")
  -- 時分（前面有零）
  local time_string_0_1 = os.date("%I:%M %p")
  local time_string_0_2 = string.gsub(time_string_0_1, "AM", "a.m.")
  local time_string_0_2 = string.gsub(time_string_0_2, "PM", "p.m.")
  local time_string_0_3 = string.gsub(time_string_0_1, "AM", "A.M.")
  local time_string_0_3 = string.gsub(time_string_0_3, "PM", "P.M.")
  local time_string_0_4 = string.gsub(time_string_0_1, "AM", "am")
  local time_string_0_4 = string.gsub(time_string_0_4, "PM", "pm")
  -- 時分秒（前面去零）
  local time_string_5 = string.gsub(os.date("%I:%M:%S %p"), "^0", "")
  local time_string_6 = string.gsub(time_string_5, "AM", "a.m.")
  local time_string_6 = string.gsub(time_string_6, "PM", "p.m.")
  local time_string_7 = string.gsub(time_string_5, "AM", "A.M.")
  local time_string_7 = string.gsub(time_string_7, "PM", "P.M.")
  local time_string_8 = string.gsub(time_string_5, "AM", "am")
  local time_string_8 = string.gsub(time_string_8, "PM", "pm")
  -- 時分秒（前面有零）
  local time_string_00_1 = os.date("%I:%M:%S %p")
  local time_string_00_2 = string.gsub(time_string_00_1, "AM", "a.m.")
  local time_string_00_2 = string.gsub(time_string_00_2, "PM", "p.m.")
  local time_string_00_3 = string.gsub(time_string_00_1, "AM", "A.M.")
  local time_string_00_3 = string.gsub(time_string_00_3, "PM", "P.M.")
  local time_string_00_4 = string.gsub(time_string_00_1, "AM", "am")
  local time_string_00_4 = string.gsub(time_string_00_4, "PM", "pm")
  -- candidate = Candidate("time", seg.start, seg._end, time_string, time_discrpt)
  return {time_string, time_string_2, time_string_3, time_string_4 , time_string_5, time_string_6, time_string_7, time_string_8, time_string_0_1, time_string_0_2, time_string_0_3, time_string_0_4, time_string_00_1, time_string_00_2, time_string_00_3, time_string_00_4}
end

-- 中文上下午時間
local function time_out2()
  -- 時分（前面有零）
  local time_c_string = os.date("%p %I時%M分")
  local time_c_string = string.gsub(time_c_string, "AM", "上午")
  local time_c_string = string.gsub(time_c_string, "PM", "下午")
  local time_c_string_2 = os.date("%p %I點%M分")
  local time_c_string_2 = string.gsub(time_c_string_2, "AM", "上午")
  local time_c_string_2 = string.gsub(time_c_string_2, "PM", "下午")
  local time_c_string_6 = os.date("%p %I:%M")
  local time_c_string_6 = string.gsub(time_c_string_6, "AM", "上午")
  local time_c_string_6 = string.gsub(time_c_string_6, "PM", "下午")
  -- 時分秒（前面有零）
  local time_c_string_3 = os.date("%p %I時%M分%S秒")
  local time_c_string_3 = string.gsub(time_c_string_3, "AM", "上午")
  local time_c_string_3 = string.gsub(time_c_string_3, "PM", "下午")
  local time_c_string_4 = os.date("%p %I點%M分%S秒")
  local time_c_string_4 = string.gsub(time_c_string_4, "AM", "上午")
  local time_c_string_4 = string.gsub(time_c_string_4, "PM", "下午")
  local time_c_string_7 = os.date("%p %I:%M:%S")
  local time_c_string_7 = string.gsub(time_c_string_7, "AM", "上午")
  local time_c_string_7 = string.gsub(time_c_string_7, "PM", "下午")
  -- 只有上下午
  local ampm = os.date("%p")
  local ampm = string.gsub(ampm, "AM", "上午")
  local ampm = string.gsub(ampm, "PM", "下午")
  return {time_c_string, time_c_string_2, time_c_string_3, time_c_string_4, ampm, time_c_string_6, time_c_string_7}
end

-- 星期格式
local function weekstyle()
  local week_n = os.date("%w")
  local l_w = { "日", "一", "二", "三", "四", "五", "六" }
  local l_w_c = { "日", "壹", "貳", "參", "肆", "伍", "陸" }
  local l_w_jp1 = { "㈰", "㈪", "㈫", "㈬", "㈭", "㈮", "㈯" }
  local l_w_jp2 = { "㈰", "㈪", "㈫", "㈬", "㈭", "㈮", "㊏" }
  local l_w_jp3 = { "日", "月", "火", "水", "木", "金", "土" }
  local l_w_eng1 = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
  local l_w_eng2 = { "Sun.", "Mon.", "Tues.", "Wed.", "Thur.", "Fri.", "Sat." }
  local l_w_eng3 = { "Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat" }
  local weekstr = l_w[week_n+1]
  local weekstr_c = l_w_c[week_n+1]
  local weekstr_jp1 = l_w_jp1[week_n+1]
  local weekstr_jp2 = l_w_jp2[week_n+1]
  local weekstr_jp3 = l_w_jp3[week_n+1]
  local weekstr_eng1 = l_w_eng1[week_n+1]
  local weekstr_eng2 = l_w_eng2[week_n+1]
  local weekstr_eng3 = l_w_eng3[week_n+1]
  -- 先展示星期，以便後面使用
  -- if (os.date("%w") == "0") then
  --     weekstr = "日"
  --     weekstr_c = "日"
  --     weekstr_jp1 = "㈰"
  --     weekstr_jp2 = "㊐"
  --     weekstr_jp3 = "日"
  --     weekstr_eng1 = "Sunday"
  --     weekstr_eng2 = "Sun."
  --     weekstr_eng3 = "Sun"
  -- elseif (os.date("%w") == "1") then
  --     weekstr = "一"
  --     weekstr_c = "壹"
  --     weekstr_jp1 = "㈪"
  --     weekstr_jp2 = "㊊"
  --     weekstr_jp3 = "月"
  --     weekstr_eng1 = "Monday"
  --     weekstr_eng2 = "Mon."
  --     weekstr_eng3 = "Mon"
  -- elseif (os.date("%w") == "2") then
  --     weekstr = "二"
  --     weekstr_c = "貳"
  --     weekstr_jp1 = "㈫"
  --     weekstr_jp2 = "㊋"
  --     weekstr_jp3 = "火"
  --     weekstr_eng1 = "Tuesday"
  --     weekstr_eng2 = "Tues."
  --     weekstr_eng3 = "Tues"
  -- elseif (os.date("%w") == "3") then
  --     weekstr = "三"
  --     weekstr_c = "參"
  --     weekstr_jp1 = "㈬"
  --     weekstr_jp2 = "㊌"
  --     weekstr_jp3 = "水"
  --     weekstr_eng1 = "Wednesday"
  --     weekstr_eng2 = "Wed."
  --     weekstr_eng3 = "Wed"
  -- elseif (os.date("%w") == "4") then
  --     weekstr = "四"
  --     weekstr_c = "肆"
  --     weekstr_jp1 = "㈭"
  --     weekstr_jp2 = "㊍"
  --     weekstr_jp3 = "木"
  --     weekstr_eng1 = "Thursday"
  --     weekstr_eng2 = "Thur."
  --     weekstr_eng3 = "Thur"
  -- elseif (os.date("%w") == "5") then
  --     weekstr = "五"
  --     weekstr_c = "伍"
  --     weekstr_jp1 = "㈮"
  --     weekstr_jp2 = "㊎"
  --     weekstr_jp3 = "金"
  --     weekstr_eng1 = "Friday"
  --     weekstr_eng2 = "Fri."
  --     weekstr_eng3 = "Fri"
  -- elseif (os.date("%w") == "6") then
  --     weekstr = "六"
  --     weekstr_c = "陸"
  --     weekstr_jp1 = "㈯"
  --     weekstr_jp2 = "㊏"
  --     weekstr_jp3 = "土"
  --     weekstr_eng1 = "Saturday"
  --     weekstr_eng2 = "Sat."
  --     weekstr_eng3 = "Sat"
  -- end
  return {weekstr, weekstr_c, weekstr_jp1, weekstr_jp2, weekstr_jp3, weekstr_eng1, weekstr_eng2, weekstr_eng3 }
end




--[[
內碼輸入法，收入 unicode 碼得出該碼字元
--]]
local function utf8_out(cp)
  local string_char = string.char
  if cp < 128 then
    return string_char(cp)
  end
  local suffix = cp % 64
  local c4 = 128 + suffix
  cp = (cp - suffix) / 64
  if cp < 32 then
    return string_char(192 + cp, c4)
  end
  suffix = cp % 64
  local c3 = 128 + suffix
  cp = (cp - suffix) / 64
  if cp < 16 then
    return string_char(224 + cp, c3, c4)
  end
  suffix = cp % 64
  cp = (cp - suffix) / 64
  return string_char(240 + cp, 128 + suffix, c3, c4)
end


-- --[[
-- 百分號編碼（英語：Percent-encoding），又稱：URL編碼（URL encoding）
-- 從編碼到文字。
-- 導出暫轉到十進位編碼，後續變成文字，要再用以下函數轉換。
-- --]]
-- local function url_decode(str_d)
--   if string.match(str_d,'^[%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_1=o_1-00000000
--     local out_all=tonumber(string.format("%07d",o_1),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])..$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_1=o_1-11000000
--     local o_2=o_2-10000000
--     local out_all=tonumber(string.format("%05d",o_1) .. string.format("%06d",o_2),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])....$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])..$', '%1')
--     local ch_3 = string.gsub(str_d,'^....([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local x_3 = tonumber(ch_3, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_3 = Dec2bin(x_3)
--     local o_1=o_1-11100000
--     local o_2=o_2-10000000
--     local o_3=o_3-10000000
--     local out_all=tonumber(string.format("%04d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])......$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])....$', '%1')
--     local ch_3 = string.gsub(str_d,'^....([%x][%x])..$', '%1')
--     local ch_4 = string.gsub(str_d,'^......([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local x_3 = tonumber(ch_3, 16)
--     local x_4 = tonumber(ch_4, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_3 = Dec2bin(x_3)
--     local o_4 = Dec2bin(x_4)
--     local o_1=o_1-11110000
--     local o_2=o_2-10000000
--     local o_3=o_3-10000000
--     local o_4=o_4-10000000
--     local out_all=tonumber(string.format("%03d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])........$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])......$', '%1')
--     local ch_3 = string.gsub(str_d,'^....([%x][%x])....$', '%1')
--     local ch_4 = string.gsub(str_d,'^......([%x][%x])..$', '%1')
--     local ch_5 = string.gsub(str_d,'^........([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local x_3 = tonumber(ch_3, 16)
--     local x_4 = tonumber(ch_4, 16)
--     local x_5 = tonumber(ch_5, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_3 = Dec2bin(x_3)
--     local o_4 = Dec2bin(x_4)
--     local o_5 = Dec2bin(x_5)
--     local o_1=o_1-11111000
--     local o_2=o_2-10000000
--     local o_3=o_3-10000000
--     local o_4=o_4-10000000
--     local o_5=o_5-10000000
--     local out_all=tonumber(string.format("%02d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4) .. string.format("%06d",o_5),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])..........$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])........$', '%1')
--     local ch_3 = string.gsub(str_d,'^....([%x][%x])......$', '%1')
--     local ch_4 = string.gsub(str_d,'^......([%x][%x])....$', '%1')
--     local ch_5 = string.gsub(str_d,'^........([%x][%x])..$', '%1')
--     local ch_6 = string.gsub(str_d,'^..........([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local x_3 = tonumber(ch_3, 16)
--     local x_4 = tonumber(ch_4, 16)
--     local x_5 = tonumber(ch_5, 16)
--     local x_6 = tonumber(ch_6, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_3 = Dec2bin(x_3)
--     local o_4 = Dec2bin(x_4)
--     local o_5 = Dec2bin(x_5)
--     local o_6 = Dec2bin(x_6)
--     local o_1=o_1-11111100
--     local o_2=o_2-10000000
--     local o_3=o_3-10000000
--     local o_4=o_4-10000000
--     local o_5=o_5-10000000
--     local o_6=o_6-10000000
--     local out_all=tonumber(string.format("%01d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4) .. string.format("%06d",o_5) .. string.format("%06d",o_6),2)
--     return out_all
--   elseif string.match(str_d,'^[a-z0-9]$') then
--     return str_d
--   else
--     local out_all='無此編碼'
--     return out_all
--   end
-- end

-- -- 網上方法，但空碼無法再接後續，不適用
-- local out_all = string.gsub(str_d, "%x%x", function(h) return string.char(tonumber(h,16)) end)
-- local function url_decode(str)
--   local str = string.gsub (str, "+", " ")
--   local str = string.gsub (str, "%%(%x%x)", function(h) return string.char(tonumber(h,16)) end)
--   local str = string.gsub (str, "\r\n", "\n")
--   return str
-- end
-- -- print(url_decode('EAb080'))


--[[
百分號編碼（英語：Percent-encoding），又稱：URL編碼（URL encoding）
從文字到編碼
--]]
local function url_encode(str_e)
  if (str_e) then
    str_e = string.gsub (str_e, "\n", "\r\n")
    str_e = string.gsub (str_e, "([^%w ])", function (c) return string.format ("%%%02X", string.byte(c)) end)
    str_e = string.gsub (str_e, " ", "+")
  end
  return str_e
end




----------------------------------------------------------------------------------------
--- @@ date/t translator
--[[
掛載 t_translator 函數開始
--]]
local function t_translator(input, seg)
  if (string.match(input, "`")~=nil) then
    -- local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    -- local chinese_time = time_description_chinese(os.time())
    -- local All_g, Y_g, M_g, D_g, H_g = lunarJzl(os.date("%Y%m%d%H"))
    -- local ll_1, ll_2, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    -- local aptime1, aptime2, aptime3, aptime4, aptime5, aptime6, aptime7, aptime8, aptime0_1, aptime0_2, aptime0_3, aptime0_4, aptime00_1, aptime00_2,  aptime00_3, aptime00_4 = time_out1()
    -- local aptime_c1, aptime_c2, aptime_c3, aptime_c4, ap_5 = time_out2()

    -- 版本資訊
    if(input=="`v") then
      yield(Candidate("version_info", seg.start, seg._end, Ver_info_frontend(), "〔版本〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info_librime(), "〔版本〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info_lua(), "〔版本〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info_id(), "〔 id 〕"))
      return
    end

    -- lua 程式原生時間
    if (input == "`p") then
      yield(Candidate("time", seg.start, seg._end, os.date(), "〔 os.date() 〕"))
      yield(Candidate("time", seg.start, seg._end, os.time(), "〔 os.time()，當前距 1970.1.1.08:00 秒數〕"))
      return
    end

    -- Candidate(type, start, end, text, comment)
    if (input == "`t") then
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~d"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M:%S"), "^0", ""), "〔時:分:秒〕 ~d"))
      -- local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
      yield(Candidate("time", seg.start, seg._end, time_out1()[6] , "〔時:分:秒〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕 ~c"))
      -- local a, b, aptime_c3, aptime_c4, ap_5 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[7], " 0([%d])", " %1"), "〔時:分:秒〕 ~s"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[3], "0([%d])", "%1"), "〔時:分:秒〕 ~w"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~z"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~u"))
      return
    end

    if (input == "`ts") then
      -- local a, b, aptime_c3, aptime_c4 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[7], " 0([%d])", " %1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..fullshape_number(string.gsub(os.date("%I"), "^0", "")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[7], "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..fullshape_number(os.date("%I")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      return
    end

    if (input == "`tw") then
      -- local a, b, aptime_c3, aptime_c4 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[3], "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[4], "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(time_out2()[3], "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(time_out2()[4], "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[3], "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[4], "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(time_out2()[3]), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(time_out2()[4]), "〔時:分:秒〕"))
      return
    end

    if (input == "`tu") then
      -- local a, b, aptime_c3, aptime_c4, ap_5 = time_out2()
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..chb_h_date(os.date("%I")).."時"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..chb_h_date(os.date("%I")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      return
    end

    if (input == "`td") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M:%S"), "^0", ""), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H"), "^0", "")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      return
    end

    if (input == "`tm") then
      -- local a, b, c, d, aptime5, aptime6, aptime7, aptime8, e, f, g, h, aptime00_1, aptime00_2,  aptime00_3, aptime00_4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, time_out1()[6] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[8] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[7] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[5] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[14] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[16] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[15] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[13] , "〔時:分:秒〕"))
      return
    end

    if (input == "`tc") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H點%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H點%M分%S秒"), "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分%S秒"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分%S秒"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H時%M分%S秒")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H點%M分%S秒")), "〔時:分:秒〕"))
      return
    end

    if (input == "`tz") then
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      return
    end

    -- if (input == "`tm") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
    --   return
    -- end

    if (input == "`z") then
      -- local tz, tzd = timezone_out1()
      yield(Candidate("time", seg.start, seg._end, timezone_out1()[1], "〔世界協調時間〕"))
      yield(Candidate("time", seg.start, seg._end, timezone_out1()[5], "〔格林威治標準時間〕"))
      yield(Candidate("time", seg.start, seg._end, timezone_out1()[2], "〔本地時區代號〕"))
      return
    end

    if (input == "`n") then
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~d"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M"), "^0", ""), "〔時:分〕 ~d"))
      -- local aptime1, aptime2, aptime3, aptime4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, time_out1()[2], "〔時:分〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕 ~c"))
      -- local aptime_c1, aptime_c2, a, b, ap_5 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[6], " 0([%d])", " %1"), "〔時:分〕 ~s"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[1], "0([%d])", "%1"), "〔時:分〕 ~w"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~z"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~u"))
      -- local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, time_description_chinese(os.time()), "〔農曆〕 ~l"))
      return
    end

    if (input == "`ns") then
      -- local aptime_c1, aptime_c2 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[6], " 0([%d])", " %1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..fullshape_number(string.gsub(os.date("%I"), "^0", "")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[6], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..fullshape_number(os.date("%I")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      return
    end

    if (input == "`nw") then
      -- local aptime_c1, aptime_c2 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[1], "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[2], "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(time_out2()[1], "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(time_out2()[2], "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[1], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[2], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(time_out2()[1]), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(time_out2()[2]), "〔時:分〕"))
      return
    end

    if (input == "`nu") then
      -- local a, b, c, d, ap_5 = time_out2()
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..chb_h_date(os.date("%I")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..chb_h_date(os.date("%I")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      return
    end

    if (input == "`nd") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M"), "^0", ""), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H"), "^0", "")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      return
    end

    if (input == "`nm") then
      -- local aptime1, aptime2, aptime3, aptime4 , a, b, c, d, aptime0_1, aptime0_2,  aptime0_3, aptime0_4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, time_out1()[2], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[4], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[3], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[1], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[10], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[12], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[11], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[9], "〔時:分〕"))
      return
    end

    if (input == "`nc") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H點%M分"), "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H時%M分"), "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H點%M分"), "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H時%M分")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H點%M分")), "〔時:分〕"))
      return
    end

    if (input == "`nz") then
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      return
    end

    if (input == "`nl") then
      -- local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, time_description_chinese(os.time()), "〔農曆〕"))
      local All_g, Y_g, M_g, D_g, H_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, H_g.."時" , "〔農曆干支〕"))
      return
    end

    -- if (input == "`ns") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
    --   return
    -- end

    if (input == "`l") then
      -- local Moonshape, Moonangle = Moonphase_out1()
      yield(Candidate("date", seg.start, seg._end, Moonphase_out1()[1], Moonphase_out1()[2]))
      -- local p, d = Moonphase_out2()
      yield(Candidate("date", seg.start, seg._end, Moonphase_out2()[1], Moonphase_out2()[2]))
      return
    end

    if (input == "`s") then
      local jq_1, jq_2, jq_3 ,jq_4 = jieqi_out1()
      yield(Candidate("date", seg.start, seg._end, jq_1, jq_2))
      yield(Candidate("date", seg.start, seg._end, jq_3, jq_4))
      -- local jqs = GetNowTimeJq(os.date("%Y%m%d"))
      local jqsy = GetNextJQ(os.date("%Y"))
      for i =1,#jqsy do
        yield(Candidate("date", seg.start, seg._end, jqsy[i], "〔節氣〕"))
      end
      jqsy = nil
      return
    end

    if (input == "`f") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "([^%d])0", "%1"), "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23), "〔民國中數〕 ~g"))
      -- yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1"), "〔日本元号〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕 ~e"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1, "〔農曆〕 ~l"))
      return
    end

    if (input == "`fj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd, "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd), "〔日本元号〕"))
      return
    end
    -- if (input == "`fj") then
    --   yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕"))
    --   return
    -- end

    if (input == "`fh") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "([^%d])0", "%1"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日", "([^%d])0", "%1"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔民國〕"))
      return
    end

    if (input == "`fg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23), "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(23), "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(23), "〔民國中數〕"))
      return
    end

    if (input == "`fl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ll_2, "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日" , "〔農曆干支〕"))
      return
    end

    if (input == "`fa") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fe") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔日月年〕"))
      return
    end

    if (input == "`fc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 "), "([^%d])0", "%1"), "〔*年月日*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 "), "〔*年月日*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔年月日〕"))
      return
    end

    if (input == "`fd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fs") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(), "〔中數〕"))
      return
    end

    if (input == "`fn") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out1()[1], "〔本地時  時區〕 ~i"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M") .. timezone_out1()[3], "〔本地時  RFC 3339/ISO 8601〕 ~r"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日 "..os.date("%H點%M分"), "([^%d])0", "%1"), "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔民國中數〕 ~g"))
      -- yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..os.date("%H:%M"), "〔日本元号〕 ~j"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      -- local chinese_time = time_description_chinese(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1 .." ".. time_description_chinese(os.time()), "〔農曆〕 ~l"))
      return
    end

    if (input == "`fni") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out1()[1], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out1()[5], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out1()[2], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M UTC"), "〔世界時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M GMT"), "〔世界時  時區〕"))
      return
    end

    if (input == "`fnr") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M") .. timezone_out1()[3], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%dT%H%M") .. timezone_out1()[4], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%dT%H:%MZ"), "〔世界時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y%m%dT%H%MZ"), "〔世界時  RFC 3339/ISO 8601〕"))
      return
    end

    if (input == "`fnj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..os.date("%H:%M"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")).." "..os.date("%H:%M"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.." "..os.date("%H:%M"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.." "..os.date("%H:%M")), "〔日本元号〕"))
      return
    end
    -- if (input == "`fnj") then
    --   yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕"))
    --   return
    -- end

    if (input == "`fnh") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日 "..os.date("%H點%M分"), "([^%d])0", "%1"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日 "..os.date("%H 點 %M 分"), "([^%d])0", "%1"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m月%d日%H點%M分"), "0([%d])", "%1")), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日"..os.date("%H點%M分"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日 "..os.date("%H 點 %M 分"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日"..fullshape_number(os.date("%H點%M分")), "〔民國〕"))
      return
    end

    if (input == "`fng") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(23).." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔民國中數〕"))
      return
    end

    if (input == "`fnl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      -- local chinese_time = time_description_chinese(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      local All_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, ll_1 .." ".. time_description_chinese(os.time()), "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ll_2 .." ".. time_description_chinese(os.time()), "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, All_g, "〔農曆干支〕"))
      return
    end

    if (input == "`fnc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 "), "([^%d])0", "%1"), "〔*年月日 時:分*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分"), "([^%d])0", "%1")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 "), "〔*年月日 時:分*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分", "〔年月日 時:分〕"))
      return
    end

    if (input == "`fnd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fns") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fnm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fnu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fnp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fnz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔中數〕"))
      return
    end

    if (input == "`ft") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out1()[1], "〔本地時  時區〕 ~i"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M:%S") .. timezone_out1()[3], "〔本地時  RFC 3339/ISO 8601〕 ~r"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日 "..os.date("%H點%M分%S秒"), "([^%d])0", "%1"), "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔民國中數〕 ~g"))
      -- yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..os.date("%H:%M:%S"), "〔日本元号〕 ~j"))
      return
    end

    if (input == "`fti") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out1()[1], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out1()[5], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out1()[2], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M-%S UTC"), "〔世界時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M-%S GMT"), "〔世界時  時區〕"))
      return
    end

    if (input == "`ftr") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M:%S") .. timezone_out1()[3], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%dT%H%M%S") .. timezone_out1()[4], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%dT%H:%M:%SZ"), "〔世界時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y%m%dT%H%M%SZ"), "〔世界時  RFC 3339/ISO 8601〕"))
      return
    end

    if (input == "`ftj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..os.date("%H:%M:%S"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")).." "..os.date("%H:%M:%S"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.." "..os.date("%H:%M:%S"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.." "..os.date("%H:%M:%S")), "〔日本元号〕"))
      return
    end
    -- if (input == "`ftj") then
    --   yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕"))
    --   return
    -- end

    if (input == "`fth") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日 "..os.date("%H點%M分%S秒"), "([^%d])0", "%1"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日 "..os.date("%H 點 %M 分 %S 秒"), "([^%d])0", "%1"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m月%d日%H點%M分%S秒"), "0([%d])", "%1")), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日"..os.date("%H點%M分%S秒"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日 "..os.date("%H 點 %M 分 %S 秒"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日"..fullshape_number(os.date("%H點%M分%S秒")), "〔民國〕"))
      return
    end

    if (input == "`ftg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(23).." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔民國中數〕"))
      return
    end

    if (input == "`ftc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒 "), "([^%d])0", "%1"), "〔*年月日 時:分:秒*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分%S秒"), "([^%d])0", "%1")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分%S秒"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒 "), "〔*年月日 時:分:秒*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分"..fullshape_number(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      return
    end

    if (input == "`ftd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`fts") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`ftm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`ftu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`ftp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`ftz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔中數〕"))
      return
    end

    if (input == "`y") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔中數〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年", "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年", "〔民國中數〕 ~g"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, jp_y, "〔日本元号〕 ~j"))
      -- local a, b, chinese_y = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1, "〔農曆〕 ~l"))
      return
    end

    if (input == "`yj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, jp_y, "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jp_y), "〔日本元号〕"))
      return
    end

    if (input == "`yh") then
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年", "〔民國〕"))
      return
    end

    if (input == "`yg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年", "〔民國中數〕"))
      return
    end

    if (input == "`yl") then
      -- local a, b, chinese_y = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ly_2, "〔農曆〕"))
      -- local a, Y_g = lunarJzl(os.date("%Y%m%d%H"))
      -- yield(Candidate("date", seg.start, seg._end, Y_g.."年", "〔農曆干支〕"))
      return
    end

    if (input == "`yc") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年"), "〔*年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年", "〔年〕"))
      return
    end

    if (input == "`yd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")), "〔年〕"))
      return
    end

    if (input == "`yz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔中數〕"))
      return
    end

    if (input == "`m") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0", ""), "〔月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔中數〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔日本格式〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕 ~e"))
      -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm, "〔農曆〕 ~l"))
      return
    end

    if (input == "`ml") then
      -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm, "〔農曆〕"))
      local All_g, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月", "〔農曆干支〕"))
      return
    end

    if (input == "`ma") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng1_m_date(os.date("%m")).." ", "〔*月*〕"))
      return
    end

    if (input == "`me") then
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng2_m_date(os.date("%m")).." ", "〔*月*〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng3_m_date(os.date("%m")).." ", "〔*月*〕"))
      return
    end

    if (input == "`mj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔日本格式〕"))
      return
    end

    if (input == "`mc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0", ""), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月"), "([ ])0", "%1"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月"), "^0", "")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月", "〔月〕"))
      return
    end

    if (input == "`mm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`mz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔中數〕"))
      return
    end

    if (input == "`d") then
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0", ""), "〔日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔中數〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日本格式〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
      -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ld, "〔農曆〕 ~l"))
      return
    end

    if (input == "`dl") then
      -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ld, "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, D_g.."日", "〔農曆干支〕"))
      return
    end

    if (input == "`da") then
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " the "..eng1_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " The "..eng1_d_date(os.date("%d")).." ", "〔*日*〕"))
      return
    end

    if (input == "`de") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng2_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, eng4_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng4_d_date(os.date("%d")).." ", "〔*日*〕"))
      -- yield(Candidate("date", seg.start, seg._end, " "..eng3_d_date(os.date("%d")).." ", "〔*日*〕"))
      return
    end

    if (input == "`dj") then
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日本格式〕"))
      return
    end

    if (input == "`dc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0", ""), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %d 日"), "([ ])0", "%1"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%d日"), "^0", "")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %d 日"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")).."日", "〔日〕"))
      return
    end

    if (input == "`dd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "`dz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔中數〕"))
      return
    end

    if (input == "`md") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔日本格式〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕 ~e"))
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld, "〔農曆〕 ~l"))
      return
    end

    if (input == "`mdl") then
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld, "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月"..D_g.."日", "〔農曆干支〕"))
      return
    end

    if (input == "`mda") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔月日〕"))
      return
    end

    if (input == "`mde") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔日月〕"))
      return
    end

    if (input == "`mdj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔日本格式〕"))
      return
    end

    if (input == "`mdc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日 "), "([ ])0", "%1"), "〔*月日*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 "), "〔*月日*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔月日〕"))
      return
    end

    if (input == "`mdd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m"), "〔日月〕"))
      return
    end

    if (input == "`mds") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m"), "〔日月〕"))
      return
    end

    if (input == "`mdm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m"), "〔日月〕"))
      return
    end

    if (input == "`mdu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m"), "〔日月〕"))
      return
    end

    if (input == "`mdp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m"), "〔日月〕"))
      return
    end

    if (input == "`mdz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23), "〔中數〕"))
      return
    end

    if (input == "`mdw") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." ".."星期"..weekstyle()[1].." ", "〔月日週〕 ~c"))
      -- yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔中數〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d"))..weekstyle()[3], "〔日本格式〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕 ~e"))
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld.." "..weekstyle()[5].." ", "〔農曆〕 ~l"))
      return
    end

    if (input == "`mdwl") then
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld.." "..weekstyle()[5].." ", "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月"..D_g.."日".." "..weekstyle()[5].." " , "〔農曆干支〕"))
      return
    end

    if (input == "`mdwa") then
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[7]..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[8].." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔週月日〕"))
      return
    end

    if (input == "`mdwe") then
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[7]..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月〕"))
      return
    end

    if (input == "`mdwc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日"), "([ ])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔*月日週*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日").." ".."星期"..weekstyle()[1].." ", "〔*月日週*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日".." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      return
    end

    if (input == "`mdwj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d"))..weekstyle()[3], "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1")..weekstyle()[3], "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." "..weekstyle()[5].."曜日 ", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").."("..weekstyle()[5].."曜日)", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").."（"..weekstyle()[5].."曜日）", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1"))..weekstyle()[3], "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).." "..weekstyle()[5].."曜日 ", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).."("..weekstyle()[5].."曜日)", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).."（"..weekstyle()[5].."曜日）", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日")..weekstyle()[3], "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." "..weekstyle()[5].."曜日 ", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."("..weekstyle()[5].."曜日)", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."（"..weekstyle()[5].."曜日）", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m月%d日")..weekstyle()[3]), "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m月%d日").." "..weekstyle()[5].."曜日 "), "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m月%d日").."("..weekstyle()[5].."曜日)"), "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m月%d日").."（"..weekstyle()[5].."曜日）"), "〔日本格式〕"))
      return
    end

    if (input == "`mdwz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstyle()[2].." ", "〔中數〕"))
      return
    end

    if (input == "`ym") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月", "([^%d])0", "%1"), "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(2), "〔民國中數〕 ~g"))
      -- yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, jp_y..string.gsub(os.date("%m").."月", "([^%d])0", "%1"), "〔日本元号〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕 ~e"))
      -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1..lm, "〔農曆〕 ~l"))
      return
    end

    if (input == "`ymj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, jp_y..string.gsub(os.date("%m").."月", "([^%d])0", "%1"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jp_y..string.gsub(os.date("%m").."月", "([^%d])0", "%1")), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jp_y..os.date("%m").."月", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jp_y..os.date("%m").."月"), "〔日本元号〕"))
      return
    end
    -- if (input == "`ymj") then
    --   yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕"))
    --   return
    -- end

    if (input == "`ymh") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月", "([^%d])0", "%1"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月", "([^%d])0", "%1"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m"), "0([%d])", "%1")).."月", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月", "〔民國〕"))
      return
    end

    if (input == "`ymg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(2), "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(2), "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(2), "〔民國中數〕"))
      return
    end

    if (input == "`yml") then
      -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1..lm, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ly_2..lm, "〔農曆〕"))
      local All_g, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月", "〔農曆干支〕"))
      return
    end

    if (input == "`yma") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕"))
      return
    end

    if (input == "`yme") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 "), "([^%d])0", "%1"), "〔*年月*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 "), "〔*年月*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月", "〔年月〕"))
      return
    end

    if (input == "`ymd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%Y"), "〔月年〕"))
      return
    end

    if (input == "`yms") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(12), "〔中數〕"))
      return
    end

-- function week_translator0(input, seg)
    if (input == "`w") then
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstyle()[1], "〔週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, "週"..weekstyle()[1], "〔週〕 ~z"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[5].."曜日", "〔週〕 ~j"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[6], "〔週〕 ~a"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[7], "〔週〕 ~e"))
      return
    end

    if (input == "`wa") then
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[6], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstyle()[6].." ", "〔*週*〕"))
      return
    end

    if (input == "`we") then
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[7], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstyle()[7].." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[8], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstyle()[8].." ", "〔*週*〕"))
      return
    end

    if (input == "`wc") then
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstyle()[1], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstyle()[1].." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."星期"..weekstyle()[1]..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."星期"..weekstyle()[1].."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstyle()[2].." ", "〔*週*〕"))
      return
    end

    if (input == "`wz") then
      yield(Candidate("qsj", seg.start, seg._end, " ".."週"..weekstyle()[1].." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, "週"..weekstyle()[1], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."週"..weekstyle()[1]..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."週"..weekstyle()[1].."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."週"..weekstyle()[2].." ", "〔*週*〕"))
      return
    end

    if (input == "`wj") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstyle()[5].."曜日 ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[5].."曜日", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "("..weekstyle()[5].."曜日)", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（"..weekstyle()[5].."曜日）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[3], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[4], "〔週〕"))
      return
    end

-- function week_translator1(input, seg)
    if (input == "`fw") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔年月日週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." ", "〔中數〕 ~z"))
      -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔民國中數〕 ~g"))
      -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstyle()[3].." ", "〔年月日週〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1")..weekstyle()[3], "〔日本元号〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕 ~e"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("qsj", seg.start, seg._end, ll_1.." "..weekstyle()[5].." ", "〔農曆〕 ~l"))
      return
    end

    if (input == "`fwj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1")..weekstyle()[3], "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..weekstyle()[5].."曜日 ", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").."("..weekstyle()[5].."曜日)", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").."（"..weekstyle()[5].."曜日）", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")..weekstyle()[3]), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1").." "..weekstyle()[5].."曜日 "), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1").."("..weekstyle()[5].."曜日)"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1").."（"..weekstyle()[5].."曜日）"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd..weekstyle()[3], "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.." "..weekstyle()[5].."曜日 ", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.."("..weekstyle()[5].."曜日)", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.."（"..weekstyle()[5].."曜日）", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd..weekstyle()[3]), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.." "..weekstyle()[5].."曜日 "), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.."("..weekstyle()[5].."曜日)"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.."（"..weekstyle()[5].."曜日）"), "〔日本元号〕"))
      return
    end
    -- if (input == "`fwj") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstyle()[3].." ", "〔年月日週〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstyle()[5].."曜日 ", "〔年月日週〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."("..weekstyle()[5].."曜日)", "〔年月日週〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."（"..weekstyle()[5].."曜日）", "〔年月日週〕"))
    --   return
    -- end

    if (input == "`fwh") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日", "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).." ".."星期"..weekstyle()[1].." ", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日".." ".."星期"..weekstyle()[1].." ", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日".." ".."星期"..weekstyle()[1].." ", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日".." ".."星期"..weekstyle()[1].." ", "〔民國〕"))
      return
    end

    if (input == "`fwg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(23).." ".."星期"..weekstyle()[2].." ", "〔民國中數〕"))
      return
    end

    if (input == "`fwl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("qsj", seg.start, seg._end, ll_1.." "..weekstyle()[5].." ", "〔農曆〕"))
      yield(Candidate("qsj", seg.start, seg._end, ll_2.." "..weekstyle()[5].." ", "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日".." "..weekstyle()[5].." " , "〔農曆干支〕"))
      return
    end

    if (input == "`fwa") then
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[7]..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[8].." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      return
    end

    if (input == "`fwe") then
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[7]..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      return
    end

    if (input == "`fwc") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔*年月日週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")).." 星期"..weekstyle()[1].." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstyle()[1].." ", "〔*年月日週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
      return
    end

    if (input == "`fwz") then
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." ", "〔中數〕"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[2].." ", "〔中數〕"))
      return
    end

-- function week_translator2(input, seg)
    -- if (input == "`fwt") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstyle()[1].." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstyle()[5].."曜日 "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstyle()[1].." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstyle()[3].." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end

    -- if (input == "`fwtz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end
-- function week_translator3(input, seg)
    -- if (input == "`fwn") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔*年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstyle()[1].." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstyle()[5].."曜日 "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstyle()[1].." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstyle()[3].." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

    -- if (input == "`fwnz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

--- 擴充模式 \r\n    日期 (年月日) ~d \r\n    年 ~y  月 ~m  日 ~day \r\n    年月 ~ym  月日 ~md \r\n    時間 (時分) ~n   (時分秒) ~t \r\n    日期時間 (年月日時分) ~dn\r\n    日期時間 (年月日時分秒) ~dt
    if(input=="`") then
    -- if input:find('^`$') then
      -- yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
      -- yield(Candidate("date", seg.start, seg._end, "║　d〔年月日〕┃   ym〔年月〕┃　md〔月日〕║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　y〔年〕　┃　　m〔月〕 ┃　　dy〔日〕 ║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　　n〔時:分〕　　 ┃　　　t〔時:分:秒〕　║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　dn〔年月日 時:分〕  ┃ dt〔年月日 時:分:秒〕║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║*/*/*〔 * 年 * 月 * 日〕┃　*-*-*〔*年*月*日〕 ║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　*/*〔 * 月 * 日〕   ┃　　 *-*〔*月*日〕　 ║" , ""))

      -- yield(Candidate("date", seg.start, seg._end, "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , ""))
      -- -- yield(Candidate("date", seg.start, seg._end, "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕┇ ○○○〔數字〕" , ""))
      -- -- yield(Candidate("date", seg.start, seg._end, "┃ ○○○〔數字〕" , ""))

      local date_table = {
        -- { '〔半角〕', '`' }
        { '  f〔年月日〕  ym〔年月〕  md〔月日〕', '⓪' }
      , { '  y〔年〕  m〔月〕  d〔日〕  w〔週〕', '①' }
      , { '  n〔時:分〕  t〔時:分:秒〕', '②' }
      , { '  fw〔年月日週〕  mdw〔月日週〕', '③' }
      , { '  fn〔年月日 時:分〕  ft〔年月日 時:分:秒〕', '④' }
      , { '  p〔程式格式〕  z〔時區〕  s〔節氣〕  l〔月相〕', '⑤' }
      , { '  ○○○〔數字〕', '⑥' }
      , { '  ○/○/○〔 ○ 年 ○ 月 ○ 日〕  ○/○〔 ○ 月 ○ 日〕', '⑦' }
      , { '  ○-○-○〔○年○月○日〕  ○-○〔○月○日〕', '⑧' }
      , { '  / [a-z]+〔小寫字母〕', '⑨' }
      , { '  ; [a-z]+〔大寫字母〕', '⑩' }
      , { '  \' [a-z]+〔開頭大寫字母〕', '⑪' }
      , { '  x [0-9a-f]+〔內碼十六進制 Hex〕', '⑫' }
      , { '  c [0-9]+〔內碼十進制 Dec〕', '⑬' }
      , { '  o [0-7]+〔內碼八進制 Oct〕', '⑭' }
      -- , { '  e [0-9a-f]+〔Percent/URL encoding〕', '⑮' }
      , { '  v〔版本資訊〕', '⑮' }
      , { '======= 結束 =======', '⑯' }
      , { '', '⑰' }
      , { '', '⑱' }
      , { '', '⑲' }
      , { '', '⑳' }

      -- , { '〔夜思‧李白〕', '床前明月光，疑是地上霜。\r舉頭望明月，低頭思故鄉。' }
      }
      for k, v in ipairs(date_table) do
        local cand = Candidate('date', seg.start, seg._end, v[2], ' ' .. v[1])
        cand.preedit = input .. '\t《時間日期數字字母》▶'
        yield(cand)
      end
      return
    end

    if(input=="`/") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔小寫字母〕")
      cand2.preedit = input .. '\t《小寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="`;") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔大寫字母〕")
      cand2.preedit = input .. '\t《大寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="`'") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔開頭大寫字母〕")
      cand2.preedit = input .. '\t《開頭大寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="`x") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔內碼十六進制 Hex〕")
      cand2.preedit = input .. '\t《內碼十六進制》▶'
      yield(cand2)
      return
    end

    if(input=="`c") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9]+〔內碼十進制 Dec〕")
      cand2.preedit = input .. '\t《內碼十進制》▶'
      yield(cand2)
      return
    end

    if(input=="`o") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-7]+〔內碼八進制 Oct〕")
      cand2.preedit = input .. '\t《內碼八進制》▶'
      yield(cand2)
      return
    end

    -- if(input=="`e") then
    --   local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔Percent/URL encoding〕")
    --   cand2.preedit = input .. '\t《Percent/URL encoding》▶'
    --   yield(cand2)
    --   return
    -- end

    local englishout1 = string.match(input, "`/(%l+)$")
    if (englishout1~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, englishout1 , "〔一般字母小寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_l(englishout1) , "〔全形字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_1(englishout1) , "〔數學字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_2(englishout1) , "〔數學字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_3(englishout1) , "〔帶圈字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_4(englishout1) , "〔帶圈字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_5(englishout1) , "〔括號字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_6(englishout1) , "〔括號字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_7(englishout1) , "〔方框字母〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_8(englishout1) , "〔黑圈字母〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_9(englishout1) , "〔黑框字母〕"))
      return
    end

    local englishout2 = string.match(input, "`'(%l+)$")
    if (englishout2~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, string.upper(string.sub(englishout2,1,1)) .. string.sub(englishout2,2,-1) , "〔一般字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_ul(englishout2) , "〔全形字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1_2(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3_4(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5_6(englishout2) , "〔帶圈字母開頭大寫〕"))
      return
    end

    local englishout3 = string.match(input, "`;(%l+)$")
    if (englishout3~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, string.upper(englishout3) , "〔一般字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_u(englishout3) , "〔全形字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1(englishout3) , "〔數學字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3(englishout3) , "〔帶圈字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5(englishout3) , "〔括號字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_7(englishout3) , "〔方框字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_8(englishout3) , "〔黑圈字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_9(englishout3) , "〔黑框字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_s_u(englishout3) , "〔小型字母大寫〕"))
      return
    end

    local utf_input = string.match(input, "`([xco][0-9a-f]+)$")
    if (utf_input~=nil) then
      -- if string.sub(input, 1, 2) ~= "'/" then return end
      local dict = { c=10, x=16, o=8 } --{ u=16 } --{ d=10, u=16, e=8 }
      local snd = string.sub(utf_input, 1, 1)
      local n_bit = dict[snd]
      if n_bit == nil then return end
      local str = string.sub(utf_input, 2)
      local c = tonumber(str, n_bit)
      if c == nil then return end
      local utf_x = string.match(utf_input, "^x")
      local utf_o = string.match(utf_input, "^o")
      local utf_c = string.match(utf_input, "^c")
      if ( utf_x ~= nil) then
        -- local fmt = "U"..snd.."%"..(n_bit==16 and "X" or snd)
        fmt = "  U+".."%X"
      elseif ( utf_o ~= nil) then
        fmt = "  0o".."%o"
      else
        fmt = "  &#".."%d"..";"
      end
      -- 單獨查找
      local cand_ui_s = Candidate("number", seg.start, seg._end, utf8_out(c), string.format(fmt, c) .. "  ( " .. url_encode(utf8_out(c)) .. " ）" )
      cand_ui_s.preedit = "`" .. snd .. " " .. string.upper(string.sub(input, 3))
      yield(cand_ui_s)
      -- 區間查找
      -- if c*n_bit+n_bit-1 < 1048575 then
      --   for i = c*n_bit, c*n_bit+n_bit-1 do
      if c+16 < 1048575 then
        for i = c+1, c+16 do
          local cand_ui_m = Candidate("number", seg.start, seg._end, utf8_out(i), string.format(fmt, i) .. "  ( " .. url_encode(utf8_out(i)) .. " ）" )
          cand_ui_m.preedit = "`" .. snd .. " " .. string.upper(string.sub(input, 3))
          yield(cand_ui_m)
        end
      end
    end


    -- local url_c_input = string.match(input, "`e([0-9a-z][0-9a-f]*)$")
    -- if (url_c_input~=nil) then
    --   local u_1 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f])$")
    --   local u_2 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
    --   local u_3 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
    --   local u_4 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
    --   if (u_1 ~= nil) or (u_2 ~= nil) or (u_3 ~= nil) or (u_4 ~= nil) then
    --     url_c_input = url_c_input .. '0'
    --   end
    --   local url_10 = url_decode(url_c_input)
    --   local uc_i = string.upper(string.sub(input, 3, 4)) .. " " .. string.upper(string.sub(input, 5, 6)) .. " " .. string.upper(string.sub(input, 7, 8)) .. " " .. string.upper(string.sub(input, 9, 10)) .. " " .. string.upper(string.sub(input, 11, 12)) .. " " .. string.upper(string.sub(input, 13, 14))
    --   local uc_i = string.gsub(uc_i, " +$", "" )
    --   if string.match(url_10, "無此編碼") ~= nil then
    --     yield(Candidate("number", seg.start, seg._end, url_10, '' ))
    --   elseif string.match(url_c_input, "^[0-9a-z]$") ~= nil then
    --     local cand_uci_a = Candidate("number", seg.start, seg._end, url_10, url_10 )
    --     cand_uci_a.preedit = "`e " .. uc_i
    --     yield(cand_uci_a)
    --   else
    --     -- local u_c = string.upper(url_c_input)
    --     -- local u_c = string.gsub(u_c, '^', '%%')
    --     -- local u_c = string.gsub(u_c, '^(%%..)(..)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(%%..%%..)(.+)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(%%..%%..%%..)(.+)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(%%..%%..%%..%%..)(.+)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(%%..%%..%%..%%..%%..)(.+)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(..)(.?.?)(.?.?)(.?.?)(.?.?)(.?.?)$', '%%%1%%%2%%%3%%%4%%%5%%%6')
    --     -- local u_c = string.gsub(u_c, '[%%]+$', '')
    --     -- yield(Candidate("number", seg.start, seg._end, utf8_out(url_10), u_c ))
    --     local cand_uci_s = Candidate("number", seg.start, seg._end, utf8_out(url_10), url_encode(utf8_out(url_10)) )
    --     cand_uci_s.preedit = "`e " .. uc_i
    --     yield(cand_uci_s)
    --   end
    --   -- if url_10*10+10-1 < 1048575 then
    --   --   for i = url_10*10, url_10*10+10-1 do
    --   if tonumber(url_10)+16 < 1048575 then
    --     for i = tonumber(url_10)+1, tonumber(url_10)+16 do
    --       local cand_uci_m = Candidate("number", seg.start, seg._end, utf8_out(i), url_encode(utf8_out(i)) )
    --       cand_uci_m.preedit = "`e " .. uc_i
    --       yield(cand_uci_m)
    --     end
    --   end
    --   return
    -- end


    local y, m, d = string.match(input, "`(%d+)/(%d?%d)/(%d?%d)$")
    if(y~=nil) and (tonumber(m)<13) and (tonumber(d)<32) then
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      if tonumber(y) > 1911 then
        yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(y).."年"..m.."月"..d.."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
      elseif tonumber(y) <= 1911 then
        yield(Candidate("date", seg.start, seg._end, "民國前"..min_guo(y).."年"..m.."月"..d.."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國前"..purech_number(min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國前"..read_number(confs[1], min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
      end
      -- yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      local jpymd2, jp_y2 = jp_ymd(y,m,d)
      yield(Candidate("date", seg.start, seg._end, jp_y2..m.."月"..d.."日" , "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d).." "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      if tonumber(y) > 1899 and tonumber(y) < 2101 then
        -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
        local ll_1b, ll_2b = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
        -- if(Date2LunarDate~=nil) then
        if(ll_1b~=nil) and (ll_2b~=nil) then
          yield(Candidate("date", seg.start, seg._end, ll_1b, "〔西曆→農曆〕"))
          yield(Candidate("date", seg.start, seg._end, ll_2b, "〔西曆→農曆〕"))
        end
      end
      if tonumber(y) > 1901 and tonumber(y) < 2101 then
        local All_g2, Y_g2, M_g2, D_g2 = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
        if(All_g2~=nil) then
          yield(Candidate("date", seg.start, seg._end, Y_g2.."年"..M_g2.."月"..D_g2.."日", "〔西曆→農曆干支〕"))
        end
        local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
        local LDD2D_leap_year  = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
        -- if(Date2LunarDate~=nil) then
        if(LDD2D~=nil) then
          yield(Candidate("date", seg.start, seg._end, LDD2D, "〔農曆→西曆〕"))
          yield(Candidate("date", seg.start, seg._end, LDD2D_leap_year, "〔農曆(閏)→西曆〕"))
        end
      end
      return
    end

    local m, d = string.match(input, "`(%d?%d)/(%d?%d)$")
    if(m~=nil) and (tonumber(m)<13) and (tonumber(d)<32) then
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      return
    end

    local y, m, d = string.match(input, "`(%d+)-(%d?%d)-(%d?%d)$")
    if(y~=nil) and (tonumber(m)<13) and (tonumber(d)<32) then
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      if tonumber(y) > 1911 then
        yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(y).."年"..m.."月"..d.."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
      elseif tonumber(y) <= 1911 then
        yield(Candidate("date", seg.start, seg._end, "民國前"..min_guo(y).."年"..m.."月"..d.."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國前"..purech_number(min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國前"..read_number(confs[1], min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
      end
      -- yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      local jpymd2, jp_y2 = jp_ymd(y,m,d)
      yield(Candidate("date", seg.start, seg._end, jp_y2..m.."月"..d.."日" , "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d).." "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      if tonumber(y) > 1899 and tonumber(y) < 2101 then
        -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
        local ll_1b, ll_2b = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
        -- if(Date2LunarDate~=nil) then
        if(ll_1b~=nil) and (ll_2b~=nil) then
          yield(Candidate("date", seg.start, seg._end, ll_1b, "〔西曆→農曆〕"))
          yield(Candidate("date", seg.start, seg._end, ll_2b, "〔西曆→農曆〕"))
        end
      end
      if tonumber(y) > 1901 and tonumber(y) < 2101 then
        local All_g2, Y_g2, M_g2, D_g2 = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
        if(All_g2~=nil) then
          yield(Candidate("date", seg.start, seg._end, Y_g2.."年"..M_g2.."月"..D_g2.."日", "〔西曆→農曆干支〕"))
        end
        local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
        local LDD2D_leap_year  = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
        -- if(Date2LunarDate~=nil) then
        if(LDD2D~=nil) then
          yield(Candidate("date", seg.start, seg._end, LDD2D, "〔農曆→西曆〕"))
          yield(Candidate("date", seg.start, seg._end, LDD2D_leap_year, "〔農曆(閏)→西曆〕"))
        end
        -- local chinese_date_input2 = to_chinese_cal(y, m, d)
        -- if(chinese_date_input2~=nil) then
        --   yield(Candidate("date", seg.start, seg._end, chinese_date_input2 .. " ", "〔農曆，可能有誤！〕"))
        -- end
      end
      return
    end

    local m, d = string.match(input, "`(%d?%d)-(%d?%d)$")
    if(m~=nil) and (tonumber(m)<13) and (tonumber(d)<32) then
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      return
    end

    -- local numberout = string.match(input, "'//?(%d+)$")
    local numberout, dot1, afterdot = string.match(input, "`(%d+)(%.?)(%d*)$")
    if (tonumber(numberout)~=nil) then
    -- if (numberout~=nil) and (tonumber(nn)~=nil) then
      local nn = string.sub(numberout, 1)
      --[[ 用 yield 產生一個候選項
      候選項的構造函數是 Candidate，它有五個參數：
      - type: 字符串，表示候選項的類型（可隨意取）
      - start: 候選項對應的輸入串的起始位置
      - _end:  候選項對應的輸入串的結束位置
      - text:  候選項的文本
      - comment: 候選項的注釋
      --]]
      yield(Candidate("number", seg.start, seg._end, numberout .. dot1 .. afterdot , "〔一般數字〕"))

      if (string.len(numberout) < 4) then
        yield(Candidate("number", seg.start, seg._end, "," , "〔千分位〕"))
      else
        -- local k = string.sub(numberout, 1, -1) -- 取參數
        local result = formatnumberthousands(numberout) --- 調用算法
        yield(Candidate("number", seg.start, seg._end, result .. dot1 .. afterdot , "〔千分位〕"))
      end

      yield(Candidate("number", seg.start, seg._end, string.format("%E", numberout .. dot1 .. afterdot ), "〔科學計數〕"))
      yield(Candidate("number", seg.start, seg._end, string.format("%e", numberout .. dot1 .. afterdot ), "〔科學計數〕"))
      yield(Candidate("number", seg.start, seg._end, math1_number(numberout) .. dot1 .. math1_number(afterdot), "〔數學粗體數字〕"))
      yield(Candidate("number", seg.start, seg._end, math2_number(numberout) .. dot1 .. math2_number(afterdot), "〔數學空心數字〕"))
      yield(Candidate("number", seg.start, seg._end, fullshape_number(numberout) .. dot1 .. fullshape_number(afterdot), "〔全形數字〕"))

      if (dot1~='.') then
        yield(Candidate("number", seg.start, seg._end, little1_number(numberout), "〔上標數字〕"))
        yield(Candidate("number", seg.start, seg._end, little2_number(numberout), "〔下標數字〕"))

        -- for _, conf in ipairs(confs) do
        --   local r = read_number(conf, nn)
        --   yield(Candidate("number", seg.start, seg._end, r, conf.comment))
        -- end
        yield(Candidate("number", seg.start, seg._end, read_number(confs[1], nn), confs[1].comment))
        yield(Candidate("number", seg.start, seg._end, read_number(confs[2], nn), confs[2].comment))

        if (string.len(numberout) < 2) then
          yield(Candidate("number", seg.start, seg._end, "元整", "〔純中文數字〕"))
        else
          yield(Candidate("number", seg.start, seg._end, purech_number(numberout), "〔純中文數字〕"))
        end

        yield(Candidate("number", seg.start, seg._end, military_number(numberout), "〔軍中數字〕"))

        yield(Candidate("number", seg.start, seg._end, circled1_number(numberout), "〔帶圈數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled2_number(numberout), "〔帶圈無襯線數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled3_number(numberout), "〔反白帶圈數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled4_number(numberout), "〔反白帶圈無襯線數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled5_number(numberout), "〔帶圈中文數字〕"))

        if (tonumber(numberout)==1) or (tonumber(numberout)==0) then
          yield(Candidate("number", seg.start, seg._end, string.sub(numberout, -1), "〔二進位〕"))
        else
          yield(Candidate("number", seg.start, seg._end, Dec2bin(numberout), "〔二進位〕"))
        end

        yield(Candidate("number", seg.start, seg._end, string.format("%o",numberout), "〔八進位〕"))
        yield(Candidate("number", seg.start, seg._end, string.format("%X",numberout), "〔十六進位〕"))
        yield(Candidate("number", seg.start, seg._end, string.format("%x",numberout), "〔十六進位〕"))
      elseif (dot1=='.') then
        yield(Candidate("number", seg.start, seg._end, military_number(numberout..dot1..afterdot), "〔軍中數字〕"))
      end
      return
    end

  end
end




----------------------------------------------------------------------------------------
--- @@ date/t2 translator
--[[
掛載 t2_translator 函數開始
--]]
local function t2_translator(input, seg)
  if (string.match(input, "'/")~=nil) then
    -- local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    -- local chinese_time = time_description_chinese(os.time())
    -- local All_g, Y_g, M_g, D_g, H_g = lunarJzl(os.date("%Y%m%d%H"))
    -- local ll_1, ll_2, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    -- local aptime1, aptime2, aptime3, aptime4, aptime5, aptime6, aptime7, aptime8, aptime0_1, aptime0_2, aptime0_3, aptime0_4, aptime00_1, aptime00_2,  aptime00_3, aptime00_4 = time_out1()
    -- local aptime_c1, aptime_c2, aptime_c3, aptime_c4, ap_5 = time_out2()

    -- 版本資訊
    if(input=="'/v") then
      yield(Candidate("version_info", seg.start, seg._end, Ver_info_frontend(), "〔版本〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info_librime(), "〔版本〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info_lua(), "〔版本〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info_id(), "〔 id 〕"))
      return
    end

    -- lua 程式原生時間
    if (input == "'/p") then
      yield(Candidate("time", seg.start, seg._end, os.date(), "〔 os.date() 〕"))
      yield(Candidate("time", seg.start, seg._end, os.time(), "〔 os.time()，當前距 1970.1.1.08:00 秒數〕"))
      return
    end

    -- Candidate(type, start, end, text, comment)
    if (input == "'/t") then
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~d"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M:%S"), "^0", ""), "〔時:分:秒〕 ~d"))
      -- local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
      yield(Candidate("time", seg.start, seg._end, time_out1()[6] , "〔時:分:秒〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕 ~c"))
      -- local a, b, aptime_c3, aptime_c4, ap_5 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[7], " 0([%d])", " %1"), "〔時:分:秒〕 ~s"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[3], "0([%d])", "%1"), "〔時:分:秒〕 ~w"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~z"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~u"))
      return
    end

    if (input == "'/ts") then
      -- local a, b, aptime_c3, aptime_c4 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[7], " 0([%d])", " %1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..fullshape_number(string.gsub(os.date("%I"), "^0", "")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[7], "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..fullshape_number(os.date("%I")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      return
    end

    if (input == "'/tw") then
      -- local a, b, aptime_c3, aptime_c4 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[3], "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[4], "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(time_out2()[3], "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(time_out2()[4], "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[3], "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[4], "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(time_out2()[3]), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(time_out2()[4]), "〔時:分:秒〕"))
      return
    end

    if (input == "'/tu") then
      -- local a, b, aptime_c3, aptime_c4, ap_5 = time_out2()
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..chb_h_date(os.date("%I")).."時"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..chb_h_date(os.date("%I")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      return
    end

    if (input == "'/td") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M:%S"), "^0", ""), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H"), "^0", "")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      return
    end

    if (input == "'/tm") then
      -- local a, b, c, d, aptime5, aptime6, aptime7, aptime8, e, f, g, h, aptime00_1, aptime00_2,  aptime00_3, aptime00_4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, time_out1()[6] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[8] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[7] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[5] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[14] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[16] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[15] , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[13] , "〔時:分:秒〕"))
      return
    end

    if (input == "'/tc") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H點%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H點%M分%S秒"), "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分%S秒"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分%S秒"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H時%M分%S秒")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H點%M分%S秒")), "〔時:分:秒〕"))
      return
    end

    if (input == "'/tz") then
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      return
    end

    -- if (input == "'/tm") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
    --   return
    -- end

    if (input == "'/z") then
      -- local tz, tzd = timezone_out1()
      yield(Candidate("time", seg.start, seg._end, timezone_out1()[1], "〔世界協調時間〕"))
      yield(Candidate("time", seg.start, seg._end, timezone_out1()[5], "〔格林威治標準時間〕"))
      yield(Candidate("time", seg.start, seg._end, timezone_out1()[2], "〔本地時區代號〕"))
      return
    end

    if (input == "'/n") then
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~d"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M"), "^0", ""), "〔時:分〕 ~d"))
      -- local aptime1, aptime2, aptime3, aptime4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, time_out1()[2], "〔時:分〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕 ~c"))
      -- local aptime_c1, aptime_c2, a, b, ap_5 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[6], " 0([%d])", " %1"), "〔時:分〕 ~s"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[1], "0([%d])", "%1"), "〔時:分〕 ~w"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~z"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~u"))
      -- local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, time_description_chinese(os.time()), "〔農曆〕 ~l"))
      return
    end

    if (input == "'/ns") then
      -- local aptime_c1, aptime_c2 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[6], " 0([%d])", " %1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..fullshape_number(string.gsub(os.date("%I"), "^0", "")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[6], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..fullshape_number(os.date("%I")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      return
    end

    if (input == "'/nw") then
      -- local aptime_c1, aptime_c2 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[1], "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(time_out2()[2], "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(time_out2()[1], "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(time_out2()[2], "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[1], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[2], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(time_out2()[1]), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(time_out2()[2]), "〔時:分〕"))
      return
    end

    if (input == "'/nu") then
      -- local a, b, c, d, ap_5 = time_out2()
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..ch_h_date(os.date("%I")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..chb_h_date(os.date("%I")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out2()[5].." "..chb_h_date(os.date("%I")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      return
    end

    if (input == "'/nd") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M"), "^0", ""), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H"), "^0", "")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      return
    end

    if (input == "'/nm") then
      -- local aptime1, aptime2, aptime3, aptime4 , a, b, c, d, aptime0_1, aptime0_2,  aptime0_3, aptime0_4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, time_out1()[2], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[4], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[3], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[1], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[10], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[12], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[11], "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, time_out1()[9], "〔時:分〕"))
      return
    end

    if (input == "'/nc") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H點%M分"), "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H時%M分"), "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H點%M分"), "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H時%M分")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H點%M分")), "〔時:分〕"))
      return
    end

    if (input == "'/nz") then
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      return
    end

    if (input == "'/nl") then
      -- local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, time_description_chinese(os.time()), "〔農曆〕"))
      local All_g, Y_g, M_g, D_g, H_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, H_g.."時" , "〔農曆干支〕"))
      return
    end

    -- if (input == "'/ns") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
    --   return
    -- end

    if (input == "'/l") then
      -- local Moonshape, Moonangle = Moonphase_out1()
      yield(Candidate("date", seg.start, seg._end, Moonphase_out1()[1], Moonphase_out1()[2]))
      -- local p, d = Moonphase_out2()
      yield(Candidate("date", seg.start, seg._end, Moonphase_out2()[1], Moonphase_out2()[2]))
      return
    end

    if (input == "'/s") then
      local jq_1, jq_2, jq_3 ,jq_4 = jieqi_out1()
      yield(Candidate("date", seg.start, seg._end, jq_1, jq_2))
      yield(Candidate("date", seg.start, seg._end, jq_3, jq_4))
      -- local jqs = GetNowTimeJq(os.date("%Y%m%d"))
      local jqsy = GetNextJQ(os.date("%Y"))
      for i =1,#jqsy do
        yield(Candidate("date", seg.start, seg._end, jqsy[i], "〔節氣〕"))
      end
      jqsy = nil
      return
    end

    if (input == "'/f") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "([^%d])0", "%1"), "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23), "〔民國中數〕 ~g"))
      -- yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1"), "〔日本元号〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕 ~e"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/fj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd, "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd), "〔日本元号〕"))
      return
    end
    -- if (input == "'/fj") then
    --   yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕"))
    --   return
    -- end

    if (input == "'/fh") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "([^%d])0", "%1"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日", "([^%d])0", "%1"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔民國〕"))
      return
    end

    if (input == "'/fg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23), "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(23), "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(23), "〔民國中數〕"))
      return
    end

    if (input == "'/fl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ll_2, "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日" , "〔農曆干支〕"))
      return
    end

    if (input == "'/fa") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fe") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔日月年〕"))
      return
    end

    if (input == "'/fc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 "), "([^%d])0", "%1"), "〔*年月日*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 "), "〔*年月日*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔年月日〕"))
      return
    end

    if (input == "'/fd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fs") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(), "〔中數〕"))
      return
    end

    if (input == "'/fn") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out1()[1], "〔本地時  時區〕 ~i"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M") .. timezone_out1()[3], "〔本地時  RFC 3339/ISO 8601〕 ~r"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日 "..os.date("%H點%M分"), "([^%d])0", "%1"), "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔民國中數〕 ~g"))
      -- yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..os.date("%H:%M"), "〔日本元号〕 ~j"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      -- local chinese_time = time_description_chinese(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1 .." ".. time_description_chinese(os.time()), "〔農曆〕 ~l"))
      return
    end

    if (input == "'/fni") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out1()[1], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out1()[5], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out1()[2], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M UTC"), "〔世界時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M GMT"), "〔世界時  時區〕"))
      return
    end

    if (input == "'/fnr") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M") .. timezone_out1()[3], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%dT%H%M") .. timezone_out1()[4], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%dT%H:%MZ"), "〔世界時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y%m%dT%H%MZ"), "〔世界時  RFC 3339/ISO 8601〕"))
      return
    end

    if (input == "'/fnj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..os.date("%H:%M"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")).." "..os.date("%H:%M"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.." "..os.date("%H:%M"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.." "..os.date("%H:%M")), "〔日本元号〕"))
      return
    end
    -- if (input == "'/fnj") then
    --   yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕"))
    --   return
    -- end

    if (input == "'/fnh") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日 "..os.date("%H點%M分"), "([^%d])0", "%1"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日 "..os.date("%H 點 %M 分"), "([^%d])0", "%1"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m月%d日%H點%M分"), "0([%d])", "%1")), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日"..os.date("%H點%M分"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日 "..os.date("%H 點 %M 分"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日"..fullshape_number(os.date("%H點%M分")), "〔民國〕"))
      return
    end

    if (input == "'/fng") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(23).." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔民國中數〕"))
      return
    end

    if (input == "'/fnl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      -- local chinese_time = time_description_chinese(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      local All_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, ll_1 .." ".. time_description_chinese(os.time()), "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ll_2 .." ".. time_description_chinese(os.time()), "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, All_g, "〔農曆干支〕"))
      return
    end

    if (input == "'/fnc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 "), "([^%d])0", "%1"), "〔*年月日 時:分*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分"), "([^%d])0", "%1")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 "), "〔*年月日 時:分*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分", "〔年月日 時:分〕"))
      return
    end

    if (input == "'/fnd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fns") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fnm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fnu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fnp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fnz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔中數〕"))
      return
    end

    if (input == "'/ft") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out1()[1], "〔本地時  時區〕 ~i"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M:%S") .. timezone_out1()[3], "〔本地時  RFC 3339/ISO 8601〕 ~r"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日 "..os.date("%H點%M分%S秒"), "([^%d])0", "%1"), "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔民國中數〕 ~g"))
      -- yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..os.date("%H:%M:%S"), "〔日本元号〕 ~j"))
      return
    end

    if (input == "'/fti") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out1()[1], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out1()[5], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out1()[2], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M-%S UTC"), "〔世界時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M-%S GMT"), "〔世界時  時區〕"))
      return
    end

    if (input == "'/ftr") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M:%S") .. timezone_out1()[3], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%dT%H%M%S") .. timezone_out1()[4], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%dT%H:%M:%SZ"), "〔世界時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y%m%dT%H%M%SZ"), "〔世界時  RFC 3339/ISO 8601〕"))
      return
    end

    if (input == "'/ftj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..os.date("%H:%M:%S"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")).." "..os.date("%H:%M:%S"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.." "..os.date("%H:%M:%S"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.." "..os.date("%H:%M:%S")), "〔日本元号〕"))
      return
    end
    -- if (input == "'/ftj") then
    --   yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕"))
    --   return
    -- end

    if (input == "'/fth") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日 "..os.date("%H點%M分%S秒"), "([^%d])0", "%1"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日 "..os.date("%H 點 %M 分 %S 秒"), "([^%d])0", "%1"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m月%d日%H點%M分%S秒"), "0([%d])", "%1")), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日"..os.date("%H點%M分%S秒"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日 "..os.date("%H 點 %M 分 %S 秒"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日"..fullshape_number(os.date("%H點%M分%S秒")), "〔民國〕"))
      return
    end

    if (input == "'/ftg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(23).." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(23).." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔民國中數〕"))
      return
    end

    if (input == "'/ftc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒 "), "([^%d])0", "%1"), "〔*年月日 時:分:秒*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分%S秒"), "([^%d])0", "%1")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分%S秒"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒 "), "〔*年月日 時:分:秒*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分"..fullshape_number(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      return
    end

    if (input == "'/ftd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/fts") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/ftm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/ftu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/ftp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/ftz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔中數〕"))
      return
    end

    if (input == "'/y") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔中數〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年", "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年", "〔民國中數〕 ~g"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, jp_y, "〔日本元号〕 ~j"))
      -- local a, b, chinese_y = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/yj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, jp_y, "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jp_y), "〔日本元号〕"))
      return
    end

    if (input == "'/yh") then
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年", "〔民國〕"))
      return
    end

    if (input == "'/yg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年", "〔民國中數〕"))
      return
    end

    if (input == "'/yl") then
      -- local a, b, chinese_y = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ly_2, "〔農曆〕"))
      -- local a, Y_g = lunarJzl(os.date("%Y%m%d%H"))
      -- yield(Candidate("date", seg.start, seg._end, Y_g.."年", "〔農曆干支〕"))
      return
    end

    if (input == "'/yc") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年"), "〔*年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年", "〔年〕"))
      return
    end

    if (input == "'/yd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")), "〔年〕"))
      return
    end

    if (input == "'/yz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔中數〕"))
      return
    end

    if (input == "'/m") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0", ""), "〔月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔中數〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔日本格式〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕 ~e"))
      -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/ml") then
      -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm, "〔農曆〕"))
      local All_g, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月", "〔農曆干支〕"))
      return
    end

    if (input == "'/ma") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng1_m_date(os.date("%m")).." ", "〔*月*〕"))
      return
    end

    if (input == "'/me") then
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng2_m_date(os.date("%m")).." ", "〔*月*〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng3_m_date(os.date("%m")).." ", "〔*月*〕"))
      return
    end

    if (input == "'/mj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔日本格式〕"))
      return
    end

    if (input == "'/mc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0", ""), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月"), "([ ])0", "%1"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月"), "^0", "")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月", "〔月〕"))
      return
    end

    if (input == "'/mm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/mz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔中數〕"))
      return
    end

    if (input == "'/d") then
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0", ""), "〔日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔中數〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日本格式〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
      -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ld, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/dl") then
      -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ld, "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, D_g.."日", "〔農曆干支〕"))
      return
    end

    if (input == "'/da") then
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " the "..eng1_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " The "..eng1_d_date(os.date("%d")).." ", "〔*日*〕"))
      return
    end

    if (input == "'/de") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng2_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, eng4_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng4_d_date(os.date("%d")).." ", "〔*日*〕"))
      -- yield(Candidate("date", seg.start, seg._end, " "..eng3_d_date(os.date("%d")).." ", "〔*日*〕"))
      return
    end

    if (input == "'/dj") then
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日本格式〕"))
      return
    end

    if (input == "'/dc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0", ""), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %d 日"), "([ ])0", "%1"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%d日"), "^0", "")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %d 日"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")).."日", "〔日〕"))
      return
    end

    if (input == "'/dd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "'/dz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔中數〕"))
      return
    end

    if (input == "'/md") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔日本格式〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕 ~e"))
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/mdl") then
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld, "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月"..D_g.."日", "〔農曆干支〕"))
      return
    end

    if (input == "'/mda") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔月日〕"))
      return
    end

    if (input == "'/mde") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔日月〕"))
      return
    end

    if (input == "'/mdj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔日本格式〕"))
      return
    end

    if (input == "'/mdc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日 "), "([ ])0", "%1"), "〔*月日*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 "), "〔*月日*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔月日〕"))
      return
    end

    if (input == "'/mdd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m"), "〔日月〕"))
      return
    end

    if (input == "'/mds") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m"), "〔日月〕"))
      return
    end

    if (input == "'/mdm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m"), "〔日月〕"))
      return
    end

    if (input == "'/mdu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m"), "〔日月〕"))
      return
    end

    if (input == "'/mdp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m"), "〔日月〕"))
      return
    end

    if (input == "'/mdz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23), "〔中數〕"))
      return
    end

    if (input == "'/mdw") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." ".."星期"..weekstyle()[1].." ", "〔月日週〕 ~c"))
      -- yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔中數〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d"))..weekstyle()[3], "〔日本格式〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕 ~e"))
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld.." "..weekstyle()[5].." ", "〔農曆〕 ~l"))
      return
    end

    if (input == "'/mdwl") then
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld.." "..weekstyle()[5].." ", "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月"..D_g.."日".." "..weekstyle()[5].." " , "〔農曆干支〕"))
      return
    end

    if (input == "'/mdwa") then
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[7]..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[8].." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔週月日〕"))
      return
    end

    if (input == "'/mdwe") then
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[7]..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月〕"))
      return
    end

    if (input == "'/mdwc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日"), "([ ])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔*月日週*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日").." ".."星期"..weekstyle()[1].." ", "〔*月日週*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日".." ".."星期"..weekstyle()[1].." ", "〔月日週〕"))
      return
    end

    if (input == "'/mdwj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d"))..weekstyle()[3], "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1")..weekstyle()[3], "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." "..weekstyle()[5].."曜日 ", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").."("..weekstyle()[5].."曜日)", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").."（"..weekstyle()[5].."曜日）", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1"))..weekstyle()[3], "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).." "..weekstyle()[5].."曜日 ", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).."("..weekstyle()[5].."曜日)", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).."（"..weekstyle()[5].."曜日）", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日")..weekstyle()[3], "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." "..weekstyle()[5].."曜日 ", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."("..weekstyle()[5].."曜日)", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."（"..weekstyle()[5].."曜日）", "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m月%d日")..weekstyle()[3]), "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m月%d日").." "..weekstyle()[5].."曜日 "), "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m月%d日").."("..weekstyle()[5].."曜日)"), "〔日本格式〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m月%d日").."（"..weekstyle()[5].."曜日）"), "〔日本格式〕"))
      return
    end

    if (input == "'/mdwz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstyle()[2].." ", "〔中數〕"))
      return
    end

    if (input == "'/ym") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔中數〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月", "([^%d])0", "%1"), "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(2), "〔民國中數〕 ~g"))
      -- yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, jp_y..string.gsub(os.date("%m").."月", "([^%d])0", "%1"), "〔日本元号〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕 ~e"))
      -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1..lm, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/ymj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, jp_y..string.gsub(os.date("%m").."月", "([^%d])0", "%1"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jp_y..string.gsub(os.date("%m").."月", "([^%d])0", "%1")), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jp_y..os.date("%m").."月", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jp_y..os.date("%m").."月"), "〔日本元号〕"))
      return
    end
    -- if (input == "'/ymj") then
    --   yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕"))
    --   return
    -- end

    if (input == "'/ymh") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月", "([^%d])0", "%1"), "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月", "([^%d])0", "%1"), "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m"), "0([%d])", "%1")).."月", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月", "〔民國〕"))
      return
    end

    if (input == "'/ymg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(2), "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(2), "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(2), "〔民國中數〕"))
      return
    end

    if (input == "'/yml") then
      -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1..lm, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ly_2..lm, "〔農曆〕"))
      local All_g, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月", "〔農曆干支〕"))
      return
    end

    if (input == "'/yma") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕"))
      return
    end

    if (input == "'/yme") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 "), "([^%d])0", "%1"), "〔*年月*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 "), "〔*年月*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月", "〔年月〕"))
      return
    end

    if (input == "'/ymd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%Y"), "〔月年〕"))
      return
    end

    if (input == "'/yms") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔中數〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(12), "〔中數〕"))
      return
    end

-- function week_translator0(input, seg)
    if (input == "'/w") then
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstyle()[1], "〔週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, "週"..weekstyle()[1], "〔週〕 ~z"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[5].."曜日", "〔週〕 ~j"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[6], "〔週〕 ~a"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[7], "〔週〕 ~e"))
      return
    end

    if (input == "'/wa") then
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[6], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstyle()[6].." ", "〔*週*〕"))
      return
    end

    if (input == "'/we") then
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[7], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstyle()[7].." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[8], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstyle()[8].." ", "〔*週*〕"))
      return
    end

    if (input == "'/wc") then
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstyle()[1], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstyle()[1].." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."星期"..weekstyle()[1]..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."星期"..weekstyle()[1].."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstyle()[2].." ", "〔*週*〕"))
      return
    end

    if (input == "'/wz") then
      yield(Candidate("qsj", seg.start, seg._end, " ".."週"..weekstyle()[1].." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, "週"..weekstyle()[1], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."週"..weekstyle()[1]..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."週"..weekstyle()[1].."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."週"..weekstyle()[2].." ", "〔*週*〕"))
      return
    end

    if (input == "'/wj") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstyle()[5].."曜日 ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[5].."曜日", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "("..weekstyle()[5].."曜日)", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（"..weekstyle()[5].."曜日）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[3], "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstyle()[4], "〔週〕"))
      return
    end

-- function week_translator1(input, seg)
    if (input == "'/fw") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔年月日週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." ", "〔中數〕 ~z"))
      -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔民國〕 ~h"))
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔民國中數〕 ~g"))
      -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstyle()[3].." ", "〔年月日週〕 ~j"))
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1")..weekstyle()[3], "〔日本元号〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕 ~e"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("qsj", seg.start, seg._end, ll_1.." "..weekstyle()[5].." ", "〔農曆〕 ~l"))
      return
    end

    if (input == "'/fwj") then
      local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1")..weekstyle()[3], "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").." "..weekstyle()[5].."曜日 ", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").."("..weekstyle()[5].."曜日)", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(jpymd, "([^%d])0", "%1").."（"..weekstyle()[5].."曜日）", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")..weekstyle()[3]), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1").." "..weekstyle()[5].."曜日 "), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1").."("..weekstyle()[5].."曜日)"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(jpymd, "([^%d])0", "%1").."（"..weekstyle()[5].."曜日）"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd..weekstyle()[3], "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.." "..weekstyle()[5].."曜日 ", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.."("..weekstyle()[5].."曜日)", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, jpymd.."（"..weekstyle()[5].."曜日）", "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd..weekstyle()[3]), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.." "..weekstyle()[5].."曜日 "), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.."("..weekstyle()[5].."曜日)"), "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(jpymd.."（"..weekstyle()[5].."曜日）"), "〔日本元号〕"))
      return
    end
    -- if (input == "'/fwj") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstyle()[3].." ", "〔年月日週〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstyle()[5].."曜日 ", "〔年月日週〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."("..weekstyle()[5].."曜日)", "〔年月日週〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."（"..weekstyle()[5].."曜日）", "〔年月日週〕"))
    --   return
    -- end

    if (input == "'/fwh") then
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日", "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub("民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日", "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).." ".."星期"..weekstyle()[1].." ", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(os.date("%Y")).."年"..os.date("%m").."月"..os.date("%d").."日".." ".."星期"..weekstyle()[1].." ", "〔民國〕"))
      yield(Candidate("date", seg.start, seg._end, "民國 "..min_guo(os.date("%Y")).." 年 "..os.date("%m").." 月 "..os.date("%d").." 日".." ".."星期"..weekstyle()[1].." ", "〔民國*〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..fullshape_number(min_guo(os.date("%Y"))).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日".." ".."星期"..weekstyle()[1].." ", "〔民國〕"))
      return
    end

    if (input == "'/fwg") then
      yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(os.date("%Y"))).."年"..rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(os.date("%Y"))).."年"..rqzdx1(23).." ".."星期"..weekstyle()[1].." ", "〔民國中數〕"))
      yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[2], min_guo(os.date("%Y"))).."年"..rqzdx2(23).." ".."星期"..weekstyle()[2].." ", "〔民國中數〕"))
      return
    end

    if (input == "'/fwl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("qsj", seg.start, seg._end, ll_1.." "..weekstyle()[5].." ", "〔農曆〕"))
      yield(Candidate("qsj", seg.start, seg._end, ll_2.." "..weekstyle()[5].." ", "〔農曆〕"))
      local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日".." "..weekstyle()[5].." " , "〔農曆干支〕"))
      return
    end

    if (input == "'/fwa") then
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[7]..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[8].." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      return
    end

    if (input == "'/fwe") then
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[7]..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstyle()[6]..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      return
    end

    if (input == "'/fwc") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1").." ".."星期"..weekstyle()[1].." ", "〔*年月日週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")).." 星期"..weekstyle()[1].." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstyle()[1].." ", "〔*年月日週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstyle()[1].." ", "〔年月日週〕"))
      return
    end

    if (input == "'/fwz") then
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." ", "〔中數〕"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[2].." ", "〔中數〕"))
      return
    end

-- function week_translator2(input, seg)
    -- if (input == "'/fwt") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstyle()[1].." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstyle()[5].."曜日 "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstyle()[1].." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstyle()[3].." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end

    -- if (input == "'/fwtz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end
-- function week_translator3(input, seg)
    -- if (input == "'/fwn") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔*年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstyle()[1].." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstyle()[5].."曜日 "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstyle()[1].." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstyle()[3].." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

    -- if (input == "'/fwnz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstyle()[1].." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

--- 擴充模式 \r\n    日期 (年月日) ~d \r\n    年 ~y  月 ~m  日 ~day \r\n    年月 ~ym  月日 ~md \r\n    時間 (時分) ~n   (時分秒) ~t \r\n    日期時間 (年月日時分) ~dn\r\n    日期時間 (年月日時分秒) ~dt
    if(input=="'/") then
    -- if input:find("^'/$") then
      -- yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
      -- yield(Candidate("date", seg.start, seg._end, "║　d〔年月日〕┃   ym〔年月〕┃　md〔月日〕║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　y〔年〕　┃　　m〔月〕 ┃　　dy〔日〕 ║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　　n〔時:分〕　　 ┃　　　t〔時:分:秒〕　║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　dn〔年月日 時:分〕  ┃ dt〔年月日 時:分:秒〕║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║*/*/*〔 * 年 * 月 * 日〕┃　*-*-*〔*年*月*日〕 ║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　*/*〔 * 月 * 日〕   ┃　　 *-*〔*月*日〕　 ║" , ""))

      -- yield(Candidate("date", seg.start, seg._end, "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , ""))
      -- -- yield(Candidate("date", seg.start, seg._end, "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○○○〔數字〕" , ""))

      local date_table = {
        { '  f〔年月日〕  ym〔年月〕  md〔月日〕', '⓪' }
      , { '  y〔年〕  m〔月〕  d〔日〕  w〔週〕', '①' }
      , { '  n〔時:分〕  t〔時:分:秒〕', '②' }
      , { '  fw〔年月日週〕  mdw〔月日週〕', '③' }
      , { '  fn〔年月日 時:分〕  ft〔年月日 時:分:秒〕', '④' }
      , { '  p〔程式格式〕  z〔時區〕  s〔節氣〕  l〔月相〕', '⑤' }
      , { '  ○○○〔數字〕', '⑥' }
      , { '  ○/○/○〔 ○ 年 ○ 月 ○ 日〕  ○/○〔 ○ 月 ○ 日〕', '⑦' }
      , { '  ○-○-○〔○年○月○日〕  ○-○〔○月○日〕', '⑧' }
      , { '  / [a-z]+〔小寫字母〕', '⑨' }
      , { '  ; [a-z]+〔大寫字母〕', '⑩' }
      , { '  \' [a-z]+〔開頭大寫字母〕', '⑪' }
      , { '  x [0-9a-f]+〔內碼十六進制 Hex〕', '⑫' }
      , { '  c [0-9]+〔內碼十進制 Dec〕', '⑬' }
      , { '  o [0-7]+〔內碼八進制 Oct〕', '⑭' }
      -- , { '  e [0-9a-f]+〔Percent/URL encoding〕', '⑮' }
      , { '  v〔版本資訊〕', '⑮' }
      , { '======= 結束 =======', '⑯' }
      , { '', '⑰' }
      , { '', '⑱' }
      , { '', '⑲' }
      , { '', '⑳' }

      -- , { '〔夜思‧李白〕', '床前明月光，疑是地上霜。\r舉頭望明月，低頭思故鄉。' }
      }
      for k, v in ipairs(date_table) do
        local cand = Candidate('date', seg.start, seg._end, v[2], ' ' .. v[1])
        cand.preedit = input .. '\t《時間日期數字字母》▶'
        yield(cand)
      end
      return
    end

    if(input=="'//") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔小寫字母〕")
      cand2.preedit = input .. '\t《小寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="'/;") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔大寫字母〕")
      cand2.preedit = input .. '\t《大寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="'/'") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔開頭大寫字母〕")
      cand2.preedit = input .. '\t《開頭大寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="'/x") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔內碼十六進制 Hex〕")
      cand2.preedit = input .. '\t《內碼十六進制》▶'
      yield(cand2)
      return
    end

    if(input=="'/c") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9]+〔內碼十進制 Dec〕")
      cand2.preedit = input .. '\t《內碼十進制》▶'
      yield(cand2)
      return
    end

    if(input=="'/o") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-7]+〔內碼八進制 Oct〕")
      cand2.preedit = input .. '\t《內碼八進制》▶'
      yield(cand2)
      return
    end

    -- if(input=="'/e") then
    --   local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔Percent/URL encoding〕")
    --   cand2.preedit = input .. '\t《Percent/URL encoding》▶'
    --   yield(cand2)
    --   return
    -- end

    local englishout1 = string.match(input, "'//(%l+)$")
    if (englishout1~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, englishout1 , "〔一般字母小寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_l(englishout1) , "〔全形字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_1(englishout1) , "〔數學字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_2(englishout1) , "〔數學字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_3(englishout1) , "〔帶圈字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_4(englishout1) , "〔帶圈字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_5(englishout1) , "〔括號字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_6(englishout1) , "〔括號字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_7(englishout1) , "〔方框字母〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_8(englishout1) , "〔黑圈字母〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_9(englishout1) , "〔黑框字母〕"))
      return
    end

    local englishout2 = string.match(input, "'/'(%l+)$")
    if (englishout2~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, string.upper(string.sub(englishout2,1,1)) .. string.sub(englishout2,2,-1) , "〔一般字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_ul(englishout2) , "〔全形字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1_2(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3_4(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5_6(englishout2) , "〔帶圈字母開頭大寫〕"))
      return
    end

    local englishout3 = string.match(input, "'/;(%l+)$")
    if (englishout3~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, string.upper(englishout3) , "〔一般字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_u(englishout3) , "〔全形字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1(englishout3) , "〔數學字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3(englishout3) , "〔帶圈字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5(englishout3) , "〔括號字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_7(englishout3) , "〔方框字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_8(englishout3) , "〔黑圈字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_9(englishout3) , "〔黑框字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_s_u(englishout3) , "〔小型字母大寫〕"))
      return
    end

    local utf_input = string.match(input, "'/([xco][0-9a-f]+)$")
    if (utf_input~=nil) then
      -- if string.sub(input, 1, 2) ~= "'/" then return end
      local dict = { c=10, x=16, o=8 } --{ u=16 } --{ d=10, u=16, e=8 }
      local snd = string.sub(utf_input, 1, 1)
      local n_bit = dict[snd]
      if n_bit == nil then return end
      local str = string.sub(utf_input, 2)
      local c = tonumber(str, n_bit)
      if c == nil then return end
      local utf_x = string.match(utf_input, "^x")
      local utf_o = string.match(utf_input, "^o")
      local utf_c = string.match(utf_input, "^c")
      if ( utf_x ~= nil) then
        -- local fmt = "U"..snd.."%"..(n_bit==16 and "X" or snd)
        fmt = "  U+".."%X"
      elseif ( utf_o ~= nil) then
        fmt = "  0o".."%o"
      else
        fmt = "  &#".."%d"..";"
      end
      -- 單獨查找
      local cand_ui_s = Candidate("number", seg.start, seg._end, utf8_out(c), string.format(fmt, c) .. "  ( " .. url_encode(utf8_out(c)) .. " ）" )
      cand_ui_s.preedit = "'/" .. snd .. " " .. string.upper(string.sub(input, 4))
      yield(cand_ui_s)
      -- 區間查找
      -- if c*n_bit+n_bit-1 < 1048575 then
      --   for i = c*n_bit, c*n_bit+n_bit-1 do
      if c+16 < 1048575 then
        for i = c+1, c+16 do
          local cand_ui_m = Candidate("number", seg.start, seg._end, utf8_out(i), string.format(fmt, i) .. "  ( " .. url_encode(utf8_out(i)) .. " ）" )
          cand_ui_m.preedit = "'/" .. snd .. " " .. string.upper(string.sub(input, 4))
          yield(cand_ui_m)
        end
      end
    end


    -- local url_c_input = string.match(input, "'/e([0-9a-z][0-9a-f]*)$")
    -- if (url_c_input~=nil) then
    --   local u_1 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f])$")
    --   local u_2 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
    --   local u_3 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
    --   local u_4 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
    --   if (u_1 ~= nil) or (u_2 ~= nil) or (u_3 ~= nil) or (u_4 ~= nil) then
    --     url_c_input = url_c_input .. '0'
    --   end
    --   local url_10 = url_decode(url_c_input)
    --   local uc_i = string.upper(string.sub(input, 4, 5)) .. " " .. string.upper(string.sub(input, 6, 7)) .. " " .. string.upper(string.sub(input, 8, 9)) .. " " .. string.upper(string.sub(input, 10, 11)) .. " " .. string.upper(string.sub(input, 12, 13)) .. " " .. string.upper(string.sub(input, 14, 15))
    --   local uc_i = string.gsub(uc_i, " +$", "" )
    --   if string.match(url_10, "無此編碼") ~= nil then
    --     yield(Candidate("number", seg.start, seg._end, url_10, '' ))
    --   elseif string.match(url_c_input, "^[0-9a-z]$") ~= nil then
    --     local cand_uci_a = Candidate("number", seg.start, seg._end, url_10, url_10 )
    --     cand_uci_a.preedit = "'/e " .. uc_i
    --     yield(cand_uci_a)
    --   else
    --     -- local u_c = string.upper(url_c_input)
    --     -- local u_c = string.gsub(u_c, '^', '%%')
    --     -- local u_c = string.gsub(u_c, '^(%%..)(..)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(%%..%%..)(.+)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(%%..%%..%%..)(.+)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(%%..%%..%%..%%..)(.+)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(%%..%%..%%..%%..%%..)(.+)', '%1%%%2')
    --     -- local u_c = string.gsub(u_c, '^(..)(.?.?)(.?.?)(.?.?)(.?.?)(.?.?)$', '%%%1%%%2%%%3%%%4%%%5%%%6')
    --     -- local u_c = string.gsub(u_c, '[%%]+$', '')
    --     -- yield(Candidate("number", seg.start, seg._end, utf8_out(url_10), u_c ))
    --     local cand_uci_s = Candidate("number", seg.start, seg._end, utf8_out(url_10), url_encode(utf8_out(url_10)) )
    --     cand_uci_s.preedit = "'/e " .. uc_i
    --     yield(cand_uci_s)
    --   end
    --   -- if url_10*10+10-1 < 1048575 then
    --   --   for i = url_10*10, url_10*10+10-1 do
    --   if tonumber(url_10)+16 < 1048575 then
    --     for i = tonumber(url_10)+1, tonumber(url_10)+16 do
    --       local cand_uci_m = Candidate("number", seg.start, seg._end, utf8_out(i), url_encode(utf8_out(i)) )
    --       cand_uci_m.preedit = "'/e " .. uc_i
    --       yield(cand_uci_m)
    --     end
    --   end
    --   return
    -- end


    local y, m, d = string.match(input, "'/(%d+)/(%d?%d)/(%d?%d)$")
    if(y~=nil) and (tonumber(m)<13) and (tonumber(d)<32) then
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      if tonumber(y) > 1911 then
        yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(y).."年"..m.."月"..d.."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
      elseif tonumber(y) <= 1911 then
        yield(Candidate("date", seg.start, seg._end, "民國前"..min_guo(y).."年"..m.."月"..d.."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國前"..purech_number(min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國前"..read_number(confs[1], min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
      end
      -- yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      local jpymd2, jp_y2 = jp_ymd(y,m,d)
      yield(Candidate("date", seg.start, seg._end, jp_y2..m.."月"..d.."日" , "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d).." "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      if tonumber(y) > 1899 and tonumber(y) < 2101 then
        -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
        local ll_1b, ll_2b = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
        -- if(Date2LunarDate~=nil) then
        if(ll_1b~=nil) and (ll_2b~=nil) then
          yield(Candidate("date", seg.start, seg._end, ll_1b, "〔西曆→農曆〕"))
          yield(Candidate("date", seg.start, seg._end, ll_2b, "〔西曆→農曆〕"))
        end
      end
      if tonumber(y) > 1901 and tonumber(y) < 2101 then
        local All_g2, Y_g2, M_g2, D_g2 = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
        if(All_g2~=nil) then
          yield(Candidate("date", seg.start, seg._end, Y_g2.."年"..M_g2.."月"..D_g2.."日", "〔西曆→農曆干支〕"))
        end
        local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
        local LDD2D_leap_year  = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
        -- if(Date2LunarDate~=nil) then
        if(LDD2D~=nil) then
          yield(Candidate("date", seg.start, seg._end, LDD2D, "〔農曆→西曆〕"))
          yield(Candidate("date", seg.start, seg._end, LDD2D_leap_year, "〔農曆(閏)→西曆〕"))
        end
      end
      return
    end

    local m, d = string.match(input, "'/(%d?%d)/(%d?%d)$")
    if(m~=nil) and (tonumber(m)<13) and (tonumber(d)<32) then
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      return
    end

    local y, m, d = string.match(input, "'/(%d+)-(%d?%d)-(%d?%d)$")
    if(y~=nil) and (tonumber(m)<13) and (tonumber(d)<32) then
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      if tonumber(y) > 1911 then
        yield(Candidate("date", seg.start, seg._end, "民國"..min_guo(y).."年"..m.."月"..d.."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國"..purech_number(min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國"..read_number(confs[1], min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
      elseif tonumber(y) <= 1911 then
        yield(Candidate("date", seg.start, seg._end, "民國前"..min_guo(y).."年"..m.."月"..d.."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國前"..purech_number(min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
        yield(Candidate("date", seg.start, seg._end, "民國前"..read_number(confs[1], min_guo(y)).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔民國〕"))
      end
      -- yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      local jpymd2, jp_y2 = jp_ymd(y,m,d)
      yield(Candidate("date", seg.start, seg._end, jp_y2..m.."月"..d.."日" , "〔日本元号〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d).." "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      if tonumber(y) > 1899 and tonumber(y) < 2101 then
        -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
        local ll_1b, ll_2b = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
        -- if(Date2LunarDate~=nil) then
        if(ll_1b~=nil) and (ll_2b~=nil) then
          yield(Candidate("date", seg.start, seg._end, ll_1b, "〔西曆→農曆〕"))
          yield(Candidate("date", seg.start, seg._end, ll_2b, "〔西曆→農曆〕"))
        end
      end
      if tonumber(y) > 1901 and tonumber(y) < 2101 then
        local All_g2, Y_g2, M_g2, D_g2 = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
        if(All_g2~=nil) then
          yield(Candidate("date", seg.start, seg._end, Y_g2.."年"..M_g2.."月"..D_g2.."日", "〔西曆→農曆干支〕"))
        end
        local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
        local LDD2D_leap_year  = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
        -- if(Date2LunarDate~=nil) then
        if(LDD2D~=nil) then
          yield(Candidate("date", seg.start, seg._end, LDD2D, "〔農曆→西曆〕"))
          yield(Candidate("date", seg.start, seg._end, LDD2D_leap_year, "〔農曆(閏)→西曆〕"))
        end
        -- local chinese_date_input2 = to_chinese_cal(y, m, d)
        -- if(chinese_date_input2~=nil) then
        --   yield(Candidate("date", seg.start, seg._end, chinese_date_input2 .. " ", "〔農曆，可能有誤！〕"))
        -- end
      end
      return
    end

    local m, d = string.match(input, "'/(%d?%d)-(%d?%d)$")
    if(m~=nil) and (tonumber(m)<13) and (tonumber(d)<32) then
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      return
    end

    -- local numberout = string.match(input, "'//?(%d+)$")
    local numberout, dot1, afterdot = string.match(input, "'/(%d+)(%.?)(%d*)$")
    if (tonumber(numberout)~=nil) then
    -- if (numberout~=nil) and (tonumber(nn)~=nil) then
      local nn = string.sub(numberout, 1)
      --[[ 用 yield 產生一個候選項
      候選項的構造函數是 Candidate，它有五個參數：
      - type: 字符串，表示候選項的類型（可隨意取）
      - start: 候選項對應的輸入串的起始位置
      - _end:  候選項對應的輸入串的結束位置
      - text:  候選項的文本
      - comment: 候選項的注釋
      --]]
      yield(Candidate("number", seg.start, seg._end, numberout .. dot1 .. afterdot , "〔一般數字〕"))

      if (string.len(numberout) < 4) then
        yield(Candidate("number", seg.start, seg._end, "," , "〔千分位〕"))
      else
        -- local k = string.sub(numberout, 1, -1) -- 取參數
        local result = formatnumberthousands(numberout) --- 調用算法
        yield(Candidate("number", seg.start, seg._end, result .. dot1 .. afterdot , "〔千分位〕"))
      end

      yield(Candidate("number", seg.start, seg._end, string.format("%E", numberout .. dot1 .. afterdot ), "〔科學計數〕"))
      yield(Candidate("number", seg.start, seg._end, string.format("%e", numberout .. dot1 .. afterdot ), "〔科學計數〕"))
      yield(Candidate("number", seg.start, seg._end, math1_number(numberout) .. dot1 .. math1_number(afterdot), "〔數學粗體數字〕"))
      yield(Candidate("number", seg.start, seg._end, math2_number(numberout) .. dot1 .. math2_number(afterdot), "〔數學空心數字〕"))
      yield(Candidate("number", seg.start, seg._end, fullshape_number(numberout) .. dot1 .. fullshape_number(afterdot), "〔全形數字〕"))

      if (dot1~='.') then
        yield(Candidate("number", seg.start, seg._end, little1_number(numberout), "〔上標數字〕"))
        yield(Candidate("number", seg.start, seg._end, little2_number(numberout), "〔下標數字〕"))

        -- for _, conf in ipairs(confs) do
        --   local r = read_number(conf, nn)
        --   yield(Candidate("number", seg.start, seg._end, r, conf.comment))
        -- end
        yield(Candidate("number", seg.start, seg._end, read_number(confs[1], nn), confs[1].comment))
        yield(Candidate("number", seg.start, seg._end, read_number(confs[2], nn), confs[2].comment))

        if (string.len(numberout) < 2) then
          yield(Candidate("number", seg.start, seg._end, "元整", "〔純中文數字〕"))
        else
          yield(Candidate("number", seg.start, seg._end, purech_number(numberout), "〔純中文數字〕"))
        end

        yield(Candidate("number", seg.start, seg._end, military_number(numberout), "〔軍中數字〕"))

        yield(Candidate("number", seg.start, seg._end, circled1_number(numberout), "〔帶圈數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled2_number(numberout), "〔帶圈無襯線數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled3_number(numberout), "〔反白帶圈數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled4_number(numberout), "〔反白帶圈無襯線數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled5_number(numberout), "〔帶圈中文數字〕"))

        if (tonumber(numberout)==1) or (tonumber(numberout)==0) then
          yield(Candidate("number", seg.start, seg._end, string.sub(numberout, -1), "〔二進位〕"))
        else
          yield(Candidate("number", seg.start, seg._end, Dec2bin(numberout), "〔二進位〕"))
        end

        yield(Candidate("number", seg.start, seg._end, string.format("%o",numberout), "〔八進位〕"))
        yield(Candidate("number", seg.start, seg._end, string.format("%X",numberout), "〔十六進位〕"))
        yield(Candidate("number", seg.start, seg._end, string.format("%x",numberout), "〔十六進位〕"))
      elseif (dot1=='.') then
        yield(Candidate("number", seg.start, seg._end, military_number(numberout..dot1..afterdot), "〔軍中數字〕"))
      end
      return
    end

    -- -- 測試空白不上屏在 translator 中直接處理！
    -- -- local engine = env.engine
    -- -- local context = engine.context
    -- -- local kkk = string.match(o_input, "'/")
    -- -- local engine = env.engine
    -- -- local context = engine.context
    -- -- local o_input = context.input
    -- local kkk = string.match(input, "( )$")
    -- -- local page_size = engine.schema.page_size
    -- if (kkk~=nil) then --and (context:is_composing())
    --   -- local s_orig = context:get_commit_text()
    --   -- local o_input = context.input
    --   -- engine:commit_text(s_orig .. "a")
    --   -- context:clear()
    --   -- yield(Candidate("number", seg.start, seg._end, "nnnnnm", "〔千分位數字〕"))
    --   return 1 -- kAccepted
    -- end

  end
end




return { t_translator = t_translator, t2_translator = t2_translator }