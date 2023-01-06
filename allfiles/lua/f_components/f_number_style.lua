--[[
number_translator: 將 `'/` + 阿拉伯數字 和 英文字母 各種轉譯
--]]

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


local function fullshape_number(fs)
  if fs == "" then return "" end
  fs = string.gsub(fs, "0", "０")
  fs = string.gsub(fs, "1", "１")
  fs = string.gsub(fs, "2", "２")
  fs = string.gsub(fs, "3", "３")
  fs = string.gsub(fs, "4", "４")
  fs = string.gsub(fs, "5", "５")
  fs = string.gsub(fs, "6", "６")
  fs = string.gsub(fs, "7", "７")
  fs = string.gsub(fs, "8", "８")
  fs = string.gsub(fs, "9", "９")
  return fs
end

local function math1_number(m1)
  if m1 == "" then return "" end
  m1 = string.gsub(m1, "0", "𝟎")
  m1 = string.gsub(m1, "1", "𝟏")
  m1 = string.gsub(m1, "2", "𝟐")
  m1 = string.gsub(m1, "3", "𝟑")
  m1 = string.gsub(m1, "4", "𝟒")
  m1 = string.gsub(m1, "5", "𝟓")
  m1 = string.gsub(m1, "6", "𝟔")
  m1 = string.gsub(m1, "7", "𝟕")
  m1 = string.gsub(m1, "8", "𝟖")
  m1 = string.gsub(m1, "9", "𝟗")
  return m1
end

local function math2_number(m2)
  if m2 == "" then return "" end
  m2 = string.gsub(m2, "0", "𝟘")
  m2 = string.gsub(m2, "1", "𝟙")
  m2 = string.gsub(m2, "2", "𝟚")
  m2 = string.gsub(m2, "3", "𝟛")
  m2 = string.gsub(m2, "4", "𝟜")
  m2 = string.gsub(m2, "5", "𝟝")
  m2 = string.gsub(m2, "6", "𝟞")
  m2 = string.gsub(m2, "7", "𝟟")
  m2 = string.gsub(m2, "8", "𝟠")
  m2 = string.gsub(m2, "9", "𝟡")
  return m2
end

local function circled1_number(c1)
  if c1 == "" then return "" end
  c1 = string.gsub(c1, "0", "⓪")
  c1 = string.gsub(c1, "1", "①")
  c1 = string.gsub(c1, "2", "②")
  c1 = string.gsub(c1, "3", "③")
  c1 = string.gsub(c1, "4", "④")
  c1 = string.gsub(c1, "5", "⑤")
  c1 = string.gsub(c1, "6", "⑥")
  c1 = string.gsub(c1, "7", "⑦")
  c1 = string.gsub(c1, "8", "⑧")
  c1 = string.gsub(c1, "9", "⑨")
  return c1
end

local function circled2_number(c2)
  if c2 == "" then return "" end
  c2 = string.gsub(c2, "0", "🄋")
  c2 = string.gsub(c2, "1", "➀")
  c2 = string.gsub(c2, "2", "➁")
  c2 = string.gsub(c2, "3", "➂")
  c2 = string.gsub(c2, "4", "➃")
  c2 = string.gsub(c2, "5", "➄")
  c2 = string.gsub(c2, "6", "➅")
  c2 = string.gsub(c2, "7", "➆")
  c2 = string.gsub(c2, "8", "➇")
  c2 = string.gsub(c2, "9", "➈")
  return c2
end

local function circled3_number(c3)
  if c3 == "" then return "" end
  c3 = string.gsub(c3, "0", "⓿")
  c3 = string.gsub(c3, "1", "❶")
  c3 = string.gsub(c3, "2", "❷")
  c3 = string.gsub(c3, "3", "❸")
  c3 = string.gsub(c3, "4", "❹")
  c3 = string.gsub(c3, "5", "❺")
  c3 = string.gsub(c3, "6", "❻")
  c3 = string.gsub(c3, "7", "❼")
  c3 = string.gsub(c3, "8", "❽")
  c3 = string.gsub(c3, "9", "❾")
  return c3
