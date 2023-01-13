--[[
number_translator: 將 `'/` + 阿拉伯數字 和 英文字母 各種轉譯
--]]

------------------------------------

local function english_s(en)
  if en == "" then return "" end
  return string.gsub(en, ",", " ")
end

local function english_u1(en)
  if en == "" then return "" end
  -- en = string.upper(string.sub(en,1,1)) .. string.sub(english_u2(english_s(en)),2)
  en = english_s(en)
  return en:gsub("^%l",string.upper)
end

local function english_u2(en)
  if en == "" then return "" end
  -- if string.match(en, "^[/.'-][a-z]") then
  --   en = string.upper(string.sub(en,1,2)) .. string.sub(en,3)
  -- end
  en = en:gsub("[/-]%l",string.upper)
  en = en:gsub("^['.]%l",string.upper)
  return en
end

local function english_s2u(en)
  if en == "" then return "" end
  en = english_u1(en)
  en = english_u2(en)
  return en:gsub(" %l",string.upper)
end

------------------------------------

local function english_1(en1)
  if en1 == "" then return "" end
  en1 = string.gsub(en1, "A", "𝔸")
  en1 = string.gsub(en1, "B", "𝔹")
  en1 = string.gsub(en1, "C", "ℂ")
  en1 = string.gsub(en1, "D", "𝔻")
  en1 = string.gsub(en1, "E", "𝔼")
  en1 = string.gsub(en1, "F", "𝔽")
  en1 = string.gsub(en1, "G", "𝔾")
  en1 = string.gsub(en1, "H", "ℍ")
  en1 = string.gsub(en1, "I", "𝕀")
  en1 = string.gsub(en1, "J", "𝕁")
  en1 = string.gsub(en1, "K", "𝕂")
  en1 = string.gsub(en1, "L", "𝕃")
  en1 = string.gsub(en1, "M", "𝕄")
  en1 = string.gsub(en1, "N", "ℕ")
  en1 = string.gsub(en1, "O", "𝕆")
  en1 = string.gsub(en1, "P", "ℙ")
  en1 = string.gsub(en1, "Q", "ℚ")
  en1 = string.gsub(en1, "R", "ℝ")
  en1 = string.gsub(en1, "S", "𝕊")
  en1 = string.gsub(en1, "T", "𝕋")
  en1 = string.gsub(en1, "U", "𝕌")
  en1 = string.gsub(en1, "V", "𝕍")
  en1 = string.gsub(en1, "W", "𝕎")
  en1 = string.gsub(en1, "X", "𝕏")
  en1 = string.gsub(en1, "Y", "𝕐")
  en1 = string.gsub(en1, "Z", "ℤ")
  en1 = string.gsub(en1, ",", " ")
  return en1
end

local function english_2(en2)
  if en2 == "" then return "" end
  en2 = string.gsub(en2, "a", "𝕒")
  en2 = string.gsub(en2, "b", "𝕓")
  en2 = string.gsub(en2, "c", "𝕔")
  en2 = string.gsub(en2, "d", "𝕕")
  en2 = string.gsub(en2, "e", "𝕖")
  en2 = string.gsub(en2, "f", "𝕗")
  en2 = string.gsub(en2, "g", "𝕘")
  en2 = string.gsub(en2, "h", "𝕙")
  en2 = string.gsub(en2, "i", "𝕚")
  en2 = string.gsub(en2, "j", "𝕛")
  en2 = string.gsub(en2, "k", "𝕜")
  en2 = string.gsub(en2, "l", "𝕝")
  en2 = string.gsub(en2, "m", "𝕞")
  en2 = string.gsub(en2, "n", "𝕟")
  en2 = string.gsub(en2, "o", "𝕠")
  en2 = string.gsub(en2, "p", "𝕡")
  en2 = string.gsub(en2, "q", "𝕢")
  en2 = string.gsub(en2, "r", "𝕣")
  en2 = string.gsub(en2, "s", "𝕤")
  en2 = string.gsub(en2, "t", "𝕥")
  en2 = string.gsub(en2, "u", "𝕦")
  en2 = string.gsub(en2, "v", "𝕧")
  en2 = string.gsub(en2, "w", "𝕨")
  en2 = string.gsub(en2, "x", "𝕩")
  en2 = string.gsub(en2, "y", "𝕪")
  en2 = string.gsub(en2, "z", "𝕫")
  en2 = string.gsub(en2, ",", " ")
  return en2
