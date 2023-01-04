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


----------------------------------------------------------------------------------------
-- 主方案用
local function convert_japan_filter(input, env)
  local engine = env.engine
  local context = engine.context
  local caret_pos = context.caret_pos
  local o_input = context.input  -- 原始未轉換輸入碼
  local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  -- local _end = caret_pos
  local c = string.match(o_input, "^([-/a-z.,;]+)%.,$")
  if caret_pos == #o_input and (c~=nil) then
    local es = _end - start - 2  --減二為扣掉「.,」兩個尾綴
    local c = string.sub(c, -es)
    -- yield(Candidate("jp", start, _end, '字串總數：'..#o_input..' 開始：'..start..' 末尾數：'.._end..' 游標數：'..caret_pos, "〔測試〕"))  --測試用
    yield(Candidate("jp", start, _end, revise_t(c), "〔羅馬字〕"))
    yield(Candidate("jp", start, _end, fullshape_t(c), "〔全形羅馬字〕"))
    local hw = halfwidth_kata_t(c)
    if not string.match(hw, "%l") then
      yield(Candidate("jp", start, _end, hw, "〔半形片假名〕"))
      yield(Candidate("jp", start, _end, kata_t(hw), "〔片假名〕"))
      yield(Candidate("jp", start, _end, hira_t(hw), "〔平假名〕"))
    else
      yield(Candidate("jp", start, _end, "", "〔該拼寫無假名〕"))
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
  local o_input = context.input  -- 原始未轉換輸入碼
  local start = context:get_preedit().sel_start
  -- local _end = context:get_preedit().sel_end + 1  --一般日語末尾只有「.」或「,」，「.,」會多一。
  local _end = caret_pos
  local tips_jp = '《日-固列》'
  local c , s = string.match(o_input, "([-/a-z][-/a-z.,;]*)(%., ?)$")
  if caret_pos == #o_input and (c~=nil) then
  -- if (c~=nil) and #o_input <= _end then
  -- if (c~=nil) and context:is_composing() then
  -- if (c~=nil) then

    -- local roma = Candidate("jp", start, _end, '字串總數：'..#o_input..' 開始：'..start..' 末尾數加一：'.._end..' 游標數：'..caret_pos, "〔測試〕")  --測試用
    local roma = Candidate("jp", start, _end, revise_t(c) , "〔羅馬字〕")
    local roma_f = Candidate("jp", start, _end, fullshape_t(c), "〔全形羅馬字〕")
    roma.preedit = tips_jp .. c .. s
    roma_f.preedit = tips_jp .. c .. s
    yield(roma)
    yield(roma_f)
    local hw = halfwidth_kata_t(c)
    if not string.match(hw, "%l") then
      local hwkata = Candidate("jp", start, _end, hw, "〔半形片假名〕")
      local kata = Candidate("jp", start, _end, kata_t(hw), "〔片假名〕")
      local hira = Candidate("jp", start, _end, hira_t(hw), "〔平假名〕")
      hwkata.preedit = tips_jp .. c .. s
      kata.preedit = tips_jp .. c .. s
      hira.preedit = tips_jp .. c .. s
      yield(hwkata)
      yield(kata)
      yield(hira)
    else
      local no_kana = Candidate("jp", start, _end, "", "〔該拼寫無假名〕")
      no_kana.preedit = tips_jp .. c .. s
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