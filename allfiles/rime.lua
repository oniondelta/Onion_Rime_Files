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
--      - lua_translator@date_translator     -- 「``」開頭打出時間日期
--      - lua_translator@mytranslator
--
--      - lua_filter@charset_filter          -- 遮屏含 CJK 擴展漢字的候選項
--      - lua_filter@charset_filter_plus         -- 遮屏含 CJK 擴展漢字的候選項，並增加開關
--      - lua_filter@charset_comment_filter  -- 為候選項加上其所屬字符集的註釋
--      - lua_filter@charset_filter2         -- 遮屏「᰼᰼」
--      - lua_filter@single_char_filter      -- 候選項重排序，使單字優先
--      - lua_filter@reverse_lookup_filter   -- 依地球拼音為候選項加上帶調拼音的註釋
--      - lua_filter@myfilter
--
--      - lua_processor@endspace -- 韓語（非英語等）空格鍵後添加" "
--      ...

local function rqzdx1(a)
-- 日期轉大寫1
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

local function rqzdx2(a)
-- 日期轉大寫2
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
以下轉寫函數
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
number_translator: 將 `'/` + 阿拉伯數字 各種轉譯
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


--- date/t translator
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
            yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
            yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
            -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分%S秒"), "〔時:分:秒〕"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分%S秒"), "〔時:分:秒〕"))
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

        if (input == "`n") then
            yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
            -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分"), "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分"), "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
            return
        end

        -- if (input == "`ns") then
        --     yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
        --     return
        -- end

        if (input == "`f") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分"), "〔年月日 時:分〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
            return
        end

        if (input == "`fnj") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕"))
            return
        end

        if (input == "`fnc") then
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
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分%S秒"), "〔年月日 時:分:秒〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
            return
        end

        if (input == "`ftj") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕"))
            return
        end

        if (input == "`ftc") then
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
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕 ~z"))
            -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕 ~d"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕 ~z"))
            -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕 ~z"))
            -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstr.." ", "〔月日週〕 ~c"))
            -- yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔月日週〕"))
            yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕 ~z"))
            -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
            yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕 ~e"))
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
            yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕 ~j"))
            yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕 ~a"))
            yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕 ~e"))
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
            yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." ", "〔年月日週〕 ~c"))
            yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕 ~j"))
            yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕 ~z"))
            -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
            yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕 ~e"))
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
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
        --     -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     return
        -- end

        -- if (input == "`fwtz") then
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     return
        -- end
-- function week_translator3(input, seg)
        -- if (input == "`fwn") then
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔*年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
        --     -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     return
        -- end

        -- if (input == "`fwnz") then
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     return
        -- end

--- 擴充模式 \r\n      日期 (年月日) ~d \r\n      年 ~y    月 ~m    日 ~day \r\n      年月 ~ym    月日 ~md \r\n      時間 (時分) ~n   (時分秒) ~t \r\n      日期時間 (年月日時分) ~dn\r\n      日期時間 (年月日時分秒) ~dt
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
              { '', '┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕' }
            , { '', '┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕' }
            , { '', '┃ n〔時:分〕┇ t〔時:分:秒〕' }
            , { '', '┃ fw〔年月日週〕┇ mdw〔月日週〕' }
            , { '', '┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕' }
            , { '', '┃ ○○○〔數字〕' }
            , { '', '┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕' }
            , { '', '┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕' }
            , { '', '┃ \' [a-z]+〔小寫字母〕┇ / [a-z]+〔開頭大寫字母〕' }
            , { '', '┃ ; [a-z]+〔大寫字母〕' }
            }
            for k, v in ipairs(date_table) do
                local cand = Candidate('date', seg.start, seg._end, v[2], ' ' .. v[1])
                cand.preedit = input .. '\t《時間日期數字字母》▶'
                yield(cand)
            end
            return
        end

        if(input=="`'") then
            local cand2 = Candidate("letter", seg.start, seg._end, "┃  [a-z]+〔小寫字母〕" , "")
            cand2.preedit = input .. '\t《小寫字母》▶'
            yield(cand2)
            return
        end

        if(input=="`/") then
            local cand2 = Candidate("letter", seg.start, seg._end, "┃  [a-z]+〔開頭大寫字母〕" , "")
            cand2.preedit = input .. '\t《開頭大寫字母》▶'
            yield(cand2)
            return
        end

        if(input=="`;") then
            local cand2 = Candidate("letter", seg.start, seg._end, "┃  [a-z]+〔大寫字母〕" , "")
            cand2.preedit = input .. '\t《大寫字母》▶'
            yield(cand2)
            return
        end

        local englishout1 = string.match(input, "`'(%l+)$")
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

        local englishout2 = string.match(input, "`/(%l+)$")
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
            return
        end

        local y, m, d = string.match(input, "`(%d+)/(%d?%d)/(%d?%d)$")
        if(y~=nil) then
            yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期〕"))
            yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
            yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
            yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
            yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
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
            return
        end

        local m, d = string.match(input, "`(%d?%d)/(%d?%d)$")
        if(m~=nil) then
            yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期〕"))
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
        if(y~=nil) then
            yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
            yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
            yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
            yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
            yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
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
            return
        end

        local m, d = string.match(input, "`(%d?%d)-(%d?%d)$")
        if(m~=nil) then
            yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
            yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期〕"))
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

        local numberout = string.match(input, "`(%d+)$")
        local n = string.sub(numberout, 1)
        if (numberout~=nil) and (tonumber(n)) ~= nil then
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
                local r = read_number(conf, n)
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