end

local function english_3(en3)
  if en3 == "" then return "" end
  en3 = string.gsub(en3, "A", "Ⓐ")
  en3 = string.gsub(en3, "B", "Ⓑ")
  en3 = string.gsub(en3, "C", "Ⓒ")
  en3 = string.gsub(en3, "D", "Ⓓ")
  en3 = string.gsub(en3, "E", "Ⓔ")
  en3 = string.gsub(en3, "F", "Ⓕ")
  en3 = string.gsub(en3, "G", "Ⓖ")
  en3 = string.gsub(en3, "H", "Ⓗ")
  en3 = string.gsub(en3, "I", "Ⓘ")
  en3 = string.gsub(en3, "J", "Ⓙ")
  en3 = string.gsub(en3, "K", "Ⓚ")
  en3 = string.gsub(en3, "L", "Ⓛ")
  en3 = string.gsub(en3, "M", "Ⓜ")
  en3 = string.gsub(en3, "N", "Ⓝ")
  en3 = string.gsub(en3, "O", "Ⓞ")
  en3 = string.gsub(en3, "P", "Ⓟ")
  en3 = string.gsub(en3, "Q", "Ⓠ")
  en3 = string.gsub(en3, "R", "Ⓡ")
  en3 = string.gsub(en3, "S", "Ⓢ")
  en3 = string.gsub(en3, "T", "Ⓣ")
  en3 = string.gsub(en3, "U", "Ⓤ")
  en3 = string.gsub(en3, "V", "Ⓥ")
  en3 = string.gsub(en3, "W", "Ⓦ")
  en3 = string.gsub(en3, "X", "Ⓧ")
  en3 = string.gsub(en3, "Y", "Ⓨ")
  en3 = string.gsub(en3, "Z", "Ⓩ")
  en3 = string.gsub(en3, ",", " ")
  return en3
end

local function english_4(en4)
  if en4 == "" then return "" end
  en4 = string.gsub(en4, "a", "ⓐ")
  en4 = string.gsub(en4, "b", "ⓑ")
  en4 = string.gsub(en4, "c", "ⓒ")
  en4 = string.gsub(en4, "d", "ⓓ")
  en4 = string.gsub(en4, "e", "ⓔ")
  en4 = string.gsub(en4, "f", "ⓕ")
  en4 = string.gsub(en4, "g", "ⓖ")
  en4 = string.gsub(en4, "h", "ⓗ")
  en4 = string.gsub(en4, "i", "ⓘ")
  en4 = string.gsub(en4, "j", "ⓙ")
  en4 = string.gsub(en4, "k", "ⓚ")
  en4 = string.gsub(en4, "l", "ⓛ")
  en4 = string.gsub(en4, "m", "ⓜ")
  en4 = string.gsub(en4, "n", "ⓝ")
  en4 = string.gsub(en4, "o", "ⓞ")
  en4 = string.gsub(en4, "p", "ⓟ")
  en4 = string.gsub(en4, "q", "ⓠ")
  en4 = string.gsub(en4, "r", "ⓡ")
  en4 = string.gsub(en4, "s", "ⓢ")
  en4 = string.gsub(en4, "t", "ⓣ")
  en4 = string.gsub(en4, "u", "ⓤ")
  en4 = string.gsub(en4, "v", "ⓥ")
  en4 = string.gsub(en4, "w", "ⓦ")
  en4 = string.gsub(en4, "x", "ⓧ")
  en4 = string.gsub(en4, "y", "ⓨ")
  en4 = string.gsub(en4, "z", "ⓩ")
  en4 = string.gsub(en4, ",", " ")
  return en4
end

