--[[
number_translator: 將 `'/` + 阿拉伯數字 和 英文字母 各種轉譯
--]]

------------------------------------

local convert_format = require("filter_cand/convert_format")

------------------------------------

local function formatnumberthousands(n3)
  local r3 = string.sub(n3, -3, -1)  -- 從後向前取三位
  local n3 = string.sub(n3, 1, -4)  -- 剩下的數字
  -- 每次循環從後向前取三位，拼接到結果前面
  -- 直到剩下數字為空
  while string.len(n3) > 0 do
    r3 = string.sub(n3, -3, -1) .. "," .. r3
    n3 = string.sub(n3, 1, -4)
  end
  -- 返回結果
  return r3
end

------------------------------------

local function fullshape_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|０１２３４５６７８９|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function math1_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|𝟎𝟏𝟐𝟑𝟒𝟓𝟔𝟕𝟖𝟗|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function math2_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function circled1_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|⓪①②③④⑤⑥⑦⑧⑨|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function circled2_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|🄋➀➁➂➃➄➅➆➇➈|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function circled3_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|⓿❶❷❸❹❺❻❼❽❾|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function circled4_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|🄌➊➋➌➍➎➏➐➑➒|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function circled5_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|Ⓞ㊀㊁㊂㊃㊄㊅㊆㊇㊈|"  --小寫「o」：ⓞ
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function paren_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|⒪㈠㈡㈢㈣㈤㈥㈦㈧㈨|"  --大寫「o」：🄞
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function purech_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|〇一二三四五六七八九點|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function purebigch_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|零壹貳參肆伍陸柒捌玖點|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function military_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|洞么兩三四五六拐八勾點|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function little1_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|⁰¹²³⁴⁵⁶⁷⁸⁹⋅|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function little2_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|₀₁₂₃₄₅₆₇₈₉.|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function mss_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|𝟢𝟣𝟤𝟥𝟦𝟧𝟨𝟩𝟪𝟫.|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function mssb_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|𝟬𝟭𝟮𝟯𝟰𝟱𝟲𝟳𝟴𝟵.|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function mm_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|𝟶𝟷𝟸𝟹𝟺𝟻𝟼𝟽𝟾𝟿.|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function arabic_indic_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|٠١٢٣٤٥٦٧٨٩٫|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function extended_arabic_indic_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|۰۱۲۳۴۵۶۷۸۹٫|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function devanagari_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789|०१२३४५६७८९|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function braille_c_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|⠴⠂⠆⠒⠲⠢⠖⠶⠦⠔⠨|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

local function braille_u_number(t)
  if t == "" then return "" end
  local format1 = "xlit|0123456789.|⠚⠁⠃⠉⠙⠑⠋⠛⠓⠊⠲|"
  local proj = convert_format(format1)
  return proj:apply(t)
end

------------------------------------

local function keycap_number(dn)
  if dn == "" then return "" end
  --- 以下新的寫法
  local n2keycap = {["0"]="0️⃣", ["1"]="1️⃣", ["2"]="2️⃣", ["3"]="3️⃣", ["4"]="4️⃣", ["5"] ="5️⃣", ["6"]="6️⃣", ["7"]="7️⃣", ["8"]="8️⃣", ["9"]="9️⃣", ["."]="．"}
  local out_dn = ""
  for w in string.gmatch(dn, ".") do
    local w = n2keycap[w] or w
    out_dn = out_dn .. w
  end
  return out_dn
  -- --- 以下舊的寫法
  -- dn = string.gsub(dn, "0", "0️⃣")
  -- dn = string.gsub(dn, "1", "1️⃣")
  -- dn = string.gsub(dn, "2", "2️⃣")
  -- dn = string.gsub(dn, "3", "3️⃣")
  -- dn = string.gsub(dn, "4", "4️⃣")
  -- dn = string.gsub(dn, "5", "5️⃣")
  -- dn = string.gsub(dn, "6", "6️⃣")
  -- dn = string.gsub(dn, "7", "7️⃣")
  -- dn = string.gsub(dn, "8", "8️⃣")
  -- dn = string.gsub(dn, "9", "9️⃣")
  -- dn = string.gsub(dn, "%.", "．")
  -- return dn
