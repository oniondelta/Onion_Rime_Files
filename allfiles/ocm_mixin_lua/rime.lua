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
--      - lua_translator@t_translator             --（引lua資料夾）「`」開頭打出時間日期
--      - lua_translator@t2_translator            --（引lua資料夾）「'/」開頭打出時間日期
--      - lua_translator@date_translator          --（引lua資料夾）（liur）「``」開頭打出時間日期
--      - lua_translator@mytranslator             --（關）（有缺函數，參考勿用，暫關閉）
--      - lua_translator@instruction_dbpmf        --（引lua資料夾）選項中顯示洋蔥雙拼各種說明
--      - lua_translator@instruction_grave_bpmf   --（引lua資料夾）選項中顯示洋蔥注音各種說明
--      - lua_translator@instruction_ocm          --（引lua資料夾）選項中顯示洋蔥蝦米各種說明
--      - lua_translator@email_url_translator     --（引lua資料夾）輸入email、網址
--      - lua_translator@email_urlw_translator    --（引lua資料夾）輸入email、網址（多了www.）
--
--
--      《 ＊ 以下「濾鏡」注意在 filters 中的順序，關係到作用效果 》
--      - lua_filter@charset_cjk_filter           --（引lua資料夾）遮屏含 CJK 擴展漢字的候選項
--      - lua_filter@charset_cjk_filter_plus      --（引lua資料夾）（bopomo_onion_double） 遮屏含 CJK 擴展漢字的候選項，開關（only_cjk_filter）
--      - lua_filter@charset_comment_filter       --（引lua資料夾）候選項註釋其所屬字符集，如：CJK、ExtA
--      - lua_filter@single_char_filter           --（引lua資料夾）候選項重排序，使單字優先
--      - lua_filter@reverse_lookup_filter        --（關）依地球拼音為候選項加上帶調拼音的註釋
--      - lua_filter@myfilter                     --（關）把 charset_comment_filter 和 reverse_lookup_filter 註釋串在一起，如：CJK(hǎo)
--
--      - lua_filter@charset_filter2              --（引lua資料夾）（ocm_onionmix）（手機全方案會用到） 遮屏選含「᰼᰼」候選項
--      - lua_filter@comment_filter_plus          --（引lua資料夾）（Mount_ocm） 遮屏提示碼，開關（simplify_comment）（遇到「'/」不遮屏）。
--      - lua_filter@symbols_mark_filter          --（關，但 mix_cf2_cfp_smf_filter 有用到某元件，部分開啟） 候選項註釋符號、音標等屬性之提示碼(comment)（用 opencc 可實現，但無法合併其他提示碼(comment)，改用 Lua 來實現）
--      - lua_filter@missing_mark_filter          --（關） 補上標點符號因直上和 opencc 衝突沒附註之選項
--      - lua_filter@array30_comment_filter       --（關） 遮屏提示碼，開關（simplify_comment）（遇到「`」不遮屏）
--      - lua_filter@array30_nil_filter           --（引lua資料夾）（onion-array30） 行列30空碼'⎔'轉成不輸出任何符號，符合原生。後來移至「=」「=」反查用。
--      - lua_filter@array30_spaceup_filter       --（關） 行列30開關一二碼按空格後，是否直上或可能有選單。
--      - lua_filter@en_sort_filter               --（引lua資料夾）（easy_en_super和其掛接）如同英漢字典一樣排序，候選項重新排序。開關（en_sort）
--
--      - ＊合併兩個以上函數：
--      - lua_filter@mix30_nil_comment_filter     --（關） 合併 array30_nil_filter 和 array30_comment_filter，兩個 lua filter 太耗效能。
--      - lua_filter@mix30_nil_comment_up_filter  --（引lua資料夾）（onion-array30） 合併 array30_nil_filter 和 array30_comment_filter 和 array30_spaceup_filter，三個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_miss_filter          --（引lua資料夾）（bopomo_onionplus 和 bo_mixin 全系列） 合併 charset_filter2 和 missing_mark_filter，兩個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_cfp_filter           --（引lua資料夾）（dif1） 合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_cfp_smf_filter       --（引lua資料夾）（ocm_mixin） 合併 charset_filter2 和 comment_filter_plus 和 symbols_mark_filter，三個 lua filter 太耗效能。
--
--
--      《 ＊ 以下「處理」注意在 processors 中的順序，基本放在最前面 》
--      - lua_processor@endspace                  --（關） （hangeul 和 hangeul2set） 韓語（非英語等）空格鍵後添加" "（該方式無法記錄到用戶詞典，故使用原生程式另外方式達成該項功能）
--      - lua_processor@ascii_punct_change        --（引lua資料夾）（bopomo_onionplus_2和3） 注音非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
--      - lua_processor@array30up                 --（關） 行列30三四碼字按空格直接上屏
--      - lua_processor@array30up_zy              --（關） 行列30注音反查 Return 和 space 上屏修正
--
--      = 以下針對「編碼有用到空白鍵」方案，如：注音一聲，去除空白上屏產生莫名之空格 =
--      - lua_processor@s2r_ss                    --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只有開頭 ^'/ 才作用，比下條目更精簡，少了 is_composing 限定）
--      - lua_processor@s2r_s                     --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只有開頭 ^'/ 才作用）
--      - lua_processor@s2r                       --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin(1,2,4)和 plus 用）
--      - lua_processor@s2r_e_u                   --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只針對 email 和 url ）
--      - lua_processor@s2r_most                  --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin(1,2,4)和 plus 用，精簡寫法）
--      - lua_processor@s2r_mixin3                --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin3 (特殊正則)專用）
--      - lua_processor@mobile_bpmf               --（引lua資料夾）（手機注音專用） 使 email_url_translator 功能按空白都能直接上屏
--
--      - ＊合併兩個以上函數：
--      - lua_processor@array30up_mix             --（引lua資料夾）（onion-array30） 合併 array30up 和 array30up_zy，增進效能。
--      - lua_processor@mix_apc_s2rm              --（引lua資料夾）（bo_mixin 1、2、4；bopomo_onionplus） 注音掛接，合併 ascii_punct_change 和 s2r_most，增進效能。
--      - lua_processor@mix_apc_s2rm_3            --（引lua資料夾）（bo_mixin3） 注音掛接，合併 ascii_punct_change 和 s2r_mixin3，增進效能。
--      - lua_processor@mix_apc_pluss             --（引lua資料夾）（bopomo_onionplus_space） 以原 ascii_punct_change 增加功能，使初始空白可以直接上屏
--      ...




