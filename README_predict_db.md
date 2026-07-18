# predict.db 預測（聯想）詞引用說明

此 predict.db 為 librime-predict 預測（聯想）詞之詞庫檔。

已處理太多字詞典，功能又不斷修正疊加，沒想太折騰，故直接引用網友大大所作檔案，因有引用，於此說明並致謝。

後來發現其預測（聯想）詞，在轉換簡體功能時會有瑕疵，開頭字為簡體時無法預測（聯想），故又再大折騰，重新編排彙整預測（聯想）詞庫，使其正常。

## predict-office-zht.db（官方）

出處：https://github.com/rime/librime-predict/releases

原檔名：predict.db（先用 opencc 轉換為台灣繁體，以此為主，再轉換為簡體，末尾增加其開頭為簡體之詞條）

## predict-kenspc-zht.db

出處：https://github.com/kenspc/rime-predict-zh/tree/main/dist

原檔名：predict-zht.db（末尾增加用 opencc 轉換為簡體，其開頭為簡體之詞條）

## predict.db 生成方法

[Wiki 說明連結](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E8%A3%BD%E4%BD%9C-librime%E2%80%90predict-%E8%81%AF%E6%83%B3%E8%A9%9E-predict.db)

## 致謝

感謝 kenspc 和 Rime 官方。
