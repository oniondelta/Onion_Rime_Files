
import os
import shutil
import time


#名稱(取出來較好變換)
sort_rime="sort_rime_bpx5"
rime_files="rime＜bpin1＞"
the_name="電腦RIME方案＜bpin1＞"


#※新增資料夾(多層目錄, 如前一層data資料夾不存在, 將自動新增)※
os.makedirs("./"+sort_rime+"/"+rime_files+"/opencc/", exist_ok=True)


#複製檔案(注音洋蔥純注音版)
shutil.copyfile("./rimefiles/essay-zh-hant-mc.txt", "./"+sort_rime+"/"+rime_files+"/essay-zh-hant-mc.txt")
shutil.copyfile("./rimefiles/bopomo_onion_phrase.txt", "./"+sort_rime+"/"+rime_files+"/bopomo_onion_phrase.txt")
shutil.copyfile("./rimefiles/bopomo_onion_symbols.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onion_symbols.yaml")
shutil.copyfile("./rimefiles/bopomo_onion.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onion.extended.dict.yaml")
shutil.copyfile("./rimefiles/bopomo_onion.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onion.schema.yaml")
shutil.copyfile("./rimefiles/cangjie5.dict.yaml", "./"+sort_rime+"/"+rime_files+"/cangjie5.dict.yaml")
shutil.copyfile("./rimefiles/cangjie5.schema.yaml", "./"+sort_rime+"/"+rime_files+"/cangjie5.schema.yaml")
shutil.copyfile("./rimefiles/terra_pinyin_onion_add.dict.yaml", "./"+sort_rime+"/"+rime_files+"/terra_pinyin_onion_add.dict.yaml")
shutil.copyfile("./rimefiles/terra_pinyin_onion.dict.yaml", "./"+sort_rime+"/"+rime_files+"/terra_pinyin_onion.dict.yaml")
shutil.copyfile("./rimefiles/mixin_bpmf.dict.yaml", "./"+sort_rime+"/"+rime_files+"/mixin_bpmf.dict.yaml")


