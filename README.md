# 電腦 Rime 洋蔥方案（注音、雙拼、拼音、形碼、行列30）

####  ※ 請勿使用於商業營利相關行為
####  ※ Commercial use is prohibited

## 內容說明：
- allfiles 包含九個主方案（三個注音、一個注音雙拼、一個拼音、三個形碼、一個行列30）和一眾掛接方案

- 三個形碼方案已刪除碼表內容，無法使用！

- 掛接方案包含：拉丁字母（含音標）、希臘字母、西里爾（俄）字母、全形數字字母、Easy 英文（含註釋字典）、日文（含漢字）、兩個韓文（HNC和形碼，含單音含漢字）、 注音文、Emoji 顏文字符號系列集等。

- 為易更新，不用同一檔案更新數次，allfiles 裡文件不以方案區分。

- 提供 sort_rime_file.py，把所需 Rime 文件放到各個方案資料夾。

## sort_rime_file.py 使用方法：
- 本倉庫 Onion_Rime_Files 按右上綠色 〔↓Code〕 ⇨ Download ZIP ⇨ 解壓縮 ZIP 進入資料夾 ⇨ Python 執行 sort_rime_file.py ⇨ 產生『電腦RIME方案_{當天日期}』資料夾

- 『電腦RIME方案_{當天日期}』，各個方案所需文件，分別放置於下層『方案名稱』資料夾。

