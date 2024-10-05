--- @@ convert_japan_translator
--[[
日文出羅馬字、全形羅馬字、半形片假名、全片假名、全平假名。
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
local function convert_japan_translator(input, seg)
  local c = string.match(input, "([-/a-z.,;]+)%.,$")
  local tag_abc = seg:has_tag("abc")
  if tag_abc and c then
    local hw = halfwidth_kata_t(c)
    yield(Candidate("simp_jp", seg.start, seg._end, revise_t(c), "〔羅馬字〕"))
    yield(Candidate("simp_jp", seg.start, seg._end, fullshape_t(c), "〔全形羅馬字〕"))
    if not string.match(hw, "%l") then
      yield(Candidate("simp_jp", seg.start, seg._end, hw, "〔半形片假名〕"))
      yield(Candidate("simp_jp", seg.start, seg._end, kata_t(hw), "〔片假名〕"))
      yield(Candidate("simp_jp", seg.start, seg._end, hira_t(hw), "〔平假名〕"))
    end
  end
end

-- 掛接方案用，掛接方案名稱「japan」。
local function p_convert_japan_translator(input, seg)
-- local function p_convert_japan_translator(input, seg, env)
  -- local tips_jp = env.engine.schema.config:get_string('japan/tips')
  -- local tips_jp = string.gsub(tips_jp, "▶", "")
  local tips_jp = "《日-固列》"
  local c = string.match(input, "([-/a-z.,;]+)%.,$")
  local tag_jp = seg:has_tag("japan")
  local jp_p = tips_jp .. input
  if tag_jp and c then
    local hw = halfwidth_kata_t(c)
    local roma = Candidate("simp_jp", seg.start, seg._end, revise_t(c), "〔羅馬字〕")
    local roma_f = Candidate("simp_jp", seg.start, seg._end, fullshape_t(c), "〔全形羅馬字〕")
    roma.preedit = jp_p
    roma_f.preedit = jp_p
    yield(roma)
    yield(roma_f)
    if not string.match(hw, "%l") then
      local hwkata = Candidate("simp_jp", seg.start, seg._end, hw, "〔半形片假名〕")
      local kata = Candidate("simp_jp", seg.start, seg._end, kata_t(hw), "〔片假名〕")
      local hira = Candidate("simp_jp", seg.start, seg._end, hira_t(hw), "〔平假名〕")
      hwkata.preedit = jp_p
      kata.preedit = jp_p
      hira.preedit = jp_p
      yield(hwkata)
      yield(kata)
      yield(hira)
    end
  end
end

return { convert_japan_translator = convert_japan_translator,
       p_convert_japan_translator = p_convert_japan_translator }