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
--      - lua_translator@t_translator                --（關）「`」開頭打出時間日期
--      - lua_translator@t2_translator               --（關）「'/」開頭打出時間日期
--      - lua_translator@mf_translator               --（引lua資料夾）合併以上兩個時間日期translator。
--      - lua_translator@date_translator             --（引lua資料夾）（liur）「``」開頭打出時間日期
--      - lua_translator@mytranslator                --（關）（有缺函數，參考勿用，暫關閉）
--      - lua_translator@instruction_dbpmf           --（引lua資料夾）選項中顯示洋蔥雙拼各種說明
--      - lua_translator@instruction_grave_bpmf      --（引lua資料夾）選項中顯示洋蔥注音各種說明
--      - lua_translator@instruction_ocm             --（引lua資料夾）選項中顯示洋蔥蝦米各種說明
--      - lua_translator@email_url_translator        --（引lua資料夾）輸入email、網址（可多加www.）
--      - lua_translator@convert_japan_translator    --（關）（效能不佳）日文出羅馬字、全形羅馬字、半形片假名、全片假名、全平假名。
--      - lua_translator@p_convert_japan_translator  --（關）（效能不佳）同 convert_japan_translator，掛接方案用。
--      - lua_translator@lua_custom_phrase           --（引lua資料夾）取代原先 table_translator@custom_phrase。可多行，用\n\r。
--
--
--      《 ＊ 以下「濾鏡」注意在 filters 中的順序，關係到作用效果 》
--      - lua_filter@charset_cjk_filter              --（引lua資料夾）遮屏含 CJK 擴展漢字的候選項
--      - lua_filter@charset_cjk_filter_plus         --（引lua資料夾）（bopomo_onion_double） 遮屏含 CJK 擴展漢字的候選項，開關（only_cjk_filter）
--      - lua_filter@charset_comment_filter          --（引lua資料夾）候選項註釋其所屬字符集，如：CJK、ExtA
--      - lua_filter@single_char_filter              --（引lua資料夾）候選項重排序，使單字優先
--      - lua_filter@reverse_lookup_filter           --（關）依地球拼音為候選項加上帶調拼音的註釋
--      - lua_filter@myfilter                        --（關）把 charset_comment_filter 和 reverse_lookup_filter 註釋串在一起，如：CJK(hǎo)
--
--      - lua_filter@charset_filter2                 --（引lua資料夾）（ocm_onionmix）（手機全方案會用到） 遮屏選含「᰼᰼」候選項
--      - lua_filter@comment_filter_plus             --（引lua資料夾）（Mount_ocm） 遮屏提示碼，開關（simplify_comment）（遇到「'/」不遮屏）。
--      - lua_filter@symbols_mark_filter             --（關，但 mix_cf2_cfp_smf_filter 有用到某元件，部分開啟） 候選項註釋符號、音標等屬性之提示碼(comment)（用 opencc 可實現，但無法合併其他提示碼(comment)，改用 Lua 來實現）
--      - lua_filter@missing_mark_filter             --（關） 補上標點符號因直上和 opencc 衝突沒附註之選項
--      - lua_filter@array30_comment_filter          --（關） 遮屏提示碼，開關（simplify_comment）（遇到「`」不遮屏）
--      - lua_filter@array30_nil_filter              --（引lua資料夾）（onion-array30） 行列30空碼'⎔'轉成不輸出任何符號，符合原生。後來移至「=」「=」反查用。
--      - lua_filter@array30_spaceup_filter          --（關） 行列30開關一二碼按空格後，是否直上或可能有選單。
--      - lua_filter@en_sort_filter                  --（引lua資料夾）（easy_en_super和其掛接）如同英漢字典一樣排序，候選項重新排序。開關（en_sort）
--      - lua_filter@kr_hnc_1m_filter                --（引lua資料夾）（hangeul_hnc）韓語遮屏只剩一個選項。開關（kr_1m）
--      - lua_filter@convert_english_filter          --（引lua資料夾）easy 英文尾綴「;」或「;;」生成全大寫或首字母大寫。後來合併修改為掛接方案也可使用。
--      - lua_filter@p_convert_english_filter        --（關）同 convert_english_filter，掛接方案用。
--      - lua_filter@convert_japan_filter            --（引lua資料夾）日文出羅馬字、全形羅馬字、半形片假名、全片假名、全平假名。後來合併修改為掛接方案也可使用。
--      - lua_filter@p_convert_japan_filter          --（關）同 convert_japan_filter，掛接方案用。
--      - lua_filter@halfwidth_katakana_filter       --（關）（jpnin1）片假名後附加半形片假名。選單顯示太雜亂，故不用。
--      - lua_filter@lua_custom_phrase_filter        --（關）取代原先 table_translator@custom_phrase。接續掛接方案後，有 bug，上不了屏，改用 translator 實現。
--      - lua_filter@preedit_model_filter            --（關）（bo_mixin 全系列）切換 preedit 樣式。
--      - lua_filter@punct_preedit_revise_filter     --（引lua資料夾）（bopomo_onion_double 和 onion-array30）punct 下，附加 preedit 後面 prompt 缺漏之標示。另修正 ascii_punct 下，分號(;)和冒號(:)無法變半形問題。
--      - lua_filter@comment_filter_unicode          --（關）註釋 Unicode 編碼。
--      - lua_filter@comment_filter_debug            --（關）註釋 debug 訊息。
--
--      - ＊合併兩個以上函數：
--      - lua_filter@mix30_nil_comment_filter        --（關） 合併 array30_nil_filter 和 array30_comment_filter，兩個 lua filter 太耗效能。
--      - lua_filter@mix30_nil_comment_up_filter     --（引lua資料夾）（onion-array30） 合併 array30_nil_filter 和 array30_comment_filter 和 array30_spaceup_filter，三個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_miss_filter             --（引lua資料夾）（bopomo_onionplus 和 bo_mixin 全系列） 合併 charset_filter2 和 missing_mark_filter，兩個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_cfp_filter              --（引lua資料夾）（dif1） 合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_cfp_smf_filter          --（關）（ocm_mixin） 合併 charset_filter2 和 comment_filter_plus 和 symbols_mark_filter，三個 lua filter 太耗效能。
--      - lua_filter@ocm_mixin_filter                --（引lua資料夾）（ocm_mixin）同上條目，comment 附加改用 opencc 方式。
--      - lua_filter@comment_filter_unicode_debug    --（引lua資料夾）（注音plus、注音mixin、ocm全系列）合併 comment_filter_unicode 和 comment_filter_debug，註釋 Unicode 編碼 和 debug 訊息。
--
--
--      《 ＊ 以下「處理」注意在 processors 中的順序，基本放在最前面 》
--      - lua_processor@endspace                     --（關） （hangeul 和 hangeul2set） 韓語（非英語等）空格鍵後添加" "（該方式無法記錄到用戶詞典，故使用原生程式另外方式達成該項功能）
--      - lua_processor@ascii_punct_change           --（引lua資料夾）（bopomo_onionplus_2和3） 注音非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
--      - lua_processor@array30up                    --（關） 行列30三四碼字按空格直接上屏
--      - lua_processor@array30up_zy                 --（關） 行列30注音反查 Return 和 space 上屏修正
--      - lua_processor@p_open_files/p_run_files     --（關） （bopomo_onionplus_2）快捷鍵開啟檔案/程式/網站
--
--      = 以下針對「編碼有用到空白鍵」方案，如：注音一聲，去除空白上屏產生莫名之空格 =
--      - lua_processor@s2r_ss                       --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只有開頭 ^'/ 才作用，比下條目更精簡，少了 is_composing 限定）
--      - lua_processor@s2r_s                        --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只有開頭 ^'/ 才作用）
--      - lua_processor@s2r                          --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin(1,2,4)和 plus 用）
--      - lua_processor@s2r_e_u                      --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只針對 email 和 url ）
--      - lua_processor@s2r_most                     --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin(1,2,4)和 plus 用，精簡寫法）
--      - lua_processor@s2r_mixin3                   --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin3 (特殊正則)專用）
--      - lua_processor@mobile_bpmf                  --（引lua資料夾）（手機注音專用） 使 email_url_translator 功能按空白都能直接上屏
--      - lua_processor@kr_2set_0m_choice            --（引lua資料夾）（hangeul2set_zeromenu）韓語成零選項。開關（space_mode）、開關（kr_0m）
--      - lua_processor@kr_2set_0m                   --（關）（hangeul2set_zeromenu）韓語成零選項。開關（space_mode）
--      - lua_processor@zhuyin_space                 --（引lua資料夾）（Mount_ocm）補注音反查無法使用空白鍵和選字後跳掉之 bug。
--      - lua_processor@lua_tran_kp                  --（關）（bopomo_onion_double）使 lua 之 mf_translator 數字和計算機功能可用小鍵盤輸入。
--
--      - ＊合併兩個以上函數：
--      - lua_processor@array30up_mix                --（引lua資料夾）（onion-array30） 合併 array30up 和 array30up_zy，增進效能。
--      - lua_processor@mix_apc_s2rm_ltk             --（引lua資料夾）（bo_mixin 1、2、4；bopomo_onionplus） 合併 ascii_punct_change、s2r_most、lua_tran_kp，增進效能。
--      - lua_processor@mix_apc_s2rm_ltk_3           --（引lua資料夾）（bo_mixin3） 合併 ascii_punct_change、s2r_mixin3、lua_tran_kp，增進效能。
--      - lua_processor@mix_apc_ltk_pluss            --（引lua資料夾）（bopomo_onionplus_space） 以原 ascii_punct_change 增加功能，使初始空白可以直接上屏。
--      - lua_processor@mix_zhs_ltk                  --（引lua資料夾）（ocm_mixin、dif1、ocm_mix） 合併 zhuyin_space 和 lua_tran_kp。
--      - lua_processor@mix_kp_return                --（引lua資料夾）（bopomo_onion_double） 合併 lua_tran_kp 並增加 return 上屏模式切換。
--      ...