local function english_5(en5)
  if en5 == "" then return "" end
  en5 = string.gsub(en5, "A", "🄐")
  en5 = string.gsub(en5, "B", "🄑")
  en5 = string.gsub(en5, "C", "🄒")
  en5 = string.gsub(en5, "D", "🄓")
  en5 = string.gsub(en5, "E", "🄔")
  en5 = string.gsub(en5, "F", "🄕")
  en5 = string.gsub(en5, "G", "🄖")
  en5 = string.gsub(en5, "H", "🄗")
  en5 = string.gsub(en5, "I", "🄘")
  en5 = string.gsub(en5, "J", "🄙")
  en5 = string.gsub(en5, "K", "🄚")
  en5 = string.gsub(en5, "L", "🄛")
  en5 = string.gsub(en5, "M", "🄜")
  en5 = string.gsub(en5, "N", "🄝")
  en5 = string.gsub(en5, "O", "🄞")
  en5 = string.gsub(en5, "P", "🄟")
  en5 = string.gsub(en5, "Q", "🄠")
  en5 = string.gsub(en5, "R", "🄡")
  en5 = string.gsub(en5, "S", "🄢")
  en5 = string.gsub(en5, "T", "🄣")
  en5 = string.gsub(en5, "U", "🄤")
  en5 = string.gsub(en5, "V", "🄥")
  en5 = string.gsub(en5, "W", "🄦")
  en5 = string.gsub(en5, "X", "🄧")
  en5 = string.gsub(en5, "Y", "🄨")
  en5 = string.gsub(en5, "Z", "🄩")
  en5 = string.gsub(en5, ",", " ")
  return en5
end

local function english_6(en6)
  if en6 == "" then return "" end
  en6 = string.gsub(en6, "a", "⒜")
  en6 = string.gsub(en6, "b", "⒝")
  en6 = string.gsub(en6, "c", "⒞")
  en6 = string.gsub(en6, "d", "⒟")
  en6 = string.gsub(en6, "e", "⒠")
  en6 = string.gsub(en6, "f", "⒡")
  en6 = string.gsub(en6, "g", "⒢")
  en6 = string.gsub(en6, "h", "⒣")
  en6 = string.gsub(en6, "i", "⒤")
  en6 = string.gsub(en6, "j", "⒥")
  en6 = string.gsub(en6, "k", "⒦")
  en6 = string.gsub(en6, "l", "⒧")
  en6 = string.gsub(en6, "m", "⒨")
  en6 = string.gsub(en6, "n", "⒩")
  en6 = string.gsub(en6, "o", "⒪")
  en6 = string.gsub(en6, "p", "⒫")
  en6 = string.gsub(en6, "q", "⒬")
  en6 = string.gsub(en6, "r", "⒭")
  en6 = string.gsub(en6, "s", "⒮")
  en6 = string.gsub(en6, "t", "⒯")
  en6 = string.gsub(en6, "u", "⒰")
  en6 = string.gsub(en6, "v", "⒱")
  en6 = string.gsub(en6, "w", "⒲")
  en6 = string.gsub(en6, "x", "⒳")
  en6 = string.gsub(en6, "y", "⒴")
  en6 = string.gsub(en6, "z", "⒵")
  en6 = string.gsub(en6, ",", " ")
  return en6
end

local function english_7(en7)
  if en7 == "" then return "" end
  en7 = string.gsub(en7, "A", "🄰")
  en7 = string.gsub(en7, "B", "🄱")
  en7 = string.gsub(en7, "C", "🄲")
  en7 = string.gsub(en7, "D", "🄳")
  en7 = string.gsub(en7, "E", "🄴")
  en7 = string.gsub(en7, "F", "🄵")
  en7 = string.gsub(en7, "G", "🄶")
  en7 = string.gsub(en7, "H", "🄷")
  en7 = string.gsub(en7, "I", "🄸")
  en7 = string.gsub(en7, "J", "🄹")
  en7 = string.gsub(en7, "K", "🄺")
  en7 = string.gsub(en7, "L", "🄻")
  en7 = string.gsub(en7, "M", "🄼")
  en7 = string.gsub(en7, "N", "🄽")
  en7 = string.gsub(en7, "O", "🄾")
  en7 = string.gsub(en7, "P", "🄿")
  en7 = string.gsub(en7, "Q", "🅀")
  en7 = string.gsub(en7, "R", "🅁")
  en7 = string.gsub(en7, "S", "🅂")
  en7 = string.gsub(en7, "T", "🅃")
  en7 = string.gsub(en7, "U", "🅄")
  en7 = string.gsub(en7, "V", "🅅")
  en7 = string.gsub(en7, "W", "🅆")
  en7 = string.gsub(en7, "X", "🅇")
  en7 = string.gsub(en7, "Y", "🅈")
  en7 = string.gsub(en7, "Z", "🅉")
  en7 = string.gsub(en7, ",", " ")
  return en7
