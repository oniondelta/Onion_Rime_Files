--- @@ load_text_dict_out1tab_old
--[[
「load_text_dict」把 txt 檔變成 lua table 供後續查詢。
舊版，只出一般打字附加的一個 tab。
--]]


---------------------------------------------------------------
-- local function file_exists(path)
--     if type(path)~="string" then return false end
--     return os.rename(path,path) and true or false
-- end

-- local function isFile(path)
--     if not file_exists(path) then return false end
--     local f = io.open(path)
--     if f then
--       local res = f:read(1) and true or false
--       f:close()
--       return res
--     end
--     return false
-- end

-- local slash = package.path:sub(1,1)  -- package.path 跑出的內容太長，不用。
---------------------------------------------------------------

local function load_text_dict_out1tab_old(text_dict)
  -- --- text_dict == "" 已會處理，但挪用此函數時此條有用。
  -- if text_dict == "" then return end
  --- 當輸入 text_dict 不為 string 則跳開，該函數為 nil。
  if (type(text_dict) ~= "string") then return end

  local path = rime_api.get_user_data_dir()
  -- local file_name = path .. "/" .. ( text_dict or "lua_custom_phrase" ) .. ".txt"  -- 如 text_dict 為 nil，下方已跳開，可不用 or
  local file_name = path .. "/" .. text_dict .. ".txt"
  -- local f = io.open(file_name, "r")

  --- 當找不到該 txt 字典檔案則跳開，該函數為 nil。
  -- if not isFile(file_name) then return end  -- 在 widonws 中會有問題。
  -- if io.open(file_name) == nil then return log.error("lua_custom_phrase： Missing user_dict File!") end  -- 錯誤日誌中提示遺失檔案（不存在）
  if io.open(file_name) == nil then return end
  -- if (f == nil) then return end

  local tab = {}
  -- for line in io.open(file_name):lines() do
  for line in io.lines(file_name) do  -- 以讀的形式進行，如果文件不存在會報錯，故前面需判別是否為 nil。因 lines() 完自動關閉，後面不能 io.close() 關閉，否則會報錯。
  -- for line in f:lines() do
    local v_text, v_code = string.match(line, "^([^\t#][^\t]*)\t([%d%l,./; -]+)\t?.*$")
    if v_text then

      -- tab[v_code] = v_text  -- 一個 code 只能有一條短語，下方可一個 code，多條短語。
      --- 下方 table 格式為：{[v_code1]={'v_text1','v_text2',...},[v_code2]={'v_text3'},...}
      local nn = {}
      if tab[v_code] == nil then
        -- local nn = {}
        -- table.insert(nn, v_text)
        -- nn[#nn+1] = v_text
        nn[1] = v_text
        tab[v_code] = nn
      else
        -- table.insert(tab[v_code], v_text)
        tab[v_code][#tab[v_code]+1] = v_text
      end
      --- 以下防止記憶體洩漏暴漲？！不會立即清理記憶體，但會回退，測試！
      nn = nil

    end
  end

  -- f:close()
  -- io.close(f)

  return tab
end


return load_text_dict_out1tab_old