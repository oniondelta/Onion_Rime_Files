--- @@ halfwidth_katakana_filter
--[[
（jpnin1）
轉換半形片假名，有 bug 關閉。
--]]
local function halfwidth_katakana(in_k)
  if in_k == "" then return "" end
  in_k = string.gsub(in_k, "。", "｡")
  in_k = string.gsub(in_k, "、", "､")
  in_k = string.gsub(in_k, "・", "･")
  in_k = string.gsub(in_k, "ヲ", "ｦ")
  in_k = string.gsub(in_k, "ァ", "ｧ")
  in_k = string.gsub(in_k, "ィ", "ｨ")
  in_k = string.gsub(in_k, "ゥ", "ｩ")
  in_k = string.gsub(in_k, "ェ", "ｪ")
  in_k = string.gsub(in_k, "ォ", "ｫ")
  in_k = string.gsub(in_k, "ャ", "ｬ")
  in_k = string.gsub(in_k, "ュ", "ｭ")
  in_k = string.gsub(in_k, "ョ", "ｮ")
  in_k = string.gsub(in_k, "ッ", "ｯ")
  in_k = string.gsub(in_k, "ー", "ｰ")
  in_k = string.gsub(in_k, "ア", "ｱ")
  in_k = string.gsub(in_k, "イ", "ｲ")
  in_k = string.gsub(in_k, "ウ", "ｳ")
  in_k = string.gsub(in_k, "エ", "ｴ")
  in_k = string.gsub(in_k, "オ", "ｵ")
  in_k = string.gsub(in_k, "カ", "ｶ")
  in_k = string.gsub(in_k, "キ", "ｷ")
  in_k = string.gsub(in_k, "ク", "ｸ")
  in_k = string.gsub(in_k, "ケ", "ｹ")
  in_k = string.gsub(in_k, "コ", "ｺ")
  in_k = string.gsub(in_k, "サ", "ｻ")
  in_k = string.gsub(in_k, "シ", "ｼ")
  in_k = string.gsub(in_k, "ス", "ｽ")
  in_k = string.gsub(in_k, "セ", "ｾ")
  in_k = string.gsub(in_k, "ソ", "ｿ")
  in_k = string.gsub(in_k, "タ", "ﾀ")
  in_k = string.gsub(in_k, "チ", "ﾁ")
  in_k = string.gsub(in_k, "ツ", "ﾂ")
  in_k = string.gsub(in_k, "テ", "ﾃ")
  in_k = string.gsub(in_k, "ト", "ﾄ")
  in_k = string.gsub(in_k, "ナ", "ﾅ")
  in_k = string.gsub(in_k, "ニ", "ﾆ")
  in_k = string.gsub(in_k, "ヌ", "ﾇ")
  in_k = string.gsub(in_k, "ネ", "ﾈ")
  in_k = string.gsub(in_k, "ノ", "ﾉ")
  in_k = string.gsub(in_k, "ハ", "ﾊ")
  in_k = string.gsub(in_k, "ヒ", "ﾋ")
  in_k = string.gsub(in_k, "フ", "ﾌ")
  in_k = string.gsub(in_k, "ヘ", "ﾍ")
  in_k = string.gsub(in_k, "ホ", "ﾎ")
  in_k = string.gsub(in_k, "マ", "ﾏ")
  in_k = string.gsub(in_k, "ミ", "ﾐ")
  in_k = string.gsub(in_k, "ム", "ﾑ")
  in_k = string.gsub(in_k, "メ", "ﾒ")
  in_k = string.gsub(in_k, "モ", "ﾓ")
  in_k = string.gsub(in_k, "ヤ", "ﾔ")
  in_k = string.gsub(in_k, "ユ", "ﾕ")
  in_k = string.gsub(in_k, "ヨ", "ﾖ")
  in_k = string.gsub(in_k, "ラ", "ﾗ")
  in_k = string.gsub(in_k, "リ", "ﾘ")
  in_k = string.gsub(in_k, "ル", "ﾙ")
  in_k = string.gsub(in_k, "レ", "ﾚ")
  in_k = string.gsub(in_k, "ロ", "ﾛ")
  in_k = string.gsub(in_k, "ワ", "ﾜ")
  in_k = string.gsub(in_k, "ン", "ﾝ")
  in_k = string.gsub(in_k, "゛", "ﾞ")
  in_k = string.gsub(in_k, "゜", "ﾟ")
  return in_k
end

local function is_katapart(c)
  -- return 12449 <= c and c <= 12534 or c == 12540 or c == 12539
  return 0x30A1 <= c and c <= 0x30EF or
  0x30F2 <= c and c <= 0x30FC or
  0x309C == c or
  0x309B == c
end

