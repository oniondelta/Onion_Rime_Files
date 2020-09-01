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
--      ...

local function rqzdx1(a)
-- 日期轉大寫1
--a=1(二〇一九年)、2(六月)、3(二十三日)、12(二〇一九年六月)、23(六月二十三日)、其它為(二〇一九年六月二十三日)
-- 二〇一九年六月二十三日
  result = ""
  number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" }
  year0=os.date("%Y")
  for i= 0, 9 do
    year0= string.gsub(year0,i,number[i])
  end
  monthnumber = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" , "十", "十一", "十二"}
  month0=monthnumber[os.date("%m")*1]
  daynumber = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一" }
  day0=daynumber[os.date("%d")*1]
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
-- 貳零零玖年零陸月貳拾叁日
--a=1(貳零壹玖年)、2(零陸月)、3(貳拾叁日)、12(貳零壹玖年零陆月)、23(零陸月貳拾叁日)、其它为(貳零壹玖年零陸月貳拾叁日)
  result = ""
  number = { [0] = "零", "壹", "貳", "叁", "肆", "伍", "陸", "柒", "捌", "玖", "拾" }
  year0=os.date("%Y")
  for i= 0, 9 do
    year0= string.gsub(year0,i,number[i])
  end
-- for i= 1, 4 do
   -- year0=  string.gsub(year0,string.sub(year0,i,1),number[string.sub(year0,i,1)*1])
-- end
  monthnumber = { [0] = "零", "零壹", "零貳", "零叁", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳" }
  month0=monthnumber[os.date("%m")*1]
  daynumber = { [0] = "零", "零壹", "零貳", "零叁", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳", "壹拾叁", "壹拾肆", "壹拾伍", "壹拾陆", "壹拾柒", "壹拾捌", "壹拾玖", "贰拾", "贰拾壹", "贰拾贰", "贰拾叁", "贰拾肆", "贰拾伍", "贰拾陆", "贰拾柒", "贰拾捌", "贰拾玖", "叁拾", "叁拾壹" }
  day0=daynumber[os.date("%d")*1]
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

--- date/t translator
function t_translator(input, seg)
  if (string.match(input, "`")~=nil) then
      -- Candidate(type, start, end, text, comment)
  if (input == "`t") then
    yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " 現在時間 (時:分:秒)"))
    -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), " 現在時間 (時:分) ~m"))
    return
  end

  -- if (input == "`tm") then
  --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), " 現在時間 (時:分)"))
  --   return
  -- end

  if (input == "`n") then
    yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), " 現在時間 (時:分)"))
    -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " 現在時間 (時:分:秒) ~s"))
    return
  end

  -- if (input == "`ns") then
  --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " 現在時間 (時:分:秒)"))
  --   return
  -- end

  if (input == "`f") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕 ~z"))
    return
  end

  if (input == "`fc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年"), "〔月日年〕"))
    return
  end

  if (input == "`fd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y"), "〔月日年〕"))
    return
  end

  if (input == "`fm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y"), "〔月日年〕"))
    return
  end

  if (input == "`fs") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y"), "〔月日年〕"))
    return
  end

  if (input == "`fu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y"), "〔月日年〕"))
    return
  end

  if (input == "`fz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(), "〔年月日〕"))
    return
  end

  if (input == "`fn") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H:%M"), "〔年月日 時:分〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..os.date("%H:%M"), "〔年月日 時:分〕 ~z"))
    return
  end

  if (input == "`fnc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日  %H : %M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H : %M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H : %M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "`fnd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "`fns") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "`fnm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "`fnu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "`fnz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..os.date("%H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..os.date("%H:%M"), "〔年月日 時:分〕"))
    return
  end

  if (input == "`ft") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H:%M:%S"), "〔年月日 時:分:秒〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..os.date("%H:%M:%S"), "〔年月日 時:分:秒〕 ~z"))
    return
  end

  if (input == "`ftc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日  %H : %M : %S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H : %M : %S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H : %M : %S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "`ftd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "`fts") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "`ftm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "`ftu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "`ftz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..os.date("%H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..os.date("%H:%M:%S"), "〔年月日 時:分:秒〕"))
    return
  end

  if (input == "`y") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年"), "〔年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕 ~z"))
    -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
    return
  end

  if (input == "`yz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
    return
  end

  if (input == "`m") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月"), "〔月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕 ~z"))
    -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
    return
  end

  if (input == "`mz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
    return
  end

  if (input == "`d") then
    yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日"), "〔日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕 ~z"))
    -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
    return
  end

  if (input == "`dz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
    return
  end

  if (input == "`md") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕 ~z"))
    return
  end

  if (input == "`mdc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月"), "〔日月〕"))
    return
  end

  if (input == "`mdd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d%m"), "〔日月〕"))
    return
  end

  if (input == "`mds") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d/%m"), "〔日月〕"))
    return
  end

  if (input == "`mdm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d-%m"), "〔日月〕"))
    return
  end

  if (input == "`mdu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d_%m"), "〔日月〕"))
    return
  end

  if (input == "`mdz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(23), "〔月日〕"))
    return
  end

  if (input == "`mdw") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstr.." ", "〔月日週〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕 ~z"))
    -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
    return
  end

  if (input == "`mdwz") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
    return
  end

  if (input == "`ym") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕 ~z"))
    return
  end

  if (input == "`ymc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %Y 年"), "〔月年〕"))
    return
  end

  if (input == "`ymd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%Y"), "〔月年〕"))
    return
  end

  if (input == "`yms") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%Y"), "〔月年〕"))
    return
  end

  if (input == "`ymm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%Y"), "〔月年〕"))
    return
  end

  if (input == "`ymu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%Y"), "〔月年〕"))
    return
  end

  if (input == "`ymz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(12), "〔年月〕"))
    return
  end

-- function week_translator0(input, seg)
  if (input == "`w") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr.." ", "〔週〕"))
    return
  end