end

local function english_8(en8)
  if en8 == "" then return "" end
  en8 = string.gsub(en8, "A", "🅐")
  en8 = string.gsub(en8, "B", "🅑")
  en8 = string.gsub(en8, "C", "🅒")
  en8 = string.gsub(en8, "D", "🅓")
  en8 = string.gsub(en8, "E", "🅔")
  en8 = string.gsub(en8, "F", "🅕")
  en8 = string.gsub(en8, "G", "🅖")
  en8 = string.gsub(en8, "H", "🅗")
  en8 = string.gsub(en8, "I", "🅘")
  en8 = string.gsub(en8, "J", "🅙")
  en8 = string.gsub(en8, "K", "🅚")
  en8 = string.gsub(en8, "L", "🅛")
  en8 = string.gsub(en8, "M", "🅜")
  en8 = string.gsub(en8, "N", "🅝")
  en8 = string.gsub(en8, "O", "🅞")
  en8 = string.gsub(en8, "P", "🅟")
  en8 = string.gsub(en8, "Q", "🅠")
  en8 = string.gsub(en8, "R", "🅡")
  en8 = string.gsub(en8, "S", "🅢")
  en8 = string.gsub(en8, "T", "🅣")
  en8 = string.gsub(en8, "U", "🅤")
  en8 = string.gsub(en8, "V", "🅥")
  en8 = string.gsub(en8, "W", "🅦")
  en8 = string.gsub(en8, "X", "🅧")
  en8 = string.gsub(en8, "Y", "🅨")
  en8 = string.gsub(en8, "Z", "🅩")
  en8 = string.gsub(en8, ",", " ")
  return en8
end

local function english_9(en9)
  if en9 == "" then return "" end
  en9 = string.gsub(en9, "A", "🅰")
  en9 = string.gsub(en9, "B", "🅱")
  en9 = string.gsub(en9, "C", "🅲")
  en9 = string.gsub(en9, "D", "🅳")
  en9 = string.gsub(en9, "E", "🅴")
  en9 = string.gsub(en9, "F", "🅵")
  en9 = string.gsub(en9, "G", "🅶")
  en9 = string.gsub(en9, "H", "🅷")
  en9 = string.gsub(en9, "I", "🅸")
  en9 = string.gsub(en9, "J", "🅹")
  en9 = string.gsub(en9, "K", "🅺")
  en9 = string.gsub(en9, "L", "🅻")
  en9 = string.gsub(en9, "M", "🅼")
  en9 = string.gsub(en9, "N", "🅽")
  en9 = string.gsub(en9, "O", "🅾")
  en9 = string.gsub(en9, "P", "🅿")
  en9 = string.gsub(en9, "Q", "🆀")
  en9 = string.gsub(en9, "R", "🆁")
  en9 = string.gsub(en9, "S", "🆂")
  en9 = string.gsub(en9, "T", "🆃")
  en9 = string.gsub(en9, "U", "🆄")
  en9 = string.gsub(en9, "V", "🆅")
  en9 = string.gsub(en9, "W", "🆆")
  en9 = string.gsub(en9, "X", "🆇")
  en9 = string.gsub(en9, "Y", "🆈")
  en9 = string.gsub(en9, "Z", "🆉")
  en9 = string.gsub(en9, ",", " ")
  return en9
end

