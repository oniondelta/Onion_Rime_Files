--- @@ convert_japan_filter
--[[
日文出羅馬字、全形羅馬字、半形片假名、全片假名、全平假名。
用 filter 方式呈現。
--]]

--[[
從 convert_kana 資料夾匯入假名相關轉換函數。
--]]
local c_k = require("convert_kana/convert_kana")
local revise_t = c_k.revise_t
local fullshape_t = c_k.fullshape_t
local halfwidth_kata_t = c_k.halfwidth_kata_t
local kata_t = c_k.kata_t
local hira_t = c_k.hira_t




--- 以下新的寫法：合併寫法
----------------------------------------------------------------------------------------
local change_preedit = require("filter_cand/change_preedit")
----------------------------------------------------------------------------------------
-- local M={}
local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local check_schema_id = config:get_string("schema/schema_id") or ""
  -- local check_plus = config:get_string("translator/dictionary") or ""  -- 檢查為獨立方案或掛接方案
  -- local p_suffix = config:get_string("japan/suffix") or ""
  -- env.p_prefix = check_plus ~= "jpnin1.extended" and config:get_string("japan/prefix") or ""
  local p_prefix = not string.match(check_schema_id, "^jpnin1") and config:get_string("japan/prefix") or ""
  -- env.match_pattern = env.p_prefix .. "([-/a-z.,;]+)(%., ?)$"  -- 尾綴不是都「空格」已改變  -- "[,46]([-/a-z][-/a-z.,;]*)(%., ?)$"：會有Bug
  -- env.match_pattern = env.p_prefix .. "([-/a-z.,;]+)(%.,[' ]*)$"
  -- env.match_pattern = env.p_prefix .. "([-/a-z.,;]+)(%.,[" .. p_suffix .. " ]*)$"
  env.match_pattern = check_schema_id ~= "bopomo_onionplus_space" and p_prefix .. "([-/a-z.,;]+)(%.,'?)$" or env.p_prefix .. "([- /a-z.,;]+)(%., *'?)$"
  env.tips_jp = "《日-固列》"
  -- env.tips_jp = p_prefix ~= "" and "《日-固列》" or ""
  -- env.prompt_jp = "（日-固列）"
end

-- function M.fini(env)
-- end

-- local function convert_japan_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input  -- 原始未轉換輸入碼
  -- local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  -- local p_start = context:get_preedit().sel_start
  -- local p_end = context:get_preedit().sel_end
  local seg_start = seg.start
  local seg_end = seg._end
  local c, s = string.match(c_input, env.match_pattern)

  if seg_end == #c_input and c then
  -- if caret_pos == #c_input and c then
    -- local es = p_end - p_start - 2  --減二為扣掉「.,」兩個尾綴（c不包含，故前移兩位）
    local es = seg_end - seg_start - 2  --減二為扣掉「.,」兩個尾綴（c不包含，故前移兩位）
    local c = string.sub(c, -es)
    -- local c = string.sub(c, p_start ,p_end)
    local jp_p = env.tips_jp .. string.upper(c) .. s
    -- local jp_p = env.p_prefix ~= "" and "《純日語》" .. string.upper(c) .. s .. "\t" .. env.prompt_jp or string.upper(c) .. s .. "\t" .. env.prompt_jp
    local roma = Candidate("simp_jp", seg_start, seg_end, revise_t(c) , "〔羅馬字〕")
    local roma_f = Candidate("simp_jp",seg_start, seg_end, fullshape_t(c), "〔全形羅馬字〕")
    yield( change_preedit(roma, jp_p) )
    yield( change_preedit(roma_f, jp_p) )

    local hw = halfwidth_kata_t(c)
    if not string.match(hw, "%l") then
      local hwkata = Candidate("simp_jp", seg_start, seg_end, hw, "〔半形片假名〕")
      local kata = Candidate("simp_jp", seg_start, seg_end, kata_t(hw), "〔片假名〕")
      local hira = Candidate("simp_jp", seg_start, seg_end, hira_t(hw), "〔平假名〕")
      yield( change_preedit(hwkata, jp_p) )
      yield( change_preedit(kata, jp_p) )
      yield( change_preedit(hira, jp_p) )
    else
      local no_kana = Candidate("simp_jp", seg_start, seg_end, "", "〔該拼寫無假名〕")
      yield( change_preedit(no_kana, jp_p) )
    end

  else
    for cand in inp:iter() do
      yield(cand)
    end
  end

end

-- return convert_japan_filter
return { init = init, func = filter }
-- return M
----------------------------------------------------------------------------------------