- 選取欲使用方案，內含文件通通放入『 Rime 』用戶設定資料夾，如已有 opencc 資料夾，移動 opencc 裡面檔案到 opencc 資料夾內，沒有則整個 opencc 移過去，「重新部署」方可。

  > 《 Windows 用戶注意！》「注音（洋蔥 plus 版）」和「注音（洋蔥 mix‧in 版）」掛接《Easy》，用提示碼作英漢字典，Windows 整頁提示碼太多程式會崩潰！提供 custom 檔給 Windows 用戶，以正則簡化提示碼，防崩潰， Mac 用戶勿使用。

  > 承上，分別於「`plus注音_防崩潰：Win必加，Mac勿加`」和「`mixin注音_同顯2修改檔(Win)`」資料夾內，把資料夾內 .custom.yaml 檔拖至上一層，與方案文件同一層，按「重新部署」方可。

  > Linux 反饋問題很多，一看其 Rime 核心 librime 過舊，librime-lua 掛件也缺失！不可能回退使功能打折去符合舊版核心寫法！方案皆以 Mac 鼠鬚管官方最新封裝版本為實作基礎。
  
  > 使用 Windows 小狼毫官方最新封裝版本，方案內有 rime.lua 該檔，建議更換最新官方封裝 [librime 核心](https://github.com/rime/librime/releases)！早期 librime-lua 版本使用遍尋候選項會產生記憶體洩漏，更新版已解決。

- 方案放置路徑：

  > 別放錯資料夾，反饋有人放錯放到程式預設方案資料夾！雖可使用，但會產生 Bug。

```
%APPDATA%\Rime  ( Windows 小狼毫 )
~/Library/Rime  ( Mac OS 鼠鬚管 )
~/.config/ibus/rime  ( Linux 中州韻 )
~/.config/fcitx/rime  ( Linux )
```

## Rime 入門需知：

- [Wiki 說明連結](https://github.com/oniondelta/Onion_Rime_Files/wiki/Rime-%E5%85%A5%E9%96%80%E9%9C%80%E7%9F%A5)

## Rime 方案安裝與修改：

  > 於本頁下載，安裝前，先用 Python 執行 sort_rime_file.py 分類方案文件。

- [Wiki 說明連結](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E6%B4%8B%E8%94%A5%E7%89%88%E9%9B%BB%E8%85%A6-Rime-%E6%96%B9%E6%A1%88%E5%AE%89%E8%A3%9D%E8%88%87%E4%BF%AE%E6%94%B9)

## 各方案說明：

  > 202203 韓文改成 HNC 羅馬字輸入方式。

- [電腦 RIME 輸入法『注音（洋蔥 純注音 版）』](https://deltazone.pixnet.net/blog/post/264319309)

- [電腦 RIME 輸入法『注音（洋蔥 plus 版）』](https://deltazone.pixnet.net/blog/post/343650692)

- [電腦 RIME 輸入法『注音（洋蔥 mix‧in 版）』](https://deltazone.pixnet.net/blog/post/347368709)

- [電腦 RIME 輸入法『注音（洋蔥 雙拼 版）』](https://deltazone.pixnet.net/blog/post/359775341)

- [電腦 RIME 輸入法〖 地球拼音（洋蔥 mix‧in 版）〗](https://deltazone.pixnet.net/blog/post/353697089)

- [電腦 RIME 設定檔〖 行列 30（洋蔥版）〗](https://deltazone.pixnet.net/blog/post/361766142)

## Demo：

- 注音（洋蔥 mix-in 版）
  
  > 集大成，多國語言和注音混打輸入 😃！
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/demo_bpmf_mixin.gif)
  
- 注音（洋蔥 plus 版）

  > 功能多，除外語還有一堆功能和細節增加，輸入手感和純注音版一樣，即使沒用外語，也推薦使用！
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/demo_bpmf_plus.gif)
  
- 注音（洋蔥 純注音 版）
  
  > 精簡功能，給新手或測試使用
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/demo_bpmf_pure.gif)
 
## Keys：
 
- 注音（洋蔥 雙拼 版）鍵位
  > 無加 custom 可簡拼，有 custom 為一般雙拼每字須鍵兩碼（聲調可省略）

  #### <img src="https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/allfiles/%E9%9B%99%E6%8B%BC%E6%B3%A8%E9%9F%B3%E9%8D%B5%E4%BD%8D%E8%AA%AA%E6%98%8E%E5%9C%96%E7%A4%BA/%E6%B3%A8%E9%9F%B3%E6%B4%8B%E8%94%A5%E9%9B%99%E6%8B%BC%E8%AA%AA%E6%98%8E.png" width = "595" alt="image" align=left />

  <br><br><br><br><br><br><br><br><br><br>

- 注音（洋蔥 plus 版）鍵位

  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/bpmf_plus_keyboard.png)

- 注音（洋蔥 mixin 版）鍵位

  > 四個衍伸方案：「1」標準版、「2」只有後綴易懂、「3」語言分野最明減少撞碼、「4」集中下排手順最好

  > 本人多使用「4」，因較喜歡鍵盤下排之手順，也推薦「3」

  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/bpmf_mixin_1_keyboard.png)
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/bpmf_mixin_2_keyboard.png)
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/bpmf_mixin_3_keyboard.png)
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/bpmf_mixin_4_keyboard.png)
  
- 注音洋蔥版選字鍵位

  #### <img src="https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/master/img/bpmf_select_keys_keyboard.png" width = "595" alt="image" align=left />

<br><br><br><br><br><br><br><br><br>

## 贊助 Donate：

  > 從第一個方案上傳已持續更新五年以上！方案從頭到尾大改、新創、新增非常多功能！且做了許多圖文說明！花了族繁不及備載的心力！

  > 懇請贊助 (Donate) 支持，讓 Rime 洋蔥的一系列方案更新更有動力！

- [按此以〈綠界〉贊助 Donate：](https://p.ecpay.com.tw/D555162)

  #### [![donate1](https://payment.ecpay.com.tw/Upload/QRCode/202010/QRCode_170c287e-2db8-4b50-b87f-8d36500a3958.png)](https://p.ecpay.com.tw/D555162)

- [按此以〈歐付寶〉贊助 Donate：](https://qr.opay.tw/q1ql7)

  #### [![donate2](https://payment.opay.tw/Upload/Broadcaster/2294343/QRcode/QRCode_7AC0FA1CAD39F0B66CFD5513A2173D1A.png)](https://qr.opay.tw/q1ql7)