--- date/t2 translator
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
            yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
            yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
            -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分%S秒"), "〔時:分:秒〕"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分%S秒"), "〔時:分:秒〕"))
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

        if (input == "'/n") then
            yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
            -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分"), "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分"), "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
            return
        end

        -- if (input == "'/ns") then
        --     yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
        --     return
        -- end

        if (input == "'/f") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分"), "〔年月日 時:分〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
            return
        end

        if (input == "'/fnj") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕"))
            return
        end

        if (input == "'/fnc") then
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
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分%S秒"), "〔年月日 時:分:秒〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
            return
        end

        if (input == "'/ftj") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕"))
            return
        end

        if (input == "'/ftc") then
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
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕 ~z"))
            -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕 ~d"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕 ~z"))
            -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕 ~z"))
            -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstr.." ", "〔月日週〕 ~c"))
            -- yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔月日週〕"))
            yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕 ~z"))
            -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
            yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕 ~e"))
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
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕 ~c"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕 ~j"))
            yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕 ~z"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕 ~p"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕 ~e"))
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
            yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕 ~j"))
            yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕 ~a"))
            yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕 ~e"))
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
            yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." ", "〔年月日週〕 ~c"))
            yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕 ~j"))
            yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕 ~z"))
            -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
            yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕 ~e"))
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
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
        --     -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     return
        -- end

        -- if (input == "'/fwtz") then
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
        --     return
        -- end
-- function week_translator3(input, seg)
        -- if (input == "'/fwn") then
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔*年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
        --     -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     return
        -- end

        -- if (input == "'/fwnz") then
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
        --     return
        -- end

--- 擴充模式 \r\n      日期 (年月日) ~d \r\n      年 ~y    月 ~m    日 ~day \r\n      年月 ~ym    月日 ~md \r\n      時間 (時分) ~n   (時分秒) ~t \r\n      日期時間 (年月日時分) ~dn\r\n      日期時間 (年月日時分秒) ~dt
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
              { '', '┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕' }
            , { '', '┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕' }
            , { '', '┃ n〔時:分〕┇ t〔時:分:秒〕' }
            , { '', '┃ fw〔年月日週〕┇ mdw〔月日週〕' }
            , { '', '┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕' }
            , { '', '┃ ○○○〔數字〕' }
            , { '', '┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕' }
            , { '', '┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕' }
            , { '', '┃ \' [a-z]+〔小寫字母〕┇ / [a-z]+〔開頭大寫字母〕' }
            , { '', '┃ ; [a-z]+〔大寫字母〕' }
            -- , { '〔夜思‧李白〕', '床前明月光，疑是地上霜。\r舉頭望明月，低頭思故鄉。' }
            }
            for k, v in ipairs(date_table) do
                local cand = Candidate('date', seg.start, seg._end, v[2], ' ' .. v[1])
                cand.preedit = input .. '\t《時間日期數字字母》▶'
                yield(cand)
            end
            return
        end

        if(input=="'/'") then
            local cand2 = Candidate("letter", seg.start, seg._end, "┃  [a-z]+〔小寫字母〕" , "")
            cand2.preedit = input .. '\t《小寫字母》▶'
            yield(cand2)
            return
        end

        if(input=="'//") then
            local cand2 = Candidate("letter", seg.start, seg._end, "┃  [a-z]+〔開頭大寫字母〕" , "")
            cand2.preedit = input .. '\t《開頭大寫字母》▶'
            yield(cand2)
            return
        end

        if(input=="'/;") then
            local cand2 = Candidate("letter", seg.start, seg._end, "┃  [a-z]+〔大寫字母〕" , "")
            cand2.preedit = input .. '\t《大寫字母》▶'
            yield(cand2)
            return
        end

        local englishout1 = string.match(input, "'/'(%l+)$")
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

        local englishout2 = string.match(input, "'//(%l+)$")
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
            return
        end

        local y, m, d = string.match(input, "'/(%d+)/(%d?%d)/(%d?%d)$")
        if(y~=nil) then
            yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期〕"))
            yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
            yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
            yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
            yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
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
            return
        end

        local m, d = string.match(input, "'/(%d?%d)/(%d?%d)$")
        if(m~=nil) then
            yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期〕"))
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
        if(y~=nil) then
            yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
            yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
            yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
            yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
            yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
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
            return
        end

        local m, d = string.match(input, "'/(%d?%d)-(%d?%d)$")
        if(m~=nil) then
            yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
            yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期〕"))
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
        local numberout = string.match(input, "'/(%d+)$")
        local n = string.sub(numberout, 1)
        if (numberout~=nil) and (tonumber(n)) ~= nil then
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
                local r = read_number(conf, n)
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


