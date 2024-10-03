# 電腦 Rime 洋蔥方案（注音、雙拼、拼音、形碼、行列30）

####  ※ 請勿使用於商業營利相關行為
####  ※ Commercial use is prohibited

## 內容說明

- allfiles 包含九個主方案和一眾掛接方案。

- 主方案：三個注音、一個注音雙拼、一個拼音、三個形碼、一個行列30。

- 掛接方案：拉丁字母（含音標）、希臘字母、西里爾（俄）字母、全形數字字母、Easy 英文（英漢字典）、日文（含漢字）、兩個韓文（HNC和形碼，含單音和漢字）、 注音文、Emoji 顏文字符號系列集等。

- 為易更新，不用同一檔案更新數次，allfiles 裡文件不以方案區分。

- 提供 sort_rime_file.py，把所需 Rime 文件放到各個方案資料夾。

- 本倉庫 Releases 中，有分類好之檔案。（不一定更到最新）

- 本倉庫 Actions 中，其 sort_rime_output 裡 artifact 有已跑好 sort_rime_file.py 分類之檔案！（不一定更到最新，需登錄 GitHub 帳號）

## sort_rime_file.py 使用方法

- 本倉庫 Onion_Rime_Files 按右上綠色 〔↓Code〕 ⇨ Download ZIP ⇨ 解壓縮 ZIP 進入資料夾 ⇨ Python 執行 sort_rime_file.py ⇨ 產生『電腦RIME方案_{當天日期}』資料夾

- 『電腦RIME方案_{當天日期}』，各個方案所需文件，分別放置於下層『方案名稱』資料夾。

- 選取欲使用方案，內含文件通通放入『 Rime 』用戶設定資料夾，如已有 opencc 資料夾，移動 opencc 裡面檔案到 opencc 資料夾內，沒有則整個 opencc 移過去，「重新部署」方可。

- 方案放置路徑：

  > 別放錯資料夾，反饋有人放錯放到程式預設方案資料夾！有些方案會因 lua 無法執行產生 Bug。

  > ```
  > %APPDATA%\Rime  ( Windows 小狼毫 )
  > ~/Library/Rime  ( Mac OS 鼠鬚管 )
  > ~/.config/ibus/rime  ( Linux 中州韻 )
  > ~/.config/fcitx/rime  ( Linux )
  > ~/.local/share/fcitx5/rime ( Linux )
  > ```

