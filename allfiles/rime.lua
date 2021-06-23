-- Usage:
--  engine:
--    ...
--    translators:
--      ...
--      - lua_translator@lua_function3
--      - lua_translator@lua_function4
--      ...
--    filters:
--      ...
--      - lua_filter@lua_function1
--      - lua_filter@lua_function2
--    可掛接作用功能:
--      ...
--      - lua_translator@t_translator        -- 「`」開頭打出時間日期
--      - lua_translator@t2_translator       -- 「'/」開頭打出時間日期
--      - lua_translator@date_translator     -- 「``」開頭打出時間日期（沒用到，暫關閉）
--      - lua_translator@email_translator    -- 輸入email
--      - lua_translator@url_translator      -- 輸入網址
--      - lua_translator@urlw_translator     -- 輸入網址（多了www.）
--      - lua_translator@mytranslator        -- （有缺函數，參考勿用）
--
--      《 ＊ 以下濾鏡注意在 filters 中的順序 》
--      - lua_filter@charset_filter          -- 遮屏含 CJK 擴展漢字的候選項
--      - lua_filter@charset_filter_plus     -- 遮屏含 CJK 擴展漢字的候選項，開關（only_cjk_filter）
--      - lua_filter@charset_filter2         -- 遮屏選含「᰼᰼」候選項
--      - lua_filter@comment_filter_plus     -- 遮屏提示碼，開關（simplify_comment）
--      - lua_filter@charset_comment_filter  -- 為候選項註釋其所屬字符集，如：CJK、ExtA
--      - lua_filter@single_char_filter      -- 候選項重排序，使單字優先
--      - lua_filter@reverse_lookup_filter   -- 依地球拼音為候選項加上帶調拼音的註釋
--      - lua_filter@myfilter                -- （有不明函數，暫關閉）
--
--      - lua_processor@endspace             -- 韓語（非英語等）空格鍵後添加" "
--      - lua_processor@s2r_ss               -- 注音掛接 t2_translator 空白上屏產生莫名空格去除（只有開頭 ^'/ 才作用，比下條目更精簡，少了 is_composing 限定）
--      - lua_processor@s2r_s                -- 注音掛接 t2_translator 空白上屏產生莫名空格去除（只有開頭 ^'/ 才作用）
--      - lua_processor@s2r                  -- 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin(1,2,4)和 plus 用）
--      - lua_processor@s2r3                 -- 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin3 (特殊正則)專用）
--      - lua_processor@s2r_e_u              -- 注音掛接 t2_translator 空白上屏產生莫名空格去除（只針對 email 和 url ）
--      ...



-- 內碼輸入法
--[[
收入 unicode 碼得出該碼字元
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
    number = { [0] = "零", "一", "二", "三", "四", "五", "六", "七", "八", "九" },
    suffix = { [0] = "", "十", "百", "千" },
    suffix2 = { [0] = "", "萬", "億", "兆", "京" }
  },
  {
    comment = "〔大寫中文數字〕",
    number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖" },
    suffix = { [0] = "", "拾", "佰", "仟" },
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
      s = conf.number[d] .. conf.suffix[i] .. s
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




--[[
轉換農曆月相等各種函數
--]]
-- Celestial algorithms and data derived from https://ytliu0.github.io/ChineseCalendar/sunMoon.html
local moon_data = {{0,4,6,6,6,5,4,3,4,5,3,7,3,6,3,3,4,3,5,6,5,5,5,1,4,2}, {1,5,6,6,6,5,3,4,2,4,5,3,7,5,5,6,4,5,5,4,6,3,5,4,3,5}, {0,4,4,5,5,4,6,2,6,3,5,6,5,6,7,6,6,6,3,6,1,4,3,4,5}, {0,5,5,3,3,2,5,3,8,5,8,6,6,6,5,6,7,7,6,6,2,4,1,4,5,4}, {1,5,4,3,3,2,1,5,3,6,6,6,6,5,4,6,4,6,5,5,5,4,5,5,5,5}, {0,6,3,6,3,4,4,4,4,4,4,4,5,4,5,2,5,1,5,4,6,7,7,7,7,6}, {1,3,7,2,8,4,6,5,5,4,4,3,4,5,3,6,2,4,2,4,5,6,7,7,6}, {1,4,5,3,6,5,8,7,6,5,4,3,4,3,4,5,4,4,3,3,4,5,4,6,3,7}, {0,4,6,7,6,6,7,5,6,6,3,7,1,5,2,4,3,4,5,5,5,5,4,2,5,1}, {1,7,5,7,7,6,4,4,4,3,6,3,7,2,5,4,4,6,5,6,7,6,4,4,1}, {1,5,3,6,6,6,5,4,2,3,3,4,7,4,6,6,5,6,5,4,6,4,6,3,4,4}, {0,4,4,5,4,5,5,3,7,4,7,6,6,7,7,7,8,6,5,6,1,5,1,5,4,4}, {1,5,4,3,3,2,1,6,2,7,5,7,5,5,6,6,6,7,7,5,6,1,4,3,5,6}, {0,5,4,4,1,2,2,1,5,4,6,5,4,4,5,4,7,4,6,6,5,5,5,4,5}, {0,5,4,6,2,6,2,4,3,3,4,4,4,4,5,3,6,2,5,3,6,6,6,6,7,5}, {1,4,5,2,6,3,7,6,6,4,3,3,3,4,3,5,1,4,1,4,4,5,6,7,6,6}, {0,5,4,6,4,7,7,7,7,5,3,4,1,3,3,3,4,2,3,3,3,4,5,4,7,3}, {1,6,5,5,6,6,5,6,5,4,5,2,6,2,4,3,3,5,5,6,6,6,3,6,1}, {1,7,4,7,7,6,6,5,3,3,5,3,7,2,6,2,4,4,4,5,6,5,5,4,2,5}, {0,2,6,7,7,7,6,4,5,3,4,6,5,7,5,6,5,4,5,5,3,5,2,4,3,3}, {1,4,5,4,6,5,4,6,3,7,4,6,5,5,7,7,7,6,6,3,6,0,4,3,5,5}, {0,5,4,4,2,2,4,3,8,4,7,6,6,6,6,6,8,7,7,6,3,5,1,4,5}, {0,5,5,4,3,3,2,2,5,4,7,6,7,6,6,5,7,5,7,6,6,6,4,5,5,4}, {1,5,4,3,5,1,5,4,5,5,4,5,6,6,5,6,2,6,2,6,4,6,6,6,6,5}, {0,5,3,6,2,7,5,7,5,5,4,4,4,4,5,3,5,1,3,1,3,5,5,6,7,5}, {1,5,5,3,7,5,7,6,5,5,4,2,4,3,4,4,4,5,4,5,5,4,4,6,3}, {1,7,4,5,5,5,5,5,5,5,5,3,6,2,5,2,4,4,5,6,6,6,5,6,2,6}, {0,2,7,6,8,6,6,4,4,4,4,6,3,7,3,4,4,3,5,5,6,7,5,3,5,1}, {1,5,4,7,7,6,5,5,3,4,3,4,6,4,6,5,4,5,5,4,6,3,6,4,4}, {1,5,4,5,5,4,4,5,3,6,2,5,4,5,6,6,6,7,6,5,5,1,5,2,5,4}, {0,5,5,4,3,3,2,2,6,3,8,5,6,5,5,6,7,7,8,7,5,5,1,4,3,5}, {1,6,5,4,4,2,2,3,3,6,5,6,6,5,5,6,4,6,4,7,5,5,6,4,5,6}, {0,6,5,6,3,7,3,5,5,5,5,5,4,5,5,2,6,1,5,2,5,5,6,7,6}, {0,5,4,6,2,7,4,9,6,6,5,4,3,4,4,4,6,3,4,2,4,3,5,6,6,5}, {1,5,3,3,5,3,7,7,7,7,5,4,5,2,4,3,4,5,4,5,5,4,4,5,3,6}, {0,3,6,5,6,6,6,6,7,6,6,7,3,6,2,5,3,3,5,6,5,6,5,2,5,1}, {1,6,4,8,6,6,6,4,3,4,5,4,8,3,6,3,3,4,4,6,7,6,5,4,2}, {1,5,2,6,6,6,6,5,3,4,2,4,5,4,7,5,5,5,4,5,5,3,6,3,4,4}, {0,3,5,4,4,5,4,4,6,3,6,4,5,6,6,7,8,8,7,6,4,6,1,5,3,5}, {1,5,4,4,3,2,2,4,3,7,4,7,5,5,6,6,6,8,8,7,7,3,5,2,5,6}, {0,5,6,4,2,3,2,2,5,4,6,5,5,6,4,4,6,4,7,5,6,6,5,6,6}, {0,6,5,6,3,6,2,5,3,4,4,4,5,5,5,4,6,2,6,2,6,5,6,8,7,6}, {1,6,5,4,7,3,8,5,7,5,5,4,4,4,5,5,3,5,1,4,2,4,5,6,6,7}, {0,5,5,6,4,7,6,8,8,7,6,5,3,5,3,5,4,3,4,3,4,4,4,4,6,4}, {1,7,4,7,6,6,7,7,6,6,5,4,6,2,5,2,4,4,4,6,6,6,5,5,2}, {1,6,3,7,7,7,7,6,5,5,4,4,7,3,6,2,4,3,4,5,6,6,7,4,3,4}, {0,2,5,5,6,7,6,5,5,3,5,4,5,7,6,6,6,5,5,5,4,6,2,5,3,4}, {1,4,4,5,5,4,4,5,3,7,3,7,5,6,7,6,7,8,6,5,6,1,6,2,5}, {1,5,5,5,4,3,2,2,1,6,3,7,5,6,5,5,6,7,6,7,7,5,5,1,5,4}, {0,5,6,5,4,3,1,2,2,3,6,4,6,6,5,5,5,4,7,5,7,6,6,6,5,6}, {1,6,5,4,5,2,6,2,4,4,4,5,5,5,5,5,4,7,2,5,3,6,6,6,7,6}, {0,6,4,5,3,8,5,9,6,6,6,4,4,5,5,5,6,2,4,2,4,4,5,7,7}, {0,5,6,4,4,6,4,8,7,8,7,5,4,5,2,5,3,5,4,3,4,4,5,5,6,5}, {1,7,4,6,5,6,6,5,6,6,6,5,6,3,5,1,4,3,4,5,5,6,6,5,3,6}, {0,3,8,5,8,7,7,6,6,4,5,6,4,8,3,6,3,4,5,4,6,6,6,5,5,3}, {1,5,3,7,7,7,7,6,4,5,3,5,5,5,7,5,6,5,4,5,5,3,6,3,5}, {1,5,4,6,5,5,6,5,4,7,3,7,4,6,6,5,7,7,7,7,6,3,5,0,5,4}, {0,5,6,5,4,3,3,2,4,3,7,4,7,5,6,7,6,7,9,9,7,7,3,5,3,5}, {1,6,5,5,4,1,3,1,2,5,4,6,6,5,6,6,5,7,4,8,6,6,6,5,6,6}, {0,5,6,5,4,6,2,5,4,5,6,5,5,6,6,5,6,3,5,2,5,4,6,7,6}, {0,6,6,4,3,6,3,8,6,8,6,4,4,4,4,5,6,4,6,1,4,2,4,6,6,6}, {1,6,5,4,4,3,7,5,7,7,6,5,4,3,4,3,5,5,4,5,4,4,5,4,4,6}, {0,3,7,4,6,6,5,7,6,5,6,6,4,7,2,5,2,4,4,5,6,7,6,5,4,2}, {1,6,3,7,6,8,6,6,5,5,5,5,6,4,7,2,4,4,3,6,6,6,6,5,4}, {1,5,3,7,6,8,8,7,5,5,3,5,3,4,6,4,6,5,5,5,5,4,6,3,5,4}, {0,5,5,5,5,6,4,5,5,3,7,2,6,4,6,7,7,7,8,7,6,6,2,7,2,6}, {1,6,6,6,4,3,2,3,2,6,3,8,5,6,6,5,7,8,7,9,7,5,6,2,5,6}, {0,7,8,6,5,5,2,4,4,3,7,6,6,6,5,5,6,5,7,4,7,5,5,6,5}, {0,6,7,5,5,7,4,7,3,6,5,5,6,5,5,6,6,4,6,1,5,3,6,6,7,7}, {1,6,5,4,6,3,8,5,8,6,7,5,5,4,5,5,5,6,3,5,1,4,4,5,7,6}, {0,5,5,3,4,6,5,8,7,8,7,6,6,5,4,5,5,6,5,4,5,4,4,4,5}, {0,4,6,3,6,4,5,6,6,6,7,7,6,7,3,6,2,5,3,4,5,5,6,6,5,4}, {1,6,3,7,5,8,7,7,6,6,4,5,6,4,7,2,6,1,4,4,5,6,6,5,5,4}, {0,3,5,3,7,6,7,7,5,4,4,3,5,6,5,7,6,6,6,5,6,6,4,7,3,5}, {1,4,4,5,5,4,5,4,3,5,2,6,3,6,6,7,7,8,7,8,7,4,7,2,7}, {1,4,7,7,6,4,4,2,2,4,3,7,4,6,5,5,5,6,7,9,8,7,7,3,6,4}, {0,6,7,6,7,5,2,3,1,2,4,4,6,5,5,5,5,4,6,5,7,5,6,7,6,7}, {1,6,6,6,6,4,6,3,6,3,5,5,5,5,6,5,4,5,2,5,2,6,5,7,8,7}, {0,7,5,5,4,6,4,9,6,8,7,5,6,5,5,6,5,5,6,2,3,2,4,6,6}, {0,7,6,4,5,5,4,8,7,9,8,7,7,5,4,5,3,5,4,4,4,3,4,5,4,5}, {1,6,4,7,5,7,7,7,8,7,6,6,6,5,6,1,5,2,4,4,5,5,6,5,4,4}, {0,2,6,3,8,6,8,8,7,6,6,5,5,7,4,7,3,4,4,4,6,6,6,6,4,3}, {1,4,2,6,5,7,8,6,6,5,4,6,5,6,7,6,7,6,6,5,5,4,6,3,6}, {1,3,5,5,4,5,5,5,5,5,4,7,3,7,5,7,7,8,8,8,7,5,6,2,7,2}, {0,7,6,6,5,5,2,3,2,2,6,3,7,4,5,6,5,7,8,8,9,8,5,7,3,7}, {1,6,7,7,5,3,3,1,2,3,3,6,4,5,5,5,5,6,5,7,5,7,5,6,7,6}, {0,6,6,6,5,6,3,6,3,6,5,5,6,6,6,7,6,4,7,2,6,3,6,7,7}, {0,7,6,4,4,5,3,8,5,9,6,6,5,5,5,5,6,6,6,3,5,2,5,5,5,7}, {1,7,5,5,4,4,6,4,9,7,8,7,6,4,4,2,5,3,4,5,4,5,4,5,6,6}, {0,4,7,4,7,5,7,6,6,6,7,6,6,6,3,6,1,5,3,5,6,6,6,6,5}, {0,4,5,3,8,5,9,8,7,6,6,5,6,6,5,7,3,6,2,4,5,4,6,6,5,5}, {1,4,4,6,5,8,9,8,8,7,5,6,4,6,6,6,7,5,5,6,5,4,5,3,6,3}, {0,6,5,5,6,6,5,6,5,5,7,3,7,3,6,6,6,8,8,8,7,7,3,6,2,6}, {1,4,7,6,5,4,4,2,2,5,3,7,3,6,5,5,6,7,7,9,7,7,6,4,6}, {1,4,6,6,6,6,4,2,3,2,3,5,4,6,5,5,7,6,5,6,4,7,5,6,6,6}, {0,6,6,5,6,5,3,6,2,6,4,5,5,5,6,6,6,5,6,3,5,1,6,5,7,7}, {1,7,6,6,4,4,7,3,8,5,7,5,5,5,4,5,6,6,4,5,1,4,2,5,6,6}, {0,7,6,4,4,4,3,7,6,8,7,6,6,5,4,6,3,6,5,5,6,4,5,5,5}, {0,5,6,4,6,4,7,6,6,7,7,7,7,6,5,7,2,5,3,5,5,6,7,7,5,5}, {1,4,3,6,5,9,7,9,8,6,5,6,5,6,7,4,6,3,5,3,4,6,5,6,6,4}, {0,4,4,3,6,6,8,8,6,5,5,3,5,4,5,7,6,6,6,6,7,5,5,6,4,6}, {1,5,5,6,5,5,6,4,5,5,3,6,3,6,4,6,7,7,7,9,7,6,6,2,7}, {1,3,7,7,7,7,5,3,3,3,3,7,4,7,4,6,5,6,7,8,7,8,7,5,7,3}, {0,7,6,7,7,6,5,4,2,4,4,4,6,5,6,6,4,5,6,5,7,4,7,5,6,7}, {1,7,6,8,6,5,7,3,7,3,6,5,5,5,5,5,6,5,4,5,1,6,3,6,6}, {1,6,7,6,5,4,5,3,7,5,9,6,6,7,5,6,7,6,7,6,4,5,2,4,4,6}, {0,7,6,4,4,3,4,5,5,8,7,8,7,6,5,5,4,6,4,6,5,5,5,5,5,6}, {1,6,5,6,3,7,5,7,7,6,7,7,7,7,7,4,6,2,5,3,5,6,6,6,5,4}, {0,3,6,3,8,6,9,7,7,6,6,5,6,7,5,7,4,5,3,4,5,5,7,6,5}, {0,5,4,3,6,4,7,7,7,7,6,3,5,3,6,5,6,7,5,6,7,5,5,6,4,6}, {1,3,6,4,5,6,5,5,6,5,5,6,3,7,3,6,6,6,7,8,8,8,6,3,6,2}, {0,7,5,6,6,6,4,3,2,3,4,3,7,3,6,4,5,6,6,8,8,7,7,6,4,7}, {1,5,7,8,7,7,5,3,4,2,4,4,4,6,5,4,5,4,5,6,4,7,5,6,7}, {1,6,7,7,6,7,6,4,6,2,6,4,5,5,5,6,7,6,6,6,2,6,2,6,6,7}, {0,8,7,6,5,5,4,6,3,8,6,8,6,6,6,6,6,7,6,5,5,2,4,3,5,7}, {1,6,7,7,5,6,5,5,8,6,9,8,7,6,5,4,6,3,5,4,4,5,4,4,5,4}, {0,6,6,4,7,4,7,7,7,8,8,7,7,7,6,7,3,6,2,5,5,6,6,6,5}, {0,4,4,3,6,4,8,7,8,7,6,5,6,6,6,7,4,7,3,5,4,5,7,6,6,5}, {1,3,3,4,2,6,6,8,8,7,7,6,5,6,6,7,7,6,7,6,6,6,5,4,6,2}, {0,6,4,5,5,5,5,5,5,5,6,4,7,3,7,4,6,7,8,7,8,7,6,6,2}, {0,7,3,8,7,6,6,4,3,3,3,3,5,3,6,3,5,5,5,7,7,8,8,7,5,6}, {1,4,7,7,7,7,5,3,4,1,3,3,4,6,5,6,6,5,6,6,5,8,4,8,6,6}, {0,7,6,6,6,5,4,6,3,7,3,6,4,4,5,6,6,6,6,5,6,2,7,4,7,7}, {1,7,8,6,5,4,5,4,8,5,8,6,6,6,4,5,6,6,6,6,4,5,3,5,6}, {1,6,7,7,5,5,3,4,6,4,8,7,7,7,5,4,4,3,5,4,5,6,5,6,6,5}, {0,6,6,5,7,3,7,5,6,7,6,6,7,6,6,6,3,5,1,4,3,5,6,6,6,5}, {1,5,3,6,3,8,6,9,9,8,8,6,6,6,7,6,7,3,5,3,4,4,5,6,5,4}, {0,5,3,3,5,5,8,8,8,8,6,5,6,4,6,6,6,6,6,5,6,5,5,5,4}, {0,6,3,6,5,5,5,6,5,6,5,5,6,3,6,3,5,5,6,7,8,8,7,6,4,6}, {1,2,7,5,7,6,5,4,4,2,3,5,3,7,4,6,4,5,7,7,8,9,7,6,6,4}, {0,6,5,7,7,6,6,5,2,3,2,4,6,5,6,5,6,6,5,5,7,5,8,5,6,6}, {1,6,7,7,6,6,6,4,7,3,6,4,6,6,5,6,6,6,6,5,3,5,2,6,5}, {1,7,8,7,5,5,4,3,6,3,8,4,6,6,5,6,5,6,7,6,6,5,3,5,4,6}, {0,7,6,7,5,3,3,4,4,6,5,8,7,6,6,5,5,5,3,6,5,6,6,5,5,5}, {1,4,6,6,4,7,4,7,6,7,7,7,7,7,6,6,6,3,6,2,5,5,6,7,6,4}, {0,4,4,2,6,3,9,7,8,7,7,6,6,5,6,7,5,6,3,4,4,4,7,6,6}, {0,5,4,4,4,4,7,6,8,8,6,6,5,3,5,4,5,5,5,6,5,5,6,5,5,6}, {1,4,6,4,5,5,5,6,6,4,5,5,3,6,2,7,4,6,7,7,8,8,7,6,6,3}, {0,7,4,8,7,7,6,4,3,4,3,4,5,3,7,3,5,5,5,6,7,7,8,6,5}, {0,7,4,8,7,8,9,6,5,4,2,4,4,4,5,4,5,5,4,6,5,4,6,3,6,5}, {1,6,7,7,6,7,6,5,6,3,7,3,5,4,4,6,6,6,7,6,5,5,1,6,3,7}, {0,7,6,7,5,4,3,4,3,7,4,8,5,5,6,5,5,7,6,6,6,4,5,2,5,6}, {1,6,8,6,4,5,3,4,5,5,8,7,7,7,5,5,5,4,6,3,5,4,4,5,4}, {1,4,5,5,4,6,3,7,5,7,7,6,8,7,7,6,6,4,5,2,5,3,4,6,5,6}, {0,5,4,3,5,3,8,5,8,7,7,6,5,5,6,6,6,7,4,5,3,4,5,4,6,5}, {1,4,3,2,2,5,4,7,7,7,7,5,5,5,4,6,6,6,7,6,6,6,5,6,5,4}, {0,5,2,5,4,5,5,6,5,5,4,4,6,3,6,3,6,6,6,8,9,8,8,7,5}, {0,7,3,8,6,8,8,6,4,4,2,4,5,3,6,3,5,4,4,6,6,7,8,6,6,6}, {1,4,7,6,8,8,7,6,5,2,3,2,4,4,4,6,5,5,6,5,5,7,5,7,5,7}, {0,7,7,8,8,6,6,5,4,6,3,5,4,4,5,5,6,7,6,6,6,3,5,2,7,6}, {1,8,9,7,6,5,4,4,6,5,8,6,7,6,5,6,6,6,6,6,5,5,1,4,3}, {1,5,8,7,7,6,3,4,5,5,8,6,8,7,6,6,5,4,5,3,6,4,5,5,4,5}, {0,6,4,5,5,4,6,4,7,6,7,7,7,7,7,6,6,5,2,5,1,5,4,5,6,5}, {1,4,3,3,2,6,4,8,6,8,7,7,7,6,6,7,7,5,7,3,5,4,4,6,5,5}, {0,5,2,3,3,2,6,6,7,7,6,6,6,5,7,5,7,7,6,6,6,6,6,5,4}, {0,6,3,6,3,6,5,5,5,6,5,5,6,4,6,2,6,3,6,7,7,8,7,7,5,5}, {1,2,7,4,7,7,6,5,4,2,3,3,3,5,2,6,3,5,5,5,8,8,7,7,6,5}, {0,7,4,7,7,7,7,5,4,3,1,2,2,3,5,4,5,5,4,6,6,5,6,4,7}, {0,5,6,7,6,6,7,5,5,6,3,6,2,5,4,5,6,5,6,7,5,4,5,1,6,4}, {1,7,7,7,7,6,4,4,4,3,7,4,8,5,5,5,4,6,5,5,6,6,3,5,3,6}, {0,6,6,8,6,5,4,3,4,5,5,8,6,6,6,4,5,4,3,5,3,5,4,5,6,5}, {1,5,6,5,5,6,3,7,5,7,7,7,8,8,7,7,6,4,6,2,5,3,5,6,5}, {1,6,4,3,2,4,2,7,5,9,8,7,7,7,6,7,7,7,7,4,5,2,4,5,4,6}, {0,5,4,4,3,3,5,5,8,8,8,7,6,6,6,4,6,5,6,7,6,6,5,5,6,5}, {1,3,5,3,5,5,5,6,5,6,6,5,4,6,3,6,3,6,6,6,8,9,7,7,5,3}, {0,5,3,7,5,7,7,5,4,4,3,3,4,3,6,3,5,4,5,6,6,8,7,7,6}, {0,5,4,7,5,7,8,6,7,5,2,4,3,4,5,5,6,5,5,6,5,5,5,4,6,4}, {1,6,6,5,7,6,5,6,5,3,6,3,6,4,4,5,5,6,7,6,6,5,3,5,2,7}, {0,7,7,8,7,5,4,3,3,5,3,7,4,6,5,4,5,4,5,6,5,5,4,2,5,4}, {1,6,7,6,6,5,2,4,3,4,7,6,7,7,6,6,4,5,6,4,6,4,4,5,4}, {1,5,5,4,5,4,3,6,3,6,5,6,7,7,7,7,6,5,6,2,6,2,5,5,6,6}, {0,5,4,4,3,2,6,4,8,7,8,7,6,6,6,6,6,6,4,6,2,4,4,5,6,5}, {1,5,4,3,3,3,3,6,5,7,7,6,6,4,4,6,4,6,5,6,7,6,6,6,5,5}, {0,6,3,6,4,5,5,5,5,5,5,4,4,3,5,2,5,3,5,6,7,7,7,6,6}, {0,5,3,7,5,8,8,8,6,5,3,3,4,4,5,3,5,2,4,4,4,6,6,6,6,5}, {1,4,6,4,7,8,8,9,6,5,4,2,4,3,4,5,4,5,5,4,5,4,3,6,3,6}, {0,5,6,7,6,6,7,5,5,5,3,6,2,4,3,4,5,5,6,6,5,4,5,1,5,3}, {1,6,6,6,6,5,4,3,4,3,7,4,8,5,6,6,5,6,7,6,6,5,3,4,2}, {1,5,6,5,6,5,4,4,2,4,5,5,8,6,7,7,5,5,5,4,6,3,5,4,5,5}, {0,5,5,6,4,4,5,3,7,5,6,6,6,7,7,7,7,6,4,5,1,5,3,5,6,5}, {1,6,5,2,3,3,2,6,5,7,6,6,7,5,6,7,7,7,7,4,6,3,5,6,5}, {1,6,5,3,3,1,2,4,4,6,7,5,6,4,5,5,4,7,5,6,7,6,6,7,5,5}, {0,5,3,6,2,5,4,5,5,5,5,5,5,5,5,2,6,2,5,5,7,7,7,7,6,5}, {1,3,5,3,7,6,8,7,5,4,3,3,3,4,3,5,2,4,3,4,6,5,7,7,6,5}, {0,6,4,7,6,8,8,7,6,4,3,3,1,3,4,4,5,4,4,5,4,5,6,4,6}, {0,5,7,6,7,7,6,5,6,4,4,6,2,6,3,4,5,5,6,6,6,5,4,2,5,2}, {1,7,6,7,8,6,5,5,3,3,6,4,8,4,6,5,4,5,5,6,6,5,4,4,2,4}, {0,4,6,8,7,7,5,3,4,4,4,7,5,7,6,5,6,4,4,4,3,5,3,4,5,4}, {1,5,5,4,5,4,3,6,3,6,5,6,7,7,7,8,6,6,6,2,5,2,5,5,5}, {1,7,5,3,2,1,1,5,3,7,5,7,7,6,7,6,6,7,7,5,6,3,5,4,4,6}, {0,5,5,4,1,2,3,2,6,5,7,7,5,6,5,4,6,4,6,5,5,6,5,5,5,4}, {1,4,4,3,5,3,5,4,5,5,5,5,5,5,3,5,1,5,2,5,6,7,8,7,6,4}, {0,5,2,7,5,8,7,6,6,4,3,3,3,3,4,2,4,2,4,4,4,6,6,6,6}, {0,5,4,6,4,7,6,7,7,5,4,3,2,4,3,4,5,4,5,5,4,5,5,4,6,3}, {1,6,4,6,6,6,6,6,5,5,5,2,5,2,5,4,4,6,6,6,6,5,4,5,1,6}, {0,5,7,8,7,7,5,4,3,4,4,7,4,6,4,4,4,3,5,5,6,6,5,3,5,3}, {1,6,7,7,8,6,4,4,2,3,5,5,7,6,6,6,4,6,4,4,6,4,5,5,5}, {1,6,5,5,6,4,4,5,2,6,4,6,7,6,7,8,7,7,6,3,5,1,4,3,5,7}, {0,6,5,4,3,3,3,3,7,5,9,7,7,8,6,6,7,6,7,6,3,4,2,4,5,4}, {1,6,4,2,3,1,2,4,4,7,7,6,7,5,5,5,4,6,5,6,6,5,6,6,5}, {1,5,5,3,6,2,6,4,5,6,5,5,5,4,4,4,2,5,1,4,4,6,7,7,7,6}, {0,4,3,5,2,7,5,7,7,5,5,4,3,4,5,4,5,2,4,3,3,6,6,7,7,5}, {1,5,4,3,6,4,7,8,5,6,4,3,3,2,4,4,4,6,4,4,6,4,5,5,3,6}, {0,3,6,6,6,7,7,5,6,4,4,5,1,4,2,4,4,5,6,6,5,5,5,2,5}, {0,2,7,6,7,8,6,4,4,2,3,4,2,7,3,5,5,4,6,5,7,7,5,5,4,2}, {1,5,4,6,8,5,5,4,2,4,2,4,6,4,6,6,5,6,4,5,5,3,5,3,5,5}, {0,5,5,6,4,5,4,3,5,3,7,5,6,6,7,7,7,6,6,5,1,4,1,5,5,5}, {1,6,4,3,3,1,2,4,3,7,6,7,6,5,6,6,6,7,6,5,5,3,5,4,5}, {1,7,5,6,3,2,3,2,3,6,5,6,6,5,5,3,3,5,3,6,5,6,5,5,6,6}, {0,4,4,5,3,6,3,5,4,5,5,5,5,5,4,3,5,2,4,3,5,6,7,7,6,5}, {1,4,4,3,6,4,9,7,7,6,4,3,4,4,4,5,3,5,2,3,4,4,6,6,5,6}, {0,4,4,6,5,8,8,8,9,5,4,4,2,4,2,4,5,4,4,5,3,5,4,4,5}, {0,3,6,4,5,7,6,6,7,5,5,5,3,5,2,5,3,4,6,5,6,7,5,4,4,1}, {1,5,3,7,8,6,6,5,2,3,3,3,6,4,7,4,4,5,4,7,6,5,6,4,3,5}, {0,3,5,6,6,7,5,4,3,2,4,5,5,7,6,6,7,4,6,4,4,5,2,4,4}, {0,4,5,5,4,6,4,4,5,2,6,3,5,6,6,7,7,6,7,6,4,5,1,4,3,5}, {1,7,5,4,3,2,2,2,2,5,3,6,6,5,5,5,6,7,6,7,6,4,5,3,4,6}, {0,5,6,4,2,2,0,2,3,3,6,6,6,6,4,4,5,4,6,4,7,7,6,6,6,4}, {1,5,3,3,4,2,5,3,4,4,4,4,5,4,4,5,2,4,1,5,4,6,7,7,7}, {1,6,4,3,5,3,8,5,7,7,5,5,3,3,3,4,3,4,1,3,2,3,6,5,6,6}, {0,4,5,4,4,7,5,8,8,6,6,3,2,3,1,3,3,4,4,4,4,5,4,5,5,4}, {1,6,4,6,6,6,7,6,5,5,5,3,5,2,5,2,3,4,4,6,6,5,5,3,2,4}, {0,2,7,7,8,8,6,6,5,4,4,5,4,6,4,5,5,3,5,4,5,5,3,3,3}, {0,2,5,5,6,8,6,7,4,3,4,3,4,5,5,6,6,4,5,3,4,4,2,5,3,4}, {1,4,4,4,5,3,5,4,3,6,3,6,5,5,6,6,7,7,5,5,5,1,4,2,5,5}, {0,4,5,3,2,1,1,1,4,3,7,6,7,7,5,7,6,6,8,6,5,5,3,5,4,5}, {1,7,4,3,3,0,1,1,2,5,5,6,7,5,6,4,4,5,4,6,5,6,6,6,5}, {1,6,4,5,5,2,5,2,5,4,4,5,5,4,5,4,4,4,1,5,2,5,6,6,7,7}, {0,4,4,4,2,5,3,7,6,6,6,3,3,3,3,4,4,3,4,2,4,5,4,7,6,6}, {1,5,3,3,4,3,7,7,7,7,4,4,3,2,4,2,4,5,4,5,5,4,6,4,4,5}, {0,4,6,5,5,7,6,6,7,5,5,5,3,5,1,3,3,3,6,5,6,6,4,4,4}, {0,1,6,4,8,8,7,7,5,3,3,4,3,6,3,6,3,3,4,3,6,5,5,5,4,3}, {1,5,3,6,7,6,7,5,3,3,2,3,4,4,6,5,5,5,3,4,4,3,5,2,4,4}, {0,5,6,6,4,5,3,4,5,3,6,3,6,6,6,7,7,6,7,5,4,5,1,4,3}, {0,4,6,5,5,3,1,1,3,2,6,4,7,6,6,7,5,6,7,6,7,5,3,5,3,5}, {1,7,5,7,3,2,2,1,2,4,4,6,6,5,6,3,4,4,3,5,4,5,6,5,5,5}, {0,5,5,3,3,4,2,5,3,5,5,4,5,5,4,5,4,2,5,2,4,4,5,8,6,6}, {1,5,3,2,4,2,7,5,7,6,5,5,3,4,4,4,4,5,2,4,2,3,6,4,6}, {1,5,3,4,3,3,6,6,8,8,6,6,4,3,3,2,3,3,3,5,4,4,4,3,4,4}, {0,3,5,3,6,6,6,6,6,5,6,4,4,5,1,4,2,3,4,5,6,6,5,5,4,2}, {1,4,2,7,7,8,7,6,5,4,2,3,4,2,6,3,4,4,2,5,4,5,5,4,3,3}, {0,2,4,5,6,7,5,6,4,3,4,2,5,5,6,6,6,5,6,4,5,4,3,5,3}, {0,3,5,5,4,5,3,5,4,3,5,3,6,4,6,7,7,7,8,6,6,5,2,5,2,6}, {1,6,6,6,4,2,2,1,2,4,2,7,5,5,6,4,6,6,6,7,6,5,5,2,5,5}, {0,5,7,4,5,3,0,1,1,2,5,4,5,6,5,6,3,4,5,4,6,6,6,7,6,5}, {1,6,4,4,4,3,5,2,4,4,4,5,4,5,5,4,4,5,1,4,3,5,6,6,7}, {1,6,5,4,4,3,7,5,9,8,7,7,4,5,4,3,5,4,3,4,1,2,4,3,6,5}, {0,5,4,3,3,5,4,8,7,8,8,4,5,4,2,4,3,4,4,4,5,4,4,5,3,4}, {1,4,2,5,4,5,6,6,6,6,5,5,4,3,4,1,3,3,3,5,5,6,5,4,3,3}, {0,1,5,4,7,7,6,6,4,3,4,4,4,6,3,6,4,3,5,3,6,4,5,4,3}, {0,1,4,3,5,7,6,7,4,3,3,2,4,4,5,7,5,6,6,3,5,4,3,4,2,4}, {1,4,4,5,5,4,5,3,3,4,2,5,3,5,5,5,7,6,6,6,5,3,4,1,5,4}, {0,5,6,5,4,2,1,1,1,1,5,3,5,5,4,6,5,6,7,6,7,5,4,5,3}, {0,5,7,5,6,3,1,1,0,1,3,3,5,5,5,6,3,4,4,3,6,4,5,6,6,7}, {1,6,5,6,4,3,5,3,6,4,5,5,4,5,5,4,5,4,2,4,1,4,4,5,7,6}, {0,6,5,4,2,4,3,7,6,7,7,5,5,3,3,4,3,3,4,1,3,2,4,7,5,7}, {1,5,4,4,3,3,6,5,7,7,6,7,3,3,3,2,3,3,3,4,4,3,5,3,5}, {1,4,4,6,4,6,6,7,7,6,6,7,5,5,5,3,4,2,3,4,4,6,5,5,4,2}, {0,1,4,2,6,7,8,8,6,5,4,4,5,5,4,5,3,4,4,2,6,4,5,4,3,3}, {1,3,2,5,6,7,8,6,6,5,3,5,3,5,5,5,6,6,4,6,3,5,4,2,4,3}, {0,4,4,4,4,5,3,5,3,3,5,3,6,5,5,7,6,7,8,7,6,5,3,4,2}, {0,5,5,5,6,4,2,1,0,0,3,3,6,4,5,6,5,7,6,7,7,6,5,6,3,5}, {1,5,5,7,5,5,2,0,1,2,2,5,4,6,7,4,6,4,4,5,4,5,5,5,6,5}, {0,5,6,4,4,4,2,5,2,4,4,4,4,5,5,5,4,4,3,2,4,2,5,7,7,7}, {1,6,4,4,3,2,6,4,7,6,5,6,3,4,3,3,3,4,3,3,2,4,4,4,7}, {1,5,5,4,2,2,3,3,7,7,7,8,4,5,3,2,4,2,4,4,4,4,5,4,5,4}, {0,4,5,3,5,4,6,6,6,6,6,5,5,4,3,4,1,3,3,3,5,5,6,5,4,3}, {1,4,3,6,5,8,9,7,6,5,4,3,4,4,5,3,4,2,2,4,2,5,4,4,4}, {1,3,2,4,3,6,7,6,8,4,4,3,2,4,4,4,6,6,5,6,3,5,4,3,4,2}, {0,5,4,5,5,5,4,5,3,3,4,2,5,3,5,5,5,7,7,7,7,5,3,4,1,5}, {1,4,6,7,5,5,4,2,2,3,2,5,4,6,6,5,7,5,7,6,6,6,4,2,5,3}, {0,5,7,5,6,4,2,2,1,2,3,4,6,5,4,6,3,4,5,3,5,4,5,6,6}, {0,6,6,5,5,3,3,5,2,5,3,4,5,5,5,5,4,5,3,3,4,1,4,5,6,8}, {1,6,5,5,2,2,4,2,7,6,7,7,5,7,4,5,5,4,5,4,2,3,3,3,6,4}, {0,6,5,3,3,2,2,5,5,7,8,6,7,4,3,3,3,4,3,4,4,4,5,5,4,5}, {1,4,3,5,3,6,5,6,6,7,5,6,5,4,5,2,4,2,3,4,4,6,5,5,4}, {1,3,1,4,3,6,7,8,7,6,5,4,3,4,5,4,6,4,4,4,4,6,5,6,5,3}, {0,3,3,2,5,5,6,7,6,5,3,3,4,3,4,5,6,6,7,5,7,4,5,5,3,5}, {1,3,5,5,5,5,6,4,5,3,3,5,3,5,4,5,6,6,7,8,6,6,5,2,5,3}, {0,5,7,6,7,4,2,2,1,1,4,2,6,4,4,5,4,7,5,7,7,6,5,6,4}, {0,6,7,7,8,5,4,2,0,2,1,2,5,4,5,6,4,5,3,4,5,3,5,4,6,6}, {1,6,6,7,4,5,4,3,5,3,5,4,5,5,5,6,6,5,4,4,1,4,2,4,6,5}, {0,7,6,4,4,3,3,6,4,8,7,6,7,4,5,4,4,5,4,3,4,2,3,4,4,7}, {1,4,5,4,2,3,4,5,7,7,7,8,4,5,3,2,4,3,3,3,4,4,4,4,5}, {1,4,4,4,3,5,4,5,6,6,6,7,5,6,5,3,4,2,4,3,3,6,5,6,5,3}, {0,3,3,2,5,5,7,7,6,6,4,4,4,4,5,6,4,5,4,3,5,4,6,4,4,4}, {1,3,2,4,4,6,7,6,8,4,4,4,2,4,5,6,6,6,6,7,4,6,4,3,3,2}, {0,4,4,4,5,5,4,6,2,4,4,2,5,2,4,5,5,8,8,7,7,6,4,5,2}, {0,5,4,6,8,5,4,3,0,1,2,1,5,2,5,4,4,6,5,7,7,6,6,5,4,5}, {1,5,6,8,6,7,4,2,2,0,3,3,4,6,5,5,7,4,6,4,4,6,4,6,6,6}, {0,7,7,5,6,4,4,4,2,5,3,4,5,5,5,6,5,5,3,3,4,2,4,5,6}, {0,9,7,6,5,3,3,4,3,7,6,7,6,4,6,3,4,4,4,4,3,2,4,4,4,7}, {1,5,7,5,3,3,3,3,5,5,7,8,5,7,4,5,4,3,4,3,4,5,5,5,6,3}, {0,5,4,4,5,3,6,6,7,7,7,5,7,5,6,4,3,4,2,4,5,5,6,5,5,4}, {1,2,2,4,4,7,8,9,8,7,6,6,5,5,5,5,6,3,4,5,3,6,4,5,4}, {1,2,3,2,2,4,6,7,8,5,6,4,3,4,3,5,5,6,7,6,5,7,4,5,4,3}, {0,5,3,4,4,4,4,5,3,4,3,3,5,2,4,4,5,7,6,8,8,6,6,4,3,4}, {1,2,6,6,6,6,3,2,1,1,2,4,3,6,4,5,6,4,8,6,6,7,5,4,5,3}, {0,6,7,6,8,4,4,2,0,1,1,2,4,5,5,6,4,6,3,4,5,3,5,5,6}, {0,7,6,6,6,4,5,4,3,5,2,4,4,4,5,5,4,6,4,4,4,1,4,2,5,7}, {1,6,8,6,4,3,2,2,5,4,7,6,6,7,3,5,4,4,6,4,3,4,3,4,6,5}, {0,8,4,5,3,2,3,3,3,6,7,7,7,4,5,3,3,4,2,4,5,5,5,5,5,6}, {1,4,5,4,3,6,5,6,7,7,7,7,6,7,4,4,4,1,3,3,4,6,5,6,5}, {1,4,3,3,3,6,5,8,9,7,7,5,5,4,4,5,5,3,4,4,3,6,4,7,4,5}, {0,4,3,3,4,4,6,8,6,8,5,5,4,2,4,4,5,6,6,6,6,4,6,3,3,4}, {1,2,4,5,5,5,6,5,6,4,5,5,3,5,4,5,6,6,8,7,7,7,5,3,4}, {1,1,5,5,6,7,5,5,4,1,2,3,4,5,4,6,5,4,7,5,7,7,6,6,5,4}, {0,5,5,6,8,6,8,4,2,3,1,3,4,4,6,6,5,7,4,5,4,3,5,3,5,6}, {1,6,6,7,5,6,3,3,4,2,5,4,5,5,5,6,7,5,6,4,3,4,2,5,5,6}, {0,8,6,5,4,2,2,4,3,7,5,7,7,4,7,4,5,6,5,5,4,2,4,4,5}, {0,7,5,7,5,3,3,3,3,6,6,8,8,6,7,4,5,3,2,4,3,5,5,5,5,6}, {1,3,5,3,4,5,3,6,5,6,7,7,6,6,5,5,4,2,3,3,4,5,5,8,6,5}, {0,4,2,2,3,4,7,7,7,8,5,6,4,4,5,4,4,5,3,4,5,3,7,4,6,4}, {1,2,2,2,3,5,6,7,8,5,7,4,4,5,4,6,5,6,7,7,5,7,4,5,4}, {1,3,5,3,5,5,5,5,5,4,6,3,3,5,2,4,4,5,7,6,8,8,6,7,5,3}, {0,6,4,7,8,7,8,5,3,3,1,2,3,3,5,3,3,5,3,7,6,6,6,5,5,5}, {1,4,7,8,7,9,6,5,3,1,2,2,3,5,5,6,6,3,7,3,5,5,4,5,5,6}, {0,7,6,6,8,5,5,4,3,5,3,5,5,4,6,6,6,6,5,5,4,2,4,3,5}, {0,7,6,8,6,5,4,3,4,7,5,8,7,6,7,4,6,4,5,5,4,3,4,2,3,5}, {1,5,8,5,5,4,3,3,4,5,7,7,8,8,5,6,4,4,4,3,4,4,5,6,5,5}, {0,6,3,4,3,3,5,5,6,6,6,7,7,6,7,5,5,4,2,3,3,4,7,5,6,5}, {1,3,2,3,2,5,6,8,9,7,8,5,6,5,5,6,6,5,5,4,3,6,4,7,4}, {1,4,3,2,2,4,4,6,8,7,8,5,5,4,4,5,5,6,7,7,6,7,5,7,4,4}, {0,4,3,5,4,5,5,6,4,6,3,4,3,2,4,3,5,6,5,8,8,7,8,5,5,4}, {1,3,6,6,7,8,5,5,2,2,2,2,3,5,4,4,6,4,7,5,8,7,7,7,5,4}, {0,6,6,6,8,5,7,4,2,2,0,2,3,4,6,6,4,7,4,6,5,4,5,5,6}, {0,7,7,7,8,6,7,4,4,5,3,5,3,5,5,5,6,6,5,6,4,3,4,2,5,6}, {1,6,9,7,6,5,3,3,4,4,7,6,6,7,4,6,4,5,5,4,5,4,3,4,5,6}, {0,9,6,8,5,3,4,2,4,6,6,8,7,5,7,3,4,3,2,4,3,4,5,5,5}, {0,7,4,6,4,5,5,4,6,7,7,8,7,8,8,6,6,5,3,4,2,3,5,5,7,5}, {1,4,3,2,2,4,4,8,8,9,9,6,7,5,6,6,6,5,6,4,4,5,4,7,4,5}, {0,4,2,2,3,2,5,6,6,9,5,8,4,5,4,3,5,6,5,7,6,6,7,4,5,4}, {1,3,4,3,5,4,4,5,5,3,6,4,4,4,3,5,4,5,7,6,9,8,7,6,4}, {1,3,5,4,7,7,7,7,4,3,2,1,2,4,4,5,4,4,6,5,8,5,7,6,5,5}, {0,5,4,7,8,7,10,6,5,3,1,3,2,3,4,4,6,6,4,7,3,4,4,3,6,5}, {1,5,7,7,6,8,4,6,4,3,5,3,5,5,4,6,6,7,7,5,6,4,2,5,4,6}, {0,9,7,8,6,3,3,3,2,6,4,6,6,5,7,3,6,4,6,6,5,5,5,4,4}, {0,7,6,8,5,6,4,2,4,4,5,7,7,7,9,5,7,3,4,4,4,5,5,5,6,6}, {1,4,6,4,5,4,4,6,5,6,7,7,8,8,6,8,5,4,4,2,4,3,5,7,6,7}, {0,5,3,3,3,3,6,6,8,9,7,8,5,6,5,5,5,6,4,5,4,4,6,4,8,4}, {1,5,3,2,2,4,4,6,8,6,8,4,6,4,4,5,6,6,7,7,7,8,5,7,3}, {1,5,4,3,5,4,6,6,5,5,6,4,5,4,3,4,3,5,5,6,9,8,8,8,5,4}, {0,4,3,6,6,8,9,7,6,4,2,3,3,4,5,4,4,5,4,7,5,8,6,6,6,5}, {1,4,5,5,7,9,6,8,4,4,3,1,2,4,4,5,6,5,8,4,6,5,5,6,5}, {1,6,7,7,7,7,4,6,4,4,4,2,5,4,4,6,4,6,7,5,7,4,3,4,3,5}, {0,7,7,9,6,5,4,3,2,4,3,7,6,7,7,5,8,4,6,6,5,5,3,3,3,4}, {1,5,9,6,7,4,3,3,3,4,6,6,8,8,6,8,4,6,4,3,4,4,5,5,6,5}, {0,7,4,7,4,5,5,4,6,5,6,7,6,6,7,5,6,4,3,4,2,4,5,5,8}, {0,6,5,4,1,2,4,3,7,8,7,8,6,7,5,5,7,6,6,5,5,5,6,4,8,4}, {1,7,4,2,2,2,3,5,6,6,9,6,7,4,4,5,4,6,5,6,7,7,6,8,5,6}, {0,5,4,6,4,5,6,6,6,7,5,6,4,5,4,3,4,3,5,7,7,8,8,7,6,4}, {1,3,6,5,7,9,7,8,5,4,3,3,3,4,3,4,4,4,7,4,8,6,8,7,5}, {1,5,6,5,7,9,8,10,5,6,3,2,2,2,3,4,5,6,7,4,7,4,5,5,4,5}, {0,5,6,7,8,7,8,5,7,5,4,6,4,5,5,5,7,7,7,7,5,5,4,2,4,4}, {1,6,8,7,9,5,4,4,4,4,6,5,7,7,5,7,4,7,5,5,6,4,4,4,4,5}, {0,7,6,10,5,5,4,2,3,4,6,8,7,7,9,4,7,4,4,4,3,4,4,4,6}, {0,6,4,6,3,5,4,3,5,5,7,7,7,8,8,8,8,6,6,4,3,4,5,5,7,5}, {1,6,5,3,2,1,2,4,6,7,8,7,8,6,7,7,6,7,6,5,5,4,4,7,5,7}, {0,4,5,3,2,2,3,5,6,8,7,9,4,6,4,4,5,5,6,7,7,7,8,4,7,4}, {1,5,5,4,5,5,5,6,6,4,6,4,5,3,3,4,3,5,6,7,9,8,8,9,6}, {1,5,5,4,6,7,8,9,6,6,3,2,2,3,3,4,4,4,5,4,8,5,9,7,6,6}, {0,5,4,6,7,8,9,7,9,4,5,3,2,3,4,4,5,5,5,7,3,6,4,4,5,4}, {1,6,7,6,7,8,6,7,4,5,4,3,5,4,4,5,5,7,6,6,6,4,3,3,3}, {1,6,8,8,10,7,7,5,3,3,5,4,6,5,6,7,3,7,4,6,5,5,4,3,3,4}, {0,6,6,9,6,8,5,4,4,3,4,6,7,8,9,6,9,4,6,4,3,4,3,4,5,5}, {1,5,6,4,6,3,5,5,5,7,7,7,8,8,8,8,6,8,5,4,4,3,4,5,5,7}, {0,5,4,3,2,3,4,5,8,9,8,10,7,8,6,6,6,6,6,5,4,4,6,4,8}, {0,4,7,3,2,1,1,3,5,7,7,9,5,9,4,6,4,4,5,6,7,7,8,7,9,5}, {1,6,4,3,4,3,5,5,5,6,6,5,6,4,5,4,3,4,4,5,8,7,9,9,6,6}, {0,4,3,5,5,7,8,7,8,5,4,3,3,4,4,4,5,5,4,7,4,8,5,7,6,5}, {1,4,4,4,7,8,8,10,6,7,4,3,3,3,4,5,5,6,7,5,7,4,6,4,5}, {1,6,6,6,8,8,7,8,4,6,4,3,4,3,4,4,4,6,6,6,7,5,5,3,3,4}, {0,5,6,10,7,9,6,4,3,3,3,5,5,6,6,5,7,4,7,5,6,6,5,4,4,4}, {1,6,8,6,9,5,6,3,2,3,4,5,7,8,7,9,4,7,4,5,4,4,5,5,6,6}, {0,7,6,8,4,6,5,5,5,5,7,8,7,8,8,7,8,5,5,3,2,3,4,4,8}, {0,6,8,5,3,3,2,3,5,6,8,9,7,8,5,7,6,6,6,5,5,5,4,4,8,5}, {1,9,5,5,3,2,2,3,5,7,8,6,9,4,6,4,4,5,5,6,6,7,7,8,5,8}, {0,4,5,4,4,5,5,6,7,6,6,7,4,6,4,4,4,3,5,5,5,9,8,7,6,4}, {1,3,4,3,6,7,8,9,7,7,5,4,4,4,4,5,4,3,4,3,7,5,8,6,6}, {1,5,4,4,5,7,7,10,7,9,5,4,3,3,2,4,4,5,6,4,7,4,7,4,5,5}, {0,4,6,7,7,7,8,6,6,4,5,4,4,5,4,5,6,5,7,7,6,7,4,4,4,3}, {1,5,8,7,9,6,6,4,3,3,4,4,6,6,6,8,4,8,5,8,6,5,4,4,3}, {1,4,6,6,10,6,8,5,4,4,3,4,6,6,7,9,5,8,3,6,4,4,4,4,5,5}, {0,5,6,7,4,6,3,5,5,4,6,6,6,8,7,7,9,6,7,5,5,4,4,5,8,6}, {1,9,5,5,3,1,2,3,4,6,7,7,9,6,8,5,7,7,6,7,6,5,5,6,5,9}, {0,5,7,4,2,2,2,4,6,7,7,10,6,9,4,5,4,4,6,6,7,7,8,6,8}, {0,4,7,4,4,5,4,5,6,6,6,7,5,6,4,5,3,2,4,4,5,7,7,9,8,7}, {1,6,5,4,6,6,8,9,8,9,5,5,4,3,4,3,3,3,3,3,6,4,9,5,7,6}, {0,5,4,5,6,7,9,8,11,6,8,3,3,3,3,4,5,6,6,8,5,7,4,5,4,3}, {1,5,5,6,8,7,7,8,5,6,5,4,5,3,4,5,4,7,6,8,8,5,6,3,3}, {1,4,5,7,9,8,9,6,5,4,3,4,6,6,7,7,4,7,4,7,5,5,5,4,4,4}, {0,4,5,8,6,10,5,6,4,3,4,4,6,7,8,7,9,4,8,4,5,4,4,4,5,5}, {1,7,6,5,6,3,4,3,3,4,4,5,7,7,8,9,7,9,6,6,4,3,4,5,5,8}, {0,6,7,5,2,3,2,3,5,5,7,9,6,9,5,7,6,7,7,5,5,5,5,5,7}, {0,4,9,4,4,3,1,2,3,4,6,8,6,9,4,6,4,4,5,5,6,6,7,7,8,6}, {1,8,4,6,5,4,5,5,5,6,5,5,6,3,6,3,4,3,3,3,6,6,9,7,8,7}, {0,4,5,4,4,6,7,8,9,6,6,4,4,4,3,4,4,4,3,5,4,8,5,9,6,6}, {1,5,4,4,6,6,8,10,7,9,4,5,3,2,3,4,4,5,6,5,8,4,6,3,5}, {1,5,5,6,7,7,8,8,6,8,4,6,5,3,4,4,3,5,4,7,6,6,7,3,4,3}, {0,4,6,8,8,11,8,7,5,3,4,4,5,6,5,5,7,4,8,4,7,6,5,4,4,4}, {1,5,7,6,11,6,9,4,4,3,3,4,6,6,7,9,5,9,3,7,4,4,4,3,4}, {1,6,6,6,8,4,7,3,5,5,5,6,7,7,9,8,8,9,6,7,4,3,4,3,3,7}, {0,5,8,5,4,3,1,2,3,5,7,8,7,9,6,9,6,7,7,6,7,6,5,4,6,5}, {1,9,5,7,3,2,2,1,3,4,6,6,9,5,8,4,6,4,4,6,5,6,7,7,6,8}, {0,5,7,3,4,4,4,5,6,5,6,6,5,7,4,6,4,4,4,4,5,8,7,9,7}, {0,6,5,4,3,4,5,7,8,7,8,4,5,3,4,4,4,4,4,5,4,6,4,9,5,7}, {1,5,4,3,4,5,7,9,8,10,5,7,3,3,2,2,3,4,5,5,7,4,8,3,6,4}, {0,4,5,6,6,7,8,7,7,4,7,4,4,4,3,4,4,4,8,6,8,8,5,6,4,3}, {1,4,6,7,10,7,8,5,4,4,3,4,4,4,5,6,3,8,3,8,5,6,5,4,4}, {1,4,5,6,9,7,10,5,7,4,3,4,5,6,7,7,6,9,4,8,3,5,3,3,4,5}, {0,5,6,6,5,7,3,6,4,4,5,6,6,7,6,8,8,7,8,4,5,3,2,3,5,5}, {1,10,6,7,5,3,3,1,3,5,5,6,9,5,9,4,7,6,6,6,5,4,4,5,4,8}, {0,5,9,4,4,2,1,2,3,5,7,8,6,9,4,7,4,5,5,5,6,6,6,7,8}, {0,5,7,3,5,3,3,5,5,6,6,6,6,7,4,7,4,4,4,3,4,6,5,9,7,8}, {1,6,4,3,3,4,6,7,8,10,6,8,5,4,4,3,4,4,4,3,5,3,7,4,9,5}, {0,5,4,3,3,5,6,7,10,7,9,4,6,3,3,4,4,4,5,6,5,8,4,7,3,4}, {1,4,4,6,6,6,7,7,5,7,3,5,4,4,4,4,4,7,5,8,7,7,6,4,4}, {1,4,4,6,8,7,10,7,6,5,4,4,5,5,5,5,5,7,3,8,4,7,5,4,4,3}, {0,3,4,7,6,10,5,9,4,4,3,3,4,6,6,7,8,6,9,4,7,4,4,4,5,4}, {1,6,6,6,7,4,6,3,5,4,4,4,5,5,7,7,8,9,7,8,4,4,3,3,5}, {1,7,6,9,5,3,3,0,2,2,4,6,7,6,9,5,8,5,7,7,6,6,6,5,5,7}, {0,6,10,5,7,2,2,2,1,3,4,6,6,9,5,8,3,6,3,4,5,6,7,7,7,7}, {1,9,4,7,4,4,4,4,5,6,5,6,6,5,7,4,5,2,2,3,3,4,7,6,9,8}, {0,6,6,4,4,5,6,8,9,6,9,4,6,3,4,4,3,4,4,4,3,7,4,9,5}, {0,7,5,4,3,4,5,7,9,7,10,5,8,3,4,2,2,3,5,5,5,7,4,8,3,6}, {1,3,4,5,5,6,8,8,7,9,6,8,5,5,5,4,4,4,4,7,5,8,6,4,5,2}, {0,2,4,6,7,10,7,9,6,5,5,4,5,5,5,4,6,3,7,2,8,4,6,4,4,3}, {1,3,5,5,8,6,10,5,6,3,3,3,4,4,6,7,6,8,4,8,3,4,3,3,3}, {1,5,5,6,6,4,7,2,5,2,4,5,5,6,8,6,9,8,8,10,6,6,4,3,3,5}, {0,5,8,5,6,4,2,2,0,2,4,6,6,8,5,9,5,9,6,7,7,5,5,5,6,5}, {1,9,5,9,4,4,2,1,2,2,4,6,8,5,9,4,7,3,5,4,5,5,7,7,7,8}, {0,5,8,3,5,3,3,4,5,4,6,5,5,6,4,6,3,4,3,3,4,7,6,10,8}, {0,8,6,4,3,3,3,5,7,7,9,5,7,3,4,4,3,4,4,4,3,5,4,9,5,9}, {1,5,5,4,4,4,5,7,7,11,7,10,4,6,3,3,2,4,3,5,6,5,8,3,7,4}, {0,5,5,5,5,7,7,8,8,6,8,4,6,4,3,3,3,3,6,4,8,6,6,6,3,3}, {1,3,4,6,9,8,10,7,7,5,4,4,4,4,5,5,3,7,3,8,3,7,4,4,4}, {1,2,3,4,7,7,10,5,9,4,5,4,3,4,6,7,7,8,5,9,3,7,3,3,3,4}, {0,3,5,4,5,6,3,6,3,5,4,4,6,6,5,9,6,9,9,7,8,5,4,4,3,5}, {1,8,6,8,4,4,2,1,2,2,4,6,7,5,9,4,8,5,7,7,6,5,4,5,5}, {1,7,5,9,4,6,3,1,1,1,2,4,5,6,9,5,8,3,7,4,5,5,5,6,8,7}, {0,6,8,4,6,3,4,3,3,4,5,4,6,5,5,7,3,5,3,3,3,4,4,8,6,9}, {1,7,5,4,2,3,4,6,7,8,7,9,4,7,4,4,4,3,4,3,4,3,7,3,9,4}, {0,6,4,4,3,3,4,6,9,7,10,5,7,3,4,2,2,3,4,5,5,7,5,8,3}, {0,6,4,4,4,6,5,7,6,7,7,4,6,3,4,3,2,1,3,3,6,5,8,7,4,4}, {1,2,2,4,6,7,10,7,10,5,5,4,3,5,5,5,4,5,3,8,3,8,4,6,4,3}, {0,3,3,4,6,9,6,11,5,7,4,3,4,4,5,6,7,6,8,3,8,3,5,3,3,4}, {1,5,5,6,7,5,7,3,6,3,4,5,4,5,7,5,8,8,8,8,5,5,2,2,4}, {1,5,6,9,6,7,4,1,2,1,3,4,5,6,8,4,9,4,8,6,7,7,5,5,5,6}, {0,6,9,5,10,4,4,1,1,2,2,4,6,7,5,9,3,7,3,5,4,5,5,6,6,7}, {1,8,5,8,4,5,3,4,4,6,5,7,6,7,7,5,7,3,4,2,2,3,6,5,9,6}, {0,7,5,3,3,2,4,5,8,7,10,5,8,4,5,4,3,4,3,3,2,5,3,8,4}, {0,9,4,5,3,2,3,5,6,7,9,6,9,3,6,2,3,3,3,4,5,5,4,8,4,6}, {1,2,5,3,4,5,6,6,7,7,6,7,4,6,4,4,3,4,3,7,4,8,6,6,5,2}, {0,3,2,4,5,8,7,10,6,7,4,3,4,4,5,4,5,3,6,3,9,4,7,4,4,3}, {1,3,2,4,7,6,11,5,8,3,4,3,2,4,5,5,6,8,4,9,3,7,3,3,3}, {1,4,3,6,5,5,6,2,6,2,4,3,3,4,4,4,7,7,9,9,7,8,4,4,4,4}, {0,4,8,6,8,4,4,2,-1,1,1,3,5,6,4,8,3,9,5,7,7,6,6,4,4,5}, {1,8,6,11,5,7,2,2,2,2,2,4,5,5,8,3,8,3,6,3,3,4,5,5,7,7}, {0,7,9,4,7,3,5,4,4,5,5,4,6,6,5,7,3,5,2,2,2,3,4,8,6}, {0,10,7,5,5,3,3,4,6,7,8,5,9,4,6,3,3,3,3,3,3,4,2,7,3,9}, {1,4,7,3,3,3,4,5,6,9,7,11,5,9,2,4,3,3,3,4,5,5,6,3,7,2}, {0,5,2,3,3,5,5,7,7,7,8,6,8,4,6,4,3,2,4,3,7,5,7,6,3}, {0,4,1,2,3,6,6,10,7,9,6,5,5,4,5,4,5,3,6,2,7,2,8,4,5,3}, {1,2,2,3,4,5,8,6,10,4,6,2,4,4,4,5,6,7,6,10,4,9,3,5,3,3}, {0,3,4,4,5,5,4,6,2,5,2,3,3,4,4,6,5,9,8,8,9,6,5,3,3,4}, {1,6,5,10,6,7,3,1,2,1,2,3,4,4,7,3,9,4,8,6,6,6,4,4,4}, {1,6,5,9,5,10,3,4,1,0,1,2,3,5,7,4,8,2,7,3,5,4,5,5,7,7}, {0,7,8,5,8,3,5,2,3,3,4,4,5,4,5,6,4,6,2,4,2,2,2,6,5,10}, {1,7,7,6,3,2,2,3,5,7,6,9,4,8,3,5,3,4,4,3,3,2,5,3,9,4}, {0,9,4,5,2,2,3,5,6,7,10,6,10,3,6,2,3,2,3,4,4,5,5,8,4}, {0,8,3,5,4,5,5,7,6,8,8,6,7,4,6,3,4,2,3,1,5,3,7,6,5,5}, {1,2,3,2,4,5,8,7,11,6,7,5,4,4,3,4,4,5,3,7,3,9,3,7,4,4}, {0,2,1,2,3,6,6,10,5,8,3,5,2,3,3,5,5,7,8,5,9,3,7,2,4,2}, {1,4,3,6,5,5,6,3,7,2,5,3,4,3,5,4,7,6,8,8,6,7,3,3,3}, {1,3,4,8,5,9,4,3,2,0,1,2,3,4,5,4,7,3,8,5,7,6,6,5,4,4}, {0,4,8,5,11,4,7,1,2,1,1,1,3,4,4,8,3,8,2,6,3,4,4,5,5,7}, {1,7,5,8,4,6,2,4,3,3,4,6,4,6,6,6,7,4,6,3,3,2,4,3,8,5}, {0,8,5,5,4,1,2,3,5,6,8,5,9,4,7,4,5,4,3,4,3,3,2,8,3}, {0,10,4,7,3,2,2,3,4,6,8,6,10,3,7,2,4,1,3,3,4,4,5,6,4,7}, {1,3,6,2,4,4,5,5,7,6,7,7,5,7,3,5,3,4,1,4,3,8,5,8,6,3}, {0,4,2,3,3,5,5,10,6,9,5,6,4,3,5,4,5,3,5,3,8,2,8,4,6}, {0,3,2,2,3,4,6,9,6,11,4,8,3,4,3,4,5,6,7,5,8,3,8,2,5,2}, {1,4,4,4,4,6,6,5,7,2,6,3,4,2,3,3,6,4,8,7,8,8,4,5,2,3}, {0,3,7,6,10,6,7,3,1,2,0,2,3,4,4,6,2,8,3,9,6,6,6,4,4,4}, {1,5,5,10,5,10,3,4,1,1,1,3,4,5,7,5,9,3,7,3,5,3,4,4,5}, {1,5,6,7,4,7,2,5,2,4,4,4,4,6,4,6,6,5,7,3,4,2,3,2,6,4}, {0,10,6,7,4,2,2,1,3,4,7,5,9,4,8,2,5,3,3,4,2,3,2,5,2,9}, {1,4,9,3,4,1,1,2,4,5,6,9,5,9,3,6,1,4,3,4,3,5,5,4,7,3}, {0,7,2,5,3,3,3,5,5,6,6,6,7,4,7,2,4,2,3,1,6,3,8,5,5}, {0,4,1,2,2,4,4,8,7,10,6,7,4,5,4,4,4,3,4,2,7,2,8,2,7,3}, {1,3,1,1,2,3,6,5,10,4,8,2,4,2,2,3,4,5,5,8,5,9,3,7,2,4}, {0,3,4,3,5,5,5,6,2,6,2,4,1,3,2,4,3,7,5,8,8,7,7,3,4,3}, {1,5,4,8,6,9,4,4,2,0,2,2,4,4,5,3,7,2,8,4,7,5,5,4,3}, {1,3,5,7,5,11,4,8,2,2,1,2,2,4,4,5,7,3,8,1,5,2,4,3,5,4}, {0,7,7,7,9,4,8,3,4,3,4,3,5,4,6,4,5,7,3,5,1,2,1,3,3,8}, {1,6,9,6,4,4,1,3,3,5,6,8,5,9,3,7,3,5,4,4,4,2,3,2,7}, {1,3,9,4,6,2,2,2,2,4,6,8,6,10,4,9,2,6,2,3,3,4,4,5,6,4}, {0,7,2,6,1,4,3,5,5,8,7,8,8,6,8,4,6,2,3,1,4,2,7,4,7,5}, {1,3,3,0,2,2,5,5,10,6,9,5,6,4,4,5,4,4,3,5,2,8,3,9,4,6}, {0,2,2,1,2,3,4,8,5,10,3,7,2,3,2,3,4,6,6,6,9,4,8,2,6}, {0,2,3,3,4,4,5,5,3,6,1,5,2,4,2,4,3,6,5,8,8,8,9,5,5,2}}
local sun_data = {{6,6,6,6,5,7,6,7,6,7,5,7,6,7,8,9,10,10,10,10,9,8,7,5}, {4,3,4,3,5,5,8,8,11,11,11,11,11,10,8,8,7,7,6,7,7,8,6,8}, {6,8,6,7,6,7,7,7,7,7,7,7,6,5,5,3,3,2,4,3,6,7,9,8}, {9,8,8,5,4,3,2,1,1,1,0,2,1,4,3,5,4,6,6,8,7,8,8,9}, {9,8,7,5,5,3,3,1,2,1,3,3,6,6,8,8,8,8,7,6,6,6,6,6}, {5,6,6,7,6,6,5,6,5,6,4,5,5,6,6,5,5,5,4,3,3,2,3,3}, {5,5,7,7,10,9,10,8,7,6,4,3,1,0,0,1,1,2,1,3,3,5,5,6}, {5,6,6,6,6,6,5,5,4,2,2,-1,-1,-1,0,0,2,2,5,5,6,7,7,7}, {6,5,4,3,3,3,2,4,3,5,4,5,4,5,5,5,4,5,4,6,6,6,6,5}, {6,4,5,4,5,4,6,6,7,8,8,8,9,7,6,5,3,3,1,1,0,3,3,5}, {6,8,8,9,9,8,8,7,7,5,5,4,4,3,4,2,3,1,1,0,2,2,5,4}, {6,7,8,8,7,8,6,6,3,4,2,2,3,4,4,6,7,7,7,7,6,6,6,5}, {5,4,5,4,6,4,5,5,6,6,7,7,8,9,10,11,11,11,10,10,9,9,6,6}, {4,5,3,4,5,6,7,8,9,10,11,11,11,11,10,9,10,8,9,7,9,8,8,8}, {8,7,8,7,8,9,8,9,8,8,7,7,6,7,5,5,4,5,5,8,8,10,10,11}, {11,11,9,8,8,6,5,3,4,3,4,2,4,4,5,5,7,8,9,9,9,10,9,10}, {9,9,8,8,6,7,4,5,3,5,4,7,7,8,9,10,10,10,9,8,9,7,7,6}, {7,6,7,6,7,7,8,8,8,8,8,8,8,8,7,7,6,7,5,5,4,4,3,5}, {4,5,5,6,7,7,8,8,8,5,6,3,3,2,2,2,4,3,4,4,5,6,6,6}, {6,5,5,4,3,4,2,3,2,3,1,1,0,2,1,3,4,6,6,8,8,7,8,6}, {5,3,3,0,0,-1,0,-1,0,0,3,3,5,5,6,6,6,6,6,6,6,7,6,7}, {5,5,4,4,3,4,3,4,4,5,6,6,7,6,6,5,5,3,3,2,3,3,6,5}, {7,8,9,9,9,9,7,6,4,4,2,2,1,2,1,2,1,2,2,2,3,4,5,6}, {8,8,10,9,9,7,7,5,5,2,1,-1,0,1,2,3,5,6,7,8,7,8,7,7}, {5,6,5,7,6,8,6,7,7,7,5,6,6,6,6,6,8,7,9,8,9,7,7,5}, {6,4,5,4,6,7,8,10,11,11,11,10,9,8,6,6,4,5,3,5,5,6,6,8}, {7,7,7,7,8,8,9,8,9,8,8,6,6,4,4,3,3,1,2,2,5,6,7,8}, {9,9,8,8,6,5,4,4,3,4,3,4,4,5,5,6,5,6,6,6,7,6,7,7}, {8,7,7,5,6,4,4,3,3,4,5,6,8,9,9,10,9,9,7,7,5,5,4,5}, {4,6,5,7,7,8,8,8,9,8,8,8,8,8,9,8,9,7,6,5,5,4,4,4}, {4,4,6,7,8,9,9,9,7,7,4,4,2,3,2,3,3,5,5,6,6,7,8,7}, {7,6,6,4,6,4,5,3,4,2,3,2,2,2,3,4,5,7,8,10,9,11,9,9}, {6,7,4,4,2,2,2,2,3,4,5,6,7,7,7,7,7,7,8,7,8,7,8,7}, {8,6,6,4,5,4,5,6,6,8,7,8,8,8,7,7,5,4,3,4,3,5,6,8}, {8,9,9,9,9,8,8,6,7,4,4,3,3,2,3,2,3,2,2,3,3,5,5,7}, {7,8,7,8,6,7,5,5,3,3,0,1,1,2,3,4,6,6,8,8,8,7,7,5}, {6,4,5,4,5,5,6,5,5,5,6,7,7,7,8,9,8,9,8,9,8,9,6,7}, {5,5,4,4,5,6,7,8,9,8,9,9,9,8,7,6,6,4,6,5,6,6,7,7}, {8,8,8,9,8,8,7,8,6,7,6,5,4,4,3,3,2,3,3,4,6,7,9,9}, {11,9,11,9,9,6,6,4,4,2,3,1,2,3,4,5,5,6,6,7,6,8,7,8}, {7,8,7,8,7,6,6,5,4,4,5,5,6,7,8,7,8,7,7,5,6,4,4,4}, {5,4,5,6,7,9,9,10,10,9,8,9,7,7,6,6,4,4,2,3,2,2,2,3}, {3,4,6,6,7,8,9,8,9,7,6,4,4,2,2,2,2,1,2,2,3,4,4,5}, {4,5,3,4,2,4,3,4,3,4,3,4,3,3,3,4,5,5,7,7,8,7,7,5}, {6,3,3,1,2,0,1,2,3,4,6,8,8,10,8,9,7,8,7,7,6,7,6,6}, {5,5,5,4,4,5,5,5,7,6,9,8,10,9,10,8,8,5,5,3,4,4,5,6}, {7,9,9,10,9,10,8,8,6,5,4,4,3,4,5,5,5,6,6,6,6,6,7,7}, {8,8,10,8,9,7,7,6,4,3,3,2,2,3,5,7,9,10,11,12,10,10,8,9}, {6,6,5,5,5,6,7,7,7,7,8,7,9,9,10,10,11,11,12,12,12,11,10,9}, {7,6,5,5,5,7,7,9,9,10,10,11,8,9,7,7,5,6,5,7,7,8,9,8}, {10,9,9,7,8,5,6,5,6,5,6,4,4,3,3,2,2,2,3,5,6,8,9,12}, {10,11,10,9,6,6,2,2,1,1,1,1,2,2,4,4,5,5,6,6,8,7,9,7}, {8,7,7,6,5,4,3,2,2,3,2,4,5,7,7,8,6,7,5,6,4,5,4,4}, {4,5,5,6,7,7,8,7,8,6,7,5,6,5,6,5,5,4,4,3,3,3,3,4}, {4,6,6,8,7,8,7,8,6,6,3,2,1,1,0,0,1,1,3,4,5,5,7,5}, {7,5,6,5,5,4,4,3,3,3,2,2,1,1,2,3,3,5,6,8,7,8,7,8}, {6,5,4,4,3,3,3,3,4,4,6,5,7,6,7,6,6,5,5,5,6,5,6,6}, {6,6,6,5,5,7,6,7,7,8,7,8,7,7,6,6,4,3,1,1,1,2,3,4}, {7,7,9,8,10,9,10,8,8,6,5,3,4,2,3,3,2,3,2,3,3,4,4,6}, {5,7,6,8,7,7,7,6,5,5,4,3,4,4,6,5,8,7,9,8,9,7,7,5}, {5,4,3,3,4,5,5,6,7,8,8,9,9,10,9,11,9,10,9,9,8,9,7,6}, {5,4,4,3,5,5,8,8,10,10,12,10,11,10,10,9,8,7,6,6,6,8,7,9}, {9,9,8,9,7,8,7,7,6,7,5,6,5,5,5,5,5,5,6,6,8,8,10,9}, {11,10,11,9,8,6,5,4,3,3,2,3,4,5,6,8,8,9,9,10,9,10,9,9}, {9,9,8,8,7,6,6,5,6,4,5,5,7,7,9,9,9,9,9,8,7,6,5,6}, {4,5,6,6,6,8,8,10,9,9,7,8,6,7,5,6,5,5,5,5,4,4,5,5}, {6,5,7,6,7,7,8,7,7,5,4,3,1,1,0,1,0,2,3,5,5,7,6,7}, {5,6,4,3,2,2,1,1,1,0,1,0,1,0,1,1,3,3,5,6,7,7,7,6}, {6,5,4,3,1,1,0,1,1,3,4,5,5,7,6,7,5,6,3,5,5,5,6,6}, {6,6,7,6,6,4,6,5,5,4,6,5,6,6,5,5,4,2,2,1,1,2,2,5}, {6,8,9,10,10,10,9,7,5,4,3,2,1,1,1,1,3,2,5,4,5,4,6,5}, {7,7,8,7,8,8,7,6,5,4,3,3,2,2,3,6,6,9,7,10,9,8,7,6}, {6,5,5,5,6,6,7,7,9,7,9,8,8,8,9,8,9,8,9,8,9,9,7,7}, {6,6,5,5,5,7,8,11,11,12,11,11,10,9,7,6,5,4,4,4,5,5,7,6}, {8,8,9,7,8,7,8,7,7,7,6,6,5,5,3,4,2,3,2,4,4,6,7,8}, {8,9,7,7,6,5,4,3,3,2,3,3,5,5,7,6,8,7,8,6,7,6,6,6}, {6,6,4,5,4,5,4,5,4,6,5,7,7,10,9,10,9,10,8,7,6,4,3,2}, {3,2,4,4,6,6,8,7,9,8,9,7,8,8,8,7,7,7,6,5,4,4,3,4}, {3,5,4,6,5,7,7,7,6,5,4,3,3,2,3,2,5,4,6,7,8,7,9,7}, {7,5,5,4,3,3,1,2,1,2,2,3,2,3,3,5,5,8,8,9,10,10,9,9}, {8,5,5,3,2,1,2,1,3,3,5,5,7,7,9,8,8,7,7,7,8,7,8,9}, {8,8,6,8,6,6,6,7,5,7,5,6,6,6,6,5,5,3,4,2,3,2,5,4}, {7,7,9,9,9,9,7,7,5,4,1,1,0,1,1,2,1,3,3,5,5,6,5,6}, {6,7,7,7,7,6,6,5,5,2,3,1,2,2,3,4,6,6,7,8,9,8,7,7}, {5,5,3,3,2,4,2,5,4,6,5,6,6,7,6,7,6,7,7,7,7,6,7,6}, {6,5,5,4,5,5,6,7,9,8,9,8,8,7,5,5,3,4,3,4,4,5,6,8}, {8,9,8,9,8,8,6,5,4,4,3,2,2,1,1,0,2,1,3,3,6,6,8,9}, {9,9,9,9,7,7,4,3,2,1,0,1,1,3,3,5,5,6,6,6,6,6,7,6}, {7,6,7,6,7,6,7,6,6,4,6,5,5,6,7,6,6,7,6,5,4,4,2,3}, {3,5,4,6,7,9,9,10,9,10,8,7,6,5,4,3,4,2,3,2,3,2,3,3}, {4,3,5,5,7,7,8,8,7,6,5,4,2,1,0,0,0,2,2,3,4,5,6,6}, {4,4,3,3,3,1,3,2,3,3,4,3,5,4,4,4,5,5,6,6,6,7,6,6}, {4,4,2,3,1,1,0,2,2,5,6,8,9,10,10,9,8,7,6,4,5,4,5,5}, {6,5,6,5,6,5,6,6,6,7,8,8,8,8,8,8,6,6,4,4,2,3,3,5}, {6,8,8,9,9,9,8,7,7,4,4,3,3,3,4,4,6,6,7,7,8,6,8,7}, {7,7,7,7,6,7,6,7,5,5,3,4,4,5,6,8,9,11,11,12,12,11,10,8}, {8,6,5,4,5,4,6,5,7,7,8,8,9,8,9,9,9,10,9,10,9,10,8,9}, {7,7,5,6,5,7,7,8,9,9,10,8,8,7,7,5,5,4,5,5,7,7,8,9}, {10,9,10,9,8,8,7,7,4,5,3,3,2,2,2,2,0,2,2,4,5,6,7,8}, {9,8,8,6,6,3,3,1,2,0,1,0,1,2,4,4,5,5,5,5,5,5,4,5}, {4,5,5,5,4,4,3,5,4,5,4,6,6,7,7,7,6,6,5,4,3,2,3,1}, {3,2,4,4,5,7,7,8,8,7,6,6,4,4,4,3,2,3,1,3,2,3,2,3}, {3,4,4,4,5,5,6,5,6,3,3,1,1,-1,0,0,1,2,4,4,6,7,7,7}, {6,6,4,4,2,2,1,1,0,2,1,1,1,2,3,4,4,5,5,6,7,8,8,7}, {8,5,6,3,3,2,3,2,3,3,5,5,6,6,6,7,5,5,4,5,4,5,4,6}, {5,7,6,8,7,8,8,8,7,6,7,5,6,5,6,3,4,2,2,1,1,1,3,4}, {5,7,8,9,9,10,9,9,6,6,4,3,1,1,1,2,2,3,4,5,4,5,5,5}, {5,4,5,4,5,5,6,5,5,4,5,4,5,4,5,6,7,7,8,8,8,8,7,6}, {4,3,1,3,2,3,4,5,7,8,9,10,10,10,10,9,9,7,9,7,8,6,7,5}, {5,4,4,4,4,4,6,7,7,9,9,10,9,9,8,8,6,6,4,5,5,7,7,8}, {8,8,8,8,7,6,5,4,4,3,4,3,4,4,5,5,6,5,6,7,8,8,8,10}, {9,10,8,8,5,4,2,2,0,0,0,1,2,4,6,8,9,9,9,8,9,7,8,6}, {7,5,6,4,5,4,5,4,4,4,4,5,5,7,7,8,8,9,8,8,7,7,5,6}, {4,5,4,5,6,8,8,8,8,7,6,4,4,2,3,2,2,2,3,2,4,4,4,4}, {4,4,4,5,4,5,4,5,3,3,1,0,-2,-2,-3,-2,-2,0,1,2,4,5,6,5}, {6,4,5,2,2,0,1,0,1,0,1,1,1,1,1,1,1,2,3,4,4,5,5,6}, {4,5,3,2,0,1,0,1,1,2,3,4,6,5,6,5,4,2,3,1,2,1,3,2}, {4,4,5,5,6,6,6,6,5,6,5,6,4,5,4,4,3,2,0,0,0,1,1,3}, {5,6,7,8,8,8,8,6,6,3,3,0,1,0,1,1,2,3,4,4,5,5,5,5}, {4,6,5,6,5,6,4,5,4,3,3,3,2,3,4,5,7,7,8,9,9,8,8,6}, {6,4,4,3,4,4,5,6,7,7,8,9,8,8,7,8,6,7,7,8,7,7,7,8}, {6,6,6,6,7,7,8,9,9,8,9,7,8,6,6,3,4,1,2,2,3,4,6,7}, {8,9,8,9,8,8,6,7,5,5,4,3,2,3,2,1,2,2,3,3,4,5,7,7}, {8,7,8,6,6,5,4,3,3,2,3,3,4,4,5,6,5,6,5,6,5,5,4,5}, {3,4,3,4,4,4,5,4,6,5,7,7,8,7,9,8,8,6,6,4,4,2,2,1}, {1,2,3,3,4,6,7,9,7,9,7,8,6,6,5,5,4,4,3,3,3,3,3,3}, {4,4,4,3,4,3,4,4,4,3,4,2,2,1,2,2,3,4,5,6,7,8,7,7}, {6,6,3,3,0,0,0,0,0,1,1,2,3,4,5,6,7,7,9,8,10,8,10,8}, {8,5,5,3,3,2,2,2,2,4,4,5,6,8,8,9,7,7,6,7,5,6,6,6}, {6,6,7,7,7,7,7,6,6,5,5,3,5,3,5,3,4,3,3,2,3,3,4,6}, {6,8,8,9,9,10,8,8,6,5,2,1,-1,0,-1,0,2,3,4,5,6,6,6,5}, {6,4,5,4,5,4,4,4,3,3,3,2,2,3,2,4,4,6,5,7,7,8,6,6}, {4,3,1,2,2,2,4,4,7,6,8,8,9,8,8,6,7,4,5,4,5,5,5,5}, {4,5,4,4,4,5,5,7,6,9,8,8,6,6,4,4,2,2,1,1,2,2,4,5}, {7,7,8,6,7,5,5,3,4,2,2,2,2,1,2,2,2,3,3,4,3,5,5,7}, {6,8,6,7,5,5,3,2,1,0,0,1,3,4,5,5,7,7,7,6,6,4,5,4}, {4,4,4,4,4,5,5,5,5,6,5,6,6,7,7,7,6,7,5,5,4,4,3,2}, {3,2,3,4,6,6,9,8,9,7,7,5,5,3,3,2,2,1,3,3,2,4,3,4}, {4,4,3,5,4,5,5,5,5,5,3,2,1,0,-1,-1,0,1,3,4,6,6,7,5}, {6,4,3,2,1,1,0,0,1,2,2,3,3,4,4,4,3,5,4,6,5,6,6,6}, {5,5,3,2,2,1,2,2,3,3,6,6,8,8,8,7,7,5,4,3,3,2,3,4}, {4,5,5,6,5,7,6,7,6,7,5,6,5,6,5,5,5,4,3,2,2,2,3,3}, {6,5,8,7,8,7,7,6,5,3,3,2,2,2,2,4,5,7,7,8,7,8,7,7}, {6,6,4,5,4,4,4,3,3,2,3,2,4,4,6,7,9,9,11,10,11,10,10,8}, {6,4,4,3,2,3,3,5,4,7,6,8,8,8,8,9,8,8,7,8,9,9,9,9}, {9,8,8,6,7,6,7,6,7,6,6,5,5,4,3,3,2,2,2,3,3,6,6,8}, {7,9,8,8,7,6,4,4,2,1,0,0,-1,-1,0,-1,0,0,3,3,5,5,6,6}, {7,6,7,5,5,4,3,2,1,1,0,1,0,2,2,4,4,5,3,4,3,4,3,3}, {3,3,3,3,3,3,5,4,6,4,5,4,5,4,5,4,4,3,2,2,1,1,0,1}, {0,1,1,3,4,5,5,8,7,7,6,6,3,2,2,1,0,0,0,1,1,1,2,2}, {3,2,3,3,4,3,4,3,3,2,1,1,0,0,-1,0,-1,1,1,3,4,6,5,7}, {5,5,3,2,1,0,1,0,0,-1,1,1,3,3,5,4,5,4,5,5,5,5,6,6}, {5,5,4,4,3,3,2,3,3,5,5,6,6,8,7,7,6,6,4,3,3,3,3,3}, {5,4,6,6,9,8,9,8,9,7,7,5,5,4,3,4,3,3,2,2,1,3,2,3}, {3,6,5,8,8,9,8,8,6,5,4,2,2,1,2,1,3,3,6,5,7,6,7,5}, {4,4,4,3,4,4,4,5,4,6,5,6,5,6,5,7,7,8,8,9,7,8,8,6}, {5,3,2,1,2,2,4,5,7,8,10,10,10,10,10,9,8,7,6,6,5,6,5,6}, {5,6,5,5,5,6,5,7,7,8,8,8,8,7,6,5,5,4,4,3,4,4,6,6}, {8,7,9,7,7,6,4,4,2,2,2,2,2,3,3,4,4,5,4,6,5,7,7,7}, {7,7,7,5,5,4,4,2,2,0,0,1,3,4,6,8,9,8,9,8,8,7,6,6}, {5,5,4,5,3,5,3,5,4,5,4,5,4,6,5,6,7,7,6,6,5,4,4,2}, {3,2,3,3,5,5,7,6,6,5,5,3,2,1,0,0,0,2,1,3,3,5,4,6}, {4,5,4,5,4,4,3,4,3,2,1,0,-1,-3,-2,-3,-1,-1,2,3,6,6,7,7}, {6,5,3,2,1,0,-1,0,-1,0,-1,0,1,2,2,2,1,2,2,3,3,4,5,4}, {5,4,4,2,2,1,2,2,3,3,5,4,6,6,6,5,5,3,2,1,0,1,1,2}, {2,5,4,7,6,7,7,7,6,6,5,4,3,3,2,1,3,1,1,1,1,0,2,2}, {4,3,6,5,6,7,7,6,4,4,2,1,0,1,1,2,2,4,4,6,6,7,6,6}, {5,4,3,3,3,3,4,3,4,3,5,4,5,4,6,7,8,7,9,8,9,9,7,7}, {5,5,3,3,2,3,3,6,6,8,8,10,10,9,8,7,7,6,7,6,6,5,6,6}, {7,6,7,6,7,7,7,7,8,8,7,7,7,6,4,4,2,3,1,3,3,4,5,6}, {7,8,8,8,7,7,6,4,4,3,3,1,2,1,3,2,2,2,4,3,5,5,5,5}, {5,6,5,5,4,4,3,4,3,3,2,3,3,5,5,6,7,7,5,5,5,4,3,2}, {3,1,2,2,3,2,5,5,6,6,8,7,8,8,7,7,6,6,5,4,2,3,1,2}, {0,2,1,2,2,4,6,6,7,7,6,5,5,4,4,2,3,2,3,2,4,3,4,4}, {4,3,4,2,2,2,2,2,1,2,1,1,1,1,1,2,2,4,4,6,7,9,9,8}, {7,6,5,2,1,-1,0,-2,-1,-2,1,1,3,4,6,6,7,6,7,6,7,7,7,8}, {6,7,5,5,3,3,2,2,2,3,3,5,5,6,7,7,8,6,6,4,5,4,5,5}, {7,6,9,9,10,10,9,9,7,6,3,3,2,2,1,2,1,3,2,4,3,5,4,5}, {5,6,6,7,8,8,8,6,6,2,2,-1,-1,-2,-2,-2,1,1,4,5,7,7,7,6}, {5,5,3,4,3,3,4,5,4,5,3,5,3,3,4,4,4,5,6,6,7,6,7,5}, {6,4,4,1,2,2,3,4,6,6,8,7,7,7,6,5,4,4,2,3,2,3,3,4}, {5,5,4,6,5,6,6,6,7,6,6,5,6,4,4,2,1,-1,1,-1,2,2,4,5}, {6,7,8,7,6,6,4,4,2,2,1,1,0,2,1,3,2,3,3,4,4,5,5,5}, {6,5,6,4,5,3,4,2,2,1,1,1,3,4,6,7,7,7,6,7,5,5,3,4}, {2,3,2,4,3,5,5,7,6,6,7,7,6,7,7,7,6,6,6,4,5,3,3,2}, {3,2,3,4,5,7,8,8,8,9,6,6,4,3,2,2,0,1,1,3,3,4,4,5}, {4,5,4,3,4,3,4,3,4,3,4,2,2,1,1,0,1,1,3,4,5,7,6,7}, {5,6,3,3,1,2,0,2,1,2,3,5,5,6,7,6,6,6,5,4,5,4,5,4}, {5,3,4,3,4,3,4,4,5,5,6,8,8,10,9,9,7,7,4,3,1,2,1,2}, {2,3,4,6,7,8,8,8,9,7,7,6,6,5,6,4,6,4,5,3,4,3,3,4}, {4,4,4,5,5,5,5,5,4,5,2,3,2,3,3,5,5,7,8,9,9,9,8,7}, {7,4,4,1,2,1,2,1,3,2,4,5,6,6,9,9,10,10,11,11,11,11,10,10}, {7,7,4,4,2,3,3,4,5,6,7,8,8,7,9,7,8,6,7,6,7,7,8,7}, {8,7,7,6,7,7,6,5,5,5,3,4,3,2,1,1,1,1,1,2,3,5,6,7}, {9,9,9,8,8,6,7,3,3,1,1,-1,-1,-2,-1,-1,1,2,3,4,4,5,5,6}, {5,6,5,6,4,4,3,3,2,1,1,1,0,2,2,3,4,4,4,4,4,3,3,1}, {2,1,2,2,3,4,5,6,6,6,6,6,5,5,4,4,2,3,1,2,0,2,1,1}, {1,0,2,2,3,4,6,6,8,6,6,4,3,1,1,-1,0,-1,0,0,1,2,3,4}, {3,4,2,2,1,2,0,1,0,1,0,1,0,1,0,0,1,1,2,3,5,5,7,5}, {7,4,5,2,2,0,-1,-2,-1,-1,1,2,3,4,5,6,5,6,5,6,5,6,5,5}, {4,5,4,5,4,4,4,4,4,4,6,6,7,7,8,7,7,5,5,4,4,2,3,3}, {4,5,6,8,9,10,10,10,8,8,5,5,3,3,2,3,3,4,4,4,4,4,4,4}, {5,5,7,7,8,7,9,7,7,5,4,2,2,1,2,3,4,5,6,7,8,8,7,8}, {6,6,3,3,3,4,4,5,5,6,6,7,6,7,7,7,8,7,9,7,9,8,8,6}, {6,4,3,2,3,4,4,6,7,9,9,10,10,10,9,9,7,6,5,5,4,5,5,5}, {6,6,6,6,7,5,7,6,8,7,8,6,7,6,5,4,4,2,2,2,2,4,5,6}, {6,7,7,7,5,5,3,4,2,2,1,2,2,3,4,5,5,6,7,6,7,6,7,6}, {6,5,5,4,4,3,2,2,1,1,1,2,3,5,6,8,8,9,8,9,7,7,5,5}, {2,2,1,1,2,3,4,5,5,5,5,5,6,5,6,6,7,6,6,5,5,5,5,4}, {4,4,3,4,4,7,6,8,6,7,4,4,1,1,-1,0,-1,0,1,3,4,5,7,6}, {7,6,6,4,5,2,2,1,2,0,1,-1,-2,-2,-2,-2,-1,0,1,4,4,6,6,8}, {6,7,5,4,3,2,1,1,1,1,1,3,3,3,4,3,4,2,4,2,3,3,5,4}, {5,5,6,5,5,5,6,6,6,7,6,6,5,7,5,5,4,4,1,1,-1,0,0,1}, {2,4,5,6,8,8,10,9,10,7,7,5,4,3,3,2,2,2,2,1,2,3,3,4}, {3,6,4,6,5,7,6,6,6,5,4,4,3,2,2,3,4,5,6,6,8,7,8,6}, {6,4,4,2,3,3,3,4,4,5,5,7,7,8,8,9,8,9,8,9,8,8,8,8}, {6,6,5,3,4,3,5,5,7,7,10,9,10,10,10,8,8,6,6,5,6,5,6,7}, {7,8,7,8,7,8,8,8,6,7,5,6,5,5,4,4,3,3,3,3,4,4,6,6}, {8,8,9,8,9,7,6,5,4,2,2,1,2,1,2,4,3,5,5,6,5,7,5,7}, {5,5,4,6,5,5,5,4,4,4,4,3,5,6,7,6,8,7,8,6,6,5,5,3}, {2,2,1,2,2,4,5,7,7,9,8,9,8,8,6,7,6,5,4,5,4,4,3,2}, {2,1,3,2,4,4,7,6,8,7,8,6,6,4,3,2,2,2,3,3,4,6,5,7}, {5,5,3,4,2,1,1,1,1,1,1,2,3,3,4,3,4,4,6,5,8,7,8,7}, {7,6,5,3,2,0,-1,0,-1,0,1,3,5,8,8,10,9,10,7,8,7,7,6,7}, {6,7,6,5,6,4,6,4,6,4,6,5,6,7,8,8,8,7,6,5,5,4,3,4}, {4,6,5,9,7,9,8,8,7,6,3,3,2,1,1,1,3,3,5,4,5,5,6,5}, {6,5,7,6,7,6,6,6,5,4,2,1,1,0,0,1,2,5,5,8,8,10,9,9}, {7,6,4,4,3,2,4,4,4,4,5,4,5,4,5,4,5,5,6,5,7,7,7,7}, {6,5,4,4,3,4,4,6,6,9,8,9,7,8,7,5,4,3,2,2,2,3,4,4}, {6,5,7,6,8,7,8,7,7,6,7,4,5,4,2,2,0,0,0,1,1,3,3,5}, {5,7,6,8,6,6,5,4,3,1,1,1,1,1,3,3,4,4,4,4,5,4,4,4}, {5,4,4,3,3,4,4,4,3,4,3,4,4,6,6,8,7,8,6,7,5,5,4,3}, {3,1,2,2,3,3,6,6,8,7,9,7,8,7,7,6,6,6,5,5,4,4,3,4}, {3,4,3,5,4,6,6,7,7,7,6,5,3,2,1,1,2,1,3,3,5,5,7,6}, {7,5,6,4,4,3,3,3,2,2,1,2,1,2,2,2,2,4,4,6,7,8,7,8}, {8,7,5,5,3,2,2,2,2,2,4,3,6,5,8,7,8,7,6,5,5,5,5,5}, {4,5,5,6,6,7,6,8,6,9,7,8,7,8,7,8,8,6,6,4,4,3,3,2}, {4,3,6,6,9,9,10,9,9,8,7,6,5,4,3,3,3,4,4,6,5,6,5,6}, {5,5,4,4,4,5,5,5,5,5,4,4,4,3,5,5,7,7,9,9,11,10,10,10}, {8,6,4,4,1,2,1,3,3,4,4,6,7,9,8,10,9,10,8,9,9,9,9,7}, {8,5,5,3,3,2,4,4,5,5,8,8,9,8,8,7,7,6,5,5,5,5,5,7}, {7,9,8,9,9,9,8,7,6,6,4,3,3,3,3,2,2,2,3,2,4,4,7,6}, {8,8,9,8,7,7,5,4,3,2,0,0,-1,0,0,2,2,4,4,6,5,5,5,5}, {5,4,4,4,5,4,5,4,5,4,5,3,4,4,6,5,6,6,6,5,4,4,3,3}, {1,3,1,3,2,5,5,8,8,9,8,8,6,5,5,4,3,3,2,2,2,1,2,1}, {3,1,2,3,4,5,6,6,7,7,7,5,4,3,1,0,-1,0,0,1,1,4,5,5}, {5,5,4,3,3,2,2,1,2,1,3,2,3,3,3,3,4,3,3,4,5,5,6,7}, {5,6,4,4,2,3,1,2,1,3,3,5,6,8,8,10,8,8,6,5,4,4,4,4}, {5,4,6,5,6,6,8,7,8,7,8,8,9,9,9,9,8,8,6,6,4,4,2,3}, {3,6,6,8,9,10,11,10,10,9,8,6,6,4,4,4,6,5,7,6,8,6,7,6}, {7,6,6,5,6,7,7,7,6,7,5,5,4,4,4,6,6,8,8,10,10,11,10,9}, {8,6,6,3,4,3,4,4,6,6,8,8,9,9,9,9,9,9,9,9,9,10,8,8}, {7,7,5,6,4,5,5,7,8,10,10,10,10,10,10,8,8,6,6,5,5,5,6,6}, {7,7,8,7,8,7,7,7,6,7,6,6,5,6,4,4,3,4,3,5,5,6,6,8}, {7,8,7,7,6,5,5,3,2,1,2,0,2,2,4,4,6,6,7,7,7,7,6,6}, {4,5,3,3,2,3,1,3,1,3,2,3,4,5,6,8,9,9,9,9,8,6,6,5}, {4,3,3,2,4,4,6,5,7,7,7,7,6,6,5,6,4,5,5,6,5,6,5,6}, {5,5,4,5,5,5,5,5,5,4,4,2,1,0,0,-1,0,0,2,2,5,5,7,7}, {7,8,6,6,4,3,2,3,1,1,0,1,0,0,0,1,2,3,3,5,5,7,8,7}, {8,7,7,5,5,3,3,1,3,2,3,3,4,5,6,6,6,5,5,4,4,4,3,5}, {3,5,5,6,6,8,8,9,8,8,8,7,7,6,6,6,5,4,4,2,3,1,2,1}, {3,3,6,6,8,9,10,11,10,10,8,7,4,4,2,3,2,2,2,4,4,6,5,5}, {5,4,5,4,5,5,6,5,6,4,5,4,5,4,4,4,6,6,7,7,8,8,8,8}, {7,6,3,3,2,3,2,4,4,6,7,8,9,9,9,10,9,8,9,8,7,6,7,6}, {6,5,6,5,5,5,5,6,7,9,9,10,10,11,9,9,6,7,4,6,4,5,4,6}, {6,8,8,9,9,9,9,8,8,6,6,5,5,4,5,3,4,3,4,3,4,4,5,6}, {7,8,7,8,7,8,6,7,4,4,2,3,2,3,3,5,6,7,8,7,8,6,6,5}, {6,4,4,3,5,4,5,5,6,6,6,6,6,6,7,8,8,9,7,8,7,7,4,4}, {2,2,1,2,3,5,6,8,10,10,10,9,9,8,7,6,6,4,5,5,5,4,5,4}, {4,3,4,4,3,5,5,7,6,7,6,6,5,4,2,2,1,2,2,4,5,6,8,8}, {8,6,6,4,3,1,2,0,1,0,2,2,4,3,4,4,5,6,6,6,7,8,8,9}, {8,9,6,6,3,3,2,1,1,2,2,4,6,6,8,8,9,8,8,6,7,4,5,4}, {5,5,7,5,6,6,6,6,6,7,6,6,5,6,5,7,6,7,5,5,4,4,3,4}, {5,5,7,8,10,9,11,10,10,7,6,3,3,2,2,1,3,2,5,5,6,7,7,8}, {7,7,6,7,5,6,5,6,5,5,3,3,1,2,2,3,3,5,6,7,8,9,9,8}, {9,6,7,4,4,3,4,4,5,6,7,7,8,8,7,7,7,7,6,6,6,7,6,8}, {6,7,5,6,6,7,7,7,9,9,10,9,10,8,7,5,5,3,3,1,2,2,4,4}, {6,6,7,8,8,9,8,9,7,8,6,6,4,4,3,3,1,2,1,1,2,3,4,4}, {6,6,7,6,6,5,6,4,5,3,4,3,4,3,4,5,5,7,6,6,5,5,4,4}, {2,3,2,3,2,3,3,4,5,6,6,6,7,8,9,9,10,8,9,7,7,5,4,2}, {2,0,1,1,2,3,5,7,8,10,9,10,9,9,7,7,5,7,4,5,4,5,4,4}, {4,4,4,4,5,5,6,6,6,5,6,4,5,4,3,3,3,3,4,4,5,7,7,9}, {7,7,5,6,4,4,2,2,1,2,2,3,3,3,4,5,6,6,7,7,7,7,8,7}, {8,7,7,5,5,4,5,3,4,4,5,6,7,8,9,10,9,10,8,8,5,6,5,5}, {4,5,5,6,6,8,10,9,10,9,10,8,9,8,8,7,8,6,7,5,6,4,4,4}, {4,4,4,6,7,9,9,11,9,9,7,8,5,5,3,4,4,5,5,6,8,8,9,7}, {8,6,6,4,4,3,4,4,4,4,5,4,5,5,5,6,6,8,8,9,9,10,9,9}, {7,6,4,3,1,1,1,2,2,3,5,6,8,9,10,9,9,8,9,8,9,7,9,8}, {8,7,7,6,6,6,6,6,6,7,7,8,7,8,7,7,6,5,4,4,4,5,6,7}, {8,8,9,9,9,8,8,6,5,3,2,1,0,0,1,1,2,2,2,3,3,4,5,7}, {7,8,7,8,7,7,6,5,3,2,0,-1,-1,0,1,2,4,5,6,6,6,6,6,5}, {5,4,5,4,5,5,5,5,5,4,4,5,3,4,4,5,4,5,5,5,5,4,4,3}, {3,2,2,2,4,4,7,7,10,8,10,7,7,5,4,2,3,1,2,2,2,2,3,4}, {3,4,4,4,4,5,5,7,5,7,5,5,3,2,1,-1,-1,-1,0,0,3,4,6,5}, {7,5,7,4,4,2,2,1,2,2,3,2,3,4,4,4,4,4,3,5,3,5,5,6}, {5,6,4,5,4,4,4,3,4,4,6,7,8,8,10,10,10,9,9,6,5,4,4,3}, {3,4,5,5,6,8,9,10,9,11,10,10,9,9,9,9,8,8,7,6,5,4,4,3}, {4,4,6,6,8,8,10,10,10,9,9,7,6,5,4,5,5,6,7,7,8,9,8,9}, {7,7,5,6,5,5,5,5,6,6,5,5,6,6,6,7,8,8,10,10,12,11,11,9}, {9,7,6,4,4,3,3,5,5,7,8,10,9,11,10,10,9,10,9,8,8,8,7,8}, {7,6,7,6,7,6,8,8,10,9,11,9,10,9,9,8,7,6,5,4,4,5,5,6}, {6,8,8,9,7,9,7,8,7,6,6,5,4,4,3,3,3,3,4,3,4,4,6,5}, {6,5,6,5,6,4,5,3,3,2,2,3,3,4,4,6,6,7,6,8,7,7,6,6}, {4,4,2,3,3,2,4,4,5,5,5,5,7,6,8,7,8,8,7,7,6,6,4,4}, {2,2,1,2,1,3,3,5,5,7,6,7,5,6,5,4,3,4,3,3,3,3,4,4}, {5,4,6,4,5,4,4,4,4,4,4,2,2,1,1,1,0,1,1,3,4,6,7,9}, {7,8,7,7,4,4,2,1,0,-1,0,0,0,1,2,3,4,4,5,4,6,5,7,6}, {7,6,7,6,6,5,5,5,4,5,4,5,5,6,7,8,7,8,5,6,4,3,3,3}, {4,4,6,5,8,8,11,11,11,10,11,7,8,6,5,4,4,3,3,3,3,4,3,4}, {3,5,4,7,7,9,9,10,9,9,8,7,5,3,2,1,2,1,3,3,6,6,7,7}, {7,5,5,4,5,4,4,5,5,5,5,6,5,6,5,7,6,6,6,7,7,8,8,8}, {6,6,4,3,3,2,3,3,5,6,8,8,11,11,11,10,10,8,7,6,7,6,6,6}, {5,6,5,5,5,5,6,7,7,9,9,11,9,10,9,8,7,6,5,3,3,3,4,4}, {7,6,9,7,9,8,8,6,6,5,5,4,4,4,4,5,4,6,4,6,5,6,5,6}, {6,7,5,6,5,6,5,4,4,2,2,1,3,3,5,6,8,8,9,9,9,8,7,6}, {5,4,3,2,3,3,4,5,5,7,6,8,6,8,8,9,8,9,8,9,8,7,6,5}, {4,2,3,1,3,3,6,7,9,9,10,8,7,7,5,5,4,4,3,4,5,6,5,6}, {5,6,4,5,4,5,4,5,4,4,5,5,4,3,3,1,1,0,2,3,6,6,9,8}, {9,7,7,5,4,3,2,1,0,0,0,1,2,4,4,5,5,6,4,6,4,6,6,6}, {6,5,5,3,3,2,3,2,3,2,4,4,6,6,8,8,9,8,7,5,5,4,2,3}, {2,4,4,5,6,8,7,10,8,9,8,8,6,6,6,5,5,5,5,3,4,3,4,3}, {4,4,6,6,7,7,8,8,7,6,5,3,2,1,0,1,1,3,3,5,5,7,7,8}, {7,7,5,4,4,3,4,4,4,3,4,3,4,3,4,4,6,6,7,8,8,9,9,9}, {8,8,5,6,4,4,3,5,4,6,6,8,7,8,7,7,7,6,6,5,5,5,6,5}, {6,6,7,6,8,7,8,8,9,9,9,7,7,6,5,4,3,2,1,1,1,2,2,4}, {4,7,7,9,9,9,9,8,7,5,5,3,3,1,1,1,1,0,2,1,3,2,4,3}, {5,5,5,5,5,6,5,5,4,4,2,3,2,4,3,5,5,6,5,6,5,5,4,2}, {2,1,1,1,2,1,4,4,6,6,8,8,8,7,8,8,8,7,6,5,5,4,2,3}, {1,2,0,2,1,3,5,7,8,10,10,10,9,8,6,5,4,3,3,3,4,3,4,3}, {5,4,5,4,5,4,4,5,4,5,4,4,4,4,2,3,2,3,3,4,4,7,7,7}, {8,8,6,6,4,3,3,1,2,0,2,1,4,4,6,7,8,7,8,8,7,7,6,7}, {6,7,6,6,5,6,4,6,4,6,5,7,7,9,9,10,10,10,9,8,7,5,5,3}, {4,3,6,4,7,8,10,10,11,10,10,10,9,8,7,7,6,7,6,7,6,7,6,6}, {5,6,5,6,6,8,8,8,9,8,7,5,5,3,4,1,4,3,6,6,8,8,9,8}, {8,7,5,4,3,3,2,3,3,4,3,5,5,6,6,7,6,8,8,9,9,9,9,8}, {8,6,6,4,4,2,3,2,4,5,7,8,9,9,9,8,8,7,6,6,5,5,5,5}, {5,6,5,6,5,6,5,6,6,7,7,6,7,7,6,5,5,2,3,1,2,1,2,3}, {5,6,7,7,8,8,7,7,5,5,2,2,1,1,1,2,2,3,3,4,3,4,4,5}, {5,4,4,4,5,4,5,3,3,2,2,0,2,1,3,3,5,6,6,6,6,5,4,4}, {2,2,1,2,1,3,3,5,5,6,6,7,6,6,6,6,6,6,6,6,5,3,4,2}, {3,1,2,1,3,3,6,8,8,9,9,9,6,6,4,3,1,1,0,2,2,3,3,5}, {4,5,4,4,4,4,4,4,5,4,5,3,4,2,2,0,0,-1,0,1,3,4,6,6}, {6,7,5,6,3,3,2,3,1,2,1,3,3,5,5,6,6,6,5,5,5,4,4,4}, {5,4,5,3,5,4,5,4,5,5,8,7,9,9,8,9,9,9,7,6,4,4,2,2}, {1,3,2,5,5,8,8,9,10,10,11,10,9,8,8,6,6,5,5,4,5,4,5,4}, {4,4,5,5,6,7,6,8,7,8,6,6,4,4,4,5,4,5,5,7,8,9,9,8}, {8,6,6,4,3,2,3,3,4,3,4,4,5,5,6,7,8,8,9,9,10,9,9,10}, {8,8,6,5,3,4,3,4,4,6,7,9,9,10,10,10,10,9,9,7,7,7,7,5}, {7,6,7,6,7,7,7,8,7,8,7,8,6,7,5,6,4,4,3,4,3,4,4,5}, {5,6,7,7,7,7,7,6,6,4,4,2,2,1,1,2,3,2,3,4,5,5,5,6}, {5,6,4,5,4,4,3,3,2,2,1,1,1,2,2,4,5,6,6,6,6,5,5,3}, {3,1,1,0,0,0,2,2,3,4,5,5,5,5,4,5,4,5,4,5,3,4,3,3}, {1,1,0,2,1,3,4,5,6,6,7,6,5,4,4,1,1,0,0,0,2,2,4,4}, {5,5,5,5,4,4,2,3,1,3,0,1,-1,0,0,0,-1,0,0,1,2,3,5,5}, {7,5,7,5,5,3,3,1,1,0,1,0,2,2,4,5,5,6,5,5,4,5,3,4}, {3,5,4,6,5,6,5,7,6,6,6,7,6,6,7,7,8,6,7,5,5,2,3,1}, {1,2,3,4,6,9,10,12,11,11,9,9,7,6,4,4,3,3,3,4,3,4,3,3}, {4,3,5,5,5,6,8,7,9,8,8,6,5,2,3,2,2,2,3,4,5,7,7,8}, {6,6,4,4,2,3,2,3,4,5,5,7,6,6,6,6,7,6,6,6,6,6,7,5}, {6,4,4,3,3,1,3,4,4,6,7,9,10,11,9,10,7,7,5,5,3,4,3,3}, {4,5,5,5,6,6,7,7,8,8,8,7,9,8,8,6,5,4,3,2,2,1,2,3}, {4,6,5,7,7,8,6,6,4,5,3,3,1,3,2,4,4,5,5,4,5,4,5,4}, {5,3,5,4,4,4,4,4,3,3,3,2,3,4,5,7,8,9,8,9,8,8,6,5}, {3,3,1,1,1,2,3,4,5,6,7,7,8,7,8,7,8,7,8,7,7,5,6,4}, {4,3,2,2,2,4,5,7,7,9,7,8,7,6,4,4,3,2,2,3,4,5,6,6}, {7,6,6,5,5,3,4,3,4,2,3,1,2,1,2,0,1,1,2,3,4,5,6,7}, {6,7,5,6,3,2,1,0,-1,0,0,1,2,3,5,5,6,5,6,5,5,3,4,3}, {4,3,4,4,5,4,4,5,5,6,6,6,6,7,6,7,7,7,6,6,4,3,2,2}, {2,1,2,3,4,6,7,7,9,8,8,6,6,4,4,3,3,2,3,3,3,3,4,4}, {3,5,4,5,4,5,4,6,5,6,4,4,3,2,1,2,2,3,4,5,7,7,8,7}, {8,6,6,3,4,2,2,1,3,3,3,3,4,4,5,5,5,7,7,8,6,7,7,8}, {7,7,4,4,4,3,4,4,5,5,7,7,8,8,9,8,8,6,6,5,4,3,4,4}, {5,5,5,6,7,9,8,10,8,10,7,7,6,5,5,5,3,2,1,1,1,1,2,2}, {4,5,6,5,7,7,8,7,7,5,4,3,2,1,1,1,2,2,2,3,3,3,3,4}, {2,3,1,3,2,4,4,4,4,4,4,4,4,4,5,4,5,6,6,5,6,3,3,2}, {1,-1,0,-2,-1,1,2,4,4,7,8,8,8,9,7,7,6,6,4,5,3,4,2,2}, {1,0,0,0,1,1,4,3,6,7,9,7,8,6,6,4,3,2,1,1,2,2,3,4}, {4,6,4,5,3,4,2,3,1,2,1,2,3,3,3,3,4,4,4,4,5,5,6,5}, {7,5,6,4,4,3,3,1,0,0,0,1,2,5,6,8,8,9,8,9,6,7,5,5}, {4,4,5,5,5,5,6,6,7,6,7,6,8,8,9,9,10,9,10,8,8,6,5,4}, {4,4,3,5,6,8,9,11,10,11,9,9,7,6,5,4,4,4,5,5,5,6,6,6}, {7,5,6,5,6,6,6,5,6,6,5,4,4,2,1,1,2,4,4,6,7,9,9,10}, {9,9,6,5,4,3,3,2,2,2,4,4,5,5,5,5,6,5,6,6,7,6,7,6}, {7,5,4,3,3,2,1,3,3,5,5,7,6,8,6,7,5,4,2,3,2,2,2,2}, {4,3,5,4,6,5,7,6,7,6,6,5,5,4,4,3,2,1,1,0,0,0,1,3}, {3,5,4,6,5,6,5,5,3,2,0,0,-1,-1,0,0,1,1,2,2,4,3,3,2}, {4,1,2,2,2,2,2,2,2,2,1,2,1,3,3,4,4,6,6,7,6,6,4,3}, {2,2,0,1,1,1,3,3,6,6,7,6,6,5,6,5,6,4,5,4,4,4,4,3}, {2,2,2,3,3,4,5,7,7,8,8,8,5,5,3,2,0,0,0,0,1,2,4,4}, {6,5,7,5,6,5,5,4,4,4,3,3,2,2,2,1,0,0,0,2,2,3,4,5}, {5,6,5,6,5,4,4,3,4,3,4,4,5,5,7,7,8,6,7,5,4,3,2,1}, {1,2,2,3,4,5,5,8,7,10,9,10,9,10,9,10,8,8,6,6,4,2,2,1}, {1,0,2,2,5,5,8,8,11,10,11,10,10,9,7,6,6,5,4,4,4,4,4,5}, {4,5,3,4,3,4,4,5,5,6,6,6,5,5,5,5,6,5,7,6,8,7,9,8}, {7,6,5,3,3,2,1,2,2,3,4,5,6,8,8,10,9,10,9,10,9,9,8,8}, {8,6,5,3,4,2,3,3,5,5,7,7,9,9,11,10,9,8,8,7,5,5,4,5}, {4,5,5,7,6,8,7,8,7,8,7,7,6,5,5,4,5,4,4,3,4,3,4,4}, {6,5,7,6,8,6,7,5,5,3,2,1,0,0,0,1,1,2,3,5,5,6,5,5}, {3,3,2,2,2,1,3,2,3,1,2,0,1,2,3,3,4,4,6,5,5,5,4,3}, {2,1,-1,-1,-1,1,1,4,4,6,6,7,6,6,5,4,3,3,3,2,2,2,2,2}, {2,1,1,0,2,2,3,3,5,5,5,5,5,3,2,1,-1,-1,-3,-1,-1,1,2,4}, {4,6,5,5,4,3,3,2,1,0,0,0,1,0,1,1,1,1,2,1,3,2,5,4}, {5,5,5,5,4,4,2,2,0,1,-1,2,1,3,4,6,6,8,6,7,5,5,4,3}, {3,3,3,3,4,4,6,6,7,6,7,7,7,6,7,8,8,7,7,6,5,5,3,3}, {2,3,3,5,6,8,9,10,11,10,9,8,6,5,4,2,3,3,3,3,5,5,6,5}, {7,5,6,5,6,5,6,6,6,6,5,5,4,3,2,2,1,3,3,5,5,7,7,7}, {7,7,5,4,4,2,3,2,4,3,6,5,7,6,7,6,7,6,6,5,6,6,5,6}, {4,5,3,4,2,4,3,5,5,8,8,10,9,10,9,9,7,6,4,3,2,1,2,1}, {3,2,4,4,6,6,7,8,8,7,8,7,7,7,6,5,4,4,1,2,1,2,1,3}, {2,4,3,5,5,6,6,5,5,3,4,2,3,2,4,4,5,5,6,6,6,5,5,4}, {3,2,1,1,1,1,1,2,2,4,3,4,4,5,6,8,8,9,9,8,8,7,6,4}, {4,0,0,-1,1,0,2,3,5,6,8,7,9,8,9,7,8,7,7,7,6,7,6,5}, {3,5,3,4,3,5,4,6,6,6,6,6,5,5,4,3,2,1,2,2,3,4,6,5}, {7,7,7,6,5,4,3,3,1,2,0,0,-1,1,0,2,1,3,2,3,3,5,5,6}, {7,6,7,5,6,5,5,2,3,2,2,2,3,3,4,5,6,6,6,5,4,4,3,3}, {2,3,2,4,3,5,5,7,6,8,8,9,7,6,6,5,5,4,4,3,3,2,2,1}, {1,1,2,3,4,6,7,9,10,10,9,8,7,6,3,3,1,1,0,2,2,4,4,5}, {5,6,4,4,4,4,5,4,6,4,5,3,4,2,3,2,3,2,3,4,5,6,7,7}, {7,7,4,4,2,2,1,3,2,3,3,5,5,7,7,8,7,7,7,6,6,5,6,5}, {7,4,6,5,5,4,6,5,6,6,7,7,9,9,9,9,7,6,4,4,3,3,2,3}, {3,5,4,7,8,9,9,9,9,8,7,6,5,4,4,2,3,2,3,1,2,2,2,3}, {4,4,5,6,6,7,7,7,5,5,3,3,1,1,1,1,1,3,3,4,4,4,4,3}, {3,2,2,2,2,2,3,3,5,5,5,4,5,4,5,5,5,6,6,6,5,5,4,3}, {1,1,-2,-1,-2,1,2,4,5,8,9,9,9,8,8,6,6,4,4,3,4,2,3,2}, {3,1,2,1,3,3,4,6,6,7,7,8,7,7,5,4,2,1,0,1,0,2,2,4}, {5,5,5,5,5,3,4,2,3,1,3,2,3,4,4,5,5,5,5,4,5,5,4,5}, {5,6,4,4,3,4,3,4,2,3,3,5,5,7,9,10,11,11,11,10,9,6,6,4}, {4,2,3,2,5,5,7,7,8,8,10,9,10,10,10,10,10,10,9,9,7,7,5,5}, {3,3,2,4,5,6,9,9,11,10,10,8,9,6,7,4,6,4,6,6,8,8,9,9}, {8,8,6,6,4,5,4,5,4,5,4,4,3,4,2,3,3,4,5,6,8,8,9,8}, {9,6,6,4,3,1,2,0,2,1,3,3,5,5,5,6,6,6,5,6,5,5,4,6}, {5,5,3,4,3,4,3,5,5,6,6,7,7,7,7,6,5,3,3,1,2,0,1,1}, {2,3,4,5,5,6,7,7,6,7,5,5,4,3,2,2,0,1,-1,-1,-1,0,0,1}, {2,3,4,4,4,4,5,4,5,3,2,0,1,0,1,1,2,2,3,3,4,3,3,4}, {2,2,1,1,0,1,1,2,2,3,3,4,4,5,5,5,6,6,6,6,6,5,4,3}, {2,0,0,-1,0,1,2,4,5,7,7,8,8,8,7,7,5,5,3,4,3,4,3,4}, {3,3,3,4,4,5,6,6,7,6,7,6,6,4,4,2,2,0,0,0,1,3,3,5}, {6,7,7,7,6,6,4,5,3,4,2,3,1,2,1,2,2,3,3,3,4,4,4,4}, {6,4,6,5,6,5,6,4,5,4,4,4,5,6,7,8,7,8,7,7,5,5,3,3}, {1,1,1,2,3,6,7,8,9,10,11,11,10,9,9,8,7,6,7,5,5,4,3,3}, {2,2,2,3,4,6,7,10,9,11,10,10,8,7,6,5,3,4,2,4,4,5,6,6}, {6,5,6,3,4,3,4,3,5,5,6,5,5,4,5,6,6,6,6,7,8,8,7,8}, {7,8,5,4,2,2,1,2,2,3,4,6,7,9,9,9,10,9,9,8,8,7,7,5}, {6,4,5,4,4,5,5,6,5,8,7,9,9,10,9,11,9,9,7,7,5,5,4,4}, {4,5,6,6,8,8,9,8,9,7,7,5,5,4,4,3,4,3,3,3,4,4,4,5}, {3,4,4,5,4,5,4,5,3,4,2,2,0,0,0,2,2,3,5,6,7,5,6,4}, {5,3,3,1,2,2,3,4,4,4,4,5,4,4,4,5,4,6,5,6,5,6,4,4}, {2,2,-1,0,0,0,2,3,5,6,8,7,8,6,5,3,3,1,2,0,2,2,2,3}, {3,3,2,3,3,4,4,6,5,7,6,6,4,5,3,3,0,0,-2,-1,-1,0,2,3}, {6,5,7,5,6,5,4,2,3,2,2,1,2,2,3,3,4,4,3,4,3,3,3,4}, {3,5,4,5,4,4,4,5,4,4,5,4,5,7,8,8,9,8,9,7,7,4,4,2}, {3,1,2,2,4,6,8,10,10,12,10,11,10,10,9,9,8,8,6,7,5,6,4,3}, {3,3,3,4,6,7,10,10,12,11,11,9,9,6,6,5,4,3,3,4,5,7,7,8}, {6,7,6,7,5,6,5,7,6,7,6,7,6,5,5,4,5,4,6,6,8,7,8,8}, {8,6,7,4,4,3,4,4,5,6,6,8,9,10,9,10,8,9,7,7,6,6,4,5}, {4,4,4,4,4,5,6,7,9,9,11,10,11,11,10,8,8,6,5,4,3,2,2,2}, {2,4,4,6,5,8,7,10,9,9,7,8,6,7,6,5,5,4,3,3,2,2,3,2}, {4,2,4,3,4,3,5,4,4,4,4,3,3,3,4,5,5,7,7,8,7,7,5,5}, {3,3,0,1,0,1,1,2,3,4,5,5,7,7,8,8,10,9,10,9,10,8,8,6}, {5,3,2,1,1,1,2,4,5,7,7,9,9,10,8,8,7,7,6,6,5,5,6,5}, {6,5,6,5,5,4,6,5,6,5,6,5,5,4,4,4,3,2,2,3,4,6,6,8}, {7,9,8,9,8,8,6,4,3,2,2,1,1,1,2,2,4,4,5,5,6,5,6,5}, {6,5,6,5,6,5,5,5,4,4,3,4,3,5,5,6,7,8,6,8,5,5,3,3}, {2,1,2,2,3,4,7,8,11,10,11,9,10,8,7,6,6,4,4,4,4,4,4,4}, {3,4,2,5,4,7,7,9,8,10,9,9,7,6,4,2,2,1,1,1,3,4,6,5}, {7,6,5,4,5,3,4,4,4,4,4,5,5,5,5,5,4,5,4,6,5,7,6,7}, {6,6,5,5,3,2,2,2,3,3,5,6,8,8,9,9,9,8,8,6,6,5,5,5}, {4,5,4,5,5,6,6,7,6,8,8,10,9,10,9,9,8,8,5,4,3,2,3,2}, {4,3,6,6,9,9,10,10,10,8,8,6,6,4,3,3,3,3,2,3,3,3,2,4}, {3,5,3,6,5,6,6,7,6,5,5,3,3,2,2,2,4,4,6,5,6,5,6,4}, {4,1,1,1,1,2,3,4,5,7,6,7,6,8,7,7,6,7,6,6,6,6,5,3}, {2,1,0,0,1,1,4,5,9,9,11,10,11,9,9,7,6,4,3,2,2,3,3,4}, {3,5,4,5,4,5,5,6,6,7,7,7,7,6,5,5,3,2,2,1,2,1,4,4}, {6,5,7,6,6,5,5,4,3,3,3,4,4,5,5,6,7,8,7,8,6,6,6,6}, {4,5,4,4,4,4,5,4,5,5,6,6,8,8,10,11,12,11,12,10,10,7,7,5}, {4,3,2,3,3,6,6,9,9,12,11,12,10,10,10,10,9,10,9,9,9,8,8,6}, {7,5,7,6,7,7,8,9,9,9,9,7,7,5,4,4,4,4,4,6,6,8,8,9}, {8,9,7,7,6,5,4,4,3,3,4,3,3,2,3,2,4,4,6,5,8,7,9,8}, {8,8,8,6,5,5,4,5,3,5,5,6,6,7,7,8,7,6,5,6,5,4,4,4}, {4,4,5,4,5,5,7,6,8,7,9,8,8,7,7,6,4,3,2,1,1,0,-1,1}, {1,3,3,5,6,8,8,9,9,8,7,6,5,4,3,1,1,0,1,0,1,1,2,1}, {3,1,3,3,4,4,5,5,4,5,4,4,3,3,3,3,3,5,5,6,5,5,4,3}, {2,1,0,-1,0,0,2,1,4,5,7,6,9,8,9,8,9,7,8,7,6,6,5,5}, {2,3,1,1,0,3,3,5,6,8,9,11,11,10,9,8,7,6,5,3,4,3,4,4}, {5,4,6,5,7,7,7,7,7,7,7,7,6,6,5,5,3,3,2,2,2,4,3,5}, {6,7,7,7,8,7,7,6,6,5,5,3,4,4,6,5,7,6,7,6,7,5,5,4}, {4,4,5,5,5,7,6,9,8,9,7,9,8,9,9,10,10,11,10,9,7,6,5,3}, {2,0,2,2,4,4,9,10,13,13,15,13,13,12,11,9,8,8,6,7,5,6,5,5}, {4,4,3,5,5,6,8,9,10,11,11,11,11,9,8,6,6,4,5,4,6,6,8,7}, {7,7,6,4,4,3,3,4,4,6,6,7,6,8,7,9,8,9,7,8,8,8,8,8}, {8,6,5,4,3,1,3,2,4,4,7,7,10,10,12,12,13,11,11,9,8,8,7,7}, {5,6,5,6,5,6,6,7,7,8,8,10,10,10,10,10,10,9,8,6,6,4,4,3}, {5,3,6,6,8,8,8,8,8,7,6,5,4,3,3,3,3,4,4,5,5,7,5,6}, {6,6,6,6,5,6,6,5,5,4,3,1,1,1,1,2,4,4,6,6,8,8,7,7}, {6,5,2,3,1,2,1,3,3,5,4,5,4,5,4,4,4,4,5,5,5,5,5,4}, {5,3,4,1,3,2,4,5,8,8,9,8,9,7,6,5,3,1,0,1,0,2,2,4}, {4,6,5,6,6,7,7,6,6,6,6,4,4,4,3,2,1,-1,0,-2,-1,0,2,3}, {4,6,6,6,7,6,5,6,4,5,3,4,3,4,4,6,5,6,5,5,4,5,4,3}, {4,2,4,3,5,4,6,6,8,6,9,7,10,8,10,10,10,10,9,9,8,6,5,4}, {1,3,2,3,3,6,7,10,11,13,12,13,12,12,11,10,9,8,7,6,7,6,6,5}, {6,4,5,5,7,8,9,9,10,11,10,10,8,8,6,6,4,5,5,6,6,8,8,8}}

local solar_term_chinese = {"冬至", "小寒", "大寒", "立春", "雨水", "驚蟄", "春分", "清明", "穀雨", "立夏", "小滿", "芒種", "夏至", "小暑", "大暑", "立秋", "處暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪", "冬至", "小寒"}
local month_chinese = {"冬月","臘月","正月","二月","三月","四月","五月","六月","七月","八月","九月","十月"}
local day_chinese = {"初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"}
local celestial_stems = {"甲","乙","丙","丁","戊","己","庚","辛","壬","癸"}
local terrestrial_branches = {"子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"}

local function get_percent_day_chinese()
  local i = 0
  local j = 0
  local k = 0
  local percent_days = {}
  local chinese_numbers = {"一", "二", "三", "四"}
  local chinese_half_hours = {"初", "正"}
  while (i < 100) and (j < 25) do
    if (864 * i < 3600 * j) then
      k = k + 1
    elseif (864 * i == 3600 * j) then
      j = j + 1
      k = 0
    else
      j = j + 1
      k = 1
    end
    i = i + 1
    percent_day = {terrestrial_branches[j % 24 // 2 + 1] .. chinese_half_hours[j % 2 + 1]}
    if (k > 0) then
      table.insert(percent_day, chinese_numbers[k] .. "刻")
    end
    table.insert(percent_days, percent_day)
  end
  return percent_days
end

local percent_day_chinese = get_percent_day_chinese()

local function getJD(yyyy,mm,dd)
  local m1 = mm
  local yy = yyyy
  if (m1 <= 2) then
    m1 = m1 + 12
    yy = yy - 1
  end
  -- Gregorian calendar
  local b = yy // 400 - yy // 100 + yy // 4
  local jd = 365*yy - 679004 + b + math.floor(30.6001*(m1+1)) + dd + 2400000.5
  return jd
end

-- UT -> TT
local function DeltaT(T)
  local y = T*100 + 2000 + 0.5/365.25
  local DT = 0
  if (y > 2150) then
    local uu = 0.01*(y-1820)
    DT = -20 + 32*uu*uu
  elseif (y > 2050) then
    local uu = 0.01*(y-1820)
    DT = -20 + 32*uu*uu - 0.5628*(2150 - y)
  elseif (y > 2022) then
    local uu = y-2000
    -- DT = 62.92 + 0.32217*uu + 0.005589*uu*uu;
    DT = 59.59 + 0.32217*uu + 0.005589*uu*uu
  elseif (y > 2017.0020533881) then
    DT = 69.184
  elseif (y > 2015.4962354552) then
    DT = 68.184
  elseif (y > 2012.4982888433) then
    DT = 67.184
  elseif (y > 2009.0020533881) then
    DT = 66.184
  elseif (y > 2006.0013689254) then
    DT = 65.184
  elseif (y > 1999.0006844627) then
    DT = 64.184
  elseif (y > 1997.4976043806) then
    DT = 63.184
  elseif (y > 1996.0) then
    DT = 62.184
  elseif (y > 1994.4969199179) then
    DT = 61.184
  elseif (y > 1993.4976043806) then
    DT = 60.184
  elseif (y > 1992.4982888433) then
    DT = 59.184
  elseif (y > 1991.0006844627) then
    DT = 58.184
  elseif (y > 1990.0013689254) then
    DT = 57.184
  elseif (y > 1988.0) then
    DT = 56.184
  elseif (y > 1985.4976043806) then
    DT = 55.184
  elseif (y > 1983.4962354552) then
    DT = 54.184
  elseif (y > 1982.4969199179) then
    DT = 53.184
  elseif (y > 1981.4976043806) then
    DT = 52.184
  elseif (y > 1980.0) then
    DT = 51.184
  elseif (y > 1979.0006844627) then
    DT = 50.184
  elseif (y > 1978.0013689254) then
    DT = 49.184
  elseif (y > 1977.0020533881) then
    DT = 48.184
  elseif (y > 1976.0) then
    DT = 47.184
  elseif (y > 1975.0006844627) then
    DT = 46.184
  elseif (y > 1974.0013689254) then
    DT = 45.184
  elseif (y > 1973.0020533881) then
    DT = 44.184
  elseif (y > 1972.4982888433) then
    DT = 43.184
  elseif (y > 1972.0) then
    DT = 42.184
  elseif (y > 1961) then
    uu = y-1975
    uu2 = uu*uu
    uu3 = uu*uu2
    DT = 45.45 + 1.067*uu - uu2/260 - uu3/718
  elseif (y > 1941) then
    local uu = y-1950
    local uu2 = uu*uu
    local uu3 = uu*uu2
    DT = 29.07 + 0.407*uu - uu2/233 + uu3/2547
  elseif (y > 1920) then
    local uu = y-1920
    local uu2 = uu*uu
    local uu3 = uu2*uu
    DT = 21.2 + 0.84493*uu - 0.0761*uu2 + 0.0020936*uu3
  elseif (y > 1900) then
    local uu = y-1900
    local uu2=uu*uu
    local uu3=uu*uu2
    local uu4=uu2*uu2
    DT = -2.79 + 1.494119*uu - 0.0598939*uu2 + 0.0061966*uu3 - 0.000197*uu4
  end
  return DT/86400.0
end

local function mod2pi_de(x)
  return x - 2 * math.pi * math.floor(0.5 * x/math.pi + 0.5)
end

local function decode_solar_terms(y, istart, offset_comp, solar_comp)
  local jd0 = getJD(y-1,12,31) - 1.0/3
  local delta_T = DeltaT((jd0-2451545 + 365.25*0.5)/36525)
  local offset = 2451545 - jd0 - delta_T
  local w = {2*math.pi, 6.282886, 12.565772, 0.337563, 83.99505, 77.712164, 5.7533, 3.9301}
  local poly_coefs = {}
  local amp = {}
  local ph = {}
  if (y > 2500) then
    poly_coefs = {-10.60617210417765, 365.2421759265393, -2.701502510496315e-08, 2.303900971263569e-12}
    amp = {0.1736157870707964, 1.914572713893651, 0.0113716862045686, 0.004885711219368455, 0.0004032584498264633, 0.001736052092601642, 0.002035081600709588, 0.001360448706185977}
    ph = {-2.012792258215681, 2.824063083728992, -0.4826844382278376, 0.9488391363261893, 2.646697770061209, -0.2675341497460084, 0.9646288791219602, -1.808852094435626}
  elseif (y > 1500) then
    poly_coefs = {-10.6111079510509, 365.2421925947405, -3.888654930760874e-08, -5.434707919089998e-12}
    amp = {0.1633918030382493, 1.95409759473169, 0.01184405584067255, 0.004842563463555804, 0.0004137082581449113, 0.001732513547029885, 0.002025850272284684, 0.001363226024948773}
    ph = {-1.767045717746641, 2.832417615687159, -0.465176623256009, 0.9461667782644696, 2.713020913181211, -0.2031148059020781, 0.9980808019332812, -1.832536089597202}
  end

  local sterm = {}
  for i=1, #solar_comp do
    local Ls = (y - 2000) + (i-1 + istart)/24.0
    local s = poly_coefs[1] + offset + Ls*(poly_coefs[2] + Ls*(poly_coefs[3] + Ls*poly_coefs[4]))
    for j=1, 8 do
      local ang = mod2pi_de(w[j] * Ls) + ph[j]
      s = s + amp[j] * math.sin(ang)
    end
    local s1 = math.floor((s-math.floor(s))*1440 + 0.5)
    local datetime = s1 + 1441 * math.floor(s) + solar_comp[i] - offset_comp
    local day = datetime // 1441
    local hourminute = datetime - 1441 * day
    local hour = hourminute // 60
    local minute = hourminute - 60 * hour
    local the_date = os.time({year=y, month=1, day=day, hour=hour, min=minute})
    table.insert(sterm, the_date)
  end
  return sterm
end

local function decode_moon_phases(y, offset_comp, lunar_comp, dp)
  local w = {2*math.pi, 6.733776, 13.467552, 0.507989, 0.0273143, 0.507984, 20.201328, 6.225791, 7.24176, 5.32461, 12.058386, 0.901181, 5.832595, 12.56637061435917, 19.300146, 11.665189, 18.398965, 6.791174, 13.636974, 1.015968, 6.903198, 13.07437, 1.070354, 6.340578614359172}
  local poly_coefs = {}
  local amp = {}
  local ph = {}
  if (y > 2500) then
    poly_coefs = {5.093879710922470, 29.53058981687484, 2.670339910922144e-11, 1.807808217274283e-15}
    amp = {0.00306380948959271, 6.08567588841838, 0.3023856209133756, 0.07481389897992345, 0.0001587661348338354, 0.1740759063081489, 0.0004131985233772993, 0.005796584475300004, 0.008268929076163079, 0.003256244384807976, 0.000520983165608148, 0.003742624708965854, 1.709506053530008, 28216.70389751519, 1.598844831045378, 0.314745599206173, 6.602993931108911, 0.0003387269181720862, 0.009226112317341887, 0.00196073145843697, 0.001457643607929487, 6.467401779992282e-05, 0.0007716739483064076, 0.001378880922256705}
    ph = {-0.0001879456766404132, -2.745704167588171, -2.348884895288619, 1.420037528559222, -2.393586904955103, -0.3914194006325855, 1.183088056748942, -2.782692143601458, 0.4430565056744425, -0.4357413971405519, -3.081209195003025, 0.7945051912707899, -0.4010911170136437, 3.003035462639878e-10, 0.4040070684461441, 2.351831380989509, 2.748612213507844, 3.133002890683667, -0.6902922380876192, 0.09563473131477442, 2.056490394534053, 2.017507533465959, 2.394015964756036, -0.3466427504049927}
  elseif (y > 1500) then
    poly_coefs = {5.097475813506625, 29.53058886049267, 1.095399949433705e-10, -6.926279905270773e-16}
    amp = {0.003064332812182054, 0.8973816160666801, 0.03119866094731004, 0.07068988004978655, 0.0001583070735157395, 0.1762683983928151, 0.0004131592685474231, 0.005950873973350208, 0.008489324571543966, 0.00334306526160656, 0.00052946042568393, 0.003743585488835091, 0.2156913373736315, 44576.30467073629, 0.1050203948601217, 0.01883710371633125, 0.380047745859265, 0.0003472930592917774, 0.009225665415301823, 0.002061407071938891, 0.001454599562245767, 5.856419090840883e-05, 0.0007688706809666596, 0.001415547168551922}
    ph = {-0.0003231124735555465, 0.380955331199635, 0.762645225819612, 1.4676293538949, -2.15595770830073, -0.3633370464549665, 1.134950591549256, -2.808169363709888, 0.422381840383887, -0.4226859182049138, -3.091797336860658, 0.7563140142610324, -0.3787677293480213, 1.863828515720658e-10, 0.3794794147818532, -0.7671105159156101, -0.3850942687637987, -3.098506117162865, -0.6738173539748421, 0.09011906278589261, 2.089832317302934, 2.160228985413543, -0.6734226930504117, -0.3333652792566645}
  end

  local jd0 = getJD(y-1,12,31) - 1.0/3
  local delta_T = DeltaT((jd0-2451545 + 365.25*0.5)/36525)
  local offset = 2451545 - jd0 - delta_T
  local lsyn = 29.5306
  local p0 = lunar_comp[1]
  local jdL0 = 2451550.259469 + 0.5*p0*lsyn

  -- Find the lunation number of the first moon phase in the year
  local Lm0 = math.floor((jd0 + 1 - jdL0)/lsyn)-1
  local Lm = 0
  local s = 0
  local s1 = 0
  for i=1, 10 do
    Lm = Lm0 + 0.5*p0 + i-1
    s = poly_coefs[1] + offset + Lm*(poly_coefs[2] + Lm*(poly_coefs[3] + Lm*poly_coefs[4]))
    for j=1, 24 do
      local ang = mod2pi_de(w[j]*Lm) + ph[j]
      s = s + amp[j]*math.sin(ang)
    end
    s1 = math.floor((s-math.floor(s))*1440 + 0.5)
    s = s1 + 1441*math.floor(s) + lunar_comp[2] - offset_comp
    if (s > 1440) then
      break
    end
  end
  Lm0 = Lm
  local mphase = {}
  -- Now decompress the remaining moon-phase times
  for i=2, #lunar_comp do
    Lm = Lm0 + (i-2)*dp
    s = poly_coefs[1] + offset + Lm*(poly_coefs[2] + Lm*(poly_coefs[3] + Lm*poly_coefs[4]))
    for j=1, 24 do
      local ang = mod2pi_de(w[j]*Lm) + ph[j]
      s = s + amp[j]*math.sin(ang)
    end
    s1 = math.floor((s-math.floor(s))*1440 + 0.5)
    local datetime = s1 + 1441*math.floor(s) + lunar_comp[i] - offset_comp
    local day = datetime // 1441
    local hourminute = datetime - 1441 * day
    local hour = hourminute // 60
    local minute = hourminute - 60 * hour
    local the_date = os.time({year=y, month=1, day=day, hour=hour, min=minute})
    table.insert(mphase, the_date)
  end
  return mphase
end

local function solar_terms_in_year(year)
  -- year in [2000, 2500]
  return decode_solar_terms(year, 0, 5, sun_data[year + 1 - 2000])
end

local function moon_phase_in_year(year)
  -- year in [2000, 2500]
  return decode_moon_phases(year, 5, moon_data[year + 1 - 2000], 0.5), moon_data[year + 1 - 2000][1]
end

local function union(a, b)
  local result = {}
  for k,v in pairs ( a ) do
    table.insert( result, v )
  end
  for k,v in pairs ( b ) do
     table.insert( result, v )
  end
  return result
end

function slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced+1] = tbl[i]
  end

  return sliced
end

local function stride(old_table, steplength)
  local new_table = {}
  local i = 0
  while i < #old_table do
    table.insert(new_table, old_table[i])
    i = i + 2
  end
  return new_table
end

local function datetime_to_date(datetime)
  local date_table = os.date("*t",datetime)
  date_table["hour"] = 0
  date_table["min"] = 0
  date_table["sec"] = 0
  return os.time(date_table)
end

local function to_local_timezone(time, tz)
  local unformated = os.date("%z")
  local sign, hours, minutes = string.match(unformated, "(-?)(%d%d)(%d%d)")
  hours = tonumber(hours)
  minutes = tonumber(minutes)
  if (sign == "-") then
    hours = -hours
    minutes = -minutes
  end
  local date_table = os.date("*t",time)
  date_table["hour"] = date_table["hour"] - tz + hours
  date_table["min"] = date_table["min"] + minutes
  return os.time(date_table)
end

local function ranked_index(date, dates)
  local i = 1
  while i <= #dates do
    if (to_local_timezone(dates[i], 8) > date) then
      break
    end
    i = i + 1
  end
  local date_diff = datetime_to_date(date) - datetime_to_date(to_local_timezone(dates[i - 1], 8))
  return i - 1, math.floor(date_diff / 3600 / 24 + 0.5)
end

local function chinese_number(num)
  local zhChar = {'一','二','三','四','五','六','七','八','九'}
  local places = {'','十','百','千','萬','十','百','千','億','十','百','千','萬'}
  if  type(num) ~=  'number' then
    return num .. 'is not a num'
  end
  local numStr = tostring(num)
  local len = string.len(numStr)
  local str = ''
  local has0 = false
  for i = 1, len do
    local n = tonumber(string.sub(numStr,i,i))
    local p = len - i + 1
    --連續多個零衹顯示一個
    if n > 0 and has0 == true then
      str = str .. '零'
      has0 = false
    end
    --十位數如果是首位則不顯示一十這樣的
    if p % 4 == 2 and n == 1 then
      if len > p then
        str = str .. zhChar[n]
      end
      str = str .. places[p]
    elseif n > 0 then
      str = str .. zhChar[n]
      str = str .. places[p]
    elseif n == 0 then
      --個位是零則補單位
      if p % 4 == 1 then
        str = str .. places[p]
      else
        has0 = true
      end
    end
  end
  return str
end

local function chinese_calendar_months(year)
  local moon_phase_previous_year, first_event = moon_phase_in_year(year - 1)
  local moon_phase = moon_phase_in_year(year)
  local moon_phase_next_year = moon_phase_in_year(year + 1)
  moon_phase = union(moon_phase_previous_year, union(moon_phase, {moon_phase_next_year[1]}))
  moon_phase = slice(moon_phase, first_event + 1, #moon_phase, 2)
  local solar_terms = solar_terms_in_year(year)
  local solar_terms_next_year = solar_terms_in_year(year + 1)
  solar_terms = union(solar_terms, solar_terms_next_year)
  solar_terms = stride(solar_terms, 2)

  local i = 7
  while i <= #moon_phase do
    if (solar_terms[1] < moon_phase[i]) then
      break
    end
    i = i + 1
  end
  moon_phase = slice(moon_phase, i - 1, #moon_phase)
  local months = {}
  i = 7
  while i <= #moon_phase do
    if (solar_terms[13] < moon_phase[i]) then
      break
    end
    i = i + 1
  end
  local month_in_year = i
  if (month_in_year == 14) then
    months = slice(union(month_chinese, month_chinese), 1, #moon_phase)
  elseif (month_in_year == 15) then
    local i = 1
    local j = 1
    local count = 0
    local solatice_in_month = {}
    while (i+1 <= #moon_phase) and (j <= #solar_terms) do
      if ((moon_phase[i] <= solar_terms[j]) and (moon_phase[i+1] > solar_terms[j])) then
        count = count + 1
        j = j + 1
      else
        table.insert(solatice_in_month, count)
        count = 0
        i = i + 1
      end
    end
    local leap = 0
    local leapLabel = ""
    for i=1, #solatice_in_month do
      if ((solatice_in_month[i] == 0) and leap == 0) then
        leap = 1
        leapLabel = "閏"
      else
        leapLabel = ""
      end
      local month_name = leapLabel .. month_chinese[(i -1 - leap) % 12 + 1]
      if (month_name == "閏正月") then
        month_name = "閏一月"
      end
      table.insert(months, month_name)
    end
  end
  return moon_phase, months
end

local function utc_timezone(unformated)
  local sign, hours, minutes = string.match(unformated, "(-?)(%d%d)(%d%d)")
  local fraction_hours = tonumber(hours) + tonumber(minutes) / 60
  if (sign == "") then
    sign = "+"
  end
  local timezone = "UTC " .. sign .. tostring(fraction_hours)
  timezone = string.gsub(timezone, "%.?0+$", "")
  return timezone
end

local function chinese_weekday(wday)
  local wday_num = tonumber(wday) + 1
  local chinese_weekdays = {"日", "月", "火", "水", "木", "金", "土"}
  return chinese_weekdays[wday_num]
end

local function time_to_num(time)
  local pattern = "(%d+):(%d+) +([AP]M)"
  if string.match(time, pattern) ~= nil then
    local hours, minutes, am = string.match(time, pattern)
    if ((am == "AM") and (tonumber(hours) >= 12)) then
      hours = hours - 12
    elseif ((am == "PM") and (tonumber(hours) < 12)) then
      hours = hours + 12
    end
  else
    pattern = "(%d+):(%d+)"
    hours, minutes = string.match(time, pattern)
  end
  return (hours*60) + minutes
end

local function time_description_chinese(time)
  local time_table = os.date("*t", time)
  local time_in_seconds = time_table["hour"] * 3600 + time_table["min"] * 60 + time_table["sec"]
  local time_in_hours = time_in_seconds // 3600
  local chinese_half_hours = {"初", "正"}
  local chinese_hour = terrestrial_branches[(time_in_hours + 1) % 24 // 2 + 1] .. chinese_half_hours[(time_in_hours + 1) % 2 + 1]
  local percent_day = time_in_seconds // 864
  percent_day = percent_day_chinese[percent_day + 1]
  if (chinese_hour == percent_day[1]) then
    if (#percent_day > 1) then
      return  percent_day[1] .. percent_day[2]
    else
       return percent_day[1]
    end
  else
    return chinese_hour
  end
end

-- 西曆轉農曆
local function to_chinese_cal_local(time)
  --西曆每月初已歷天数
  local month_cum_passed_days = {0,31,59,90,120,151,181,212,243,273,304,334}
  local curr_year = tonumber(os.date("%Y", time))
  local curr_month = tonumber(os.date("%m", time))
  local curr_day = tonumber(os.date("%d", time))
  local days_since_reference_day = (curr_year - 1921) * 365 + math.floor((curr_year - 1921) / 4) + curr_day + month_cum_passed_days[curr_month] - 38
  if (((curr_year % 4) == 0) and (curr_month > 2)) then
    days_since_reference_day = days_since_reference_day + 1
  end
  local celeterre_date = celestial_stems[(days_since_reference_day - 3) % 10 + 1] .. terrestrial_branches[(days_since_reference_day + 1) % 12 + 1]

  local eclipse, months = chinese_calendar_months(tonumber(os.date("%Y", time)))
  local month_index, day_index = ranked_index(time, eclipse)
  local chinese_month = months[month_index]
  local chinese_day = day_chinese[day_index+1]
  if ((chinese_month == "冬月") or (chinese_month == "閏冬月") or (chinese_month == "臘月") or (chinese_month == "閏臘月")) then
    curr_year = curr_year - 1
  end
  local chinese_year = celestial_stems[(((curr_year - 4) % 60) % 10)+1] .. terrestrial_branches[(((curr_year - 4) % 60) % 12) + 1] .. "年"
  return chinese_year .. chinese_month .. chinese_day, celeterre_date, chinese_year, chinese_month, chinese_day
end

-- local function to_chinese_cal(year, month, day)
--   --西曆每月初已歷天数
--   local month_cum_passed_days = {0,31,59,90,120,151,181,212,243,273,304,334}
--   --華曆數據
--   local chinese_cal_data = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
--   ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
--   ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
--   ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
--   ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
--   ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
--   ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
--   ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
--   ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
--   ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877}

--   local curr_year, curr_month, curr_day;
--   local days_since_reference_day, is_end, m, k, n, i, bit;
--   local chinese_year, chinese_date, celeterre_date;
--   --取西曆年、月、日
--   local curr_year = tonumber(year);
--   local curr_month = tonumber(month);
--   local curr_day = tonumber(day);
--   --計算自1921年2月8日正月初一已歷天數
--   local days_since_reference_day = (curr_year - 1921) * 365 + math.floor((curr_year - 1921) / 4) + curr_day + month_cum_passed_days[curr_month] - 38
--   if (((curr_year % 4) == 0) and (curr_month > 2)) then
--     days_since_reference_day = days_since_reference_day + 1
--   end

--   --干支計日
--   local celeterre_date = celestial_stems[(days_since_reference_day - 3) % 10 + 1] .. terrestrial_branches[(days_since_reference_day + 1) % 12 + 1]
--   --計算華曆天干、地支、月、日
--   local is_end = 0;
--   local m = 0;
--   while is_end ~= 1 do
--     if chinese_cal_data[m+1] < 4095 then
--       k = 11;
--     else
--       k = 12;
--     end
--     n = k;
--     while n >= 0 do
--       --獲取chinese_cal_data(m)的第n個二進制位值
--       bit = chinese_cal_data[m + 1];
--       for i=1, n do
--         bit = math.floor(bit / 2);
--       end
--       bit = bit % 2;
--       if days_since_reference_day <= (29 + bit) then
--         is_end = 1;
--         break
--       end
--       days_since_reference_day = days_since_reference_day - 29 - bit;
--       n = n - 1;
--     end
--     if is_end ~= 0 then
--       break;
--     end
--     m = m + 1;
--   end

--   curr_year = 1921 + m;
--   curr_month = k - n + 1;
--   curr_day = days_since_reference_day;
--   if k == 12 then
--     if curr_month == math.floor(chinese_cal_data[m+1] / 65536) + 1 then
--       curr_month = 1 - curr_month;
--     elseif curr_month > math.floor(chinese_cal_data[m+1] / 65536) + 1 then
--       curr_month = curr_month - 1;
--     end
--   end
--   curr_day = math.floor(curr_day)
--   --華曆天干、地支 -> chinese_year
--   chinese_year = celestial_stems[(((curr_year - 4) % 60) % 10)+1] .. terrestrial_branches[(((curr_year - 4) % 60) % 12) + 1] .. "年"

--   --華曆月、日 -> chinese_date
--   if curr_month < 1 then
--     chinese_date = "閏" .. month_chinese[(-1 * curr_month) + 1]
--   else
--     chinese_date = month_chinese[curr_month+1]
--   end

--   chinese_date = chinese_date .. "月" .. day_chinese[curr_day+1]
--   return chinese_year .. chinese_date, celeterre_date
-- end

local function date_diff_chinese(diff)
  local desp
  if (diff > 2) then
    desp = chinese_number(diff) .. "日後"
  elseif (diff == 2) then
    desp = "後日"
  elseif (diff == 1) then
    desp = "明日"
  elseif (diff == 0) then
    desp = "今日"
  elseif (diff == -1) then
    desp = "昨日"
  elseif (diff == -2) then
    desp = "前日"
  elseif (diff < -2) then
    desp = chinese_number(-diff) .. "日前"
  end
  return desp
end

-- 月相（圖示）
local function Moonphase_out1()
  local moon_phase_previous = moon_phase_in_year(tonumber(os.date("%Y")) - 1)
  local moon_phase, first_event = moon_phase_in_year(tonumber(os.date("%Y")))
  local moon_phase_next = moon_phase_in_year(tonumber(os.date("%Y")) + 1)
  local moon_phase = union({moon_phase_previous[#moon_phase_previous]}, union(moon_phase, {moon_phase_next[1]}))
  local first_event = 1 - first_event
  local index = ranked_index(os.time(), moon_phase)

  local date_diff_to_previous = os.time() - to_local_timezone(moon_phase[index], 8)
  local date_diff_to_approaching = to_local_timezone(moon_phase[index+1], 8) - os.time()
  local moon_phase_fraction = date_diff_to_previous / (date_diff_to_previous + date_diff_to_approaching) * 0.5
  if ((first_event + index - 1) % 2 == 1) then
    moon_phase_fraction = moon_phase_fraction + 0.5
  end
  local moon_phase_emojis = {"🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘"}
  local choice = math.floor((moon_phase_fraction * 8 + 0.5) % 8.0) + 1
  local Moonphase1 = moon_phase_emojis[choice]
  local Moonphase2 = string.format("%.f °", moon_phase_fraction * 360)
  return Moonphase1, Moonphase2
end

-- 月相（朔望文字）
local function Moonphase_out2()
  local moon_phase_previous = moon_phase_in_year(tonumber(os.date("%Y")) - 1)
  local moon_phase, first_event = moon_phase_in_year(tonumber(os.date("%Y")))
  local moon_phase_next = moon_phase_in_year(tonumber(os.date("%Y")) + 1)
  local moon_phase = union({moon_phase_previous[#moon_phase_previous]}, union(moon_phase, {moon_phase_next[1]}))
  local first_event = 1 - first_event
  local index = ranked_index(os.time(), moon_phase)
  local luna_event_names = {"朔", "望"}

  local previous_lunar_event = luna_event_names[(first_event + index - 1) % 2 + 1]
  local date_diff_to_previous = datetime_to_date(os.time()) - datetime_to_date(to_local_timezone(moon_phase[index], 8))
  local date_diff_to_previous = math.floor(date_diff_to_previous // 3600 //24 + 0.5)
  local date_diff_to_previous = date_diff_chinese(-date_diff_to_previous)
  local date_diff_to_previous = date_diff_to_previous .. time_description_chinese(to_local_timezone(moon_phase[index], 8))
  return previous_lunar_event, date_diff_to_previous
end

-- 前後節氣（文字）
local function jieqi_out1()
  local solar_terms = solar_terms_in_year(tonumber(os.date("%Y")))
  local solar_terms_next = solar_terms_in_year(tonumber(os.date("%Y")) + 1)
  local solar_terms = union(solar_terms, slice(solar_terms_next, 1, 2))
  local index = ranked_index(os.time(), solar_terms)

  local previous_solar_event = solar_term_chinese[index]
  local date_diff_to_previous = datetime_to_date(os.time()) - datetime_to_date(to_local_timezone(solar_terms[index], 8))
  local date_diff_to_previous = math.floor(date_diff_to_previous // 3600 //24 + 0.5)
  local date_diff_to_previous = date_diff_chinese(-date_diff_to_previous)
  local date_diff_to_previous = date_diff_to_previous .. time_description_chinese(to_local_timezone(solar_terms[index], 8))
  -- local candidate = Candidate("date", seg.start, seg._end, previous_solar_event, date_diff_to_previous)

  local approching_solar_event = solar_term_chinese[index+1]
  local date_diff_to_approaching = datetime_to_date(to_local_timezone(solar_terms[index+1], 8)) - datetime_to_date(os.time())
  local date_diff_to_approaching = math.floor(date_diff_to_approaching // 3600 //24 + 0.5)
  local date_diff_to_approaching = date_diff_chinese(date_diff_to_approaching)
  local date_diff_to_approaching = date_diff_to_approaching .. time_description_chinese( to_local_timezone(solar_terms[index+1], 8))
  -- candidate = Candidate("date", seg.start, seg._end, approching_solar_event, date_diff_to_approaching)
  return previous_solar_event, date_diff_to_previous, approching_solar_event, date_diff_to_approaching
end

-- 上下午時間
local function time_out1()
  local time = os.time()
  -- local time_string = string.gsub(os.date("%H:%M", time), "^0+", "")
  -- local time_discrpt = time_description_chinese(time)
  -- local candidate = Candidate("time", seg.start, seg._end, time_string, time_discrpt)
  local time_string = string.gsub(os.date("%I:%M %p", time), "^0+", "")
  local time_string_2 = string.gsub(time_string, "AM", "a.m.")
  local time_string_2 = string.gsub(time_string_2, "PM", "p.m.")
  local time_string_3 = string.gsub(time_string, "AM", "A.M.")
  local time_string_3 = string.gsub(time_string_3, "PM", "P.M.")
  local time_string_4 = string.gsub(time_string, "AM", "am")
  local time_string_4 = string.gsub(time_string_4, "PM", "pm")

  local time_string_5 = string.gsub(os.date("%I:%M:%S %p", time), "^0+", "")
  local time_string_6 = string.gsub(time_string_5, "AM", "a.m.")
  local time_string_6 = string.gsub(time_string_6, "PM", "p.m.")
  local time_string_7 = string.gsub(time_string_5, "AM", "A.M.")
  local time_string_7 = string.gsub(time_string_7, "PM", "P.M.")
  local time_string_8 = string.gsub(time_string_5, "AM", "am")
  local time_string_8 = string.gsub(time_string_8, "PM", "pm")
  -- candidate = Candidate("time", seg.start, seg._end, time_string, time_discrpt)
  return time_string, time_string_2, time_string_3, time_string_4 , time_string_5, time_string_6, time_string_7, time_string_8
end

-- 時區
local function timezone_out1()
  local timezone = utc_timezone(os.date("%z"))
  local timezone_discrpt = os.date("%Z")
  -- local candidate = Candidate("timezone", seg.start, seg._end, timezone, timezone_discrpt)
  return timezone, timezone_discrpt
end




--- @@ date/t translator
--[[
掛載 t_translator 函數開始
--]]
function t_translator(input, seg)
  if (string.match(input, "`")~=nil) then
    -- 先展示星期，以便後面使用
    if (os.date("%w") == "0") then
      weekstr = "日"
      weekstr_c = "日"
      weekstr_jp1 = "㈰"
      weekstr_jp2 = "㊐"
      weekstr_jp3 = "日"
      weekstr_eng1 = "Sunday"
      weekstr_eng2 = "Sun."
      weekstr_eng3 = "Sun"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
      weekstr_c = "壹"
      weekstr_jp1 = "㈪"
      weekstr_jp2 = "㊊"
      weekstr_jp3 = "月"
      weekstr_eng1 = "Monday"
      weekstr_eng2 = "Mon."
      weekstr_eng3 = "Mon"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
      weekstr_c = "貳"
      weekstr_jp1 = "㈫"
      weekstr_jp2 = "㊋"
      weekstr_jp3 = "火"
      weekstr_eng1 = "Tuesday"
      weekstr_eng2 = "Tues."
      weekstr_eng3 = "Tues"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
      weekstr_c = "參"
      weekstr_jp1 = "㈬"
      weekstr_jp2 = "㊌"
      weekstr_jp3 = "水"
      weekstr_eng1 = "Wednesday"
      weekstr_eng2 = "Wed."
      weekstr_eng3 = "Wed"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
      weekstr_c = "肆"
      weekstr_jp1 = "㈭"
      weekstr_jp2 = "㊍"
      weekstr_jp3 = "木"
      weekstr_eng1 = "Thursday"
      weekstr_eng2 = "Thur."
      weekstr_eng3 = "Thur"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
      weekstr_c = "伍"
      weekstr_jp1 = "㈮"
      weekstr_jp2 = "㊎"
      weekstr_jp3 = "金"
      weekstr_eng1 = "Friday"
      weekstr_eng2 = "Fri."
      weekstr_eng3 = "Fri"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
      weekstr_c = "陸"
      weekstr_jp1 = "㈯"
      weekstr_jp2 = "㊏"
      weekstr_jp3 = "土"
      weekstr_eng1 = "Saturday"
      weekstr_eng2 = "Sat."
      weekstr_eng3 = "Sat"
    end

    -- Candidate(type, start, end, text, comment)
    if (input == "`t") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~d"))
      local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime6 , "〔時:分:秒〕 ~m"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕 ~c"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~z"))
      return
    end

    if (input == "`td") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      return
    end

    if (input == "`tm") then
      local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime6 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime8 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime7 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime5 , "〔時:分:秒〕"))
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

    if (input == "`u") then
      local tz, tzd = timezone_out1()
      yield(Candidate("time", seg.start, seg._end, tz, tzd))
      return
    end

    if (input == "`n") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~d"))
      local aptime1, aptime2, aptime3, aptime4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime2, "〔時:分〕 ~m"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕 ~c"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~z"))
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, chinese_time, "〔農曆！〕 ~l"))
      return
    end

    if (input == "`nd") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      return
    end

    if (input == "`nm") then
      local aptime1, aptime2, aptime3, aptime4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime2, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime4, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime3, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime1, "〔時:分〕"))
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
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, chinese_time, "〔農曆！〕"))
      return
    end

    -- if (input == "`ns") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
    --   return
    -- end

    if (input == "`l") then
      local Moonshape, Moonangle = Moonphase_out1()
      yield(Candidate("date", seg.start, seg._end, Moonshape, Moonangle))
      local p, d = Moonphase_out2()
      yield(Candidate("date", seg.start, seg._end, p, d))
      return
    end

    if (input == "`s") then
      local jq1, jq2, jq3 ,jq4 = jieqi_out1()
      yield(Candidate("date", seg.start, seg._end, jq1, jq2))
      yield(Candidate("date", seg.start, seg._end, jq3, jq4))
      return
    end

    if (input == "`f") then
      local chinese_date = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_date, "〔農曆！〕 ~l"))
      return
    end

    if (input == "`fl") then
      local chinese_date = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_date, "〔農曆！〕"))
      return
    end

    if (input == "`fj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕"))
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
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1"), "〔*年月日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日"), "〔*年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年"), "〔*日月年〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年"), "〔*月日年〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(), "〔年月日〕"))
      return
    end

    if (input == "`fn") then
      local chinese_date = to_chinese_cal_local(os.time())
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_date .." ".. chinese_time, "〔農曆！〕 ~l"))
      return
    end

    if (input == "`fnl") then
      local chinese_date = to_chinese_cal_local(os.time())
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_date .." ".. chinese_time, "〔農曆！〕"))
      -- yield(Candidate("date", seg.start, seg._end, chinese_date .. chinese_time, "〔農曆！〕"))
      return
    end

    if (input == "`fnj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕"))
      return
    end

    if (input == "`fnc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分"), "([^%d])0", "%1"), "〔*年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分"), "([^%d])0", "%1")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分"), "〔*年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分", "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H 點 %M 分"), "〔*日月年 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H 點 %M 分"), "〔*月日年 時:分〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕"))
      return
    end

    if (input == "`ft") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕 ~j"))
      return
    end

    if (input == "`ftj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕"))
      return
    end

    if (input == "`ftc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒"), "([^%d])0", "%1"), "〔*年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分%S秒"), "([^%d])0", "%1")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒"), "〔*年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分%S秒"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分"..fullshape_number(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H 點 %M 分 %S 秒"), "〔*日月年 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H 點 %M 分 %S 秒"), "〔*月日年 時:分:秒〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔年月日 時:分〕"))
      return
    end

    if (input == "`y") then
      local a, b, chinese_y = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, chinese_y, "〔農曆！〕 ~l"))
      return
    end

    if (input == "`yl") then
      local a, b, chinese_y = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_y, "〔農曆！〕"))
      return
    end

    if (input == "`yc") then
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年"), "〔*年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年", "〔年〕"))
      return
    end

    if (input == "`yd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")), "〔年〕"))
      return
    end

    if (input == "`yz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      return
    end

    if (input == "`m") then
      local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0+", ""), "〔月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_m, "〔農曆！〕 ~l"))
      return
    end

    if (input == "`ml") then
      local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_m, "〔農曆！〕"))
      return
    end

    if (input == "`ma") then
      yield(Candidate("date", seg.start, seg._end, " "..eng1_m_date(os.date("%m")).." ", "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`me") then
      yield(Candidate("date", seg.start, seg._end, " "..eng2_m_date(os.date("%m")).." ", "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng3_m_date(os.date("%m")).." ", "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`mj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`mc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月"), "([ ])0+", "%1"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0+", ""), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月"), "^0+", "")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月", "〔月〕"))
      return
    end

    if (input == "`mm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`mz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      return
    end

    if (input == "`d") then
      local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0+", ""), "〔日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_d, "〔農曆！〕 ~l"))
      return
    end

    if (input == "`dl") then
      local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_d, "〔農曆！〕"))
      return
    end

    if (input == "`da") then
      yield(Candidate("date", seg.start, seg._end, " the "..eng1_d_date(os.date("%d")).." ", "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " The "..eng1_d_date(os.date("%d")).." ", "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "`de") then
      yield(Candidate("date", seg.start, seg._end, " "..eng2_d_date(os.date("%d")).." ", "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng4_d_date(os.date("%d")).." ", "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, eng4_d_date(os.date("%d")), "〔日〕"))
      -- yield(Candidate("date", seg.start, seg._end, " "..eng3_d_date(os.date("%d")).." ", "〔*日〕"))
      return
    end

    if (input == "`dj") then
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "`dc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %d 日"), "([ ])0+", "%1"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0+", ""), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%d日"), "^0+", "")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %d 日"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")).."日", "〔日〕"))
      return
    end

    if (input == "`dd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "`dz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      return
    end

    if (input == "`md") then
      local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "^0+", ""), "〔月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_m .. chinese_d, "〔農曆！〕 ~l"))
      return
    end

    if (input == "`mdl") then
      local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_m .. chinese_d, "〔農曆！〕"))
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
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕"))
      return
    end

    if (input == "`mdc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日"), "([ ])0+", "%1"), "〔*月日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "^0+", ""), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "^0+", "")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日"), "〔*月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月"), "〔*日月〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23), "〔月日〕"))
      return
    end

    if (input == "`mdw") then
      local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "^0+", "").." ".."星期"..weekstr.." ", "〔月日週〕 ~c"))
      -- yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_m..chinese_d.." "..weekstr_jp3.." ", "〔農曆！〕 ~l"))
      return
    end

    if (input == "`mdwl") then
      local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_m..chinese_d.." "..weekstr_jp3.." ", "〔農曆！〕"))
      return
    end

    if (input == "`mdwa") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng3.." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔週月日〕"))
      return
    end

    if (input == "`mdwe") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月〕"))
      return
    end

    if (input == "`mdwc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日"), "([ ])0+", "%1").." ".."星期"..weekstr.." ", "〔*月日週〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "^0+", "").." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "^0+", "")).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日").." ".."星期"..weekstr.." ", "〔*月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日".." ".."星期"..weekstr.." ", "〔月日週〕"))
      return
    end

    if (input == "`mdwj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." "..weekstr_jp3.."曜日 ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."("..weekstr_jp3.."曜日)", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."（"..weekstr_jp3.."曜日）", "〔月日週〕"))
      return
    end

    if (input == "`mdwz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr_c.." ", "〔月日週〕"))
      return
    end

    if (input == "`ym") then
      local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_y .. chinese_m, "〔農曆！〕 ~l"))
      return
    end

    if (input == "`yml") then
      local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_y .. chinese_m, "〔農曆！〕"))
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
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月"), "([^%d])0", "%1"), "〔*年月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月"), "〔*年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月", "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %Y 年"), "〔*月年〕"))
      return
    end

    if (input == "`ymj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(12), "〔年月〕"))
      return
    end

-- function week_translator0(input, seg)
    if (input == "`w") then
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstr, "〔週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕 ~a"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕 ~e"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕 ~j"))
      return
    end

    if (input == "`wa") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng1.." ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕"))
      return
    end

    if (input == "`we") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng2.." ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng3.." ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng3, "〔週〕"))
      return
    end

    if (input == "`wc") then
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr.." ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstr, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."星期"..weekstr..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."星期"..weekstr.."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr_c.." ", "〔*週〕"))
      return
    end

    if (input == "`wj") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_jp3.."曜日 ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "("..weekstr_jp3.."曜日)", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（"..weekstr_jp3.."曜日）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp1, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp2, "〔週〕"))
      return
    end