--- date/time translator
function date_translator(input, seg)
    if (string.match(input, "``")~=nil) then
        -- Candidate(type, start, end, text, comment)
        if (input == "``time") then
            yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " 現在時間"))
            return
        end

        if (input == "``now") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), " 現在日期"))
            return
        end

        if(input=="``") then
            yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
            return
        end

        local y, m, d = string.match(input, "``(%d+)/(%d?%d)/(%d?%d)$")
        if(y~=nil) then
            yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , " 日期"))
            return
        end

        local m, d = string.match(input, "``(%d?%d)/(%d?%d)$")
        if(m~=nil) then
            yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , " 日期"))
            return
        end
    end
end

--- charset filter
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
--     comment_filter = charset_comment_filter }



--- charset filter2 把 opencc 轉換成「᰼」(或某個符號)，再用 lua 功能去除「᰼」
-- charset2 = {
--    ["Deletesymbol"] = { first = 0x1C3C } }

-- function exists2(single_filter2, text)
--   for i in utf8.codes(text) do
--      local c = utf8.codepoint(text, i)
--      if (not single_filter2(c)) then
--   return false
--      end
--   end
--   return true
-- end

-- function is_charset2(s)
--    return function (c)
--       return c == charset2[s].first
--    end
-- end

-- function is_symbol_ext(c)
--    return is_charset2("Deletesymbol")(c)
-- end

-- function charset_filter2(input)
--    for cand in input:iter() do
--       if (not exists2(is_symbol_ext, cand.text))
--       then
--         yield(cand)
--       end
--    end
-- end

function charset_filter2(input)
    for cand in input:iter() do
        if (not string.find(cand.text, '᰼᰼' )) then
        -- if (not string.find(cand.text, '.*᰼᰼.*' )) then
            yield(cand)
        end
        -- if (input == nil) then
        --     cand = nil
        -- end
    end
    -- return nil
end

--- single_char_filter
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


--- reverse_lookup_filter
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
function myfilter(input)
    local input2 = Translation(charset_comment_filter, input)
    reverse_lookup_filter(input2)
end

function mytranslator(input, seg)
    date_translator(input, seg)
    time_translator(input, seg)
end

--- 韓語（非英語等）空格鍵後添加" "
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
            engine:commit_text(s_orig .. " ")
            context:clear()
            return 1 --「0」「2」「kAccepted」「kRejected」「kNoop」：直接後綴產生空白   「1」：後綴不會產生空白，可用.." "增加空白或其他符號
            -- 「拒」kRejected、「收」kAccepted、「不認得」kNoop，分別對應返回值：0、1、2。
            -- 返回「拒絕」時，雖然我們已經處理過按鍵了，但系統以為沒有，於是會按默認值再處理一遍。
        end
    end
    return 2 -- kNoop
end

