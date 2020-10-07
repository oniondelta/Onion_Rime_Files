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
    local month_number = { [0] = "〇", "㋀", "㋁", "㋂", "㋃", "㋄", "㋅", "㋆", "㋇", "㋈", "㋉", "㋊", "㋋" }
    local a=month_number[a*1]
    return a
end

local function jp_d_date(a)
    if a == "" then return "" end
    local day_number = { [0] = "〇", "㏠", "㏡", "㏢", "㏣", "㏤", "㏥", "㏦", "㏧", "㏨", "㏩", "㏪", "㏫", "㏬", "㏭", "㏮", "㏯", "㏰", "㏱", "㏲", "㏳", "㏴", "㏵", "㏶", "㏷", "㏸", "㏹", "㏺", "㏻", "㏼", "㏽", "㏾" }
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

local function eng1_d_date(a)
    if a == "" then return "" end
    local day_number = { [0] = "〇", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "egihteenth", "nineteenth", "twentieth", "twenty-first", "twenty-second", "twenty-third", "twenty-fouth", "twenty-fifth", "twenty-sixth", "twenty-seventh", "twenty-eighth", "twenty-ninth", "thirtieth", "thirty-first" }
    local a=day_number[a*1]
    return a
end

local function eng2_d_date(a)
    if a == "" then return "" end
    local day_number = { [0] = "〇", "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th", "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st" }
    local a=day_number[a*1]
    return a
end

