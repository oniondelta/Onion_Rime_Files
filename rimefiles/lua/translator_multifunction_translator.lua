--[[
從 lunar_calendar 資料夾匯入兩個農曆相關函數集合
--]]

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
--- 農曆相關轉換
local lc_1 = require("lunar_calendar/lunar_calendar_1")
local Dec2bin = lc_1.Dec2bin
local Date2LunarDate = lc_1.Date2LunarDate
local LunarDate2Date = lc_1.LunarDate2Date
-- local GetNextJQ = lc_1.GetNextJQ
local GetNowTimeJq = lc_1.GetNowTimeJq
local lunarJzl = lc_1.lunarJzl

local lc_2 = require("lunar_calendar/lunar_calendar_2")
local time_description_chinese = lc_2.time_description_chinese
local Moonphase_out1 = lc_2.Moonphase_out1
local Moonphase_out2 = lc_2.Moonphase_out2
local jieqi_out1 = lc_2.jieqi_out1

local GetLunarSichen = require("lunar_calendar/lunar_time")

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
local paren_number = f_n_s.paren_number
local purech_number = f_n_s.purech_number
local purebigch_number = f_n_s.purebigch_number
local military_number = f_n_s.military_number
local little1_number = f_n_s.little1_number
local little2_number = f_n_s.little2_number
local braille_c_number = f_n_s.braille_c_number
local braille_u_number = f_n_s.braille_u_number
local emoji_number = f_n_s.emoji_number
local keycap_number = f_n_s.keycap_number
local keycap_ns_number = f_n_s.keycap_ns_number
local mss_number = f_n_s.mss_number
local mssb_number = f_n_s.mssb_number
local mm_number = f_n_s.mm_number
local arabic_indic_number = f_n_s.arabic_indic_number
local extended_arabic_indic_number = f_n_s.extended_arabic_indic_number
local devanagari_number = f_n_s.devanagari_number

local f_c_n = require("f_components/f_chinese_number")
local read_number = f_c_n.read_number
local read_number_bank = f_c_n.read_number_bank
local confs = f_c_n.confs

local f_e_s = require("f_components/f_english_style")
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
local english_mds_u = f_e_s.english_mds_u
local english_mds_l = f_e_s.english_mds_l
local english_ms_u = f_e_s.english_ms_u
local english_ms_l = f_e_s.english_ms_l
local english_mf_u = f_e_s.english_mf_u
local english_mf_l = f_e_s.english_mf_l
local english_mss_u = f_e_s.english_mss_u
local english_mss_l = f_e_s.english_mss_l
local english_mssi_u = f_e_s.english_mssi_u
local english_mssi_l = f_e_s.english_mssi_l
local english_mssb_u = f_e_s.english_mssb_u
local english_mssb_l = f_e_s.english_mssb_l
local english_mssbi_u = f_e_s.english_mssbi_u
local english_mssbi_l = f_e_s.english_mssbi_l
local english_mi_u = f_e_s.english_mi_u
local english_mi_l = f_e_s.english_mi_l
local english_mm_u = f_e_s.english_mm_u
local english_mm_l = f_e_s.english_mm_l
local english_mb_u = f_e_s.english_mb_u
local english_mb_l = f_e_s.english_mb_l
local english_mbi_u = f_e_s.english_mbi_u
local english_mbi_l = f_e_s.english_mbi_l
local english_mbs_u = f_e_s.english_mbs_u
local english_mbs_l = f_e_s.english_mbs_l
local english_mbf_u = f_e_s.english_mbf_u
local english_mbf_l = f_e_s.english_mbf_l
local english_3_4 = f_e_s.english_3_4
local english_5_6 = f_e_s.english_5_6
local english_f_ul = f_e_s.english_f_ul
local english_mds_ul = f_e_s.english_mds_ul
local english_ms_ul = f_e_s.english_ms_ul
local english_mf_ul = f_e_s.english_mf_ul
local english_mss_ul = f_e_s.english_mss_ul
local english_mssi_ul = f_e_s.english_mssi_ul
local english_mssb_ul = f_e_s.english_mssb_ul
local english_mssbi_ul = f_e_s.english_mssbi_ul
local english_mi_ul = f_e_s.english_mi_ul
local english_mm_ul = f_e_s.english_mm_ul
local english_mb_ul = f_e_s.english_mb_ul
local english_mbi_ul = f_e_s.english_mbi_ul
local english_mbs_ul = f_e_s.english_mbs_ul
local english_mbf_ul = f_e_s.english_mbf_ul
local english_s = f_e_s.english_s
local english_s2u = f_e_s.english_s2u
local english_braille_c_u = f_e_s.english_braille_c_u
local english_braille_c_l = f_e_s.english_braille_c_l
local english_braille_c_ul = f_e_s.english_braille_c_ul
local english_braille_u_u = f_e_s.english_braille_u_u
local english_braille_u_l = f_e_s.english_braille_u_l
local english_braille_u_ul = f_e_s.english_braille_u_ul

----------------------------------------------------------------------------------------
--- Unicode 等各種字符編碼轉換

local utf8_sub = require("f_components/f_utf8_sub")

local utf8_out = require("f_components/f_utf8_out")

local url_encode = require("f_components/f_url_encode")

local url_decode = require("f_components/f_url_decode")

----------------------------------------------------------------------------------------
--- 計算機

local simple_calculator = require("f_components/f_simple_calculator")

----------------------------------------------------------------------------------------
--- 按鍵說明

local hotkeys = require("f_components/keys_table/hot_keys")
local kh_table = require("f_components/keys_table/kh_table")
local ks_table = require("f_components/keys_table/ks_table")
local kj_table = require("f_components/keys_table/kj_table")
local ki_table = require("f_components/keys_table/ki_table")
local kp_table = require("f_components/keys_table/kp_table")
local ky_table = require("f_components/keys_table/ky_table")
local kg_table = require("f_components/keys_table/kg_table")
local kc_table = require("f_components/keys_table/kc_table")
local numberkeys = require("f_components/keys_table/number_keys")

----------------------------------------------------------------------------------------
--- 快捷開啟

local run_pattern = require("p_components/p_run_pattern")
local run_menu = require("p_components/p_run_menu")

----------------------------------------------------------------------------------------
--- 置入方案範例
--[[
engine:
  translators:
    - lua_translator@mf_translator

mf_translator:
  prefix: "'/"  # "`" 或其他
--]]
----------------------------------------------------------------------------------------
local function init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  -- local namespace = "mf_translator"
  env.prefix = config:get_string(env.name_space .. "/prefix")
  env.prefix_s = "^" .. env.prefix
  env.schema_id = config:get_string("schema/schema_id")
  env.menu_table = {
        -- { "〔半角〕", "`" }
        { "⓪", "〖日期和時間〗" }
      , { "①", "　f 或 h〔年月日〕  ym〔年月〕  md〔月日〕" }
      , { "②", "　y〔年〕  m〔月〕  d〔日〕  w〔週〕" }
      , { "③", "　n〔時:分〕  t〔時:分:秒〕" }
      , { "④", "　fw〔年月日週〕  mdw〔月日週〕" }
      , { "⑤", "　fn〔年月日 時:分〕  ft〔年月日 時:分:秒〕" }
      , { "⑥", "　p〔程式格式〕  z〔時區〕  s〔節氣〕  l〔月相〕" }
      -- , { "⑥", "  ○/○/○〔 ○ 年 ○ 月 ○ 日〕  ○/○〔 ○ 月 ○ 日〕" }
      -- , { "⑦", "  ○-○-○〔○年○月○日〕  ○-○〔○月○日〕" }
      , { "⑦", "　○ y ○ m ○ d〔○年○月○日〕" }
      , { "⑧", "　○ y ○ m〔○年○月〕    ○ m ○ d〔○月○日〕" }
      , { "⑨", "　○ y〔○年〕    ○ m〔○月〕    ○ d〔○日〕" }
      , { "⑩", "〖數字和計算機〗" }
      -- , { "⑨", "  ○○○〔數字〕" }
      , { "⑪", "　[ - . 0-9 ]+〔數字〕" }
      , { "⑫", "　[ - . 0-9 ]+[ + - * / ^ ( ) ]…〔計算機〕" }
      , { "⑬", "　※ 算符： ‹+ a›   ‹- r›   ‹* x›   ‹/ v›   ‹^ s›   ‹ ( q›   ‹ ) w›　" }
      , { "⑭", "〖字母〗" }
      , { "⑮", "　/ [ a-z , . - \' / ]+〔小寫字母〕" }
      , { "⑯", "　; [ a-z , . - \' / ]+〔大寫字母〕" }
      , { "⑰", "　\' [ a-z , . - \' / ]+〔開頭大寫字母〕" }
      , { "⑱", "〖Unicode 內碼〗" }
      , { "⑲", "　i [ 0-9 a-f ]+〔 Percent/URL encoding 〕" }
      , { "⑳", "　u [ 0-9 a-f ]+〔內碼十六進制 Hex 〕(Unicode)" }
      , { "㉑", "　x [ 0-9 a-f ]+〔內碼十六進制 Hex 〕(Unicode)" }
      , { "㉒", "　c [ 0-9 ]+〔內碼十進制 Dec 〕" }
      , { "㉓", "　o [ 0-7 ]+〔內碼八進制 Oct 〕" }
      , { "㉔", "〖快捷功能〗" }
      , { "㉕", "　e 或 j  [ a-z ]+〔快捷開啟〕" }
      , { "㉖", "　a 或 , 〔短語總列表〕" }
      , { "㉗", "〖鍵位和編碼〗" }
      , { "㉘", "　k k〔快捷鍵 說明〕" }
      , { "㉙", "　k o〔操作鍵 說明〕" }
      , { "㉚", "　k j〔日文 羅馬字 編碼〕" }
      , { "㉛", "　k h〔韓文 HNC 編碼〕(注音系列)" }
      , { "㉜", "　k s〔韓文 洋蔥形碼 編碼〕(形碼系列)" }
      , { "㉝", "　k i〔拉丁 洋蔥形碼 IPA 國際音標 編碼〕" }
      , { "㉞", "　k p〔拉丁 洋蔥形碼 KK/DJ/IPA 音標 編碼〕" }
      , { "㉟", "　k y〔拉丁 洋蔥形碼 中文拼音 編碼〕" }
      , { "㊱", "　k g〔希臘 洋蔥形碼 編碼〕" }
      , { "㊲", "　k c〔西里爾 洋蔥形碼 編碼〕" }
      , { "㊳", "　k n〔數符選項 鍵位〕" }
      , { "㊴", "〖記憶體〗" }
      , { "㊵", "　g〔 Lua 所佔記憶體〕(Garbage)" }
      , { "㊶", "　gc〔垃圾回收〕(Garbage Collection)" }
      , { "㊷", "〖版本和路徑〗" }
      , { "㊸", "　v〔版本資訊〕" }
      , { "㊹", "　vf〔資料夾路徑〕" }
      , { "㊺", "═══  結束  ═══  " }
      , { "㊻", "" }
      , { "㊼", "" }
      , { "㊽", "" }
      , { "㊾", "" }
      , { "㊿", "" }
      -- , { "㉛", "===========  結束  ===========    " }
      -- , { "床前明月光，疑是地上霜。\r舉頭望明月，低頭思故鄉。", "〔夜思‧李白〕" }
      }
  env.run_menu_table = run_menu(run_pattern)
  -- log.info("mf_translator Initilized!")
end
----------------------------------------------------------------------------------------
--- @@ mf_translator
--[[
掛載 mf_translator 函數開始
--]]
local function translate(input, seg, env)
  local engine = env.engine
  local context = engine.context
  -- local caret_pos = context.caret_pos or 0

-----------------------------
-----------------------------

  --- 跳掉不符合該 translate 時機用
  local tag_mf = seg:has_tag("mf_translator")
  -- local start_key = string.match(input, "^" .. env.prefix)
  -- if not tag_mf or not start_key then return end
  if not tag_mf then return end
  -- if not seg:has_tag("mf_translator") then return end
  -- if tag_mf then
  -- if seg:has_tag("mf_translator") then
  -- if seg:has_tag("mf_translator") and string.match(input, env.prefix) then
  -- if string.match(input, env.prefix) then
  -- local start_key = string.match(input, env.prefix)
  -- if start_key then

    -- local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    -- local chinese_time = time_description_chinese(os.time())
    -- local All_g, Y_g, M_g, D_g, H_g = lunarJzl(os.date("%Y%m%d%H"))
    -- local ll_1, ll_2, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    -- local aptime1, aptime2, aptime3, aptime4, aptime5, aptime6, aptime7, aptime8, aptime0_1, aptime0_2, aptime0_3, aptime0_4, aptime00_1, aptime00_2,  aptime00_3, aptime00_4 = time_out1()
    -- local aptime_c1, aptime_c2, aptime_c3, aptime_c4, ap_5 = time_out2()

-----------------------------
-----------------------------

  --- 精簡程式碼用
  -- local yield_c = function(cand_text, comment, preedit_text)
  local function yield_c(cand_text, comment, preedit_text)
    -- comment = comment == nil and "" or comment
    local comment = comment or ""
    local cand = Candidate("simp_mf", seg.start, seg._end, cand_text, comment)
    -- cand.preedit = preedit_text == nil and cand.preedit or preedit_text == "" and cand.preedit or preedit_text
    if preedit_text ~= nil and preedit_text ~= "" then
      cand.preedit = preedit_text
    end
    yield(cand)
  end
  -- local yield_c = function(cand_text, comment)
  --   -- comment = comment == nil and "" or comment
  --   local comment = comment or ""
  --   yield(Candidate("simp_mf", seg.start, seg._end, cand_text, comment))
  -- end

  --- 不足兩位數補零 zero padding 提示用（精簡程式碼用，利於一次性全部更改）。
  local function yield_zp(preedit_text)
    yield_c( "", "── 以下前置補０至２位 ──", preedit_text)
    -- local cand = Candidate("simp_mf", seg.start, seg._end, "", "── 以下前置補０至２位 ──")
    -- if preedit_text ~= nil and preedit_text ~= "" then
    --   cand.preedit = preedit_text
    -- end
    -- yield(cand)
  end

-----------------------------
-----------------------------