--[[
掛接備註：

如果 lua 資料夾檔案最後 return {table} ，掛接使用：
local 檔名 = require("檔名")
函數名 = 檔名.函數名

如果 lua 資料夾檔案最後 return 函數名 ，掛接使用：
函數名 = require("檔名")
--]]




-- --[[
-- 以下防 opencc 記憶體問題
-- 但開啟後 lua 的 opencc 函數無法正常作用
-- memory leak issue
-- --]]
-- -- bypass
-- Opencc=function(fs)
--   return  {
--     convert= function(self,text) return text end,
--     convert_text = function(self,text) return text end,
--     convert_word= function(self,text) return end,
--     random_convert_text = function(self,text) return text end,
--   }
-- end




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
comment_filter_plus = require("filter_comment_filter_plus")


--- comment_filter_unicode_debug （注音plus、注音mixin、ocm全系列）
-- 註釋 Unicode 編碼 和 debug 訊息
comment_filter_unicode = require("filter_comment_filter_unicode")
-- comment_filter_debug = require("filter_comment_filter_debug")
-- comment_filter_unicode_debug = require("filter_comment_filter_unicode_debug")


--- array30_nil_filter （onion-array30）
-- 後來移至「=」「=」反查用。行列30空碼'⎔'轉成不輸出任何符號，符合原生
array30_nil_filter = require("filter_array30_nil_filter")