#複製檔案(注音洋蔥plus版)
shutil.copyfile("./rimefiles/essay-jp-onion.txt", "./"+sort_rime+"/"+rime_files+"/essay-jp-onion.txt")
shutil.copyfile("./rimefiles/essay-kr-hanja.txt", "./"+sort_rime+"/"+rime_files+"/essay-kr-hanja.txt")
shutil.copyfile("./rimefiles/allbpm.dict.yaml", "./"+sort_rime+"/"+rime_files+"/allbpm.dict.yaml")
shutil.copyfile("./rimefiles/allbpm.schema.yaml", "./"+sort_rime+"/"+rime_files+"/allbpm.schema.yaml")
shutil.copyfile("./rimefiles/bopomo_onionplus_space.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onionplus_space.schema.yaml")
shutil.copyfile("./rimefiles/bopomo_onionplus_phrase.txt", "./"+sort_rime+"/"+rime_files+"/bopomo_onionplus_phrase.txt")
shutil.copyfile("./rimefiles/lua_custom_phrase.txt", "./"+sort_rime+"/"+rime_files+"/lua_custom_phrase.txt")
shutil.copyfile("./rimefiles/bopomo_onionplus.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onionplus.extended.dict.yaml")
shutil.copyfile("./rimefiles/bopomo_onionplus.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onionplus.schema.yaml")
shutil.copyfile("./rimefiles/cyrillic.dict.yaml", "./"+sort_rime+"/"+rime_files+"/cyrillic.dict.yaml")
shutil.copyfile("./rimefiles/cyrillic.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/cyrillic.extended.dict.yaml")
shutil.copyfile("./rimefiles/cyrillic.schema.yaml", "./"+sort_rime+"/"+rime_files+"/cyrillic.schema.yaml")
# shutil.copyfile("./rimefiles/easy_en_super.dict.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_super.dict.yaml")
# shutil.copyfile("./rimefiles/easy_en_super_original.dict.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_super_original.dict.yaml")
# shutil.copyfile("./rimefiles/easy_en_super.schema.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_super.schema.yaml")
shutil.copyfile("./rimefiles/easy_en_lcomment.dict.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_lcomment.dict.yaml")
shutil.copyfile("./rimefiles/easy_en_lcomment.schema.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_lcomment.schema.yaml")
shutil.copyfile("./rimefiles/easy_en_lower.dict.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_lower.dict.yaml")
shutil.copyfile("./rimefiles/easy_en_lower.schema.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_lower.schema.yaml")
shutil.copyfile("./rimefiles/easy_en_upper.dict.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_upper.dict.yaml")
shutil.copyfile("./rimefiles/easy_en_upper.schema.yaml", "./"+sort_rime+"/"+rime_files+"/easy_en_upper.schema.yaml")
shutil.copyfile("./rimefiles/element_bopomo.yaml", "./"+sort_rime+"/"+rime_files+"/element_bopomo.yaml")
shutil.copyfile("./rimefiles/fullshape.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/fullshape.extended.dict.yaml")
shutil.copyfile("./rimefiles/fullshape.dict.yaml", "./"+sort_rime+"/"+rime_files+"/fullshape.dict.yaml")
shutil.copyfile("./rimefiles/fullshape.schema.yaml", "./"+sort_rime+"/"+rime_files+"/fullshape.schema.yaml")
shutil.copyfile("./rimefiles/greek.dict.yaml", "./"+sort_rime+"/"+rime_files+"/greek.dict.yaml")
shutil.copyfile("./rimefiles/greek.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/greek.extended.dict.yaml")
shutil.copyfile("./rimefiles/greek.schema.yaml", "./"+sort_rime+"/"+rime_files+"/greek.schema.yaml")
shutil.copyfile("./rimefiles/hangeul_phrase.txt", "./"+sort_rime+"/"+rime_files+"/hangeul_phrase.txt")
shutil.copyfile("./rimefiles/hangeul.dict.yaml", "./"+sort_rime+"/"+rime_files+"/hangeul.dict.yaml")
shutil.copyfile("./rimefiles/hangeul_hanja.dict.yaml", "./"+sort_rime+"/"+rime_files+"/hangeul_hanja.dict.yaml")
shutil.copyfile("./rimefiles/hangeul.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/hangeul.extended.dict.yaml")
shutil.copyfile("./rimefiles/hangeul.schema.yaml", "./"+sort_rime+"/"+rime_files+"/hangeul.schema.yaml")
shutil.copyfile("./rimefiles/hangeul_hnc.schema.yaml", "./"+sort_rime+"/"+rime_files+"/hangeul_hnc.schema.yaml")
shutil.copyfile("./rimefiles/hangeul_hnc.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/hangeul_hnc.extended.dict.yaml")
shutil.copyfile("./rimefiles/hangeul_hnc.dict.yaml", "./"+sort_rime+"/"+rime_files+"/hangeul_hnc.dict.yaml")
shutil.copyfile("./rimefiles/hangeul_hnc_hanja.dict.yaml", "./"+sort_rime+"/"+rime_files+"/hangeul_hnc_hanja.dict.yaml")
shutil.copyfile("./rimefiles/hangeul_hnc_phrase.txt", "./"+sort_rime+"/"+rime_files+"/hangeul_hnc_phrase.txt")
shutil.copyfile("./rimefiles/jpnin1_phrase.txt", "./"+sort_rime+"/"+rime_files+"/jpnin1_phrase.txt")
shutil.copyfile("./rimefiles/jpnin1.dict.yaml", "./"+sort_rime+"/"+rime_files+"/jpnin1.dict.yaml")
shutil.copyfile("./rimefiles/jpnin1_hw.dict.yaml", "./"+sort_rime+"/"+rime_files+"/jpnin1_hw.dict.yaml")
shutil.copyfile("./rimefiles/jpnin1.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/jpnin1.extended.dict.yaml")
shutil.copyfile("./rimefiles/jpnin1.schema.yaml", "./"+sort_rime+"/"+rime_files+"/jpnin1.schema.yaml")
shutil.copyfile("./rimefiles/latinin1.dict.yaml", "./"+sort_rime+"/"+rime_files+"/latinin1.dict.yaml")
shutil.copyfile("./rimefiles/latinin1.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/latinin1.extended.dict.yaml")
shutil.copyfile("./rimefiles/latinin1.schema.yaml", "./"+sort_rime+"/"+rime_files+"/latinin1.schema.yaml")
shutil.copyfile("./rimefiles/space.dict.yaml", "./"+sort_rime+"/"+rime_files+"/space.dict.yaml")
shutil.copyfile("./rimefiles/space_f.dict.yaml", "./"+sort_rime+"/"+rime_files+"/space_f.dict.yaml")
shutil.copyfile("./rimefiles/phrases.cht.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.cht.dict.yaml")
shutil.copyfile("./rimefiles/phrases.chtp.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.chtp.dict.yaml")
shutil.copyfile("./rimefiles/phrases.cyr_all.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.cyr_all.dict.yaml")
shutil.copyfile("./rimefiles/phrases.en_l_w.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.en_l_w.dict.yaml")
shutil.copyfile("./rimefiles/phrases.en_o_w.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.en_o_w.dict.yaml")
shutil.copyfile("./rimefiles/phrases.en_u_w.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.en_u_w.dict.yaml")
shutil.copyfile("./rimefiles/phrases.fs_all.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.fs_all.dict.yaml")
shutil.copyfile("./rimefiles/phrases.gr_all.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.gr_all.dict.yaml")
shutil.copyfile("./rimefiles/phrases.jp_hk.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.jp_hk.dict.yaml")
shutil.copyfile("./rimefiles/phrases.jp_hk_more.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.jp_hk_more.dict.yaml")
shutil.copyfile("./rimefiles/phrases.jp_hkk.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.jp_hkk.dict.yaml")
shutil.copyfile("./rimefiles/phrases.jp_hkkseg.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.jp_hkkseg.dict.yaml")
# shutil.copyfile("./rimefiles/phrases.jp_hkup_w.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.jp_hkup_w.dict.yaml")
# shutil.copyfile("./rimefiles/phrases.jp_hkmoreup_w.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.jp_hkmoreup_w.dict.yaml")
shutil.copyfile("./rimefiles/phrases.kr_more.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.kr_more.dict.yaml")
shutil.copyfile("./rimefiles/phrases.la_py_w.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.la_py_w.dict.yaml")
shutil.copyfile("./rimefiles/phrases.la_eu_w.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.la_eu_w.dict.yaml")
shutil.copyfile("./rimefiles/punct_bopomo.yaml", "./"+sort_rime+"/"+rime_files+"/punct_bopomo.yaml")
shutil.copyfile("./rimefiles/rime.lua", "./"+sort_rime+"/"+rime_files+"/rime.lua")
shutil.copytree("./rimefiles/lua/", "./"+sort_rime+"/"+rime_files+"/lua/")
shutil.copyfile("./rimefiles/symbols_bpmf.dict.yaml", "./"+sort_rime+"/"+rime_files+"/symbols_bpmf.dict.yaml")
shutil.copyfile("./rimefiles/symbols_bpmf.schema.yaml", "./"+sort_rime+"/"+rime_files+"/symbols_bpmf.schema.yaml")
shutil.copyfile("./rimefiles/opencc/back_mark.json", "./"+sort_rime+"/"+rime_files+"/opencc/back_mark.json")
shutil.copyfile("./rimefiles/opencc/back_mark_series.json", "./"+sort_rime+"/"+rime_files+"/opencc/back_mark_series.json")
shutil.copyfile("./rimefiles/opencc/back_mark_script.txt", "./"+sort_rime+"/"+rime_files+"/opencc/back_mark_script.txt")
shutil.copyfile("./rimefiles/opencc/back_mark_table.txt", "./"+sort_rime+"/"+rime_files+"/opencc/back_mark_table.txt")
shutil.copyfile("./rimefiles/opencc/bpm_moedict_big5e_hkscs_jis.json", "./"+sort_rime+"/"+rime_files+"/opencc/bpm_moedict_big5e_hkscs_jis.json")
shutil.copyfile("./rimefiles/opencc/bpm_moedict_big5e_hkscs_jis.txt", "./"+sort_rime+"/"+rime_files+"/opencc/bpm_moedict_big5e_hkscs_jis.txt")
shutil.copyfile("./rimefiles/opencc/emoji_t.json", "./"+sort_rime+"/"+rime_files+"/opencc/emoji_t.json")
shutil.copyfile("./rimefiles/opencc/emoji_t.txt", "./"+sort_rime+"/"+rime_files+"/opencc/emoji_t.txt")
shutil.copyfile("./rimefiles/opencc/ocm_moedict_big5e_hkscs_jis.json", "./"+sort_rime+"/"+rime_files+"/opencc/ocm_moedict_big5e_hkscs_jis.json")
shutil.copyfile("./rimefiles/opencc/ocm_moedict_big5e_hkscs_jis.txt", "./"+sort_rime+"/"+rime_files+"/opencc/ocm_moedict_big5e_hkscs_jis.txt")
shutil.copyfile("./rimefiles/opencc/punct_mark.json", "./"+sort_rime+"/"+rime_files+"/opencc/punct_mark.json")
shutil.copyfile("./rimefiles/opencc/punct_mark.txt", "./"+sort_rime+"/"+rime_files+"/opencc/punct_mark.txt")
# shutil.copytree("./rimefiles/custom檔_舊版防崩潰/plus注音_防崩潰：Win必加，Mac勿加/", "./"+sort_rime+"/"+rime_files+"/plus注音_防崩潰：Win必加，Mac勿加/")
# shutil.copyfile("./rimefiles/custom檔_舊版防崩潰/easy_en_super_防崩潰：Win必加，Mac勿加/easy_en_super.custom.yaml", "./"+sort_rime+"/"+rime_files+"/plus注音_防崩潰：Win必加，Mac勿加/easy_en_super.custom.yaml")
# shutil.copyfile("./rimefiles/custom檔_舊版防崩潰/easy_en_lower_防崩潰：Win必加，Mac勿加/easy_en_lower.custom.yaml", "./"+sort_rime+"/"+rime_files+"/plus注音_防崩潰：Win必加，Mac勿加/easy_en_lower.custom.yaml")
# shutil.copytree("./rimefiles/custom檔_日語jpnin1精簡/jpnin1只出假名修改檔/", "./"+sort_rime+"/"+rime_files+"/jpnin1只出假名修改檔/")
# shutil.copytree("./rimefiles/custom檔_日語jpnin1精簡/jpnin1精簡轉寫修改檔/", "./"+sort_rime+"/"+rime_files+"/jpnin1精簡轉寫修改檔/")
shutil.copytree("./rimefiles/custom檔_日語jpnin1精簡/", "./"+sort_rime+"/"+rime_files+"/custom檔_日語jpnin1精簡/")