local function eng3_d_date(a)
    if a == "" then return "" end
    local day_number = { [0] = "〇", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31" }
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
            weekstr_jp1 = "㈰"
            weekstr_jp2 = "㊐"
            weekstr_jp3 = "日"
            weekstr_eng1 = "Sunday"
            weekstr_eng2 = "Sun."
        end
        if (os.date("%w") == "1") then
            weekstr = "一"
            weekstr_jp1 = "㈪"
            weekstr_jp2 = "㊊"
            weekstr_jp3 = "月"
            weekstr_eng1 = "Monday"
            weekstr_eng2 = "Mon."
        end
        if (os.date("%w") == "2") then
            weekstr = "二"
            weekstr_jp1 = "㈫"
            weekstr_jp2 = "㊋"
            weekstr_jp3 = "火"
            weekstr_eng1 = "Tuesday"
            weekstr_eng2 = "Tues."
        end
        if (os.date("%w") == "3") then
            weekstr = "三"
            weekstr_jp1 = "㈬"
            weekstr_jp2 = "㊌"
            weekstr_jp3 = "水"
            weekstr_eng1 = "Wednesday"
            weekstr_eng2 = "Wed."
        end
        if (os.date("%w") == "4") then
            weekstr = "四"
            weekstr_jp1 = "㈭"
            weekstr_jp2 = "㊍"
            weekstr_jp3 = "木"
            weekstr_eng1 = "Thursday"
            weekstr_eng2 = "Thur."
        end
        if (os.date("%w") == "5") then
            weekstr = "五"
            weekstr_jp1 = "㈮"
            weekstr_jp2 = "㊎"
            weekstr_jp3 = "金"
            weekstr_eng1 = "Friday"
            weekstr_eng2 = "Fri."
        end
        if (os.date("%w") == "6") then
            weekstr = "六"
            weekstr_jp1 = "㈯"
            weekstr_jp2 = "㊏"
            weekstr_jp3 = "土"
            weekstr_eng1 = "Saturday"
            weekstr_eng2 = "Sat."
        end

        -- Candidate(type, start, end, text, comment)
        if (input == "`t") then
            yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
            yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
            -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分%S秒"), "〔時:分:秒〕"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分%S秒"), "〔時:分:秒〕"))
            return
        end

    -- if (input == "`tm") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), " 現在時間 (時:分)"))
    --   return
    -- end

        if (input == "`n") then
            yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
            -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分"), "〔時:分〕"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分"), "〔時:分〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年"), "〔*日月年〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年"), "〔*月日年〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y"), "〔日月年〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y"), "〔月日年〕"))
            return
        end

        if (input == "`fu") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y"), "〔日月年〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y"), "〔月日年〕"))
            return
        end

        if (input == "`fp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔年月日〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分", "〔年月日 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H 點 %M 分"), "〔*日月年 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H 點 %M 分"), "〔*月日年 時:分〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M"), "〔日月年 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M"), "〔月日年 時:分〕"))
            return
        end

        if (input == "`fnp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分"..fullshape_number(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H 點 %M 分 %S 秒"), "〔*日月年 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H 點 %M 分 %S 秒"), "〔*月日年 時:分:秒〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
            return
        end

        if (input == "`ftp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
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
            return
        end

        if (input == "`me") then
            yield(Candidate("date", seg.start, seg._end, " "..eng2_m_date(os.date("%m")).." ", "〔*月〕"))
            return
        end

        if (input == "`mj") then
            yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕"))
            return
        end

        if (input == "`mc") then
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
            yield(Candidate("date", seg.start, seg._end, eng1_d_date(os.date("%d")), "〔日〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
            return
        end

        if (input == "`da") then
            yield(Candidate("date", seg.start, seg._end, " "..eng1_d_date(os.date("%d")).." ", "〔*日〕"))
            return
        end

        if (input == "`de") then
            yield(Candidate("date", seg.start, seg._end, " "..eng2_d_date(os.date("%d")).." ", "〔*日〕"))
            return
        end

        if (input == "`dj") then
            yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕"))
            return
        end

        if (input == "`dc") then
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月"), "〔*日月〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔月日〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d_%m"), "〔日月〕"))
            return
        end

        if (input == "`mdp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔月日〕"))
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
            yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
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
            return
        end

        if (input == "`ymc") then
            yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月"), "〔*年月〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月", "〔年月〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %Y 年"), "〔*月年〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")), "〔年月〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")), "〔年月〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")), "〔年月〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%Y"), "〔月年〕"))
            return
        end

        if (input == "`ymp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")), "〔年月〕"))
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
            return
        end

        if (input == "`we") then
            yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng2.." ", "〔*週〕"))
            return
        end

        if (input == "`wc") then
            yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr.." ", "〔*週〕"))
            return
        end

        if (input == "`wj") then
            yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_jp3.."曜日 ", "〔*週〕"))
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
            yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
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

        if(input=="`") then
            ---    yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
            yield(Candidate("date", seg.start, seg._end, "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , ""))
            -- yield(Candidate("date", seg.start, seg._end, "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ ○○○〔數字〕" , ""))
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
            for _, conf in ipairs(confs) do
                local r = read_number(conf, n)
                yield(Candidate("number", seg.start, seg._end, r, conf.comment))
            end
            yield(Candidate("number", seg.start, seg._end, purech_number(numberout), "〔純中文數字〕"))
            --[[ 用 `yield` 產生一個候選項
            候選項的構造函數是 `Candidate`，它有五個參數：
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
            weekstr_jp1 = "㈰"
            weekstr_jp2 = "㊐"
            weekstr_jp3 = "日"
            weekstr_eng1 = "Sunday"
            weekstr_eng2 = "Sun."
        end
        if (os.date("%w") == "1") then
            weekstr = "一"
            weekstr_jp1 = "㈪"
            weekstr_jp2 = "㊊"
            weekstr_jp3 = "月"
            weekstr_eng1 = "Monday"
            weekstr_eng2 = "Mon."
        end
        if (os.date("%w") == "2") then
            weekstr = "二"
            weekstr_jp1 = "㈫"
            weekstr_jp2 = "㊋"
            weekstr_jp3 = "火"
            weekstr_eng1 = "Tuesday"
            weekstr_eng2 = "Tues."
        end
        if (os.date("%w") == "3") then
            weekstr = "三"
            weekstr_jp1 = "㈬"
            weekstr_jp2 = "㊌"
            weekstr_jp3 = "水"
            weekstr_eng1 = "Wednesday"
            weekstr_eng2 = "Wed."
        end
        if (os.date("%w") == "4") then
            weekstr = "四"
            weekstr_jp1 = "㈭"
            weekstr_jp2 = "㊍"
            weekstr_jp3 = "木"
            weekstr_eng1 = "Thursday"
            weekstr_eng2 = "Thur."
        end
        if (os.date("%w") == "5") then
            weekstr = "五"
            weekstr_jp1 = "㈮"
            weekstr_jp2 = "㊎"
            weekstr_jp3 = "金"
            weekstr_eng1 = "Friday"
            weekstr_eng2 = "Fri."
        end
        if (os.date("%w") == "6") then
            weekstr = "六"
            weekstr_jp1 = "㈯"
            weekstr_jp2 = "㊏"
            weekstr_jp3 = "土"
            weekstr_eng1 = "Saturday"
            weekstr_eng2 = "Sat."
        end

        -- Candidate(type, start, end, text, comment)
        if (input == "'/t") then
            yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
            yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
            -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分%S秒"), "〔時:分:秒〕"))
            yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分%S秒"), "〔時:分:秒〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年"), "〔*日月年〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年"), "〔*月日年〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y"), "〔日月年〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y"), "〔月日年〕"))
            return
        end

        if (input == "'/fu") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y"), "〔日月年〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y"), "〔月日年〕"))
            return
        end

        if (input == "'/fp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔年月日〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分", "〔年月日 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H 點 %M 分"), "〔*日月年 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H 點 %M 分"), "〔*月日年 時:分〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M"), "〔日月年 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M"), "〔月日年 時:分〕"))
            return
        end

        if (input == "'/fnp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分"..fullshape_number(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H 點 %M 分 %S 秒"), "〔*日月年 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H 點 %M 分 %S 秒"), "〔*月日年 時:分:秒〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
            return
        end

        if (input == "'/ftp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
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
            return
        end

        if (input == "'/me") then
            yield(Candidate("date", seg.start, seg._end, " "..eng2_m_date(os.date("%m")).." ", "〔*月〕"))
            return
        end

        if (input == "'/mj") then
            yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕"))
            return
        end

        if (input == "'/mc") then
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
            yield(Candidate("date", seg.start, seg._end, eng1_d_date(os.date("%d")), "〔日〕 ~a"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
            return
        end

        if (input == "'/da") then
            yield(Candidate("date", seg.start, seg._end, " "..eng1_d_date(os.date("%d")).." ", "〔*日〕"))
            return
        end

        if (input == "'/de") then
            yield(Candidate("date", seg.start, seg._end, " "..eng2_d_date(os.date("%d")).." ", "〔*日〕"))
            return
        end

        if (input == "'/dj") then
            yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕"))
            return
        end

        if (input == "'/dc") then
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月"), "〔*日月〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔月日〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔月日〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%d_%m"), "〔日月〕"))
            return
        end

        if (input == "'/mdp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔月日〕"))
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
            yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
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
            return
        end

        if (input == "'/ymc") then
            yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月"), "〔*年月〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月", "〔年月〕"))
            yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %Y 年"), "〔*月年〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")), "〔年月〕"))
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
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")), "〔年月〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")), "〔年月〕"))
            yield(Candidate("date", seg.start, seg._end, os.date("%m_%Y"), "〔月年〕"))
            return
        end

        if (input == "'/ymp") then
            yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕"))
            yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")), "〔年月〕"))
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
            return
        end

        if (input == "'/we") then
            yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng2.." ", "〔*週〕"))
            return
        end

        if (input == "'/wc") then
            yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr.." ", "〔*週〕"))
            return
        end

        if (input == "'/wj") then
            yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_jp3.."曜日 ", "〔*週〕"))
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
            yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
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
            -- yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
            -- yield(Candidate("date", seg.start, seg._end, "║　d〔年月日〕┃   ym〔年月〕┃　md〔月日〕║" , ""))
            -- yield(Candidate("date", seg.start, seg._end, "║　　y〔年〕　┃　　m〔月〕 ┃　　dy〔日〕 ║" , ""))
            -- yield(Candidate("date", seg.start, seg._end, "║　　　n〔時:分〕　　 ┃　　　t〔時:分:秒〕　║" , ""))
            -- yield(Candidate("date", seg.start, seg._end, "║　dn〔年月日 時:分〕  ┃ dt〔年月日 時:分:秒〕║" , ""))
            -- yield(Candidate("date", seg.start, seg._end, "║*/*/*〔 * 年 * 月 * 日〕┃　*-*-*〔*年*月*日〕 ║" , ""))
            -- yield(Candidate("date", seg.start, seg._end, "║　　*/*〔 * 月 * 日〕   ┃　　 *-*〔*月*日〕　 ║" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , ""))
            -- yield(Candidate("date", seg.start, seg._end, "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕" , ""))
            yield(Candidate("date", seg.start, seg._end, "┃ ○○○〔數字〕" , ""))
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
            yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
            yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
            yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
            yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
            yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
            return
        end

        local numberout = string.match(input, "'/(%d+)$")
        local n = string.sub(numberout, 1)
        if (numberout~=nil) and (tonumber(n)) ~= nil then
            yield(Candidate("number", seg.start, seg._end, numberout , "〔一般數字〕"))
            yield(Candidate("number", seg.start, seg._end, fullshape_number(numberout), "〔全形數字〕"))
            for _, conf in ipairs(confs) do
                local r = read_number(conf, n)
                yield(Candidate("number", seg.start, seg._end, r, conf.comment))
            end
            yield(Candidate("number", seg.start, seg._end, purech_number(numberout), "〔純中文數字〕"))
            --[[ 用 `yield` 產生一個候選項
            候選項的構造函數是 `Candidate`，它有五個參數：
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
        if (not exists(is_cjk_ext, cand.text))
        then
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
        if (not string.find(cand.text, '᰼᰼' ))
        -- if (not string.find(cand.text, '.*᰼᰼.*' ))
        then
            yield(cand)
        end
    end
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
    if (key:repr() == "space") and (context:is_composing())then
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
                engine:commit_text(s_orig)
                -- engine:commit_text(s_orig .. "a")
                context:clear()
                return 0 -- kAccepted
                -- return kAccepted
            -- end
        end
    end
    return 2 -- kNoop
    -- return kNoop
end