-- function week_translator1(input, seg)
    if (input == "`fw") then
      local chinese_date = to_chinese_cal_local(os.time())
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔年月日週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕 ~z"))
      -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕 ~e"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕 ~j"))
      yield(Candidate("qsj", seg.start, seg._end, chinese_date.." "..weekstr_jp3.." ", "〔農曆！〕 ~l"))
      return
    end

    if (input == "`fwl") then
      local chinese_date = to_chinese_cal_local(os.time())
      yield(Candidate("qsj", seg.start, seg._end, chinese_date.." "..weekstr_jp3.." ", "〔農曆！〕"))
      return
    end

    if (input == "`fwa") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng3.." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      return
    end

    if (input == "`fwe") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      return
    end

    if (input == "`fwc") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔*年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")).." 星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." ", "〔*年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." ", "〔年月日週〕"))
      return
    end

    if (input == "`fwj") then
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕"))
      -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."("..weekstr_jp3.."曜日)", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."（"..weekstr_jp3.."曜日）", "〔年月日週〕"))
      return
    end

    if (input == "`fwz") then
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr_c.." ", "〔年月日週〕"))
      return
    end

-- function week_translator2(input, seg)
    -- if (input == "`fwt") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end

    -- if (input == "`fwtz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end
-- function week_translator3(input, seg)
    -- if (input == "`fwn") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔*年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

    -- if (input == "`fwnz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
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
      , { '  s〔節氣〕  l〔月相〕  u〔時區〕', '⑤' }
      , { '  ○○○〔數字〕', '⑥' }
      , { '  ○/○/○〔 ○ 年 ○ 月 ○ 日〕  ○/○〔 ○ 月 ○ 日〕', '⑦' }
      , { '  ○-○-○〔○年○月○日〕  ○-○〔○月○日〕', '⑧' }
      , { '  / [a-z]+〔小寫字母〕', '⑨' }
      , { '  ; [a-z]+〔大寫字母〕', '⑩' }
      , { '  \' [a-z]+〔開頭大寫字母〕', '⑪' }
      , { '  x [0-9abcdef]+〔內碼十六進制 Hex〕', '⑫' }
      , { '  c [0-9]+〔內碼十進制 Dec〕', '⑬' }
      , { '  o [0-7]+〔內碼八進制 Oct〕', '⑭' }
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
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9abcdef]+〔內碼十六進制 Hex〕")
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
        fmt = "U+".."%X"
      elseif ( utf_o ~= nil) then
        fmt = "0o".."%o"
      else
        fmt = "&#".."%d"..";"
      end
      -- 單獨查找
      yield(Candidate("number", seg.start, seg._end, utf8_out(c), string.format(fmt, c) ))
      -- 區間查找
      if c*n_bit+n_bit-1 < 1048575 then
        for i = c*n_bit, c*n_bit+n_bit-1 do
          yield(Candidate("number", seg.start, seg._end, utf8_out(i), string.format(fmt, i) ))
        end
      end
    end

    local y, m, d = string.match(input, "`(%d+)/(%d?%d)/(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
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
      yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      if(chinese_date_input~=nil) then
        yield(Candidate("date", seg.start, seg._end, chinese_date_input, "〔農曆！〕"))
      end
      return
    end

    local m, d = string.match(input, "`(%d?%d)/(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期〕"))
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
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
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      return
    end

    local y, m, d = string.match(input, "`(%d+)-(%d?%d)-(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
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
      yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      if(chinese_date_input~=nil) then
        yield(Candidate("date", seg.start, seg._end, chinese_date_input, "〔農曆！〕"))
      end
      -- local chinese_date_input2 = to_chinese_cal(y, m, d)
      -- if(chinese_date_input2~=nil) then
      --   yield(Candidate("date", seg.start, seg._end, chinese_date_input2 .. " ", "〔農曆！〕"))
      -- end
      return
    end

    local m, d = string.match(input, "`(%d?%d)-(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
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
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      return
    end

    local numberout = string.match(input, "`(%d+)$")
    local nn = string.sub(numberout, 1)
    if (numberout~=nil) and (tonumber(nn)) ~= nil then
      yield(Candidate("number", seg.start, seg._end, numberout , "〔一般數字〕"))
      yield(Candidate("number", seg.start, seg._end, fullshape_number(numberout), "〔全形數字〕"))
      yield(Candidate("number", seg.start, seg._end, math1_number(numberout), "〔數學粗體數字〕"))
      yield(Candidate("number", seg.start, seg._end, math2_number(numberout), "〔數學空心數字〕"))
      yield(Candidate("number", seg.start, seg._end, little1_number(numberout), "〔上標數字〕"))
      yield(Candidate("number", seg.start, seg._end, little2_number(numberout), "〔下標數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled1_number(numberout), "〔帶圈數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled2_number(numberout), "〔帶圈無襯線數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled3_number(numberout), "〔反白帶圈數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled4_number(numberout), "〔反白帶圈無襯線數字〕"))
      for _, conf in ipairs(confs) do
        local r = read_number(conf, nn)
        yield(Candidate("number", seg.start, seg._end, r, conf.comment))
      end
      yield(Candidate("number", seg.start, seg._end, purech_number(numberout), "〔純中文數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled5_number(numberout), "〔帶圈中文數字〕"))
      --[[ 用 yield 產生一個候選項
      候選項的構造函數是 Candidate，它有五個參數：
      - type: 字符串，表示候選項的類型（可隨意取）
      - start: 候選項對應的輸入串的起始位置
      - _end:  候選項對應的輸入串的結束位置
      - text:  候選項的文本
      - comment: 候選項的注釋
      --]]
      -- local k = string.sub(numberout, 1, -1) -- 取參數
      local result = formatnumberthousands(numberout) --- 調用算法
      yield(Candidate("number", seg.start, seg._end, result, "〔千分位數字〕"))
      return
    end

  end
end




--- @@ date/t2 translator
--[[
掛載 t2_translator 函數開始
--]]
function t2_translator(input, seg)
  if (string.match(input, "'/")~=nil) then
    -- 先展示星期，以便後面使用
    if (os.date("%w") == "0") then
      weekstr = "日"
      weekstr_c = "日"
      weekstr_jp1 = "㈰"
      weekstr_jp2 = "㊐"
      weekstr_jp3 = "日"
      weekstr_eng1 = "Sunday"
      weekstr_eng2 = "Sun."
      weekstr_eng3 = "Sun"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
      weekstr_c = "壹"
      weekstr_jp1 = "㈪"
      weekstr_jp2 = "㊊"
      weekstr_jp3 = "月"
      weekstr_eng1 = "Monday"
      weekstr_eng2 = "Mon."
      weekstr_eng3 = "Mon"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
      weekstr_c = "貳"
      weekstr_jp1 = "㈫"
      weekstr_jp2 = "㊋"
      weekstr_jp3 = "火"
      weekstr_eng1 = "Tuesday"
      weekstr_eng2 = "Tues."
      weekstr_eng3 = "Tues"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
      weekstr_c = "參"
      weekstr_jp1 = "㈬"
      weekstr_jp2 = "㊌"
      weekstr_jp3 = "水"
      weekstr_eng1 = "Wednesday"
      weekstr_eng2 = "Wed."
      weekstr_eng3 = "Wed"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
      weekstr_c = "肆"
      weekstr_jp1 = "㈭"
      weekstr_jp2 = "㊍"
      weekstr_jp3 = "木"
      weekstr_eng1 = "Thursday"
      weekstr_eng2 = "Thur."
      weekstr_eng3 = "Thur"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
      weekstr_c = "伍"
      weekstr_jp1 = "㈮"
      weekstr_jp2 = "㊎"
      weekstr_jp3 = "金"
      weekstr_eng1 = "Friday"
      weekstr_eng2 = "Fri."
      weekstr_eng3 = "Fri"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
      weekstr_c = "陸"
      weekstr_jp1 = "㈯"
      weekstr_jp2 = "㊏"
      weekstr_jp3 = "土"
      weekstr_eng1 = "Saturday"
      weekstr_eng2 = "Sat."
      weekstr_eng3 = "Sat"
    end

    -- Candidate(type, start, end, text, comment)
    if (input == "'/t") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~d"))
      local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime6 , "〔時:分:秒〕 ~m"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕 ~c"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~z"))
      return
    end

    if (input == "'/td") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      return
    end

    if (input == "'/tm") then
      local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime6 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime8 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime7 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime5 , "〔時:分:秒〕"))
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

    if (input == "'/u") then
      local tz, tzd = timezone_out1()
      yield(Candidate("time", seg.start, seg._end, tz, tzd))
      return
    end

    if (input == "'/n") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~d"))
      local aptime1, aptime2, aptime3, aptime4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime2, "〔時:分〕 ~m"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕 ~c"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~z"))
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, chinese_time, "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/nd") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      return
    end

    if (input == "'/nm") then
      local aptime1, aptime2, aptime3, aptime4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime2, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime4, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime3, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime1, "〔時:分〕"))
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
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, chinese_time, "〔農曆！〕"))
      return
    end

    -- if (input == "'/ns") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
    --   return
    -- end

    if (input == "'/l") then
      local Moonshape, Moonangle = Moonphase_out1()
      yield(Candidate("date", seg.start, seg._end, Moonshape, Moonangle))
      local p, d = Moonphase_out2()
      yield(Candidate("date", seg.start, seg._end, p, d))
      return
    end

    if (input == "'/s") then
      local jq1, jq2, jq3 ,jq4 = jieqi_out1()
      yield(Candidate("date", seg.start, seg._end, jq1, jq2))
      yield(Candidate("date", seg.start, seg._end, jq3, jq4))
      return
    end

    if (input == "'/f") then
      local chinese_date = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_date, "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/fl") then
      local chinese_date = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_date, "〔農曆！〕"))
      return
    end

    if (input == "'/fj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕"))
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
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1"), "〔*年月日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日"), "〔*年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年"), "〔*日月年〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年"), "〔*月日年〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(), "〔年月日〕"))
      return
    end

    if (input == "'/fn") then
      local chinese_date = to_chinese_cal_local(os.time())
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_date .." ".. chinese_time, "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/fnl") then
      local chinese_date = to_chinese_cal_local(os.time())
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_date .." ".. chinese_time, "〔農曆！〕"))
      -- yield(Candidate("date", seg.start, seg._end, chinese_date .. chinese_time, "〔農曆！〕"))
      return
    end

    if (input == "'/fnj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕"))
      return
    end

    if (input == "'/fnc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分"), "([^%d])0", "%1"), "〔*年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分"), "([^%d])0", "%1")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分"), "〔*年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分", "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H 點 %M 分"), "〔*日月年 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H 點 %M 分"), "〔*月日年 時:分〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕"))
      return
    end

    if (input == "'/ft") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕 ~j"))
      return
    end

    if (input == "'/ftj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕"))
      return
    end

    if (input == "'/ftc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒"), "([^%d])0", "%1"), "〔*年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分%S秒"), "([^%d])0", "%1")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒"), "〔*年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分%S秒"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分"..fullshape_number(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H 點 %M 分 %S 秒"), "〔*日月年 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H 點 %M 分 %S 秒"), "〔*月日年 時:分:秒〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔年月日 時:分〕"))
      return
    end

    if (input == "'/y") then
      local a, b, chinese_y = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, chinese_y, "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/yl") then
      local a, b, chinese_y = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_y, "〔農曆！〕"))
      return
    end

    if (input == "'/yc") then
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年"), "〔*年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年", "〔年〕"))
      return
    end

    if (input == "'/yd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")), "〔年〕"))
      return
    end

    if (input == "'/yz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      return
    end

    if (input == "'/m") then
      local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0+", ""), "〔月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_m, "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/ml") then
      local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_m, "〔農曆！〕"))
      return
    end

    if (input == "'/ma") then
      yield(Candidate("date", seg.start, seg._end, " "..eng1_m_date(os.date("%m")).." ", "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/me") then
      yield(Candidate("date", seg.start, seg._end, " "..eng2_m_date(os.date("%m")).." ", "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng3_m_date(os.date("%m")).." ", "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/mj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/mc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月"), "([ ])0+", "%1"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0+", ""), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月"), "^0+", "")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月", "〔月〕"))
      return
    end

    if (input == "'/mm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/mz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      return
    end

    if (input == "'/d") then
      local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0+", ""), "〔日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_d, "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/dl") then
      local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_d, "〔農曆！〕"))
      return
    end

    if (input == "'/da") then
      yield(Candidate("date", seg.start, seg._end, " the "..eng1_d_date(os.date("%d")).." ", "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " The "..eng1_d_date(os.date("%d")).." ", "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "'/de") then
      yield(Candidate("date", seg.start, seg._end, " "..eng2_d_date(os.date("%d")).." ", "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng4_d_date(os.date("%d")).." ", "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, eng4_d_date(os.date("%d")), "〔日〕"))
      -- yield(Candidate("date", seg.start, seg._end, " "..eng3_d_date(os.date("%d")).." ", "〔*日〕"))
      return
    end

    if (input == "'/dj") then
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "'/dc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %d 日"), "([ ])0+", "%1"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0+", ""), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%d日"), "^0+", "")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %d 日"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")).."日", "〔日〕"))
      return
    end

    if (input == "'/dd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "'/dz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      return
    end

    if (input == "'/md") then
      local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "^0+", ""), "〔月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_m .. chinese_d, "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/mdl") then
      local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_m .. chinese_d, "〔農曆！〕"))
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
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕"))
      return
    end

    if (input == "'/mdc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日"), "([ ])0+", "%1"), "〔*月日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "^0+", ""), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "^0+", "")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日"), "〔*月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月"), "〔*日月〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23), "〔月日〕"))
      return
    end

    if (input == "'/mdw") then
      local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "^0+", "").." ".."星期"..weekstr.." ", "〔月日週〕 ~c"))
      -- yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_m..chinese_d.." "..weekstr_jp3.." ", "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/mdwl") then
      local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_m..chinese_d.." "..weekstr_jp3.." ", "〔農曆！〕"))
      return
    end

    if (input == "'/mdwa") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng3.." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔週月日〕"))
      return
    end

    if (input == "'/mdwe") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月〕"))
      return
    end

    if (input == "'/mdwc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日"), "([ ])0+", "%1").." ".."星期"..weekstr.." ", "〔*月日週〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "^0+", "").." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "^0+", "")).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日").." ".."星期"..weekstr.." ", "〔*月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日".." ".."星期"..weekstr.." ", "〔月日週〕"))
      return
    end

    if (input == "'/mdwj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." "..weekstr_jp3.."曜日 ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."("..weekstr_jp3.."曜日)", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."（"..weekstr_jp3.."曜日）", "〔月日週〕"))
      return
    end

    if (input == "'/mdwz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr_c.." ", "〔月日週〕"))
      return
    end

    if (input == "'/ym") then
      local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕 ~j"))
      yield(Candidate("date", seg.start, seg._end, chinese_y .. chinese_m, "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/yml") then
      local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      yield(Candidate("date", seg.start, seg._end, chinese_y .. chinese_m, "〔農曆！〕"))
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
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月"), "([^%d])0", "%1"), "〔*年月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月"), "〔*年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月", "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %Y 年"), "〔*月年〕"))
      return
    end

    if (input == "'/ymj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕"))
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
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(12), "〔年月〕"))
      return
    end

