--- @@ load_text_dict_out2tab
--[[
「load_text_dict」把 txt 檔變成 lua table 供後續查詢。
新版，可出兩個 tab：一般打字附加的 tab 和短語列表 tab。
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

local function load_text_dict_out2tab(text_dict)
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
  -- if io.open(file_name) == nil then return end
  if io.open(file_name) == nil then
    tab = {['zz']={'※ 無短語字典'}}
    tab_list2 = {{ text = "", code = "※ 無短語字典", sort = 0 }}
    return {tab, tab_list2}
  end
  -- if (f == nil) then return end

  local tab = {}
  local tab_list1 = {}
  -- for line in io.open(file_name):lines() do
  for line in io.lines(file_name) do  -- 以讀的形式進行，如果文件不存在會報錯，故前面需判別是否為 nil。因 lines() 完自動關閉，後面不能 io.close() 關閉，否則會報錯。
  -- for line in f:lines() do
    local v_text, v_code, v_sort = string.match(line, "^([^\t#][^\t]*)\t([%d%l,./; -]+)\t?(%d*)$")
    if v_text then

      local v_text = string.gsub(v_text, "\\n", "\n")  -- 可以多行文本
      local v_text = string.gsub(v_text, "\\r", "\r")  -- 可以多行文本

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

      --- 下方 table 格式為：{["v_text1"] = { code = {"v_code1"}, sort = 0 },["v_text2"] = { code = {"v_code2"}, sort = 3 }}
      local nn_text = {}
      local v_sort = tonumber(v_sort) or 1
      if tab_list1[v_text] == nil then
        nn_text[1] = v_text
        nn_text["code"] = {v_code}
        nn_text["sort"] = v_sort or 1
        -- nn_text["sort"] = v_sort ~= "" and v_sort or v_sort == nil and 1 or 1
        tab_list1[v_text] = nn_text
      else
        tab_list1[v_text]["code"][#tab_list1[v_text]["code"]+1] = v_code

        local t_sort = tab_list1[v_text]["sort"]
         if t_sort < v_sort then
           tab_list1[v_text]["sort"] = v_sort
         end
        -- if tab_list1[v_text]["sort"] < v_sort then  -- 特殊短語條目會報錯！！！
        --   tab_list1[v_text]["sort"] = v_sort
        -- end
      end

      --- 下方 table 格式為：{{ text = {"測試條目1"}, code = {"ds"}, sort = 0 }, { text = {"測試條目2"}, code = {"dds"}, sort = 3 }}
      tab_list2 = {}
      for k, v in pairs(tab_list1) do
        vcode = v.code
        vsort = v.sort
        -- vsort = tonumber(vsort)  -- 改到前面數字化
        allcode = ""
        for _, v in pairs(vcode) do
          -- allcode = allcode .. "  " .. v
          allcode = allcode .. "  " .. string.gsub(v, " ", "␣")  -- 以注音一聲空白編碼，於列表時，可顯示為"␣"。
        end
        tab_list2[#tab_list2+1]={text=k, code=allcode, sort=vsort}
        -- tab_list2[#tab_list2+1]={k, allcode, vsort}
        allcode = nil
      end

      -- sort(詞頻)排序：a.sort>b.sort； text(詞條)排序：a.text<b.text； code (編碼)排序：a.code<b.code。
      -- 以 sort(詞頻)排序 (a.sort>b.sort)優先比較，如 sort(詞頻)(a.sort==b.sort)一樣，比 text(詞條)。
      table.sort(tab_list2, function(a,b) return ( a.sort==b.sort and a.text<b.text or a.sort>b.sort) end)
      -- table.sort(tab_list2, function(a,b) return (a[3]>b[3]) end)

      --- 以下防止記憶體洩漏暴漲？！不會立即清理記憶體，但會回退，測試！
      nn = nil
      nn_text = nil

    end
  end

  if next(tab) == nil then
    tab = {['zz']={'※ 無短語編碼'}}
    tab_list2 = {{ text = "", code = "※ 無短語編碼", sort = 0 }}
  end

  -- f:close()
  -- io.close(f)

  return {tab, tab_list2}
end


return load_text_dict_out2tab