end

------------------------------------

local function keycap_ns_number(dn)
  if dn == "" then return "" end
  --- 以下新的寫法
  local n2keycap_ns = {["0"]="0⃣", ["1"]="1⃣", ["2"]="2⃣", ["3"]="3⃣", ["4"]="4⃣", ["5"] ="5⃣", ["6"]="6⃣", ["7"]="7⃣", ["8"]="8⃣", ["9"]="9⃣", ["."]=".⃣"}
  local out_dn = ""
  for w in string.gmatch(dn, ".") do
    local w = n2keycap_ns[w] or w
    out_dn = out_dn .. w
  end
  return out_dn
  -- --- 以下舊的寫法
  -- dn = string.gsub(dn, "0", "0⃣")
  -- dn = string.gsub(dn, "1", "1⃣")
  -- dn = string.gsub(dn, "2", "2⃣")
  -- dn = string.gsub(dn, "3", "3⃣")
  -- dn = string.gsub(dn, "4", "4⃣")
  -- dn = string.gsub(dn, "5", "5⃣")
  -- dn = string.gsub(dn, "6", "6⃣")
  -- dn = string.gsub(dn, "7", "7⃣")
  -- dn = string.gsub(dn, "8", "8⃣")
  -- dn = string.gsub(dn, "9", "9⃣")
  -- dn = string.gsub(dn, "%.", ".⃣")
  -- return dn
end

------------------------------------