#複製檔案(注音洋蔥mixin版)
shutil.copyfile("./rimefiles/essay-zh-hant-mc-mixin.txt", "./"+sort_rime+"/"+rime_files+"/essay-zh-hant-mc-mixin.txt")
shutil.copyfile("./rimefiles/bo_mixin_jp.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin_jp.dict.yaml")
shutil.copyfile("./rimefiles/bo_mixin_kr.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin_kr.dict.yaml")
shutil.copyfile("./rimefiles/bo_mixin_kr_hnc.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin_kr_hnc.dict.yaml")
shutil.copyfile("./rimefiles/bo_mixin_la.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin_la.dict.yaml")
shutil.copyfile("./rimefiles/bo_mixin_en.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin_en.dict.yaml")
shutil.copyfile("./rimefiles/bo_mixin_phrase.txt", "./"+sort_rime+"/"+rime_files+"/bo_mixin_phrase.txt")
shutil.copyfile("./rimefiles/bo_mixin.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin.extended.dict.yaml")
shutil.copyfile("./rimefiles/bo_mixin1.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin1.schema.yaml")
shutil.copyfile("./rimefiles/bo_mixin2.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin2.schema.yaml")
shutil.copyfile("./rimefiles/bo_mixin3.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin3.schema.yaml")
shutil.copyfile("./rimefiles/bo_mixin4.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bo_mixin4.schema.yaml")
shutil.copyfile("./rimefiles/phrases.cht_en_w.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.cht_en_w.dict.yaml")
shutil.copyfile("./rimefiles/phrases.jp_hkkreduce.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.jp_hkkreduce.dict.yaml")
shutil.copyfile("./rimefiles/phrases.kr.dict.yaml", "./"+sort_rime+"/"+rime_files+"/phrases.kr.dict.yaml")
shutil.copytree("./rimefiles/custom檔_注音mixin版兩行同顯/", "./"+sort_rime+"/"+rime_files+"/custom檔_注音mixin版兩行同顯/")
# shutil.copytree("./rimefiles/custom檔_注音mixin版舊版同顯/mixin注音_同顯1修改檔(Mac)(fcitx5-rime)/", "./"+sort_rime+"/"+rime_files+"/mixin注音_同顯1修改檔(Mac)(fcitx5-rime)/")
# shutil.copytree("./rimefiles/custom檔_注音mixin版舊版同顯/mixin注音_同顯2修改檔(Mac)(fcitx5-rime)/", "./"+sort_rime+"/"+rime_files+"/mixin注音_同顯2修改檔(Mac)(fcitx5-rime)/")
# shutil.copytree("./rimefiles/custom檔_注音mixin版舊版同顯/mixin注音_同顯1修改檔(Win)/", "./"+sort_rime+"/"+rime_files+"/mixin注音_同顯1修改檔(Win)/")
# shutil.copytree("./rimefiles/custom檔_注音mixin版舊版同顯/mixin注音_同顯2修改檔(Win)/", "./"+sort_rime+"/"+rime_files+"/mixin注音_同顯2修改檔(Win)/")
# shutil.copyfile("./rimefiles/custom檔_舊版防崩潰/easy_en_super_防崩潰：Win必加，Mac勿加/easy_en_super.custom.yaml", "./"+sort_rime+"/"+rime_files+"/mixin注音_同顯1修改檔(Win)/easy_en_super.custom.yaml")
# shutil.copyfile("./rimefiles/custom檔_舊版防崩潰/easy_en_super_防崩潰：Win必加，Mac勿加/easy_en_super.custom.yaml", "./"+sort_rime+"/"+rime_files+"/mixin注音_同顯2修改檔(Win)/easy_en_super.custom.yaml")
# shutil.copyfile("./rimefiles/custom檔_舊版防崩潰/easy_en_lower_防崩潰：Win必加，Mac勿加/easy_en_lower.custom.yaml", "./"+sort_rime+"/"+rime_files+"/mixin注音_同顯1修改檔(Win)/easy_en_lower.custom.yaml")
# shutil.copyfile("./rimefiles/custom檔_舊版防崩潰/easy_en_lower_防崩潰：Win必加，Mac勿加/easy_en_lower.custom.yaml", "./"+sort_rime+"/"+rime_files+"/mixin注音_同顯2修改檔(Win)/easy_en_lower.custom.yaml")