local function check_kata(text)
  -- local checkkata = true
  -- for _, c in utf8.codes(text) do
  for i in utf8.codes(text) do
    local c = utf8.codepoint(text, i)
    if not is_katapart(c) then
      -- checkkata = false
      -- return checkkata
      return false
    end
  end
  -- return checkkata
  return true
end


-- local charset_j = {
--   ["CJK"] = { first = 0x4E00, last = 0x9FFF },     -- CJK Unified Ideographs - https://unicode.org/charts/PDF/U4E00.pdf
--   ["ExtA"] = { first = 0x3400, last = 0x4DBF },    -- CJK Unified Ideographs Extension A - https://unicode.org/charts/PDF/U3400.pdf
--   ["ExtB"] = { first = 0x20000, last = 0x2A6DF },  -- CJK Unified Ideographs Extension B - https://unicode.org/charts/PDF/U20000.pdf
--   ["ExtC"] = { first = 0x2A700, last = 0x2B73F },  -- CJK Unified Ideographs Extension C - https://unicode.org/charts/PDF/U2A700.pdf
--   ["ExtD"] = { first = 0x2B740, last = 0x2B81F },  -- CJK Unified Ideographs Extension D - https://unicode.org/charts/PDF/U2B740.pdf
--   ["ExtE"] = { first = 0x2B820, last = 0x2CEAF },  -- CJK Unified Ideographs Extension E - https://unicode.org/charts/PDF/U2B820.pdf
--   ["ExtF"] = { first = 0x2CEB0, last = 0x2EBEF },  -- CJK Unified Ideographs Extension F - https://unicode.org/charts/PDF/U2CEB0.pdf
--   ["ExtG"] = { first = 0x30000, last = 0x3134A },  -- CJK Unified Ideographs Extension G - https://unicode.org/charts/PDF/U30000.pdf
--   ["Compat"] = { first = 0x2F800, last = 0x2FA1F }, -- CJK Compatibility Ideographs Supplement - https://unicode.org/charts/PDF/U2F800.pdf

--   ["Hiragana"] = { first = 0x3041, last = 0x3096 },
--   -- ["Katakana"] = { first = 0x30A1, last = 0x30FC },
--   -- ["Katakana2"] = { first = 0x30fb, last = 0x30fc },
--   -- ["Katakana3"] = { first = 0x309b, last = 0x309c },
--   -- ["J_punctuation"] = { first = 0x3001, last = 0x3002 },
--   ["J_punctuation"] = { first = 0x3005, last = 0x3006 },
--   }

-- local function exists_j(single_filter, text)
--   for i in utf8.codes(text) do
--     local c = utf8.codepoint(text, i)
--     if (not single_filter(c)) then
--       return false
--     end
--   end
--   return true
-- end

-- local function is_charset_j(s)
--   return function (c)
--     return c >= charset_j[s].first and c <= charset_j[s].last
--   end
-- end

-- local function is_cjk_j_ext(c)
--   return is_charset_j("CJK")(c) or is_charset_j("ExtA")(c) or is_charset_j("ExtB")(c) or
--     is_charset_j("ExtC")(c) or is_charset_j("ExtD")(c) or
--     is_charset_j("ExtE")(c) or is_charset_j("ExtF")(c) or
--     is_charset_j("ExtG")(c) or is_charset_j("Compat")(c) or is_charset_j("Hiragana")(c) or
--     is_charset_j("J_punctuation")(c)
--   -- return is_charset_j("katakana")(c) or is_charset_j("katakana2")(c)
--   --   is_charset("katakana3")(c) or is_charset("j_punctuation")(c)
-- end




-- local M={}
-- local function init(env)
-- function M.init(env)


-- function M.fini(env)
-- end


