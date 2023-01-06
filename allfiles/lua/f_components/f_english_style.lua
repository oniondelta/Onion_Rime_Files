--[[
number_translator: 將 `'/` + 阿拉伯數字 和 英文字母 各種轉譯
--]]

local function english_1(en1)
  if en1 == "" then return "" end
  en1 = string.gsub(en1, "a", "𝔸")
  en1 = string.gsub(en1, "b", "𝔹")
  en1 = string.gsub(en1, "c", "ℂ")
  en1 = string.gsub(en1, "d", "𝔻")
  en1 = string.gsub(en1, "e", "𝔼")
  en1 = string.gsub(en1, "f", "𝔽")
  en1 = string.gsub(en1, "g", "𝔾")
  en1 = string.gsub(en1, "h", "ℍ")
  en1 = string.gsub(en1, "i", "𝕀")
  en1 = string.gsub(en1, "j", "𝕁")
  en1 = string.gsub(en1, "k", "𝕂")
  en1 = string.gsub(en1, "l", "𝕃")
  en1 = string.gsub(en1, "m", "𝕄")
  en1 = string.gsub(en1, "n", "ℕ")
  en1 = string.gsub(en1, "o", "𝕆")
  en1 = string.gsub(en1, "p", "ℙ")
  en1 = string.gsub(en1, "q", "ℚ")
  en1 = string.gsub(en1, "r", "ℝ")
  en1 = string.gsub(en1, "s", "𝕊")
  en1 = string.gsub(en1, "t", "𝕋")
  en1 = string.gsub(en1, "u", "𝕌")
  en1 = string.gsub(en1, "v", "𝕍")
  en1 = string.gsub(en1, "w", "𝕎")
  en1 = string.gsub(en1, "x", "𝕏")
  en1 = string.gsub(en1, "y", "𝕐")
  en1 = string.gsub(en1, "z", "ℤ")
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
  return en2
end

local function english_3(en3)
  if en3 == "" then return "" end
  en3 = string.gsub(en3, "a", "Ⓐ")
  en3 = string.gsub(en3, "b", "Ⓑ")
  en3 = string.gsub(en3, "c", "Ⓒ")
  en3 = string.gsub(en3, "d", "Ⓓ")
  en3 = string.gsub(en3, "e", "Ⓔ")
  en3 = string.gsub(en3, "f", "Ⓕ")
  en3 = string.gsub(en3, "g", "Ⓖ")
  en3 = string.gsub(en3, "h", "Ⓗ")
  en3 = string.gsub(en3, "i", "Ⓘ")
  en3 = string.gsub(en3, "j", "Ⓙ")
  en3 = string.gsub(en3, "k", "Ⓚ")
  en3 = string.gsub(en3, "l", "Ⓛ")
  en3 = string.gsub(en3, "m", "Ⓜ")
  en3 = string.gsub(en3, "n", "Ⓝ")
  en3 = string.gsub(en3, "o", "Ⓞ")
  en3 = string.gsub(en3, "p", "Ⓟ")
  en3 = string.gsub(en3, "q", "Ⓠ")
  en3 = string.gsub(en3, "r", "Ⓡ")
  en3 = string.gsub(en3, "s", "Ⓢ")
  en3 = string.gsub(en3, "t", "Ⓣ")
  en3 = string.gsub(en3, "u", "Ⓤ")
  en3 = string.gsub(en3, "v", "Ⓥ")
  en3 = string.gsub(en3, "w", "Ⓦ")
  en3 = string.gsub(en3, "x", "Ⓧ")
  en3 = string.gsub(en3, "y", "Ⓨ")
  en3 = string.gsub(en3, "z", "Ⓩ")
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
  return en4
end

local function english_5(en5)
  if en5 == "" then return "" end
  en5 = string.gsub(en5, "a", "🄐")
  en5 = string.gsub(en5, "b", "🄑")
  en5 = string.gsub(en5, "c", "🄒")
  en5 = string.gsub(en5, "d", "🄓")
  en5 = string.gsub(en5, "e", "🄔")
  en5 = string.gsub(en5, "f", "🄕")
  en5 = string.gsub(en5, "g", "🄖")
  en5 = string.gsub(en5, "h", "🄗")
  en5 = string.gsub(en5, "i", "🄘")
  en5 = string.gsub(en5, "j", "🄙")
  en5 = string.gsub(en5, "k", "🄚")
  en5 = string.gsub(en5, "l", "🄛")
  en5 = string.gsub(en5, "m", "🄜")
  en5 = string.gsub(en5, "n", "🄝")
  en5 = string.gsub(en5, "o", "🄞")
  en5 = string.gsub(en5, "p", "🄟")
  en5 = string.gsub(en5, "q", "🄠")
  en5 = string.gsub(en5, "r", "🄡")
  en5 = string.gsub(en5, "s", "🄢")
  en5 = string.gsub(en5, "t", "🄣")
  en5 = string.gsub(en5, "u", "🄤")
  en5 = string.gsub(en5, "v", "🄥")
  en5 = string.gsub(en5, "w", "🄦")
  en5 = string.gsub(en5, "x", "🄧")
  en5 = string.gsub(en5, "y", "🄨")
  en5 = string.gsub(en5, "z", "🄩")
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
  return en6
