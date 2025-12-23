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
    # - lua_translator@lua_custom_phrase  -- 須於 rime.lua 載入模塊。
    - lua_translator@*_translator_lua_custom_phrase@lua_custom_phrase

lua_custom_phrase:
  user_dict: "lua_custom_phrase"
--]]
---------------------------------------------------------------
local load_text_dict = require("load_custom/load_text_dict_out2tab")
-- local change_preedit = require("filter_cand/change_preedit")
---------------------------------------------------------------

local function init(env)
  engine = env.engine
  schema = engine.schema
  config = schema.config
  env.prefix = config:get_string("mf_translator/prefix")
  -- namespace = "lua_custom_phrase"
  env.textdict = config:get_string(env.name_space .. "/user_dict") or ""
  --- 以下 「load_text_dict」 可能為 nil or {}
  --- 更新 txt 需「重新部署」或方案變換。
  if env.textdict == "" then
    env.tab = {['zz']={'※ 無短語字典連結(schema)'}}
    env.tab_list = {{ text = "", code = "※ 無短語字典連結(schema)", sort = 0 }}
  else
    env.tab = load_text_dict(env.textdict)[1] or {}
    env.tab_list = load_text_dict(env.textdict)[2] or {}
  end
  env.quality = 10
  -- log.info("lua_custom_phrase: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
  --- 以下擷取「translator/preedit_format」轉換格式。
  --- 擷取後使用「env.t_preedit:apply(input)」去轉換。  -- convert string
  local t_preedit_fmt_list = config:get_list("translator/preedit_format")  -- load ConfigList form path
  env.t_preedit = Projection()  -- create Projection obj
  env.t_preedit:load(t_preedit_fmt_list)  -- load convert rules
end


local function translate(input, seg, env)

  -- --- 當 schema 中找不到設定則跳開（env.textdict為""，translate 函數為 nil）
  -- --- 以下 env.textdict == "" 狀況提前於 init 處理。
  -- if env.textdict == "" then return end

  local tag_mf = seg:has_tag("mf_translator")
  if tag_mf and (input == env.prefix .. "a" or input == env.prefix .. ",") then
  -- if seg:has_tag("mf_translator") and (input == env.prefix .. "a") then
    tab_list = env.tab_list
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
      local short_preedit = env.t_preedit:apply(input)
      -- local v = string.gsub(v, "\\n", "\n")  -- 可以多行文本
      -- local v = string.gsub(v, "\\r", "\r")  -- 可以多行文本
      local cand = Candidate("simp_short", seg.start, seg._end, v, "〔短語〕")
      -- local cand = change_preedit(cand, short_preedit)
      -- cand.preedit = env.t_preedit:apply(input)
      cand.preedit = short_preedit
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