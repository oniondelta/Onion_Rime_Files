--[[
可快捷開啟（join/joint）檔案/程式/網址 列表。
只限起始輸入「前綴」「j」「開啟碼」。開啟碼限英文[a-z]+。
（限起始輸入：防止輸入長碼，未上屏後接 Lua 功能時，誤按整個長碼跳掉）
注意！單碼會有劫碼情形，如：「p」已設定開啟某檔，p[a-z]將無法輸入開啟。
設定「開啟碼」規律（非強制性設定）：「f」為開啟檔案、「w」為開啟網址、「a」為開啟 app。
「ft」「fc」兩鍵位已使用。
修改後需「重新部署」才可生效。
--]]

local op_pattern = {
  -- ["開啟碼"] = "檔案or程式or網址位置",
--------------------------------------------------------------------------
--------------------------------------------------------------------------
  ["wr"] = "https://github.com/rime",
  ["wo"] = "https://github.com/oniondelta/Onion_Rime_Files",
  ["wwo"] = "https://github.com/oniondelta/Onion_Rime_Files/wiki",
--------------------------------------------------------------------------
--------------------------------------------------------------------------
  -- ["ac"] = "/System/Applications/Calculator.app",           -- mac 專用：計算機
  -- ["at"] = "/System/Applications/TextEdit.app",             -- mac 專用：文字編輯
  -- ["ad"] = "/System/Applications/Dictionary.app",           -- mac 專用：字典
  -- ["ac"] = "/Applications/CotEditor.app",                   -- mac 專用：一般 app
  -- ["as"] = "/Applications/Sublime' 'Text.app",              -- mac 專用：路徑中空格用「' '」標示
  -- ["as"] = "/Applications/Sublime\\ Text.app",              -- mac 專用：路徑中空格用「\\ 」標示
--------------------------------------------------------------------------
  -- ["wr"] = "-a '/Applications/Firefox.app' https://github.com/rime",                               -- mac 專用：指定程式開啟
  -- ["wo"] = "-a '/Applications/Firefox.app' https://github.com/oniondelta/Onion_Rime_Files",        -- mac 專用：指定程式開啟
  -- ["wwo"] = "-a '/Applications/Firefox.app' https://github.com/oniondelta/Onion_Rime_Files/wiki",  -- mac 專用：指定程式開啟
--------------------------------------------------------------------------
  -- ["ft"] = "-a '/Applications/CotEditor.app' /Users/使用者名稱/test.txt",     -- mac 專用：指定程式開啟
  -- ["ft"] = "-a '/Applications/Sublime Text.app' /Users/使用者名稱/test.txt",  -- mac 專用：指定程式開啟（此處程式名稱空格不用更動）
--------------------------------------------------------------------------
--------------------------------------------------------------------------
  -- ["ac"] = [["C:\WINDOWS\system32\calc.exe"]],              -- win 專用：計算機
  -- ["an"] = [["C:\WINDOWS\system32\notepad.exe"]],           -- win 專用：記事本
  -- ["ap"] = [["C:\WINDOWS\system32\mspaint.exe"]],           -- win 專用：小畫家
  -- ["aa"] = [["C:\Program Files\Notepad++\notepad++.exe"]],  -- win 專用：路徑中空格不用更動
--------------------------------------------------------------------------
--------------------------------------------------------------------------
 }

return op_pattern