-- function week_translator0(input, seg)
    if (input == "'/w") then
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstr, "〔週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕 ~a"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕 ~e"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕 ~j"))
      return
    end

    if (input == "'/wa") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng1.." ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕"))
      return
    end

    if (input == "'/we") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng2.." ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng3.." ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng3, "〔週〕"))
      return
    end

    if (input == "'/wc") then
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr.." ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstr, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."星期"..weekstr..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."星期"..weekstr.."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr_c.." ", "〔*週〕"))
      return
    end

    if (input == "'/wj") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_jp3.."曜日 ", "〔*週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "("..weekstr_jp3.."曜日)", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（"..weekstr_jp3.."曜日）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp1, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp2, "〔週〕"))
      return
    end

-- function week_translator1(input, seg)
    if (input == "'/fw") then
      local chinese_date = to_chinese_cal_local(os.time())
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔年月日週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕 ~z"))
      -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕 ~e"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕 ~j"))
      yield(Candidate("qsj", seg.start, seg._end, chinese_date.." "..weekstr_jp3.." ", "〔農曆！〕 ~l"))
      return
    end

    if (input == "'/fwl") then
      local chinese_date = to_chinese_cal_local(os.time())
      yield(Candidate("qsj", seg.start, seg._end, chinese_date.." "..weekstr_jp3.." ", "〔農曆！〕"))
      return
    end

    if (input == "'/fwa") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng3.." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      return
    end

    if (input == "'/fwe") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      return
    end

    if (input == "'/fwc") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔*年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")).." 星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." ", "〔*年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." ", "〔年月日週〕"))
      return
    end

    if (input == "'/fwj") then
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕"))
      -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."("..weekstr_jp3.."曜日)", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."（"..weekstr_jp3.."曜日）", "〔年月日週〕"))
      return
    end

    if (input == "'/fwz") then
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr_c.." ", "〔年月日週〕"))
      return
    end