-- function week_translator1(input, seg)
  if (input == "`fw") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
       weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." ", "〔年月日週〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕 ~z"))
    -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
    return
  end

  if (input == "`fwz") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
       weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
    return
  end
-- function week_translator2(input, seg)
  if (input == "`fwt") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
    -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    return
  end

  if (input == "`fwtz") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    return
  end
-- function week_translator3(input, seg)
  if (input == "`fwn") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
    -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    return
  end

  if (input == "`fwnz") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    return
  end

  if(input=="`") then
---    yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
    yield(Candidate("date", seg.start, seg._end, "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ */*/*〔 * 年 * 月 * 日〕┇ */*〔 * 月 * 日〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ *-*-*〔*年*月*日〕┇ *-*〔*月*日〕" , ""))
    return
  end

  y, m, d = string.match(input, "`(%d+)/(%d?%d)/(%d?%d)$")
  if(y~=nil) then
    yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , " 日期"))
    return
  end

  m, d = string.match(input, "`(%d?%d)/(%d?%d)$")
  if(m~=nil) then
    yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , " 日期"))
    return
  end

  y, m, d = string.match(input, "`(%d+)-(%d?%d)-(%d?%d)$")
  if(y~=nil) then
    yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
    return
  end

  m, d = string.match(input, "`(%d?%d)-(%d?%d)$")
  if(m~=nil) then
    yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
    return
  end

  end
end


