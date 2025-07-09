--- @@ lua_custom_phrase
--[[
取代原先 table_translator@custom_phrase。
可多行，用\n\r。
--]]


---------------------------------------------------------------
--- 置入方案範例
--[[
engine:
  translators:
    - lua_translator@lua_custom_phrase

lua_custom_phrase:
  user_dict: "lua_custom_phrase"
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
--- 「load_text_dict」把 txt 檔變成 lua table 供後續查詢。

local function load_text_dict(text_dict)
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
          allcode = allcode .. "  " .. v
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

---------------------------------------------------------------
local function init(env)
  engine = env.engine
  schema = engine.schema
  config = schema.config
  env.prefix = config:get_string("mf_translator/prefix")
  -- namespace = "lua_custom_phrase"
  env.textdict = config:get_string(env.name_space .. "/user_dict") or ""
  --- 以下 「load_text_dict」 可能為 nil or {}
  --- 更新 txt 需「重新部署」或方案變換
  if env.textdict == "" then
    env.tab = {['zz']={'※ 無短語字典連結(schema)'}}
    env.tab_list = {{ text = "", code = "※ 無短語字典連結(schema)", sort = 0 }}
  else
    env.tab = load_text_dict(env.textdict)[1] or {}
    env.tab_list = load_text_dict(env.textdict)[2] or {}
  end
  env.quality = 10
  -- log.info("lua_custom_phrase: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
end


local function translate(input, seg, env)

  -- --- 當 schema 中找不到設定則跳開（env.textdict為""，translate 函數為 nil）
  -- --- 以下 env.textdict == "" 狀況提前於 init 處理。
  -- if env.textdict == "" then return end

  local tag_mf = seg:has_tag("mf_translator")
  if tag_mf and (input == env.prefix .. "a" or input == env.prefix .. ",") then
  -- if seg:has_tag("mf_translator") and (input == env.prefix .. "a") then
    tab_list=env.tab_list
    for k, v in pairs(tab_list) do
      -- local text = v.text
      -- local text = string.gsub(text, "\\n", "\n")  -- 可以多行文本
      -- local text = string.gsub(text, "\\r", "\r")  -- 可以多行文本
      local cand = Candidate("simp_short_list", seg.start, seg._end, v.text, v.code)
      -- local cand = Candidate("simp_short_list", seg.start, seg._end, v.text, v.code.."  〔"..v.sort.."〕")
      -- local cand = Candidate("simp_short_list", seg.start, seg._end, v[1], v[2].."  〔"..v[3].."〕")
      cand.preedit = input .. "\t 【短語總列表】"
      yield(cand)
    end
    return
  end


  local tag_abc = seg:has_tag("abc")
  --- 當 schema 中找不到設定則跳開（env.textdict為""，translate 函數為 nil）
  --- 預防出現在掛接輸入中，限定在 abc 段落（tag_abc）
  -- if env.textdict == "" then return log.error("lua_custom_phrase： user_dict File Name is Wrong or Missing!") end  -- 錯誤日誌中提示名稱錯誤或遺失
  -- if not tag_abc or env.textdict == "" then return end
  if not tag_abc then return end
  -- if not seg:has_tag("abc") then return end

  -- local engine = env.engine
  -- local context = engine.context
  -- local caret_pos = context.caret_pos
  --- 以下 「load_text_dict」 可能為 nil 故要 or {}
  -- local text_dict_tab = load_text_dict("lua_custom_phrase") or {}  -- 直接限定 txt 字典
  -- local text_dict_tab = load_text_dict(env.textdict) or {}  -- 更新 txt 不需「重新部署」
  --- {}['xxx'] 拋出 nil，{}不為 nil。
  -- local c_p_tab = text_dict_tab[input]  -- 更新 txt 不需「重新部署」
  local c_p_tab = env.tab[input]  -- 更新 txt 需「重新部署」或方案變換

  if c_p_tab then
  -- if (caret_pos == #input) and c_p_tab then  --只能在一開頭輸入，掛接後續無法。
    for _, v in pairs(c_p_tab) do
      -- local v = string.gsub(v, "\\n", "\n")  -- 可以多行文本
      -- local v = string.gsub(v, "\\r", "\r")  -- 可以多行文本
      local cand = Candidate("simp_short", seg.start, seg._end, v, "〔短語〕")
      cand.quality = env.quality
      yield(cand)
    end
  end

  -- --- 以下測試用
  -- if (string.match(input, "^11$")~=nil) then
  --   cand.quality = env.quality
  --   yield( Candidate("short", seg.start, seg._end, "『測試用』", "〔短語〕") )
  --   yield(cand)

end


return {init = init, func = translate}
-- return lua_custom_phrase
---------------------------------------------------------------
--- 參考


--[[
local function load_ext_dict(ext_dict)
  --local path= string.gsub(debug.getinfo(1).source,"^@(.+/)[^/]+$", "%1")
  local path= rime_api.get_user_data_dir() .. slash
  filename =  path ..  ( ext_dict or "ext_dict" ) .. ".txt"
  if not isFile(filename) then return end

  local tab = {}
  for line in io.open(filename):lines() do
    if not line:match("^#") then  -- 第一字 #  不納入字典
      local t=line:split("\t")
      if t then
        tab[ t[1] ] = t[2]
      end
    end
  end
  return tab
end


-- return Translation
local function eng_tran(dict,mode,prefix_comment,cand)

  return Translation(function()
    -- 使用 context.input 查字典 type "english"
    local inp = cand.text
    for w in dict:iter(inp) do
      -- system_format 處理 comment 字串長度 格式
      local comment = system_format(  prefix_comment..w:get_info(mode) )
      local commit = sync_case(inp,w.word)
      -- 如果 與 字典相同 替換 first_cand cand.comment
      if cand.text:lower() == commit:lower() then
        cand.comment= comment
      else
        yield( ShadowCandidate(cand,cand.type,commit,comment) )
      end
    end
  end)
end
--]]