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

return {
        ch_y_date = ch_y_date,
        ch_m_date = ch_m_date,
        ch_d_date = ch_d_date,
        ch_h_date = ch_h_date,
        ch_minsec_date = ch_minsec_date,
        chb_y_date = chb_y_date,
        chb_m_date = chb_m_date,
        chb_d_date = chb_d_date,
        chb_h_date = chb_h_date,
        chb_minsec_date = chb_minsec_date,
        jp_m_date = jp_m_date,
        jp_d_date = jp_d_date,
        eng1_m_date = eng1_m_date,
        eng2_m_date = eng2_m_date,
        eng3_m_date = eng3_m_date,
        eng1_d_date = eng1_d_date,
        eng2_d_date = eng2_d_date,
        eng3_d_date = eng3_d_date,
        eng4_d_date = eng4_d_date
        }