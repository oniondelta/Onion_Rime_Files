# Win_小狼毫主程式

### 說明：

- 本安裝檔和官網 https://rime.im/ 相同。但官方後來又釋出相同版本號之檔案 https://github.com/rime/weasel/releases ，可能更新了 librime 引擎？未測試！

### 安裝後建議修改：
    
- 置換新版 librime 引擎：
    - 官網 https://rime.im/ 下載 0.14.3 版，其中 librime 在使用 lua 某些功能會產生記憶體泄漏問題，強烈建議更換。
    - rime-with-plugins-1.7.3-win32.zip ⇨ dist ⇨ lib ⇨ 提取 rime.dll ⇨ 取代 C:\Program Files (x86)\Rime\weasel-0.14.3\rime.dll ⇨《重開機》！
    - 如 Windows 出現執行中無法取代等訊息，於工作列點右鍵 ⇨《工作管理員》⇨點選《小狼毫算法服務》並結束工作，即可取代！
    
### 可到官網 https://rime.im/ 下載安裝檔。