end

local function english_7(en7)
  if en7 == "" then return "" end
  en7 = string.gsub(en7, "a", "🄰")
  en7 = string.gsub(en7, "b", "🄱")
  en7 = string.gsub(en7, "c", "🄲")
  en7 = string.gsub(en7, "d", "🄳")
  en7 = string.gsub(en7, "e", "🄴")
  en7 = string.gsub(en7, "f", "🄵")
  en7 = string.gsub(en7, "g", "🄶")
  en7 = string.gsub(en7, "h", "🄷")
  en7 = string.gsub(en7, "i", "🄸")
  en7 = string.gsub(en7, "j", "🄹")
  en7 = string.gsub(en7, "k", "🄺")
  en7 = string.gsub(en7, "l", "🄻")
  en7 = string.gsub(en7, "m", "🄼")
  en7 = string.gsub(en7, "n", "🄽")
  en7 = string.gsub(en7, "o", "🄾")
  en7 = string.gsub(en7, "p", "🄿")
  en7 = string.gsub(en7, "q", "🅀")
  en7 = string.gsub(en7, "r", "🅁")
  en7 = string.gsub(en7, "s", "🅂")
  en7 = string.gsub(en7, "t", "🅃")
  en7 = string.gsub(en7, "u", "🅄")
  en7 = string.gsub(en7, "v", "🅅")
  en7 = string.gsub(en7, "w", "🅆")
  en7 = string.gsub(en7, "x", "🅇")
  en7 = string.gsub(en7, "y", "🅈")
  en7 = string.gsub(en7, "z", "🅉")
  return en7
end

local function english_8(en8)
  if en8 == "" then return "" end
  en8 = string.gsub(en8, "a", "🅐")
  en8 = string.gsub(en8, "b", "🅑")
  en8 = string.gsub(en8, "c", "🅒")
  en8 = string.gsub(en8, "d", "🅓")
  en8 = string.gsub(en8, "e", "🅔")
  en8 = string.gsub(en8, "f", "🅕")
  en8 = string.gsub(en8, "g", "🅖")
  en8 = string.gsub(en8, "h", "🅗")
  en8 = string.gsub(en8, "i", "🅘")
  en8 = string.gsub(en8, "j", "🅙")
  en8 = string.gsub(en8, "k", "🅚")
  en8 = string.gsub(en8, "l", "🅛")
  en8 = string.gsub(en8, "m", "🅜")
  en8 = string.gsub(en8, "n", "🅝")
  en8 = string.gsub(en8, "o", "🅞")
  en8 = string.gsub(en8, "p", "🅟")
  en8 = string.gsub(en8, "q", "🅠")
  en8 = string.gsub(en8, "r", "🅡")
  en8 = string.gsub(en8, "s", "🅢")
  en8 = string.gsub(en8, "t", "🅣")
  en8 = string.gsub(en8, "u", "🅤")
  en8 = string.gsub(en8, "v", "🅥")
  en8 = string.gsub(en8, "w", "🅦")
  en8 = string.gsub(en8, "x", "🅧")
  en8 = string.gsub(en8, "y", "🅨")
  en8 = string.gsub(en8, "z", "🅩")
  return en8
end

local function english_9(en9)
  if en9 == "" then return "" end
  en9 = string.gsub(en9, "a", "🅰")
  en9 = string.gsub(en9, "b", "🅱")
  en9 = string.gsub(en9, "c", "🅲")
  en9 = string.gsub(en9, "d", "🅳")
  en9 = string.gsub(en9, "e", "🅴")
  en9 = string.gsub(en9, "f", "🅵")
  en9 = string.gsub(en9, "g", "🅶")
  en9 = string.gsub(en9, "h", "🅷")
  en9 = string.gsub(en9, "i", "🅸")
  en9 = string.gsub(en9, "j", "🅹")
  en9 = string.gsub(en9, "k", "🅺")
  en9 = string.gsub(en9, "l", "🅻")
  en9 = string.gsub(en9, "m", "🅼")
  en9 = string.gsub(en9, "n", "🅽")
  en9 = string.gsub(en9, "o", "🅾")
  en9 = string.gsub(en9, "p", "🅿")
  en9 = string.gsub(en9, "q", "🆀")
  en9 = string.gsub(en9, "r", "🆁")
  en9 = string.gsub(en9, "s", "🆂")
  en9 = string.gsub(en9, "t", "🆃")
  en9 = string.gsub(en9, "u", "🆄")
  en9 = string.gsub(en9, "v", "🆅")
  en9 = string.gsub(en9, "w", "🆆")
  en9 = string.gsub(en9, "x", "🆇")
  en9 = string.gsub(en9, "y", "🆈")
  en9 = string.gsub(en9, "z", "🆉")
  return en9
end

