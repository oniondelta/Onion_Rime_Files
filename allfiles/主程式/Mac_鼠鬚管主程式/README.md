# Mac_鼠鬚管主程式

### 安裝：

- 解壓縮 ⇨ 執行 Squirrel.pkg 安裝檔
（可能需要：「打開鍵盤偏好」 ⇨ 「+」「簡體中文」 ⇨ 選取 鼠鬚管 加入！）


### 安裝後建議修改：

- 修改 App 中 essay.txt（八股文）檔案，符合台灣用字用詞：
    - 於 /Library/Input Methods/Squirrel.app/Contents/SharedSupport/ 置換 essay.txt（八股文） ⇨《重新部署》。
    
- 修改 App 使 OS 默認 Squirrel 為繁體中文：
    - 於 /Library/Input Methods/Squirrel.app/Contents/Info.plist 把 Info.plist 中的 zh 改成 zh-Hant ⇨ 《重開機》。

- 置換新版 librime 引擎：
    - 原 librime 在使用 lua 某些功能會產生記憶體泄漏問題，建議更換。
    - rime-with-plugins-1.6.1-osx ⇨ dist ⇨ lib ⇨ 提取 librime.1.dylib ⇨ 取代 /Library/Input Methods/Squirrel.app/Contents/Frameworks/librime.1.dylib ⇨《重開機》！

### 可到官網 https://rime.im/ 下載安裝檔。

