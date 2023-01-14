--[[
number_translator: 將 `'/` + 阿拉伯數字 和 英文字母 各種轉譯
--]]

------------------------------------

local function english_s(en)
  if en == "" then return "" end
  return string.gsub(en, "%./", " ")
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

local function english_1(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "𝔸")
  en = string.gsub(en, "B", "𝔹")
  en = string.gsub(en, "C", "ℂ")
  en = string.gsub(en, "D", "𝔻")
  en = string.gsub(en, "E", "𝔼")
  en = string.gsub(en, "F", "𝔽")
  en = string.gsub(en, "G", "𝔾")
  en = string.gsub(en, "H", "ℍ")
  en = string.gsub(en, "I", "𝕀")
  en = string.gsub(en, "J", "𝕁")
  en = string.gsub(en, "K", "𝕂")
  en = string.gsub(en, "L", "𝕃")
  en = string.gsub(en, "M", "𝕄")
  en = string.gsub(en, "N", "ℕ")
  en = string.gsub(en, "O", "𝕆")
  en = string.gsub(en, "P", "ℙ")
  en = string.gsub(en, "Q", "ℚ")
  en = string.gsub(en, "R", "ℝ")
  en = string.gsub(en, "S", "𝕊")
  en = string.gsub(en, "T", "𝕋")
  en = string.gsub(en, "U", "𝕌")
  en = string.gsub(en, "V", "𝕍")
  en = string.gsub(en, "W", "𝕎")
  en = string.gsub(en, "X", "𝕏")
  en = string.gsub(en, "Y", "𝕐")
  en = string.gsub(en, "Z", "ℤ")
  en = string.gsub(en, "%./", " ")
  return en
end

local function english_2(en)
  if en == "" then return "" end
  en = string.gsub(en, "a", "𝕒")
  en = string.gsub(en, "b", "𝕓")
  en = string.gsub(en, "c", "𝕔")
  en = string.gsub(en, "d", "𝕕")
  en = string.gsub(en, "e", "𝕖")
  en = string.gsub(en, "f", "𝕗")
  en = string.gsub(en, "g", "𝕘")
  en = string.gsub(en, "h", "𝕙")
  en = string.gsub(en, "i", "𝕚")
  en = string.gsub(en, "j", "𝕛")
  en = string.gsub(en, "k", "𝕜")
  en = string.gsub(en, "l", "𝕝")
  en = string.gsub(en, "m", "𝕞")
  en = string.gsub(en, "n", "𝕟")
  en = string.gsub(en, "o", "𝕠")
  en = string.gsub(en, "p", "𝕡")
  en = string.gsub(en, "q", "𝕢")
  en = string.gsub(en, "r", "𝕣")
  en = string.gsub(en, "s", "𝕤")
  en = string.gsub(en, "t", "𝕥")
  en = string.gsub(en, "u", "𝕦")
  en = string.gsub(en, "v", "𝕧")
  en = string.gsub(en, "w", "𝕨")
  en = string.gsub(en, "x", "𝕩")
  en = string.gsub(en, "y", "𝕪")
  en = string.gsub(en, "z", "𝕫")
  en = string.gsub(en, "%./", " ")
  return en
end

local function english_3(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "Ⓐ")
  en = string.gsub(en, "B", "Ⓑ")
  en = string.gsub(en, "C", "Ⓒ")
  en = string.gsub(en, "D", "Ⓓ")
  en = string.gsub(en, "E", "Ⓔ")
  en = string.gsub(en, "F", "Ⓕ")
  en = string.gsub(en, "G", "Ⓖ")
  en = string.gsub(en, "H", "Ⓗ")
  en = string.gsub(en, "I", "Ⓘ")
  en = string.gsub(en, "J", "Ⓙ")
  en = string.gsub(en, "K", "Ⓚ")
  en = string.gsub(en, "L", "Ⓛ")
  en = string.gsub(en, "M", "Ⓜ")
  en = string.gsub(en, "N", "Ⓝ")
  en = string.gsub(en, "O", "Ⓞ")
  en = string.gsub(en, "P", "Ⓟ")
  en = string.gsub(en, "Q", "Ⓠ")
  en = string.gsub(en, "R", "Ⓡ")
  en = string.gsub(en, "S", "Ⓢ")
  en = string.gsub(en, "T", "Ⓣ")
  en = string.gsub(en, "U", "Ⓤ")
  en = string.gsub(en, "V", "Ⓥ")
  en = string.gsub(en, "W", "Ⓦ")
  en = string.gsub(en, "X", "Ⓧ")
  en = string.gsub(en, "Y", "Ⓨ")
  en = string.gsub(en, "Z", "Ⓩ")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  return en