-- function week_translator2(input, seg)
    -- if (input == "'/fwt") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end

    -- if (input == "'/fwtz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end
-- function week_translator3(input, seg)
    -- if (input == "'/fwn") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔*年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

    -- if (input == "'/fwnz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
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
      , { '  s〔節氣〕  l〔月相〕  u〔時區〕', '⑤' }
      , { '  ○○○〔數字〕', '⑥' }
      , { '  ○/○/○〔 ○ 年 ○ 月 ○ 日〕  ○/○〔 ○ 月 ○ 日〕', '⑦' }
      , { '  ○-○-○〔○年○月○日〕  ○-○〔○月○日〕', '⑧' }
      , { '  / [a-z]+〔小寫字母〕', '⑨' }
      , { '  ; [a-z]+〔大寫字母〕', '⑩' }
      , { '  \' [a-z]+〔開頭大寫字母〕', '⑪' }
      , { '  x [0-9abcdef]+〔內碼十六進制 Hex〕', '⑫' }
      , { '  c [0-9]+〔內碼十進制 Dec〕', '⑬' }
      , { '  o [0-7]+〔內碼八進制 Oct〕', '⑭' }
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
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9abcdef]+〔內碼十六進制 Hex〕")
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
        fmt = "U+".."%X"
      elseif ( utf_o ~= nil) then
        fmt = "0o".."%o"
      else
        fmt = "&#".."%d"..";"
      end
      -- 單獨查找
      yield(Candidate("number", seg.start, seg._end, utf8_out(c), string.format(fmt, c) ))
      -- 區間查找
      if c*n_bit+n_bit-1 < 1048575 then
        for i = c*n_bit, c*n_bit+n_bit-1 do
          yield(Candidate("number", seg.start, seg._end, utf8_out(i), string.format(fmt, i) ))
        end
      end
    end

    local y, m, d = string.match(input, "'/(%d+)/(%d?%d)/(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
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
      yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      if(chinese_date_input~=nil) then
        yield(Candidate("date", seg.start, seg._end, chinese_date_input, "〔農曆！〕"))
      end
      return
    end

    local m, d = string.match(input, "'/(%d?%d)/(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期〕"))
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
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
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      return
    end

    local y, m, d = string.match(input, "'/(%d+)-(%d?%d)-(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
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
      yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      if(chinese_date_input~=nil) then
        yield(Candidate("date", seg.start, seg._end, chinese_date_input, "〔農曆！〕"))
      end
      -- local chinese_date_input2 = to_chinese_cal(y, m, d)
      -- if(chinese_date_input2~=nil) then
      --   yield(Candidate("date", seg.start, seg._end, chinese_date_input2 .. " ", "〔農曆！〕"))
      -- end
      return
    end

    local m, d = string.match(input, "'/(%d?%d)-(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
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
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      return
    end

    -- local numberout = string.match(input, "'//?(%d+)$")
    local numberout = string.match(input, "'/(%d+)$")
    local nn = string.sub(numberout, 1)
    if (numberout~=nil) and (tonumber(nn)) ~= nil then
      yield(Candidate("number", seg.start, seg._end, numberout , "〔一般數字〕"))
      yield(Candidate("number", seg.start, seg._end, fullshape_number(numberout), "〔全形數字〕"))
      yield(Candidate("number", seg.start, seg._end, math1_number(numberout), "〔數學粗體數字〕"))
      yield(Candidate("number", seg.start, seg._end, math2_number(numberout), "〔數學空心數字〕"))
      yield(Candidate("number", seg.start, seg._end, little1_number(numberout), "〔上標數字〕"))
      yield(Candidate("number", seg.start, seg._end, little2_number(numberout), "〔下標數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled1_number(numberout), "〔帶圈數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled2_number(numberout), "〔帶圈無襯線數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled3_number(numberout), "〔反白帶圈數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled4_number(numberout), "〔反白帶圈無襯線數字〕"))
      for _, conf in ipairs(confs) do
        local r = read_number(conf, nn)
        yield(Candidate("number", seg.start, seg._end, r, conf.comment))
      end
      yield(Candidate("number", seg.start, seg._end, purech_number(numberout), "〔純中文數字〕"))
      yield(Candidate("number", seg.start, seg._end, circled5_number(numberout), "〔帶圈中文數字〕"))
      --[[ 用 yield 產生一個候選項
      候選項的構造函數是 Candidate，它有五個參數：
      - type: 字符串，表示候選項的類型（可隨意取）
      - start: 候選項對應的輸入串的起始位置
      - _end:  候選項對應的輸入串的結束位置
      - text:  候選項的文本
      - comment: 候選項的注釋
      --]]
      -- local k = string.sub(numberout, 1, -1) -- 取參數
      local result = formatnumberthousands(numberout) --- 調用算法
      yield(Candidate("number", seg.start, seg._end, result, "〔千分位數字〕"))
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


-- --- date/time translator
-- function date_translator(input, seg)
--   if (string.match(input, "``")~=nil) then
--     -- Candidate(type, start, end, text, comment)
--     if (input == "``time") then
--       yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " 現在時間"))
--       return
--     end

--     if (input == "``now") then
--       yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), " 現在日期"))
--       return
--     end

