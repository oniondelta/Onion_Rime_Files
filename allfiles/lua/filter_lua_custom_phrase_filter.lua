--- @@ lua_custom_phrase_filter
--[[
接續掛接方案後，有 bug，上不了屏，改用 translator 實現。
--]]


---------------------------------------------------------------
--- 置入方案範例
--[[
engine:
  filter:
    - lua_filter@lua_custom_phrase_filter

lua_custom_phrase_filter:
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
  if io.open(file_name) == nil then return end
  -- if (f == nil) then return end

  local tab = {}
  for line in io.open(file_name):lines() do
  -- for line in f:lines() do
    local v_text, v_code = string.match(line, "^([^\t#][^\t]*)\t([%d%l,./; -]+)\t?.*$")
    if v_text then

      -- tab[v_code] = v_text  -- 一個 code 只能有一條短語，下方可一個 code，多條短語。
      local nn={}
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

  return tab
end

---------------------------------------------------------------
-- local M={}
local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  -- namespace = "lua_custom_phrase_filter"
  env.textdict = config:get_string(env.name_space .. "/user_dict") or ""
  --- 以下 「load_text_dict」 可能為 nil 故要 or {}
  env.tab = load_text_dict(env.textdict) or {}  -- 更新 txt 需「重新部署」或方案變換
  -- log.info("lua_custom_phrase_filter: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
end


-- function M.fini(env)
-- end


-- local function lua_custom_phrase_filter(inp,env)
local function filter(inp,env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  local caret_pos = context.caret_pos
  local es = _end - start
  local c_input = context.input  -- 原始未轉換輸入碼
  local cut_input = string.sub(c_input, -es)
  --- 以下 「load_text_dict」 可能為 nil 故要 or {}
  -- local text_dict_tab = load_text_dict("lua_custom_phrase") or {}  -- 直接限定 txt 字典
  -- local text_dict_tab = load_text_dict(env.textdict) or {}  -- 更新 txt 不需「重新部署」
  --- {}['xxx'] 拋出 nil，{}不為 nil。
  -- local c_p_tab = text_dict_tab[cut_input]  -- 更新 txt 不需「重新部署」
  -- local c_p_tab = text_dict_tab[c_input]  -- 更新 txt 不需「重新部署」
  local c_p_tab = env.tab[cut_input]

  if env.textdict == "" then
  elseif env.tab == {} then
  -- elseif text_dict_tab == {} then
  elseif c_p_tab then
  -- elseif (caret_pos == #c_input) and c_p_tab then
    for _, v in pairs(c_p_tab) do
      local v = string.gsub(v, "\\n", "\n")  -- 可以多行文本
      local v = string.gsub(v, "\\r", "\r")  -- 可以多行文本
      local cand = Candidate("short", start, _end, v, "〔短語〕")
      yield(cand)
    end
    -- local custom_phrase_cand = Candidate("short", start, _end, c_p_tab, "〔短語〕")
    -- yield( custom_phrase_cand )
    --- 以下防止記憶體洩漏暴漲？！不會立即清理記憶體，但會回退，測試！
    -- c_p_tab = {}
    -- c_p_tab = nil
  end

  for cand in inp:iter() do
    yield(cand)
  end
end


-- return lua_custom_phrase_filter
return { init = init, func = filter }
-- return M