--- mix_cf2_miss_filter （bopomo_onionplus 和 bo_mixin 全系列）
-- 合併 charset_filter2 和 missing_mark_filter，兩個 lua filter 太耗效能。
mix_cf2_miss_filter = require("filter_mix_cf2_miss_filter")


--- mix_cf2_cfp_filter （dif1）
-- 合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
mix_cf2_cfp_filter = require("filter_mix_cf2_cfp_filter")
mix30_nil_comment_up_filter = require("filter_mix30_nil_comment_up_filter")


--- preedit_model_filter （bo_mixin 全系列）
-- 切換 preedit 樣式
-- preedit_model_filter = require("filter_preedit_model_filter")
-- preedit_model_charset_filter2_filter = require("filter_preedit_model_charset_filter2_filter")


--- punct_preedit_revise_filter （bopomo_onion_double 和 onion-array30）
-- punct 下，附加 preedit 後面 prompt 缺漏之標示。
-- 另修正 ascii_punct 下，分號(;)和冒號(:)無法變半形問題。
punct_preedit_revise_filter = require("filter_punct_preedit_revise_filter")


--- en_sort_filter （easy_en_super）
-- 如同英漢字典一樣排序，候選項重新排序。開關（en_sort）
en_sort_filter = require("filter_en_sort_filter")