--     if(input=="``") then
--       yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
--       return
--     end

--     local y, m, d = string.match(input, "``(%d+)/(%d?%d)/(%d?%d)$")
--     if(y~=nil) then
--       yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , " 日期"))
--       return
--     end

--     local m, d = string.match(input, "``(%d?%d)/(%d?%d)$")
--     if(m~=nil) then
--       yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , " 日期"))
--       return
--     end
--   end
-- end

-- function mytranslator(input, seg)
--   date_translator(input, seg)
--   time_translator(input, seg)
-- end




--- @@ email_translator
--[[
把 recognizer 正則輸入 email 使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
--]]
function email_translator(input, seg)
  local email_in = string.match(input, "^([a-z][-_.0-9a-z]*@.*)$")
  if (email_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, email_in , "〔e-mail〕"))
    return
  end
end




--- @@ url_translator
--[[
把 recognizer 正則輸入網址使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
--]]
function url_translator(input, seg)
  local url1_in = string.match(input, "^(https?:.*)$")
  if (url1_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, url1_in , "〔URL〕"))
    return
  end

  local url2_in = string.match(input, "^(ftp:.*)$")
  if (url2_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, url2_in , "〔URL〕"))
    return
  end

  local url3_in = string.match(input, "^(mailto:.*)$")
  if (url3_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, url3_in , "〔URL〕"))
    return
  end

  local url4_in = string.match(input, "^(file:.*)$")
  if (url4_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, url4_in , "〔URL〕"))
    return
  end