--- date/t2 translator
function t2_translator(input, seg)
  if (string.match(input, "'/")~=nil) then
      -- Candidate(type, start, end, text, comment)
  if (input == "'/t") then
    yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
    -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
    return
  end

  -- if (input == "'/tm") then
  --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
  --   return
  -- end

  if (input == "'/n") then
    yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
    -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
    return
  end

  -- if (input == "'/ns") then
  --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
  --   return
  -- end

  if (input == "'/f") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕 ~z"))
    return
  end

  if (input == "'/fc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年"), "〔月日年〕"))
    return
  end

  if (input == "'/fd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y"), "〔月日年〕"))
    return
  end

  if (input == "'/fm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y"), "〔月日年〕"))
    return
  end

  if (input == "'/fs") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y"), "〔月日年〕"))
    return
  end

  if (input == "'/fu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y"), "〔日月年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y"), "〔月日年〕"))
    return
  end

  if (input == "'/fz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(), "〔年月日〕"))
    return
  end

  if (input == "'/fn") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H:%M"), "〔年月日 時:分〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..os.date("%H:%M"), "〔年月日 時:分〕 ~z"))
    return
  end

  if (input == "'/fnc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日  %H : %M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H : %M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H : %M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "'/fnd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "'/fns") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "'/fnm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "'/fnu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M"), "〔日月年 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M"), "〔月日年 時:分〕"))
    return
  end

  if (input == "'/fnz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..os.date("%H:%M"), "〔年月日 時:分〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..os.date("%H:%M"), "〔年月日 時:分〕"))
    return
  end

  if (input == "'/ft") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H:%M:%S"), "〔年月日 時:分:秒〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..os.date("%H:%M:%S"), "〔年月日 時:分:秒〕 ~z"))
    return
  end

  if (input == "'/ftc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日  %H : %M : %S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月 %Y 年  %H : %M : %S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 %Y 年  %H : %M : %S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "'/ftd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "'/fts") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "'/ftm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "'/ftu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
    return
  end

  if (input == "'/ftz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..os.date("%H:%M:%S"), "〔年月日 時:分:秒〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..os.date("%H:%M:%S"), "〔年月日 時:分:秒〕"))
    return
  end

  if (input == "'/y") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年"), "〔年〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕 ~z"))
    -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
    return
  end

  if (input == "'/yz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
    return
  end

  if (input == "'/m") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月"), "〔月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕 ~z"))
    -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
    return
  end

  if (input == "'/mz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
    return
  end

  if (input == "'/d") then
    yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日"), "〔日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕 ~z"))
    -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
    return
  end

  if (input == "'/dz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
    return
  end

  if (input == "'/md") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕 ~z"))
    return
  end

  if (input == "'/mdc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %d 日 %m 月"), "〔日月〕"))
    return
  end

  if (input == "'/mdd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d%m"), "〔日月〕"))
    return
  end

  if (input == "'/mds") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d/%m"), "〔日月〕"))
    return
  end

  if (input == "'/mdm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d-%m"), "〔日月〕"))
    return
  end

  if (input == "'/mdu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%d_%m"), "〔日月〕"))
    return
  end

  if (input == "'/mdz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(23), "〔月日〕"))
    return
  end

  if (input == "'/mdw") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstr.." ", "〔月日週〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕 ~z"))
    -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
    return
  end

  if (input == "'/mdwz") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
    return
  end

  if (input == "'/ym") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕 ~c"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
    yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕 ~z"))
    return
  end

  if (input == "'/ymc") then
    yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %Y 年"), "〔月年〕"))
    return
  end

  if (input == "'/ymd") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m%Y"), "〔月年〕"))
    return
  end

  if (input == "'/yms") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m/%Y"), "〔月年〕"))
    return
  end

  if (input == "'/ymm") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m-%Y"), "〔月年〕"))
    return
  end

  if (input == "'/ymu") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕"))
    yield(Candidate("date", seg.start, seg._end, os.date("%m_%Y"), "〔月年〕"))
    return
  end

  if (input == "'/ymz") then
    yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年日〕"))
    yield(Candidate("date", seg.start, seg._end, rqzdx2(12), "〔年日〕"))
    return
  end

-- function week_translator0(input, seg)
  if (input == "'/w") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr.." ", "〔週〕"))
    return
  end
-- function week_translator1(input, seg)
  if (input == "'/fw") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
       weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." ", "〔年月日週〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕 ~z"))
    -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
    return
  end

  if (input == "'/fwz") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
       weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
    return
  end
-- function week_translator2(input, seg)
  if (input == "'/fwt") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
    -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    return
  end

  if (input == "'/fwtz") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    return
  end
-- function week_translator3(input, seg)
  if (input == "'/fwn") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
    -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    return
  end

  if (input == "'/fwnz") then
    if (os.date("%w") == "0") then
      weekstr = "日"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
    end
    yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    return
  end

--- 擴充模式 \r\n      日期 (年月日) ~d \r\n      年 ~y    月 ~m    日 ~day \r\n      年月 ~ym    月日 ~md \r\n      時間 (時分) ~n   (時分秒) ~t \r\n      日期時間 (年月日時分) ~dn\r\n      日期時間 (年月日時分秒) ~dt
  if(input=="'/") then