local function emoji_number(dn)
  if dn == "" then return "" end
  --- 以下新的寫法
  local n2emoji = {
    [1] = {["0"]="🛎️", ["1"]="🪑", ["2"]="👂🏻", ["3"]="☂️", ["4"]="💩", ["5"] ="💃🏻", ["6"]="🐂", ["7"]="😭", ["8"]="👨🏻", ["9"]="🥃", ["."]="⚡️", ["-"]="✂️"},
    [2] = {["0"]="🕳️", ["1"]="💊", ["2"]="👥", ["3"]="☘️", ["4"]="🍀", ["5"] ="⭐️", ["6"]="🐮", ["7"]="🚩", ["8"]="🎱", ["9"]="🍺", ["."]="🔋", ["-"]="⛔️"},
    [3] = {["0"]="🈳️", ["1"]="☝️", ["2"]="✌️", ["3"]="📐", ["4"]="☠️", ["5"] ="🖐️", ["6"]="⛸️", ["7"]="🐧", ["8"]="🇧🇷", ["9"]="🥂", ["."]="💡", ["-"]="☢️"},
    [4] = {["0"]="🥚", ["1"]="🥇", ["2"]="🎎", ["3"]="⛰️", ["4"]="👨‍👩‍👧‍👦", ["5"] ="🐯", ["6"]="✡️", ["7"]="🐔", ["8"]="🐙", ["9"]="🐶", ["."]="⚫", ["-"]="🚬"},
    [5] = {["0"]="🔔", ["1"]="💺", ["2"]="🐰", ["3"]="🔱", ["4"]="🐹", ["5"] ="🤭", ["6"]="🪀", ["7"]="🌈", ["8"]="🕷️", ["9"]="🦶🏻", ["."]="📍", ["-"]="📛"},
                  }
  local out_dn = ""
  for w in string.gmatch(dn, ".") do
    local ranNumber = math.random(1, 5)
    local w = n2emoji[ranNumber][w] or w  -- n2emoji[ranNumber] 如果為 nil 該條目會報錯！
    out_dn = out_dn .. w
  end
  return out_dn
  -- --- 以下舊的寫法
  -- local out_dn = ""
  -- for w in string.gmatch(dn, ".") do
  --   local ranNumber = math.random(1, 5)
  --   if ranNumber == 1 then
  --     w = string.gsub(w, "0", "🛎️")  -- 🕳️🈳️🥚🔔  -- 🔕🎐🍳🧊🤡🃏🕛
  --     w = string.gsub(w, "1", "🪑")  -- 💊☝️🥇💺  -- 🏆👆💯🕐
  --     w = string.gsub(w, "2", "👂🏻")  -- 👥✌️🎎🐰  -- 🥈🥢👫🐇🦢🪿🎧♊️♓️🕑
  --     w = string.gsub(w, "3", "☂️")  -- ☘️📐⛰️🔱  -- 🥉🏔️🗻🔺🔻🌂☔️⛱️🪭🧮🧄🌲🌳🌴🎄🕒
  --     w = string.gsub(w, "4", "💩")  -- 🍀☠️👨‍👩‍👧‍👦🐹  -- 💀🧟⚰️👻🐁🐀🐭🧹🆗🔢🫟🕓
  --     w = string.gsub(w, "5", "💃🏻")  -- ⭐️🖐️🐯🤭  -- 🙈🙉🙊🐸🐢🈚️🔥🐅🥁🚫🪘🕔
  --     w = string.gsub(w, "6", "🐂")  -- 🐮⛸️✡️🪀  -- 🔯🐄🐃🤙❄️🦬🛝🕕
  --     w = string.gsub(w, "7", "😭")  -- 🚩🐧🐔🌈  -- 🕎🎰🐓🐤🐥🐣🏁🎈🩼🕖
  --     w = string.gsub(w, "8", "👨🏻")  -- 🎱🇧🇷🐙🕷️  -- ☸️☯️🇵🇬🇵🇾🕸️🔈🔇🔉🔊📢📣♾️🕗
  --     w = string.gsub(w, "9", "🥃")  -- 🍺🥂🐶🦶🏻  -- 🍶🍻🍾🍷🍸🐕🦮🐕‍🦺🐩👣🥟✅☑️✔️🪝🕘
  --     w = string.gsub(w, "%.", "⚡️")  -- 🔋💡⚫📍  -- 🔘⏺️🖥️🏮🔦📌
  --     w = string.gsub(w, "-", "✂️")  -- ⛔️☢️🚬📛  -- ➖⚛️🩻
  --   elseif ranNumber == 2 then
  --     w = string.gsub(w, "0", "🕳️")
  --     w = string.gsub(w, "1", "💊")
  --     w = string.gsub(w, "2", "👥")
  --     w = string.gsub(w, "3", "☘️")
  --     w = string.gsub(w, "4", "🍀")
  --     w = string.gsub(w, "5", "⭐️")
  --     w = string.gsub(w, "6", "🐮")
  --     w = string.gsub(w, "7", "🚩")
  --     w = string.gsub(w, "8", "🎱")
  --     w = string.gsub(w, "9", "🍺")
  --     w = string.gsub(w, "%.", "🔋")
  --     w = string.gsub(w, "-", "⛔️")
  --   elseif ranNumber == 3 then
  --     w = string.gsub(w, "0", "🈳️")
  --     w = string.gsub(w, "1", "☝️")
  --     w = string.gsub(w, "2", "✌️")
  --     w = string.gsub(w, "3", "📐")
  --     w = string.gsub(w, "4", "☠️")
  --     w = string.gsub(w, "5", "🖐️")
  --     w = string.gsub(w, "6", "⛸️")
  --     w = string.gsub(w, "7", "🐧")
  --     w = string.gsub(w, "8", "🇧🇷")
  --     w = string.gsub(w, "9", "🥂")
  --     w = string.gsub(w, "%.", "💡")
  --     w = string.gsub(w, "-", "☢️")
  --   elseif ranNumber == 4 then
  --     w = string.gsub(w, "0", "🥚")
  --     w = string.gsub(w, "1", "🥇")
  --     w = string.gsub(w, "2", "🎎")
  --     w = string.gsub(w, "3", "⛰️")
  --     w = string.gsub(w, "4", "👨‍👩‍👧‍👦")
  --     w = string.gsub(w, "5", "🐯")
  --     w = string.gsub(w, "6", "✡️")
  --     w = string.gsub(w, "7", "🐔")
  --     w = string.gsub(w, "8", "🐙")
  --     w = string.gsub(w, "9", "🐶")
  --     w = string.gsub(w, "%.", "⚫")
  --     w = string.gsub(w, "-", "🚬")
  --   elseif ranNumber == 5 then
  --     w = string.gsub(w, "0", "🔔")
  --     w = string.gsub(w, "1", "💺")
  --     w = string.gsub(w, "2", "🐰")
  --     w = string.gsub(w, "3", "🔱")
  --     w = string.gsub(w, "4", "🐹")
  --     w = string.gsub(w, "5", "🤭")
  --     w = string.gsub(w, "6", "🪀")
  --     w = string.gsub(w, "7", "🌈")
  --     w = string.gsub(w, "8", "🕷️")
  --     w = string.gsub(w, "9", "🦶🏻")
  --     w = string.gsub(w, "%.", "📍")
  --     w = string.gsub(w, "-", "📛")
  --   end
  --   out_dn = out_dn .. w
  -- end
  -- return out_dn