--- kr_hnc_1m_filter （hangeul_hnc）
-- 韓語遮屏只剩一個選項。開關（kr_1m）
kr_hnc_1m_filter = require("filter_kr_hnc_1m_filter")


-- --- mix_cf2_cfp_smf_filter （ocm_mixin）
-- -- 沒用到 ocm_mixin 方案時，ReverseDb("build/symbols-mark.reverse.bin")會找不到。
-- -- 故改用下條目 opencc 應用。
-- -- mix_cf2_cfp_smf_filter = require("filter_mix_cf2_cfp_smf_filter") --無效
-- local filter_mix_cf2_cfp_smf_filter = require("filter_mix_cf2_cfp_smf_filter")
-- mix_cf2_cfp_smf_filter = filter_mix_cf2_cfp_smf_filter.mix_cf2_cfp_smf_filter
-- mix_cf2_cfp_smf_filter = require("filter_mix_cf2_cfp_smf_filter")


--- ocm_mixin_filter （ocm_mixin）
-- 同上條目，但附加 comment 不用 ReverseDb 方式，改用新版 lua 的 opencc 引入方式。
-- local filter_ocm_mixin = require("filter_ocm_mixin")
-- ocm_mixin_filter = filter_ocm_mixin.ocm_mixin_filter
ocm_mixin_filter = require("filter_ocm_mixin")


--- charset_filter2 （ocm_onionmix）（手機全方案會用到）
-- 把 opencc 轉換成「᰼」(或某個符號)，再用 lua 功能去除「᰼」
-- charset_filter2 = require("filter_charset_filter2")
-- local filter_charset_filter2 = require("filter_charset_filter2")
-- charset_filter2 = filter_charset_filter2.charset_filter2
charset_filter2 = require("filter_charset_filter2")


--- 日文出羅馬字、全形羅馬字、半形片假名、全片假名、全平假名。
-- convert_japan_filter：主方案用。後來合併修改為掛接方案也可使用。
-- p_convert_japan_filter：掛接方案用，方案名稱：「japan」。
-- 用 filter 方式。
-- local c_j_filter = require("filter_convert_japan_filter")
-- convert_japan_filter = c_j_filter.convert_japan_filter
-- p_convert_japan_filter = c_j_filter.p_convert_japan_filter
convert_japan_filter = require("filter_convert_japan_filter")


--- easy 英文尾綴「;」或「;;」生成全大寫或首字母大寫。
-- convert_english_filter：主方案用。後來合併修改為掛接方案也可使用。
-- p_convert_english_filter：掛接方案用。
-- 用 filter 方式。
-- local c_e_filter = require("filter_convert_english_filter")
-- convert_english_filter = c_e_filter.convert_english_filter
-- p_convert_english_filter = c_e_filter.p_convert_english_filter
convert_english_filter = require("filter_convert_english_filter")


-- --- halfwidth_katakana_filter (jpnin1)
-- -- 片假名後附加半形片假名。
-- -- 選單顯示太雜亂，故不用。
-- -- 改用 convert_japan_translator 出半形片假名。
-- local filter_halfwidth_katakana_filter = require("filter_halfwidth_katakana_filter")
-- halfwidth_katakana_filter = filter_halfwidth_katakana_filter.halfwidth_katakana_filter
-- halfwidth_katakana_filter = require("filter_halfwidth_katakana_filter")


-- --- lua_custom_phrase_filter
-- -- 取代原先 table_translator@custom_phrase。
-- -- 可多行，用\n\r。
-- -- 接續掛接方案後，有 bug，上不了屏，改用 translator 實現。
-- lua_custom_phrase_filter = require("filter_lua_custom_phrase_filter")




--[[
--------------------------------------------
！！！！以下為 processor 掛接！！！！
--------------------------------------------
--]]


