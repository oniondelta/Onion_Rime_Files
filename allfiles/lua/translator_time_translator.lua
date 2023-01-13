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
--- 版本訊息

local Ver_info = require("f_components/f_ver_info")

----------------------------------------------------------------------------------------
--- 日期時間各種格式轉寫

local timezone_out = require("f_components/f_timezone_out")

local f_y_s = require("f_components/f_year_style")
local min_guo = f_y_s.min_guo
local jp_ymd = f_y_s.jp_ymd

local f_d_s = require("f_components/f_date_style")
local ch_y_date = f_d_s.ch_y_date
local ch_m_date = f_d_s.ch_m_date
local ch_d_date = f_d_s.ch_d_date
local ch_h_date = f_d_s.ch_h_date
local ch_minsec_date = f_d_s.ch_minsec_date
local chb_y_date = f_d_s.chb_y_date
local chb_m_date = f_d_s.chb_m_date
local chb_d_date = f_d_s.chb_d_date
local chb_h_date = f_d_s.chb_h_date
local chb_minsec_date = f_d_s.chb_minsec_date
local jp_m_date = f_d_s.jp_m_date
local jp_d_date = f_d_s.jp_d_date
local eng1_m_date = f_d_s.eng1_m_date
local eng2_m_date = f_d_s.eng2_m_date
local eng3_m_date = f_d_s.eng3_m_date
local eng1_d_date = f_d_s.eng1_d_date
local eng2_d_date = f_d_s.eng2_d_date
local eng3_d_date = f_d_s.eng3_d_date
local eng4_d_date = f_d_s.eng4_d_date

local f_c_d_s = require("f_components/f_chinese_date_style")
local rqzdx1 = f_c_d_s.rqzdx1
local rqzdx2 = f_c_d_s.rqzdx2

local weekstyle = require("f_components/f_week_style")

local f_t_s = require("f_components/f_time_style")
local time_out1 = f_t_s.time_out1
local time_out2 = f_t_s.time_out2

----------------------------------------------------------------------------------------
--- 數字字母各種格式轉寫

local f_n_s = require("f_components/f_number_style")
local formatnumberthousands = f_n_s.formatnumberthousands
local fullshape_number = f_n_s.fullshape_number
local math1_number = f_n_s.math1_number
local math2_number = f_n_s.math2_number
local circled1_number = f_n_s.circled1_number
local circled2_number = f_n_s.circled2_number
local circled3_number = f_n_s.circled3_number
local circled4_number = f_n_s.circled4_number
local circled5_number = f_n_s.circled5_number
local purech_number = f_n_s.purech_number
local military_number = f_n_s.military_number
local little1_number = f_n_s.little1_number
local little2_number = f_n_s.little2_number

local f_c_n = require("f_components/f_chinese_number")
local read_number = f_c_n.read_number
local confs = f_c_n.confs

local f_e_s = require("f_components/f_english_style")
local english_1 = f_e_s.english_1
local english_2 = f_e_s.english_2
local english_3 = f_e_s.english_3
local english_4 = f_e_s.english_4
local english_5 = f_e_s.english_5
local english_6 = f_e_s.english_6
local english_7 = f_e_s.english_7
local english_8 = f_e_s.english_8
local english_9 = f_e_s.english_9
local english_f_u = f_e_s.english_f_u
local english_f_l = f_e_s.english_f_l
local english_s_u = f_e_s.english_s_u
local english_1_2 = f_e_s.english_1_2
local english_3_4 = f_e_s.english_3_4
local english_5_6 = f_e_s.english_5_6
local english_f_ul = f_e_s.english_f_ul
local english_s = f_e_s.english_s
local english_s2u = f_e_s.english_s2u

----------------------------------------------------------------------------------------
--- Unicode 等各種字符編碼轉換

local utf8_sub = require("f_components/f_utf8_sub")

local utf8_out = require("f_components/f_utf8_out")

local url_encode = require("f_components/f_url_encode")

local url_decode = require("f_components/f_url_decode")