end

local function english_4(en)
  if en == "" then return "" end
  en = string.gsub(en, "a", "ⓐ")
  en = string.gsub(en, "b", "ⓑ")
  en = string.gsub(en, "c", "ⓒ")
  en = string.gsub(en, "d", "ⓓ")
  en = string.gsub(en, "e", "ⓔ")
  en = string.gsub(en, "f", "ⓕ")
  en = string.gsub(en, "g", "ⓖ")
  en = string.gsub(en, "h", "ⓗ")
  en = string.gsub(en, "i", "ⓘ")
  en = string.gsub(en, "j", "ⓙ")
  en = string.gsub(en, "k", "ⓚ")
  en = string.gsub(en, "l", "ⓛ")
  en = string.gsub(en, "m", "ⓜ")
  en = string.gsub(en, "n", "ⓝ")
  en = string.gsub(en, "o", "ⓞ")
  en = string.gsub(en, "p", "ⓟ")
  en = string.gsub(en, "q", "ⓠ")
  en = string.gsub(en, "r", "ⓡ")
  en = string.gsub(en, "s", "ⓢ")
  en = string.gsub(en, "t", "ⓣ")
  en = string.gsub(en, "u", "ⓤ")
  en = string.gsub(en, "v", "ⓥ")
  en = string.gsub(en, "w", "ⓦ")
  en = string.gsub(en, "x", "ⓧ")
  en = string.gsub(en, "y", "ⓨ")
  en = string.gsub(en, "z", "ⓩ")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  return en
end

local function english_5(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "🄐")
  en = string.gsub(en, "B", "🄑")
  en = string.gsub(en, "C", "🄒")
  en = string.gsub(en, "D", "🄓")
  en = string.gsub(en, "E", "🄔")
  en = string.gsub(en, "F", "🄕")
  en = string.gsub(en, "G", "🄖")
  en = string.gsub(en, "H", "🄗")
  en = string.gsub(en, "I", "🄘")
  en = string.gsub(en, "J", "🄙")
  en = string.gsub(en, "K", "🄚")
  en = string.gsub(en, "L", "🄛")
  en = string.gsub(en, "M", "🄜")
  en = string.gsub(en, "N", "🄝")
  en = string.gsub(en, "O", "🄞")
  en = string.gsub(en, "P", "🄟")
  en = string.gsub(en, "Q", "🄠")
  en = string.gsub(en, "R", "🄡")
  en = string.gsub(en, "S", "🄢")
  en = string.gsub(en, "T", "🄣")
  en = string.gsub(en, "U", "🄤")
  en = string.gsub(en, "V", "🄥")
  en = string.gsub(en, "W", "🄦")
  en = string.gsub(en, "X", "🄧")
  en = string.gsub(en, "Y", "🄨")
  en = string.gsub(en, "Z", "🄩")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  return en
end

local function english_6(en)
  if en == "" then return "" end
  en = string.gsub(en, "a", "⒜")
  en = string.gsub(en, "b", "⒝")
  en = string.gsub(en, "c", "⒞")
  en = string.gsub(en, "d", "⒟")
  en = string.gsub(en, "e", "⒠")
  en = string.gsub(en, "f", "⒡")
  en = string.gsub(en, "g", "⒢")
  en = string.gsub(en, "h", "⒣")
  en = string.gsub(en, "i", "⒤")
  en = string.gsub(en, "j", "⒥")
  en = string.gsub(en, "k", "⒦")
  en = string.gsub(en, "l", "⒧")
  en = string.gsub(en, "m", "⒨")
  en = string.gsub(en, "n", "⒩")
  en = string.gsub(en, "o", "⒪")
  en = string.gsub(en, "p", "⒫")
  en = string.gsub(en, "q", "⒬")
  en = string.gsub(en, "r", "⒭")
  en = string.gsub(en, "s", "⒮")
  en = string.gsub(en, "t", "⒯")
  en = string.gsub(en, "u", "⒰")
  en = string.gsub(en, "v", "⒱")
  en = string.gsub(en, "w", "⒲")
  en = string.gsub(en, "x", "⒳")
  en = string.gsub(en, "y", "⒴")
  en = string.gsub(en, "z", "⒵")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  return en
end