end

------------------------------------
--- 以下舊的寫法（備份參考）
--[[
local function fullshape_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "０")
  dn = string.gsub(dn, "1", "１")
  dn = string.gsub(dn, "2", "２")
  dn = string.gsub(dn, "3", "３")
  dn = string.gsub(dn, "4", "４")
  dn = string.gsub(dn, "5", "５")
  dn = string.gsub(dn, "6", "６")
  dn = string.gsub(dn, "7", "７")
  dn = string.gsub(dn, "8", "８")
  dn = string.gsub(dn, "9", "９")
  return dn
end

local function math1_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "𝟎")
  dn = string.gsub(dn, "1", "𝟏")
  dn = string.gsub(dn, "2", "𝟐")
  dn = string.gsub(dn, "3", "𝟑")
  dn = string.gsub(dn, "4", "𝟒")
  dn = string.gsub(dn, "5", "𝟓")
  dn = string.gsub(dn, "6", "𝟔")
  dn = string.gsub(dn, "7", "𝟕")
  dn = string.gsub(dn, "8", "𝟖")
  dn = string.gsub(dn, "9", "𝟗")
  return dn
end

local function math2_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "𝟘")
  dn = string.gsub(dn, "1", "𝟙")
  dn = string.gsub(dn, "2", "𝟚")
  dn = string.gsub(dn, "3", "𝟛")
  dn = string.gsub(dn, "4", "𝟜")
  dn = string.gsub(dn, "5", "𝟝")
  dn = string.gsub(dn, "6", "𝟞")
  dn = string.gsub(dn, "7", "𝟟")
  dn = string.gsub(dn, "8", "𝟠")
  dn = string.gsub(dn, "9", "𝟡")
  return dn
end

local function circled1_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "⓪")
  dn = string.gsub(dn, "1", "①")
  dn = string.gsub(dn, "2", "②")
  dn = string.gsub(dn, "3", "③")
  dn = string.gsub(dn, "4", "④")
  dn = string.gsub(dn, "5", "⑤")
  dn = string.gsub(dn, "6", "⑥")
  dn = string.gsub(dn, "7", "⑦")
  dn = string.gsub(dn, "8", "⑧")
  dn = string.gsub(dn, "9", "⑨")
  return dn
end

local function circled2_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "🄋")
  dn = string.gsub(dn, "1", "➀")
  dn = string.gsub(dn, "2", "➁")
  dn = string.gsub(dn, "3", "➂")
  dn = string.gsub(dn, "4", "➃")
  dn = string.gsub(dn, "5", "➄")
  dn = string.gsub(dn, "6", "➅")
  dn = string.gsub(dn, "7", "➆")
  dn = string.gsub(dn, "8", "➇")
  dn = string.gsub(dn, "9", "➈")
  return dn
end

local function circled3_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "⓿")
  dn = string.gsub(dn, "1", "❶")
  dn = string.gsub(dn, "2", "❷")
  dn = string.gsub(dn, "3", "❸")
  dn = string.gsub(dn, "4", "❹")
  dn = string.gsub(dn, "5", "❺")
  dn = string.gsub(dn, "6", "❻")
  dn = string.gsub(dn, "7", "❼")
  dn = string.gsub(dn, "8", "❽")
  dn = string.gsub(dn, "9", "❾")
  return dn
end