#複製檔案(注音洋蔥雙拼版)
shutil.copyfile("./rimefiles/bopomo_onion_double.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onion_double.extended.dict.yaml")
shutil.copyfile("./rimefiles/bopomo_onion_double.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onion_double.schema.yaml")
shutil.copyfile("./rimefiles/bopomo_onion_double_t2.schema.yaml", "./"+sort_rime+"/"+rime_files+"/bopomo_onion_double_t2.schema.yaml")
shutil.copyfile("./rimefiles/bopomo_onion_double_phrase.txt", "./"+sort_rime+"/"+rime_files+"/bopomo_onion_double_phrase.txt")
shutil.copyfile("./rimefiles/symbols_bpmf_double.schema.yaml", "./"+sort_rime+"/"+rime_files+"/symbols_bpmf_double.schema.yaml")
shutil.copyfile("./rimefiles/element_bopomo_double.yaml", "./"+sort_rime+"/"+rime_files+"/element_bopomo_double.yaml")
shutil.copyfile("./rimefiles/punct_bopomo_double.yaml", "./"+sort_rime+"/"+rime_files+"/punct_bopomo_double.yaml")
# shutil.copytree("./rimefiles/custom檔_雙拼注音不開頭簡拼/", "./"+sort_rime+"/"+rime_files+"/custom檔_雙拼注音不開頭簡拼/")
shutil.copytree("./rimefiles/雙拼注音鍵位說明圖示/", "./"+sort_rime+"/其他/雙拼注音鍵位說明圖示/")