--- ascii_punct_change （bopomo_onionplus_2和3）
-- 改變標點符號
-- 於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
ascii_punct_change = require("processor_ascii_punct_change")


--- array30up_mix （onion-array30）
-- 合併 array30up 和 array30up_zy
-- 行列30三四碼字按空格直接上屏
-- 行列30注音反查 Return 和 space 上屏修正
array30up_mix = require("processor_array30up_mix")


--- mix_apc_s2rm_ltk （bo_mixin 1、2、4；bopomo_onionplus）
-- 合併 ascii_punct_change、s2r_most、lua_tran_kp，增進效能。
mix_apc_s2rm_ltk = require("processor_mix_apc_s2rm_ltk")


--- mix_apc_s2rm_ltk_3 （bo_mixin3）
-- 合併 ascii_punct_change、s2r_mixin3、lua_tran_kp，增進效能。
mix_apc_s2rm_ltk_3 = require("processor_mix_apc_s2rm_ltk_3")


--- mix_apc_ltk_pluss （bopomo_onionplus_space）
-- 以原 ascii_punct_change 增加功能
-- 使初始空白可以直接上屏
-- 於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
mix_apc_ltk_pluss = require("processor_mix_apc_ltk_pluss")


--- zhuyin_space （Mount_ocm）
-- 補注音反查無法使用空白鍵和選字後跳調之 bug。
zhuyin_space = require("processor_zhuyin_space")


-- --- lua_tran_kp （bopomo_onion_double）
-- -- 使 lua 之 mf_translator 數字和計算機功能可用小鍵盤輸入。
-- lua_tran_kp = require("processor_lua_tran_kp")


--- mix_kp_return （bopomo_onion_double）
-- 使 lua 之 mf_translator 數字和計算機功能可用小鍵盤輸入。
-- 使 return 上屏模式切換
mix_kp_return = require("processor_mix_kp_return")


--- mix_zhs_ltk （ocm_mixin、dif1、ocm_onionmix）
-- 合併 zhuyin_space 和 lua_tran_kp
mix_zhs_ltk = require("processor_mix_zhs_ltk")


--- kr_2set_0m_choice （hangeul2set_zeromenu）
-- 韓語成零選項。開關（space_mode）、開關（kr_0m）
kr_2set_0m_choice = require("processor_kr_2set_0m_choice")


-- --- kr_2set_0m （hangeul2set_zeromenu）
-- -- 韓語成零選項。開關（space_mode）
-- kr_2set_0m = require("processor_kr_2set_0m")


-- --- p_open_files （bopomo_onionplus_2）
-- -- 快捷鍵開啟檔案/程式/網站
-- -- p_open_files：英文字母開啟/p_run_files：上屏鍵開啟。
-- -- p_open_files = require("processor_p_open_files")
-- p_run_files = require("processor_p_run_files")




-- --- mobile_bpmf （手機注音用）
-- -- 使 email_url_translator 功能按空白都能直接上屏
-- mobile_bpmf = require("processor_mobile_bpmf")




--[[
--------------------------------------------
！！！！以下為 translator 掛接！！！！
--------------------------------------------
--]]


--- email_url_translator
-- 把 recognizer 正則輸入 email 使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
-- 把 recognizer 正則輸入網址使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
-- 可多加「www.」
email_url_translator = require("translator_email_url_translator")


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
-- 合併 t_translator 和 t2_translator 為 mf_translator。
-- t_translator = require("translator_time_translator")
-- t2_translator = require("translator_time2_translator")
mf_translator = require("translator_multifunction_translator")


--- lua_custom_phrase
-- 取代原先 table_translator@custom_phrase。
-- 可多行，用\n\r。
lua_custom_phrase = require("translator_lua_custom_phrase")


-- --- 日文出羅馬字、全形羅馬字、半形片假名、全片假名、全平假名。
-- -- （關）（效能不佳）用 translator 方式。
-- -- convert_japan_translator：主方案用。
-- -- p_convert_japan_translator：掛接方案用，方案名稱：「japan」。
-- local c_j_translator = require("translator_convert_japan_translator")
-- convert_japan_translator = c_j_translator.convert_japan_translator
-- p_convert_japan_translator = c_j_translator.p_convert_japan_translator