-- local function halfwidth_katakana_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input  -- 原始未轉換輸入碼
  -- local newcand = {start = context:get_preedit().sel_start, _end = context:get_preedit().sel_end}
  for cand in inp:iter() do
    local start = context:get_preedit().sel_start
    local _end = context:get_preedit().sel_end
    -- if (string.match(c_input, "%.,$")) and (string.match(cand.text, "^[。、・ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン゛゜]+$")) then
    -- if (string.match(c_input, "%.,$")) and (string.gmatch(cand.text, "^[\x30a1-\x30ab\x30ad\x30af\x30b1\x30b3\x30b5\x30b7\x30b9\x30bb\x30bd\x30bf\x30c1\x30c3\x30c4\x30c6\x30c8\x30ca-\x30cf\x30d2\x30d5\x30d8\x30db\x30de-\x30ed\x30ef\x30f2\x30f3\x30fb\x30fc\x3001\x3002\x309b\x309c]+$")) then
    -- if (not string.match(c_input, "%.$")) then
 -- and (string.match(cand.text, "^[ナ]+$"))
      -- if (string.gmatch(cand.text, "^[\x30a1-\x30ab\x30ad\x30af\x30b1\x30b3\x30b5\x30b7\x30b9\x30bb\x30bd\x30bf\x30c1\x30c3\x30c4\x30c6\x30c8\x30ca-\x30cf\x30d2\x30d5\x30d8\x30db\x30de-\x30ed\x30ef\x30f2\x30f3\x30fb\x30fc\x3001\x3002\x309b\x309c]+$")) then
      -- if (string.gmatch(cand.text, "^[\x30a1-\x30f3]+$")) then
      -- if (exists(is_katakana, cand.text)) then
      -- if (string.match(cand.text, "^[。、・ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン゛゜]+$")) then
    local kana = Candidate("simp_halfwidth_katakana", start, _end, halfwidth_katakana(cand.text), "〔ｶﾀｶﾅ〕")
      -- local kana = Candidate("simp_halfwidth_katakana", 0, string.len(c_input), halfwidth_katakana(cand.text), " ｶﾀｶﾅ")
      -- local kana = Candidate("simp_halfwidth_katakana", context:get_preedit().sel_start, context:get_preedit().sel_end, halfwidth_katakana(cand.text), " ﹙ｶﾀｶﾅ﹚")
        -- local kana = Candidate("simp_halfwidth_katakana", 0, 3, halfwidth_katakana(cand.text), " ｶﾀｶﾅ")
      -- yield(kana)
        -- yield(cand)
        -- break
      -- return
    -- else
      -- local k_pattern = "[\x30a1-\x30ab\x30ad\x30af\x30b1\x30b3\x30b5\x30b7\x30b9\x30bb\x30bd\x30bf\x30c1\x30c3\x30c4\x30c6\x30c8\x30ca-\x30cf\x30d2\x30d5\x30d8\x30db\x30de-\x30ed\x30ef\x30f2\x30f3\x30fb\x30fc\x3001\x3002\x309b\x309c])"
      -- local k_pattern = "^[\u{30a1}-\u{30fc}]+$"
    -- local k_pattern = "^[\u{3002}\u{3001}\u{30fb}\u{30fc}\u{309c}\u{309b}\u{30a2}\u{30a4}\u{30a6}\u{30a8}\u{30aa}\u{30ab}\u{30ad}\u{30af}\u{30b1}\u{30b3}\u{30b5}\u{30b7}\u{30b9}\u{30bb}\u{30bd}\u{30bf}\u{30c1}\u{30c4}\u{30c6}\u{30c8}\u{30ca}\u{30cb}\u{30cc}\u{30cd}\u{30ce}\u{30cf}\u{30d2}\u{30d5}\u{30d8}\u{30db}\u{30de}\u{30df}\u{30e0}\u{30e1}\u{30e2}\u{30e4}\u{30e6}\u{30e8}\u{30e9}\u{30ea}\u{30eb}\u{30ec}\u{30ed}\u{30ef}\u{30f2}\u{30f3}\u{30a1}\u{30a3}\u{30a5}\u{30a7}\u{30a9}\u{30e3}\u{30e5}\u{30e7}\u{30c3}]+$"
      -- local k_pattern = "^[。、・ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン゛゜]+$"
      -- local k_pattern = "^[ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン]+$"
      -- local h_pattern = "[をぁぃぅぇぉゃゅょっあいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわん]"
      -- local c_pattern = "[\x4e00-\x9fa5]"


    -- if (string.match(cand.text, k_pattern )) then
    -- if (string.match(cand.text, k_pattern )) then
    --   -- local kana = Candidate("simp_halfwidth_katakana", context:get_preedit().sel_start, context:get_preedit().sel_end, halfwidth_katakana(cand.text), " ﹙ｶﾀｶﾅ﹚")
    --   yield(cand)
    --   yield(kana)
    -- else
    -- -- if (not string.gmatch(cand.text, k_pattern ) or string.gmatch(cand.text, c_pattern )) then
    -- -- if (string.gmatch(cand.text, k_pattern) or string.gmatch(cand.text, c_pattern) ) then
    -- -- if (not string.match(cand.text, "[ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン゛゜。、・]")) then
    --   yield(cand)
    --   -- end
    -- -- end
    --   -- return
    -- end


    -- if (not exists_j(is_cjk_j_ext, cand.text)) then
    --   yield(cand)
    --   yield(kana)
    -- else
    --   yield(cand)
    -- end

    if check_kata(cand.text) == true then
      yield(cand)
      yield(kana)
    else
      yield(cand)
    end

  end
end

-- return halfwidth_katakana_filter
return { func = filter }
-- return M

-- return { halfwidth_katakana_filter = halfwidth_katakana_filter }