local function english_f_u(en_f_u)
  if en_f_u == "" then return "" end
  en_f_u = string.gsub(en_f_u, "A", "Ａ")
  en_f_u = string.gsub(en_f_u, "B", "Ｂ")
  en_f_u = string.gsub(en_f_u, "C", "Ｃ")
  en_f_u = string.gsub(en_f_u, "D", "Ｄ")
  en_f_u = string.gsub(en_f_u, "E", "Ｅ")
  en_f_u = string.gsub(en_f_u, "F", "Ｆ")
  en_f_u = string.gsub(en_f_u, "G", "Ｇ")
  en_f_u = string.gsub(en_f_u, "H", "Ｈ")
  en_f_u = string.gsub(en_f_u, "I", "Ｉ")
  en_f_u = string.gsub(en_f_u, "J", "Ｊ")
  en_f_u = string.gsub(en_f_u, "K", "Ｋ")
  en_f_u = string.gsub(en_f_u, "L", "Ｌ")
  en_f_u = string.gsub(en_f_u, "M", "Ｍ")
  en_f_u = string.gsub(en_f_u, "N", "Ｎ")
  en_f_u = string.gsub(en_f_u, "O", "Ｏ")
  en_f_u = string.gsub(en_f_u, "P", "Ｐ")
  en_f_u = string.gsub(en_f_u, "Q", "Ｑ")
  en_f_u = string.gsub(en_f_u, "R", "Ｒ")
  en_f_u = string.gsub(en_f_u, "S", "Ｓ")
  en_f_u = string.gsub(en_f_u, "T", "Ｔ")
  en_f_u = string.gsub(en_f_u, "U", "Ｕ")
  en_f_u = string.gsub(en_f_u, "V", "Ｖ")
  en_f_u = string.gsub(en_f_u, "W", "Ｗ")
  en_f_u = string.gsub(en_f_u, "X", "Ｘ")
  en_f_u = string.gsub(en_f_u, "Y", "Ｙ")
  en_f_u = string.gsub(en_f_u, "Z", "Ｚ")
  en_f_u = string.gsub(en_f_u, ",", "　")
  en_f_u = string.gsub(en_f_u, "%.", "．")
  en_f_u = string.gsub(en_f_u, "-", "－")
  en_f_u = string.gsub(en_f_u, "/", "／")
  en_f_u = string.gsub(en_f_u, "'", "＇")
  return en_f_u
end

local function english_f_l(en_f_l)
  if en_f_l == "" then return "" end
  en_f_l = string.gsub(en_f_l, "a", "ａ")
  en_f_l = string.gsub(en_f_l, "b", "ｂ")
  en_f_l = string.gsub(en_f_l, "c", "ｃ")
  en_f_l = string.gsub(en_f_l, "d", "ｄ")
  en_f_l = string.gsub(en_f_l, "e", "ｅ")
  en_f_l = string.gsub(en_f_l, "f", "ｆ")
  en_f_l = string.gsub(en_f_l, "g", "ｇ")
  en_f_l = string.gsub(en_f_l, "h", "ｈ")
  en_f_l = string.gsub(en_f_l, "i", "ｉ")
  en_f_l = string.gsub(en_f_l, "j", "ｊ")
  en_f_l = string.gsub(en_f_l, "k", "ｋ")
  en_f_l = string.gsub(en_f_l, "l", "ｌ")
  en_f_l = string.gsub(en_f_l, "m", "ｍ")
  en_f_l = string.gsub(en_f_l, "n", "ｎ")
  en_f_l = string.gsub(en_f_l, "o", "ｏ")
  en_f_l = string.gsub(en_f_l, "p", "ｐ")
  en_f_l = string.gsub(en_f_l, "q", "ｑ")
  en_f_l = string.gsub(en_f_l, "r", "ｒ")
  en_f_l = string.gsub(en_f_l, "s", "ｓ")
  en_f_l = string.gsub(en_f_l, "t", "ｔ")
  en_f_l = string.gsub(en_f_l, "u", "ｕ")
  en_f_l = string.gsub(en_f_l, "v", "ｖ")
  en_f_l = string.gsub(en_f_l, "w", "ｗ")
  en_f_l = string.gsub(en_f_l, "x", "ｘ")
  en_f_l = string.gsub(en_f_l, "y", "ｙ")
  en_f_l = string.gsub(en_f_l, "z", "ｚ")
  en_f_l = string.gsub(en_f_l, ",", "　")
  en_f_l = string.gsub(en_f_l, "%.", "．")
  en_f_l = string.gsub(en_f_l, "-", "－")
  en_f_l = string.gsub(en_f_l, "/", "／")
  en_f_l = string.gsub(en_f_l, "'", "＇")
  return en_f_l
end

