# Win_舊0.14.3.0版小狼毫主程式

### 安裝後建議修改
    
- 置換新版 librime 引擎：
    - 官網 https://rime.im/ 或 [releases](https://github.com/rime/weasel/releases) 之 0.14.3 版，其附加舊版 librime-lua 在使用某些函數，會產生記憶體泄漏，建議更換。
    - rime-08dd95f-Windows.7z ⇨ dist ⇨ lib ⇨ 提取 rime.dll ⇨ 取代 C:\Program Files (x86)\Rime\weasel-0.14.3\rime.dll ⇨《重開機》！
    - 如 Windows 出現執行中無法取代等訊息，於工作列點右鍵 ⇨《工作管理員》⇨點選《小狼毫算法服務》並結束工作，即可取代！

### Source File

- https://github.com/rime/weasel/releases

- https://github.com/rime/librime/releases

### Version Info (置換 librime 核心後)：

- Weasel 0.14.3

- librime 1.8.5

- librime-lua #200

### plugins

- librime-lua

- librime-octagram

- librime-charcode