--- 以下舊的寫法：分開寫法
--[[
----------------------------------------------------------------------------------------
local change_preedit = require("filter_cand/change_preedit")
----------------------------------------------------------------------------------------
-- 主方案用
local function convert_japan_filter(input, env)
  local engine = env.engine
  local context = engine.context
  local caret_pos = context.caret_pos
  local c_input = context.input  -- 原始未轉換輸入碼
  local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  -- local _end = caret_pos
  local c = string.match(c_input, "^([-/a-z.,;]+)%.,$")
  if caret_pos == #c_input and (c~=nil) then
    local es = _end - start - 2  --減二為扣掉「.,」兩個尾綴
    local c = string.sub(c, -es)
    -- yield(Candidate("simp_jp", start, _end, '字串總數：'..#c_input..' 開始：'..start..' 末尾數：'.._end..' 游標數：'..caret_pos, "〔測試〕"))  --測試用
    yield(Candidate("simp_jp", start, _end, revise_t(c), "〔羅馬字〕"))
    yield(Candidate("simp_jp", start, _end, fullshape_t(c), "〔全形羅馬字〕"))
    local hw = halfwidth_kata_t(c)
    if not string.match(hw, "%l") then
      yield(Candidate("simp_jp", start, _end, hw, "〔半形片假名〕"))
      yield(Candidate("simp_jp", start, _end, kata_t(hw), "〔片假名〕"))
      yield(Candidate("simp_jp", start, _end, hira_t(hw), "〔平假名〕"))
    else
      yield(Candidate("simp_jp", start, _end, "", "〔該拼寫無假名〕"))
    end

  else
    for cand in input:iter() do
      yield(cand)
    end
  end

end

-- 掛接方案用，掛接方案開頭為[,46]。
local function p_convert_japan_filter(input, env)
  local engine = env.engine
  local context = engine.context
  local caret_pos = context.caret_pos
  local c_input = context.input  -- 原始未轉換輸入碼
  local start = context:get_preedit().sel_start
  -- local _end = context:get_preedit().sel_end + 1  --一般日語末尾只有「.」或「,」，「.,」會多一。
  local _end = caret_pos
  local tips_jp = "《日-固列》"
  local c, s = string.match(c_input, "[,46]([-/a-z][-/a-z.,;]*)(%., ?)$")
  if caret_pos == #c_input and (c~=nil) then
  -- if (c~=nil) and #c_input <= _end then
  -- if (c~=nil) and context:is_composing() then
  -- if (c~=nil) then

    local jp_p = tips_jp .. c .. s
    -- local roma = Candidate("simp_jp", start, _end, '字串總數：'..#c_input..' 開始：'..start..' 末尾數加一：'.._end..' 游標數：'..caret_pos, "〔測試〕")  --測試用
    local roma = Candidate("simp_jp", start, _end, revise_t(c) , "〔羅馬字〕")
    local roma_f = Candidate("simp_jp", start, _end, fullshape_t(c), "〔全形羅馬字〕")
    -- yield( change_preedit(roma, jp_p) )
    -- yield( change_preedit(roma_f, jp_p) )
    -- roma.preedit = tips_jp .. c .. s
    -- roma_f.preedit = tips_jp .. c .. s
    roma.preedit = jp_p
    roma_f.preedit = jp_p
    yield(roma)
    yield(roma_f)
    local hw = halfwidth_kata_t(c)
    if not string.match(hw, "%l") then
      local hwkata = Candidate("simp_jp", start, _end, hw, "〔半形片假名〕")
      local kata = Candidate("simp_jp", start, _end, kata_t(hw), "〔片假名〕")
      local hira = Candidate("simp_jp", start, _end, hira_t(hw), "〔平假名〕")
      -- yield( change_preedit(hwkata, jp_p) )
      -- yield( change_preedit(kata, jp_p) )
      -- yield( change_preedit(hira, jp_p) )
      -- hwkata.preedit = tips_jp .. c .. s
      -- kata.preedit = tips_jp .. c .. s
      -- hira.preedit = tips_jp .. c .. s
      hwkata.preedit = jp_p
      kata.preedit = jp_p
      hira.preedit = jp_p
      yield(hwkata)
      yield(kata)
      yield(hira)
    else
      local no_kana = Candidate("simp_jp", start, _end, "", "〔該拼寫無假名〕")
      -- yield( change_preedit(no_kana, jp_p) )
      -- no_kana.preedit = tips_jp .. c .. s
      no_kana.preedit = jp_p
      yield(no_kana)
    end

  else
    for cand in input:iter() do
      yield(cand)
    end
  end
  -- for cand in input:iter() do
  --   yield(cand)
  -- end
end

return { convert_japan_filter = convert_japan_filter,
       p_convert_japan_filter = p_convert_japan_filter }
----------------------------------------------------------------------------------------
--]]