--[[
掛接備註：

如果 lua 資料夾檔案最後 return {table} ，掛接使用：
local 檔名 = require("檔名")
函數名 = 檔名.函數名

如果 lua 資料夾檔案最後 return 函數名 ，掛接使用：
函數名 = require("檔名")
--]]




--[[
--------------------------------------------
！！！！以下為 filter 掛接！！！！
--------------------------------------------
--]]


--- charset cjk filter 系列
-- charset_cjk_filter: 濾除含 CJK 擴展漢字的候選項
-- charset_comment_filter: 為候選項加上其所屬字符集的註釋
local charset_cjk = require("filter_charset_cjk")
charset_cjk_filter = charset_cjk.charset_cjk_filter
charset_comment_filter = charset_cjk.charset_comment_filter
--- charset_cjk_filter_plus （bopomo_onion_double）
-- 同上，將濾除含 CJK 擴展漢字的候選項，增加開關設置
charset_cjk_filter_plus = charset_cjk.charset_cjk_filter_plus


--- comment_filter_plus （Mount_ocm）
-- 去除後面編碼註釋
comment_filter_plus =  require("filter_comment_filter_plus")


--- array30_nil_filter （onion-array30）
-- 後來移至「=」「=」反查用。行列30空碼'⎔'轉成不輸出任何符號，符合原生
array30_nil_filter =  require("filter_array30_nil_filter")


--- mix_cf2_miss_filter （bopomo_onionplus 和 bo_mixin 全系列）
-- 合併 charset_filter2 和 missing_mark_filter，兩個 lua filter 太耗效能。
mix_cf2_miss_filter =  require("filter_mix_cf2_miss_filter")