end


--- urlw_translator
--[[
把 recognizer 正則輸入網址使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
該項多加「www.」
--]]
function urlw_translator(input, seg)
  local www_in = string.match(input, "^(www[.].*)$")
  if (www_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, www_in , "〔URL〕"))
    return
  end

  local url1_in = string.match(input, "^(https?:.*)$")
  if (url1_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, url1_in , "〔URL〕"))
    return
  end

  local url2_in = string.match(input, "^(ftp:.*)$")
  if (url2_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, url2_in , "〔URL〕"))
    return
  end

  local url3_in = string.match(input, "^(mailto:.*)$")
  if (url3_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, url3_in , "〔URL〕"))
    return
  end

  local url4_in = string.match(input, "^(file:.*)$")
  if (url4_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, url4_in , "〔URL〕"))
    return
  end
end




--- @@ charset filter
--[[
charset_filter: 濾除含 CJK 擴展漢字的候選項
charset_comment_filter: 為候選項加上其所屬字符集的註釋
本例說明了 filter 最基本的寫法。
請見 `charset_filter` 和 `charset_comment_filter` 上方註釋。
--]]

-- 幫助函數（可跳過）
local charset = {
  ["CJK"] = { first = 0x4E00, last = 0x9FFF },
  ["ExtA"] = { first = 0x3400, last = 0x4DBF },
  ["ExtB"] = { first = 0x20000, last = 0x2A6DF },
  ["ExtC"] = { first = 0x2A700, last = 0x2B73F },
  ["ExtD"] = { first = 0x2B740, last = 0x2B81F },
  ["ExtE"] = { first = 0x2B820, last = 0x2CEAF },
  ["ExtF"] = { first = 0x2CEB0, last = 0x2EBEF },
  ["Compat"] = { first = 0x2F800, last = 0x2FA1F } }

