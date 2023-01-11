--- @@ convert_english_filter
--[[
easy 英文尾綴「;」或「;;」生成全大寫或首字母大寫。
--]]

local function english_space(en)
  if en == "" then return "" end
  en = string.gsub(en, ",", " ")
  return en
end

local function english_2(en)
  if string.match(en, "^[/.'-][a-z]") then
    en = string.upper(string.sub(en,1,2)) .. string.sub(en,3)
  end
  return en
end

----------------------------------------------------------------------------------------
-- 主方案用
local function convert_english_filter(input, env)
  local engine = env.engine
  local context = engine.context
  local caret_pos = context.caret_pos
  local o_input = context.input  -- 原始未轉換輸入碼
  local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  -- local _end = caret_pos
  local c1 = string.match(o_input, "^([-/a-z.,']+);$")
  local c2 = string.match(o_input, "^([-/a-z.,']+);;$")
  local c3 = string.match(o_input, "^([-/a-z.,']+);;;$")

  for cand in input:iter() do
    yield(cand)
  end

  if caret_pos == #o_input and (c1~=nil) then
    -- local es = _end - start - 1  --減一為扣掉「;」一個尾綴
    -- local c1 = string.sub(c1, -es)
    yield(Candidate("en", start, _end, string.upper(english_space(c1)), ""))
  elseif caret_pos == #o_input and (c2~=nil) then
    -- local es = _end - start - 1  --減二為扣掉「;;」兩個尾綴
    -- local c2 = string.sub(c2, -es)
    yield(Candidate("en", start, _end, string.upper(string.sub(c2,1,1)) .. string.sub(english_2(english_space(c2)),2), ""))
  elseif caret_pos == #o_input and (c3~=nil) then
    -- local es = _end - start - 1  --減二為扣掉「;;」兩個尾綴
    -- local c3 = string.sub(c3, -es)
    yield(Candidate("en", start, _end, english_space(c3) , ""))
    -- yield(Candidate("en", start, _end, '字串總數：'..#o_input..' 開始：'..start..' 末尾數：'.._end..' 游標數：'..caret_pos, "〔測試〕"))  --測試用
  end

end


-- 掛接方案用，掛接方案開頭為[.3]。
local function p_convert_english_filter(input, env)
  local engine = env.engine
  local context = engine.context
  local caret_pos = context.caret_pos
  local o_input = context.input  -- 原始未轉換輸入碼
  local start = context:get_preedit().sel_start
  -- local _end = context:get_preedit().sel_end + 1  --一般末尾「;」會多一。
  local _end = caret_pos
  local tips_en = '《Easy》'
  local c1 , s1 = string.match(o_input, "[.3]([-/a-z.,']+)(; ?)$")
  local c2 , s2 = string.match(o_input, "[.3]([-/a-z.,']+)(;; ?)$")
  local c3 , s3 = string.match(o_input, "[.3]([-/a-z.,']+)(;;; ?)$")

  for cand in input:iter() do
    yield(cand)
  end

  if caret_pos == #o_input and (c1~=nil) then
    local english = Candidate("en", start, _end, string.upper(english_space(c1)), "")
    english.preedit = tips_en .. c1 .. s1
    yield(english)
  elseif caret_pos == #o_input and (c2~=nil) then
    local english = Candidate("en", start, _end, string.upper(string.sub(c2,1,1)) .. string.sub(english_2(english_space(c2)),2), "")
    english.preedit = tips_en .. c2 .. s2
    yield(english)
  elseif caret_pos == #o_input and (c3~=nil) then
    local english = Candidate("en", start, _end, english_space(c3) , "")
    english.preedit = tips_en .. c3 .. s3
    yield(english)
    -- local english = Candidate("en", start, _end, '字串總數：'..#o_input..' 開始：'..start..' 末尾數加一：'.._end..' 游標數：'..caret_pos, "〔測試〕")  --測試用
  end

end


return { convert_english_filter = convert_english_filter,
       p_convert_english_filter = p_convert_english_filter }