- Linux、Win、Mac 皆需注意核心 librime 版本問題：

  > Linux 反饋問題很多，其 Rime 核心 librime 過舊，librime-lua 掛件缺失！不可能回退使功能打折去符合舊版核心寫法！

  > 20231110後，Mac 和 Win 用官方發布（release）的主程式即可！以下為之前各版本，其組件版本不一造成不相容時之說明。

  > 原先方案以 Mac 鼠鬚管官方最新編譯版本為實作基礎，後來放飛使用新版 librime 核心和 librime-lua 掛件的新功能、新函數。如不符合，則需更換或編譯含最新版 librime-lua 的 librime 核心才能確保完整運行所有功能。[核心更換方法](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E6%8E%A8%E8%96%A6-Rime-%E4%B8%BB%E7%A8%8B%E5%BC%8F%E5%AE%89%E8%A3%9D%E4%B9%8B%E7%89%88%E6%9C%AC%E5%92%8C%E6%96%B9%E6%B3%95)。20230130 官方推出[鼠鬚管 0.16.1 新版](https://github.com/rime/squirrel/releases)，可相容。
  
  > 承上，有二個非注音方案確定使用最新 librime-lua 函數去達成功能，其他方案也不追求相容舊版，只確保這邊 Windows 和 Mac 兩者皆可正常運行出功能。
  
  > 先前 Windows 小狼毫官方多年未更新，核心和 librime-lua 版本陳舊，推薦使用網友修改封裝版：[fxliang](https://github.com/fxliang/weasel)；近期官方 [小狼毫](https://github.com/rime/weasel) 更新，也可使用。
  
  > 總結：20230130 目前方案編輯使用的版本：librime 1.8.3、librime-lua 200。由於 Rime 官方、librime-lua 官方、本方案皆不斷更新，需注意版本，才好相容。

## Rime 入門需知

- [Wiki 說明連結](https://github.com/oniondelta/Onion_Rime_Files/wiki/Rime-%E5%85%A5%E9%96%80%E9%9C%80%E7%9F%A5)

## 推薦 Rime 主程式安裝之版本和方法

- [Wiki 說明連結](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E6%8E%A8%E8%96%A6-Rime-%E4%B8%BB%E7%A8%8B%E5%BC%8F%E5%AE%89%E8%A3%9D%E4%B9%8B%E7%89%88%E6%9C%AC%E5%92%8C%E6%96%B9%E6%B3%95)

## Rime 方案安裝與修改

- [Wiki 說明連結](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E6%B4%8B%E8%94%A5%E7%89%88%E9%9B%BB%E8%85%A6-Rime-%E6%96%B9%E6%A1%88%E5%AE%89%E8%A3%9D%E8%88%87%E4%BF%AE%E6%94%B9)

## 各方案說明

- [電腦 RIME 輸入法『注音（洋蔥 純注音 版）』](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%8E-%E6%B3%A8%E9%9F%B3-%E6%B4%8B%E8%94%A5-%E7%B4%94%E6%B3%A8%E9%9F%B3-%E7%89%88-%E3%80%8F%E6%96%B9%E6%A1%88%E8%AA%AA%E6%98%8E)

- [電腦 RIME 輸入法『注音（洋蔥 plus 版）』](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%8E-%E6%B3%A8%E9%9F%B3-%E6%B4%8B%E8%94%A5-plus-%E7%89%88-%E3%80%8F%E6%96%B9%E6%A1%88%E8%AA%AA%E6%98%8E)

- [電腦 RIME 輸入法『注音（洋蔥 mix‧in 版）』](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%8E-%E6%B3%A8%E9%9F%B3-%E6%B4%8B%E8%94%A5-mixin-%E7%89%88-%E3%80%8F%E6%96%B9%E6%A1%88%E8%AA%AA%E6%98%8E)

- [電腦 RIME 輸入法『注音（洋蔥 雙拼 版）』](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%8E-%E6%B3%A8%E9%9F%B3-%E6%B4%8B%E8%94%A5-%E9%9B%99%E6%8B%BC-%E7%89%88-%E3%80%8F%E6%96%B9%E6%A1%88%E8%AA%AA%E6%98%8E)

- [電腦 RIME 輸入法〖 地球拼音（洋蔥 mix‧in 版）〗](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%8E-%E5%9C%B0%E7%90%83%E6%8B%BC%E9%9F%B3-%E6%B4%8B%E8%94%A5-mixin-%E7%89%88-%E3%80%8F%E6%96%B9%E6%A1%88%E8%AA%AA%E6%98%8E)

- [電腦 RIME 設定檔〖 行列 30（洋蔥版）〗](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%8E-%E6%B4%8B%E8%94%A5%E7%89%88-%E8%A1%8C%E5%88%9730-%E3%80%8F%E6%96%B9%E6%A1%88%E8%AA%AA%E6%98%8E)

- [電腦 RIME 設定檔〖 形碼（洋蔥 plus 版）〗](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%8E-%E6%B4%8B%E8%94%A5%E7%89%88-%E5%BD%A2%E7%A2%BC-plus-%E7%89%88-%E3%80%8F%E6%96%B9%E6%A1%88%E8%AA%AA%E6%98%8E)

- [電腦 RIME 設定檔〖 形碼（洋蔥 mix‧in 版）〗](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%8E-%E6%B4%8B%E8%94%A5%E7%89%88-%E5%BD%A2%E7%A2%BC-mixin-%E7%89%88-%E3%80%8F%E6%96%B9%E6%A1%88%E8%AA%AA%E6%98%8E)

## 注音系列功能說明

- [標點符號](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%94%E6%B4%8B%E8%94%A5%E6%B3%A8%E9%9F%B3%E7%B3%BB%E5%88%97%E3%80%95%EF%BC%9A%E6%A8%99%E9%BB%9E%E7%AC%A6%E8%99%9F)

- [功能鍵和快捷鍵](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%94%E6%B4%8B%E8%94%A5%E6%B3%A8%E9%9F%B3%E7%B3%BB%E5%88%97%E3%80%95%EF%BC%9A%E5%8A%9F%E8%83%BD%E9%8D%B5%E5%92%8C%E5%BF%AB%E6%8D%B7%E9%8D%B5)

- [簡體與字符範圍和編碼](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%94%E6%B4%8B%E8%94%A5%E6%B3%A8%E9%9F%B3%E7%B3%BB%E5%88%97%E3%80%95%EF%BC%9A%E7%B0%A1%E9%AB%94%E8%88%87%E5%AD%97%E7%AC%A6%E7%AF%84%E5%9C%8D%E5%92%8C%E7%B7%A8%E7%A2%BC)

- [注音文](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%94%E6%B4%8B%E8%94%A5%E6%B3%A8%E9%9F%B3%E7%B3%BB%E5%88%97%E3%80%95%EF%BC%9A%E6%B3%A8%E9%9F%B3%E6%96%87)

- [系列符號與 Emoji](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%94%E6%B4%8B%E8%94%A5%E6%B3%A8%E9%9F%B3%E7%B3%BB%E5%88%97%E3%80%95%EF%BC%9A%E7%B3%BB%E5%88%97%E7%AC%A6%E8%99%9F%E8%88%87-Emoji)

- [Lua 特殊功能集](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%94%E6%B4%8B%E8%94%A5%E6%B3%A8%E9%9F%B3%E7%B3%BB%E5%88%97%E3%80%95%EF%BC%9ALua-%E7%89%B9%E6%AE%8A%E5%8A%9F%E8%83%BD%E9%9B%86)

- [短語](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E3%80%94%E6%B4%8B%E8%94%A5%E6%B3%A8%E9%9F%B3%E7%B3%BB%E5%88%97%E3%80%95%EF%BC%9A%E7%9F%AD%E8%AA%9E)

## Demo

- 注音（洋蔥 mix-in 版）
  
  > 集大成，多國語言和注音一次性混打輸入 😃！
  
    ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/img/demo_bpmf_mixin.gif)
  
- 注音（洋蔥 plus 版）

  > 功能多，除外語還有一堆功能和細節增加，輸入手感和純注音版一樣，即使沒用外語，也推薦使用！
  
    ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/img/demo_bpmf_plus.gif)
  
- 注音（洋蔥 純注音 版）
  
  > 精簡功能，給新手或測試使用
  
    ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/img/demo_bpmf_pure.gif)
 