----------------------------------------------------------------------------------------

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
      yield(Candidate("version_info", seg.start, seg._end, Ver_info()[1], "〔 distribution_version 〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info()[2], "〔 rime_version 〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info()[3], "〔 librime-lua_version 〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info()[4], "〔 lua_version 〕"))
      yield(Candidate("version_info", seg.start, seg._end, Ver_info()[5], "〔 installation_id 〕"))
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
      -- local tz, tzd = timezone_out()
      yield(Candidate("time", seg.start, seg._end, timezone_out()[1], "〔世界協調時間〕"))
      yield(Candidate("time", seg.start, seg._end, timezone_out()[5], "〔格林威治標準時間〕"))
      yield(Candidate("time", seg.start, seg._end, timezone_out()[2], "〔本地時區代號〕"))
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
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out()[1], "〔本地時  時區〕 ~i"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M") .. timezone_out()[3], "〔本地時  RFC 3339/ISO 8601〕 ~r"))
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
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out()[1], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out()[5], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M ") .. timezone_out()[2], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M UTC"), "〔世界時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M GMT"), "〔世界時  時區〕"))
      return
    end

    if (input == "`fnr") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M") .. timezone_out()[3], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%dT%H%M") .. timezone_out()[4], "〔本地時  RFC 3339/ISO 8601〕"))
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
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out()[1], "〔本地時  時區〕 ~i"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M:%S") .. timezone_out()[3], "〔本地時  RFC 3339/ISO 8601〕 ~r"))
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
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out()[1], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out()[5], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d-%H-%M-%S ") .. timezone_out()[2], "〔本地時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M-%S UTC"), "〔世界時  時區〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("!%Y-%m-%d-%H-%M-%S GMT"), "〔世界時  時區〕"))
      return
    end

    if (input == "`ftr") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M:%S") .. timezone_out()[3], "〔本地時  RFC 3339/ISO 8601〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%dT%H%M%S") .. timezone_out()[4], "〔本地時  RFC 3339/ISO 8601〕"))
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
        -- { "〔半角〕", "`" }
        { "  f〔年月日〕  ym〔年月〕  md〔月日〕", "⓪" }
      , { "  y〔年〕  m〔月〕  d〔日〕  w〔週〕", "①" }
      , { "  n〔時:分〕  t〔時:分:秒〕", "②" }
      , { "  fw〔年月日週〕  mdw〔月日週〕", "③" }
      , { "  fn〔年月日 時:分〕  ft〔年月日 時:分:秒〕", "④" }
      , { "  p〔程式格式〕  z〔時區〕  s〔節氣〕  l〔月相〕", "⑤" }
      , { "  ○○○〔數字〕", "⑥" }
      , { "  ○/○/○〔 ○ 年 ○ 月 ○ 日〕  ○/○〔 ○ 月 ○ 日〕", "⑦" }
      , { "  ○-○-○〔○年○月○日〕  ○-○〔○月○日〕", "⑧" }
      , { "  / [a-z , . - ' / ]+〔小寫字母〕", "⑨" }
      , { "  ; [a-z , . - ' / ]+〔大寫字母〕", "⑩" }
      , { "  \' [a-z , . - ' / ]+〔開頭大寫字母〕", "⑪" }
      , { "  e [0-9a-f]+〔Percent/URL encoding〕", "⑫" }
      , { "  u [0-9a-f]+〔內碼十六進制 Hex〕(Unicode)", "⑬" }
      , { "  x [0-9a-f]+〔內碼十六進制 Hex〕(Unicode)", "⑭" }
      , { "  c [0-9]+〔內碼十進制 Dec〕", "⑮" }
      , { "  o [0-7]+〔內碼八進制 Oct〕", "⑯" }
      , { "  v〔版本資訊〕", "⑰" }
      , { "===========  結束  ===========    ", "⑱" }
      , { "", "⑲" }
      , { "", "⑳" }

      -- , { "〔夜思‧李白〕", "床前明月光，疑是地上霜。\r舉頭望明月，低頭思故鄉。" }
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
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔內碼十六進制 Hex〕(Unicode)")
      cand2.preedit = input .. '\t《內碼十六進制》▶'
      yield(cand2)
      return
    end

    if(input=="`u") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔內碼十六進制 Hex〕(Unicode)")
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

    if(input=="`e") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔Percent/URL encoding〕")
      cand2.preedit = input .. '\t《Percent/URL encoding》▶'
      yield(cand2)
      return
    end

    local englishout1 = string.match(input, "`/([%l.,/'-]+)$")
    if (englishout1~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, english_s(englishout1) , "〔一般字母小寫〕"))
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

    local englishout2 = string.match(input, "`'([%l.,/'-]+)$")
    if (englishout2~=nil) then
      -- yield(Candidate("englishtype", seg.start, seg._end, string.upper(string.sub(englishout2,1,1)) .. string.sub(englishout2,2,-1) , "〔一般字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_s2u(englishout2) , "〔一般字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_ul(englishout2) , "〔全形字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1_2(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3_4(englishout2) , "〔帶圈字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5_6(englishout2) , "〔括號字母大寫〕"))
      return
    end

    local englishout3 = string.match(input, "`;([%l.,/'-]+)$")
    if (englishout3~=nil) then
      local englishout3 = string.upper(englishout3)
      yield(Candidate("englishtype", seg.start, seg._end, english_s(englishout3) , "〔一般字母大寫〕"))
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

    local utf_prefix, utf_input = string.match(input, "(`)([xuco][0-9a-f]+)$")
    if (utf_input~=nil) then
      -- if string.sub(input, 1, 2) ~= utf_prefix then return end
      local dict = { c=10, x=16, u=16, o=8 } --{ u=16 } --{ d=10, u=16, e=8 }
      local snd = string.sub(utf_input, 1, 1)
      local n_bit = dict[snd]
      if n_bit == nil then return end
      local str = string.sub(utf_input, 2)
      local c = tonumber(str, n_bit)
      if c == nil then return end
      local utf_x = string.match(utf_input, "^x")
      local utf_u = string.match(utf_input, "^u")
      local utf_o = string.match(utf_input, "^o")
      local utf_c = string.match(utf_input, "^c")
      if ( utf_x ~= nil) then
        -- local fmt = "U"..snd.."%"..(n_bit==16 and "X" or snd)
        fmt = "  U+".."%X"
      elseif ( utf_u ~= nil) then
        fmt = "  U+".."%X"
      elseif ( utf_o ~= nil) then
        fmt = "  0o".."%o"
      else
        fmt = "  &#".."%d"..";"
      end
      -- 單獨查找
      local cand_ui_s = Candidate("number", seg.start, seg._end, utf8_out(c), string.format(fmt, c) .. "  ( " .. url_encode(utf8_out(c)) .. " ）" )
      -- 排除數字太大超出範圍。正常範圍輸出已 string_char，故 0 直接可以限定。
      if (utf8_out(c) == 0) then
        cand_ui_s = Candidate("number", seg.start, seg._end, "", "〈超出範圍〉" )  --字符過濾可能會過濾掉""整個選項。
      end
      cand_ui_s.preedit = utf_prefix .. snd .. " " .. string.upper(string.sub(utf_input, 2))
      yield(cand_ui_s)
      -- 區間查找
      -- if c*n_bit+n_bit-1 < 1048575 then
      --   for i = c*n_bit, c*n_bit+n_bit-1 do
      if c+16 < 1048575 then
        for i = c+1, c+16 do
          local cand_ui_m = Candidate("number", seg.start, seg._end, utf8_out(i), string.format(fmt, i) .. "  ( " .. url_encode(utf8_out(i)) .. " ）" )
          cand_ui_m.preedit = utf_prefix .. snd .. " " .. string.upper(string.sub(utf_input, 2))
          yield(cand_ui_m)
        end
      end
    end


    local url_e_prefix, url_e_input = string.match(input, "(`e)([0-9a-z][0-9a-f]*)$")
    if (url_e_input~=nil) then
      local preedit_url_e = string.gsub(url_e_input, "(%x%x)", "%%%1")
      local preedit_url_e = string.gsub(preedit_url_e, "(%x%x)(%x)$", "%1%%%2")
      local preedit_url_e = string.gsub(preedit_url_e, "^(%x)$", "%%%1")
      local url_e_cand = url_decode(url_e_input)

      if string.match(url_e_cand, "… $") then
        judge_unfinished = "〈輸入未完〉"
      else
        judge_unfinished = ""
      end

      local cand_url_e_error = Candidate("number", seg.start, seg._end, "", url_e_cand)  --字符過濾可能會過濾掉""整個選項。
      cand_url_e_error.preedit = url_e_prefix .. " " .. string.upper(preedit_url_e)

      local cand_url_e_sentence = Candidate("number", seg.start, seg._end, url_e_cand, judge_unfinished)
      cand_url_e_sentence.preedit = url_e_prefix .. " " .. string.upper(preedit_url_e)

      local url_first_word = utf8_sub(url_e_cand,1,1)
      local url_first_word_dec = utf8.codepoint(url_first_word)
      local cand_url_e_single = Candidate("number", seg.start, seg._end, url_first_word, string.format("  U+".."%X" ,url_first_word_dec) .. judge_unfinished)
      cand_url_e_single.preedit = url_e_prefix .. " " .. string.upper(preedit_url_e)

      local cand_url_e_code = Candidate("number", seg.start, seg._end, string.upper(preedit_url_e), "〔URL編碼〕")
      cand_url_e_code.preedit = url_e_prefix .. " " .. string.upper(preedit_url_e)

      if string.match(url_e_cand, "^〈輸入錯誤〉") then
      -- if url_e_cand == "〈輸入錯誤〉" then
        yield(cand_url_e_error)
      elseif url_e_cand == url_first_word then
        yield(cand_url_e_single)
      -- elseif string.match(url_e_cand, "^ …") then
      --   yield(cand_url_e_sentence)
      else
        yield(cand_url_e_sentence)
        -- yield(cand_url_e_single)
      end
      yield(cand_url_e_code)
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
    local dot0 ,numberout, dot1, afterdot = string.match(input, "`(%.?)(%d+)(%.?)(%d*)$")
    if (tonumber(numberout)~=nil) then
      if (dot0=='.') and (dot1=='.') then
        yield(Candidate("number", seg.start, seg._end, "" , "〔不能兩個小數點〕"))  --字符過濾可能會過濾掉""整個選項。
        return
      elseif (dot0=='.') then
        afterdot = numberout
        dot1 = dot0
        numberout = '0'
      end
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
      elseif (dot0=='.') then
        yield(Candidate("number", seg.start, seg._end, military_number(dot1..afterdot), "〔軍中數字〕"))
      elseif (dot0~='.') and (dot1=='.') then
        yield(Candidate("number", seg.start, seg._end, military_number(numberout..dot1..afterdot), "〔軍中數字〕"))
      end
      return
    end

  end
end


return t_translator