local function english_s_u(en_s_u)
  if en_s_u == "" then return "" end
  en_s_u = string.gsub(en_s_u, "A", "ᴀ")
  en_s_u = string.gsub(en_s_u, "B", "ʙ")
  en_s_u = string.gsub(en_s_u, "C", "ᴄ")
  en_s_u = string.gsub(en_s_u, "D", "ᴅ")
  en_s_u = string.gsub(en_s_u, "E", "ᴇ")
  en_s_u = string.gsub(en_s_u, "F", "ꜰ")
  en_s_u = string.gsub(en_s_u, "G", "ɢ")
  en_s_u = string.gsub(en_s_u, "H", "ʜ")
  en_s_u = string.gsub(en_s_u, "I", "ɪ")
  en_s_u = string.gsub(en_s_u, "J", "ᴊ")
  en_s_u = string.gsub(en_s_u, "K", "ᴋ")
  en_s_u = string.gsub(en_s_u, "L", "ʟ")
  en_s_u = string.gsub(en_s_u, "M", "ᴍ")
  en_s_u = string.gsub(en_s_u, "N", "ɴ")
  en_s_u = string.gsub(en_s_u, "O", "ᴏ")
  en_s_u = string.gsub(en_s_u, "P", "ᴘ")
  en_s_u = string.gsub(en_s_u, "Q", "ǫ")
  en_s_u = string.gsub(en_s_u, "R", "ʀ")
  en_s_u = string.gsub(en_s_u, "S", "s")
  en_s_u = string.gsub(en_s_u, "T", "ᴛ")
  en_s_u = string.gsub(en_s_u, "U", "ᴜ")
  en_s_u = string.gsub(en_s_u, "V", "ᴠ")
  en_s_u = string.gsub(en_s_u, "W", "ᴡ")
  en_s_u = string.gsub(en_s_u, "X", "x")
  en_s_u = string.gsub(en_s_u, "Y", "ʏ")
  en_s_u = string.gsub(en_s_u, "Z", "ᴢ")
  en_s_u = string.gsub(en_s_u, ",", " ")
  return en_s_u
end

local function english_1_2(en_1_2)
  if en_1_2 == "" then return "" end
  -- en_1_2 = english_1(string.sub(en_1_2,1,1)) .. english_2(string.sub(en_1_2,2,-1))
  en_1_2 = english_s2u(en_1_2)
  en_1_2 = english_1(en_1_2)
  en_1_2 = english_2(en_1_2)
  return en_1_2
end

local function english_3_4(en_3_4)
  if en_3_4 == "" then return "" end
  -- en_3_4 = english_3(string.sub(en_3_4,1,1)) .. english_4(string.sub(en_3_4,2,-1))
  en_3_4 = english_s2u(en_3_4)
  en_3_4 = english_3(en_3_4)
  en_3_4 = english_4(en_3_4)
  return en_3_4
end

local function english_5_6(en_5_6)
  if en_5_6 == "" then return "" end
  -- en_5_6 = english_5(string.sub(en_5_6,1,1)) .. english_6(string.sub(en_5_6,2,-1))
  en_5_6 = english_s2u(en_5_6)
  en_5_6 = english_5(en_5_6)
  en_5_6 = english_6(en_5_6)
  return en_5_6
end

local function english_f_ul(en_ul)
  if en_ul == "" then return "" end
  -- en_ul = english_f_u(string.sub(en_ul,1,1)) .. english_f_l(string.sub(en_ul,2,-1))
  en_ul = english_s2u(en_ul)
  en_ul = english_f_u(en_ul)
  en_ul = english_f_l(en_ul)
  return en_ul
end




return {
        english_s = english_s,
        english_u1 = english_u1,
        -- english_u2 = english_u2,
        english_s2u = english_s2u,

        english_1 = english_1,
        english_2 = english_2,
        english_3 = english_3,
        english_4 = english_4,
        english_5 = english_5,
        english_6 = english_6,
        english_7 = english_7,
        english_8 = english_8,
        english_9 = english_9,
        english_f_u = english_f_u,
        english_f_l = english_f_l,
        english_s_u = english_s_u,
        english_1_2 = english_1_2,
        english_3_4 = english_3_4,
        english_5_6 = english_5_6,
        english_f_ul = english_f_ul,
        }