local function circled4_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "🄌")
  dn = string.gsub(dn, "1", "➊")
  dn = string.gsub(dn, "2", "➋")
  dn = string.gsub(dn, "3", "➌")
  dn = string.gsub(dn, "4", "➍")
  dn = string.gsub(dn, "5", "➎")
  dn = string.gsub(dn, "6", "➏")
  dn = string.gsub(dn, "7", "➐")
  dn = string.gsub(dn, "8", "➑")
  dn = string.gsub(dn, "9", "➒")
  return dn
end

local function circled5_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "Ⓞ")
  dn = string.gsub(dn, "1", "㊀")
  dn = string.gsub(dn, "2", "㊁")
  dn = string.gsub(dn, "3", "㊂")
  dn = string.gsub(dn, "4", "㊃")
  dn = string.gsub(dn, "5", "㊄")
  dn = string.gsub(dn, "6", "㊅")
  dn = string.gsub(dn, "7", "㊆")
  dn = string.gsub(dn, "8", "㊇")
  dn = string.gsub(dn, "9", "㊈")
  return dn
end

local function purech_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "〇")
  dn = string.gsub(dn, "1", "一")
  dn = string.gsub(dn, "2", "二")
  dn = string.gsub(dn, "3", "三")
  dn = string.gsub(dn, "4", "四")
  dn = string.gsub(dn, "5", "五")
  dn = string.gsub(dn, "6", "六")
  dn = string.gsub(dn, "7", "七")
  dn = string.gsub(dn, "8", "八")
  dn = string.gsub(dn, "9", "九")
  return dn
end

local function military_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "洞")
  dn = string.gsub(dn, "1", "么")
  dn = string.gsub(dn, "2", "兩")
  dn = string.gsub(dn, "3", "三")
  dn = string.gsub(dn, "4", "四")
  dn = string.gsub(dn, "5", "五")
  dn = string.gsub(dn, "6", "六")
  dn = string.gsub(dn, "7", "拐")
  dn = string.gsub(dn, "8", "八")
  dn = string.gsub(dn, "9", "勾")
  dn = string.gsub(dn, "%.", "點")
  return dn
end

local function little1_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "⁰")
  dn = string.gsub(dn, "1", "¹")
  dn = string.gsub(dn, "2", "²")
  dn = string.gsub(dn, "3", "³")
  dn = string.gsub(dn, "4", "⁴")
  dn = string.gsub(dn, "5", "⁵")
  dn = string.gsub(dn, "6", "⁶")
  dn = string.gsub(dn, "7", "⁷")
  dn = string.gsub(dn, "8", "⁸")
  dn = string.gsub(dn, "9", "⁹")
  return dn
end

local function little2_number(dn)
  if dn == "" then return "" end
  dn = string.gsub(dn, "0", "₀")
  dn = string.gsub(dn, "1", "₁")
  dn = string.gsub(dn, "2", "₂")
  dn = string.gsub(dn, "3", "₃")
  dn = string.gsub(dn, "4", "₄")
  dn = string.gsub(dn, "5", "₅")
  dn = string.gsub(dn, "6", "₆")
  dn = string.gsub(dn, "7", "₇")
  dn = string.gsub(dn, "8", "₈")
  dn = string.gsub(dn, "9", "₉")
  return dn
end
--]]
------------------------------------

return {
        formatnumberthousands = formatnumberthousands,
        fullshape_number = fullshape_number,
        math1_number = math1_number,
        math2_number = math2_number,
        circled1_number = circled1_number,
        circled2_number = circled2_number,
        circled3_number = circled3_number,
        circled4_number = circled4_number,
        circled5_number = circled5_number,
        paren_number = paren_number,
        purech_number = purech_number,
        purebigch_number = purebigch_number,
        military_number = military_number,
        little1_number = little1_number,
        little2_number = little2_number,
        braille_c_number = braille_c_number,
        braille_u_number = braille_u_number,
        emoji_number = emoji_number,
        keycap_number = keycap_number,
        keycap_ns_number = keycap_ns_number,
        mss_number = mss_number,
        mssb_number = mssb_number,
        mm_number = mm_number,
        arabic_indic_number = arabic_indic_number,
        extended_arabic_indic_number = extended_arabic_indic_number,
        devanagari_number = devanagari_number,
        }