## Keys
 
- 注音（洋蔥 雙拼 版）鍵位
  > 無加 custom 可簡拼，有 custom 為一般雙拼每字須鍵兩碼（聲調可省略）

  #### <img src="https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/allfiles/%E9%9B%99%E6%8B%BC%E6%B3%A8%E9%9F%B3%E9%8D%B5%E4%BD%8D%E8%AA%AA%E6%98%8E%E5%9C%96%E7%A4%BA/%E6%B3%A8%E9%9F%B3%E6%B4%8B%E8%94%A5%E9%9B%99%E6%8B%BC%E8%AA%AA%E6%98%8E.png" width = "595" alt="image" /><br>

- 注音（洋蔥 plus 版）鍵位

  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/img/bpmf_plus_keyboard.png)

- 注音（洋蔥 mixin 版）鍵位

  > 四個衍伸方案：「1」標準版、「2」只有後綴易懂、「3」語言分野最明減少撞碼、「4」集中下排手順最好

  > 本人多使用「4」，因較喜歡鍵盤下排之手順，也推薦「3」

  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/img/bpmf_mixin_1_keyboard.png)
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/img/bpmf_mixin_2_keyboard.png)
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/img/bpmf_mixin_3_keyboard.png)
  
  #### ![image](https://raw.githubusercontent.com/oniondelta/Onion_Rime_Files/main/img/bpmf_mixin_4_keyboard.png)
  
- 注音洋蔥版選字鍵位

  #### <img src="https://user-images.githubusercontent.com/54584047/236190921-a2c86863-ed81-4a28-ae37-07566aa9c3a9.png" width = "595" alt="image" /><br>

## 贊助 Donate

方案已持續更新六年以上！大改、新創、新增非常多功能！做了許多圖文說明！花了族繁不及備載的心力！

贊助 (Donate) 支持，讓 Rime 洋蔥一系列方案更新更有動力！

- #### [以〈綠界〉贊助 Donate](https://p.ecpay.com.tw/D555162)

    [![donate1](https://payment.ecpay.com.tw/Upload/QRCode/202010/QRCode_170c287e-2db8-4b50-b87f-8d36500a3958.png)](https://p.ecpay.com.tw/D555162)

- #### [以〈歐付寶〉贊助 Donate](https://qr.opay.tw/q1ql7)

    [![donate2](https://payment.opay.tw/Upload/Broadcaster/2294343/QRcode/QRCode_7AC0FA1CAD39F0B66CFD5513A2173D1A.png)](https://qr.opay.tw/q1ql7)