local function english_f_u(en_f_u)
  if en_f_u == "" then return "" end
  en_f_u = string.gsub(en_f_u, "a", "Ａ")
  en_f_u = string.gsub(en_f_u, "b", "Ｂ")
  en_f_u = string.gsub(en_f_u, "c", "Ｃ")
  en_f_u = string.gsub(en_f_u, "d", "Ｄ")
  en_f_u = string.gsub(en_f_u, "e", "Ｅ")
  en_f_u = string.gsub(en_f_u, "f", "Ｆ")
  en_f_u = string.gsub(en_f_u, "g", "Ｇ")
  en_f_u = string.gsub(en_f_u, "h", "Ｈ")
  en_f_u = string.gsub(en_f_u, "i", "Ｉ")
  en_f_u = string.gsub(en_f_u, "j", "Ｊ")
  en_f_u = string.gsub(en_f_u, "k", "Ｋ")
  en_f_u = string.gsub(en_f_u, "l", "Ｌ")
  en_f_u = string.gsub(en_f_u, "m", "Ｍ")
  en_f_u = string.gsub(en_f_u, "n", "Ｎ")
  en_f_u = string.gsub(en_f_u, "o", "Ｏ")
  en_f_u = string.gsub(en_f_u, "p", "Ｐ")
  en_f_u = string.gsub(en_f_u, "q", "Ｑ")
  en_f_u = string.gsub(en_f_u, "r", "Ｒ")
  en_f_u = string.gsub(en_f_u, "s", "Ｓ")
  en_f_u = string.gsub(en_f_u, "t", "Ｔ")
  en_f_u = string.gsub(en_f_u, "u", "Ｕ")
  en_f_u = string.gsub(en_f_u, "v", "Ｖ")
  en_f_u = string.gsub(en_f_u, "w", "Ｗ")
  en_f_u = string.gsub(en_f_u, "x", "Ｘ")
  en_f_u = string.gsub(en_f_u, "y", "Ｙ")
  en_f_u = string.gsub(en_f_u, "z", "Ｚ")
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
  return en_f_l
end

local function english_s_u(en_s_u)
  if en_s_u == "" then return "" end
  en_s_u = string.gsub(en_s_u, "a", "ᴀ")
  en_s_u = string.gsub(en_s_u, "b", "ʙ")
  en_s_u = string.gsub(en_s_u, "c", "ᴄ")
  en_s_u = string.gsub(en_s_u, "d", "ᴅ")
  en_s_u = string.gsub(en_s_u, "e", "ᴇ")
  en_s_u = string.gsub(en_s_u, "f", "ꜰ")
  en_s_u = string.gsub(en_s_u, "g", "ɢ")
  en_s_u = string.gsub(en_s_u, "h", "ʜ")
  en_s_u = string.gsub(en_s_u, "i", "ɪ")
  en_s_u = string.gsub(en_s_u, "j", "ᴊ")
  en_s_u = string.gsub(en_s_u, "k", "ᴋ")
  en_s_u = string.gsub(en_s_u, "l", "ʟ")
  en_s_u = string.gsub(en_s_u, "m", "ᴍ")
  en_s_u = string.gsub(en_s_u, "n", "ɴ")
  en_s_u = string.gsub(en_s_u, "o", "ᴏ")
  en_s_u = string.gsub(en_s_u, "p", "ᴘ")
  en_s_u = string.gsub(en_s_u, "q", "ǫ")
  en_s_u = string.gsub(en_s_u, "r", "ʀ")
  en_s_u = string.gsub(en_s_u, "s", "s")
  en_s_u = string.gsub(en_s_u, "t", "ᴛ")
  en_s_u = string.gsub(en_s_u, "u", "ᴜ")
  en_s_u = string.gsub(en_s_u, "v", "ᴠ")
  en_s_u = string.gsub(en_s_u, "w", "ᴡ")
  en_s_u = string.gsub(en_s_u, "x", "x")
  en_s_u = string.gsub(en_s_u, "y", "ʏ")
  en_s_u = string.gsub(en_s_u, "z", "ᴢ")
  return en_s_u
end

local function english_1_2(en_1_2)
  if en_1_2 == "" then return "" end
  en_1_2 = english_1(string.sub(en_1_2,1,1)) .. english_2(string.sub(en_1_2,2,-1))
  return en_1_2
end

local function english_3_4(en_3_4)
  if en_3_4 == "" then return "" end
  en_3_4 = english_3(string.sub(en_3_4,1,1)) .. english_4(string.sub(en_3_4,2,-1))
  return en_3_4
end

local function english_5_6(en_5_6)
  if en_5_6 == "" then return "" end
  en_5_6 = english_5(string.sub(en_5_6,1,1)) .. english_6(string.sub(en_5_6,2,-1))
  return en_5_6
end

local function english_f_ul(en_ul)
  if en_ul == "" then return "" end
  en_ul = english_f_u(string.sub(en_ul,1,1)) .. english_f_l(string.sub(en_ul,2,-1))
  return en_ul
end

return {
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
        english_f_ul = english_f_ul
        }