#複製檔案(地球拼音洋蔥mix-in版)
shutil.copyfile("./rimefiles/ocm_mixin_jp.dict.yaml", "./"+sort_rime+"/"+rime_files+"/ocm_mixin_jp.dict.yaml")
shutil.copyfile("./rimefiles/ocm_mixin_kr.dict.yaml", "./"+sort_rime+"/"+rime_files+"/ocm_mixin_kr.dict.yaml")
shutil.copyfile("./rimefiles/ocm_mixin_kr_hnc.dict.yaml", "./"+sort_rime+"/"+rime_files+"/ocm_mixin_kr_hnc.dict.yaml")
shutil.copyfile("./rimefiles/ocm_mixin_la.dict.yaml", "./"+sort_rime+"/"+rime_files+"/ocm_mixin_la.dict.yaml")
shutil.copyfile("./rimefiles/terra_pinyin_onion.extended.dict.yaml", "./"+sort_rime+"/"+rime_files+"/terra_pinyin_onion.extended.dict.yaml")
shutil.copyfile("./rimefiles/terra_pinyin_onion.schema.yaml", "./"+sort_rime+"/"+rime_files+"/terra_pinyin_onion.schema.yaml")
shutil.copyfile("./rimefiles/opencc/back_mark_ocm.json", "./"+sort_rime+"/"+rime_files+"/opencc/back_mark_ocm.json")
shutil.copyfile("./rimefiles/opencc/back_mark_ocm.txt", "./"+sort_rime+"/"+rime_files+"/opencc/back_mark_ocm.txt")


