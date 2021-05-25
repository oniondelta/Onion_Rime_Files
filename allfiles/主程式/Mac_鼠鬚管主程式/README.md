# Mac_鼠鬚管主程式

### 安裝：

- 解壓縮 ⇨ 執行 Squirrel.pkg 安裝檔
（在預設輸入法中會有 鼠鬚管 選項，如沒有：「打開鍵盤偏好」 ⇨ 「+」「簡體中文」 ⇨ 選取 鼠鬚管 加入！）


### 安裝後建議修改：
    
- 修改鼠鬚管 App 使 OS 默認 Squirrel 為繁體中文：
    - 鼠鬚管 0.14.0 版推薦可修改，但 0.15.1 之後的版本，修改後會產生問題！建議不要更改！
    - 最新的鼠鬚管 0.15.2 版，實測一些軟體（如：Word ），默認會是繁體，看似也不需要修改！
    - 於 /Library/Input Methods/Squirrel.app/Contents/Info.plist 把 Info.plist 中唯一的 \<string>zh\</string> 改成 \<string>zh-Hant\</string> ⇨ 《重開機》。

- 置換新版 librime 引擎：
    - 原鼠鬚管 0.14.0 版其中 librime 在使用 lua 某些功能會產生記憶體泄漏問題，強烈建議更換。
    - 鼠鬚管 0.15.1 之後的版本，輸入時會因選字單或上方 preedit ，其不同字體有不同字身框大小，產生跳動情形，不想跳動可安裝 0.14.0 版然後置換 librime 核心。如不在意跳動，直接上官網下載最新版。
    - rime-with-plugins-1.7.3-osx.zip ⇨ dist ⇨ lib ⇨ 提取 librime.1.dylib ⇨ 取代 /Library/Input Methods/Squirrel.app/Contents/Frameworks/librime.1.dylib ⇨《重開機》！

### 可到官網 https://rime.im/ 下載最新版安裝檔。

