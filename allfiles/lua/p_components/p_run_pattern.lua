--[[
快捷開啟（join/joint）檔案/程式/網址之列表。

- 限起始輸入「前綴」「j」「開啟碼」「上屏鍵」。（限起始輸入：防止輸入長碼，未上屏後接 Lua 功能時，誤按使整個長碼跳掉）
- 「開啟碼」限英文 [a-z]+。
- 「t」「c」兩鍵位已使用於開啟方案內設文件，避免為「開啟碼」。
- 多個同編碼的「開啟碼」，以後面條目為用。
- Win 中 open = "路徑"，其路徑名稱包含「中文（非ASCII編碼）」可能無法開啟。
- s = "數字"，為「前綴」「j」提示選單中的順序，如相同以「開啟碼」排序。

- 修改後需「重新部署」才可生效。
--]]

local run_pattern = {
  -- ["開啟碼"] = { s = "提示選單上的排序", name = "檔案/程式/網址：名稱", open= "檔案/程式/網址位：路徑和相關參數(如：指定開啟程式)" },
--------------------------------------------------------------------------
-- 通用：
--------------------------------------------------------------------------
  ["r"] = { s = 1, name = "Rime 官方 GitHub", open = "https://github.com/rime" },
  ["rw"] = { s = 2, name = "Rime 詳解", open = "https://github.com/LEOYoon-Tsaw/Rime_collections/blob/master/Rime_description.md" },
  ["l"] = { s = 3, name = "librime-lua 官方 GitHub", open = "https://github.com/hchunhui/librime-lua" },
  ["lw"] = { s = 4, name = "librime-lua 腳本開發指南", open = "https://github.com/hchunhui/librime-lua/wiki/Scripting" },
  ["o"] = { s = 5, name = "Onion 洋蔥 GitHub", open = "https://github.com/oniondelta/Onion_Rime_Files" },
  ["ow"] = { s = 6, name = "Onion 洋蔥 GitHub Wiki", open = "https://github.com/oniondelta/Onion_Rime_Files/wiki" },
--------------------------------------------------------------------------
-- Mac：
--------------------------------------------------------------------------
  -- ["r"] = { s = 1, name = "Rime 官方 GitHub Ⓕ", open = "-a '/Applications/Firefox.app' https://github.com/rime" },                                                     -- mac 專用：指定程式開啟
  -- ["rw"] = { s = 2, name = "Rime 詳解 Ⓕ", open = "-a '/Applications/Firefox.app' https://github.com/LEOYoon-Tsaw/Rime_collections/blob/master/Rime_description.md" },  -- mac 專用：指定程式開啟
  -- ["l"] = { s = 3, name = "librime-lua 官方 GitHub Ⓕ", open = "-a '/Applications/Firefox.app' https://github.com/hchunhui/librime-lua" },                              -- mac 專用：指定程式開啟
  -- ["lw"] = { s = 4, name = "librime-lua 腳本開發指南 Ⓕ", open = "-a '/Applications/Firefox.app' https://github.com/hchunhui/librime-lua/wiki/Scripting" },              -- mac 專用：指定程式開啟
  -- ["o"] = { s = 5, name = "Onion 洋蔥 GitHub Ⓕ", open = "-a '/Applications/Firefox.app' https://github.com/oniondelta/Onion_Rime_Files" },                             -- mac 專用：指定程式開啟
  -- ["ow"] = { s = 6, name = "Onion 洋蔥 GitHub Wiki Ⓕ", open = "-a '/Applications/Firefox.app' https://github.com/oniondelta/Onion_Rime_Files/wiki" },                  -- mac 專用：指定程式開啟
--------------------------------------------------------------------------
  -- ["at"] = { s = 10, name = "文字編輯器", open = "/System/Applications/TextEdit.app" },               -- mac 專用：文字編輯
  -- ["ac"] = { s = 11, name = "計算機", open = "/System/Applications/Calculator.app" },                -- mac 專用：計算機
  -- ["ad"] = { s = 12, name = "字典", open = "/System/Applications/Dictionary.app" },                  -- mac 專用：字典
--------------------------------------------------------------------------
  -- ["ac"] = { s = 14, name = "CotEditor", open = "/Applications/CotEditor.app" },                    -- mac 專用：一般 app
  -- ["as"] = { s = 15, name = "Sublime", open = "/Applications/Sublime' 'Text.app" },                 -- mac 專用：路徑中空格用「' '」標示
  -- ["as"] = { s = 15, name = "Sublime", open = "/Applications/Sublime\\ Text.app" },                 -- mac 專用：路徑中空格用「\\ 」標示
--------------------------------------------------------------------------
  -- ["ft"] = { s = 16, name = "TEST", open = "-a '/Applications/CotEditor.app' /Users/使用者名稱/test.txt" },         -- mac 專用：指定程式開啟
  -- ["ft"] = { s = 17, name = "TEST", open = "-a '/Applications/Sublime Text.app' /Users/使用者名稱/test' '1.txt" },  -- mac 專用：指定程式開啟（此處前方路徑名稱空格不用更動，後方路徑空格需補「' '」或「\\ 」）
--------------------------------------------------------------------------
-- Win：
--------------------------------------------------------------------------
  -- ["r"] = { s = 1, name = "Rime 官方 GitHub Ⓕ", open = [["C:\Program Files (x86)\Mozilla Firefox\firefox.exe" https://github.com/rime]] },                                                     -- win 專用：指定程式開啟
  -- ["rw"] = { s = 2, name = "Rime 詳解 Ⓕ", open = [["C:\Program Files (x86)\Mozilla Firefox\firefox.exe" https://github.com/LEOYoon-Tsaw/Rime_collections/blob/master/Rime_description.md]] },  -- win 專用：指定程式開啟
  -- ["l"] = { s = 3, name = "librime-lua 官方 GitHub Ⓕ", open = [["C:\Program Files (x86)\Mozilla Firefox\firefox.exe" https://github.com/hchunhui/librime-lua]] },                              -- win 專用：指定程式開啟
  -- ["lw"] = { s = 4, name = "librime-lua 腳本開發指南 Ⓕ", open = [["C:\Program Files (x86)\Mozilla Firefox\firefox.exe" https://github.com/hchunhui/librime-lua/wiki/Scripting]] },              -- win 專用：指定程式開啟
  -- ["o"] = { s = 5, name = "Onion 洋蔥 GitHub Ⓕ", open = [["C:\Program Files (x86)\Mozilla Firefox\firefox.exe" https://github.com/oniondelta/Onion_Rime_Files]] },                             -- win 專用：指定程式開啟
  -- ["ow"] = { s = 6, name = "Onion 洋蔥 GitHub Wiki Ⓕ", open = [["C:\Program Files (x86)\Mozilla Firefox\firefox.exe" https://github.com/oniondelta/Onion_Rime_Files/wiki]] },                  -- win 專用：指定程式開啟
--------------------------------------------------------------------------
  -- ["ac"] = { s = 7, name = "計算機", open = [["C:\WINDOWS\system32\calc.exe"]] },                    -- win 專用：計算機
  -- ["ap"] = { s = 8, name = "小畫家", open = [["C:\WINDOWS\system32\mspaint.exe"]] },                 -- win 專用：小畫家
  -- ["at"] = { s = 9, name = "記事本", open = [["C:\WINDOWS\system32\notepad.exe"]] },                 -- win 專用：記事本
--------------------------------------------------------------------------
  -- ["an"] = { s = 10, name = "Notepad++", open = [["C:\Program Files\Notepad++\notepad++.exe"]] },  -- win 專用：路徑中空格不用更動
--------------------------------------------------------------------------
  -- ["ft"] = { s = 11, name = "TEST", open = [["C:\Program Files\Notepad++\notepad++.exe" C:\Users\使用者名稱\AppData\Roaming\Rime\rime.lua]] },         -- win 專用：指定程式開啟
  -- ["ft"] = { s = 12, name = "TEST", open = [["C:\Program Files\Sublime Text\sublime_text.exe"]].." "..[["C:\Users\使用者名稱\Desktop\test 1.txt"]] },  -- win 專用：指定程式開啟（此處前方路徑名稱空格不用更動，後方路徑空格需用特殊格式）
--------------------------------------------------------------------------
-- 測試用：
--------------------------------------------------------------------------
  -- ["rt"] = "https://github.com/rime",
  -- ["xt"] = { name = "缺省測試" },
  -- ["yt"] = { name = "油管", open = "https://www.youtube.com/" },
--------------------------------------------------------------------------
 }

-- print(run_pattern['r'].name)
-- print(run_pattern['r'].open)
-- print(run_pattern['o'].name)
-- print(run_pattern['o'].open)

-- print(run_pattern['no_item'].open)  -->報錯！！！
-- print(run_pattern['no_item'])       -->nil
-- print(run_pattern['wr'].no_item)    -->nil
-- print(run_pattern[nil])             -->nil

return run_pattern