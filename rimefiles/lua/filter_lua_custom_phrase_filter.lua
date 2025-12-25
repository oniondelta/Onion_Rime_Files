--- @@ lua_custom_phrase_filter
--[[
接續掛接方案後，有 bug，上不了屏，改用 translator 實現。
202512 測試好似又沒 bug？掛接方案後，也可直接上屏？！
形碼方案時，無簡單方式（如：利用詞頻），讓單字在前，短語在後，故使用 translator 實現。注音和雙拼方案可引用，測試中。
--]]


---------------------------------------------------------------
--- 置入方案範例
--[[
engine:
  filter:
    # - lua_filter@lua_custom_phrase_filter  -- 須於 rime.lua 載入模塊。
    - lua_filter@*filter_lua_custom_phrase_filter@lua_custom_phrase_filter

lua_custom_phrase_filter:
  user_dict: "lua_custom_phrase"
--]]
---------------------------------------------------------------
local load_text_dict = require("load_custom/load_text_dict_out2tab")
---------------------------------------------------------------

-- local M={}
local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local prefix = config:get_string("mf_translator/prefix")  -- env.prefix
  env.prefix_a = prefix .. "a"
  env.prefix_comma = prefix .. ","
  -- namespace = "lua_custom_phrase"
  local textdict = config:get_string(env.name_space .. "/user_dict") or ""  -- env.textdict
  --- 以下 「load_text_dict」 可能為 nil or {}
  --- 更新 txt 需「重新部署」或方案變換。
  if textdict == "" then
    env.tab = {['zz']={'※ 無短語字典連結(schema)'}}
    env.tab_list = {{ text = "", code = "※ 無短語字典連結(schema)", sort = 0 }}
  else
    env.tab = load_text_dict(textdict)[1] or {}
    env.tab_list = load_text_dict(textdict)[2] or {}
  end
  env.quality = 10
  -- log.info("lua_custom_phrase: \'" .. textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
  --- 以下擷取「translator/preedit_format」轉換格式。
  --- 擷取後使用「env.t_preedit:apply(input)」去轉換。  -- convert string
  local t_preedit_fmt_list = config:get_list("translator/preedit_format")  -- load ConfigList form path
  env.t_preedit = Projection()  -- create Projection obj
  env.t_preedit:load(t_preedit_fmt_list)  -- load convert rules
end


-- function M.fini(env)
-- end


local function tags_match(seg, env)
  seg_abc = seg:has_tag("abc")
  seg_mf = seg:has_tag("mf_translator")
  return seg_abc or seg_mf
end


-- local function lua_custom_phrase_filter(inp,env)
local function filter(inp,env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  -- local caret_pos = context.caret_pos
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

  -- --- 當 schema 中找不到設定則跳開（env.textdict為""，translate 函數為 nil）
  -- --- 以下 env.textdict == "" 狀況提前於 init 處理。
  -- if env.textdict == "" then return end
  if seg_abc and c_p_tab then
  -- if (caret_pos == #cut_input) and c_p_tab then  --只能在一開頭輸入，掛接後續無法。
    for _, v in pairs(c_p_tab) do
      -- local v = string.gsub(v, "\\n", "\n")  -- 可以多行文本
      -- local v = string.gsub(v, "\\r", "\r")  -- 可以多行文本
      local cand = Candidate("simp_short", start, _end, v, "〔短語〕")
      -- local short_preedit = env.t_preedit:apply(cut_input)
      -- local cand = change_preedit(cand, short_preedit)
      -- cand.preedit = short_preedit
      cand.preedit = env.t_preedit:apply(cut_input)
      cand.quality = env.quality
      yield(cand)
    end
  elseif seg_mf and (cut_input == env.prefix_a or cut_input == env.prefix_comma) then
  -- elseif seg_mf and (cut_input == env.prefix .. "a" or cut_input == env.prefix .. ",") then
  -- elseif cut_input == env.prefix .. "a" or cut_input == env.prefix .. "," then
    -- tab_list = env.tab_list
    for k, v in pairs(env.tab_list) do
      -- local text = v.text
      -- local text = string.gsub(text, "\\n", "\n")  -- 可以多行文本
      -- local text = string.gsub(text, "\\r", "\r")  -- 可以多行文本
      local cand = Candidate("simp_short_list", start, _end, v.text, v.code)
      -- local cand = Candidate("simp_short_list", start, _end, v.text, v.code.."  〔"..v.sort.."〕")
      -- local cand = Candidate("simp_short_list", start, _end, v[1], v[2].."  〔"..v[3].."〕")
      cand.preedit = cut_input .. "\t 【短語總列表】"
      yield(cand)
    end
    return  -- 跳開不跑下面 iter()。
  end

  -- --- 以下測試用。
  -- local cand_test = Candidate("seg_test", start, _end, "〔test〕" , "〔測試〕")
  -- yield(cand_test)

  for cand in inp:iter() do
    yield(cand)
  end

end


-- return lua_custom_phrase_filter
return { init = init, func = filter, tags_match = tags_match }
-- return M