#五個注音拼音方案開啟default.custom檔
shutil.copyfile("./rimefiles/其他/五個注音拼音方案開啟default.custom檔/default.custom.yaml", "./"+sort_rime+"/"+rime_files+"/default.custom.yaml")


#各方案default.custom
shutil.copytree("./rimefiles/各方案default.custom/地球拼音洋蔥mix-in版_custom/", "./"+sort_rime+"/其他/各方案default.custom/地球拼音洋蔥mix-in版_custom/")
shutil.copytree("./rimefiles/各方案default.custom/注音洋蔥mixin版_custom/", "./"+sort_rime+"/其他/各方案default.custom/注音洋蔥mixin版_custom/")
shutil.copytree("./rimefiles/各方案default.custom/注音洋蔥plus版_custom/", "./"+sort_rime+"/其他/各方案default.custom/注音洋蔥plus版_custom/")
shutil.copytree("./rimefiles/各方案default.custom/注音洋蔥純注音版_custom/", "./"+sort_rime+"/其他/各方案default.custom/注音洋蔥純注音版_custom/")
shutil.copytree("./rimefiles/各方案default.custom/注音洋蔥雙拼版_custom/", "./"+sort_rime+"/其他/各方案default.custom/注音洋蔥雙拼版_custom/")


#其他
shutil.copytree("./rimefiles/其他/Mac鼠鬚管外觀設定檔/", "./"+sort_rime+"/其他/Mac鼠鬚管外觀設定檔/")
shutil.copytree("./rimefiles/其他/OpenCC_ocd_64位元/", "./"+sort_rime+"/其他/OpenCC_ocd_64位元/")
shutil.copytree("./rimefiles/其他/Win小狼毫外觀設定檔/", "./"+sort_rime+"/其他/Win小狼毫外觀設定檔/")

# shutil.copytree("./rimefiles/其他/OpenCC_ocd_64位元/", "./"+sort_rime+"/ocm/OpenCC_ocd_64位元/")
# shutil.copytree("./rimefiles/custom檔_舊版防崩潰/ocm_防崩潰：Win必加，Mac勿加/", "./"+sort_rime+"/ocm/ocm_防崩潰：Win必加，Mac勿加/")
# shutil.copyfile("./rimefiles/custom檔_舊版防崩潰/easy_en_super_防崩潰：Win必加，Mac勿加/easy_en_super.custom.yaml", "./"+sort_rime+"/ocm/ocm_防崩潰：Win必加，Mac勿加/easy_en_super.custom.yaml")
# shutil.copyfile("./rimefiles/custom檔_舊版防崩潰/easy_en_lower_防崩潰：Win必加，Mac勿加/easy_en_lower.custom.yaml", "./"+sort_rime+"/ocm/ocm_防崩潰：Win必加，Mac勿加/easy_en_lower.custom.yaml")


#主程式
shutil.copytree("./rimefiles/主程式/", "./"+sort_rime+"/主程式/")


#增加日期
localtime=time.strftime("%Y%m%d", time.localtime())
os.rename("./"+sort_rime+"/"+rime_files+"/", "./"+sort_rime+"/"+rime_files+"_"+localtime)
os.rename("./"+sort_rime+"/", "./"+the_name+"_"+localtime)



