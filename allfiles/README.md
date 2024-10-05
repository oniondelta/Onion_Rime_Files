# 檔案文件說明


```
「設定檔」：方案設定檔

「引入檔」：設定檔中可用語法引入該檔內程式碼。多個方案同樣設定時，如此可方便修改

「主字詞典」：設定檔中連結的字詞典，該檔內可連結引入其他字詞典；「字典」：只有單字；「詞典」：只有詞句；「字詞典」：有單字也有詞句
  ps:官方並無如此區分，皆為引入字詞的 .dict.yaml 檔，由於習慣單字和詞句分開放置，故此區分

「用戶短語」：添加短語詞彙，如：常用地址、e-mail等
  ps:可無視設定檔設置內容，硬性添加也不產生問題。新手愛用，但不推薦把它當成一般字詞典使用。在輸入時可被快捷鍵刪除，且除非有原檔備份，否則無法回復，曾誤刪過

「 lua 程式碼檔」：lua 程式碼寫於此，也可用它引入 lua 資料夾中的 lua 文件


┌─ Mount_bopomo.extended.dict.yaml            〈掛載用 注音方案〉「主字詞典」
├─ Mount_bopomo.schema.yaml                   〈掛載用 注音方案〉「設定檔」
├─ Mount_ocm.extended.dict.yaml               
├─ Mount_ocm.schema.yaml                      
├─ allbpm.dict.yaml                           〈掛載用 注音文方案〉「主字詞典」
├─ allbpm.schema.yaml                         〈掛載用 注音文方案〉「設定檔」
├─ bo_mixin.extended.dict.yaml                〈注音 mixin 系列方案〉「主字詞典」
├─ bo_mixin1.schema.yaml                      〈注音 mixin 1 方案〉「設定檔」
├─ bo_mixin2.schema.yaml                      〈注音 mixin 2 方案〉「設定檔」
├─ bo_mixin3.schema.yaml                      〈注音 mixin 3 方案〉「設定檔」
├─ bo_mixin4.schema.yaml                      〈注音 mixin 4 方案〉「設定檔」
├─ bo_mixin_en.dict.yaml                      〈注音 mixin 系列方案〉純26個英文字母+簡單標點「字典」
├─ bo_mixin_jp.dict.yaml                      〈注音 mixin 系列方案〉日文假名「字典」
├─ bo_mixin_kr.dict.yaml                      〈注音 mixin 系列方案〉韓文 形碼 鍵位「字典」
├─ bo_mixin_kr_hnc.dict.yaml                  〈注音 mixin 系列方案〉韓文 HNC 鍵位「字典」
├─ bo_mixin_la.dict.yaml                      〈注音 mixin 系列方案〉拉丁「字典」  （含英文字母、音標、帶調字母等）
├─ bo_mixin_phrase.txt                        〈注音 mixin 系列方案〉「用戶短語」
├─ bopomo_onion.extended.dict.yaml            〈純注音 方案〉「主字詞典」
├─ bopomo_onion.schema.yaml                   〈純注音 方案〉「設定檔」
├─ bopomo_onion_double.extended.dict.yaml     〈雙拼注音 方案〉「主字詞典」
├─ bopomo_onion_double_phrase.txt             〈雙拼注音 方案〉「用戶短語」
├─ bopomo_onion_double.schema.yaml            〈雙拼注音 方案〉「設定檔」
├─ bopomo_onion_phrase.txt                    〈純注音 方案〉「用戶短語」
├─ bopomo_onion_symbols.yaml                  〈純注音 方案〉標點符號「引入檔」
├─ bopomo_onionplus.extended.dict.yaml        〈注音 plus 系列方案〉「主字詞典」
├─ bopomo_onionplus.schema.yaml               〈注音 plus 方案〉「設定檔」
├─ bopomo_onionplus_phrase.txt                〈注音 plus 方案〉「用戶短語」
├─ bopomo_onionplus_space.schema.yaml         〈注音 plus space 方案〉「設定檔」  （空白不直出，按空白鍵打出空白，但沒上屏）
├─ cangjie5.dict.yaml                         〈掛載用 倉頡 方案〉「主字典」  （反查用，Rime 官方製作版）
├─ cangjie5.schema.yaml                       〈掛載用 倉頡 方案〉「設定檔」  （反查用，Rime 官方製作版）                                   
├─ cyrillic.dict.yaml                         〈掛載用 西里爾（俄文）方案〉「字典」  （注音方案掛載）
├─ cyrillic.extended.dict.yaml                〈掛載用 西里爾（俄文）方案〉「主字詞典」  （注音方案掛載）
├─ cyrillic.schema.yaml                       〈掛載用 西里爾（俄文）方案〉「設定檔」  （注音方案掛載）
├─ dif1.extended.dict.yaml                    
├─ dif1.schema.yaml                           
├─ dif1_cy.schema.yaml                        
├─ dif1_fs.schema.yaml                        
├─ dif1_gr.schema.yaml                        
├─ dif1_jp.extended.dict.yaml                 
├─ dif1_jphi.schema.yaml                      
├─ dif1_jpka.schema.yaml                      
├─ dif1_kr.extended.dict.yaml                 
├─ dif1_kr.schema.yaml                        
├─ dif1_la.extended.dict.yaml                 
├─ dif1_la.schema.yaml                        
├─ dif1_phrase.txt                            
├─ easy_en_lcomment.dict.yaml                 〈掛載用 英漢字典 方案〉「主字詞典」（單純 Comment 濾鏡用）
├─ easy_en_lcomment.schema.yaml               〈掛載用 英漢字典 方案〉「設定檔」（單純 Comment 濾鏡用）
├─ easy_en_lower.dict.yaml                    〈掛載用 英漢字典 方案〉「主字詞典」（小寫）
├─ easy_en_lower.schema.yaml                  〈掛載用 英漢字典 方案〉「設定檔」（小寫）
├─ easy_en_super.dict.yaml                    （未引用）〈掛載用 英漢字典 方案〉「主字詞典」
├─ easy_en_super.schema.yaml                  （未引用）〈掛載用 英漢字典 方案〉「設定檔」（因 Comment 合一，排序會有問題）
├─ easy_en_super_original.dict.yaml           （未引用）〈掛載用 英漢字典 方案〉「字詞典」  （未排序前之 easy_en_super.dict.yaml 原始檔）
├─ easy_en_upper.dict.yaml                    〈掛載用 英漢字典 方案〉「主字詞典」（大寫或大小寫混合）
├─ easy_en_upper.schema.yaml                  〈掛載用 英漢字典 方案〉「設定檔」（大寫或大小寫混合）
├─ element_bopomo.yaml                        〈注音 mixin 和 plus 方案〉程式碼「引入檔」
├─ element_bopomo_double.yaml                 〈雙拼注音 方案〉程式碼「引入檔」
├─ element_ocm.yaml                           
├─ essay-jp-onion.txt                         〈八股文檔〉日文  （只針對假名，因日文一個漢字都對應太多發音，故不包括含有漢字詞彙，漢字詞頻直接在字詞典附註）
├─ essay-kr-hanja.txt                         〈八股文檔〉韓文  （只針韓文漢字）
├─ essay-zh-hant-mc-mixin.txt                 〈八股文檔〉多國語言  （注音 mixin 系列所使用）
├─ essay-zh-hant-mc.txt                       〈八股文檔〉中文  （較輕量化，詞頻引自小麥注音）
├─ fullshape.dict.yaml                        〈掛載用 全形字母 方案〉「字典」
├─ fullshape.extended.dict.yaml               〈掛載用 全形字母 方案〉「主字詞典」
├─ fullshape.schema.yaml                      〈掛載用 全形字母 方案〉「設定檔」
├─ greek.dict.yaml                            〈掛載用 希臘文 方案〉「字典」  （注音方案掛載）
├─ greek.extended.dict.yaml                   〈掛載用 希臘文 方案〉「主字詞典」  （注音方案掛載）
├─ greek.schema.yaml                          〈掛載用 希臘文 方案〉「設定檔」  （注音方案掛載）
├─ hangeul.dict.yaml                          （未引用）〈掛載用 韓文形碼 方案〉諺文「字典」  （改用 HNC 版）
├─ hangeul.extended.dict.yaml                 （未引用）〈掛載用 韓文形碼 方案〉「主字詞典」  （改用 HNC 版）
├─ hangeul.schema.yaml                        （未引用）〈掛載用 韓文形碼 方案〉「設定檔」  （改用 HNC 版）
├─ hangeul_hanja.dict.yaml                    （未引用）〈掛載用 韓文形碼 方案〉漢字「字典」  （改用 HNC 版）
├─ hangeul_hnc.dict.yaml                      〈掛載用 韓文 HNC 方案〉諺文「字典」  （注音方案掛載）
├─ hangeul_hnc.extended.dict.yaml             〈掛載用 韓文 HNC 方案〉「主字詞典」  （注音方案掛載）
├─ hangeul_hnc.schema.yaml                    〈掛載用 韓文 HNC 方案〉「設定檔」  （注音方案掛載）
├─ hangeul_hnc_hanja.dict.yaml                〈掛載用 韓文 HNC 方案〉漢字「字典」  （注音方案掛載）
├─ hangeul_hnc_phrase.txt                     〈掛載用 韓文 HNC 方案〉「用戶短語」  （注音方案掛載）
├─ hangeul_phrase.txt                         （未引用）〈掛載用 韓文形碼 方案〉「用戶短語」  （改用 HNC 版）
├─ jpnin1.dict.yaml                           〈掛載用 日文 方案〉「字典」  （含假名和單漢字）
├─ jpnin1.extended.dict.yaml                  〈掛載用 日文 方案〉「主字詞典」
├─ jpnin1.schema.yaml                         〈掛載用 日文 方案〉「設定檔」
├─ jpnin1_hw.dict.yaml                        〈掛載用 日文 方案〉半形片假名「字典」
├─ jpnin1_phrase.txt                          〈掛載用 日文 方案〉「用戶短語」
├─ kanaword.dict.yaml                         
├─ latinin1.dict.yaml                         〈掛載用 拉丁 方案〉「字典」  （含英文字母、音標、帶調字母等）
├─ latinin1.extended.dict.yaml                〈掛載用 拉丁 方案〉「主字詞典」
├─ latinin1.schema.yaml                       〈掛載用 拉丁 方案〉「設定檔」
├─ lua_custom_phrase.txt                      〈注音 mixin4 方案〉「用戶短語」
├─ mixin_bpmf.dict.yaml                       〈內嵌用 注音文〉「字詞典」
├─ ocm_mixin.extended.dict.yaml               
├─ ocm_mixin.schema.yaml                      
├─ ocm_mixin_cyrillic.schema.yaml             
├─ ocm_mixin_fullshape.schema.yaml            
├─ ocm_mixin_greek.schema.yaml                
├─ ocm_mixin_jp.dict.yaml                     
├─ ocm_mixin_kr.dict.yaml                     
├─ ocm_mixin_kr_hnc.dict.yaml                 
├─ ocm_mixin_la.dict.yaml                     
├─ ocm_mixin_phrase.txt                       
├─ ocm_tc_mc.dict.yaml                        
├─ ocm_tc.dict.yaml                           
├─ onion-array30-generally.dict.yaml          〈行列 30 方案〉「字典」
├─ onion-array30-phrases.dict.yaml            〈行列 30 方案〉多字詞句「詞典」
├─ onion-array30-shortcode.dict.yaml          〈行列 30 方案〉簡碼「字典」
├─ onion-array30-special.dict.yaml            〈行列 30 方案〉特別碼「字典」  （按空格才出現或上屏之編碼）
├─ onion-array30-wsymbols.dict.yaml           〈掛載用 行列 30 符號方案〉「主字典」
├─ onion-array30-wsymbols.schema.yaml         〈掛載用 行列 30 符號方案〉「設定檔」
├─ onion-array30.extended.dict.yaml           〈行列 30 方案〉「主字典」
├─ onion-array30.schema.yaml                  〈行列 30 方案〉「設定檔」
├─ phrases.cht.dict.yaml                      （未引用）〈注音相關方案〉未標註拼音「詞典」  （破音字因素，未有方案引用。逐步標註拼音移至 phrases.chtp.dict.yaml ）
├─ phrases.cht_en_w.dict.yaml                 中英混合詞彙「詞典」
├─ phrases.chtp.dict.yaml                     〈注音相關方案〉已標註拼音「詞典」
├─ phrases.cyr_all.dict.yaml                  西里爾（俄文）「詞典」
├─ phrases.en_l_w.dict.yaml                   英文小寫「詞典」
├─ phrases.en_o_w.dict.yaml                   英文名品牌和含有標點等特殊「詞典」
├─ phrases.en_u_w.dict.yaml                   英文大寫和首字母大寫「詞典」
├─ phrases.fs_all.dict.yaml                   全形字母「詞典」
├─ phrases.gr_all.dict.yaml                   希臘文「詞典」
├─ phrases.jp_hk.dict.yaml                    日文純假名小「詞典」
├─ phrases.jp_hk_more.dict.yaml               日文純假名大「詞典」  （比 phrases.jp_hk.dict.yaml 詞彙量更多）
├─ phrases.jp_hkk.dict.yaml                   日文「詞典」  （假名和漢字皆含）
├─ phrases.jp_hkkreduce.dict.yaml             〈注音 mixin 系列方案〉日文純假名「詞典」  （減除中文字詞典中已有字詞彙）
├─ phrases.jp_hkkseg.dict.yaml                〈掛載用 日文 方案〉日文標註發音「詞典」  （不包含純假名詞句，純假名放置在 phrases.jp_hk_more.dict.yaml 或 phrases.jp_hk.dict.yaml）（只在 jpnin1.schema.yaml 該設定檔使用）
├─ phrases.jp_hkmoreup_w.dict.yaml            （未引用）日文「詞典」  （使與漢字同發音之純假名字串可顯示於選項中，後期增加更大日文詞典，已無效益）
├─ phrases.jp_hkup_w.dict.yaml                （未引用）日文「詞典」  （使與漢字同發音之純假名字串可顯示於選項中，後期增加更大日文詞典，已無效益）
├─ phrases.kr.dict.yaml                       韓文小「詞典」
├─ phrases.kr_more.dict.yaml                  韓文大「詞典」  （比 phrases.kr.dict.yaml 詞彙量更多）
├─ phrases.la_eu_w.dict.yaml                  非純 26 英文字母「詞典」  （如：café、rosé 等歐洲語言詞彙）
├─ phrases.la_py_w.dict.yaml                  中文拼音「詞典」
├─ phrases.ocmtc_essay_mc.dict.yaml           
├─ punct_bopomo.yaml                          〈注音相關方案〉標點符號「引入檔」
├─ punct_bopomo_double.yaml                   〈雙拼注音相關方案〉標點符號「引入檔」
├─ punct_ocm.yaml                             
├─ punct_ovff.dict.yaml                       
├─ punct_ovff.schema.yaml                     
├─ rime.lua                                   「 lua 程式碼檔」  （引入用，主要程式文件在 lua 資料夾中）
├─ space.dict.yaml                            一些掛載方案需有空格編碼，使主方案〈注音 plus space 方案〉可出空格，獨立字典檔好開關。對其他大千注音方案，在某些操作下，掛載方案上屏可少一鍵。
├─ space_f.dict.yaml                          同上，但為全形空白，針對〈掛載用 全形字母 方案〉。
├─ symbols-mark.dict.yaml                     （未引用）
├─ symbols-mark.schema.yaml                   （未引用）
├─ symbols_bpmf.dict.yaml                     〈掛載用 系列符號（注音） 方案〉「主字詞典」  （注音方案掛載）
├─ symbols_bpmf.schema.yaml                   〈掛載用 系列符號（注音） 方案〉「設定檔」  （注音方案掛載）
├─ symbols_bpmf_double.schema.yaml            〈掛載用 系列符號（雙拼注音） 方案〉「設定檔」  （雙拼注音方案掛載）
├─ symbols_ocm.dict.yaml                      
├─ symbols_ocm.schema.yaml                    
├─ terra_pinyin_onion.dict.yaml               中文拼音「字詞典」  （以兩岸字典有的發音為標準）（注音相關方案和拼音等眾多方案皆有引用）（原官方 terra_pinyin.dict.yaml 改寫，但已修改眾多，單個中文字發音補足兩岸詞典皆有發音，詞句用字以台灣標準為主）
├─ terra_pinyin_onion.extended.dict.yaml      〈泰瑞拼音 mixin 方案〉「主字詞典」
├─ terra_pinyin_onion.schema.yaml             〈泰瑞拼音 mixin 方案〉「設定檔」
├─ terra_pinyin_onion_add.dict.yaml           中文拼音「字典」  （補充常用發音，但兩岸字典皆沒有該發音）（補充針對 terra_pinyin_onion.dict.yaml ）（注音相關方案和拼音等眾多方案皆有引用）
└─ uniabcdword.dict.yaml                      
```