--- mix_cf2_cfp_filter （dif1）
-- 合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
mix_cf2_cfp_filter =  require("filter_mix_cf2_cfp_filter")
mix30_nil_comment_up_filter =  require("filter_mix30_nil_comment_up_filter")


--- en_sort_filter （easy_en_super）
-- 如同英漢字典一樣排序，候選項重新排序。開關（en_sort）
en_sort_filter =  require("filter_en_sort_filter")


--- kr_hnc_1m_filter （hangeul_hnc）
-- 韓語遮屏只剩一個選項。開關（kr_1m）
kr_hnc_1m_filter =  require("filter_kr_hnc_1m_filter")


--- mix_cf2_cfp_smf_filter （ocm_mixin）
--- 沒用到 ocm_mixin 方案時，ReverseDb("build/symbols-mark.reverse.bin")會找不到。
-- mix_cf2_cfp_smf_filter = require("filter_mix_cf2_cfp_smf_filter") --無效
local filter_mix_cf2_cfp_smf_filter = require("filter_mix_cf2_cfp_smf_filter")
mix_cf2_cfp_smf_filter = filter_mix_cf2_cfp_smf_filter.mix_cf2_cfp_smf_filter


-- --- charset_filter2 （ocm_onionmix）（手機全方案會用到）
-- --- 把 opencc 轉換成「᰼」(或某個符號)，再用 lua 功能去除「᰼」
-- -- charset_filter2 = require("filter_charset_filter2")
-- local filter_charset_filter2 = require("filter_charset_filter2")
-- charset_filter2 = filter_charset_filter2.charset_filter2




--[[
--------------------------------------------
！！！！以下為 processor 掛接！！！！
--------------------------------------------
--]]


--- ascii_punct_change 改變標點符號 （bopomo_onionplus_2和3）
-- 於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
ascii_punct_change = require("processor_ascii_punct_change")


--- array30up_mix （onion-array30）
-- 合併 array30up 和 array30up_zy
-- 行列30三四碼字按空格直接上屏
-- 行列30注音反查 Return 和 space 上屏修正
array30up_mix = require("processor_array30up_mix")


--- mix_apc_s2rm 注音mixin 1_2_4 和 plus 專用 （bo_mixin 1、2、4；bopomo_onionplus）
-- 合併 ascii_punct_change 和 s2r_most，增進效能。
mix_apc_s2rm = require("processor_mix_apc_s2rm")


--- mix_apc_s2rm_3 注音mixin 3 （bo_mixin3）
-- 合併 ascii_punct_change 和 s2r_mixin3，增進效能。
mix_apc_s2rm_3 = require("processor_mix_apc_s2rm_3")


--- mix_apc_pluss （bopomo_onionplus_space）
-- 以原 ascii_punct_change 增加功能
-- 使初始空白可以直接上屏
-- 於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
mix_apc_pluss = require("processor_mix_apc_pluss")


-- --- kr_2set_0m （hangeul2set_zeromenu）
-- -- 韓語遮屏成零選項。
-- kr_2set_0m = require("processor_kr_2set_0m")




-- --- mobile_bpmf（手機注音用）
-- --- 使 email_url_translator 功能按空白都能直接上屏
-- mobile_bpmf = require("processor_mobile_bpmf")




--[[
--------------------------------------------
！！！！以下為 translator 掛接！！！！
--------------------------------------------
--]]


--- email_url_translator
-- 把 recognizer 正則輸入 email 使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
-- 把 recognizer 正則輸入網址使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
email_url_translator = require("translator_email_url_translator")


--- email_urlw_translator
-- 把 recognizer 正則輸入網址使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
-- 該項多加「www.」
email_urlw_translator = require("translator_email_urlw_translator")


--- instruction_grave_bpmf
-- 說明注音「`」開頭之符號集
instruction_grave_bpmf = require("translator_instruction_grave_bpmf")


--- instruction_dbpmf
-- 說明雙拼注音各種掛接
instruction_dbpmf = require("translator_instruction_dbpmf")


--- instruction_ocm
-- 說明蝦米各種掛接
instruction_ocm = require("translator_instruction_ocm")


--- t_translator 系列
local time_translator = require("translator_time_translator")
t_translator = time_translator.t_translator
t2_translator = time_translator.t2_translator