local function english_7(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "🄰")
  en = string.gsub(en, "B", "🄱")
  en = string.gsub(en, "C", "🄲")
  en = string.gsub(en, "D", "🄳")
  en = string.gsub(en, "E", "🄴")
  en = string.gsub(en, "F", "🄵")
  en = string.gsub(en, "G", "🄶")
  en = string.gsub(en, "H", "🄷")
  en = string.gsub(en, "I", "🄸")
  en = string.gsub(en, "J", "🄹")
  en = string.gsub(en, "K", "🄺")
  en = string.gsub(en, "L", "🄻")
  en = string.gsub(en, "M", "🄼")
  en = string.gsub(en, "N", "🄽")
  en = string.gsub(en, "O", "🄾")
  en = string.gsub(en, "P", "🄿")
  en = string.gsub(en, "Q", "🅀")
  en = string.gsub(en, "R", "🅁")
  en = string.gsub(en, "S", "🅂")
  en = string.gsub(en, "T", "🅃")
  en = string.gsub(en, "U", "🅄")
  en = string.gsub(en, "V", "🅅")
  en = string.gsub(en, "W", "🅆")
  en = string.gsub(en, "X", "🅇")
  en = string.gsub(en, "Y", "🅈")
  en = string.gsub(en, "Z", "🅉")
  en = string.gsub(en, "%./", "　")
  return en
end

local function english_8(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "🅐")
  en = string.gsub(en, "B", "🅑")
  en = string.gsub(en, "C", "🅒")
  en = string.gsub(en, "D", "🅓")
  en = string.gsub(en, "E", "🅔")
  en = string.gsub(en, "F", "🅕")
  en = string.gsub(en, "G", "🅖")
  en = string.gsub(en, "H", "🅗")
  en = string.gsub(en, "I", "🅘")
  en = string.gsub(en, "J", "🅙")
  en = string.gsub(en, "K", "🅚")
  en = string.gsub(en, "L", "🅛")
  en = string.gsub(en, "M", "🅜")
  en = string.gsub(en, "N", "🅝")
  en = string.gsub(en, "O", "🅞")
  en = string.gsub(en, "P", "🅟")
  en = string.gsub(en, "Q", "🅠")
  en = string.gsub(en, "R", "🅡")
  en = string.gsub(en, "S", "🅢")
  en = string.gsub(en, "T", "🅣")
  en = string.gsub(en, "U", "🅤")
  en = string.gsub(en, "V", "🅥")
  en = string.gsub(en, "W", "🅦")
  en = string.gsub(en, "X", "🅧")
  en = string.gsub(en, "Y", "🅨")
  en = string.gsub(en, "Z", "🅩")
  en = string.gsub(en, "%./", "　")
  return en
end

local function english_9(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "🅰")
  en = string.gsub(en, "B", "🅱")
  en = string.gsub(en, "C", "🅲")
  en = string.gsub(en, "D", "🅳")
  en = string.gsub(en, "E", "🅴")
  en = string.gsub(en, "F", "🅵")
  en = string.gsub(en, "G", "🅶")
  en = string.gsub(en, "H", "🅷")
  en = string.gsub(en, "I", "🅸")
  en = string.gsub(en, "J", "🅹")
  en = string.gsub(en, "K", "🅺")
  en = string.gsub(en, "L", "🅻")
  en = string.gsub(en, "M", "🅼")
  en = string.gsub(en, "N", "🅽")
  en = string.gsub(en, "O", "🅾")
  en = string.gsub(en, "P", "🅿")
  en = string.gsub(en, "Q", "🆀")
  en = string.gsub(en, "R", "🆁")
  en = string.gsub(en, "S", "🆂")
  en = string.gsub(en, "T", "🆃")
  en = string.gsub(en, "U", "🆄")
  en = string.gsub(en, "V", "🆅")
  en = string.gsub(en, "W", "🆆")
  en = string.gsub(en, "X", "🆇")
  en = string.gsub(en, "Y", "🆈")
  en = string.gsub(en, "Z", "🆉")
  en = string.gsub(en, "%./", "　")
  return en
end

local function english_f_u(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "Ａ")
  en = string.gsub(en, "B", "Ｂ")
  en = string.gsub(en, "C", "Ｃ")
  en = string.gsub(en, "D", "Ｄ")
  en = string.gsub(en, "E", "Ｅ")
  en = string.gsub(en, "F", "Ｆ")
  en = string.gsub(en, "G", "Ｇ")
  en = string.gsub(en, "H", "Ｈ")
  en = string.gsub(en, "I", "Ｉ")
  en = string.gsub(en, "J", "Ｊ")
  en = string.gsub(en, "K", "Ｋ")
  en = string.gsub(en, "L", "Ｌ")
  en = string.gsub(en, "M", "Ｍ")
  en = string.gsub(en, "N", "Ｎ")
  en = string.gsub(en, "O", "Ｏ")
  en = string.gsub(en, "P", "Ｐ")
  en = string.gsub(en, "Q", "Ｑ")
  en = string.gsub(en, "R", "Ｒ")
  en = string.gsub(en, "S", "Ｓ")
  en = string.gsub(en, "T", "Ｔ")
  en = string.gsub(en, "U", "Ｕ")
  en = string.gsub(en, "V", "Ｖ")
  en = string.gsub(en, "W", "Ｗ")
  en = string.gsub(en, "X", "Ｘ")
  en = string.gsub(en, "Y", "Ｙ")
  en = string.gsub(en, "Z", "Ｚ")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  en = string.gsub(en, ",", "，")
  en = string.gsub(en, "%.", "．")
  en = string.gsub(en, "-", "－")
  en = string.gsub(en, "/", "／")
  en = string.gsub(en, "'", "＇")
  return en