local function exists(single_filter, text)
  for i in utf8.codes(text) do
    local c = utf8.codepoint(text, i)
    if (not single_filter(c)) then
      return false
    end
  end
  return true
end

local function is_charset(s)
  return function (c)
    return c >= charset[s].first and c <= charset[s].last
  end
end

local function is_cjk_ext(c)
  return is_charset("ExtA")(c) or is_charset("ExtB")(c) or
    is_charset("ExtC")(c) or is_charset("ExtD")(c) or
    is_charset("ExtE")(c) or is_charset("ExtF")(c) or
    is_charset("Compat")(c)
end


--[[
filter 的功能是對 translator 翻譯而來的候選項做修飾，
如去除不想要的候選、為候選加註釋、候選項重排序等。
欲定義的 filter 包含兩個輸入參數：
 - input: 候選項列表
 - env: 可選參數，表示 filter 所處的環境（本例沒有體現）
filter 的輸出與 translator 相同，也是若干候選項，也要求您使用 `yield` 產生候選項。
如下例所示，charset_filter 將濾除含 CJK 擴展漢字的候選項：
--]]
function charset_filter(input)
  -- 使用 `iter()` 遍歷所有輸入候選項
  for cand in input:iter() do
    -- 如果當前候選項 `cand` 不含 CJK 擴展漢字
    if (not exists(is_cjk_ext, cand.text)) then
      -- 結果中仍保留此候選
      yield(cand)
    end
    --[[ 上述條件不滿足時，當前的候選 `cand` 沒有被 yield。
      因此過濾結果中將不含有該候選。
    --]]
  end
