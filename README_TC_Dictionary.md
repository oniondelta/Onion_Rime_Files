#  中文字詞庫編修備註

####  ※ 請勿使用於商業營利相關行為
####  ※ Commercial use is prohibited

## 部落格方案
部落格內容已移至 GitHub，故關閉先前方案文章。以下連結已失效。

- 部落格四個注音方案：http://deltazone.pixnet.net/blog/category/11823230
- 部落格一個拼音方案：http://deltazone.pixnet.net/blog/post/353697089

## 字詞頻庫《八股文》說明
- essay-zh-hant-onion.txt 《八股文》引用 [Rime 官方 essay](https://github.com/rime/rime-essay) 文件，比對修改貼近台灣習慣用字，並修改字詞頻，follow 官方更新。202102 八股文改用掛接。
- essay-zh-hant-mc.txt 《八股文》引用[小麥注音](https://github.com/openvanilla/McBopomofo)文件，比對修改錯字和變更字詞頻符合方案，比 essay-zh-hant-onion.txt 字詞條數精簡許多，部屬較快速。
## 字詞庫說明
- terra_pinyin_onion.dict.yaml 《字庫&詞庫》原[地球拼音](https://github.com/rime/rime-terra-pinyin)增修，補充各字典「字」發音，「詞」改台灣習慣用字和發音，「詞」移動各種變音、該詞單個字發音在字典中查無、錯誤發音到 phrases.chtpp.dict.yaml 該檔；非臺灣慣用字形之詞彙移到 phrases.chtpv.dict.yaml 該檔。
- terra_pinyin_onion_add.dict.yaml 《字庫》補充慣用但非正確之發音，且增加避免空碼產生問題刻意附加之發音。
- phrases.chtp.dict.yaml 《詞庫》附加帶調拼音。
- phrases.cht.dict.yaml 《詞庫》無附加拼音。陸續手動附加拼音移至 phrases.chtp.dict.yaml。
- phrases.chtpp.dict.yaml 《詞庫，未上傳》只含有各種變音、該詞單個字發音在字典中查無和大陸發音、錯誤發音。
- phrases.chtpv.dict.yaml 《詞庫，未上傳》只含有各種非臺灣慣用字形之詞彙。

## 原則

- 「字」以兩岸字典有的發音都收錄為目標。

- 「詞」的發音和用字原則上以臺灣為主。

## 問題紀錄

許多 Rime 詞庫為不帶拼音（編碼），好處是容易 mapping ，不好之處是如破音字會出現在不該為此發音之選單中，整理四十萬多字帶拼音和聲調之詞庫 phrases.chtp.dict.yaml，但其中（包含 terra_pinyin_onion.dict.yaml 該檔）還有許多錯誤、待考、待釐清之處。

《詞》

- 由於使用多個字詞碼表合併刪重，以先求有再求好，故存有許多錯誤拼音和用字。

- 一些網路民間的常用字和發音並非教育部標準，或兩種用字或發音（又音）都可的情形，單個字的話，字典有的發音多直接收錄，但詞的話，由於可能會延伸到有用到此字之眾多詞彙，而產生太多冷門發音的詞條，影響出字，故尚有許多待考釐清。

- 「詞」原則上以臺灣為主，但上列原因，碼表中也存有許多對岸發音，且媒體日常影響，有些發音也不知該不該刪減，如不刪減，是否要補充沒附加到之相關詞彙發音？

- 大量原 phrases.cht.dict.yaml 無附加拼音之詞彙，為避免破音字因素，曾使用網路工具轉成帶拼音並存入 phrases.chtp.dict.yaml 中，其中因轉換之故，存有許多錯誤拼音和用字。

- 「詞」的「變音」（變調）很是頭大，〈[教育部重編國語辭典](http://dict.revised.moe.edu.tw/cbdic/)〉裡（[萌典](https://www.moedict.tw/)所引用之辭典）含有許多這類詞彙發音，而網路上許多碼表更是大量引用此類發音，包含官方原版 terra_pinyin.dict.yaml，不能說是錯誤，只是一般人打字時多不會有如此變音之習慣，但「不：ㄅㄨˋ ㄅㄨˊ」「一：ㄧˊ ㄧˋ」「親屬稱謂 輕聲」等之變音，一般倒是常慣用，如有注意，會把這些常見變音都新增上，其他變音則於 202101 全改為字典中單字有的發音。

- 202012 把「詞」中含有的輕聲變調和部分大陸獨有發音從 terra_pinyin_onion.dict.yaml 和 phrases.chtp.dict.yaml 兩檔移動到新建的 phrases.chtpp.dict.yaml，方案預設不啟用該檔。

《字》

- 後來增補字典檔中沒有的 Big5E、HKSCS、JIS 共一千四百多字，多為 香港 日本 用字，經查許多字並無國語發音，故香港用字如字典中查不到，會查其粵語發音，然後反推該粵語發音有哪些字，以此來標註其發音。日本用字如查無發音，多以偏旁發音來標註。

- 接續上條目，增補過程，曾引用〈[全字庫](https://www.cns11643.gov.tw/)〉，但後來發現〈[全字庫](https://www.cns11643.gov.tw/)〉對於罕見字錯誤眾多，查找其他多本線上中文字典，幾乎不可能為該發音，故後來捨棄引用〈[全字庫](https://www.cns11643.gov.tw/)〉，並返回修改引用〈[全字庫](https://www.cns11643.gov.tw/)〉遺留下錯誤發音標註，但可能尚留有錯誤引用。

- 許多字發音補充引用各家線上字典，過程發現〈[古今文字集成](http://www.ccamc.co/)〉其中「漢語大字典」其發音，其他字典皆沒有，雖不像〈[全字庫](https://www.cns11643.gov.tw/)〉經查基本就認定為錯誤發音，但太寬泛且獨門。〈[教育部異體字字典](https://dict.variants.moe.edu.tw/)〉很多字的發音也很寬泛和獨門，因附考據，且一開始發現缺漏就補，故延舊作法發現缺漏則補上。對〈[漢語大字典(白雲深處人家)](https://homeinmists.ilotus.org/hd/hydzd.php)〉獨有發音，還在猶豫是否增加或刪除，前面已經增加很多此發音，也刪過一些此字典有的冷門發音。官方原版 terra_pinyin.dict.yaml 也有相同之發音。後來發現少數日常慣用發音只在〈[漢語大字典(白雲深處人家)](https://homeinmists.ilotus.org/hd/hydzd.php)〉有收錄，雖更多的是獨門發音，還是決定收錄該字典發音。

- 〈[古今文字集成](http://www.ccamc.co/)〉裡面有註解「漢語大字典」之發音，但大量查找後，發現不一定如實，像一聲「ˉ」偶會被辨別成三聲「ˇ」等之類的錯誤，還是要到〈[漢語大字典(白雲深處人家)](https://homeinmists.ilotus.org/hd/hydzd.php)〉確認。

《2021修改字詞彙發音》

- 比對詞彙單個字的發音，修正為方案字典中單字有的發音，符合一般輸入法習慣，故詞彙發音可能與某些詞典中的發音不同，例：〈[萌典](https://www.moedict.tw/)〉和〈[教育部重編國語辭典](http://dict.revised.moe.edu.tw/cbdic/)〉就有大量該類詞彙。換句話說，詞句中變調等之發音不收錄，改為字典中單個字有的發音，原變調或錯誤之發音等詞彙轉到 phrases.chtpp.dict.yaml 該檔；如詞彙中單個字的發音在以下比對之字典有的，但方案字典沒有，則補上。

## 比對參考字典

- 主要：

    * 〈[萌典](https://www.moedict.tw/)〉

    * 〈[教育部異體字字典](https://dict.variants.moe.edu.tw/variants/rbt/home.do)〉
       
    * 〈[古今文字集成](http://www.ccamc.co/)〉
    
    * 〈[漢語大字典(白雲深處人家)](https://homeinmists.ilotus.org/hd/hydzd.php)〉

- 補充：
    
    * 〈[叶典](http://yedict.com/)〉
    
    * 〈[漢典](https://www.zdic.net/)〉
    
    * 〈[文學網-在線新華字典](https://zd.hwxnet.com/)〉
    
    * 〈[漢語大字典(ivantsoi)](https://ivantsoi.ddns.net/hydzd/search.html)〉（失效）