end

local function english_f_l(en)
  if en == "" then return "" end
  en = string.gsub(en, "a", "ａ")
  en = string.gsub(en, "b", "ｂ")
  en = string.gsub(en, "c", "ｃ")
  en = string.gsub(en, "d", "ｄ")
  en = string.gsub(en, "e", "ｅ")
  en = string.gsub(en, "f", "ｆ")
  en = string.gsub(en, "g", "ｇ")
  en = string.gsub(en, "h", "ｈ")
  en = string.gsub(en, "i", "ｉ")
  en = string.gsub(en, "j", "ｊ")
  en = string.gsub(en, "k", "ｋ")
  en = string.gsub(en, "l", "ｌ")
  en = string.gsub(en, "m", "ｍ")
  en = string.gsub(en, "n", "ｎ")
  en = string.gsub(en, "o", "ｏ")
  en = string.gsub(en, "p", "ｐ")
  en = string.gsub(en, "q", "ｑ")
  en = string.gsub(en, "r", "ｒ")
  en = string.gsub(en, "s", "ｓ")
  en = string.gsub(en, "t", "ｔ")
  en = string.gsub(en, "u", "ｕ")
  en = string.gsub(en, "v", "ｖ")
  en = string.gsub(en, "w", "ｗ")
  en = string.gsub(en, "x", "ｘ")
  en = string.gsub(en, "y", "ｙ")
  en = string.gsub(en, "z", "ｚ")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  en = string.gsub(en, ",", "，")
  en = string.gsub(en, "%.", "．")
  en = string.gsub(en, "-", "－")
  en = string.gsub(en, "/", "／")
  en = string.gsub(en, "'", "＇")
  return en
end

local function english_s_u(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "ᴀ")
  en = string.gsub(en, "B", "ʙ")
  en = string.gsub(en, "C", "ᴄ")
  en = string.gsub(en, "D", "ᴅ")
  en = string.gsub(en, "E", "ᴇ")
  en = string.gsub(en, "F", "ꜰ")
  en = string.gsub(en, "G", "ɢ")
  en = string.gsub(en, "H", "ʜ")
  en = string.gsub(en, "I", "ɪ")
  en = string.gsub(en, "J", "ᴊ")
  en = string.gsub(en, "K", "ᴋ")
  en = string.gsub(en, "L", "ʟ")
  en = string.gsub(en, "M", "ᴍ")
  en = string.gsub(en, "N", "ɴ")
  en = string.gsub(en, "O", "ᴏ")
  en = string.gsub(en, "P", "ᴘ")
  en = string.gsub(en, "Q", "ǫ")
  en = string.gsub(en, "R", "ʀ")
  en = string.gsub(en, "S", "s")
  en = string.gsub(en, "T", "ᴛ")
  en = string.gsub(en, "U", "ᴜ")
  en = string.gsub(en, "V", "ᴠ")
  en = string.gsub(en, "W", "ᴡ")
  en = string.gsub(en, "X", "x")
  en = string.gsub(en, "Y", "ʏ")
  en = string.gsub(en, "Z", "ᴢ")
  en = string.gsub(en, "%./", " ")
  return en
end

local function english_1_2(en)
  if en == "" then return "" end
  -- en = english_1(string.sub(en,1,1)) .. english_2(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_1(en)
  en = english_2(en)
  return en
end

local function english_3_4(en)
  if en == "" then return "" end
  -- en = english_3(string.sub(en,1,1)) .. english_4(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_3(en)
  en = english_4(en)
  return en
end

local function english_5_6(en)
  if en == "" then return "" end
  -- en = english_5(string.sub(en,1,1)) .. english_6(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_5(en)
  en = english_6(en)
  return en
end

local function english_f_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_f_u(en)
  en = english_f_l(en)
  return en
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