end

local function circled4_number(c4)
  if c4 == "" then return "" end
  c4 = string.gsub(c4, "0", "🄌")
  c4 = string.gsub(c4, "1", "➊")
  c4 = string.gsub(c4, "2", "➋")
  c4 = string.gsub(c4, "3", "➌")
  c4 = string.gsub(c4, "4", "➍")
  c4 = string.gsub(c4, "5", "➎")
  c4 = string.gsub(c4, "6", "➏")
  c4 = string.gsub(c4, "7", "➐")
  c4 = string.gsub(c4, "8", "➑")
  c4 = string.gsub(c4, "9", "➒")
  return c4
end

local function circled5_number(c5)
  if c5 == "" then return "" end
  c5 = string.gsub(c5, "0", "Ⓞ")
  c5 = string.gsub(c5, "1", "㊀")
  c5 = string.gsub(c5, "2", "㊁")
  c5 = string.gsub(c5, "3", "㊂")
  c5 = string.gsub(c5, "4", "㊃")
  c5 = string.gsub(c5, "5", "㊄")
  c5 = string.gsub(c5, "6", "㊅")
  c5 = string.gsub(c5, "7", "㊆")
  c5 = string.gsub(c5, "8", "㊇")
  c5 = string.gsub(c5, "9", "㊈")
  return c5
end

local function purech_number(ch)
  if ch == "" then return "" end
  ch = string.gsub(ch, "0", "〇")
  ch = string.gsub(ch, "1", "一")
  ch = string.gsub(ch, "2", "二")
  ch = string.gsub(ch, "3", "三")
  ch = string.gsub(ch, "4", "四")
  ch = string.gsub(ch, "5", "五")
  ch = string.gsub(ch, "6", "六")
  ch = string.gsub(ch, "7", "七")
  ch = string.gsub(ch, "8", "八")
  ch = string.gsub(ch, "9", "九")
  return ch
end

local function military_number(jn)
  if jn == "" then return "" end
  jn = string.gsub(jn, "0", "洞")
  jn = string.gsub(jn, "1", "么")
  jn = string.gsub(jn, "2", "兩")
  jn = string.gsub(jn, "3", "三")
  jn = string.gsub(jn, "4", "四")
  jn = string.gsub(jn, "5", "五")
  jn = string.gsub(jn, "6", "六")
  jn = string.gsub(jn, "7", "拐")
  jn = string.gsub(jn, "8", "八")
  jn = string.gsub(jn, "9", "勾")
  jn = string.gsub(jn, "%.", "點")
  return jn
end

local function little1_number(l1)
  if l1 == "" then return "" end
  l1 = string.gsub(l1, "0", "⁰")
  l1 = string.gsub(l1, "1", "¹")
  l1 = string.gsub(l1, "2", "²")
  l1 = string.gsub(l1, "3", "³")
  l1 = string.gsub(l1, "4", "⁴")
  l1 = string.gsub(l1, "5", "⁵")
  l1 = string.gsub(l1, "6", "⁶")
  l1 = string.gsub(l1, "7", "⁷")
  l1 = string.gsub(l1, "8", "⁸")
  l1 = string.gsub(l1, "9", "⁹")
  return l1
end

local function little2_number(l2)
  if l2 == "" then return "" end
  l2 = string.gsub(l2, "0", "₀")
  l2 = string.gsub(l2, "1", "₁")
  l2 = string.gsub(l2, "2", "₂")
  l2 = string.gsub(l2, "3", "₃")
  l2 = string.gsub(l2, "4", "₄")
  l2 = string.gsub(l2, "5", "₅")
  l2 = string.gsub(l2, "6", "₆")
  l2 = string.gsub(l2, "7", "₇")
  l2 = string.gsub(l2, "8", "₈")
  l2 = string.gsub(l2, "9", "₉")
  return l2
end

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
        purech_number = purech_number,
        military_number = military_number,
        little1_number = little1_number,
        little2_number = little2_number
        }