end


--[[
同上將濾除含 CJK 擴展漢字的候選項
但增加開關設置
--]]
function charset_filter_plus(input, env)
  -- 使用 `iter()` 遍歷所有輸入候選項
  local o_c_f = env.engine.context:get_option("only_cjk_filter")
  for cand in input:iter() do
    -- 如果當前候選項 `cand` 不含 CJK 擴展漢字
    if (not o_c_f or not exists(is_cjk_ext, cand.text)) then
      -- 結果中仍保留此候選
      yield(cand)
    end
    --[[ 上述條件不滿足時，當前的候選 `cand` 沒有被 yield。
      因此過濾結果中將不含有該候選。
    --]]
  end
end


--- charset comment filter
--[[
如下例所示，charset_comment_filter 為候選項加上其所屬字符集的註釋：
--]]
function charset_comment_filter(input)
  for cand in input:iter() do
    for s, r in pairs(charset) do
      if (exists(is_charset(s), cand.text)) then
        cand:get_genuine().comment = cand.comment .. " " .. s
        break
      end
    end
    yield(cand)
  end
end

-- 本例中定義了兩個 filter，故使用一個表將兩者導出
-- return { filter = charset_filter,
--   comment_filter = charset_comment_filter }


--- charset filter2 把 opencc 轉換成「᰼」(或某個符號)，再用 lua 功能去除「᰼」
-- charset2 = {
--  ["Deletesymbol"] = { first = 0x1C3C } }

-- function exists2(single_filter2, text)
--   for i in utf8.codes(text) do
--    local c = utf8.codepoint(text, i)
--    if (not single_filter2(c)) then
--   return false
--    end
--   end
--   return true
-- end

-- function is_charset2(s)
--  return function (c)
--     return c == charset2[s].first
--  end
-- end

-- function is_symbol_ext(c)
--  return is_charset2("Deletesymbol")(c)
-- end

-- function charset_filter2(input)
--  for cand in input:iter() do
--     if (not exists2(is_symbol_ext, cand.text))
--     then
--     yield(cand)
--     end
--  end
-- end


function charset_filter2(input)
  for cand in input:iter() do
    if (not string.find(cand.text, '᰼᰼' )) then
    -- if (not string.find(cand.text, '.*᰼᰼.*' )) then
      yield(cand)
    end
    -- if (input == nil) then
    --   cand = nil
    -- end
  end
  -- return nil
end




--- @@ single_char_filter
--[[
single_char_filter: 候選項重排序，使單字優先
--]]
function single_char_filter(input)
  local l = {}
  for cand in input:iter() do
    if (utf8.len(cand.text) == 1) then
      yield(cand)
    else
      table.insert(l, cand)
    end
  end
  for i, cand in ipairs(l) do
    yield(cand)
  end
end




--- @@ reverse_lookup_filter
--[[
依地球拼音為候選項加上帶調拼音的註釋
--]]
local pydb = ReverseDb("build/terra_pinyin.reverse.bin")

local function xform_py(inp)
  if inp == "" then return "" end
  inp = string.gsub(inp, "([aeiou])(ng?)([1234])", "%1%3%2")
  inp = string.gsub(inp, "([aeiou])(r)([1234])", "%1%3%2")
  inp = string.gsub(inp, "([aeo])([iuo])([1234])", "%1%3%2")
  inp = string.gsub(inp, "a1", "ā")
  inp = string.gsub(inp, "a2", "á")
  inp = string.gsub(inp, "a3", "ǎ")
  inp = string.gsub(inp, "a4", "à")
  inp = string.gsub(inp, "e1", "ē")
  inp = string.gsub(inp, "e2", "é")
  inp = string.gsub(inp, "e3", "ě")
  inp = string.gsub(inp, "e4", "è")
  inp = string.gsub(inp, "o1", "ō")
  inp = string.gsub(inp, "o2", "ó")
  inp = string.gsub(inp, "o3", "ǒ")
  inp = string.gsub(inp, "o4", "ò")
  inp = string.gsub(inp, "i1", "ī")
  inp = string.gsub(inp, "i2", "í")
  inp = string.gsub(inp, "i3", "ǐ")
  inp = string.gsub(inp, "i4", "ì")
  inp = string.gsub(inp, "u1", "ū")
  inp = string.gsub(inp, "u2", "ú")
  inp = string.gsub(inp, "u3", "ǔ")
  inp = string.gsub(inp, "u4", "ù")
  inp = string.gsub(inp, "v1", "ǖ")
  inp = string.gsub(inp, "v2", "ǘ")
  inp = string.gsub(inp, "v3", "ǚ")
  inp = string.gsub(inp, "v4", "ǜ")
  inp = string.gsub(inp, "([nljqxy])v", "%1ü")
  inp = string.gsub(inp, "eh[0-5]?", "ê")
  return "(" .. inp .. ")"
end

function reverse_lookup_filter(input)
  for cand in input:iter() do
    cand:get_genuine().comment = cand.comment .. " " .. xform_py(pydb:lookup(cand.text))
    yield(cand)
  end
end

--- composition
-- function myfilter(input)
--   local input2 = Translation(charset_comment_filter, input)
--   reverse_lookup_filter(input2)
-- end




--[[
@@ 嘸蝦米後面註釋刪除
--]]
-- local function xform_c(cf)
--   if cf == "" then return "" end
--   cf = string.gsub(cf, "[ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ%s]+$", "zk")
--   return cf
-- end

function comment_filter_plus(input, env)
  local s_c_f = env.engine.context:get_option("simplify_comment")
  -- 使用 `iter()` 遍歷所有輸入候選項
  for cand in input:iter() do
    if (not s_c_f) then
      yield(cand)
    else
    --   -- comment123 = cand.comment .. cand.text .. "open"
    --   -- comment123 = cand.comment
    --   -- comment123 = "kkk" .. comment123
    --   -- cand:get_genuine().comment = comment123 .." "
      cand:get_genuine().comment = ""
      yield(cand)
    end
  end
end




--[[
@@ 韓語（非英語等）空格鍵後添加" "
--]]
function endspace(key, env)
  local engine = env.engine
  local context = engine.context
  -- local arr = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
  --- accept: space_do_space when: composing
  if (key:repr() == "space") and (context:is_composing()) then
    local caret_pos = context.caret_pos
    local s_orig = context:get_commit_text()
    -- local s_orig = context:get_commit_composition()
    -- local o_orig = context:commit()
    -- local o_orig = context:get_script_text()
    -- local o_orig = string.gsub(context:get_script_text(), " ", "a")
    -- 以下「含有英文字母、控制字元、空白」和「切分上屏時」不作用（用字數統計驗證是否切分）
    if (not string.find(s_orig, "[%a%c%s]")) and (caret_pos == context.input:len()) then
    -- if (not string.find(o_orig, "[%a%c%s]")) and (caret_pos == context.input:len()) then
    -- if (string.find(o_orig, "[%a%c%s]")) and (caret_pos == context.input:len()) then
      -- 下一句：游標位置向左一格，在本例無用，單純記錄用法
      -- context.caret_pos = caret_pos - 1
      -- 下兩句合用可使輸出句被電腦記憶
      -- engine:commit_text("a")
      -- engine:confirm_current_selection()
      -- 下一句：用冒號為精簡寫法，該句為完整寫法
      -- engine.commit_text(engine, s_orig .. "a")
      -- engine:commit_text(s_orig .. "a")
      engine:commit_text(s_orig .. " ") --「return 1」時用
      -- engine:commit_text(s_orig) --「return 0」「return 2」時用
      context:clear()
      return 1 -- kAccepted
      -- 「0」「2」「kAccepted」「kRejected」「kNoop」：直接後綴產生空白
      -- 「1」：後綴不會產生空白，可用.." "增加空白或其他符號
      -- （該條目有問題，實測對應不起來）「拒」kRejected、「收」kAccepted、「不認得」kNoop，分別對應返回值：0、1、2。
      -- 返回「拒絕」時，雖然我們已經處理過按鍵了，但系統以為沒有，於是會按默認值再處理一遍。
    end
  end
  return 2 -- kNoop
end




--[[
@@ 各種寫法，針對掛載 t2_translator 在注音（用到空白鍵時）去除上屏時跑出空格之函數
--]]
-- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（只針對開頭，並且寫法精簡，少了 is_composing ）
function s2r_ss(key, env)
  local engine = env.engine
  local context = engine.context
  local o_input = context.input
  -- local kkk = string.find(o_input, "'/")
  if (string.find(o_input, "^'/")) and (key:repr() == 'space') then  -- (kkk~=nil) and (context:is_composing())
    local s_orig = context:get_commit_text()
    engine:commit_text(s_orig) -- .. "a"
    context:clear()
    return 1 -- kAccepted
  end
  return 2 -- kNoop
end

--- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（只針對開頭）
function s2r_s(key, env)
  local engine = env.engine
  local context = engine.context
  -- local page_size = engine.schema.page_size
  if (key:repr() == 'space') and (context:is_composing()) then
    local s_orig = context:get_commit_text()
    local o_input = context.input
    if (string.find(o_input, "^'/")) then
      engine:commit_text(s_orig)
      context:clear()
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end

--- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。
function s2r(key, env)
  local engine = env.engine
  local context = engine.context
  -- local page_size = engine.schema.page_size
  if (key:repr() == 'space') and (context:is_composing()) then
    local s_orig = context:get_commit_text()
    local o_input = context.input
    if (string.find(o_input, "'/[';/]?[a-z]*$")) or (string.find(o_input, "'/[0-9/-]*$")) or (string.find(o_input, "'/[xco][0-9a-f]+$")) then
-- or string.find(o_input, "^[a-z][-_.0-9a-z]*@.*$") or string.find(o_input, "^https?:.*$") or string.find(o_input, "^ftp:.*$") or string.find(o_input, "^mailto:.*$") or string.find(o_input, "^file:.*$")
      engine:commit_text(s_orig)
      context:clear()
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end

--- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（特別正則 for mixin3）
function s2r3(key, env)
  local engine = env.engine
  local context = engine.context
  -- local page_size = engine.schema.page_size
  if (key:repr() == 'space') and (context:is_composing()) then
    local s_orig = context:get_commit_text()
    local o_input = context.input
    if (string.find(o_input, "^'/[';/]?[a-z0-9/-]*$")) or (string.find(o_input, "[-,./;a-z125890][][3467%s]'/[';/]?[a-z0-9/-]*$")) or (string.find(o_input, "''/[';/]?[a-z0-9/-]*$")) or (string.find(o_input, "[=][0-9]'/[';/]?[a-z0-9/-]*$")) or (string.find(o_input, "[=][][]'/[';/]?[a-z0-9/-]*$")) or (string.find(o_input, "[=][][][][]'/[';/]?[a-z0-9/-]*$")) or (string.find(o_input, "[=][-,.;=`]'/[';/]?[a-z0-9/-]*$")) or (string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';/]?[a-z0-9/-]*$")) then
-- or string.find(o_input, "^[a-z][-_.0-9a-z]*@.*$") or string.find(o_input, "^https?:.*$") or string.find(o_input, "^ftp:.*$") or string.find(o_input, "^mailto:.*$") or string.find(o_input, "^file:.*$")
--
-- 無效的正則，不去影響一般輸入：
-- string.find(o_input, "[=][-,.;'=`]'/[';/]?[a-z0-9/-]*$") or string.find(o_input, "[][]'/[';/]?[a-z0-9/-]*$") or string.find(o_input, "[][][][]'/[';/]?[a-z0-9/-]*$") or string.find(o_input, "[][][']'/[';/]?[a-z0-9/-]*$") or string.find(o_input, "[][][][][']'/[';/]?[a-z0-9/-]*$") 
-- 原始全部正則：
-- "^'/[';/]?[a-z0-9/-]*$|(?<=[-,./;a-z125890][][3467 ])'/[';/]?[a-z0-9/-]*$|(?<=['])'/[';/]?[a-z0-9/-]*$|(?<=[=][0-9])'/[';/]?[a-z0-9/-]*$|(?<=[=][][])'/[';/]?[a-z0-9/-]*$|(?<=[=][][][][])'/[';/]?[a-z0-9/-]*$|(?<=[=][-,.;'=`])'/[';/]?[a-z0-9/-]*$|(?<=[=][-,.;'=`][-,.;'=`])'/[';/]?[a-z0-9/-]*$|(?<=[][])'/[';/]?[a-z0-9/-]*$|(?<=[][][][])'/[';/]?[a-z0-9/-]*$|(?<=[][]['])'/[';/]?[a-z0-9/-]*$|(?<=[][][][]['])'/[';/]?[a-z0-9/-]*$"
      engine:commit_text(s_orig)
      context:clear()
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end

--- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（只針對 email 和 url ）
function s2r_e_u(key, env)
  local engine = env.engine
  local context = engine.context
  -- local page_size = engine.schema.page_size
  if (key:repr() == 'space') and (context:is_composing()) then
    local s_orig = context:get_commit_text()
    local o_input = context.input
    if (string.find(o_input, "^[a-z][-_.0-9a-z]*@.*$")) or (string.find(o_input, "^https?:.*$")) or (string.find(o_input, "^ftp:.*$")) or (string.find(o_input, "^mailto:.*$")) or (string.find(o_input, "^file:.*$")) then
      engine:commit_text(s_orig)
      context:clear()
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end