--- 擴充模式 \r\n    日期 (年月日) ~d \r\n    年 ~y  月 ~m  日 ~day \r\n    年月 ~ym  月日 ~md \r\n    時間 (時分) ~n   (時分秒) ~t \r\n    日期時間 (年月日時分) ~dn\r\n    日期時間 (年月日時分秒) ~dt
  if input == env.prefix then
  -- if input:find("^" .. env.prefix .. "$") then
    -- yield_c( "" , "擴充模式")
    -- yield_c( "║　d〔年月日〕┃   ym〔年月〕┃　md〔月日〕║" , "")
    -- yield_c( "║　　y〔年〕　┃　　m〔月〕 ┃　　dy〔日〕 ║" , "")
    -- yield_c( "║　　　n〔時:分〕　　 ┃　　　t〔時:分:秒〕　║" , "")
    -- yield_c( "║　dn〔年月日 時:分〕  ┃ dt〔年月日 時:分:秒〕║" , "")
    -- yield_c( "║*/*/*〔 * 年 * 月 * 日〕┃　*-*-*〔*年*月*日〕 ║" , "")
    -- yield_c( "║　　*/*〔 * 月 * 日〕   ┃　　 *-*〔*月*日〕　 ║" , "")

    -- yield_c( "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , "")
    -- yield_c( "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , "")
    -- yield_c( "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , "")
    -- -- yield_c( "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , "")
    -- yield_c( "┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕" , "")
    -- yield_c( "┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕┇ ○○○〔數字〕" , "")
    -- -- yield_c( "┃ ○○○〔數字〕" , "")

    for k, v in ipairs(env.menu_table) do
      -- yield_c( v[1], " " .. v[2], input .. "\t《時間日期數字字母》▶")
      yield_c( v[1], " " .. v[2], input .. "\t《特殊功能集》▶")
    end
    return
  end

  if input == env.prefix .. "/" then
    yield_c( "", "  ~ [a-z]+〔小寫字母〕", input .. "\t 【小寫字母】▶")
    return
  end

  if input == env.prefix .. ";" then
    yield_c( "", "  ~ [a-z]+〔大寫字母〕", input .. "\t 【大寫字母】▶")
    return
  end

  if input == env.prefix .. "\'" then
    yield_c( "", "  ~ [a-z]+〔開頭大寫字母〕", input .. "\t 【開頭大寫字母】▶")
    return
  end

  if input == env.prefix .. "x" then
    yield_c( "", "  ~ [0-9a-f]+〔內碼十六進制 Hex〕(Unicode)", input .. "\t 【內碼十六進制】▶")
    return
  end

  if input == env.prefix .. "u" then
    yield_c( "", "  ~ [0-9a-f]+〔內碼十六進制 Hex〕(Unicode)", input .. "\t 【內碼十六進制】▶")
    return
  end

  if input == env.prefix .. "c" then
    yield_c( "", "  ~ [0-9]+〔內碼十進制 Dec〕", input .. "\t 【內碼十進制】▶")
    return
  end

  if input == env.prefix .. "o" then
    yield_c( "", "  ~ [0-7]+〔內碼八進制 Oct〕", input .. "\t 【內碼八進制】▶")
    return
  end

  if input == env.prefix .. "i" then
    yield_c( "", "  ~ [0-9a-f]+〔Percent/URL encoding〕", input .. "\t 【Percent/URL encoding】▶")
    return
  end


  -- 短語總列表（提示：無短語功能）
  -- local bopomo_onion_double = string.match( env.schema_id, "^bopomo_onion_double")
  -- local onion_array30 = string.match( env.schema_id, "^onion[-]array30")
  -- if input == env.prefix .. "a" and (bopomo_onion_double or onion_array30) then
  if env.schema_id == "onion-array30" and (input == env.prefix .. "a" or input == env.prefix .. ",") then
  -- if env.prefix == "`" and (input == env.prefix .. "a" or input == env.prefix .. ",") then
    yield_c( "", "〔無短語功能〕", input .. "\t 【短語總列表】")
    return
  end


  -- 版本資訊
  if input == env.prefix .. "v" then
    local preedittext = input .. "\t 【版本資訊】"
    yield_c( Ver_info(env)[1], "〔 介面 名稱和版本 〕", preedittext)  -- 〔 distribution_version 〕
    yield_c( Ver_info(env)[2], "〔 librime / rime 版本 〕", preedittext)  -- 〔 rime_version 〕
    yield_c( Ver_info(env)[3], "〔 librime-lua 版本 〕", preedittext)  -- 〔 librime-lua_version 〕
    yield_c( Ver_info(env)[4], "〔 lua 版本 〕", preedittext)  -- 〔 lua_version 〕
    yield_c( Ver_info(env)[5], "〔 ID 〕", preedittext)  -- 〔 installation_id 〕
    --- 記憶體回收，上方可能讓記憶暴漲，故增 collectgarbage。
    -- collectgarbage()  -- 強制進行垃圾回收
    -- collectgarbage("collect")  -- 做一次完整的垃圾收集循環
    return
  end

  -- 資料夾路徑
  if input == env.prefix .. "vf" then
    local preedittext = input .. "\t 【資料夾路徑】"
    -- yield_c( "", " ═════ 資料夾 ═════  ", preedittext)
    yield_c( Ver_info(env)[6], "〔 用戶資料夾 〕", preedittext)  -- 〔user_data_dir〕
    yield_c( Ver_info(env)[7], "〔 同步資料夾 〕", preedittext)  -- 〔sync_dir〕
    yield_c( Ver_info(env)[8], "〔 程序資料夾 〕", preedittext)  -- 〔shared_data_dir〕
    return
  end


  -- lua 所佔垃圾/記憶體(Garbage)
  if input == env.prefix .. "g" then
    local preedittext = input .. "\t 【Lua 所佔記憶體】(Garbage)"
    yield_c( ("%.f"):format(collectgarbage("count")) .. " KB", "〔 the amount of Lua memory 〕 ~c", preedittext)
    -- yield_c( "", " ~c 〔垃圾回收〕(Garbage Collection)", preedittext)
    return
  end

  -- 垃圾回收器(Garbage Collection)
  if input == env.prefix .. "gc" then
    local preedittext = input .. "\t 【垃圾回收】(Garbage Collection)"
    yield_c( ("%.f"):format(collectgarbage("count")) .. " KB", "〔 the amount of Lua memory before GC 〕", preedittext)
    -- yield_c( ("%.f"):format(collectgarbage("count")*1024) .. " Bytes", "〔 the amount of lua memory before GC 〕")
    -- yield_c( collectgarbage("count") .. " KB", "〔 the amount of lua memory before GC 〕")
    -- yield_c( collectgarbage("count")*1024, "〔 the amount of lua memory before GC 〕")
    collectgarbage()  -- 強制進行垃圾回收
    -- collectgarbage("collect")  -- 做一次完整的垃圾收集循環
    yield_c( ("%.f"):format(collectgarbage("count")) .. " KB", "〔 the amount of Lua memory after GC 〕", preedittext)
    -- yield_c( ("%.f"):format(collectgarbage("count")*1024) .. " Bytes", "〔 the amount of lua memory after GC 〕")
    -- yield_c( collectgarbage("count") .. " KB", "〔 the amount of lua memory after GC 〕")
    -- yield_c( collectgarbage("count")*1024, "〔 the amount of lua memory after GC 〕")
    return
  end


  -- lua 程式原生時間
  if input == env.prefix .. "p" then
    local preedittext = input .. "\t 【程式格式】"
    yield_c( os.date(), "〔 os.date() 〕", preedittext)
    yield_c( os.time(), "〔 os.time()，當前距 1970.1.1.08:00 秒數〕", preedittext)
    return
  end

  if input == env.prefix .. "z" then
    local preedittext = input .. "\t 【時區】"
    -- local tz, tzd = timezone_out()
    yield_c( timezone_out()[1], "〔世界協調時間〕", preedittext)
    yield_c( timezone_out()[5], "〔格林威治標準時間〕", preedittext)
    yield_c( timezone_out()[2], "〔本地時區代號〕", preedittext)
    return
  end

  if input == env.prefix .. "l" then
    local preedittext = input .. "\t 【月相】"
    -- local Moonshape, Moonangle = Moonphase_out1()
    yield_c( Moonphase_out1()[1], Moonphase_out1()[2], preedittext)
    -- local p, d = Moonphase_out2()
    yield_c( Moonphase_out2()[1], Moonphase_out2()[2], preedittext)
    return
  end

  if input == env.prefix .. "s" then
    local preedittext = input .. "\t 【節氣】"
    local jq_1, jq_2, jq_3 ,jq_4 = jieqi_out1()
    yield_c( jq_1, jq_2, preedittext)
    yield_c( jq_3, jq_4, preedittext)
    local nt_jqs = GetNowTimeJq(os.date("%Y%m%d")) or 1
    -- local n_jqsy = GetNextJQ(os.date("%Y"))  -- 會少最近一期節氣
    for i =1,#nt_jqs do
      yield_c( nt_jqs[i], "", preedittext)  --〔節氣〕
    end
    local nt_jqs = nil
    return
  end

-----------------------------
-----------------------------

  -- --- Lua 字符類依賴於本地環境，故'[a-z]'可能與'%l'表示的字符集不同。一般情況下，後者包括'ç'和'ã'，前者沒有。
  -- --- 承上，盡量使用後者來表示字母，除非出於特殊考慮，因後者更簡單、方便、高效。
  -- --- goto 和 ::Label:: 之後不要接變數，例：local abc = xxx，易產生錯誤！
  ---
  -- local op_check = string.match(input, env.prefix_s .. "j(%l*)$")
  local op_prefix, op_check = string.match(input, env.prefix_s .. "([ej])(%l*)$")
  local op_preedit = op_check and op_check ~= "" and env.prefix .. op_prefix .. " " .. string.upper(op_check) .. "\t 【快捷開啟】" or ""  -- 無 op_check 則為 nil，但 op_check == "" 則為 false 不為 nil。
  ---
  local k_key = string.match(input, env.prefix_s .. "k%l?$")
  ---
  local t_key = string.match(input, env.prefix_s .. "t%l?$")
  local n_key = string.match(input, env.prefix_s .. "n%l?$")
  local d_key = string.match(input, env.prefix_s .. "d%l?$")
  local w_key = string.match(input, env.prefix_s .. "w%l?$")
  local y_key = string.match(input, env.prefix_s .. "y%l*$")
  local m_key = string.match(input, env.prefix_s .. "m%l*$")
  local fh_key = string.match(input, env.prefix_s .. "[fh]%l*$")
  ---
  local englishout1 = string.match(input, env.prefix_s .. "/([%l.,/'-]+)$")
  local englishout2 = string.match(input, env.prefix_s .. "\'([%l.,/'-]+)$")
  local englishout3 = string.match(input, env.prefix_s .. ";([%l.,/'-]+)$")
  ---
  local utf_input = string.match(input, env.prefix_s .. "([xuco][a-f%d]+)$")
  local urlencode_input = string.match(input, env.prefix_s .. "i([%l%d][a-f%d]*)$")
  ---
  --- 以下自訂日期開始
  local xy = string.match(input, env.prefix_s .. "(%d+)y$")
  local xm = string.match(input, env.prefix_s .. "(%d+)m$")
  local xd = string.match(input, env.prefix_s .. "(%d+)d$")
  -- local xm = string.match(input, env.prefix_s .. "(%d%d?)m$")
  -- local xd = string.match(input, env.prefix_s .. "(%d%d?)d$")
  ---
  -- --- 先在外部宣告區域變數（初始值為 nil）。因宣告過，下方處理不會建立新的全域變數，拋出後為區域變數。
  local y, m, m_suffix, d, d_suffix
  if string.match(input, env.prefix_s .. "%d+y1[3-9]") then
    y, m, m_suffix, d, d_suffix = string.match(input, env.prefix_s .. "(%d+)y(1)(m?)(%d*)(d?)$")  -- 後面可接無限數字，但顯示〈輸入錯誤〉。
    -- y, m, m_suffix, d, d_suffix = string.match(input, env.prefix_s .. "(%d+)y(1)(m?)(%d?%d?)(d?)$")
    -- tonumber_y = tonumber(y)
    -- tonumber_m = tonumber(m)
    -- tonumber_d = tonumber(d)
  else
    y, m, m_suffix, d, d_suffix = string.match(input, env.prefix_s .. "(%d+)y([01]?%d)(m?)(%d*)(d?)$")  -- 後面可接無限數字，但顯示〈輸入錯誤〉。
    -- y, m, m_suffix, d, d_suffix = string.match(input, env.prefix_s .. "(%d+)y([01]?%d)(m?)(%d?%d?)(d?)$")
    -- tonumber_y = tonumber(y)
    -- tonumber_m = tonumber(m)
    -- tonumber_d = tonumber(d)
  end
  -- local y, m, m_suffix = string.match(input, env.prefix_s .. "(%d+)y(%d%d?)(m?)$")
  -- local y, m, d, d_suffix = string.match(input, env.prefix_s .. "(%d+)y(%d%d?)m(%d%d?)(d?)$")
  -- --- 下面一行，把上兩行合併成一行，但沒判別「y1[3-9]」等容錯功能，故不採用。
  -- local y, m, m_suffix, d, d_suffix = string.match(input, env.prefix_s .. "(%d+)y(%d%d?)(m?)(%d?%d?)(d?)$")
  -- --- 下面一行，匹配到時，不知為何？只有開頭「y」不為 nil，其餘變數皆為 nil。
  -- --- 下面一行並承上說明：當執行 (match1) and (match2) or (match3) 時，Lua 的邏輯運算子只會保留第一個回傳值來進行布林判斷。
  -- local y, m, m_suffix, d, d_suffix = string.match(input, env.prefix_s .. "%d+y1[3-9]") and string.match(input, env.prefix_s .. "(%d+)y(1)(m?)(%d*)(d?)$") or string.match(input, env.prefix_s .. "(%d+)y([01]?%d)(m?)(%d*)(d?)$")
  ---
  local nm, nd, nd_suffix = string.match(input, env.prefix_s .. "(%d%d?)m(%d+)(d?)$")
  -- local nm, nd, nd_suffix = string.match(input, env.prefix_s .. "(%d%d?)m(%d%d?)(d?)$")
  ---
  --- 以下數字和計算機相關
  local paren_left_q = string.match(input, env.prefix_s .. "([q(][q(]?)$")
  local neg_nf = string.match(input, env.prefix_s .. "[q(]?[q(]?[-r]$")
  local dot = string.match(input, env.prefix_s .. "[q(]?[q(]?%.$")
  local neg_nf_dot = string.match(input, env.prefix_s .. "[q(]?[q(]?[-r]%.$")
  local double_dot_error = string.match(input, env.prefix_s .. "[-rq(]?[-rq(]?%d*%.%d*%.%d*$")
  local double_neg_error = string.match(input, env.prefix_s .. "[q(]?[q(]?[-r][-r]+%d*$")
  local double_neg_bracket_error = string.match(input, env.prefix_s .. "[-r][q(]%d*$")
  local neg_n, dot0 ,numberout, dot1, afterdot = string.match(input, env.prefix_s .. "([q(]?[q(]?[-r]?)(%.?)(%d+)(%.?)(%d*)$")
  local cal_input = string.match(input, env.prefix_s .. "([q(]?[q(]?[-r]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*)$")
  ---
  ---
  local num_preedit = string.match(input, env.prefix_s .. "([-rq(.%d]+)$") or ""
  local num_preedit = string.gsub(num_preedit, "r", "-")
  local num_preedit = string.gsub(num_preedit, "q", "(")
  local num_preedit = env.prefix .. " " .. num_preedit .. "\t 【數字】"  -- 數字格式開始

-----------------------------

  if op_check then
    goto op_check_label
  ---
  elseif k_key then
    goto k_label
  ---
  elseif t_key then
    goto t_label
  elseif n_key then
    goto n_label
  elseif d_key then
    goto d_label
  elseif w_key then
    goto w_label
  elseif y_key then
    goto y_label
  elseif m_key then
    goto m_label
  elseif fh_key then
    goto fh_label
  ---
  elseif englishout1 then
    goto englishout1_label
  elseif englishout2 then
    goto englishout2_label
  elseif englishout3 then
    goto englishout3_label
  ---
  elseif utf_input then
    goto utf_input_label
  elseif urlencode_input then
    goto urlencode_input_label
  ---
  elseif xy then
    goto xy_label
  elseif xm then
    goto xm_label
  elseif xd then
    goto xd_label
  elseif y then
    goto ym_ymd_label
  elseif nm then
    goto nmnd_label
  ---
  elseif paren_left_q then
    goto paren_left_q_label
  elseif neg_nf then
    goto neg_nf_label
  elseif dot then
    goto dot_label
  elseif neg_nf_dot then
    goto neg_nf_dot_label
  elseif double_dot_error or double_neg_error or double_neg_bracket_error then
    goto double_error_label
  elseif numberout then
    goto numberout_label
  elseif cal_input then
    goto cal_input_label
  ---
  else
    -- local num_preedit = nil  -- 數字格式結束，清空 num_preedit 記憶
    return
  end

-----------------------------
-----------------------------

  ::op_check_label::

  -- 快捷開啟（開啟檔案/程式/網站）
  -- if input == env.prefix .. "j" then
  if input == env.prefix .. op_prefix then
    -- local keys_table = {
    --     { "⓿", "※ 限起始輸入，限英文 [a-z]+  " }  -- ≤ 2
    --   , { "❶", "※ 編輯後須「重新部署」生效  " }  --  "────────────  "
    --   , { "❷", "  ~t   〔 編輯 快捷開啟 table 〕" }
    --   , { "❸", "  ~c   〔 編輯 custom 短語 〕" }
    --   , { "❹", "  ~r   〔 Rime 官方 GitHub 〕" }
    --   , { "❺", "  ~rw 〔 Rime 詳解 〕" }
    --   , { "❻", "  ~l   〔 librime-lua 官方 GitHub 〕" }
    --   , { "❼", "  ~lw 〔 librime-lua 腳本開發指南 〕" }
    --   , { "❽", "  ~o   〔 Onion 洋蔥 GitHub 〕" }
    --   , { "❾", "  ~ow 〔 Onion 洋蔥 GitHub Wiki 〕" }
    --   , { "❿", "═══  結束  ═══  " }
    --   , { "⓫", "" }
    --   , { "⓬", "" }
    --   , { "⓭", "" }
    --   , { "⓮", "" }
    --   , { "⓯", "" }
    --   , { "⓰", "" }
    --   , { "⓱", "" }
    --   , { "⓲", "" }
    --   , { "⓳", "" }
    --   , { "⓴", "" }
    --   }

    -- local keys_table = run_menu(run_pattern)  -- 不用 init 引入，直接引入
    -- for k, v in ipairs(keys_table) do
    for k, v in ipairs(env.run_menu_table) do -- init 引入
      yield_c( v[1], " " .. v[2], input .. "\t 【快捷開啟】▶")
    end
    return
  end


  -- op_check 先避免影響各種字母形式之功能
  -- local op_check = not string.match(input, env.prefix .. "['/;]") and string.match(input, env.prefix .. "j([a-z]+)$")
  -- local op_check = string.match(input, env.prefix_s .. "j([a-z]+)$")
  -- local first_check = input ~= nil and caret_pos - #input or 1
  -- if op_check and first_check ~= 0 then
  -- --- 《以下 preeit 演進取代過程》：
  -- -- env.prefix .. "j " .. string.upper(op_check) .. "\t 【快捷開啟】"
  -- -- env.prefix .. op_prefix .. " " .. string.upper(op_check) .. "\t 【快捷開啟】"
  -- -- op_preedit
  if op_check and seg.start ~= 0 then
      yield_c( "", "〔非起始輸入〕", op_preedit)
    return
  elseif op_check and #context.input ~= seg._end then
    yield_c( "", "〔光標非末尾狀態〕")
    -- yield_c( "", "〔光標非末尾狀態〕", op_preedit)  --光標非末尾狀態，此條無效，故關閉
  elseif op_check == "t" then
    yield_c( "", "〘 編輯 快捷開啟 table 〙", op_preedit)  -- or〔錯誤〕
    return
  -- elseif op_check == "c" and env.prefix == "`" then
  elseif op_check == "c" and env.schema_id == "onion-array30" then
    yield_c( "", "〔無短語功能〕", op_preedit)  -- or〔錯誤〕
    return
  elseif op_check == "c" then
    yield_c( "", "〘 編輯 custom 短語 〙", op_preedit)  -- or〔錯誤〕
    return
  -- elseif op_check and first_check == 0 then
  elseif op_check and seg.start == 0 then
    local run_in = run_pattern[ op_check ]
    if run_in ~= nil then
      if run_in.name ~= nil then
        yield_c( "", "〘 " .. run_in.name .. " 〙", op_preedit)  -- or〔錯誤〕
      else
        yield_c( "", "〔 NONAME：無法開啟 🛑 〕", op_preedit)  -- or〔錯誤〕
      end
      return
    elseif run_in == nil then
      yield_c( "", "〔無〕", op_preedit)  -- 〔無此開啟碼〕or〔錯誤〕
      -- --- 以下測試光標插入點等位置數值用
      -- local caret_pos = context.caret_pos or 0
      -- local cgp = context:get_preedit().text
      -- local cgpstart = context:get_preedit().sel_start
      -- local cgpend = context:get_preedit().sel_end
      -- yield_c( "", "#input：" .. #input .. "  seg.start：" .. seg.start .. "  seg._end：" .. seg._end .. "  input：" .. input .. "  caret_pos：" .. caret_pos .. "  get_preedit().text：" .. cgp .. "  get_preedit().sel_start：" .. cgpstart .. "  get_preedit().sel_end：" .. cgpend .. "  #context.input：" .. #context.input , env.prefix .. "j " .. op_check .. "\t 【快捷開啟】")  -- 〔無此開啟碼〕or〔錯誤〕
      return
    end
  -- elseif op_check == "fc" then
  --   yield_c( "", "〔無短語功能〕", env.prefix .. "j " .. op_check .. "\t 【快捷開啟】")  -- or〔錯誤〕
  --   return
  -- elseif op_check and first_check == 0 then
  -- -- if input == env.prefix .. "opp" then
  --   yield_c( "", "〔無此開啟碼〕", env.prefix .. "j " .. op_check .. "\t 【快捷開啟】")  -- or〔錯誤〕
  --   return
  end

-----------------------------

  ::k_label::

  -- 鍵位編碼說明
  if input == env.prefix .. "k" then
    local keys_table = {
        { "⓵", "  ~k 〔快捷鍵 說明〕" }
      , { "⓶", "  ~o 〔操作鍵 說明〕" }
      , { "⓷", "  ~j 〔日文 羅馬字 編碼〕" }
      , { "⓸", "  ~h 〔韓文 HNC 編碼〕(注音系列)" }
      , { "⓹", "  ~s 〔韓文 洋蔥形碼 編碼〕(形碼系列)" }
      , { "⓺", "  ~i 〔拉丁 洋蔥形碼 IPA 國際音標 編碼〕" }
      , { "⓻", "  ~p 〔拉丁 洋蔥形碼 KK/DJ/IPA 音標 編碼〕" }
      , { "⓼", "  ~y 〔拉丁 洋蔥形碼 中文拼音 編碼〕" }
      , { "⓽", "  ~g 〔希臘 洋蔥形碼 編碼〕" }
      , { "⓾", "  ~c 〔西里爾 洋蔥形碼 編碼〕" }
      , { "⑪", "  ~n 〔數符選項 鍵位〕" }
      , { "", "　═══  結束  ═══  " }
      -- , { "⓼", "===========  結束  ===========    " }
      }
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], input .. "\t 【鍵位和編碼】▶")
    end
    return
  end

  if input == env.prefix .. "ko" then
    -- local keys_table = hotkeys(env.schema_id)[1]
    -- for k, v in ipairs(keys_table) do
    for k, v in ipairs(hotkeys(env.schema_id)[1]) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k O" .. "\t 【操作鍵 說明】")
    end
    return
  end

  if input == env.prefix .. "kk" then
    -- local keys_table = hotkeys(env.schema_id)[2]
    -- for k, v in ipairs(keys_table) do
    for k, v in ipairs(hotkeys(env.schema_id)[2]) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k K" .. "\t 【快捷鍵 說明】")
    end
    return
  end

  -- if input == env.prefix .. "kk" then
  --   local keys_table = {
  --       { "  h〔韓文 HNC 鍵位〕", "⁰" }
  --     , { "  s〔韓文 洋蔥形碼 鍵位〕", "¹" }
  --     }
  --   for k, v in ipairs(keys_table) do
  --     yield_c( v[1], " " .. v[2], input .. "\t 【韓文鍵位】▶")
  --   end
  --   return
  -- end

  if input == env.prefix .. "kh" then
    local keys_table = kh_table
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k H" .. "\t 【韓文 HNC 編碼】" )
    end
    return
  end

  if input == env.prefix .. "ks" then
    local keys_table = ks_table
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k S" .. "\t 【韓文 洋蔥形碼 編碼】")
    end
    return
  end

  if input == env.prefix .. "kj" then
    local keys_table = kj_table
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k J" .. "\t 【日文 羅馬字 編碼】" )
    end
    return
  end

  if input == env.prefix .. "ki" then
    local keys_table = ki_table
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k I" .. "\t 【拉丁 洋蔥形碼 IPA國際音標 編碼】")
    end
    return
  end

  if input == env.prefix .. "kp" then
    local keys_table = kp_table
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k P" .. "\t 【拉丁 洋蔥形碼 KK/DJ/IPA音標 編碼】")
    end
    return
  end

  if input == env.prefix .. "ky" then
    local keys_table = ky_table
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k Y" .. "\t 【拉丁 洋蔥形碼 中文拼音 編碼】")
    end
    return
  end

  if input == env.prefix .. "kg" then
    local keys_table = kg_table
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k G" .. "\t 【希臘 洋蔥形碼 編碼】")
    end
    return
  end

  if input == env.prefix .. "kc" then
    local keys_table = kc_table
    for k, v in ipairs(keys_table) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k C" .. "\t 【西里爾 洋蔥形碼 編碼】")
    end
    return
  end

  if input == env.prefix .. "kn" then
    -- local keys_table = numberkeys(env.schema_id)
    -- for k, v in ipairs(keys_table) do
    for k, v in ipairs(numberkeys(env.schema_id)) do
      yield_c( v[1], " " .. v[2], env.prefix .. "k N" .. "\t 【數符選項 鍵位】")
    end
    return
  end

-----------------------------

  ::t_label::

  -- Candidate(type, start, end, text, comment)
  if input == env.prefix .. "t" then
    local t_I, t_H, t_M, t_S = os.date("%I"), os.date("%H"), os.date("%M"), os.date("%S")
    local time_out1_6 = time_out1()[6]
    local time_out2_7 = time_out2()[7]
    local time_out2_3 = time_out2()[3]
    local time_out2_5 = time_out2()[5]
    local preedittext = input .. "\t 【現時：時分秒】"  --〔時:分:秒〕
    -- yield_c( os.date("%H:%M"), "〔時:分〕 ~m", preedittext)
    -- yield_c( os.date("%H:%M:%S"), "〔時:分:秒〕 ~d", preedittext)
    yield_c( string.gsub(t_H .. ":" .. t_M .. ":" .. t_S, "^0", ""), " ~d", preedittext)
    -- local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
    yield_c( time_out1_6 , " ~m", preedittext)
    yield_c( string.gsub(t_H .. "時" .. t_M .. "分" .. t_S .. "秒", "0([%d])", "%1"), " ~c", preedittext)
    -- local a, b, aptime_c3, aptime_c4, ap_5 = time_out2()
    yield_c( string.gsub(time_out2_7, " 0([%d])", " %1"), " ~s", preedittext)
    yield_c( string.gsub(time_out2_3, "0([%d])", "%1"), " ~w", preedittext)
    yield_c( ch_h_date(t_H) .. "時" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", " ~z", preedittext)
    yield_c( time_out2_5 .. " " .. ch_h_date(t_I) .. "時" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", " ~u", preedittext)
    return
  end

  if input == env.prefix .. "ts" then
    local t_I, t_M, t_S = os.date("%I"), os.date("%M"), os.date("%S")
    local time_out2_7 = time_out2()[7]
    local time_out2_5 = time_out2()[5]
    local check_number_format = string.match(t_I, "^0")
    local preedittext = input .. "\t 【現時：時分秒】"  --〔時:分:秒〕
    -- local a, b, aptime_c3, aptime_c4 = time_out2()
    yield_c( string.gsub(time_out2_7, " 0([%d])", " %1"), "", preedittext)
    yield_c( time_out2_5 .. " " .. fullshape_number(string.gsub(t_I, "^0", "")) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( time_out2_7, "", preedittext)
      yield_c( time_out2_5 .. " " .. fullshape_number(t_I) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    end
    return
  end

  if input == env.prefix .. "tw" then
    local t_I, t_M, t_S = os.date("%I"), os.date("%M"), os.date("%S")
    local time_out2_3 = time_out2()[3]
    local time_out2_4 = time_out2()[4]
    local check_number_format = string.match(t_I, "^0") or string.match(t_M, "^0") or string.match(t_S, "^0")
    local preedittext = input .. "\t 【現時：時分秒】"  --〔時:分:秒〕
    -- local a, b, aptime_c3, aptime_c4 = time_out2()
    yield_c( string.gsub(time_out2_3, "0([%d])", "%1"), "", preedittext)
    yield_c( string.gsub(time_out2_4, "0([%d])", "%1"), "", preedittext)
    yield_c( fullshape_number(string.gsub(time_out2_3, "0([%d])", "%1")), "", preedittext)
    yield_c( fullshape_number(string.gsub(time_out2_4, "0([%d])", "%1")), "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( time_out2_3, "", preedittext)
      yield_c( time_out2_4, "", preedittext)
      yield_c( fullshape_number(time_out2_3), "", preedittext)
      yield_c( fullshape_number(time_out2_4), "", preedittext)
    end
    return
  end

  if input == env.prefix .. "tu" then
    local t_I, t_M, t_S = os.date("%I"), os.date("%M"), os.date("%S")
    local time_out2_5 = time_out2()[5]
    local preedittext = input .. "\t 【現時：時分秒】"  --〔時:分:秒〕
    -- local a, b, aptime_c3, aptime_c4, ap_5 = time_out2()
    yield_c( time_out2_5 .. " " .. ch_h_date(t_I) .. "時" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "", preedittext)
    yield_c( time_out2_5 .. " " .. ch_h_date(t_I) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "", preedittext)
    yield_c( time_out2_5 .. " " .. chb_h_date(t_I) .. "時" .. chb_minsec_date(t_M) .. "分" .. chb_minsec_date(t_S) .. "秒", "", preedittext)
    yield_c( time_out2_5 .. " " .. chb_h_date(t_I) .. "點" .. chb_minsec_date(t_M) .. "分" .. chb_minsec_date(t_S) .. "秒", "", preedittext)
    return
  end

  if input == env.prefix .. "td" then
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local check_number_format = string.match(t_H, "^0")
    local preedittext = input .. "\t 【現時：時分秒】"  --〔時:分:秒〕
    yield_c( string.gsub(t_H .. ":" .. t_M .. ":" .. t_S, "^0", ""), "", preedittext)
    yield_c( fullshape_number(string.gsub(t_H, "^0", "")) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( t_H .. ":" .. t_M .. ":" .. t_S, "", preedittext)
      yield_c( fullshape_number(t_H) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    end
    return
  end

  if input == env.prefix .. "tm" then
    local t_I = os.date("%I")
    local time_out1_6 = time_out1()[6]
    local time_out1_8 = time_out1()[8]
    local time_out1_7 = time_out1()[7]
    local time_out1_5 = time_out1()[5]
    local time_out1_14 = time_out1()[14]
    local time_out1_16 = time_out1()[16]
    local time_out1_15 = time_out1()[15]
    local time_out1_13 = time_out1()[13]
    local check_number_format = string.match(t_I, "^0")
    local preedittext = input .. "\t 【現時：時分秒】"  --〔時:分:秒〕
    -- local a, b, c, d, aptime5, aptime6, aptime7, aptime8, e, f, g, h, aptime00_1, aptime00_2,  aptime00_3, aptime00_4 = time_out1()
    yield_c( time_out1_6, "", preedittext)
    yield_c( time_out1_8, "", preedittext)
    yield_c( time_out1_7, "", preedittext)
    yield_c( time_out1_5, "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( time_out1_14, "", preedittext)
      yield_c( time_out1_16, "", preedittext)
      yield_c( time_out1_15, "", preedittext)
      yield_c( time_out1_13, "", preedittext)
    end
    return
  end

  if input == env.prefix .. "tc" then
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local check_number_format = string.match(t_H, "^0") or string.match(t_M, "^0") or string.match(t_S, "^0")
    local preedittext = input .. "\t 【現時：時分秒】"  --〔時:分:秒〕
    yield_c( string.gsub(t_H .. "時" .. t_M .. "分" .. t_S .. "秒", "0([%d])", "%1"), "", preedittext)
    yield_c( string.gsub(t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "0([%d])", "%1"), "", preedittext)
    yield_c( fullshape_number(string.gsub(t_H .. "時" .. t_M .. "分" .. t_S .. "秒", "0([%d])", "%1")), "", preedittext)
    yield_c( fullshape_number(string.gsub(t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "0([%d])", "%1")), "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( t_H .. "時" .. t_M .. "分" .. t_S .. "秒", "", preedittext)
      yield_c( t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "", preedittext)
      yield_c( fullshape_number(t_H .. "時" .. t_M .. "分" .. t_S .. "秒"), "", preedittext)
      yield_c( fullshape_number(t_H .. "點" .. t_M .. "分" .. t_S .. "秒"), "", preedittext)
    end
    return
  end

  if input == env.prefix .. "tz" then
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local preedittext = input .. "\t 【現時：時分秒】"  --〔時:分:秒〕
    yield_c( ch_h_date(t_H) .. "時" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "", preedittext)
    yield_c( ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "", preedittext)
    yield_c( chb_h_date(t_H) .. "時" .. chb_minsec_date(t_M) .. "分" .. chb_minsec_date(t_S) .. "秒", "", preedittext)
    yield_c( chb_h_date(t_H) .. "點" .. chb_minsec_date(t_M) .. "分" .. chb_minsec_date(t_S) .. "秒", "", preedittext)
    return
  end

  -- if input == env.prefix .. "tm" then
  --   yield_c( os.date("%H:%M"), "〔時:分〕")
  --   return
  -- end

-----------------------------

  ::n_label::

  if input == env.prefix .. "n" then
    local t_I, t_H, t_M = os.date("%I"), os.date("%H"), os.date("%M")
    local os_time = os.time()
    local time_out1_2 = time_out1()[2]
    local time_out2_6 = time_out2()[6]
    local time_out2_1 = time_out2()[1]
    local time_out2_5 = time_out2()[5]
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    -- yield_c( os.date("%H:%M:%S"), "〔時:分:秒〕 ~s", preedittext)
    -- yield_c( os.date("%H:%M"), "〔時:分〕 ~d", preedittext)
    yield_c( string.gsub(t_H .. ":" .. t_M, "^0", ""), " ~d", preedittext)
    -- local aptime1, aptime2, aptime3, aptime4 = time_out1()
    yield_c( time_out1_2, " ~m", preedittext)
    yield_c( string.gsub(t_H .. "時" .. t_M .. "分", "0([%d])", "%1"), " ~c", preedittext)
    -- local aptime_c1, aptime_c2, a, b, ap_5 = time_out2()
    yield_c( string.gsub(time_out2_6, " 0([%d])", " %1"), " ~s", preedittext)
    yield_c( string.gsub(time_out2_1, "0([%d])", "%1"), " ~w", preedittext)
    yield_c( ch_h_date(t_H) .. "時" .. ch_minsec_date(t_M) .. "分", " ~z", preedittext)
    yield_c( time_out2_5 .. " " .. ch_h_date(t_I) .. "時" .. ch_minsec_date(t_M) .. "分", " ~u", preedittext)
    -- local chinese_time = time_description_chinese(os.time())
    yield_c( time_description_chinese(os_time), "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "ns" then
    local t_I, t_M = os.date("%I"), os.date("%M")
    local time_out2_6 = time_out2()[6]
    local time_out2_5 = time_out2()[5]
    local check_number_format = string.match(t_I, "^0")
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    -- local aptime_c1, aptime_c2 = time_out2()
    yield_c( string.gsub(time_out2_6, " 0([%d])", " %1"), "", preedittext)
    yield_c( time_out2_5 .. " " .. fullshape_number(string.gsub(t_I, "^0", "")) .. "：" .. fullshape_number(t_M), "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( time_out2_6, "", preedittext)
      yield_c( time_out2_5 .. " " .. fullshape_number(t_I) .. "：" .. fullshape_number(t_M), "", preedittext)
    end
    return
  end

  if input == env.prefix .. "nw" then
    local t_I, t_M = os.date("%I"), os.date("%M")
    local time_out2_1 = time_out2()[1]
    local time_out2_2 = time_out2()[2]
    local check_number_format = string.match(t_I, "^0") or string.match(t_M, "^0")
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    -- local aptime_c1, aptime_c2 = time_out2()
    yield_c( string.gsub(time_out2_1, "0([%d])", "%1"), "", preedittext)
    yield_c( string.gsub(time_out2_2, "0([%d])", "%1"), "", preedittext)
    yield_c( fullshape_number(string.gsub(time_out2_1, "0([%d])", "%1")), "", preedittext)
    yield_c( fullshape_number(string.gsub(time_out2_2, "0([%d])", "%1")), "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( time_out2_1, "", preedittext)
      yield_c( time_out2_2, "", preedittext)
      yield_c( fullshape_number(time_out2_1), "", preedittext)
      yield_c( fullshape_number(time_out2_2), "", preedittext)
    end
    return
  end

  if input == env.prefix .. "nu" then
    local t_I, t_M = os.date("%I"), os.date("%M")
    local time_out2_5 = time_out2()[5]
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    -- local a, b, c, d, ap_5 = time_out2()
    yield_c( time_out2_5 .. " " .. ch_h_date(t_I) .. "時" .. ch_minsec_date(t_M) .. "分", "", preedittext)
    yield_c( time_out2_5 .. " " .. ch_h_date(t_I) .. "點" .. ch_minsec_date(t_M) .. "分", "", preedittext)
    yield_c( time_out2_5 .. " " .. chb_h_date(t_I) .. "時" .. chb_minsec_date(t_M) .. "分", "", preedittext)
    yield_c( time_out2_5 .. " " .. chb_h_date(t_I) .. "點" .. chb_minsec_date(t_M) .. "分", "", preedittext)
    return
  end

  if input == env.prefix .. "nd" then
    local t_H, t_M = os.date("%H"), os.date("%M")
    local check_number_format = string.match(t_H, "^0")
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    yield_c( string.gsub(t_H .. ":" .. t_M, "^0", ""), "", preedittext)
    yield_c( fullshape_number(string.gsub(t_H, "^0", "")) .. "：" .. fullshape_number(t_M), "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( t_H .. ":" .. t_M, "", preedittext)
      yield_c( fullshape_number(t_H) .. "：" .. fullshape_number(t_M), "", preedittext)
    end
    return
  end

  if input == env.prefix .. "nm" then
    local t_I = os.date("%I")
    local time_out1_2 = time_out1()[2]
    local time_out1_4 = time_out1()[4]
    local time_out1_3 = time_out1()[3]
    local time_out1_1 = time_out1()[1]
    local time_out1_10 = time_out1()[10]
    local time_out1_12 = time_out1()[12]
    local time_out1_11 = time_out1()[11]
    local time_out1_9 = time_out1()[9]
    local check_number_format = string.match(t_I, "^0")
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    -- local aptime1, aptime2, aptime3, aptime4 , a, b, c, d, aptime0_1, aptime0_2,  aptime0_3, aptime0_4 = time_out1()
    yield_c( time_out1_2, "", preedittext)
    yield_c( time_out1_4, "", preedittext)
    yield_c( time_out1_3, "", preedittext)
    yield_c( time_out1_1, "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( time_out1_10, "", preedittext)
      yield_c( time_out1_12, "", preedittext)
      yield_c( time_out1_11, "", preedittext)
      yield_c( time_out1_9, "", preedittext)
    end
    return
  end

  if input == env.prefix .. "nc" then
    local t_H, t_M = os.date("%H"), os.date("%M")
    local check_number_format = string.match(t_H, "^0") or string.match(t_M, "^0")
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    yield_c( string.gsub(t_H .. "時" .. t_M .. "分", "0([%d])", "%1"), "", preedittext)
    yield_c( string.gsub(t_H .. "點" .. t_M .. "分", "0([%d])", "%1"), "", preedittext)
    yield_c( fullshape_number(string.gsub(t_H .. "時" .. t_M .. "分", "0([%d])", "%1")), "", preedittext)
    yield_c( fullshape_number(string.gsub(t_H .. "點" .. t_M .. "分", "0([%d])", "%1")), "", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( t_H .. "時" .. t_M .. "分", "", preedittext)
      yield_c( t_H .. "點" .. t_M .. "分", "", preedittext)
      yield_c( fullshape_number(t_H .. "時" .. t_M .. "分"), "", preedittext)
      yield_c( fullshape_number(t_H .. "點" .. t_M .. "分"), "", preedittext)
    end
    return
  end

  if input == env.prefix .. "nz" then
    local t_H, t_M = os.date("%H"), os.date("%M")
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    yield_c( ch_h_date(t_H) .. "時" .. ch_minsec_date(t_M) .. "分", "", preedittext)
    yield_c( ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "", preedittext)
    yield_c( chb_h_date(t_H) .. "時" .. chb_minsec_date(t_M) .. "分", "", preedittext)
    yield_c( chb_h_date(t_H) .. "點" .. chb_minsec_date(t_M) .. "分", "", preedittext)
    return
  end

  if input == env.prefix .. "nl" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H = os.date("%H")
    local os_time = os.time()
    local All_g, Y_g, M_g, D_g, H_g = lunarJzl(t_Y .. t_m .. t_d .. t_H)
    local preedittext = input .. "\t 【現時：時分】"  --〔時:分〕
    -- local chinese_time = time_description_chinese(os.time())
    yield_c( time_description_chinese(os_time), "〔農曆〕", preedittext)
    yield_c( H_g .. "時", "〔農曆干支〕", preedittext)
    yield_c( GetLunarSichen(t_H), "〔農曆時辰〕", preedittext)
    return
  end

  -- if input == env.prefix .. "ns" then
  --   yield_c( os.date("%H:%M:%S"), "〔時:分:秒〕")
  --   return
  -- end

-----------------------------

  ::d_label::

  if input == env.prefix .. "d" then
    local preedittext = input .. "\t 【現時：日】"
    yield_c( os.date("%d"), " ~d   ~o", preedittext)
    yield_c( string.gsub(os.date("%d日"), "^0", ""), "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1(3), "〔中數〕 ~z", preedittext)
    -- yield_c( rqzdx2(3), "〔日〕", preedittext)
    yield_c( jp_d_date(os.date("%d")), "〔日本格式〕 ~j", preedittext)
    yield_c( "the " .. eng1_d_date(os.date("%d")), "〔英文全寫〕 ~a", preedittext)
    yield_c( eng2_d_date(os.date("%d")), "〔英文英數〕 ~e", preedittext)
    -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
    local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ld, "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "dl" then
    local preedittext = input .. "\t 【現時：日】"
    -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
    local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ld, "〔農曆〕", preedittext)
    local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
    yield_c( D_g .. "日", "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "da" then
    local preedittext = input .. "\t 【現時：日】"  --〔日〕〔*日*〕
    yield_c( "the " .. eng1_d_date(os.date("%d")), "〔英文全寫〕", preedittext)
    yield_c( " the " .. eng1_d_date(os.date("%d")) .. " ", "〔*英文全寫*〕", preedittext)
    yield_c( "The " .. eng1_d_date(os.date("%d")), "〔英文全寫〕", preedittext)
    yield_c( " The " .. eng1_d_date(os.date("%d")) .. " ", "〔*英文全寫*〕", preedittext)
    return
  end

  if input == env.prefix .. "de" then
    local preedittext = input .. "\t 【現時：日】"  --〔日〕〔*日*〕
    yield_c( eng2_d_date(os.date("%d")), "〔英文英數〕", preedittext)
    yield_c( " " .. eng2_d_date(os.date("%d")) .. " ", "〔*英文英數*〕", preedittext)
    yield_c( eng4_d_date(os.date("%d")), "〔英文英數〕", preedittext)
    yield_c( " " .. eng4_d_date(os.date("%d")) .. " ", "〔*英文英數*〕", preedittext)
    -- yield_c( " " .. eng3_d_date(os.date("%d")) .. " ", "〔*英文英數*〕", preedittext)
    return
  end

  if input == env.prefix .. "dj" then
    local preedittext = input .. "\t 【現時：日】"
    yield_c( jp_d_date(os.date("%d")), "〔日本格式〕", preedittext)
    return
  end

  if input == env.prefix .. "dc" then
    local preedittext = input .. "\t 【現時：日】"  --〔日〕〔*日*〕
    yield_c( string.gsub(os.date("%d日"), "^0", ""), "〔日期〕", preedittext)
    yield_c( string.gsub(os.date(" %d 日"), "([ ])0", "%1"), "〔*日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%d日"), "^0", "")), "〔日期〕", preedittext)
    local check_number_format = string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( os.date("%d日"), "〔日期〕", preedittext)
      yield_c( os.date(" %d 日"), "〔*日期〕", preedittext)
      yield_c( fullshape_number(os.date("%d")) .. "日", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "dd" or input == env.prefix .. "do" then
    local preedittext = input .. "\t 【現時：日】"  --〔日〕
    yield_c( os.date("%d"), "", preedittext)
    yield_c( fullshape_number(os.date("%d")), "", preedittext)
    return
  end

  if input == env.prefix .. "dz" then
    local preedittext = input .. "\t 【現時：日】"
    yield_c( rqzdx1(3), "〔中數〕", preedittext)
    yield_c( rqzdx2(3), "〔中數〕", preedittext)
    return
  end

-----------------------------

  ::w_label::

-- function week_translator0(input, seg)
  if input == env.prefix .. "w" then
    local preedittext = input .. "\t 【現時：週】"  --〔週〕
    yield_c( "星期" .. weekstyle()[1], "〔日期〕 ~c", preedittext)
    yield_c( "週" .. weekstyle()[1], "〔中文〕 ~z", preedittext)
    yield_c( weekstyle()[5] .. "曜日", "〔日本格式〕 ~j", preedittext)
    yield_c( weekstyle()[6], "〔英文全寫〕 ~a", preedittext)
    yield_c( weekstyle()[7], "〔英文縮寫〕 ~e", preedittext)
    return
  end

  if input == env.prefix .. "wa" then
    local preedittext = input .. "\t 【現時：週】"  --〔週〕〔*週*〕
    yield_c( weekstyle()[6], "〔英文全寫〕", preedittext)
    yield_c( " " .. weekstyle()[6] .. " ", "〔*英文全寫*〕", preedittext)
    return
  end

  if input == env.prefix .. "we" then
    local preedittext = input .. "\t 【現時：週】"  --〔週〕〔*週*〕
    yield_c( weekstyle()[7], "〔英文縮寫〕", preedittext)
    yield_c( " " .. weekstyle()[7] .. " ", "〔*英文縮寫*〕", preedittext)
    yield_c( weekstyle()[8], "〔英文縮寫〕", preedittext)
    yield_c( " " .. weekstyle()[8] .. " ", "〔*英文縮寫*〕", preedittext)
    return
  end

  if input == env.prefix .. "wc" then
    local preedittext = input .. "\t 【現時：週】"  --〔週〕〔*週*〕
    yield_c( "星期" .. weekstyle()[1], "〔日期〕", preedittext)
    yield_c( " " .. "星期" .. weekstyle()[1] .. " ", "〔*日期*〕", preedittext)
    yield_c( "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
    yield_c( " (" .. "星期" .. weekstyle()[1] .. ") ", "〔*日期*〕", preedittext)
    yield_c( "(" .. "星期" .. weekstyle()[1] .. ")", "〔日期〕", preedittext)
    yield_c( " " .. "星期" .. weekstyle()[2] .. " ", "〔*日期*〕", preedittext)
    return
  end

  if input == env.prefix .. "wz" then
    local preedittext = input .. "\t 【現時：週】"  --〔週〕〔*週*〕
    yield_c( "週" .. weekstyle()[1], "〔中文〕", preedittext)
    yield_c( " " .. "週" .. weekstyle()[1] .. " ", "〔*中文*〕", preedittext)
    yield_c( "（" .. "週" .. weekstyle()[1] .. "）", "〔中文〕", preedittext)
    yield_c( " (" .. "週" .. weekstyle()[1] .. ") ", "〔*中文*〕", preedittext)
    yield_c( "(" .. "週" .. weekstyle()[1] .. ")", "〔中文〕", preedittext)
    yield_c( " " .. "週" .. weekstyle()[2] .. " ", "〔*中文*〕", preedittext)
    return
  end

  if input == env.prefix .. "wj" then
    local preedittext = input .. "\t 【現時：週】"  --〔週〕〔*週*〕
    yield_c( weekstyle()[5] .. "曜日", "〔日本格式〕", preedittext)
    yield_c( " " .. weekstyle()[5] .. "曜日 ", "〔*日本格式*〕", preedittext)
    yield_c( "（" .. weekstyle()[5] .. "曜日）", "〔日本格式〕", preedittext)
    yield_c( " (" .. weekstyle()[5] .. "曜日) ", "〔*日本格式*〕", preedittext)
    yield_c( "(" .. weekstyle()[5] .. "曜日)", "〔日本格式〕", preedittext)
    yield_c( weekstyle()[5], "〔日本格式〕", preedittext)
    yield_c( " " .. weekstyle()[5] .. " ", "〔*日本格式*〕", preedittext)
    yield_c( "（" .. weekstyle()[5] .. "）", "〔日本格式〕", preedittext)
    yield_c( " (" .. weekstyle()[5] .. ") ", "〔*日本格式*〕", preedittext)
    yield_c( "(" .. weekstyle()[5] .. ")", "〔日本格式〕", preedittext)
    yield_c( weekstyle()[3], "〔日本格式〕", preedittext)
    yield_c( weekstyle()[4], "〔日本格式〕", preedittext)
    return
  end

-----------------------------

  ::y_label::

  if input == env.prefix .. "y" then
    local preedittext = input .. "\t 【現時：年】"  --〔年〕
    yield_c( os.date("%Y"), " ~d   ~o", preedittext)
    yield_c( os.date("%Y年"), "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1(1), "〔中數〕 ~z", preedittext)
    -- yield_c( rqzdx2(1), "〔年〕", preedittext)
    yield_c( "民國" .. min_guo(os.date("%Y")) .. "年", "〔民國〕 ~h", preedittext)
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年", "〔民國中數〕 ~g", preedittext)
    local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"), preedittext)
    yield_c( jp_y, "〔日本元号〕 ~j", preedittext)
    -- local a, b, chinese_y = to_chinese_cal_local(os.time())
    local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ly_1, "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "yj" then
    local preedittext = input .. "\t 【現時：年】"
    local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    yield_c( jp_y, "〔日本元号〕", preedittext)
    yield_c( fullshape_number(jp_y), "〔日本元号〕", preedittext)
    return
  end

  if input == env.prefix .. "yh" then
    local preedittext = input .. "\t 【現時：年】"
    yield_c( "民國" .. min_guo(os.date("%Y")) .. "年", "〔民國〕", preedittext)
    yield_c( "民國 " .. min_guo(os.date("%Y")) .. " 年", "〔民國*〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年", "〔民國〕", preedittext)
    return
  end

  if input == env.prefix .. "yg" then
    local preedittext = input .. "\t 【現時：年】"
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(os.date("%Y"))) .. "年", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[2], min_guo(os.date("%Y"))) .. "年", "〔民國中數〕", preedittext)
    return
  end

  if input == env.prefix .. "yl" then
    local preedittext = input .. "\t 【現時：年】"
    -- local a, b, chinese_y = to_chinese_cal_local(os.time())
    local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ly_1, "〔農曆〕", preedittext)
    yield_c( ly_2, "〔農曆〕", preedittext)
    -- local a, Y_g = lunarJzl(os.date("%Y%m%d%H"))
    -- yield_c( Y_g .. "年", "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "yc" then
    local preedittext = input .. "\t 【現時：年】"  --〔年〕
    yield_c( os.date("%Y年"), "〔日期〕", preedittext)
    yield_c( os.date(" %Y 年"), "〔*日期〕", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "年", "〔日期〕", preedittext)
    return
  end

  if input == env.prefix .. "yd" or input == env.prefix .. "yo" then
    local preedittext = input .. "\t 【現時：年】"  --〔年〕
    yield_c( os.date("%Y"), "", preedittext)
    yield_c( fullshape_number(os.date("%Y")), "", preedittext)
    return
  end

  if input == env.prefix .. "yz" then
    local preedittext = input .. "\t 【現時：年】"
    yield_c( rqzdx1(1), "〔中數〕", preedittext)
    yield_c( rqzdx2(1), "〔中數〕", preedittext)
    return
  end


  if input == env.prefix .. "ym" then
    local preedittext = input .. "\t 【現時：年月】"  --〔年月〕
    yield_c( os.date("%Y%m"), " ~d   ~o", preedittext)
    yield_c( os.date("%Y.%m"), " ~p   ~q", preedittext)
    yield_c( os.date("%Y/%m"), " ~s   ~y", preedittext)
    yield_c( os.date("%Y-%m"), " ~m   ~r", preedittext)
    yield_c( os.date("%Y_%m"), " ~u   ~v", preedittext)
    yield_c( string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1(12), "〔中數〕 ~z", preedittext)
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月", "([^%d])0", "%1"), "〔民國〕 ~h", preedittext)
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(2), "〔民國中數〕 ~g", preedittext)
    -- yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")), "〔年月〕 ~j", preedittext)
    local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    yield_c( jp_y .. string.gsub(os.date("%m") .. "月", "([^%d])0", "%1"), "〔日本元号〕 ~j", preedittext)
    yield_c( eng1_m_date(os.date("%m")) .. ", " .. os.date("%Y"), "〔英文逗點〕 ~a", preedittext)
    yield_c( eng1_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文格式〕 ~e", preedittext)
    -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
    local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ly_1 .. lm, "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "ymj" then
    local preedittext = input .. "\t 【現時：年月】"
    local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    yield_c( jp_y .. string.gsub(os.date("%m") .. "月", "([^%d])0", "%1"), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(jp_y .. string.gsub(os.date("%m") .. "月", "([^%d])0", "%1")), "〔日本元号〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( jp_y .. os.date("%m") .. "月", "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jp_y .. os.date("%m") .. "月"), "〔日本元号〕", preedittext)
    end
    return
  end
  -- if input == env.prefix .. "ymj" then
  --   yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")), "〔年月〕")
  --   return
  -- end

  if input == env.prefix .. "ymh" then
    local preedittext = input .. "\t 【現時：年月】"
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月", "([^%d])0", "%1"), "〔民國〕", preedittext)
    yield_c( string.gsub("民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月", "([^%d])0", "%1"), "〔民國*〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(string.gsub(os.date("%m"), "0([%d])", "%1")) .. "月", "〔民國〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( "民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月", "〔民國〕", preedittext)
      yield_c( "民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月", "〔民國*〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(os.date("%m")) .. "月", "〔民國〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "ymg" then
    local preedittext = input .. "\t 【現時：年月】"
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(2), "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(os.date("%Y"))) .. "年" .. rqzdx1(2), "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[2], min_guo(os.date("%Y"))) .. "年" .. rqzdx2(2), "〔民國中數〕", preedittext)
    return
  end

  if input == env.prefix .. "yml" then
    local preedittext = input .. "\t 【現時：年月】"
    -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
    local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ly_1 .. lm, "〔農曆〕", preedittext)
    yield_c( ly_2 .. lm, "〔農曆〕", preedittext)
    local All_g, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
    yield_c( Y_g .. "年" .. M_g .. "月", "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "yma" then
    local preedittext = input .. "\t 【現時：年月】"  --〔月年〕
    yield_c( eng1_m_date(os.date("%m")) .. ", " .. os.date("%Y"), "〔英文逗點〕", preedittext)
    yield_c( eng2_m_date(os.date("%m")) .. ", " .. os.date("%Y"), "〔英文逗點〕", preedittext)
    return
  end

  if input == env.prefix .. "yme" then
    local preedittext = input .. "\t 【現時：年月】"  --〔月年〕
    yield_c( eng1_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文格式〕", preedittext)
    yield_c( eng2_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文格式〕", preedittext)
    yield_c( eng3_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文格式〕", preedittext)
    return
  end

  if input == env.prefix .. "ymc" then
    local preedittext = input .. "\t 【現時：年月】"  --〔年月〕〔*年月*〕
    yield_c( string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔日期〕", preedittext)
    yield_c( string.gsub(os.date(" %Y 年 %m 月 "), "([^%d])0", "%1"), "〔*日期*〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1")), "〔日期〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( os.date("%Y年%m月"), "〔日期〕", preedittext)
      yield_c( os.date(" %Y 年 %m 月 "), "〔*日期*〕", preedittext)
      yield_c( fullshape_number(os.date("%Y")) .. "年" .. fullshape_number(os.date("%m")) .. "月", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "ymd" or input == env.prefix .. "ymo" then
    local preedittext = input .. "\t 【現時：年月】"  --〔年月〕
    yield_c( os.date("%Y%m"), "", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. fullshape_number(os.date("%m")), "", preedittext)
    yield_c( os.date("%m%Y"), "〔月年〕", preedittext)
    return
  end

  if input == env.prefix .. "yms" or input == env.prefix .. "ymy" then
    local preedittext = input .. "\t 【現時：年月】"  --〔年月〕
    yield_c( os.date("%Y/%m"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%Y")) .. "/" .. fullshape_number(os.date("%m")), "〔年月〕", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "／" .. fullshape_number(os.date("%m")), "", preedittext)
    yield_c( os.date("%m/%Y"), "〔月年〕", preedittext)
    return
  end

  if input == env.prefix .. "ymm" or input == env.prefix .. "ymr" then
    local preedittext = input .. "\t 【現時：年月】"  --〔年月〕
    yield_c( os.date("%Y-%m"), "", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "－" .. fullshape_number(os.date("%m")), "", preedittext)
    yield_c( os.date("%m-%Y"), "〔月年〕", preedittext)
    return
  end

  if input == env.prefix .. "ymu" or input == env.prefix .. "ymv" then
    local preedittext = input .. "\t 【現時：年月】"  --〔年月〕
    yield_c( os.date("%Y_%m"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%Y")) .. "_" .. fullshape_number(os.date("%m")), "〔年月〕", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "＿" .. fullshape_number(os.date("%m")), "", preedittext)
    yield_c( os.date("%m_%Y"), "〔月年〕", preedittext)
    return
  end

  if input == env.prefix .. "ymp" or input == env.prefix .. "ymq" then
    local preedittext = input .. "\t 【現時：年月】"  --〔年月〕
    yield_c( os.date("%Y.%m"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%Y")) .. "." .. fullshape_number(os.date("%m")), "〔年月〕", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "．" .. fullshape_number(os.date("%m")), "", preedittext)
    yield_c( os.date("%m.%Y"), "〔月年〕", preedittext)
    return
  end

  if input == env.prefix .. "ymz" then
    local preedittext = input .. "\t 【現時：年月】"
    yield_c( rqzdx1(12), "〔中數〕", preedittext)
    yield_c( rqzdx2(12), "〔中數〕", preedittext)
    return
  end

-----------------------------

  ::m_label::

  if input == env.prefix .. "m" then
    local preedittext = input .. "\t 【現時：月】"
    yield_c( os.date("%m"), " ~x   ~o", preedittext)
    yield_c( string.gsub(os.date("%m月"), "^0", ""), "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1(2), "〔中數〕 ~z", preedittext)
    -- yield_c( rqzdx2(2), "〔月〕", preedittext)
    yield_c( jp_m_date(os.date("%m")), "〔日本格式〕 ~j", preedittext)
    yield_c( eng1_m_date(os.date("%m")), "〔英文全寫〕 ~a", preedittext)
    yield_c( eng2_m_date(os.date("%m")), "〔英文縮寫〕 ~e", preedittext)
    -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
    local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( lm, "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "ml" then
    local preedittext = input .. "\t 【現時：月】"
    -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
    local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( lm, "〔農曆〕", preedittext)
    local All_g, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
    yield_c( M_g .. "月", "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "ma" then
    local preedittext = input .. "\t 【現時：月】"
    yield_c( eng1_m_date(os.date("%m")), "〔英文全寫〕", preedittext)
    yield_c( " " .. eng1_m_date(os.date("%m")) .. " ", "〔*英文全寫*〕", preedittext)
    return
  end

  if input == env.prefix .. "me" then
    local preedittext = input .. "\t 【現時：月】"
    yield_c( eng2_m_date(os.date("%m")), "〔英文縮寫〕", preedittext)
    yield_c( " " .. eng2_m_date(os.date("%m")) .. " ", "〔*英文縮寫*〕", preedittext)
    yield_c( eng3_m_date(os.date("%m")), "〔英文縮寫〕", preedittext)
    yield_c( " " .. eng3_m_date(os.date("%m")) .. " ", "〔*英文縮寫*〕", preedittext)
    return
  end

  if input == env.prefix .. "mj" then
    local preedittext = input .. "\t 【現時：月】"
    yield_c( jp_m_date(os.date("%m")), "〔日本格式〕", preedittext)
    return
  end

  if input == env.prefix .. "mc" then
    local preedittext = input .. "\t 【現時：月】"  --〔月〕〔*月〕
    yield_c( string.gsub(os.date("%m月"), "^0", ""), "〔日期〕", preedittext)
    yield_c( string.gsub(os.date(" %m 月"), "([ ])0", "%1"), "〔*日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月"), "^0", "")), "〔日期〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( os.date("%m月"), "〔日期〕", preedittext)
      yield_c( os.date(" %m 月"), "〔*日期〕", preedittext)
      yield_c( fullshape_number(os.date("%m")) .. "月", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "mx" or input == env.prefix .. "mo" then
    local preedittext = input .. "\t 【現時：月】"  --〔月〕
    yield_c( os.date("%m"), "", preedittext)
    yield_c( fullshape_number(os.date("%m")), "", preedittext)
    return
  end

  if input == env.prefix .. "mz" then
    local preedittext = input .. "\t 【現時：月】"
    yield_c( rqzdx1(2), "〔中數〕", preedittext)
    yield_c( rqzdx2(2), "〔中數〕", preedittext)
    return
  end


  if input == env.prefix .. "md" then
    local preedittext = input .. "\t 【現時：月日】"  --〔月日〕〔日月〕
    yield_c( os.date("%m%d"), " ~d   ~o", preedittext)
    yield_c( os.date("%m.%d"), " ~p   ~q", preedittext)
    yield_c( os.date("%m/%d"), " ~s   ~y", preedittext)
    yield_c( os.date("%m-%d"), " ~m   ~r", preedittext)
    yield_c( os.date("%m_%d"), " ~u   ~v", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1(23), "〔中數〕 ~z", preedittext)
    yield_c( jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")), "〔日本格式〕 ~j", preedittext)
    yield_c( eng1_m_date(os.date("%m")) .. " " .. eng2_d_date(os.date("%d")), "〔英文美式〕 ~a", preedittext)
    yield_c( eng2_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")), "〔英文英式〕 ~e", preedittext)
    -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
    local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( lm .. ld, "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "mdl" then
    local preedittext = input .. "\t 【現時：月日】"
    -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
    local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( lm .. ld, "〔農曆〕", preedittext)
    local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
    yield_c( M_g .. "月" .. D_g .. "日", "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "mda" then
    local preedittext = input .. "\t 【現時：月日】"  --〔月日〕
    yield_c( eng1_m_date(os.date("%m")) .. " " .. eng2_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(os.date("%m")) .. " " .. eng3_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    yield_c( eng2_m_date(os.date("%m")) .. " " .. eng3_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    yield_c( eng3_m_date(os.date("%m")) .. " " .. eng4_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(os.date("%m")) .. " the " .. eng1_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    return
  end

  if input == env.prefix .. "mde" then
    local preedittext = input .. "\t 【現時：月日】"  --〔日月〕
    yield_c( eng2_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    yield_c( eng3_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    yield_c( eng2_d_date(os.date("%d")) .. " " .. eng2_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    yield_c( "the " .. eng1_d_date(os.date("%d")) .. " of " .. eng1_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    yield_c( "The " .. eng1_d_date(os.date("%d")) .. " of " .. eng1_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    return
  end

  if input == env.prefix .. "mdj" then
    local preedittext = input .. "\t 【現時：月日】"
    yield_c( jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")), "〔日本格式〕", preedittext)
    return
  end

  if input == env.prefix .. "mdc" then
    local preedittext = input .. "\t 【現時：月日】"  --〔月日〕〔*月日*〕
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔日期〕", preedittext)
    yield_c( string.gsub(os.date(" %m 月 %d 日 "), "([ ])0", "%1"), "〔*日期*〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")), "〔日期〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( os.date("%m月%d日"), "〔日期〕", preedittext)
      yield_c( os.date(" %m 月 %d 日 "), "〔*日期*〕", preedittext)
      yield_c( fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "mdd" or input == env.prefix .. "mdo" then
    local preedittext = input .. "\t 【現時：月日】"
    yield_c( os.date("%m%d"), "", preedittext)
    yield_c( fullshape_number(os.date("%m")) .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d%m"), "〔日月〕", preedittext)
    return
  end

  if input == env.prefix .. "mds" or input == env.prefix .. "mdy" then
    local preedittext = input .. "\t 【現時：月日】"  --〔月日〕
    yield_c( os.date("%m/%d"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%m")) .. "/" .. fullshape_number(os.date("%d")), "〔月日〕", preedittext)
    yield_c( fullshape_number(os.date("%m")) .. "／" .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d/%m"), "〔日月〕", preedittext)
    return
  end

  if input == env.prefix .. "mdm" or input == env.prefix .. "mdr" then
    local preedittext = input .. "\t 【現時：月日】"  --〔月日〕
    yield_c( os.date("%m-%d"), "", preedittext)
    yield_c( fullshape_number(os.date("%m")) .. "－" .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d-%m"), "〔日月〕", preedittext)
    return
  end

  if input == env.prefix .. "mdu" or input == env.prefix .. "mdv" then
    local preedittext = input .. "\t 【現時：月日】"  --〔月日〕
    yield_c( os.date("%m_%d"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%m")) .. "_" .. fullshape_number(os.date("%d")), "〔月日〕", preedittext)
    yield_c( fullshape_number(os.date("%m")) .. "＿" .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d_%m"), "〔日月〕", preedittext)
    return
  end

  if input == env.prefix .. "mdp" or input == env.prefix .. "mdq" then
    local preedittext = input .. "\t 【現時：月日】"  --〔月日〕
    yield_c( os.date("%m.%d"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%m")) .. "." .. fullshape_number(os.date("%d")), "〔月日〕", preedittext)
    yield_c( fullshape_number(os.date("%m")) .. "．" .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d.%m"), "〔日月〕", preedittext)
    return
  end

  if input == env.prefix .. "mdz" then
    local preedittext = input .. "\t 【現時：月日】"
    yield_c( rqzdx1(23), "〔中數〕", preedittext)
    yield_c( rqzdx2(23), "〔中數〕", preedittext)
    return
  end

  if input == env.prefix .. "mdw" then
    local preedittext = input .. "\t 【現時：月日週】"  --〔月日週〕
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕 ~c", preedittext)
    -- yield_c( jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔月日週〕", preedittext)
    yield_c( rqzdx1(23) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔中數〕 ~z", preedittext)
    -- yield_c( rqzdx2(23) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔月日週〕", preedittext)
    yield_c( jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. weekstyle()[3], "〔日本格式〕 ~j", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng1_m_date(os.date("%m")) .. " " .. eng2_d_date(os.date("%d")), "〔英文美式〕 ~a", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng2_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")), "〔英文英式〕 ~e", preedittext)
    -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
    local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( lm .. ld .. " " .. weekstyle()[5] .. " ", "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "mdwl" then
    local preedittext = input .. "\t 【現時：月日週】"
    -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
    local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( lm .. ld .. " " .. weekstyle()[5] .. " ", "〔農曆〕", preedittext)
    yield_c( lm .. ld .. "（" .. weekstyle()[5] .. "）", "〔農曆〕", preedittext)
    yield_c( lm .. ld .. "(" .. weekstyle()[5] .. ")", "〔農曆〕", preedittext)
    local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
    yield_c( M_g .. "月" .. D_g .. "日" .. " " .. weekstyle()[5] .. " ", "〔農曆干支〕", preedittext)
    yield_c( M_g .. "月" .. D_g .. "日" .. "（" .. weekstyle()[5] .. "）", "〔農曆干支〕", preedittext)
    yield_c( M_g .. "月" .. D_g .. "日" .. "(" .. weekstyle()[5] .. ")", "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "mdwa" then
    local preedittext = input .. "\t 【現時：月日週】"  --〔週月日〕
    yield_c( weekstyle()[6] .. ", " .. eng1_m_date(os.date("%m")) .. " " .. eng2_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng1_m_date(os.date("%m")) .. " " .. eng3_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    yield_c( weekstyle()[7] .. ", " .. eng2_m_date(os.date("%m")) .. " " .. eng3_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    yield_c( weekstyle()[8] .. " " .. eng3_m_date(os.date("%m")) .. " " .. eng4_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng1_m_date(os.date("%m")) .. " the " .. eng1_d_date(os.date("%d")), "〔英文美式〕", preedittext)
    return
  end

  if input == env.prefix .. "mdwe" then
    local preedittext = input .. "\t 【現時：月日週】"  --〔週日月〕
    yield_c( weekstyle()[6] .. ", " .. eng2_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng3_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    yield_c( weekstyle()[7] .. ", " .. eng2_d_date(os.date("%d")) .. " " .. eng2_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    yield_c( weekstyle()[6] .. ", " .. "the " .. eng1_d_date(os.date("%d")) .. " of " .. eng1_m_date(os.date("%m")), "〔英文英式〕", preedittext)
    -- yield_c( weekstyle()[6] .. ", " .. "The " .. eng1_d_date(os.date("%d")) .. " of " .. eng1_m_date(os.date("%m")) .. ", " .. os.date("%Y"), "〔週日月〕", preedittext)
    return
  end

  if input == env.prefix .. "mdwc" then
    local preedittext = input .. "\t 【現時：月日週】"  --〔月日週〕〔*月日週*〕
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. "星期" .. weekstyle()[1], "〔日期〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔日期〕", preedittext)
    yield_c( string.gsub(os.date(" %m 月 %d 日"), "([ ])0", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔*日期*〕", preedittext)
    yield_c( string.gsub(os.date(" %m 月 %d 日"), "([ ])0", "%1") .. "星期" .. weekstyle()[1], "〔*日期*〕", preedittext)
    yield_c( string.gsub(os.date(" %m 月 %d 日"), "([ ])0", "%1") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔*日期*〕", preedittext)
    yield_c( string.gsub(os.date(" %m 月 %d 日"), "([ ])0", "%1") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔*日期*〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. "星期" .. weekstyle()[1], "〔日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔日期〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( os.date("%m月%d日") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕", preedittext)
      yield_c( os.date("%m月%d日") .. "星期" .. weekstyle()[1], "〔日期〕", preedittext)
      yield_c( os.date("%m月%d日") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
      yield_c( os.date("%m月%d日") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔日期〕", preedittext)
      yield_c( os.date(" %m 月 %d 日") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔*日期*〕", preedittext)
      yield_c( os.date(" %m 月 %d 日") .. "星期" .. weekstyle()[1], "〔*日期*〕", preedittext)
      yield_c( os.date(" %m 月 %d 日") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔*日期*〕", preedittext)
      yield_c( os.date(" %m 月 %d 日") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔*日期*〕", preedittext)
      yield_c( fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕", preedittext)
      yield_c( fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. "星期" .. weekstyle()[1], "〔日期〕", preedittext)
      yield_c( fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
      yield_c( fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "mdwj" then
    local preedittext = input .. "\t 【現時：月日週】"
    yield_c( jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. weekstyle()[3], "〔日本格式〕", preedittext)
    yield_c( jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. weekstyle()[4], "〔日本格式〕", preedittext)
    --- 
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. " " .. weekstyle()[5] .. "曜日 ", "〔日本格式〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. weekstyle()[5] .. "曜日", "〔日本格式〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. "（" .. weekstyle()[5] .. "曜日）", "〔日本格式〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. "(" .. weekstyle()[5] .. "曜日)", "〔日本格式〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. "（" .. weekstyle()[5] .. "）", "〔日本格式〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. "(" .. weekstyle()[5] .. ")", "〔日本格式〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. weekstyle()[3], "〔日本格式〕", preedittext)
    yield_c( string.gsub(os.date("%m月%d日"), "0([%d])", "%1") .. weekstyle()[4], "〔日本格式〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. " " .. weekstyle()[5] .. "曜日 ", "〔日本格式〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. weekstyle()[5] .. "曜日", "〔日本格式〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. "（" .. weekstyle()[5] .. "曜日）", "〔日本格式〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. "(" .. weekstyle()[5] .. "曜日)", "〔日本格式〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. "（" .. weekstyle()[5] .. "）", "〔日本格式〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. "(" .. weekstyle()[5] .. ")", "〔日本格式〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. weekstyle()[3], "〔日本格式〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. weekstyle()[4], "〔日本格式〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( os.date("%m月%d日") .. " " .. weekstyle()[5] .. "曜日 ", "〔日本格式〕", preedittext)
      yield_c( os.date("%m月%d日") .. weekstyle()[5] .. "曜日", "〔日本格式〕", preedittext)
      yield_c( os.date("%m月%d日") .. "（" .. weekstyle()[5] .. "曜日）", "〔日本格式〕", preedittext)
      yield_c( os.date("%m月%d日") .. "(" .. weekstyle()[5] .. "曜日)", "〔日本格式〕", preedittext)
      yield_c( os.date("%m月%d日") .. "（" .. weekstyle()[5] .. "）", "〔日本格式〕", preedittext)
      yield_c( os.date("%m月%d日") .. "(" .. weekstyle()[5] .. ")", "〔日本格式〕", preedittext)
      yield_c( os.date("%m月%d日") .. weekstyle()[3], "〔日本格式〕", preedittext)
      yield_c( os.date("%m月%d日") .. weekstyle()[4], "〔日本格式〕", preedittext)
      yield_c( fullshape_number(os.date("%m月%d日") .. " " .. weekstyle()[5] .. "曜日 "), "〔日本格式〕", preedittext)
      yield_c( fullshape_number(os.date("%m月%d日") .. weekstyle()[5] .. "曜日"), "〔日本格式〕", preedittext)
      yield_c( fullshape_number(os.date("%m月%d日") .. "（" .. weekstyle()[5] .. "曜日）"), "〔日本格式〕", preedittext)
      yield_c( fullshape_number(os.date("%m月%d日") .. "(" .. weekstyle()[5] .. "曜日)"), "〔日本格式〕", preedittext)
      yield_c( fullshape_number(os.date("%m月%d日") .. "（" .. weekstyle()[5] .. "）"), "〔日本格式〕", preedittext)
      yield_c( fullshape_number(os.date("%m月%d日") .. "(" .. weekstyle()[5] .. ")"), "〔日本格式〕", preedittext)
      yield_c( fullshape_number(os.date("%m月%d日") .. weekstyle()[3]), "〔日本格式〕", preedittext)
      yield_c( fullshape_number(os.date("%m月%d日") .. weekstyle()[4]), "〔日本格式〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "mdwz" then
    local preedittext = input .. "\t 【現時：月日週】"
    yield_c( rqzdx1(23) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔中數〕", preedittext)
    yield_c( rqzdx1(23) .. "星期" .. weekstyle()[1], "〔中數〕", preedittext)
    yield_c( rqzdx1(23) .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔中數〕", preedittext)
    yield_c( rqzdx1(23) .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔中數〕", preedittext)
    --- 中文大寫數字
    yield_c( rqzdx2(23) .. " " .. "星期" .. weekstyle()[2] .. " ", "〔中數〕", preedittext)
    return
  end

-----------------------------

  ::fh_label::

  -- local date_key = string.match(input, "^" .. env.prefix .. "[fh]")
  -- -- if date_key then
  -- if not date_key then
  --   return
  -- end
  -- -- if not date_key then
  -- --   goto continue
  -- -- end

  if input == env.prefix .. "f" or input == env.prefix .. "h" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔年月日〕
    yield_c( os.date("%Y%m%d"), " ~d   ~o", preedittext)
    yield_c( os.date("%Y.%m.%d"), " ~p   ~q", preedittext)
    yield_c( os.date("%Y/%m/%d"), " ~s   ~y", preedittext)
    yield_c( os.date("%Y-%m-%d"), " ~m   ~r", preedittext)
    yield_c( os.date("%Y_%m_%d"), " ~u   ~v", preedittext)
    yield_c( string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1(), "〔中數〕 ~z", preedittext)
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日", "([^%d])0", "%1"), "〔民國〕 ~h", preedittext)
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23), "〔民國中數〕 ~g", preedittext)
    -- yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")), "〔年月日〕 ~j", preedittext)
    local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    yield_c( string.gsub(jpymd, "([^%d])0", "%1"), "〔日本元号〕 ~j", preedittext)
    yield_c( eng1_m_date(os.date("%m")) .. " " .. eng2_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕 ~a", preedittext)
    yield_c( eng2_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文英式〕 ~e", preedittext)
    -- local chinese_date = to_chinese_cal_local(os.time())
    local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ll_1, "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "fj" or input == env.prefix .. "hj" then
    local preedittext = input .. "\t 【現時：年月日】"
    local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    yield_c( string.gsub(jpymd, "([^%d])0", "%1"), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1")), "〔日本元号〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( jpymd, "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd), "〔日本元号〕", preedittext)
    end
    return
  end
  -- if input == env.prefix .. "fj" or input == env.prefix .. "hj" then
  --   yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")), "〔年月日〕")
  --   return
  -- end

  if input == env.prefix .. "fh" or input == env.prefix .. "hh" then
    local preedittext = input .. "\t 【現時：年月日】"
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日", "([^%d])0", "%1"), "〔民國〕", preedittext)
    yield_c( string.gsub("民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日", "([^%d])0", "%1"), "〔民國*〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")), "〔民國〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( "民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日", "〔民國〕", preedittext)
      yield_c( "民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日", "〔民國*〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日", "〔民國〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "fg" or input == env.prefix .. "hg" then
    local preedittext = input .. "\t 【現時：年月日】"
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23), "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23), "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[2], min_guo(os.date("%Y"))) .. "年" .. rqzdx2(23), "〔民國中數〕", preedittext)
    return
  end

  if input == env.prefix .. "fl" or input == env.prefix .. "hl" then
    local preedittext = input .. "\t 【現時：年月日】"
    -- local chinese_date = to_chinese_cal_local(os.time())
    local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ll_1, "〔農曆〕", preedittext)
    yield_c( ll_2, "〔農曆〕", preedittext)
    local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
    yield_c( Y_g .. "年" .. M_g .. "月" .. D_g .. "日", "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "fa" or input == env.prefix .. "ha" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔月日年〕
    yield_c( eng1_m_date(os.date("%m")) .. " " .. eng2_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(os.date("%m")) .. " " .. eng3_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕", preedittext)
    yield_c( eng2_m_date(os.date("%m")) .. " " .. eng3_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕", preedittext)
    yield_c( eng3_m_date(os.date("%m")) .. " " .. eng4_d_date(os.date("%d")) .. " " .. os.date("%Y"), "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(os.date("%m")) .. " the " .. eng1_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕", preedittext)
    return
  end

  if input == env.prefix .. "fe" or input == env.prefix .. "he" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔日月年〕
    yield_c( eng2_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文英式〕", preedittext)
    yield_c( eng3_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文英式〕", preedittext)
    yield_c( eng2_d_date(os.date("%d")) .. " " .. eng2_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文英式〕", preedittext)
    yield_c( "the " .. eng1_d_date(os.date("%d")) .. " of " .. eng1_m_date(os.date("%m")) .. ", " .. os.date("%Y"), "〔英文英式〕", preedittext)
    yield_c( "The " .. eng1_d_date(os.date("%d")) .. " of " .. eng1_m_date(os.date("%m")) .. ", " .. os.date("%Y"), "〔英文英式〕", preedittext)
    return
  end

  if input == env.prefix .. "fc" or input == env.prefix .. "hc" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔年月日〕〔*年月日*〕
    yield_c( string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔日期〕", preedittext)
    yield_c( string.gsub(os.date(" %Y 年 %m 月 %d 日 "), "([^%d])0", "%1"), "〔*日期*〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")), "〔日期〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( os.date("%Y年%m月%d日"), "〔日期〕", preedittext)
      yield_c( os.date(" %Y 年 %m 月 %d 日 "), "〔*日期*〕", preedittext)
      yield_c( fullshape_number(os.date("%Y")) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "fd" or input == env.prefix .. "fo" or input == env.prefix .. "hd" or input == env.prefix .. "ho" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔年月日〕
    yield_c( os.date("%Y%m%d"), "", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. fullshape_number(os.date("%m")) .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d%m%Y"), "〔日月年〕", preedittext)
    yield_c( os.date("%m%d%Y"), "〔月日年〕", preedittext)
    return
  end

  if input == env.prefix .. "fm" or input == env.prefix .. "fr" or input == env.prefix .. "hm" or input == env.prefix .. "hr" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔年月日〕
    yield_c( os.date("%Y-%m-%d"), "", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "－" .. fullshape_number(os.date("%m")) .. "－" .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d-%m-%Y"), "〔日月年〕", preedittext)
    yield_c( os.date("%m-%d-%Y"), "〔月日年〕", preedittext)
    return
  end

  if input == env.prefix .. "fs" or input == env.prefix .. "fy" or input == env.prefix .. "hs" or input == env.prefix .. "hy" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔年月日〕
    yield_c( os.date("%Y/%m/%d"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%Y")) .. "/" .. fullshape_number(os.date("%m")) .. "/" .. fullshape_number(os.date("%d")), "〔年月日〕", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "／" .. fullshape_number(os.date("%m")) .. "／" .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d/%m/%Y"), "〔日月年〕", preedittext)
    yield_c( os.date("%m/%d/%Y"), "〔月日年〕", preedittext)
    return
  end

  if input == env.prefix .. "fu" or input == env.prefix .. "fv" or input == env.prefix .. "hu" or input == env.prefix .. "hv" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔年月日〕
    yield_c( os.date("%Y_%m_%d"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%Y")) .. "_" .. fullshape_number(os.date("%m")) .. "_" .. fullshape_number(os.date("%d")), "〔年月日〕", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "＿" .. fullshape_number(os.date("%m")) .. "＿" .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d_%m_%Y"), "〔日月年〕", preedittext)
    yield_c( os.date("%m_%d_%Y"), "〔月日年〕", preedittext)
    return
  end

  if input == env.prefix .. "fp" or input == env.prefix .. "fq" or input == env.prefix .. "hp" or input == env.prefix .. "hq" then
    local preedittext = input .. "\t 【現時：年月日】"  --〔年月日〕
    yield_c( os.date("%Y.%m.%d"), "", preedittext)
    -- yield_c( fullshape_number(os.date("%Y")) .. "." .. fullshape_number(os.date("%m")) .. "." .. fullshape_number(os.date("%d")), "〔年月日〕", preedittext)
    yield_c( fullshape_number(os.date("%Y")) .. "．" .. fullshape_number(os.date("%m")) .. "．" .. fullshape_number(os.date("%d")), "", preedittext)
    yield_c( os.date("%d.%m.%Y"), "〔日月年〕", preedittext)
    yield_c( os.date("%m.%d.%Y"), "〔月日年〕", preedittext)
    return
  end

  if input == env.prefix .. "fz" or input == env.prefix .. "hz" then
    local preedittext = input .. "\t 【現時：年月日】"
    yield_c( rqzdx1(), "〔中數〕", preedittext)
    yield_c( rqzdx2(), "〔中數〕", preedittext)
    return
  end

  if input == env.prefix .. "fn" or input == env.prefix .. "hn" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local os_time = os.time()
    local timezone_out_1 = timezone_out()[1]
    local timezone_out_3 = timezone_out()[3]
    local rqzdx1_nil = rqzdx1()
    local rqzdx1_23 = rqzdx1(23)
    local jpymd, jp_y = jp_ymd(t_Y, t_m, t_d)
    local ll_1, ll_2 = Date2LunarDate(t_Y .. t_m .. t_d)
    local preedittext = input .. "\t 【現時：年月日時分】"  --〔年月日 時:分〕
    yield_c( t_Y .. t_m .. t_d .. " " .. t_H .. ":" .. t_M, " ~d   ~o", preedittext)
    yield_c( t_Y .. "." .. t_m .. "." .. t_d .. " " .. t_H .. ":" .. t_M, " ~p   ~q", preedittext)
    yield_c( t_Y .. "/" .. t_m .. "/" .. t_d .. " " .. t_H .. ":" .. t_M, " ~s   ~y", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. " " .. t_H .. ":" .. t_M, " ~m   ~r", preedittext)
    yield_c( t_Y .. "_" .. t_m .. "_" .. t_d .. " " .. t_H .. ":" .. t_M, " ~u   ~v", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "-" .. t_H .. "-" .. t_M .. " " .. timezone_out_1, "〔本地時  時區〕 ~i", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "T" .. t_H .. ":" .. t_M .. timezone_out_3, "〔本地時  RFC 3339/ISO 8601〕 ~f", preedittext)
    yield_c( string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日" .. " " .. t_H .. "點" .. t_M .. "分", "([^%d])0", "%1"), "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1_nil .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "〔中數〕 ~z", preedittext)
    yield_c( string.gsub("民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分", "([^%d])0", "%1"), "〔民國〕 ~h", preedittext)
    yield_c( "民國" .. purech_number(min_guo(t_Y)) .. "年" .. rqzdx1_23 .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "〔民國中數〕 ~g", preedittext)
    -- yield_c( t_Y .. "年 " .. jp_m_date(t_m) .. jp_d_date(t_d) .. " " .. t_H .. ":" .. t_M, "〔年月日 時:分〕 ~j", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. " " .. t_H .. ":" .. t_M, "〔日本元号〕 ~j", preedittext)
    -- local chinese_date = to_chinese_cal_local(os.time())
    -- local chinese_time = time_description_chinese(os.time())
    yield_c( ll_1 .. " " .. time_description_chinese(os_time), "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "fni" or input == env.prefix .. "hni" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local C_U_T = os.date("!%Y-%m-%d-%H-%M")
    local timezone_out_1 = timezone_out()[1]
    local timezone_out_5 = timezone_out()[5]
    local timezone_out_2 = timezone_out()[2]
    local preedittext = input .. "\t 【現時：年月日時分】"
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "-" .. t_H .. "-" .. t_M .. " " .. timezone_out_1, "〔本地時  時區〕", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "-" .. t_H .. "-" .. t_M .. " " .. timezone_out_5, "〔本地時  時區〕", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "-" .. t_H .. "-" .. t_M .. " " .. timezone_out_2, "〔本地時  時區〕", preedittext)
    yield_c( C_U_T .. " UTC", "〔世界時  時區〕", preedittext)
    yield_c( C_U_T .. " GMT", "〔世界時  時區〕", preedittext)
    return
  end

  if input == env.prefix .. "fnf" or input == env.prefix .. "hnf" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local timezone_out_3 = timezone_out()[3]
    local timezone_out_4 = timezone_out()[4]
    local C_U_T_1, C_U_T_2 = os.date("!%Y-%m-%dT%H:%M"), os.date("!%Y%m%dT%H%M")
    local preedittext = input .. "\t 【現時：年月日時分】"
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "T" .. t_H .. ":" .. t_M .. timezone_out_3, "〔本地時  RFC 3339/ISO 8601〕", preedittext)
    yield_c( t_Y .. t_m .. t_d .. "T" .. t_H .. t_M .. timezone_out_4, "〔本地時  RFC 3339/ISO 8601〕", preedittext)
    yield_c( C_U_T_1 .. "Z", "〔世界時  RFC 3339/ISO 8601〕", preedittext)
    yield_c( C_U_T_2 .. "Z", "〔世界時  RFC 3339/ISO 8601〕", preedittext)
    return
  end

  if input == env.prefix .. "fnj" or input == env.prefix .. "hnj" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local jpymd, jp_y = jp_ymd(t_Y, t_m, t_d)
    local check_number_format = string.match(t_m, "^0") or string.match(t_d, "^0")
    local preedittext = input .. "\t 【現時：年月日時分】"
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. " " .. t_H .. ":" .. t_M, "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. t_H .. ":" .. t_M, "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. "　" .. t_H .. ":" .. t_M), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. t_H .. ":" .. t_M), "〔日本元号〕", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( jpymd .. " " .. t_H .. ":" .. t_M, "〔日本元号〕", preedittext)
      yield_c( jpymd .. t_H .. ":" .. t_M, "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. "　" .. t_H .. ":" .. t_M), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. t_H .. ":" .. t_M), "〔日本元号〕", preedittext)
    end
    return
  end
  -- if input == env.prefix .. "fnj" or input == env.prefix .. "hnj" then
  --   yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. os.date("%H") .. ":" .. os.date("%M"), "〔年月日 時:分〕")
  --   return
  -- end

  if input == env.prefix .. "fnh" or input == env.prefix .. "hnh" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local check_number_format = string.match(t_m, "^0") or string.match(t_d, "^0") or string.match(t_H, "^0") or string.match(t_M, "^0")
    local preedittext = input .. "\t 【現時：年月日時分】"
    yield_c( string.gsub("民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分", "([^%d])0", "%1"), "〔民國〕", preedittext)
    yield_c( string.gsub("民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分", "([^%d])0", "%1"), "〔民國〕", preedittext)
    yield_c( string.gsub("民國 " .. min_guo(t_Y) .. " 年 " .. t_m .. " 月 " .. t_d .. " 日 " .. t_H .. " 點 " .. t_M .. " 分", "([^%d])0", "%1"), "〔民國*〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(t_Y)) .. "年" .. fullshape_number(string.gsub(t_m .. "月" .. t_d .. "日　" .. t_H .. "點" .. t_M .. "分", "0([%d])", "%1")), "〔民國〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(t_Y)) .. "年" .. fullshape_number(string.gsub(t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分", "0([%d])", "%1")), "〔民國〕", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( "民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分", "〔民國〕", preedittext)
      yield_c( "民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分", "〔民國〕", preedittext)
      yield_c( "民國 " .. min_guo(t_Y) .. " 年 " .. t_m .. " 月 " .. t_d .. " 日 " .. t_H .. " 點 " .. t_M .. " 分", "〔民國*〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(t_Y)) .. "年" .. fullshape_number(t_m) .. "月" .. fullshape_number(t_d) .. "日　" .. fullshape_number(t_H .. "點" .. t_M .. "分"), "〔民國〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(t_Y)) .. "年" .. fullshape_number(t_m) .. "月" .. fullshape_number(t_d) .. "日" .. fullshape_number(t_H .. "點" .. t_M .. "分"), "〔民國〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "fng" or input == env.prefix .. "hng" then
    local t_Y = os.date("%Y")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local rqzdx1_23 = rqzdx1(23)
    local rqzdx2_23 = rqzdx2(23)
    local preedittext = input .. "\t 【現時：年月日時分】"
    yield_c( "民國" .. purech_number(min_guo(t_Y)) .. "年" .. rqzdx1_23 .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "〔民國中數〕", preedittext)
    yield_c( "民國" .. purech_number(min_guo(t_Y)) .. "年" .. rqzdx1_23 .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(t_Y)) .. "年" .. rqzdx1_23 .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(t_Y)) .. "年" .. rqzdx1_23 .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[2], min_guo(t_Y)) .. "年" .. rqzdx2_23 .. " " .. chb_h_date(t_H) .. "點" .. chb_minsec_date(t_M) .. "分", "〔民國中數〕", preedittext)
    return
  end

  if input == env.prefix .. "fnl" or input == env.prefix .. "hnl" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H = os.date("%H")
    local os_time = os.time()
    local ll_1, ll_2 = Date2LunarDate(t_Y .. t_m .. t_d)
    local All_g = lunarJzl(t_Y .. t_m .. t_d .. t_H)
    local preedittext = input .. "\t 【現時：年月日時分】"
    -- local chinese_date = to_chinese_cal_local(os.time())
    -- local chinese_time = time_description_chinese(os.time())
    yield_c( ll_1 .. " " .. time_description_chinese(os_time), "〔農曆〕", preedittext)
    yield_c( ll_2 .. " " .. time_description_chinese(os_time), "〔農曆〕", preedittext)
    yield_c( All_g, "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "fnc" or input == env.prefix .. "hnc" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local check_number_format = string.match(t_m, "^0") or string.match(t_d, "^0") or string.match(t_H, "^0") or string.match(t_M, "^0")
    local preedittext = input .. "\t 【現時：年月日時分】"  --〔年月日 時:分〕〔*年月日 時:分*〕
    yield_c( string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分", "([^%d])0", "%1"), "〔日期〕", preedittext)
    yield_c( string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分", "([^%d])0", "%1"), "〔日期〕", preedittext)
    yield_c( string.gsub(" " .. t_Y .. " 年 " .. t_m .. " 月 " .. t_d .. " 日 " .. t_H .. " 點 " .. t_M .. " 分 ", "([^%d])0", "%1"), "〔*日期*〕", preedittext)
    yield_c( fullshape_number(string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日　" .. t_H .. "點" .. t_M .. "分", "([^%d])0", "%1")), "〔日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分", "([^%d])0", "%1")), "〔日期〕", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( t_Y .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分", "〔日期〕", preedittext)
      yield_c( t_Y .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分", "〔日期〕", preedittext)
      yield_c( " " .. t_Y .. " 年 " .. t_m .. " 月 " .. t_d .. " 日 " .. t_H .. " 點 " .. t_M .. " 分 ", "〔*日期*〕", preedittext)
      yield_c( fullshape_number(t_Y) .. "年" .. fullshape_number(t_m) .. "月" .. fullshape_number(t_d) .. "日　" .. fullshape_number(t_H) .. "點" .. fullshape_number(t_M) .. "分", "〔日期〕", preedittext)
      yield_c( fullshape_number(t_Y) .. "年" .. fullshape_number(t_m) .. "月" .. fullshape_number(t_d) .. "日" .. fullshape_number(t_H) .. "點" .. fullshape_number(t_M) .. "分", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "fnd" or input == env.prefix .. "fno" or input == env.prefix .. "hnd" or input == env.prefix .. "hno" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local preedittext = input .. "\t 【現時：年月日時分】"  --〔年月日 時:分〕
    yield_c( t_Y .. t_m .. t_d .. " " .. t_H .. ":" .. t_M, "", preedittext)
    yield_c( fullshape_number(t_Y) .. fullshape_number(t_m) .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M), "", preedittext)
    yield_c( t_d .. t_m .. t_Y .. " " .. t_H .. ":" .. t_M, "〔日月年 時:分〕", preedittext)
    yield_c( t_m .. t_d .. t_Y .. " " .. t_H .. ":" .. t_M, "〔月日年 時:分〕", preedittext)
    return
  end

  if input == env.prefix .. "fns" or input == env.prefix .. "fny" or input == env.prefix .. "hns" or input == env.prefix .. "hny" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local preedittext = input .. "\t 【現時：年月日時分】"  --〔年月日 時:分〕
    yield_c( t_Y .. "/" .. t_m .. "/" .. t_d .. " " .. t_H .. ":" .. t_M, "", preedittext)
    -- yield_c( fullshape_number(t_Y) .. "/" .. fullshape_number(t_m) .. "/" .. fullshape_number(t_d) .. " " .. fullshape_number(t_H) .. ":" .. fullshape_number(t_M), "〔年月日 時:分〕", preedittext)
    yield_c( fullshape_number(t_Y) .. "／" .. fullshape_number(t_m) .. "／" .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M), "", preedittext)
    yield_c( t_d .. "/" .. t_m .. "/" .. t_Y .. " " .. t_H .. ":" .. t_M, "〔日月年 時:分〕", preedittext)
    yield_c( t_m .. "/" .. t_d .. "/" .. t_Y .. " " .. t_H .. ":" .. t_M, "〔月日年 時:分〕", preedittext)
    return
  end

  if input == env.prefix .. "fnm" or input == env.prefix .. "fnr" or input == env.prefix .. "hnm" or input == env.prefix .. "hnr" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local preedittext = input .. "\t 【現時：年月日時分】"  --〔年月日 時:分〕
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. " " .. t_H .. ":" .. t_M, "", preedittext)
    yield_c( fullshape_number(t_Y) .. "－" .. fullshape_number(t_m) .. "－" .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M), "", preedittext)
    yield_c( t_d .. "-" .. t_m .. "-" .. t_Y .. " " .. t_H .. ":" .. t_M, "〔日月年 時:分〕", preedittext)
    yield_c( t_m .. "-" .. t_d .. "-" .. t_Y .. " " .. t_H .. ":" .. t_M, "〔月日年 時:分〕", preedittext)
    return
  end

  if input == env.prefix .. "fnu" or input == env.prefix .. "fnv" or input == env.prefix .. "hnu" or input == env.prefix .. "hnv" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local preedittext = input .. "\t 【現時：年月日時分】"  --〔年月日 時:分〕
    yield_c( t_Y .. "_" .. t_m .. "_" .. t_d .. " " .. t_H .. ":" .. t_M, "", preedittext)
    -- yield_c( fullshape_number(t_Y) .. "_" .. fullshape_number(t_m) .. "_" .. fullshape_number(t_d) .. " " .. fullshape_number(t_H) .. ":" .. fullshape_number(t_M), "〔年月日 時:分〕", preedittext)
    yield_c( fullshape_number(t_Y) .. "＿" .. fullshape_number(t_m) .. "＿" .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M), "", preedittext)
    yield_c( t_d .. "_" .. t_m .. "_" .. t_Y .. " " .. t_H .. ":" .. t_M, "〔日月年 時:分〕", preedittext)
    yield_c( t_m .. "_" .. t_d .. "_" .. t_Y .. " " .. t_H .. ":" .. t_M, "〔月日年 時:分〕", preedittext)
    return
  end

  if input == env.prefix .. "fnp" or input == env.prefix .. "fnq" or input == env.prefix .. "hnp" or input == env.prefix .. "hnq" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M = os.date("%H"), os.date("%M")
    local preedittext = input .. "\t 【現時：年月日時分】"  --〔年月日 時:分〕
    yield_c( t_Y .. "." .. t_m .. "." .. t_d .. " " .. t_H .. ":" .. t_M, "", preedittext)
    -- yield_c( fullshape_number(t_Y) .. "." .. fullshape_number(t_m) .. "." .. fullshape_number(t_d) .. " " .. fullshape_number(t_H) .. ":" .. fullshape_number(t_M), "〔年月日 時:分〕", preedittext)
    yield_c( fullshape_number(t_Y) .. "．" .. fullshape_number(t_m) .. "．" .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M), "", preedittext)
    yield_c( t_d .. "." .. t_m .. "." .. t_Y .. " " .. t_H .. ":" .. t_M, "〔日月年 時:分〕", preedittext)
    yield_c( t_m .. "." .. t_d .. "." .. t_Y .. " " .. t_H .. ":" .. t_M, "〔月日年 時:分〕", preedittext)
    return
  end

  if input == env.prefix .. "fnz" or input == env.prefix .. "hnz" then
    local t_H, t_M = os.date("%H"), os.date("%M")
    local rqzdx1_nil = rqzdx1()
    local rqzdx2_nil = rqzdx2()
    local preedittext = input .. "\t 【現時：年月日時分】"
    yield_c( rqzdx1_nil .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "〔中數〕", preedittext)
    yield_c( rqzdx1_nil .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分", "〔中數〕", preedittext)
    yield_c( rqzdx2_nil .. " " .. chb_h_date(t_H) .. "點" .. chb_minsec_date(t_M) .. "分", "〔中數〕", preedittext)
    return
  end

  if input == env.prefix .. "ft" or input == env.prefix .. "ht" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local rqzdx1_nil = rqzdx1()
    local rqzdx1_23 = rqzdx1(23)
    local jpymd, jp_y = jp_ymd(t_Y, t_m, t_d)
    local preedittext = input .. "\t 【現時：年月日時分秒】"  --〔年月日 時:分:秒〕
    yield_c( t_Y .. t_m .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, " ~d   ~o", preedittext)
    yield_c( t_Y .. "." .. t_m .. "." .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, " ~p   ~q", preedittext)
    yield_c( t_Y .. "/" .. t_m .. "/" .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, " ~s   ~y", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, " ~m   ~r", preedittext)
    yield_c( t_Y .. "_" .. t_m .. "_" .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, " ~u   ~v", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "-" .. t_H .. "-" .. t_M .. "-" .. t_S .. " " .. timezone_out()[1], "〔本地時  時區〕 ~i", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "T" .. t_H .. ":" .. t_M .. ":" .. t_S .. timezone_out()[3], "〔本地時  RFC 3339/ISO 8601〕 ~f", preedittext)
    yield_c( string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日" .. " " .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "([^%d])0", "%1"), "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1_nil .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "〔中數〕 ~z", preedittext)
    yield_c( string.gsub("民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "([^%d])0", "%1"), "〔民國〕 ~h", preedittext)
    yield_c( "民國" .. purech_number(min_guo(t_Y)) .. "年" .. rqzdx1_23 .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "〔民國中數〕 ~g", preedittext)
    -- yield_c( t_Y .. "年 " .. jp_m_date(t_m) .. jp_d_date(t_d) .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔年月日 時:分:秒〕 ~j", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日本元号〕 ~j", preedittext)
    return
  end

  if input == env.prefix .. "fti" or input == env.prefix .. "hti" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local C_U_T = os.date("!%Y-%m-%d-%H-%M-%S")
    local timezone_out_1 = timezone_out()[1]
    local timezone_out_5 = timezone_out()[5]
    local timezone_out_2 = timezone_out()[2]
    local preedittext = input .. "\t 【現時：年月日時分秒】"
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "-" .. t_H .. "-" .. t_M .. "-" .. t_S .. " " .. timezone_out_1, "〔本地時  時區〕", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "-" .. t_H .. "-" .. t_M .. "-" .. t_S .. " " .. timezone_out_5, "〔本地時  時區〕", preedittext)
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "-" .. t_H .. "-" .. t_M .. "-" .. t_S .. " " .. timezone_out_2, "〔本地時  時區〕", preedittext)
    yield_c( C_U_T .. " UTC", "〔世界時  時區〕", preedittext)
    yield_c( C_U_T .. " GMT", "〔世界時  時區〕", preedittext)
    return
  end

  if input == env.prefix .. "ftf" or input == env.prefix .. "htf" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local timezone_out_3 = timezone_out()[3]
    local timezone_out_4 = timezone_out()[4]
    local C_U_T_1, C_U_T_2 = os.date("!%Y-%m-%dT%H:%M:%S"), os.date("!%Y%m%dT%H%M%S")
    local preedittext = input .. "\t 【現時：年月日時分秒】"
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. "T" .. t_H .. ":" .. t_M .. ":" .. t_S .. timezone_out_3, "〔本地時  RFC 3339/ISO 8601〕", preedittext)
    yield_c( t_Y .. t_m .. t_d .. "T" .. t_H .. t_M .. t_S .. timezone_out_4, "〔本地時  RFC 3339/ISO 8601〕", preedittext)
    yield_c( C_U_T_1 .. "Z", "〔世界時  RFC 3339/ISO 8601〕", preedittext)
    yield_c( C_U_T_2 .. "Z", "〔世界時  RFC 3339/ISO 8601〕", preedittext)
    return
  end

  if input == env.prefix .. "ftj" or input == env.prefix .. "htj" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local jpymd, jp_y = jp_ymd(t_Y, t_m, t_d)
    local check_number_format = string.match(t_m, "^0") or string.match(t_d, "^0")
    local preedittext = input .. "\t 【現時：年月日時分秒】"
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. "　" .. t_H .. ":" .. t_M .. ":" .. t_S), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. t_H .. ":" .. t_M .. ":" .. t_S), "〔日本元号〕", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( jpymd .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日本元号〕", preedittext)
      yield_c( jpymd .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. "　" .. t_H .. ":" .. t_M .. ":" .. t_S), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. t_H .. ":" .. t_M .. ":" .. t_S), "〔日本元号〕", preedittext)
    end
    return
  end
  -- if input == env.prefix .. "ftj" or input == env.prefix .. "htj" then
  --   yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. os.date("%H") .. ":" .. os.date("%M") .. ":" .. os.date("%S"), "〔年月日 時:分:秒〕")
  --   return
  -- end

  if input == env.prefix .. "fth" or input == env.prefix .. "hth" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local check_number_format = string.match(t_m, "^0") or string.match(t_d, "^0") or string.match(t_H, "^0") or string.match(t_M, "^0") or string.match(t_S, "^0")
    local preedittext = input .. "\t 【現時：年月日時分秒】"
    yield_c( string.gsub("民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "([^%d])0", "%1"), "〔民國〕", preedittext)
    yield_c( string.gsub("民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "([^%d])0", "%1"), "〔民國〕", preedittext)
    yield_c( string.gsub("民國 " .. min_guo(t_Y) .. " 年 " .. t_m .. " 月 " .. t_d .. " 日 " .. t_H .. " 點 " .. t_M .. " 分 " .. t_S .. " 秒", "([^%d])0", "%1"), "〔民國*〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(t_Y)) .. "年" .. fullshape_number(string.gsub(t_m .. "月" .. t_d .. "日　" .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "0([%d])", "%1")), "〔民國〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(t_Y)) .. "年" .. fullshape_number(string.gsub(t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "0([%d])", "%1")), "〔民國〕", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( "民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "〔民國〕", preedittext)
      yield_c( "民國" .. min_guo(t_Y) .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "〔民國〕", preedittext)
      yield_c( "民國 " .. min_guo(t_Y) .. " 年 " .. t_m .. " 月 " .. t_d .. " 日 " .. t_H .. " 點 " .. t_M .. " 分 " .. t_S .. " 秒", "〔民國*〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(t_Y)) .. "年" .. fullshape_number(t_m) .. "月" .. fullshape_number(t_d) .. "日　" .. fullshape_number(t_H .. "點" .. t_M .. "分" .. t_S .. "秒"), "〔民國〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(t_Y)) .. "年" .. fullshape_number(t_m) .. "月" .. fullshape_number(t_d) .. "日" .. fullshape_number(t_H .. "點" .. t_M .. "分" .. t_S .. "秒"), "〔民國〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "ftg" or input == env.prefix .. "htg" then
    local t_Y = os.date("%Y")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local rqzdx1_23 = rqzdx1(23)
    local rqzdx2_23 = rqzdx2(23)
    local preedittext = input .. "\t 【現時：年月日時分秒】"
    yield_c( "民國" .. purech_number(min_guo(t_Y)) .. "年" .. rqzdx1_23 .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "〔民國中數〕", preedittext)
    yield_c( "民國" .. purech_number(min_guo(t_Y)) .. "年" .. rqzdx1_23 .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(t_Y)) .. "年" .. rqzdx1_23 .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(t_Y)) .. "年" .. rqzdx1_23 .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[2], min_guo(t_Y)) .. "年" .. rqzdx2_23 .. " " .. chb_h_date(t_H) .. "點" .. chb_minsec_date(t_M) .. "分" .. chb_minsec_date(t_S) .. "秒", "〔民國中數〕", preedittext)
    return
  end

  if input == env.prefix .. "ftc" or input == env.prefix .. "htc" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local check_number_format = string.match(t_m, "^0") or string.match(t_d, "^0") or string.match(t_H, "^0") or string.match(t_M, "^0") or string.match(t_S, "^0")
    local preedittext = input .. "\t 【現時：年月日時分秒】"  --〔年月日 時:分:秒〕〔*年月日 時:分:秒*〕
    yield_c( string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "([^%d])0", "%1"), "〔日期〕", preedittext)
    yield_c( string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "([^%d])0", "%1"), "〔日期〕", preedittext)
    yield_c( string.gsub(" " .. t_Y .. " 年 " .. t_m .. " 月 " .. t_d .. " 日 " .. t_H .. " 點 " .. t_M .. " 分 " .. t_S .. " 秒 ", "([^%d])0", "%1"), "〔*日期*〕", preedittext)
    yield_c( fullshape_number(string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日　" .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "([^%d])0", "%1")), "〔日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(t_Y .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "([^%d])0", "%1")), "〔日期〕", preedittext)
    if check_number_format then
      yield_zp(preedittext)
      yield_c( t_Y .. "年" .. t_m .. "月" .. t_d .. "日 " .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "〔日期〕", preedittext)
      yield_c( t_Y .. "年" .. t_m .. "月" .. t_d .. "日" .. t_H .. "點" .. t_M .. "分" .. t_S .. "秒", "〔日期〕", preedittext)
      yield_c( " " .. t_Y .. " 年 " .. t_m .. " 月 " .. t_d .. " 日 " .. t_H .. " 點 " .. t_M .. " 分 " .. t_S .. " 秒 ", "〔*日期*〕", preedittext)
      yield_c( fullshape_number(t_Y) .. "年" .. fullshape_number(t_m) .. "月" .. fullshape_number(t_d) .. "日　" .. fullshape_number(t_H) .. "點" .. fullshape_number(t_M) .. "分" .. fullshape_number(t_S) .. "秒", "〔日期〕", preedittext)
      yield_c( fullshape_number(t_Y) .. "年" .. fullshape_number(t_m) .. "月" .. fullshape_number(t_d) .. "日" .. fullshape_number(t_H) .. "點" .. fullshape_number(t_M) .. "分" .. fullshape_number(t_S) .. "秒", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "ftd" or input == env.prefix .. "fto" or input == env.prefix .. "htd" or input == env.prefix .. "hto" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local preedittext = input .. "\t 【現時：年月日時分秒】"  --〔年月日 時:分:秒〕
    yield_c( t_Y .. t_m .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "", preedittext)
    yield_c( fullshape_number(t_Y) .. fullshape_number(t_m) .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    yield_c( t_d .. t_m .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日月年 時:分:秒〕", preedittext)
    yield_c( t_m .. t_d .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔月日年 時:分:秒〕", preedittext)
    return
  end

  if input == env.prefix .. "fts" or input == env.prefix .. "fty" or input == env.prefix .. "hts" or input == env.prefix .. "hty" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local preedittext = input .. "\t 【現時：年月日時分秒】"  --〔年月日 時:分:秒〕
    yield_c( t_Y .. "/" .. t_m .. "/" .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "", preedittext)
    -- yield_c( fullshape_number(t_Y) .. "/" .. fullshape_number(t_m) .. "/" .. fullshape_number(t_d) .. " " .. fullshape_number(t_H) .. ":" .. fullshape_number(t_M) .. ":" .. fullshape_number(t_S), "〔年月日 時:分:秒〕", preedittext)
    yield_c( fullshape_number(t_Y) .. "／" .. fullshape_number(t_m) .. "／" .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    yield_c( t_d .. "/" .. t_m .. "/" .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日月年 時:分:秒〕", preedittext)
    yield_c( t_m .. "/" .. t_d .. "/" .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔月日年 時:分:秒〕", preedittext)
    return
  end

  if input == env.prefix .. "ftm" or input == env.prefix .. "ftr" or input == env.prefix .. "htm" or input == env.prefix .. "htr" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local preedittext = input .. "\t 【現時：年月日時分秒】"  --〔年月日 時:分:秒〕
    yield_c( t_Y .. "-" .. t_m .. "-" .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "", preedittext)
    yield_c( fullshape_number(t_Y) .. "－" .. fullshape_number(t_m) .. "－" .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    yield_c( t_d .. "-" .. t_m .. "-" .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日月年 時:分:秒〕", preedittext)
    yield_c( t_m .. "-" .. t_d .. "-" .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔月日年 時:分:秒〕", preedittext)
    return
  end

  if input == env.prefix .. "ftu" or input == env.prefix .. "ftv" or input == env.prefix .. "htu" or input == env.prefix .. "htv" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local preedittext = input .. "\t 【現時：年月日時分秒】"  --〔年月日 時:分:秒〕
    yield_c( t_Y .. "_" .. t_m .. "_" .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "", preedittext)
    -- yield_c( fullshape_number(t_Y) .. "_" .. fullshape_number(t_m) .. "_" .. fullshape_number(t_d) .. " " .. fullshape_number(t_H) .. ":" .. fullshape_number(t_M) .. ":" .. fullshape_number(t_S), "〔年月日 時:分:秒〕", preedittext)
    yield_c( fullshape_number(t_Y) .. "＿" .. fullshape_number(t_m) .. "＿" .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    yield_c( t_d .. "_" .. t_m .. "_" .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日月年 時:分:秒〕", preedittext)
    yield_c( t_m .. "_" .. t_d .. "_" .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔月日年 時:分:秒〕", preedittext)
    return
  end

  if input == env.prefix .. "ftp" or input == env.prefix .. "ftq" or input == env.prefix .. "htp" or input == env.prefix .. "htq" then
    local t_Y, t_m, t_d = os.date("%Y"), os.date("%m"), os.date("%d")
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local preedittext = input .. "\t 【現時：年月日時分秒】"  --〔年月日 時:分:秒〕
    yield_c( t_Y .. "." .. t_m .. "." .. t_d .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "", preedittext)
    -- yield_c( fullshape_number(t_Y) .. "." .. fullshape_number(t_m) .. "." .. fullshape_number(t_d) .. " " .. fullshape_number(t_H) .. ":" .. fullshape_number(t_M) .. ":" .. fullshape_number(t_S), "〔年月日 時:分:秒〕", preedittext)
    yield_c( fullshape_number(t_Y) .. "．" .. fullshape_number(t_m) .. "．" .. fullshape_number(t_d) .. "　" .. fullshape_number(t_H) .. "：" .. fullshape_number(t_M) .. "：" .. fullshape_number(t_S), "", preedittext)
    yield_c( t_d .. "." .. t_m .. "." .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔日月年 時:分:秒〕", preedittext)
    yield_c( t_m .. "." .. t_d .. "." .. t_Y .. " " .. t_H .. ":" .. t_M .. ":" .. t_S, "〔月日年 時:分:秒〕", preedittext)
    return
  end

  if input == env.prefix .. "ftz" or input == env.prefix .. "htz" then
    local t_H, t_M, t_S = os.date("%H"), os.date("%M"), os.date("%S")
    local rqzdx1_nil = rqzdx1()
    local rqzdx2_nil = rqzdx2()
    local preedittext = input .. "\t 【現時：年月日時分秒】"
    yield_c( rqzdx1_nil .. " " .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "〔中數〕", preedittext)
    yield_c( rqzdx1_nil .. ch_h_date(t_H) .. "點" .. ch_minsec_date(t_M) .. "分" .. ch_minsec_date(t_S) .. "秒", "〔中數〕", preedittext)
    yield_c( rqzdx2_nil .. " " .. chb_h_date(t_H) .. "點" .. chb_minsec_date(t_M) .. "分" .. chb_minsec_date(t_S) .. "秒", "〔中數〕", preedittext)
    return
  end


-- function week_translator1(input, seg)
  if input == env.prefix .. "fw" or input == env.prefix .. "hw" then
    local preedittext = input .. "\t 【現時：年月日週】"  --〔年月日週〕
    yield_c( string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕 ~c", preedittext)
    yield_c( rqzdx1() .. " " .. "星期" .. weekstyle()[1] .. " ", "〔中數〕 ~z", preedittext)
    -- yield_c( rqzdx2() .. " " .. "星期" .. weekstyle()[1] .. " ", "〔年月日週〕", preedittext)
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日", "([^%d])0", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國〕 ~h", preedittext)
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國中數〕 ~g", preedittext)
    -- yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. weekstyle()[3] .. " ", "〔年月日週〕 ~j", preedittext)
    local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    -- yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. weekstyle()[3], "〔日本元号〕 ~j", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. " " .. weekstyle()[5] .. "曜日 ", "〔日本元号〕 ~j", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng1_m_date(os.date("%m")) .. " " .. eng2_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕 ~a", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng2_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文英式〕 ~e", preedittext)
    -- local chinese_date = to_chinese_cal_local(os.time())
    local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ll_1 .. " " .. weekstyle()[5] .. " ", "〔農曆〕 ~l", preedittext)
    return
  end

  if input == env.prefix .. "fwj" or input == env.prefix .. "hwj" then
    local preedittext = input .. "\t 【現時：年月日週】"
    local jpymd, jp_y = jp_ymd(os.date("%Y"),os.date("%m"),os.date("%d"))
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. " " .. weekstyle()[5] .. "曜日 ", "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. weekstyle()[5] .. "曜日", "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. "（" .. weekstyle()[5] .. "曜日）", "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. "(" .. weekstyle()[5] .. "曜日)", "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. "（" .. weekstyle()[5] .. "）", "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. "(" .. weekstyle()[5] .. ")", "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. weekstyle()[3], "〔日本元号〕", preedittext)
    yield_c( string.gsub(jpymd, "([^%d])0", "%1") .. weekstyle()[4], "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. " " .. weekstyle()[5] .. "曜日 "), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. weekstyle()[5] .. "曜日"), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. "（" .. weekstyle()[5] .. "曜日）"), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. "(" .. weekstyle()[5] .. "曜日)"), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. "（" .. weekstyle()[5] .. "）"), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. "(" .. weekstyle()[5] .. ")"), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. weekstyle()[3]), "〔日本元号〕", preedittext)
    yield_c( fullshape_number(string.gsub(jpymd, "([^%d])0", "%1") .. weekstyle()[4]), "〔日本元号〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( jpymd .. " " .. weekstyle()[5] .. "曜日 ", "〔日本元号〕", preedittext)
      yield_c( jpymd .. weekstyle()[5] .. "曜日", "〔日本元号〕", preedittext)
      yield_c( jpymd .. "（" .. weekstyle()[5] .. "曜日）", "〔日本元号〕", preedittext)
      yield_c( jpymd .. "(" .. weekstyle()[5] .. "曜日)", "〔日本元号〕", preedittext)
      yield_c( jpymd .. "（" .. weekstyle()[5] .. "）", "〔日本元号〕", preedittext)
      yield_c( jpymd .. "(" .. weekstyle()[5] .. ")", "〔日本元号〕", preedittext)
      yield_c( jpymd .. weekstyle()[3], "〔日本元号〕", preedittext)
      yield_c( jpymd .. weekstyle()[4], "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. " " .. weekstyle()[5] .. "曜日 "), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. weekstyle()[5] .. "曜日"), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. "（" .. weekstyle()[5] .. "曜日）"), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. "(" .. weekstyle()[5] .. "曜日)"), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. "（" .. weekstyle()[5] .. "）"), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. "(" .. weekstyle()[5] .. ")"), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. weekstyle()[3]), "〔日本元号〕", preedittext)
      yield_c( fullshape_number(jpymd .. weekstyle()[4]), "〔日本元号〕", preedittext)
    end
    return
  end
  -- if input == env.prefix .. "fwj" or input == env.prefix .. "hwj" then
  --   yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. weekstyle()[3] .. " ", "〔年月日週〕")
  --   -- yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔年月日週〕")
  --   yield_c( os.date("%Y年%m月%d日") .. " " .. weekstyle()[5] .. "曜日 ", "〔年月日週〕")
  --   yield_c( os.date("%Y年%m月%d日") .. "(" .. weekstyle()[5] .. "曜日)", "〔年月日週〕")
  --   yield_c( os.date("%Y年%m月%d日") .. "（" .. weekstyle()[5] .. "曜日）", "〔年月日週〕")
  --   return
  -- end

  if input == env.prefix .. "fwh" or input == env.prefix .. "hwh" then
    local preedittext = input .. "\t 【現時：年月日週】"
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日", "([^%d])0", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國〕", preedittext)
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日", "([^%d])0", "%1") .. "星期" .. weekstyle()[1], "〔民國〕", preedittext)
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日", "([^%d])0", "%1") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔民國〕", preedittext)
    yield_c( string.gsub("民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日", "([^%d])0", "%1") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔民國〕", preedittext)
    yield_c( string.gsub("民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日", "([^%d])0", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國*〕", preedittext)
    yield_c( string.gsub("民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日", "([^%d])0", "%1") .. "星期" .. weekstyle()[1], "〔民國*〕", preedittext)
    yield_c( string.gsub("民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日", "([^%d])0", "%1") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔民國*〕", preedittext)
    yield_c( string.gsub("民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日", "([^%d])0", "%1") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔民國*〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. "星期" .. weekstyle()[1], "〔民國〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔民國〕", preedittext)
    yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")) .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔民國〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( "民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日" .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國〕", preedittext)
      yield_c( "民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日" .. "星期" .. weekstyle()[1], "〔民國〕", preedittext)
      yield_c( "民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日" .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔民國〕", preedittext)
      yield_c( "民國" .. min_guo(os.date("%Y")) .. "年" .. os.date("%m") .. "月" .. os.date("%d") .. "日" .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔民國〕", preedittext)
      yield_c( "民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日" .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國*〕", preedittext)
      yield_c( "民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日" .. "星期" .. weekstyle()[1], "〔民國*〕", preedittext)
      yield_c( "民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日" .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔民國*〕", preedittext)
      yield_c( "民國 " .. min_guo(os.date("%Y")) .. " 年 " .. os.date("%m") .. " 月 " .. os.date("%d") .. " 日" .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔民國*〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. "星期" .. weekstyle()[1], "〔民國〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔民國〕", preedittext)
      yield_c( "民國" .. fullshape_number(min_guo(os.date("%Y"))) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔民國〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "fwg" or input == env.prefix .. "hwg" then
    local preedittext = input .. "\t 【現時：年月日週】"
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國中數〕", preedittext)
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. "星期" .. weekstyle()[1], "〔民國中數〕", preedittext)
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔民國中數〕", preedittext)
    yield_c( "民國" .. purech_number(min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. "星期" .. weekstyle()[1], "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔民國中數〕", preedittext)
    yield_c( "民國" .. read_number(confs[1], min_guo(os.date("%Y"))) .. "年" .. rqzdx1(23) .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔民國中數〕", preedittext)
    --- 中文大寫數字
    yield_c( "民國" .. read_number(confs[2], min_guo(os.date("%Y"))) .. "年" .. rqzdx2(23) .. " " .. "星期" .. weekstyle()[2] .. " ", "〔民國中數〕", preedittext)
    return
  end

  if input == env.prefix .. "fwl" or input == env.prefix .. "hwl" then
    local preedittext = input .. "\t 【現時：年月日週】"
    -- local chinese_date = to_chinese_cal_local(os.time())
    local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
    yield_c( ll_1 .. " " .. weekstyle()[5] .. " ", "〔農曆〕", preedittext)
    yield_c( ll_1 .. "（" .. weekstyle()[5] .. "）", "〔農曆〕", preedittext)
    yield_c( ll_1 .. "(" .. weekstyle()[5] .. ")", "〔農曆〕", preedittext)
    yield_c( ll_2 .. " " .. weekstyle()[5] .. " ", "〔農曆〕", preedittext)
    yield_c( ll_2 .. "（" .. weekstyle()[5] .. "）", "〔農曆〕", preedittext)
    yield_c( ll_2 .. "(" .. weekstyle()[5] .. ")", "〔農曆〕", preedittext)
    local All_g, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
    yield_c( Y_g .. "年" .. M_g .. "月" .. D_g .. "日" .. " " .. weekstyle()[5] .. " " , "〔農曆干支〕", preedittext)
    yield_c( Y_g .. "年" .. M_g .. "月" .. D_g .. "日" .. "（" .. weekstyle()[5] .. "）" , "〔農曆干支〕", preedittext)
    yield_c( Y_g .. "年" .. M_g .. "月" .. D_g .. "日" .. "(" .. weekstyle()[5] .. ")" , "〔農曆干支〕", preedittext)
    return
  end

  if input == env.prefix .. "fwa" or input == env.prefix .. "hwa" then
    local preedittext = input .. "\t 【現時：年月日週】"  --〔週月日年〕
    yield_c( weekstyle()[6] .. ", " .. eng1_m_date(os.date("%m")) .. " " .. eng2_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng1_m_date(os.date("%m")) .. " " .. eng3_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕", preedittext)
    yield_c( weekstyle()[7] .. ", " .. eng2_m_date(os.date("%m")) .. " " .. eng3_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕", preedittext)
    yield_c( weekstyle()[8] .. " " .. eng3_m_date(os.date("%m")) .. " " .. eng4_d_date(os.date("%d")) .. " " .. os.date("%Y"), "〔英文美式〕", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng1_m_date(os.date("%m")) .. " the " .. eng1_d_date(os.date("%d")) .. ", " .. os.date("%Y"), "〔英文美式〕", preedittext)
    return
  end

  if input == env.prefix .. "fwe" or input == env.prefix .. "hwe" then
    local preedittext = input .. "\t 【現時：年月日週】"  --〔週日月年〕
    yield_c( weekstyle()[6] .. ", " .. eng2_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文英式〕", preedittext)
    yield_c( weekstyle()[6] .. ", " .. eng3_d_date(os.date("%d")) .. " " .. eng1_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文英式〕", preedittext)
    yield_c( weekstyle()[7] .. ", " .. eng2_d_date(os.date("%d")) .. " " .. eng2_m_date(os.date("%m")) .. " " .. os.date("%Y"), "〔英文英式〕", preedittext)
    yield_c( weekstyle()[6] .. ", " .. "the " .. eng1_d_date(os.date("%d")) .. " of " .. eng1_m_date(os.date("%m")) .. ", " .. os.date("%Y"), "〔英文英式〕", preedittext)
    -- yield_c( weekstyle()[6] .. ", " .. "The " .. eng1_d_date(os.date("%d")) .. " of " .. eng1_m_date(os.date("%m")) .. ", " .. os.date("%Y"), "〔週日月年〕", preedittext)
    return
  end

  if input == env.prefix .. "fwc" or input == env.prefix .. "hwc" then
    local preedittext = input .. "\t 【現時：年月日週】"  --〔年月日週〕〔*年月日週*〕
    yield_c( string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕", preedittext)
    yield_c( string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1") .. "星期" .. weekstyle()[1], "〔日期〕", preedittext)
    yield_c( string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
    yield_c( string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔日期〕", preedittext)
    yield_c( string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔*日期*〕", preedittext)
    yield_c( string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1") .. "星期" .. weekstyle()[1], "〔*日期*〕", preedittext)
    yield_c( string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔*日期*〕", preedittext)
    yield_c( string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔*日期*〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")) .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")) .. "星期" .. weekstyle()[1], "〔日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")) .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
    yield_c( fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")) .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔日期〕", preedittext)
    local check_number_format = string.match(os.date("%m"), "^0") or string.match(os.date("%d"), "^0")
    if check_number_format then
      yield_zp(preedittext)
      yield_c( os.date("%Y年%m月%d日") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕", preedittext)
      yield_c( os.date("%Y年%m月%d日") .. "星期" .. weekstyle()[1], "〔日期〕", preedittext)
      yield_c( os.date("%Y年%m月%d日") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
      yield_c( os.date("%Y年%m月%d日") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔日期〕", preedittext)
      yield_c( os.date(" %Y 年 %m 月 %d 日") .. " " .. "星期" .. weekstyle()[1] .. " ", "〔*日期*〕", preedittext)
      yield_c( os.date(" %Y 年 %m 月 %d 日") .. "星期" .. weekstyle()[1], "〔*日期*〕", preedittext)
      yield_c( os.date(" %Y 年 %m 月 %d 日") .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔*日期*〕", preedittext)
      yield_c( os.date(" %Y 年 %m 月 %d 日") .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔*日期*〕", preedittext)
      yield_c( fullshape_number(os.date("%Y")) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. " " .. "星期" .. weekstyle()[1] .. " ", "〔日期〕", preedittext)
      yield_c( fullshape_number(os.date("%Y")) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. "星期" .. weekstyle()[1], "〔日期〕", preedittext)
      yield_c( fullshape_number(os.date("%Y")) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔日期〕", preedittext)
      yield_c( fullshape_number(os.date("%Y")) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日" .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔日期〕", preedittext)
    end
    return
  end

  if input == env.prefix .. "fwz" or input == env.prefix .. "hwz" then
    local preedittext = input .. "\t 【現時：年月日週】"
    yield_c( rqzdx1() .. " " .. "星期" .. weekstyle()[1] .. " ", "〔中數〕", preedittext)
    yield_c( rqzdx1() .. "星期" .. weekstyle()[1], "〔中數〕", preedittext)
    yield_c( rqzdx1() .. "（" .. "星期" .. weekstyle()[1] .. "）", "〔中數〕", preedittext)
    yield_c( rqzdx1() .. " (" .. "星期" .. weekstyle()[1] .. ") ", "〔中數〕", preedittext)
    --- 中文大寫數字
    yield_c( rqzdx2() .. " " .. "星期" .. weekstyle()[2] .. " ", "〔中數〕", preedittext)
    return
  end

-- function week_translator2(input, seg)
  -- if input == env.prefix .. "fwt" or input == env.prefix .. "hwt" then
  --   yield_c( os.date("%Y年%m月%d日") .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕")
  --   yield_c( os.date(" %Y 年 %m 月 %d 日") .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕")
  --   yield_c( fullshape_number(os.date("%Y")) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日 " .. "星期" .. weekstyle()[1] .. " " .. fullshape_number(os.date("%H")) .. "：" .. fullshape_number(os.date("%M")) .. "：" .. fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕")
  --   yield_c( os.date("%Y年%m月%d日") .. " " .. weekstyle()[5] .. "曜日 " .. os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕")
  --   -- yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H") .. ":" .. os.date("%M") .. ":" .. os.date("%S"), "〔年月日週 時:分:秒〕")
  --   yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. weekstyle()[3] .. " " .. os.date("%H") .. ":" .. os.date("%M") .. ":" .. os.date("%S"), "〔年月日週 時:分:秒〕")
  --   yield_c( rqzdx1() .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z")
  --   -- yield_c( rqzdx2() .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕")
  --   return
  -- end

  -- if input == env.prefix .. "fwtz" or input == env.prefix .. "hwtz" then
  --   yield_c( rqzdx1() .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕")
  --   yield_c( rqzdx2() .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕")
  --   return
  -- end
-- function week_translator3(input, seg)
  -- if input == env.prefix .. "fwn" or input == env.prefix .. "hwn" then
  --   yield_c( os.date("%Y年%m月%d日") .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M"), "〔年月日週 時:分〕")
  --   yield_c( os.date(" %Y 年 %m 月 %d 日") .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M"), "〔*年月日週 時:分〕")
  --   yield_c( fullshape_number(os.date("%Y")) .. "年" .. fullshape_number(os.date("%m")) .. "月" .. fullshape_number(os.date("%d")) .. "日 " .. "星期" .. weekstyle()[1] .. " " .. fullshape_number(os.date("%H")) .. "：" .. fullshape_number(os.date("%M")), "〔年月日週 時:分〕")
  --   yield_c( os.date("%Y年%m月%d日") .. " " .. weekstyle()[5] .. "曜日 " .. os.date("%H:%M"), "〔年月日週 時:分〕")
  --   -- yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H") .. ":" .. os.date("%M"), "〔年月日週 時:分〕")
  --   yield_c( os.date("%Y") .. "年 " .. jp_m_date(os.date("%m")) .. jp_d_date(os.date("%d")) .. " " .. weekstyle()[3] .. " " .. os.date("%H") .. ":" .. os.date("%M"), "〔年月日週 時:分〕")
  --   yield_c( rqzdx1() .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M"), "〔年月日週 時:分〕 ~z")
  --   -- yield_c( rqzdx2() .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M"), "〔年月日週 時:分〕")
  --   return
  -- end

  -- if input == env.prefix .. "fwnz" or input == env.prefix .. "hwnz" then
  --   yield_c( rqzdx1() .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M"), "〔年月日週 時:分〕")
  --   yield_c( rqzdx2() .. " " .. "星期" .. weekstyle()[1] .. " " .. os.date("%H:%M"), "〔年月日週 時:分〕")
  --   return
  -- end

  -- ::continue::

  -- end

-----------------------------

  ::englishout1_label::

  -- local englishout1 = string.match(input, env.prefix .. "/([%l.,/'-]+)$")
  if englishout1 then
    local preedittext = env.prefix .. "/ " .. englishout1 .. "\t 【小寫字母】"
    yield_c( english_s(englishout1), "〔一般〕", preedittext)
    yield_c( english_f_l(englishout1), "〔全形〕", preedittext)
    -- yield_c( english_mds_u(englishout1), "〔數學字母大寫〕", preedittext)
    yield_c( english_mm_l(englishout1), "〔等寬體〕", preedittext)
    yield_c( english_mds_l(englishout1), "〔雙線體〕", preedittext)
    yield_c( english_mi_l(englishout1), "〔斜體〕", preedittext)
    yield_c( english_mb_l(englishout1), "〔粗體〕", preedittext)
    yield_c( english_mbi_l(englishout1), "〔粗斜體〕", preedittext)
    yield_c( english_mss_l(englishout1), "〔無襯線體〕", preedittext)
    yield_c( english_mssi_l(englishout1), "〔無襯線斜體〕", preedittext)
    yield_c( english_mssb_l(englishout1), "〔無襯線粗體〕", preedittext)
    yield_c( english_mssbi_l(englishout1), "〔無襯線粗斜體〕", preedittext)
    yield_c( english_ms_l(englishout1), "〔手稿體〕", preedittext)
    yield_c( english_mbs_l(englishout1), "〔手稿粗體〕", preedittext)
    yield_c( english_mf_l(englishout1), "〔尖角體〕", preedittext)
    yield_c( english_mbf_l(englishout1), "〔尖角粗體〕", preedittext)
    -- yield_c( english_3(englishout1), "〔帶圈字母大寫〕", preedittext)
    yield_c( english_6(englishout1), "〔括號〕", preedittext)
    yield_c( english_4(englishout1), "〔帶圈〕", preedittext)
    -- yield_c( english_5(englishout1), "〔括號字母大寫〕", preedittext)
    -- yield_c( english_7(englishout1), "〔方框字母〕", preedittext)
    -- yield_c( english_8(englishout1), "〔黑圈字母〕", preedittext)
    -- yield_c( english_9(englishout1), "〔黑框字母〕", preedittext)
    if english_braille_c_l(englishout1) ~= english_braille_u_l(englishout1) then
      yield_c( english_braille_c_l(englishout1), "〔點字 computer〕", preedittext)  -- (computer)
      yield_c( english_braille_u_l(englishout1), "〔點字 unified〕", preedittext)  -- (unified)
    else
      yield_c( english_braille_c_l(englishout1), "〔點字 computer/unified〕", preedittext)  -- (computer/unified)
    end
    return
  end

  ::englishout2_label::

  -- local englishout2 = string.match(input, env.prefix .. "\'([%l.,/'-]+)$")
  if englishout2 then
    local preedittext = env.prefix .. "\' " .. englishout2 .. "\t 【開頭大寫字母】"
    -- yield_c( string.upper(string.sub(englishout2,1,1)) .. string.sub(englishout2,2,-1) , "〔一般字母開頭大寫〕", preedittext)
    yield_c( english_s2u(englishout2), "〔一般〕", preedittext)
    yield_c( english_f_ul(englishout2), "〔全形〕", preedittext)
    yield_c( english_mm_ul(englishout2), "〔等寬體〕", preedittext)
    yield_c( english_mds_ul(englishout2), "〔雙線體〕", preedittext)
    yield_c( english_mi_ul(englishout2), "〔斜體〕", preedittext)
    yield_c( english_mb_ul(englishout2), "〔粗體〕", preedittext)
    yield_c( english_mbi_ul(englishout2), "〔粗斜體〕", preedittext)
    yield_c( english_mss_ul(englishout2), "〔無襯線體〕", preedittext)
    yield_c( english_mssi_ul(englishout2), "〔無襯線斜體〕", preedittext)
    yield_c( english_mssb_ul(englishout2), "〔無襯線粗體〕", preedittext)
    yield_c( english_mssbi_ul(englishout2), "〔無襯線粗斜體〕", preedittext)
    yield_c( english_ms_ul(englishout2), "〔手稿體〕", preedittext)
    yield_c( english_mbs_ul(englishout2), "〔手稿粗體〕", preedittext)
    yield_c( english_mf_ul(englishout2), "〔尖角體〕", preedittext)
    yield_c( english_mbf_ul(englishout2), "〔尖角粗體〕", preedittext)
    yield_c( english_5_6(englishout2), "〔括號〕", preedittext)
    yield_c( english_3_4(englishout2), "〔帶圈〕", preedittext)
    if english_braille_c_ul(englishout2) ~= english_braille_u_ul(englishout2) then
      yield_c( english_braille_c_ul(englishout2), "〔點字 computer〕", preedittext)  -- (computer)
      yield_c( english_braille_u_ul(englishout2), "〔點字 unified〕", preedittext)  -- (unified)
    else
      yield_c( english_braille_c_ul(englishout2), "〔點字 computer/unified〕", preedittext)  -- (computer/unified)
    end
    return
  end

  ::englishout3_label::

  -- local englishout3 = string.match(input, env.prefix .. ";([%l.,/'-]+)$")
  if englishout3 then
    local preedittext = env.prefix .. "; " .. englishout3 .. "\t 【大寫字母】"
    local englishout3 = string.upper(englishout3)
    yield_c( english_s(englishout3), "〔一般〕", preedittext)
    yield_c( english_f_u(englishout3), "〔全形〕", preedittext)
    yield_c( english_mm_u(englishout3), "〔等寬體〕", preedittext)
    yield_c( english_mds_u(englishout3), "〔雙線體〕", preedittext)
    yield_c( english_mi_u(englishout3), "〔斜體〕", preedittext)
    yield_c( english_mb_u(englishout3), "〔粗體〕", preedittext)
    yield_c( english_mbi_u(englishout3), "〔粗斜體〕", preedittext)
    yield_c( english_mss_u(englishout3), "〔無襯線體〕", preedittext)
    yield_c( english_mssi_u(englishout3), "〔無襯線斜體〕", preedittext)
    yield_c( english_mssb_u(englishout3), "〔無襯線粗體〕", preedittext)
    yield_c( english_mssbi_u(englishout3), "〔無襯線粗斜體〕", preedittext)
    yield_c( english_ms_u(englishout3), "〔手稿體〕", preedittext)
    yield_c( english_mbs_u(englishout3), "〔手稿粗體〕", preedittext)
    yield_c( english_mf_u(englishout3), "〔尖角體〕", preedittext)
    yield_c( english_mbf_u(englishout3), "〔尖角粗體〕", preedittext)
    yield_c( english_5(englishout3), "〔括號〕", preedittext)
    yield_c( english_3(englishout3), "〔帶圈〕", preedittext)
    yield_c( english_7(englishout3), "〔方框〕", preedittext)
    yield_c( english_8(englishout3), "〔黑圈〕", preedittext)
    yield_c( english_9(englishout3), "〔黑框〕", preedittext)
    yield_c( english_s_u(englishout3), "〔小型〕", preedittext)
    if english_braille_c_u(englishout3) ~= english_braille_u_u(englishout3) then
      yield_c( english_braille_c_u(englishout3), "〔點字 computer〕", preedittext)  -- (computer)
      yield_c( english_braille_u_u(englishout3), "〔點字 unified〕", preedittext)  -- (unified)
    else
      yield_c( english_braille_c_u(englishout3), "〔點字 computer/unified〕", preedittext)  -- (computer/unified)
    end
    return
  end

-----------------------------

  ::utf_input_label::

  -- local utf_prefix = env.prefix
  -- local utf_input = string.match(input, utf_prefix .. "([xuco][0-9a-f]+)$")
  -- local utf_input = string.match(input, env.prefix_s .. "([xuco][0-9a-f]+)$")
  if utf_input then
    -- if string.sub(input, 1, 2) ~= utf_prefix then return end
    local dict = { c=10, x=16, u=16, o=8 } --{ u=16 } --{ d=10, u=16, e=8 }
    local snd = string.sub(utf_input, 1, 1)
    local n_bit = dict[snd]
    if n_bit == nil then return end
    local str = string.sub(utf_input, 2)
    local c = tonumber(str, n_bit)
    if c == nil then return end
    local utf_x_u = string.match(utf_input, "^[xu]")
    local utf_o = string.match(utf_input, "^o")
    -- local utf_c = string.match(utf_input, "^c")  -- 可省略
    -- local preedittext = utf_prefix .. snd .. " " .. string.upper(string.sub(utf_input, 2))
    local preedittext = env.prefix .. snd .. " " .. string.upper(string.sub(utf_input, 2))
    -- if utf_x_u then
    --   -- local fmt = "U" .. snd .. "%" .. (n_bit == 16 and "X" or snd)
    --   fmt = "  U+" .. "%X"
    --   preedittext = preedittext .. "\t 【內碼十六進制】"  --【內碼十六進制 Hex】(Unicode)
    -- elseif utf_o then
    --   fmt = "  0o" .. "%o"
    --   preedittext = preedittext .. "\t 【內碼八進制】"  --【內碼八進制 Oct】
    -- else
    --   fmt = "  &#" .. "%d" .. ";"
    --   preedittext = preedittext .. "\t 【內碼十進制】"  --【內碼十進制 Dec】
    -- end
    local fmt = utf_x_u and "  U+" .. "%X" or
                utf_o and "  0o" .. "%o" or
                "  &#" .. "%d" .. ";"
    local preedittext = utf_x_u and preedittext .. "\t 【內碼十六進制】" or
                        utf_o and preedittext .. "\t 【內碼八進制】" or
                        preedittext .. "\t 【內碼十進制】"
    -- 單獨查找(改用下面迴圈執行)
    -- local cand_ui_s = Candidate("simp_mf_utf", seg.start, seg._end, utf8_out(c), string.format(fmt, c) .. "（ " .. url_encode(utf8_out(c)) .. " ）" )
    -- 排除數字太大超出範圍。正常範圍輸出已 string_char，故 0 直接可以限定。
    if utf8_out(c) == 0 then
      yield_c( "", "〈超出範圍〉", preedittext)  --字符過濾可能會過濾掉""整個選項。
      return
    end
    -- 區間查找
    -- if (c*n_bit+n_bit-1 < 1048575) then  -- 補下一位，如：x8d70 為「走」，補 x8d70[0-f]。
    --   for i = c*n_bit, c*n_bit+n_bit-1 do
    if c+32 <= 1048575 then  -- 補後面 32 碼，如：x8d70 為「走」，補 x8d70[+32] 到 x8d90。
      for i = c, c+32 do
    -- if c+16 <= 1048575 then  -- 補後面 16 碼，如：x8d70 為「走」，補 x8d70[+16] 到 x8d80。
    --   for i = c, c+16 do
      -- for i = c+1, c+16 do
        yield_c( utf8_out(i), string.format(fmt, i) .. "（ " .. url_encode(utf8_out(i)) .. " ）", preedittext)
      end
      return
    -- elseif c <= 1048575 and c+16 > 1048575 then  -- Unicode 編碼末尾。
    elseif c <= 1048575 then  -- Unicode 編碼末尾。
      for i = c, 1048575 do
        yield_c( utf8_out(i), string.format(fmt, i) .. "（ " .. url_encode(utf8_out(i)) .. " ）", preedittext)
      end
      return
    end
  end

  ::urlencode_input_label::

  -- local urlencode_prefix = env.prefix .. "i"
  -- local urlencode_input = string.match(input, urlencode_prefix .. "([0-9a-z][0-9a-f]*)$")
  -- local urlencode_input = string.match(input, env.prefix_s .. "i([0-9a-z][0-9a-f]*)$")
  if urlencode_input then
    local preedit_urlencode = string.gsub(urlencode_input, "(%w%w)", "%1 ")
    local urlencode_code = string.gsub(urlencode_input, "(%x%x)", "%%%1")
    local urlencode_code = string.gsub(urlencode_code, "(%x%x)(%x)$", "%1%%%2")
    local urlencode_code = string.gsub(urlencode_code, "^(%x)$", "%%%1")
    local urlencode_cand = url_decode(urlencode_input)
    -- local preedittext = urlencode_prefix .. " " .. string.upper(preedit_urlencode) .. "\t 【Percent/URL encoding】"
    local preedittext = env.prefix .. "i " .. string.upper(preedit_urlencode) .. "\t 【Percent/URL encoding】"
    -- local preedittext = urlencode_prefix .. " " .. string.upper(preedit_urlencode)  --string.upper(urlencode_code)

    local unfinished = string.match(urlencode_cand, "… $")
    if unfinished then
      judge_unfinished = "〈輸入未完〉"
    else
      judge_unfinished = ""
    end

    -- local cand_urlencode_error = Candidate("simp_mf_urlencode", seg.start, seg._end, "", urlencode_cand)  --字符過濾可能會過濾掉""整個選項。
    -- cand_urlencode_error.preedit = preedittext

    -- local cand_urlencode_sentence = Candidate("simp_mf_urlencode", seg.start, seg._end, urlencode_cand, judge_unfinished)
    -- cand_urlencode_sentence.preedit = preedittext

    local url_first_word = utf8_sub(urlencode_cand,1,1)
    local url_first_word_dec = utf8.codepoint(url_first_word)
    -- local cand_urlencode_single = Candidate("simp_mf_urlencode", seg.start, seg._end, url_first_word, string.format( "  U+" .. "%X", url_first_word_dec) .. judge_unfinished)
    -- cand_urlencode_single.preedit = preedittext

    -- local cand_urlencode_code = Candidate("simp_mf_urlencode", seg.start, seg._end, string.upper(urlencode_code), "〔URL編碼〕")
    -- cand_urlencode_code.preedit = preedittext

    local is_error = string.match(urlencode_cand, "^〈輸入錯誤〉")
    if is_error then
    -- if urlencode_cand == "〈輸入錯誤〉" then
      -- yield(cand_urlencode_error)
      yield_c( "", urlencode_cand, preedittext)  --字符過濾可能會過濾掉""整個選項。
    elseif urlencode_cand == url_first_word then
      -- yield(cand_urlencode_single)
      yield_c( url_first_word, string.format( "  U+" .. "%X", url_first_word_dec) .. judge_unfinished, preedittext)
    -- elseif string.match(urlencode_cand, "^ …") then
    --   yield(cand_urlencode_sentence)
    else
      -- yield(cand_urlencode_sentence)
      yield_c( urlencode_cand, judge_unfinished, preedittext)
      -- yield(cand_urlencode_single)
    end
    -- yield(cand_urlencode_code)
    yield_c( string.upper(urlencode_code), "〔URL編碼〕", preedittext)
    return
  end

  -- local url_c_input = string.match(input, env.prefix .. "e([0-9a-z][0-9a-f]*)$")
  -- if url_c_input ~= nil then
  --   local u_1 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f])$")
  --   local u_2 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
  --   local u_3 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
  --   local u_4 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
  --   if u_1 ~= nil or u_2 ~= nil or u_3 ~= nil or u_4 ~= nil then
  --     url_c_input = url_c_input .. "0"
  --   end
  --   local url_10 = url_decode(url_c_input)
  --   local uc_i = string.upper(string.sub(input, 4, 5)) .. " " .. string.upper(string.sub(input, 6, 7)) .. " " .. string.upper(string.sub(input, 8, 9)) .. " " .. string.upper(string.sub(input, 10, 11)) .. " " .. string.upper(string.sub(input, 12, 13)) .. " " .. string.upper(string.sub(input, 14, 15))
  --   local uc_i = string.gsub(uc_i, " +$", "" )
  --   if string.match(url_10, "無此編碼") ~= nil then
  --     yield_c( url_10, "" )
  --   elseif string.match(url_c_input, "^[0-9a-z]$") ~= nil then
  --     local cand_uci_a = Candidate("simp_mf_urlencode", seg.start, seg._end, url_10, url_10 )
  --     cand_uci_a.preedit = env.prefix .. "e " .. uc_i
  --     yield(cand_uci_a)
  --   else
  --     -- local u_c = string.upper(url_c_input)
  --     -- local u_c = string.gsub(u_c, '^', '%%')
  --     -- local u_c = string.gsub(u_c, '^(%%%w%w)(%w%w)', '%1%%%2')
  --     -- local u_c = string.gsub(u_c, '^(%%%w%w%%%w%w)(%w+)', '%1%%%2')
  --     -- local u_c = string.gsub(u_c, '^(%%%w%w%%%w%w%%%w%w)(%w+)', '%1%%%2')
  --     -- local u_c = string.gsub(u_c, '^(%%%w%w%%%w%w%%%w%w%%%w%w)(%w+)', '%1%%%2')
  --     -- local u_c = string.gsub(u_c, '^(%%%w%w%%%w%w%%%w%w%%%w%w%%%w%w)(%w+)', '%1%%%2')
  --     -- local u_c = string.gsub(u_c, '^(%w%w)(%w?%w?)(%w?%w?)(%w?%w?)(%w?%w?)(%w?%w?)$', '%%%1%%%2%%%3%%%4%%%5%%%6')
  --     -- local u_c = string.gsub(u_c, '[%%]+$', '')
  --     -- yield_c( utf8_out(url_10), u_c )
  --     local cand_uci_s = Candidate("simp_mf_urlencode", seg.start, seg._end, utf8_out(url_10), url_encode(utf8_out(url_10)) )
  --     cand_uci_s.preedit = env.prefix .. "e " .. uc_i
  --     yield(cand_uci_s)
  --   end
  --   -- if url_10*10+10-1 < 1048575 then
  --   --   for i = url_10*10, url_10*10+10-1 do
  --   if tonumber(url_10)+16 < 1048575 then
  --     for i = tonumber(url_10)+1, tonumber(url_10)+16 do
  --       local cand_uci_m = Candidate("simp_mf_urlencode", seg.start, seg._end, utf8_out(i), url_encode(utf8_out(i)) )
  --       cand_uci_m.preedit = env.prefix .. "e " .. uc_i
  --       yield(cand_uci_m)
  --     end
  --   end
  --   return
  -- end

-----------------------------
-----------------------------

  ::xy_label::

  -- local xy = string.match(input, env.prefix_s .. "(%d+)y$")
  -- if not xy then xy = string.match(input, env.prefix .. "y(%d+)$") end
  if xy then
    local preedittext = env.prefix .. " " .. xy .. "Y" .. "\t 【自訂日期：○年】"
    yield_c( xy .. "年", "〔日期〕", preedittext)
    yield_c( " " .. xy .. " 年 ", "〔*日期*〕", preedittext)
    yield_c( fullshape_number(xy) .. "年", "〔全形〕", preedittext)
    yield_c( ch_y_date(xy) .. "年", "〔小寫中文〕", preedittext)
    yield_c( chb_y_date(xy) .. "年", "〔大寫中文〕", preedittext)
    if tonumber(xy) > 1911 then
      yield_c( "民國" .. min_guo(xy) .. "年", "〔民國〕", preedittext)
      yield_c( "民國" .. purech_number(min_guo(xy)) .. "年", "〔民國〕", preedittext)
      yield_c( "民國" .. read_number(confs[1], min_guo(xy)) .. "年", "〔民國〕", preedittext)
    elseif tonumber(xy) <= 1911 then
      yield_c( "民國前" .. min_guo(xy) .. "年", "〔民國〕", preedittext)
      yield_c( "民國前" .. purech_number(min_guo(xy)) .. "年", "〔民國〕", preedittext)
      yield_c( "民國前" .. read_number(confs[1], min_guo(xy)) .. "年", "〔民國〕", preedittext)
    end
    -- yield_c( xy .. "年 ", "〔日文日期〕", preedittext)
    -- local jpymd2, jp_y2 = jp_ymd(xy, "1", "1")
    -- yield_c( jp_y2, "〔日本元号〕(沒有月日，元号可能有誤)", preedittext)
    yield_c( xy, "〔英文 美式/英式〕", preedittext)
    return
  end

  ::xm_label::

  -- local xm = string.match(input, env.prefix_s .. "(%d%d?)m$")
  -- if not xm then xm =  string.match(input, env.prefix .. "m(%d%d?)$") end
  if xm and tonumber(xm) < 13 then
    local preedittext = env.prefix .. " " .. xm .. "M" .. "\t 【自訂日期：○月】"
    yield_c( xm .. "月", "〔日期〕", preedittext)
    yield_c( " " .. xm .. " 月 ", "〔*日期*〕", preedittext)
    yield_c( fullshape_number(xm) .. "月", "〔全形〕", preedittext)
    yield_c( ch_m_date(xm) .. "月", "〔小寫中文〕", preedittext)
    yield_c( chb_m_date(xm) .. "月", "〔大寫中文〕", preedittext)
    yield_c( jp_m_date(xm), "〔日文日〕", preedittext)
    yield_c( eng1_m_date(xm), "〔英文 美式/英式〕", preedittext)
    yield_c( eng2_m_date(xm), "〔英文 美式/英式〕", preedittext)
    yield_c( eng3_m_date(xm), "〔英文美式〕", preedittext)
    return
  elseif xm then  -- 月份大於12跳掉（後改為顯示〈輸入錯誤〉）
    local preedittext = env.prefix .. " " .. xm .. "M" .. "\t 【自訂日期：○月】"
    yield_c( "", "〈輸入錯誤〉", preedittext)
    return
  end

  ::xd_label::

  -- local xd = string.match(input, env.prefix_s .. "(%d%d?)d$")
  -- if not xd then xd =  string.match(input, env.prefix .. "d(%d%d?)$") end
  if xd and tonumber(xd) < 32 then
    local preedittext = env.prefix .. " " .. xd .. "D" .. "\t 【自訂日期：○日】"
    yield_c( xd .. "日", "〔日期〕", preedittext)
    yield_c( " " .. xd .. " 日 ", "〔*日期*〕", preedittext)
    yield_c( fullshape_number(xd) .. "日", "〔全形〕", preedittext)
    yield_c( ch_d_date(xd) .. "日", "〔小寫中文〕", preedittext)
    yield_c( chb_d_date(xd) .. "日", "〔大寫中文〕", preedittext)
    yield_c( jp_d_date(xd), "〔日文〕", preedittext)
    yield_c( eng2_d_date(xd), "〔英文 美式/英式〕", preedittext)
    yield_c( eng3_d_date(xd), "〔英文 美式/英式〕", preedittext)
    yield_c( eng4_d_date(xd), "〔英文美式〕", preedittext)
    yield_c( "the " .. eng1_d_date(xd), "〔英文 美式/英式〕", preedittext)
    yield_c( "The " .. eng1_d_date(xd), "〔英文英式〕", preedittext)
    return
  elseif xd then  -- 日期大於31跳掉（後改為顯示〈輸入錯誤〉）
    local preedittext = env.prefix .. " " .. xd .. "D" .. "\t 【自訂日期：○日】"
    yield_c( "", "〈輸入錯誤〉", preedittext)
    return
  end

-----------------------------

  ::ym_ymd_label::

  -- local y, m, m_suffix = string.match(input, env.prefix_s .. "(%d+)y(%d%d?)(m?)$")
  -- if not y then y, m = string.match(input, env.prefix .. "y(%d+)m(%d%d?)$") end
  -- if y and tonumber(m) < 13 then

  -- local y, m, d, d_suffix = string.match(input, env.prefix_s .. "(%d+)y(%d%d?)m(%d%d?)(d?)$")
  -- if not y then y, m, d = string.match(input, env.prefix .. "y(%d+)m(%d%d?)d(%d%d?)$") end
  -- if y and tonumber(m) < 13 and tonumber(d) < 32 then

  -- if y and d == "" and tonumber(m) < 13 then
  if y and d == "" then
    local preedittext = env.prefix .. " " .. y .. "Y " .. m .. string.upper(m_suffix) .. "\t 【自訂日期：○年○月】"
    -- local m = tonumber(m) == 0 and "01" or m  -- 「0」校正，置後於「preedittext」，才不會錯誤顯示。
    yield_c( y .. "年" .. m .. "月", "〔日期〕", preedittext)
    yield_c( " " .. y .. " 年 " .. m .. " 月 ", "〔*日期*〕", preedittext)
    yield_c( fullshape_number(y) .. "年" .. fullshape_number(m) .. "月", "〔全形〕", preedittext)
    yield_c( ch_y_date(y) .. "年" .. ch_m_date(m) .. "月", "〔小寫中文〕", preedittext)
    yield_c( chb_y_date(y) .. "年" .. chb_m_date(m) .. "月", "〔大寫中文〕", preedittext)
    if tonumber(y) > 1911 then
      yield_c( "民國" .. min_guo(y) .. "年" .. m .. "月", "〔民國〕", preedittext)
      yield_c( "民國" .. purech_number(min_guo(y)) .. "年" .. ch_m_date(m) .. "月", "〔民國〕", preedittext)
      yield_c( "民國" .. read_number(confs[1], min_guo(y)) .. "年" .. ch_m_date(m) .. "月", "〔民國〕", preedittext)
    elseif tonumber(y) <= 1911 then
      yield_c( "民國前" .. min_guo(y) .. "年" .. m .. "月", "〔民國〕", preedittext)
      yield_c( "民國前" .. purech_number(min_guo(y)) .. "年" .. ch_m_date(m) .. "月", "〔民國〕", preedittext)
      yield_c( "民國前" .. read_number(confs[1], min_guo(y)) .. "年" .. ch_m_date(m) .. "月", "〔民國〕", preedittext)
    end
    -- yield_c( y .. "年 " .. jp_m_date(m), "〔日文日期〕", preedittext)
    -- local jpymd2, jp_y2 = jp_ymd(y, m, "1")
    -- yield_c( jp_y2 .. m .. "月", "〔日本元号〕(沒有日，元号可能有誤)", preedittext)
    yield_c( eng1_m_date(m) .. ", " .. y, "〔英文 美式/英式〕", preedittext)
    yield_c( eng2_m_date(m) .. ", " .. y, "〔英文美式〕", preedittext)
    yield_c( eng3_m_date(m) .. " " .. y, "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(m) .. " " .. y, "〔英文英式〕", preedittext)
    yield_c( eng2_m_date(m) .. " " .. y, "〔英文英式〕", preedittext)
    return
  -- end
  -- elseif y and d ~= "" and tonumber(m) < 13 and tonumber(d) < 32 then
  elseif y and d ~= "" and tonumber(d) < 32 then
    local preedittext = env.prefix .. " " .. y .. "Y " .. m .. "M " .. d .. string.upper(d_suffix) .. "\t 【自訂日期：○年○月○日】"  -- （月日：0→01）
    --- 以下「0」校正，防農曆轉換錯亂。
    local preedittext = (tonumber(m) == 0 or tonumber(d) == 0) and preedittext .. "（月日：0→01）" or preedittext
    local m = tonumber(m) == 0 and "01" or m  -- 「0」校正，置後於「preedittext」，才不會錯誤顯示。
    local d = tonumber(d) == 0 and "01" or d  -- 「0」校正，置後於「preedittext」，才不會錯誤顯示。
    yield_c( y .. "年" .. m .. "月" .. d .. "日", "〔日期〕", preedittext)
    yield_c( " " .. y .. " 年 " .. m .. " 月 " .. d .. " 日 ", "〔*日期*〕", preedittext)
    yield_c( fullshape_number(y) .. "年" .. fullshape_number(m) .. "月" .. fullshape_number(d) .. "日", "〔全形〕", preedittext)
    yield_c( ch_y_date(y) .. "年" .. ch_m_date(m) .. "月" .. ch_d_date(d) .. "日", "〔小寫中文〕", preedittext)
    yield_c( chb_y_date(y) .. "年" .. chb_m_date(m) .. "月" .. chb_d_date(d) .. "日", "〔大寫中文〕", preedittext)
    if tonumber(y) > 1911 then
      yield_c( "民國" .. min_guo(y) .. "年" .. m .. "月" .. d .. "日", "〔民國〕", preedittext)
      yield_c( "民國" .. purech_number(min_guo(y)) .. "年" .. ch_m_date(m) .. "月" .. ch_d_date(d) .. "日", "〔民國〕", preedittext)
      yield_c( "民國" .. read_number(confs[1], min_guo(y)) .. "年" .. ch_m_date(m) .. "月" .. ch_d_date(d) .. "日", "〔民國〕", preedittext)
    elseif tonumber(y) <= 1911 then
      yield_c( "民國前" .. min_guo(y) .. "年" .. m .. "月" .. d .. "日", "〔民國〕", preedittext)
      yield_c( "民國前" .. purech_number(min_guo(y)) .. "年" .. ch_m_date(m) .. "月" .. ch_d_date(d) .. "日", "〔民國〕", preedittext)
      yield_c( "民國前" .. read_number(confs[1], min_guo(y)) .. "年" .. ch_m_date(m) .. "月" .. ch_d_date(d) .. "日", "〔民國〕", preedittext)
    end
    -- yield_c( y .. "年 " .. jp_m_date(m) .. jp_d_date(d), "〔日文日期〕", preedittext)
    local jpymd2, jp_y2 = jp_ymd(y, m, d)
    yield_c( jp_y2 .. m .. "月" .. d .. "日", "〔日本元号〕", preedittext)
    yield_c( eng1_m_date(m) .. " " .. eng2_d_date(d) .. ", " .. y, "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(m) .. " " .. eng3_d_date(d) .. ", " .. y, "〔英文美式〕", preedittext)
    yield_c( eng2_m_date(m) .. " " .. eng3_d_date(d) .. ", " .. y, "〔英文美式〕", preedittext)
    yield_c( eng3_m_date(m) .. " " .. eng4_d_date(d) .. " " .. y, "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(m) .. " the " .. eng1_d_date(d) .. ", " .. y, "〔英文美式〕", preedittext)
    yield_c( eng2_d_date(d) .. " " .. eng1_m_date(m) .. " " .. y, "〔英文英式〕", preedittext)
    yield_c( eng3_d_date(d) .. " " .. eng1_m_date(m) .. " " .. y, "〔英文英式〕", preedittext)
    yield_c( eng2_d_date(d) .. " " .. eng2_m_date(m) .. " " .. y, "〔英文英式〕", preedittext)
    yield_c( "the " .. eng1_d_date(d) .. " of " .. eng1_m_date(m) .. ", " .. y, "〔英文英式〕", preedittext)
    yield_c( "The " .. eng1_d_date(d) .. " of " .. eng1_m_date(m) .. ", " .. y, "〔英文英式〕", preedittext)
    if tonumber(y) > 1899 and tonumber(y) < 2101 then
      -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      local ll_1b, ll_2b = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
      -- if Date2LunarDate ~= nil then
      if ll_1b ~= nil and ll_2b ~= nil then
        yield_c( ll_1b, "〔西曆→農曆〕", preedittext)
        yield_c( ll_2b, "〔西曆→農曆〕", preedittext)
      end
    end
    if tonumber(y) > 1901 and tonumber(y) < 2101 then
      local All_g2, Y_g2, M_g2, D_g2 = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
      if All_g2 ~= nil then
        yield_c( Y_g2 .. "年" .. M_g2 .. "月" .. D_g2 .. "日", "〔西曆→農曆干支〕", preedittext)
      end
      local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
      local LDD2D_leap_year = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
      -- if Date2LunarDate ~= nil then
      if LDD2D ~= nil then
        yield_c( LDD2D, "〔農曆→西曆〕", preedittext)
        yield_c( LDD2D_leap_year, "〔農曆(閏)→西曆〕", preedittext)
      end
      -- local chinese_date_input2 = to_chinese_cal(y, m, d)
      -- if chinese_date_input2 ~= nil then
      --   yield_c( chinese_date_input2 .. " ", "〔農曆，可能有誤！〕", preedittext)
      -- end
    end
    return
  elseif y then  -- 月份大於12或日期大於31跳掉（後改為顯示〈輸入錯誤〉）
    local preedittext = env.prefix .. " " .. y .. "Y " .. m .. "M " .. d .. string.upper(d_suffix) .. "\t 【自訂日期：○年○月○日】"
    yield_c( "", "〈輸入錯誤〉", preedittext)
    return
  end

-----------------------------

  ::nmnd_label::

  -- local nm, nd, nd_suffix = string.match(input, env.prefix_s .. "(%d%d?)m(%d%d?)(d?)$")
  -- if not nm then nm, nd =  string.match(input, env.prefix .. "m(%d%d?)d(%d%d?)$") end
  if nm and tonumber(nm) < 13 and tonumber(nd) < 32 then
    local preedittext = env.prefix .. " " .. nm .. "M " .. nd .. string.upper(nd_suffix) .. "\t 【自訂日期：○月○日】"
    -- local nm = tonumber(nm) == 0 and "01" or nm  -- 「0」校正，置後於「preedittext」，才不會錯誤顯示。
    -- local nd = tonumber(nd) == 0 and "01" or nd  -- 「0」校正，置後於「preedittext」，才不會錯誤顯示。
    yield_c( nm .. "月" .. nd .. "日", "〔日期〕", preedittext)
    yield_c( " " .. nm .. " 月 " .. nd .. " 日 ", "〔*日期*〕", preedittext)
    yield_c( fullshape_number(nm) .. "月" .. fullshape_number(nd) .. "日", "〔全形〕", preedittext)
    yield_c( ch_m_date(nm) .. "月" .. ch_d_date(nd) .. "日", "〔小寫中文〕", preedittext)
    yield_c( chb_m_date(nm) .. "月" .. chb_d_date(nd) .. "日", "〔大寫中文〕", preedittext)
    yield_c( jp_m_date(nm) .. jp_d_date(nd), "〔日文〕", preedittext)
    yield_c( eng1_m_date(nm) .. " " .. eng2_d_date(nd), "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(nm) .. " " .. eng3_d_date(nd), "〔英文美式〕", preedittext)
    yield_c( eng2_m_date(nm) .. " " .. eng3_d_date(nd), "〔英文美式〕", preedittext)
    yield_c( eng3_m_date(nm) .. " " .. eng4_d_date(nd), "〔英文美式〕", preedittext)
    yield_c( eng1_m_date(nm) .. " the " .. eng1_d_date(nd), "〔英文美式〕", preedittext)
    yield_c( eng2_d_date(nd) .. " " .. eng1_m_date(nm), "〔英文英式〕", preedittext)
    yield_c( eng3_d_date(nd) .. " " .. eng1_m_date(nm), "〔英文英式〕", preedittext)
    yield_c( eng2_d_date(nd) .. " " .. eng2_m_date(nm), "〔英文英式〕", preedittext)
    yield_c( "the " .. eng1_d_date(nd) .. " of " .. eng1_m_date(nm), "〔英文英式〕", preedittext)
    yield_c( "The " .. eng1_d_date(nd) .. " of " .. eng1_m_date(nm), "〔英文英式〕", preedittext)
    return
  elseif nm then  -- 月份大於12或日期大於31跳掉（後改為顯示〈輸入錯誤〉）
    local preedittext = env.prefix .. " " .. nm .. "M " .. nd .. string.upper(nd_suffix) .. "\t 【自訂日期：○月○日】"
    yield_c( "", "〈輸入錯誤〉", preedittext)
    return
  end

-----------------------------
-----------------------------

  ::paren_left_q_label::

  --- 補以下開頭括號缺漏（另改成如同啟始符）
  -- local paren_left_q = string.match(input, env.prefix_s .. "([q(][q(]?)$")
  if paren_left_q then
    local paren_left_q = string.gsub(paren_left_q, "q", "(")
    yield_c( "", "  ~ [ - . 0-9 ]+[ + - * / ^ ( ) ]…〔數字和計算機〕", env.prefix .. " " .. paren_left_q .. "\t 【數字和計算機】▶")
    -- yield_c( "", "  ~ [ - . 0-9 ]+〔數字〕")
    -- yield_c( "", "  ~ [ - . 0-9 ]+[ + - * / ^ ( ) ]…〔計算機〕")
    -- yield_c( "(", "〔括號〕")
    return
  end

  -- local num_preedit = string.match(input, env.prefix_s .. "([-rq(.%d]+)$") or ""
  -- local num_preedit = string.gsub(num_preedit, "r", "-")
  -- local num_preedit = string.gsub(num_preedit, "q", "(")
  -- local num_preedit = env.prefix .. " " .. num_preedit .. "\t 【數字】"  -- 數字格式開始

  ::neg_nf_label::

  --- 補以下開頭負號缺漏
  -- local neg_nf = string.match(input, env.prefix_s .. "[q(]?[q(]?[-r]$")
  if neg_nf then
    yield_c( "-", "〔一般 負號〕", num_preedit)
    yield_c( "−", "〔數學 負號〕", num_preedit)
    yield_c( "－", "〔全形 負號〕", num_preedit)
    yield_c( "⁻", "〔上標 負號〕", num_preedit)
    yield_c( "₋", "〔下標 負號〕", num_preedit)
    yield_c( "負", "〔中文 負號〕", num_preedit)
    yield_c( "槓", "〔軍中 負號〕", num_preedit)
    yield_c( "−⃝", "〔帶圈 負號〕", num_preedit)  -- ㊀ -⃝ −︎⃝ ⊝ ⊖
    yield_c( "⛔︎", "〔反白帶圈 負號〕", num_preedit)
    yield_c( "負⃝", "〔帶圈中文 負號〕", num_preedit)  -- 負︎⃝
    yield_c( "(負)", "〔帶括中文 負號〕", num_preedit)
    yield_c( "➖", "〔鍵帽 負號/加粗減號〕", num_preedit)  -- 〔加粗的減號〕
    -- yield_c( "⛔", "〔鍵帽 負號〕", num_preedit)  -- ➖
    yield_c( "-⃣", "〔鍵帽非標準 負號〕", num_preedit)  -- -⃣ −⃣  -- (非標準)(nstd.)
    yield_c( "⠤", "〔點字 computer/unified 負號〕", num_preedit)  -- (computer/unified)
    yield_c( "✂️", "〔表符密文 fixed 負號〕", num_preedit)  -- (固定)(fixed)
    yield_c( emoji_number("-")[1], "〔表符密文 random 負號〕", num_preedit)  -- (隨機)(random)
    return
  end

  ::dot_label::

  --- 補以下開頭小數點缺漏
  -- local dot = string.match(input, env.prefix_s .. "[q(]?[q(]?%.$")
  if dot then
    yield_c( ".", "〔一般 小數點〕", num_preedit)
    yield_c( "．", "〔全形點〕", num_preedit)
    yield_c( "⋅", "〔上標 小數點〕", num_preedit)
    yield_c( "點", "〔中文 小數點〕", num_preedit)
    -- yield_c( "點", "〔軍中 小數點〕", num_preedit)
    -- yield_c( "．", "〔鍵帽 小數點〕", num_preedit)  -- "."
    yield_c( ".⃣", "〔鍵帽非標準 小數點〕", num_preedit)  -- (非標準)(nstd.)
    yield_c( "⠨", "〔點字 computer 小數點〕", num_preedit)  -- (computer)
    yield_c( "⠲", "〔點字 unified 小數點〕", num_preedit)  -- (unified)
    yield_c( "⚡️", "〔表符密文 fixed 小數點〕", num_preedit)  -- (固定)(fixed)
    yield_c( emoji_number(".")[1], "〔表符密文 random 小數點〕", num_preedit)  -- (隨機)(random)
    yield_c( "٫", "〔阿拉伯文 小數點〕", num_preedit)
    return
  end

  ::neg_nf_dot_label::

  --- 補以下開頭負號+小數點缺漏
  -- local neg_nf_dot = string.match(input, env.prefix_s .. "[q(]?[q(]?[-r]%.$")
  if neg_nf_dot then
    yield_c( "-0.", "〔一般〕", num_preedit)
    yield_c( ",", "〔千分位〕", num_preedit)
    yield_c( "-0.000000E+00", "〔科學計數〕", num_preedit)
    yield_c( "-0.000000e+00", "〔科學計數〕", num_preedit)
    yield_c( "−𝟎.", "〔數學粗體〕", num_preedit)
    yield_c( "−𝟘.", "〔數學空心〕", num_preedit)
    yield_c( "－０.", "〔全形〕", num_preedit)
    yield_c( "⁻⁰⋅", "〔上標〕", num_preedit)
    yield_c( "₋₀.", "〔下標〕", num_preedit)
    yield_c( "負〇點", "〔小寫中文〕", num_preedit)
    yield_c( "負零點", "〔大寫中文〕", num_preedit)
    yield_c( "負點", "〔純中文〕", num_preedit)
    yield_c( "槓點", "〔軍中〕", num_preedit)
    yield_c( "➖．", "〔鍵帽〕", num_preedit)  -- "➖."
    yield_c( "-⃣.⃣", "〔鍵帽非標準〕", num_preedit)  -- (非標準)(nstd.)
    yield_c( "⠤⠨", "〔點字 computer〕", num_preedit)  -- (computer)
    yield_c( "⠤⠲", "〔點字 unified〕", num_preedit)  -- (unified)
    yield_c( "✂️⚡️", "〔表符密文 fixed〕", num_preedit)  -- (固定)(fixed)
    yield_c( emoji_number("-.")[1], "〔表符密文 random〕", num_preedit)  -- (隨機)(random)
    return
  end

  ::double_error_label::

  --- 輸入「數字」格式錯誤之提示（於「數字」模式，「計算機」另行處理）
  -- local double_dot_error = string.match(input, env.prefix_s .. "[-rq(]?[-rq(]?%d*%.%d*%.%d*$")
  -- local double_neg_error = string.match(input, env.prefix_s .. "[q(]?[q(]?[-r][-r]+%d*$")
  -- local double_neg_bracket_error = string.match(input, env.prefix_s .. "[-r][q(]%d*$")
  if double_dot_error then
    yield_c( "" , "〔不能兩個小數點〕", num_preedit)  --字符過濾可能會過濾掉""整個選項。
    return
  elseif double_neg_error then
    yield_c( "" , "〔不能兩個負號〕", num_preedit)
    return
  elseif double_neg_bracket_error then
    yield_c( "" , "〔不能負號接括號〕", num_preedit)
    return
  end

  ::numberout_label::

  -- local numberout = string.match(input, env.prefix .. "/?(%d+)$")
  -- local neg_n, dot0 ,numberout, dot1, afterdot = string.match(input, env.prefix_s .. "([q(]?[q(]?[-r]?)(%.?)(%d+)(%.?)(%d*)$")
  if tonumber(numberout) ~= nil then
    local neg_n = string.gsub(neg_n, "r", "-")  --配合計算機算符
    local neg_n = string.gsub(neg_n, "[q(]", "")  --配合計算機算符

    if dot0 ~= "" and dot1 ~= "" then
      yield_c( "" , "〔不能兩個小數點〕", num_preedit)  --字符過濾可能會過濾掉""整個選項。
      return
    elseif dot0 ~= "" then
      afterdot = numberout
      dot1 = dot0
      numberout = "0"
    end

    -- --- 下方遮屏，因後面內容直接用函數轉換負號。
    -- local neg_n_m = string.gsub(neg_n, "-", "−")
    -- local neg_n_f = string.gsub(neg_n, "-", "－")
    -- local neg_n_h = string.gsub(neg_n, "-", "⁻")
    -- local neg_n_l = string.gsub(neg_n, "-", "₋")
    -- local neg_n_c = string.gsub(neg_n, "-", "負")  -- 下方尚有用到，移至下方。
    -- local neg_n_s = string.gsub(neg_n, "-", "槓")
    -- local neg_n_q = string.gsub(neg_n, "-", "−⃝")  -- ㊀ -⃝ −︎⃝ ⊝ ⊖
    -- local neg_n_a = string.gsub(neg_n, "-", "⛔︎")
    -- local neg_n_z = string.gsub(neg_n, "-", "負⃝")  -- 負︎⃝
    -- local neg_n_p = string.gsub(neg_n, "-", "(負)")
    -- local neg_n_k = string.gsub(neg_n, "-", "➖")  -- ⛔
    -- local neg_n_k_ns = string.gsub(neg_n, "-", "-⃣")  -- -⃣ −⃣
    -- local neg_n_b = string.gsub(neg_n, "-", "⠤")
    -- local neg_n_e = string.gsub(neg_n, "-", "✂️")

  -- if numberout ~= nil and tonumber(nn) ~= nil then
    -- local nn = string.sub(numberout, 1)
    --[[ 用 yield 產生一個候選項
    候選項的構造函數是 Candidate，它有五個參數：
    - type: 字符串，表示候選項的類型（可隨意取）
    - start: 候選項對應的輸入串的起始位置
    - _end:  候選項對應的輸入串的結束位置
    - text:  候選項的文本
    - comment: 候選項的注釋
    --]]
    local ng_n_d1_a = neg_n .. numberout .. dot1 .. afterdot
    local d1_a = dot1 .. afterdot

    yield_c( ng_n_d1_a , "〔一般〕", num_preedit)

    -- if string.len(numberout) < 4 or neg_n ~= "" then
    if string.len(numberout) < 4 then
      yield_c( "," , "〔千分位〕", num_preedit)
    else
      -- local k = string.sub(numberout, 1, -1) -- 取參數
      local result = formatnumberthousands(numberout) --- 調用算法
      yield_c( neg_n .. result .. dot1 .. afterdot , "〔千分位〕", num_preedit)
    end

    yield_c( string.format("%E", ng_n_d1_a ), "〔科學計數〕", num_preedit)
    yield_c( string.format("%e", ng_n_d1_a ), "〔科學計數〕", num_preedit)
    -- if neg_n == "" then
    --   yield_c( math1_number(numberout) .. dot1 .. math1_number(afterdot), "〔數學粗體數字〕", num_preedit)
    --   yield_c( math2_number(numberout) .. dot1 .. math2_number(afterdot), "〔數學空心數字〕", num_preedit)
    -- elseif neg_n ~= "" then
    --   yield_c( neg_n .. " " .. math1_number(numberout) .. dot1 .. math1_number(afterdot), "〔數學粗體數字〕", num_preedit)
    --   yield_c( neg_n .. " " .. math2_number(numberout) .. dot1 .. math2_number(afterdot), "〔數學空心數字〕", num_preedit)
    -- end
    yield_c( fullshape_number(ng_n_d1_a), "〔全形〕", num_preedit)  -- neg_n_f
    yield_c( mm_number(ng_n_d1_a), "〔等寬體〕", num_preedit)  -- neg_n_m
    yield_c( math2_number(ng_n_d1_a), "〔雙線體〕", num_preedit)  -- neg_n_m
    yield_c( math1_number(ng_n_d1_a), "〔粗體〕", num_preedit)  -- neg_n_m
    yield_c( mss_number(ng_n_d1_a), "〔無襯線體〕", num_preedit)  -- neg_n_m
    yield_c( mssb_number(ng_n_d1_a), "〔無襯線粗體〕", num_preedit)  -- neg_n_m
    yield_c( little1_number(ng_n_d1_a), "〔上標〕", num_preedit)  -- neg_n_h
    yield_c( little2_number(ng_n_d1_a), "〔下標〕", num_preedit)  -- neg_n_l
    --- 超過「1000垓」則不顯示中文數字
    if string.len(numberout) < 25 then
      local neg_n_c = string.gsub(neg_n, "-", "負")
      yield_c( neg_n_c .. read_number(confs[1], numberout) .. purech_number(d1_a), confs[1].comment, num_preedit)
      yield_c( neg_n_c .. read_number_bank(confs[2], numberout) .. purebigch_number(d1_a), confs[2].comment, num_preedit)
    else
      yield_c( "〇" , "（超過 1000垓/24位 計算限制）" .. confs[1].comment, num_preedit)
      yield_c( "零" , "（超過 1000垓/24位 計算限制）" .. confs[2].comment, num_preedit)
    end

    if dot1 == "" then
      local ng_n = neg_n .. numberout

      -- --- 超過「1000垓」則不顯示中文數字
      -- if string.len(numberout) < 25 then
      --   -- for _, conf in ipairs(confs) do
      --   --   local r = read_number(conf, nn)
      --   --   yield_c( r, conf.comment)
      --   -- end
      --   yield_c( neg_n_c .. read_number(confs[1], nn), confs[1].comment)
      --   yield_c( neg_n_c .. read_number_bank(confs[2], nn), confs[2].comment)
      -- -- else
      -- --   yield_c( "超過位數", confs[1].comment)
      -- --   yield_c( "超過位數", confs[2].comment)
      -- end

      if string.len(numberout) < 2 then  -- 避免被去重！
        yield_c( "元整", "〔純中文〕(repeated⚠️)", num_preedit)  -- 〔純中文數字〕
      else
        yield_c( purech_number(ng_n), "〔純中文〕", num_preedit)  -- neg_n_c
      end
      if not string.match(ng_n, "[01279-]") then  -- 避免被去重！
        yield_c( military_number(ng_n) .. "⚠", "〔軍中〕(repeated⚠️)", num_preedit)  -- neg_n_s
      else
        yield_c( military_number(ng_n), "〔軍中〕", num_preedit)  -- neg_n_s
      end

      yield_c( circled1_number(ng_n), "〔帶圈〕", num_preedit)  -- neg_n_q
      yield_c( circled2_number(ng_n), "〔帶圈無襯線〕", num_preedit)  -- neg_n_q
      yield_c( circled3_number(ng_n), "〔反白帶圈〕", num_preedit)  -- neg_n_a
      yield_c( circled4_number(ng_n), "〔反白帶圈無襯線〕", num_preedit)  -- neg_n_a
      yield_c( circled5_number(ng_n), "〔帶圈中文〕", num_preedit)  -- neg_n_z
      yield_c( paren_number(ng_n), "〔帶括中文〕", num_preedit)  -- neg_n_p

      yield_c( keycap_number(ng_n), "〔鍵帽〕", num_preedit)  -- neg_n_k
      yield_c( keycap_ns_number(ng_n), "〔鍵帽非標準〕", num_preedit)  -- neg_n_k_ns  -- (非標準)(nstd.)
      yield_c( braille_c_number(ng_n), "〔點字 computer〕", num_preedit)  -- neg_n_b  -- (computer)
      -- yield_c( neg_n_b .. "⠼" .. braille_c_number(numberout), "〔點字(一般)〕", num_preedit)
      yield_c( braille_u_number(ng_n), "〔點字 unified〕", num_preedit)  -- neg_n_b .. "⠼"  -- (unified)
      yield_c( emoji_number(ng_n)[2], "〔表符密文 fixed〕", num_preedit)  -- neg_n_e  -- (固定)(fixed)
      yield_c( emoji_number(ng_n)[1], "〔表符密文 random〕", num_preedit)  -- neg_n_e  -- (隨機)(random)
      if neg_n == "" then
        yield_c( arabic_indic_number(numberout), "〔阿拉伯文〕", num_preedit)
        yield_c( extended_arabic_indic_number(numberout), "〔東阿拉伯文〕", num_preedit)
        yield_c( devanagari_number(numberout), "〔天城文〕", num_preedit)

        local tonumber_n = tonumber(numberout)
        -- if tonumber_n == 1 or tonumber_n == 0 then
        --   yield_c( string.sub(numberout, -1), "〔二進位〕", num_preedit)
        if tonumber_n < 2 then
          yield_c( numberout .. "⚠", "〔二進位〕(repeated⚠️)", num_preedit)
        --- 浮點精度關係，二進制轉換運算中：
        --- math.floor 極限是小數點後15位(小於16位，1.9999999999999999)
        --- math.fmod 極限是小數點後13位(小於14位，1.99999999999999，14位開頭為偶數時除2是正確的，奇數則不正確)
        elseif string.len(numberout) < 14 then
        --- （以下還是有錯誤！）等於大於9999999999999999（16位-1），lua中幾個轉換函數都會出錯，運算會不正確
        -- elseif tonumber(numberout) < 9999999999999999 then
        -- elseif string.len(numberout) < 16 then
          yield_c( Dec2bin(numberout), "〔二進位〕", num_preedit)
        else
          yield_c( "bin", "（超過 14位 會有誤）〔二進位〕", num_preedit)
          -- yield_c( "%b", "（數值超過 14位 可能會不正確）〔二進位〕", num_preedit)
          -- yield_c( "", "（數值超過 16位-1 會不正確）〔二進位〕", num_preedit)
        end
        --- 整數庫限制：最大的64位元整數超過64位等同十進制2^63，超過則報錯，極限2^63-1，超過設定不顯示
        -- if tonumber(numberout) < 9223372036854775808 then
        -- if tonumber_n < 9223372036854775808 then
        -- if string.len(numberout) < 19 then
        local less_2p63 = tonumber_n < 9223372036854775808
        if tonumber_n < 8 then
          yield_c( numberout .. "⚠ ", "〔八進位〕(repeated⚠️)", num_preedit)
        elseif less_2p63 then
          yield_c( string.format("%o",numberout), "〔八進位〕", num_preedit)
        else
          yield_c( "oct", "（超過 2⁶³-1 報錯）〔八進位〕", num_preedit)
        end
        if tonumber_n < 16 then
          yield_c( numberout .. "⚠  ", "〔十六進位〕(repeated⚠️)", num_preedit)
        elseif less_2p63 then
          yield_c( string.format("%X",numberout), "〔十六進位〕", num_preedit)
          yield_c( string.format("%x",numberout), "〔十六進位〕", num_preedit)
        else
          yield_c( "Hex", "（超過 2⁶³-1 報錯）〔十六進位〕", num_preedit)
          yield_c( "hex", "（超過 2⁶³-1 報錯）〔十六進位〕", num_preedit)
        end
        return  -- 數字選字單最後了。
      end

    elseif dot0 ~= "" then
      local ng_d1_a = neg_n .. dot1 .. afterdot
      yield_c( purech_number(ng_d1_a), "〔純中文〕", num_preedit)  -- neg_n_c
      if not string.match(ng_d1_a, "[01279-]") then  -- 避免被去重！
        yield_c( military_number(ng_d1_a) .. "⚠", "〔軍中〕(repeated⚠️)", num_preedit)  -- neg_n_s
      else
        yield_c( military_number(ng_d1_a), "〔軍中〕", num_preedit)  -- neg_n_s
      end
      yield_c( keycap_number(ng_d1_a), "〔鍵帽〕", num_preedit)  -- neg_n_k
      yield_c( keycap_ns_number(ng_d1_a), "〔鍵帽非標準〕", num_preedit)  -- neg_n_k_ns  -- (非標準)(nstd.)
      yield_c( braille_c_number(ng_d1_a), "〔點字 computer〕", num_preedit)  -- neg_n_b  -- (computer)
      -- yield_c( neg_n_b .. "⠼" .. braille_c_number(dot1 .. afterdot), "〔點字(一般)〕", num_preedit)
      yield_c( braille_u_number(ng_d1_a), "〔點字 unified〕", num_preedit)  -- neg_n_b .. "⠼"  -- (unified)
      yield_c( emoji_number(ng_d1_a)[2], "〔表符密文 fixed〕", num_preedit)  -- neg_n_e  -- (固定)(fixed)
      yield_c( emoji_number(ng_d1_a)[1], "〔表符密文 random〕", num_preedit)  -- neg_n_e  -- (隨機)(random)
      if neg_n == "" then
        -- local d1_a = dot1 .. afterdot  -- 前方已有相同！
        yield_c( "٠" .. arabic_indic_number(d1_a), "〔阿拉伯文〕", num_preedit)  -- 補零："٠" == 0
        yield_c( "۰" .. extended_arabic_indic_number(d1_a), "〔東阿拉伯文〕", num_preedit)  -- 補零："٠" == 0
      end
      return  -- 數字選字單最後了。
    elseif dot0 == "" and dot1 ~= "" then
      -- local ng_n_d1_a = neg_n .. numberout .. dot1 .. afterdot  -- 前方已有相同！
      if string.len(numberout) < 2 then  -- 避免被去重！
        yield_c( "元整", "〔純中文〕(repeated⚠️)", num_preedit)
      else
        yield_c( purech_number(ng_n_d1_a), "〔純中文〕", num_preedit)  -- neg_n_c
      end
      if not string.match(ng_n_d1_a, "[01279-]") then  -- 避免被去重！
        yield_c( military_number(ng_n_d1_a) .. "⚠", "〔軍中〕(repeated⚠️)", num_preedit)  -- neg_n_s
      else
        yield_c( military_number(ng_n_d1_a), "〔軍中〕", num_preedit)  -- neg_n_s
      end
      yield_c( keycap_number(ng_n_d1_a), "〔鍵帽〕", num_preedit)  -- neg_n_k
      yield_c( keycap_ns_number(ng_n_d1_a), "〔鍵帽非標準〕", num_preedit)  -- neg_n_k_ns  -- (非標準)(nstd.)
      yield_c( braille_c_number(ng_n_d1_a), "〔點字 computer〕", num_preedit)  -- neg_n_b  -- (computer)
      -- yield_c( neg_n_b .. "⠼" .. braille_c_number(numberout .. dot1 .. afterdot), "〔點字(一般)〕", num_preedit)
      yield_c( braille_u_number(ng_n_d1_a), "〔點字 unified〕", num_preedit)  -- neg_n_b .. "⠼"  -- (unified)
      yield_c( emoji_number(ng_n_d1_a)[2], "〔表符密文 fixed〕", num_preedit)  -- neg_n_e  -- (固定)(fixed)
      yield_c( emoji_number(ng_n_d1_a)[1], "〔表符密文 random〕", num_preedit)  -- neg_n_e  -- (隨機)(random)
      if neg_n == "" then
        local n_d1_a = numberout .. dot1 .. afterdot
        yield_c( arabic_indic_number(n_d1_a), "〔阿拉伯文〕", num_preedit)
        yield_c( extended_arabic_indic_number(n_d1_a), "〔東阿拉伯文〕", num_preedit)
      end
      return  -- 數字選字單最後了。
    end

    return
  end

  -- local num_preedit = nil  -- 數字格式結束，清空 num_preedit 記憶

-----------------------------

  ::cal_input_label::

  --- 計算機
  -- local cal_input = string.match(input, env.prefix_s .. "([q(]?[q(]?[-r]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*)$")
  if cal_input then
    local cal_input = string.gsub(cal_input, "a", "+")
    local cal_input = string.gsub(cal_input, "s", "^")
    local cal_input = string.gsub(cal_input, "r", "-")
    local cal_input = string.gsub(cal_input, "v", "/")
    local cal_input = string.gsub(cal_input, "x", "*")
    local cal_input = string.gsub(cal_input, "q", "(")
    local cal_input = string.gsub(cal_input, "w", ")")
    local input_exp = string.gsub(cal_input, "^0+(%d)", "%1")
    local input_exp = string.gsub(input_exp, "([-+*/^()])0+(%d)", "%1%2")
    --會出 Bug -- local input_exp = string.gsub(input_exp, "(%d*%.%d*0)$", function(n) return string.format("%g",n) end)
    --會出 Bug -- local input_exp = string.gsub(input_exp, "(%d*%.%d*0)([-+*/^()])", function(n, opr) return string.format("%g",n) .. opr end)
    local input_exp = string.gsub(input_exp, "(%d*%.%d*0)$", function(n) return string.gsub(n,"0+$", "") end)  --去除小數點後末尾0
    local input_exp = string.gsub(input_exp, "(%d*%.%d*0)([-+*/^()])", function(n, opr) return string.gsub(n,"0+$", "") .. opr end)  --去除小數點後末尾0
    local input_exp = string.gsub(input_exp, "^%.", "0.")
    local input_exp = string.gsub(input_exp, "%.%$", "")
    local input_exp = string.gsub(input_exp, "%.([-+*/^()])", "%1")
    local input_exp = string.gsub(input_exp, "([-+*/^()])%.", "%10.")
    local cal_preedit = string.gsub(cal_input, "([-+*/^()])", " %1 ")

    local cal_output = simple_calculator(input_exp)[1]
    local output_exp = simple_calculator(input_exp)[2]
    local s_output = simple_calculator(input_exp)[3]

    local preedittext = env.prefix .. " " .. cal_preedit .. "\t 【計算機】"
    if string.sub(cal_output, 1,1) == "E" or string.sub(cal_output, 1,1) == "W" then
      yield_c( "", cal_output .. "〔結果〕", preedittext)  -- yield(cc_out_error)
      yield_c( s_output, "〔 Waring 結果〕", preedittext)  -- yield(cc_out_shadow)
      yield_c( output_exp .. "=" .. s_output, "〔 Waring 規格化算式〕", preedittext)  -- yield(cc_exp_error)
    else
      yield_c( cal_output, "〔結果〕", preedittext)  -- yield(cc_out)
      -- if s_output ~= "" then
      --   yield_c( s_output, "〔 Waring 結果〕", preedittext)  -- yield(cc_out_shadow)
      -- end
      yield_c( output_exp .. "=" .. cal_output, "〔規格化算式〕", preedittext)  -- yield(cc_exp)
      -- yield_c( input_exp .. "=" .. cal_output, "〔規格化算式〕", preedittext)  -- yield(cc_exp)
    end
    -- if s_output ~= "" then
    --   yield_c( s_output, "〔 Waring 結果〕", preedittext)  -- yield(cc_out_shadow)
    -- end
    yield_c( "", "※  會有浮點數誤差和錯誤；括號限兩層三堆；14位數限制", preedittext)  -- yield(cc_statement)
    -- yield_c( "", "※  會有浮點數誤差和錯誤；括號限兩層；14位數限制", preedittext)
    return
  end

-----------------------------
-----------------------------

  -- -- 測試空白不上屏在 translator 中直接處理！
  -- -- local engine = env.engine
  -- -- local context = engine.context
  -- -- local kkk = string.match(o_input, env.prefix .. "")
  -- -- local engine = env.engine
  -- -- local context = engine.context
  -- -- local o_input = context.input
  -- local kkk = string.match(input, "( )$")
  -- -- local page_size = engine.schema.page_size
  -- if kkk ~= nil then --and context:is_composing()
  --   -- local s_orig = context:get_commit_text()
  --   -- local o_input = context.input
  --   -- engine:commit_text(s_orig .. "a")
  --   -- context:clear()
  --   -- yield_c( "nnnnnm", "〔千分位數字〕")
  --   return 1 -- kAccepted
  -- end

end



return {init = init, func = translate}