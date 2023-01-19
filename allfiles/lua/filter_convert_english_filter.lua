--- @@ convert_english_filter
--[[
easy 英文尾綴「;」或「;;」生成全大寫或首字母大寫。
--]]

local f_e_s = require("f_components/f_english_style")
local english_s = f_e_s.english_s
local english_u1 = f_e_s.english_u1
local english_s2u = f_e_s.english_s2u
-- 可利用 cp pattern 隨時增加pattern 
local english_pattern{
  [";"] = {comment = "〔全大寫〕", func= string.upper },
  [";;"] = {comment= "〔開頭大寫〕", func= english_u1},
  [";/"] = {comment= "〔全小寫〕" , func= english_s},
  [";'"] = {comment= "〔間隔後大寫〕" , func= englishi_s2u},
  [""] = {comment= "〔補空〕" , func= english_s},
 }



local change_preedit = require("filter_cand/change_preedit")

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
  --[[
  local c1 = string.match(o_input, "^([-/a-z.,']+);;$")
  local c2 = string.match(o_input, "^([-/a-z.,']+);$")
  local c3 = string.match(o_input, "^([-/a-z.,']+);/$")
  local c4 = string.match(o_input, "^([-/a-z.,']+);'$")
  local c5 = string.match(o_input, "^([-/a-z.,']+)$")
  --]]
  for cand in input:iter() do
    yield(cand)
  end
  if caret_pos == #o_input then
    ocal mstr,cp = o_input:match("^(-/a-z.,']+)([;/']*)$") -- 取代 s1~ s5
    local cp_tab= english_pattern[cp]
    if cp_tab then
      yield( Candidate("en", start, _end, cp_tab.func(mstr) , cp.tab.comment) )
    end
  end
--[[
  if caret_pos ~= #o_input then
  elseif (c1~=nil) then
    -- local es = _end - start - 1  --減一為扣掉「;」一個尾綴
    -- local c1 = string.sub(c1, -es)
    yield(Candidate("en", start, _end, string.upper(english_s(c1)), "〔全大寫〕"))
  elseif (c2~=nil) then
    -- local es = _end - start - 1  --減二為扣掉「;;」兩個尾綴
    -- local c2 = string.sub(c2, -es)
    yield(Candidate("en", start, _end, english_u1(c2), "〔開頭大寫〕"))
  elseif (c3~=nil) then
    -- local es = _end - start - 1  --減二為扣掉「;;」兩個尾綴
    -- local c3 = string.sub(c3, -es)
    yield(Candidate("en", start, _end, english_s(c3), "〔全小寫〕"))
    -- yield(Candidate("en", start, _end, '字串總數：'..#o_input..' 開始：'..start..' 末尾數：'.._end..' 游標數：'..caret_pos, "〔測試〕"))  --測試用
  elseif (c4~=nil) then
    yield(Candidate("en", start, _end, english_s2u(c4), "〔間隔後大寫〕"))
  elseif (c5~=nil) and (not context:has_menu()) then
    yield(Candidate("en", start, _end, english_s(c5), "〔補空〕"))
  end
  --]]
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
  --[[
  local c1 , s1 = string.match(o_input, "[.3]([-/a-z.,']+)(;; ?)$")
  local c2 , s2 = string.match(o_input, "[.3]([-/a-z.,']+)(; ?)$")
  local c3 , s3 = string.match(o_input, "[.3]([-/a-z.,']+)(;/ ?)$")
  local c4 , s4 = string.match(o_input, "[.3]([-/a-z.,']+)(;' ?)$")
  local c5 , s5 = string.match(o_input, "[.3]([-/a-z.,']+)( ?)$")
  --]]



  for cand in input:iter() do
    yield(cand)
  end
  
  if caret_pos == #o_input then
    local mstr , cp = o_input:match("[.3]([-/a-z.,']+)([;/']*) ?$")  -- 取代 s1~ s5
    local cp_tab= english_pattern[cp]
    if cp_tab then
      local e_cand = Candidate("en", start, _end, cp_tab.func(mstr) , cp.tab.comment)
      yield( chang_preedit(e_cand, tips_en .. mstr .. cp) )
    end
  end
--[[
  if caret_pos ~= #o_input then
  elseif (c1~=nil) then
    local english = Candidate("en", start, _end, string.upper(english_s(c1)), "〔全大寫〕")
    -- english.preedit = tips_en .. c1 .. s1
    yield( change_preedit(english, tips_en .. c1 .. s1) )
  elseif (c2~=nil) then
    local english = Candidate("en", start, _end, english_u1(c2), "〔開頭大寫〕")
    -- english.preedit = tips_en .. c2 .. s2
    yield( change_preedit(english, tips_en .. c2 .. s2) )
  elseif (c3~=nil) then
    local english = Candidate("en", start, _end, english_s(c3), "〔全小寫〕")
    -- english.preedit = tips_en .. c3 .. s3
    yield( change_preedit(english, tips_en .. c3 .. s3) )
  elseif (c4~=nil) then
    local english = Candidate("en", start, _end, english_s2u(c4), "〔間隔後大寫〕")
    -- english.preedit = tips_en .. c4 .. s4
    yield( change_preedit(english, tips_en .. c4 .. s4) )
    -- local english = Candidate("en", start, _end, '字串總數：'..#o_input..' 開始：'..start..' 末尾數加一：'.._end..' 游標數：'..caret_pos, "〔測試〕")  --測試用
  elseif (c5~=nil) and (not context:has_menu()) then
    local english = Candidate("en", start, _end, english_s(c5), "〔補空〕")
    -- english.preedit = tips_en .. c5 .. s5
    yield( change_preedit(english, tips_en .. c5 .. s5) )
  end
--]]
end


return { convert_english_filter = convert_english_filter,
       p_convert_english_filter = p_convert_english_filter }