---    yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
    -- yield(Candidate("date", seg.start, seg._end, "║　d〔年月日〕┃   ym〔年月〕┃　md〔月日〕║" , ""))
    -- yield(Candidate("date", seg.start, seg._end, "║　　y〔年〕　┃　　m〔月〕 ┃　　dy〔日〕 ║" , ""))
    -- yield(Candidate("date", seg.start, seg._end, "║　　　n〔時:分〕　　 ┃　　　t〔時:分:秒〕　║" , ""))
    -- yield(Candidate("date", seg.start, seg._end, "║　dn〔年月日 時:分〕  ┃ dt〔年月日 時:分:秒〕║" , ""))
    -- yield(Candidate("date", seg.start, seg._end, "║*/*/*〔 * 年 * 月 * 日〕┃　*-*-*〔*年*月*日〕 ║" , ""))
    -- yield(Candidate("date", seg.start, seg._end, "║　　*/*〔 * 月 * 日〕   ┃　　 *-*〔*月*日〕　 ║" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ */*/*〔 * 年 * 月 * 日〕┇ */*〔 * 月 * 日〕" , ""))
    yield(Candidate("date", seg.start, seg._end, "┃ *-*-*〔*年*月*日〕┇ *-*〔*月*日〕" , ""))
    return
  end

  y, m, d = string.match(input, "'/(%d+)/(%d?%d)/(%d?%d)$")
  if(y~=nil) then
    yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日" , "〔日期〕"))
    return
  end

  m, d = string.match(input, "'/(%d?%d)/(%d?%d)$")
  if(m~=nil) then
    yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日" , "〔日期〕"))
    return
  end

  y, m, d = string.match(input, "'/(%d+)-(%d?%d)-(%d?%d)$")
  if(y~=nil) then
    yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
    return
  end

  m, d = string.match(input, "'/(%d?%d)-(%d?%d)$")
  if(m~=nil) then
    yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
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

  y, m, d = string.match(input, "``(%d+)/(%d?%d)/(%d?%d)$")
  if(y~=nil) then
    yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , " 日期"))
    return
  end

  m, d = string.match(input, "``(%d?%d)/(%d?%d)$")
  if(m~=nil) then
    yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , " 日期"))
    return
  end

  end
end


--- charset filter
charset = {
   ["CJK"] = { first = 0x4E00, last = 0x9FFF },
   ["ExtA"] = { first = 0x3400, last = 0x4DBF },
   ["ExtB"] = { first = 0x20000, last = 0x2A6DF },
   ["ExtC"] = { first = 0x2A700, last = 0x2B73F },
   ["ExtD"] = { first = 0x2B740, last = 0x2B81F },
   ["ExtE"] = { first = 0x2B820, last = 0x2CEAF },
   ["ExtF"] = { first = 0x2CEB0, last = 0x2EBEF },
   ["Compat"] = { first = 0x2F800, last = 0x2FA1F } }

function exists(single_filter, text)
  for i in utf8.codes(text) do
     local c = utf8.codepoint(text, i)
     if (not single_filter(c)) then
  return false
     end
  end
  return true
end

function is_charset(s)
   return function (c)
      return c >= charset[s].first and c <= charset[s].last
   end
end

function is_cjk_ext(c)
   return is_charset("ExtA")(c) or is_charset("ExtB")(c) or
      is_charset("ExtC")(c) or is_charset("ExtD")(c) or
      is_charset("ExtE")(c) or is_charset("ExtF")(c) or
      is_charset("Compat")(c)
end

function charset_filter(input)
   for cand in input:iter() do
      if (not exists(is_cjk_ext, cand.text))
      then
   yield(cand)
      end
   end
end

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
      if (not string.find(cand.text, '᰼' ))
      -- if (not string.find(cand.text, '.*᰼.*' ))
        then
        yield(cand)
      end
   end
end

--- charset comment filter
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


--- single_char_filter
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
pydb = ReverseDb("build/terra_pinyin.reverse.bin")

function xform_py(inp)
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
