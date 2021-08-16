-- Usage:
--  engine:
--    ...
--    translators:
--      ...
--      - lua_translator@lua_function3
--      - lua_translator@lua_function4
--      ...
--    filters:
--      ...
--      - lua_filter@lua_function1
--      - lua_filter@lua_function2
--    可掛接作用功能:
--      ...
--      - lua_translator@t_translator             -- 「`」開頭打出時間日期
--      - lua_translator@t2_translator            -- 「'/」開頭打出時間日期
--      - lua_translator@date_translator          -- 「``」開頭打出時間日期
--      - lua_translator@mytranslator             -- （有缺函數，參考勿用，暫關閉）
--      - lua_translator@instruction_dbpmf        -- 選項中顯示洋蔥雙拼各種說明
--      - lua_translator@instruction_grave_bpmf   -- 選項中顯示洋蔥注音各種說明
--      - lua_translator@instruction_ocm          -- 選項中顯示洋蔥蝦米各種說明
--      - lua_translator@email_url_translator     -- 輸入email、網址
--      - lua_translator@email_urlw_translator    -- 輸入email、網址（多了www.）
--
--
--      《 ＊ 以下「濾鏡」注意在 filters 中的順序，關係到作用效果 》
--      - lua_filter@charset_filter               -- 遮屏含 CJK 擴展漢字的候選項
--      - lua_filter@charset_filter_plus          --（bopomo_onion_double） 遮屏含 CJK 擴展漢字的候選項，開關（only_cjk_filter）
--      - lua_filter@charset_comment_filter       -- 候選項註釋其所屬字符集，如：CJK、ExtA
--      - lua_filter@single_char_filter           -- 候選項重排序，使單字優先
--      - lua_filter@reverse_lookup_filter        -- 依地球拼音為候選項加上帶調拼音的註釋
--      - lua_filter@myfilter                     -- 把 charset_comment_filter 和 reverse_lookup_filter 註釋串在一起，如：CJK(hǎo)
--
--      - lua_filter@charset_filter2              --（ocm_onionmix） 遮屏選含「᰼᰼」候選項
--      - lua_filter@comment_filter_plus          --（Mount_ocm） 遮屏提示碼，開關（simplify_comment）（遇到「'/」不遮屏）。
--      - lua_filter@symbols_mark_filter          --（關，但 mix_cf2_cfp_smf_filter 有用到某元件，部分開啟） 候選項註釋符號、音標等屬性之提示碼(comment)（用 opencc 可實現，但無法合併其他提示碼(comment)，改用 Lua 來實現）
--      - lua_filter@missing_mark_filter          --（關） 補上標點符號因直上和 opencc 衝突沒附註之選項
--      - lua_filter@array30_comment_filter       --（關） 遮屏提示碼，開關（simplify_comment）（遇到「`」不遮屏）
--      - lua_filter@array30_nil_filter           --（關） 行列30空碼'⎔'轉成不輸出任何符號，符合原生
--      - lua_filter@array30_spaceup_filter       --（onion-array30） 行列30開關一二碼按空格後，是否直上或可能有選單。
--
--      - ＊合併兩個以上函數：
--      - lua_filter@mix30_nil_comment_filter     --（onion-array30） 合併 array30_nil_filter 和 array30_comment_filter，兩個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_miss_filter          --（bopomo_onionplus 和 bo_mixin 全系列） 合併 charset_filter2 和 missing_mark_filter，兩個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_cfp_filter           --（dif1） 合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
--      - lua_filter@mix_cf2_cfp_smf_filter       --（ocm_mixin） 合併 charset_filter2 和 comment_filter_plus 和 symbols_mark_filter，三個 lua filter 太耗效能。
--
--
--      《 ＊ 以下「處理」注意在 processors 中的順序，基本放在最前面 》
--      - lua_processor@endspace                  --（hangeul 和 hangeul2set） 韓語（非英語等）空格鍵後添加" "
--      - lua_processor@ascii_punct_change        --（bopomo_onionplus_2和3） 注音非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
--      - lua_processor@array30up                 --（關） 行列30三四碼字按空格直接上屏
--      - lua_processor@array30up_zy              --（關） 行列30注音反查 Return 和 space 上屏修正
--
--      = 以下針對「編碼有用到空白鍵」方案，如：注音一聲，去除空白上屏產生莫名之空格 =
--      - lua_processor@s2r_ss                    --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只有開頭 ^'/ 才作用，比下條目更精簡，少了 is_composing 限定）
--      - lua_processor@s2r_s                     --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只有開頭 ^'/ 才作用）
--      - lua_processor@s2r                       --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin(1,2,4)和 plus 用）
--      - lua_processor@s2r_e_u                   --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（只針對 email 和 url ）
--      - lua_processor@s2r_most                  --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin(1,2,4)和 plus 用，精簡寫法）
--      - lua_processor@s2r_mixin3                --（關） 注音掛接 t2_translator 空白上屏產生莫名空格去除（ mixin3 (特殊正則)專用）
--
--      - ＊合併兩個以上函數：
--      - lua_processor@array30up_mix             --（onion-array30） 合併 array30up 和 array30up_zy，增進效能。
--      - lua_processor@mix_apc_s2rm              --（bo_mixin 1、2、4；bopomo_onionplus） 注音掛接，合併 ascii_punct_change 和 s2r_most，增進效能。
--      - lua_processor@mix_apc_s2rm_3            --（bo_mixin3） 注音掛接，合併 ascii_punct_change 和 s2r_mixin3，增進效能。
--      - lua_processor@mix_apc_pluss             --（bopomo_onionplus_space） 以原 ascii_punct_change 增加功能，使初始空白可以直接上屏
--      ...




--[[
--------------------------------------------
！！！！以下為 filter 掛接！！！！
--------------------------------------------
--]]




--- @@ charset filter
--[[
charset_filter: 濾除含 CJK 擴展漢字的候選項
charset_comment_filter: 為候選項加上其所屬字符集的註釋
本例說明了 filter 最基本的寫法。
請見 `charset_filter` 和 `charset_comment_filter` 上方註釋。
--]]

-- 幫助函數（可跳過）
local charset = {
  ["CJK"] = { first = 0x4E00, last = 0x9FFF },
  ["ExtA"] = { first = 0x3400, last = 0x4DBF },
  ["ExtB"] = { first = 0x20000, last = 0x2A6DF },
  ["ExtC"] = { first = 0x2A700, last = 0x2B73F },
  ["ExtD"] = { first = 0x2B740, last = 0x2B81F },
  ["ExtE"] = { first = 0x2B820, last = 0x2CEAF },
  ["ExtF"] = { first = 0x2CEB0, last = 0x2EBEF },
  ["Compat"] = { first = 0x2F800, last = 0x2FA1F } }

local function exists(single_filter, text)
  for i in utf8.codes(text) do
    local c = utf8.codepoint(text, i)
    if (not single_filter(c)) then
      return false
    end
  end
  return true
end

local function is_charset(s)
  return function (c)
    return c >= charset[s].first and c <= charset[s].last
  end
end

local function is_cjk_ext(c)
  return is_charset("ExtA")(c) or is_charset("ExtB")(c) or
    is_charset("ExtC")(c) or is_charset("ExtD")(c) or
    is_charset("ExtE")(c) or is_charset("ExtF")(c) or
    is_charset("Compat")(c)
end




--- @@ charset_filter
--[[
filter 的功能是對 translator 翻譯而來的候選項做修飾，
如去除不想要的候選、為候選加註釋、候選項重排序等。
欲定義的 filter 包含兩個輸入參數：
 - input: 候選項列表
 - env: 可選參數，表示 filter 所處的環境（本例沒有體現）
filter 的輸出與 translator 相同，也是若干候選項，也要求您使用 `yield` 產生候選項。
如下例所示，charset_filter 將濾除含 CJK 擴展漢字的候選項：
--]]
function charset_filter(input)
  -- 使用 `iter()` 遍歷所有輸入候選項
  for cand in input:iter() do
    -- 如果當前候選項 `cand` 不含 CJK 擴展漢字
    if (not exists(is_cjk_ext, cand.text)) then
      -- 結果中仍保留此候選
      yield(cand)
    end
    --[[ 上述條件不滿足時，當前的候選 `cand` 沒有被 yield。
      因此過濾結果中將不含有該候選。
    --]]
  end
end




--- @@ charset_filter_plus
--[[
（bopomo_onion_double）
同上，將濾除含 CJK 擴展漢字的候選項
增加開關設置
--]]
function charset_filter_plus(input, env)
  -- 使用 `iter()` 遍歷所有輸入候選項
  local c_f_p_s = env.engine.context:get_option("only_cjk_filter")
  if (c_f_p_s) then
    for cand in input:iter() do
      -- 如果當前候選項 `cand` 不含 CJK 擴展漢字
      if (not exists(is_cjk_ext, cand.text)) then
        -- 結果中仍保留此候選
        yield(cand)
      end
      --[[ 上述條件不滿足時，當前的候選 `cand` 沒有被 yield。
        因此過濾結果中將不含有該候選。
      --]]
    end
  else
    for cand in input:iter() do
      yield(cand)
    end
  end
end




--- @@ charset comment filter
--[[
如下例所示，charset_comment_filter 為候選項加上其所屬字符集的註釋：
--]]
function charset_comment_filter(input)
  for cand in input:iter() do
    for s, r in pairs(charset) do
      if (exists(is_charset(s), cand.text)) then
        cand:get_genuine().comment = cand.comment .. " " .. s
        break
      end
    end
    yield(cand)
  end
end

-- 本例中定義了兩個 filter，故使用一個表將兩者導出
-- return { filter = charset_filter,
--   comment_filter = charset_comment_filter }




--- @@ charset_filter2
--[[
（ocm_onionmix）
把 opencc 轉換成「᰼」(或某個符號)，再用 lua 功能去除「᰼」
--]]

-- charset2 = {
--  ["Deletesymbol"] = { first = 0x1C3C } }

-- function exists2(single_filter2, text)
--   for i in utf8.codes(text) do
--    local c = utf8.codepoint(text, i)
--    if (not single_filter2(c)) then
--   return false
--    end
--   end
--   return true
-- end

-- function is_charset2(s)
--  return function (c)
--     return c == charset2[s].first
--  end
-- end

-- function is_symbol_ext(c)
--  return is_charset2("Deletesymbol")(c)
-- end

-- function charset_filter2(input)
--  for cand in input:iter() do
--     if (not exists2(is_symbol_ext, cand.text))
--     then
--     yield(cand)
--     end
--  end
-- end

function charset_filter2(input, env)
  local c_f2_s = env.engine.context:get_option("zh_tw")
  if (c_f2_s) then
    for cand in input:iter() do
      if (not string.find(cand.text, '᰼᰼' )) then
      -- if (not string.find(cand.text, '.*᰼᰼.*' )) then
        yield(cand)
      end
    end
  else
    for cand in input:iter() do
      yield(cand)
    end
    -- if (input == nil) then
    --   cand = nil
    -- end
  end
  -- return nil
end




--- @@ single_char_filter
--[[
single_char_filter: 候選項重排序，使單字優先
--]]
function single_char_filter(input)
  local l = {}
  for cand in input:iter() do
    if (utf8.len(cand.text) == 1) then
      yield(cand)
    else
      table.insert(l, cand)
    end
  end
  for i, cand in ipairs(l) do
    yield(cand)
  end
end




--- @@ reverse_lookup_filter
--[[
依地球拼音為候選項加上帶調拼音的註釋
--]]
local pydb = ReverseDb("build/terra_pinyin.reverse.bin")

local function xform_py(inp)
  if inp == "" then return "" end
  inp = string.gsub(inp, "([aeiou])(ng?)([1234])", "%1%3%2")
  inp = string.gsub(inp, "([aeiou])(r)([1234])", "%1%3%2")
  inp = string.gsub(inp, "([aeo])([iuo])([1234])", "%1%3%2")
  inp = string.gsub(inp, "a1", "ā")
  inp = string.gsub(inp, "a2", "á")
  inp = string.gsub(inp, "a3", "ǎ")
  inp = string.gsub(inp, "a4", "à")
  inp = string.gsub(inp, "e1", "ē")
  inp = string.gsub(inp, "e2", "é")
  inp = string.gsub(inp, "e3", "ě")
  inp = string.gsub(inp, "e4", "è")
  inp = string.gsub(inp, "o1", "ō")
  inp = string.gsub(inp, "o2", "ó")
  inp = string.gsub(inp, "o3", "ǒ")
  inp = string.gsub(inp, "o4", "ò")
  inp = string.gsub(inp, "i1", "ī")
  inp = string.gsub(inp, "i2", "í")
  inp = string.gsub(inp, "i3", "ǐ")
  inp = string.gsub(inp, "i4", "ì")
  inp = string.gsub(inp, "u1", "ū")
  inp = string.gsub(inp, "u2", "ú")
  inp = string.gsub(inp, "u3", "ǔ")
  inp = string.gsub(inp, "u4", "ù")
  inp = string.gsub(inp, "v1", "ǖ")
  inp = string.gsub(inp, "v2", "ǘ")
  inp = string.gsub(inp, "v3", "ǚ")
  inp = string.gsub(inp, "v4", "ǜ")
  inp = string.gsub(inp, "([nljqxy])v", "%1ü")
  inp = string.gsub(inp, "eh[0-5]?", "ê")
  return "(" .. inp .. ")"
end

function reverse_lookup_filter(input)
  for cand in input:iter() do
    cand:get_genuine().comment = cand.comment .. " " .. xform_py(pydb:lookup(cand.text))
    yield(cand)
  end
end




--- @@ myfilter
--[[
--- composition
把 charset_comment_filter 和 reverse_lookup_filter 註釋串在一起，如：CJK(hǎo)
--]]
function myfilter(input)
  local input2 = Translation(charset_comment_filter, input)
  reverse_lookup_filter(input2)
end




--- @@ symbols_mark_filter
--[[
（關，但 mix_cf2_cfp_smf_filter 有用到某元件，部分開啟）
候選項註釋符號、音標等屬性之提示碼(comment)（用 opencc 可實現，但無法合併其他提示碼(comment)，改用 Lua 來實現）
--]]
local ocmdb = ReverseDb("build/symbols-mark.reverse.bin")

local function xform_mark(inp)
  if inp == "" then return "" end
    inp = string.gsub(inp, "^(〔.+〕)(〔.+〕)$", "%1")
    inp = string.gsub(inp, "，", ", ")
  return inp
end

-- function symbols_mark_filter(input, env)
--   local b_k = env.engine.context:get_option("back_mark")
--   if (b_k) then
--     for cand in input:iter() do
--       cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
--       -- cand:get_genuine().comment = cand.comment .. ocmdb:lookup(cand.text)
--       yield(cand)
--     end
--   else
--     for cand in input:iter() do
--       yield(cand)
--     end
--   end
-- end




--- @@ comment_filter_plus
--[[
（Mount_ocm）
去除後面編碼註釋
--]]
-- local function xform_c(cf)
--   if cf == "" then return "" end
--   cf = string.gsub(cf, "[ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ%s]+$", "zk")
--   return cf
-- end

function comment_filter_plus(input, env)
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  local find_prefix = env.engine.context.input
  -- local pun1 = string.find(find_prefix, "^'/" )
  -- local pun2 = string.find(find_prefix, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.find(find_prefix, "[]\\[]+$" )
  -- local pun4 = string.find(find_prefix, "^[;|][;]?$" )
  if (not s_c_f_p_s) then
  -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
  -- 使用 `iter()` 遍歷所有輸入候選項
    for cand in input:iter() do
      yield(cand)
    end
  else
    for cand in input:iter() do
    --   -- comment123 = cand.comment .. cand.text .. "open"
    --   -- comment123 = cand.comment
    --   -- comment123 = "kkk" .. comment123
    --   -- cand:get_genuine().comment = comment123 .." "
      cand:get_genuine().comment = ""
      yield(cand)
    end
  end
end


-- function array30_comment_filter(input, env)
--   local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
--   local find_prefix = env.engine.context.input
--   if (not s_c_f_p_s) or (string.find(find_prefix, "`" )) then
--   -- 使用 `iter()` 遍歷所有輸入候選項
--     for cand in input:iter() do
--       yield(cand)
--     end
--   else
--     for cand in input:iter() do
--       cand:get_genuine().comment = ""
--       yield(cand)
--     end
--   end
-- end




-- --- @@ array30_nil_filter
-- --[[
-- 行列30空碼'⎔'轉成不輸出任何符號，符合原生
-- --]]
-- -- -- preedit_format 格式轉寫
-- -- local function xform_array30_input(ainput)
-- --   if ainput == "" then return "" end
-- --   ainput = string.gsub(ainput, "a", "1-")
-- --   ainput = string.gsub(ainput, "b", "5⇣")
-- --   ainput = string.gsub(ainput, "c", "3⇣")
-- --   ainput = string.gsub(ainput, "d", "3-")
-- --   ainput = string.gsub(ainput, "e", "3⇡")
-- --   ainput = string.gsub(ainput, "f", "4-")
-- --   ainput = string.gsub(ainput, "g", "5-")
-- --   ainput = string.gsub(ainput, "h", "6-")
-- --   ainput = string.gsub(ainput, "i", "8⇡")
-- --   ainput = string.gsub(ainput, "j", "7-")
-- --   ainput = string.gsub(ainput, "k", "8-")
-- --   ainput = string.gsub(ainput, "l", "9-")
-- --   ainput = string.gsub(ainput, "m", "7⇣")
-- --   ainput = string.gsub(ainput, "n", "6⇣")
-- --   ainput = string.gsub(ainput, "o", "9⇡")
-- --   ainput = string.gsub(ainput, "p", "0⇡")
-- --   ainput = string.gsub(ainput, "q", "1⇡")
-- --   ainput = string.gsub(ainput, "r", "4⇡")
-- --   ainput = string.gsub(ainput, "s", "2-")
-- --   ainput = string.gsub(ainput, "t", "5⇡")
-- --   ainput = string.gsub(ainput, "u", "7⇡")
-- --   ainput = string.gsub(ainput, "v", "4⇣")
-- --   ainput = string.gsub(ainput, "w", "2⇡")
-- --   ainput = string.gsub(ainput, "x", "2⇣")
-- --   ainput = string.gsub(ainput, "y", "6⇡")
-- --   ainput = string.gsub(ainput, "z", "1⇣")
-- --   ainput = string.gsub(ainput, "%.", "9⇣")
-- --   ainput = string.gsub(ainput, "/", "0⇣")
-- --   ainput = string.gsub(ainput, ";", "0-")
-- --   ainput = string.gsub(ainput, ",", "8⇣")
-- --   ainput = string.gsub(ainput, "% ", "▫")
-- --   ainput = string.gsub(ainput, "^==", "《查注音》")
-- --   return ainput
-- -- end

-- function array30_nil_filter(input, env)
--   for cand in input:iter() do
--     if (string.find(cand.text, '^⎔%d$' )) then
--       -- local cccc = string.gsub(cand.text, "^⎔2$", "⎔")
--       -- cand.text = '⎔'
--       -- cand:get_genuine().text = '@'
--       -- cand:get_genuine().comment = cand.comment .. "⎔"
-- --[[
--       欲定義的 translator 包含三個輸入參數：
--       - input: 待翻譯的字符串
--       - seg: 包含 `start` 和 `_end` 兩個屬性，分別表示當前串在輸入框中的起始和結束位置
--       - env: 可選參數，表示 translator 所處的環境
-- --]]
--       -- yield(Candidate("date", seg.start, seg._end, "⎔" , "〔日期〕"))
--       -- yield(Candidate("date", seg.start, seg._end, string.gsub(cand.text, "^⎔2$", "⎔") , "〔日期〕"))
-- --[[
--       -- local commit = env.engine.context:get_commit_text()  -- 原版樣式
--       -- local text = cand.text  -- 原版樣式
--       -- yield(Candidate("cap", 0, string.len(commit) , text, cand.comment))  -- 原版樣式
-- --]]
--       -- local array30_nil_preedit = cand:get_genuine().preedit  -- 效用同下，獲取原 preedit
--       local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
--       local array30_input = env.engine.context.input  -- 原始未轉換輸入碼
--       local array30_nil_cand = Candidate("array30nil", 0, string.len(array30_input) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
--       -- local array30_nil_cand = Candidate("array30nil", 0, string.len(commit) , "", "⎔")  -- 選擇空碼"⎔"效果為卡住，但 preedit 顯示會有問題
--       array30_nil_cand.preedit = array30_preedit
--       -- array30_nil_cand.preedit = xform_array30_input(array30_input)  -- 使用 gsub 函數轉換，上列為不使用 gsub 轉換更精簡寫法
--       yield(array30_nil_cand)
--     else
--       yield(cand)
--     end
--   end
--   -- return nil
-- end




--- @@ mix30_nil_comment_filter
--[[
（onion-array30）
合併 array30_nil_filter 和 array30_comment_filter，兩個 lua filter 太耗效能。
--]]
function mix30_nil_comment_filter(input, env)
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  local array30_input = env.engine.context.input  -- 原始未轉換輸入碼
  if (not s_c_f_p_s) or (string.find(array30_input, "`" )) then
    for cand in input:iter() do
      local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      local array30_nil_cand = Candidate("array30nil", 0, string.len(array30_input) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      if (string.find(cand.text, '^⎔%d$' )) then
        array30_nil_cand.preedit = array30_preedit
        yield(array30_nil_cand)
      else
        yield(cand)
      end
    end
  else
    for cand in input:iter() do
      local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      local array30_nil_cand = Candidate("array30nil", 0, string.len(array30_input) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      if (string.find(cand.text, '^⎔%d$' )) then
        array30_nil_cand.preedit = array30_preedit
        yield(array30_nil_cand)
      else
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  end
end




-- --- @@ missing_mark_filter
-- --[[
-- 補上標點符號因直上和 opencc 衝突沒附註之選項
-- --]]
-- function missing_mark_filter(input, env)
--   local p_key = env.engine.context.input
--   if (string.match(p_key, '=%.$' )) or (string.match(p_key, '[][]$' )) then
--     for cand in input:iter() do
--       if (cand.text == '。') then
--         cand:get_genuine().comment = "〔句點〕"
--         yield(cand)
--       elseif (cand.text == '〔') or (cand.text == '〕') then
--         cand:get_genuine().comment = "〔六角括號〕"
--         yield(cand)
--       else
--         yield(cand)
--       end
--     end
--   else
--     for cand in input:iter() do
--       yield(cand)
--     end
--   end
-- end




--- @@ mix_cf2_miss_filter
--[[
（bopomo_onionplus 和 bo_mixin 全系列）
合併 charset_filter2 和 missing_mark_filter，兩個 lua filter 太耗效能。
--]]
function mix_cf2_miss_filter(input, env)
  local c_f2_s = env.engine.context:get_option("zh_tw")
  local p_key = env.engine.context.input
  local addcomment1 = string.match(p_key, '=%.$')
  local addcomment2 = string.match(p_key, '[][]$')
  if (c_f2_s) then
    for cand in input:iter() do
      if (not string.find(cand.text, '᰼᰼' )) and (not addcomment1) and (not addcomment2) then
      -- if (not string.find(cand.text, '.*᰼᰼.*' )) then
        yield(cand)
      elseif (not string.find(cand.text, '᰼᰼' )) and (addcomment1) or (addcomment2) then
        if (cand.text == '。') then
          cand:get_genuine().comment = "〔句點〕"
          yield(cand)
        elseif (cand.text == '〔') or (cand.text == '〕') then
          cand:get_genuine().comment = "〔六角括號〕"
          yield(cand)
        else
          yield(cand)
        end
      end
    end
  else
    if (addcomment1) or (addcomment2) then
      for cand in input:iter() do
        if (cand.text == '。') then
          cand:get_genuine().comment = "〔句點〕"
          yield(cand)
        elseif (cand.text == '〔') or (cand.text == '〕') then
          cand:get_genuine().comment = "〔六角括號〕"
          yield(cand)
        else
          yield(cand)
        end
      end
    else
      for cand in input:iter() do
        yield(cand)
      end
    end
  end
end




--- @@ mix_cf2_cfp_filter
--[[
（dif1）
合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
--]]
function mix_cf2_cfp_filter(input, env)
  local c_f2_s = env.engine.context:get_option("zh_tw")
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  local find_prefix = env.engine.context.input
  -- local pun1 = string.find(find_prefix, "^'/" )
  -- local pun2 = string.find(find_prefix, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.find(find_prefix, "[]\\[]+$" )
  -- local pun4 = string.find(find_prefix, "^[;|][;]?$" )
  if (c_f2_s) then
    for cand in input:iter() do
      if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) then
      -- if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
        yield(cand)
      elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) then
      -- elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  else
    if (not s_c_f_p_s) then
    -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
      for cand in input:iter() do
        yield(cand)
      end
    else
      for cand in input:iter() do
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  end
end




--- @@ mix_cf2_cfp_smf_filter
--[[
（ocm_mixin）
合併 charset_filter2 和 comment_filter_plus 和 symbols_mark_filter，三個 lua filter 太耗效能。
--]]
function mix_cf2_cfp_smf_filter(input, env)
  local c_f2_s = env.engine.context:get_option("zh_tw")
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  local b_k = env.engine.context:get_option("back_mark")
  local find_prefix = env.engine.context.input
  -- local pun1 = string.find(find_prefix, "^'/" )
  -- local pun2 = string.find(find_prefix, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.find(find_prefix, "[]\\[]+$" )
  -- local pun4 = string.find(find_prefix, "^[;|][;]?$" )
  if (c_f2_s) and (b_k) then
    for cand in input:iter() do
      if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) then
      -- if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
        cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
        yield(cand)
      elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) then
      -- elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
        cand:get_genuine().comment = ""
        cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
        yield(cand)
      end
    end
  elseif (not c_f2_s) and (b_k) then
    if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
      for cand in input:iter() do
        cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
        yield(cand)
      end
    else
      for cand in input:iter() do
        cand:get_genuine().comment = ""
        cand:get_genuine().comment = xform_mark( cand.comment .. ocmdb:lookup(cand.text) )
        yield(cand)
      end
    end
  elseif (c_f2_s) and (not b_k) then
    for cand in input:iter() do
      if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) then
      -- if (not string.find(cand.text, '᰼᰼' )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
        yield(cand)
      elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) then
      -- elseif (not string.find(cand.text, '᰼᰼' )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  elseif (not c_f2_s) and (not b_k) then
    if (not s_c_f_p_s) then
    -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
      for cand in input:iter() do
        yield(cand)
      end
    else
      for cand in input:iter() do
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  end
end




--- @@ array30_spaceup_filter
--[[
（onion-array30）
行列30開關一二碼按空格後，是否直上或可能有選單。
--]]
function array30_spaceup_filter(input, env)
  local s_up = env.engine.context:get_option("1_2_straight_up")
  local find_prefix = env.engine.context.input
  if (s_up) then
    for cand in input:iter() do
      if (string.find(find_prefix, "^[a-z,./;][a-z,./;]? $" )) and (not string.find(cand.comment, '▪' )) then
        yield(cand)
      elseif (string.find(find_prefix, "^[a-z.,/;][a-z.,/;]?[a-z.,/;']?[a-z.,/;']?[i']?$" )) or (string.find(find_prefix, "^a[k,] $" )) or (string.find(find_prefix, "^lr $" )) or (string.find(find_prefix, "^ol $" )) or (string.find(find_prefix, "^qk $" )) or (string.find(find_prefix, "^%.b $" )) or (string.find(find_prefix, "^/%. $" )) or (string.find(find_prefix, "^pe $" )) then
        yield(cand)
      elseif (string.find(find_prefix, "^sf $" )) and (string.find(cand.text, '毋' )) then
        yield(cand)
      elseif (string.find(find_prefix, "^lb $" )) and (string.find(cand.text, '及' )) then
        yield(cand)
      -- elseif (string.find(find_prefix, "`.*$" )) or (string.find(find_prefix, "^w[0-9]$" ))  or (string.find(find_prefix, "^[a-z][-_.0-9a-z]*@.*$" )) or (string.find(find_prefix, "^(www[.]|https?:|ftp:|mailto:|file:).*$" )) then
      --   yield(cand)
      end
    end
  elseif (not s_up) then
    for cand in input:iter() do
      yield(cand)
    end
  end
end




--[[
--------------------------------------------
！！！！以下為 processor 掛接！！！！
--------------------------------------------
--]]




--- @@ endspace 增加上屏空白
--[[
（hangeul 和 hangeul2set）
韓語（非英語等）空格鍵後添加" "
--]]
function endspace(key, env)
  local engine = env.engine
  local context = engine.context
  -- local arr = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
  --- accept: space_do_space when: composing
  if (key:repr() == "space") and (context:is_composing()) then
    local caret_pos = context.caret_pos
    local s_orig = context:get_commit_text()
    -- local s_orig = context:get_commit_composition()
    -- local o_orig = context:commit()
    -- local o_orig = context:get_script_text()
    -- local o_orig = string.gsub(context:get_script_text(), " ", "a")
    -- 以下「含有英文字母、控制字元、空白」和「切分上屏時」不作用（用字數統計驗證是否切分）
    if (not string.find(s_orig, "[%a%c%s]")) and (caret_pos == context.input:len()) then
    -- if (not string.find(o_orig, "[%a%c%s]")) and (caret_pos == context.input:len()) then
    -- if (string.find(o_orig, "[%a%c%s]")) and (caret_pos == context.input:len()) then
      -- 下一句：游標位置向左一格，在本例無用，單純記錄用法
      -- context.caret_pos = caret_pos - 1
      -- 下兩句合用可使輸出句被電腦記憶
      -- engine:commit_text("a")
      -- engine:confirm_current_selection()
      -- 下一句：用冒號為精簡寫法，該句為完整寫法
      -- engine.commit_text(engine, s_orig .. "a")
      -- engine:commit_text(s_orig .. "a")
      engine:commit_text(s_orig .. " ") --「return 1」時用
      -- engine:commit_text(s_orig) --「return 0」「return 2」時用
      context:clear()
      return 1 -- kAccepted
      -- 「0」「2」「kAccepted」「kRejected」「kNoop」：直接後綴產生空白
      -- 「1」：後綴不會產生空白，可用.." "增加空白或其他符號
      -- （該條目有問題，實測對應不起來）「拒」kRejected、「收」kAccepted、「不認得」kNoop，分別對應返回值：0、1、2。
      -- 返回「拒絕」時，雖然我們已經處理過按鍵了，但系統以為沒有，於是會按默認值再處理一遍。
    end
  end
  return 2 -- kNoop
end




-- --- @@ 行列30上屏
-- --[[
-- 行列30三四碼字按空格直接上屏
-- --]]
-- function array30up(key, env)
--   local engine = env.engine
--   local context = engine.context
--   if (key:repr() == "space") and (context:has_menu()) then
--     -- local caret_pos = context.caret_pos
--     local array_s_orig = context:get_commit_text()
--     local array_o_input = context.input
--     if (string.find(array_o_input, "^[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.find(array_o_input, "^[=][=][a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.find(array_o_input, "`.+$")) or (string.find(array_o_input, "^[a-z][-_.0-9a-z]*@.*$")) or (string.find(array_o_input, "^https?:.*$")) or (string.find(array_o_input, "^ftp:.*$")) or (string.find(array_o_input, "^mailto:.*$")) or (string.find(array_o_input, "^file:.*$")) or (string.find(array_o_input, "^www%..+$")) then
--       engine:commit_text(array_s_orig)
--       context:clear()
--       return 1 -- kAccepted
--       -- 「0」「2」「kAccepted」「kRejected」「kNoop」：直接後綴產生空白
--       -- 「1」：後綴不會產生空白，可用.." "增加空白或其他符號
--       -- （該條目有問題，實測對應不起來）「拒」kRejected、「收」kAccepted、「不認得」kNoop，分別對應返回值：0、1、2。
--       -- 返回「拒絕」時，雖然我們已經處理過按鍵了，但系統以為沒有，於是會按默認值再處理一遍。
--     end
--   end
--   return 2 -- kNoop
-- end




-- --- @@ 行列30注音反查 Return 和 space 上屏修正
-- --[[
-- --]]
-- function array30up_zy(key, env)
--   local engine = env.engine
--   local context = engine.context
--   if (key:repr() == "Return" or key:repr() == "space" and context:has_menu()) then
--     -- local caret_pos = context.caret_pos
--     local array_s_orig = context:get_commit_text()
--     local array_o_input = context.input
--     -- if (string.find(array_o_input, "^=[a-z0-9 ,.;/-]+$")) and (not string.find(array_s_orig, "[%a%c%s]")) then
--     if (string.find(array_o_input, "^=[a-z0-9,.;/-]+$")) then
--       engine:commit_text(array_s_orig)
--       context:clear()
--       return 1 -- kAccepted
--       -- 「0」「2」「kAccepted」「kRejected」「kNoop」：直接後綴產生空白
--       -- 「1」：後綴不會產生空白，可用.." "增加空白或其他符號
--       -- （該條目有問題，實測對應不起來）「拒」kRejected、「收」kAccepted、「不認得」kNoop，分別對應返回值：0、1、2。
--       -- 返回「拒絕」時，雖然我們已經處理過按鍵了，但系統以為沒有，於是會按默認值再處理一遍。
--     end
--   end
--   return 2 -- kNoop
-- end




--- @@ 合併 array30up 和 array30up_zy
--[[
（onion-array30）
行列30三四碼字按空格直接上屏
行列30注音反查 Return 和 space 上屏修正
--]]
function array30up_mix(key, env)
  local engine = env.engine
  local context = engine.context
  local array_s_orig = context:get_commit_text()
  local array_o_input = context.input
  if (key:repr() == "space") and (context:has_menu()) then
    if (string.find(array_o_input, "^[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.find(array_o_input, "^[=][=][a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.find(array_o_input, "`.+$")) or (string.find(array_o_input, "^[a-z][-_.0-9a-z]*@.*$")) or (string.find(array_o_input, "^https?:.*$")) or (string.find(array_o_input, "^ftp:.*$")) or (string.find(array_o_input, "^mailto:.*$")) or (string.find(array_o_input, "^file:.*$")) or (string.find(array_o_input, "^www%..+$")) or (string.find(array_o_input, "^=[a-z0-9,.;/-]+$")) then
      engine:commit_text(array_s_orig)
      context:clear()
      return 1 -- kAccepted
    end
  elseif (key:repr() == "Return") and (context:has_menu()) then
    if (string.find(array_o_input, "^=[a-z0-9,.;/-]+$")) then
      engine:commit_text(array_s_orig)
      context:clear()
      return 1 -- kAccepted
    end
  end
  return 2
end




--- @@ ascii_punct_change 改變標點符號
--[[
（bopomo_onionplus_2和3）
於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
--]]
function ascii_punct_change(key, env)
  local c_b_d = env.engine.context:get_option("ascii_punct")
  local en_m = env.engine.context:get_option("ascii_mode")
  if (c_b_d) and (not en_m) then
    local engine = env.engine
    local context = engine.context
    if (key:repr() == 'Shift+less') then
      local b_orig = context:get_commit_text()
      engine:commit_text( b_orig .. ",")
      context:clear()
      return 1 -- kAccepted
    -- end
    elseif (key:repr() == 'Shift+greater') then
      local b_orig = context:get_commit_text()
      engine:commit_text( b_orig .. ".")
      context:clear()
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end




-- --- @@ s2r……去除上屏空白
-- --[[
-- 各種寫法，針對掛載 t2_translator 在注音（用到空白鍵時）去除上屏時跑出空格之函數
-- --]]
-- -- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（只針對開頭，並且寫法精簡，少了 is_composing ）
-- function s2r_ss(key, env)
--   local engine = env.engine
--   local context = engine.context
--   local o_input = context.input
--   -- local kkk = string.find(o_input, "'/")
--   if (string.find(o_input, "^'/")) and (key:repr() == 'space') then  -- (kkk~=nil) and (context:is_composing())
--     local s_orig = context:get_commit_text()
--     engine:commit_text(s_orig) -- .. "a"
--     context:clear()
--     return 1 -- kAccepted
--   end
--   return 2 -- kNoop
-- end

-- --- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（只針對開頭）
-- function s2r_s(key, env)
--   local engine = env.engine
--   local context = engine.context
--   -- local page_size = engine.schema.page_size
--   if (key:repr() == 'space') and (context:is_composing()) then
--   -- if (key:repr() == 'space') and (context:has_menu()) then
--     local s_orig = context:get_commit_text()
--     local o_input = context.input
--     if (string.find(o_input, "^'/")) then
--       engine:commit_text(s_orig)
--       context:clear()
--       return 1 -- kAccepted
--     end
--   end
--   return 2 -- kNoop
-- end

-- --- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。
-- function s2r(key, env)
--   local engine = env.engine
--   local context = engine.context
--   -- local page_size = engine.schema.page_size
--   if (key:repr() == 'space') and (context:is_composing()) then
--   -- if (key:repr() == 'space') and (context:has_menu()) then
--     local o_input = context.input
--     if (string.find(o_input, "'/")) then
--       if (string.find(o_input, "'/[';/]?[a-z]*$")) or (string.find(o_input, "'/[0-9./-]*$")) or (string.find(o_input, "'/[xcoe][0-9a-z]+$")) then
-- -- or string.find(o_input, "^[a-z][-_.0-9a-z]*@.*$") or string.find(o_input, "^https?:.*$") or string.find(o_input, "^ftp:.*$") or string.find(o_input, "^mailto:.*$") or string.find(o_input, "^file:.*$")
--         local s_orig = context:get_commit_text()
--         engine:commit_text(s_orig)
--         context:clear()
--         return 1 -- kAccepted
--       end
--     end
--   end
--   return 2 -- kNoop
-- end

-- --- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（只針對 email 和 url ）
-- function s2r_e_u(key, env)
--   local engine = env.engine
--   local context = engine.context
--   -- local page_size = engine.schema.page_size
--   if (key:repr() == 'space') and (context:is_composing()) then
--   -- if (key:repr() == 'space') and (context:has_menu()) then
--     local o_input = context.input
--     if (string.find(o_input, "[@:]")) then
--       if (string.find(o_input, "^[a-z][-_.0-9a-z]*@.*$")) or (string.find(o_input, "^https?:.*$")) or (string.find(o_input, "^ftp:.*$")) or (string.find(o_input, "^mailto:.*$")) or (string.find(o_input, "^file:.*$")) then
--         local s_orig = context:get_commit_text()
--         engine:commit_text(s_orig)
--         context:clear()
--         return 1 -- kAccepted
--       end
--     end
--   end
--   return 2 -- kNoop
-- end

-- --- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（特別正則 for mixin3）
-- function s2r_mixin3(key, env)
--   local engine = env.engine
--   local context = engine.context
--   -- local page_size = engine.schema.page_size
--   if (key:repr() == 'space') and (context:is_composing()) then
--   -- if (key:repr() == 'space') and (context:has_menu()) then
--     local o_input = context.input
--     -- if (string.find(o_input, "'/")) then
--       if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") ) then  --or string.find(o_input, "==[,.]{2}$")
--       -- if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
--       --「全，非精簡」 if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-][-]$") or string.find(o_input, "=[;][;]$") or string.find(o_input, "=[,][,]$") or string.find(o_input, "=[.][.]$") or string.find(o_input, "=[/][/]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
--       -- if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';/]?[a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][][3467%s]'/[';/]?[a-z0-9./-]*$") or string.find(o_input, "''/[';/]?[a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';/]?[a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';/]?[a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';/]?[a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';/]?[a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';/]?[a-z0-9./-]*$") ) then
-- -- or string.find(o_input, "^[a-z][-_.0-9a-z]*@.*$") or string.find(o_input, "^https?:.*$") or string.find(o_input, "^ftp:.*$") or string.find(o_input, "^mailto:.*$") or string.find(o_input, "^file:.*$")
-- --
-- -- 無效的正則，不去影響一般輸入：
-- -- string.find(o_input, "[=][-,.;'=`]'/[';/]?[a-z0-9/-]*$") or string.find(o_input, "[][]'/[';/]?[a-z0-9/-]*$") or string.find(o_input, "[][][][]'/[';/]?[a-z0-9/-]*$") or string.find(o_input, "[][][']'/[';/]?[a-z0-9/-]*$") or string.find(o_input, "[][][][][']'/[';/]?[a-z0-9/-]*$") 
-- -- 原始全部正則：
-- -- "^'/[';/]?[a-z0-9/-]*$|(?<=[-,./;a-z125890][][3467 ])'/[';/]?[a-z0-9/-]*$|(?<=['])'/[';/]?[a-z0-9/-]*$|(?<=[=][0-9])'/[';/]?[a-z0-9/-]*$|(?<=[=][][])'/[';/]?[a-z0-9/-]*$|(?<=[=][][][][])'/[';/]?[a-z0-9/-]*$|(?<=[=][-,.;'=`])'/[';/]?[a-z0-9/-]*$|(?<=[=][-,.;'=`][-,.;'=`])'/[';/]?[a-z0-9/-]*$|(?<=[][])'/[';/]?[a-z0-9/-]*$|(?<=[][][][])'/[';/]?[a-z0-9/-]*$|(?<=[][]['])'/[';/]?[a-z0-9/-]*$|(?<=[][][][]['])'/[';/]?[a-z0-9/-]*$"
--         local s_orig = context:get_commit_text()
--         engine:commit_text(s_orig)
--         context:clear()
--         return 1 -- kAccepted
--       end

--     -- end
--   end
--   return 2 -- kNoop
-- end

-- --- 把注音掛接 t2_translator 時，時不時尾邊出現" "問題去除，直接上屏。（ mixin(1,2,4)和 plus 用，精簡寫法）
-- function s2r_most(key, env)
--   local engine = env.engine
--   local context = engine.context
--   -- local page_size = engine.schema.page_size
--   if (key:repr() == 'space') and (context:is_composing()) then
--   -- if (key:repr() == 'space') and (context:has_menu()) then
--     local o_input = context.input
--     if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") ) then  --or string.find(o_input, "==[,.]{2}$")
--     -- if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
--     --「全，非精簡」 if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-][-]$") or string.find(o_input, "=[;][;]$") or string.find(o_input, "=[,][,]$") or string.find(o_input, "=[.][.]$") or string.find(o_input, "=[/][/]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
--         local s_orig = context:get_commit_text()
--         engine:commit_text(s_orig)
--         context:clear()
--         return 1 -- kAccepted
--     end
--   end
--   return 2 -- kNoop
-- end




--- @@ mix_apc_s2rm 注音mixin 1_2_4 和 plus 專用
--[[
（bo_mixin 1、2、4；bopomo_onionplus）
合併 ascii_punct_change 和 s2r_most，增進效能。
--]]
function mix_apc_s2rm(key, env)
  local c_b_d = env.engine.context:get_option("ascii_punct")
  local en_m = env.engine.context:get_option("ascii_mode")
  local engine = env.engine
  local context = engine.context
  local b_orig = context:get_commit_text()
  local o_input = context.input
  if (c_b_d) and (not en_m) then
    if (key:repr() == 'Shift+less') then
      engine:commit_text( b_orig .. ",")
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == 'Shift+greater') then
      engine:commit_text( b_orig .. ".")
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == 'space') and (context:is_composing()) then
      -- if (key:repr() == 'space') and (context:has_menu()) then
      if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") ) then  --or string.find(o_input, "==[,.]{2}$")
      -- if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
      --「全，非精簡」 if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-][-]$") or string.find(o_input, "=[;][;]$") or string.find(o_input, "=[,][,]$") or string.find(o_input, "=[.][.]$") or string.find(o_input, "=[/][/]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
        engine:commit_text(b_orig)
        context:clear()
        return 1 -- kAccepted
      end
    end
  elseif (not c_b_d) and (not en_m) then
    if (key:repr() == 'space') and (context:is_composing()) then
      if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") ) then  --or string.find(o_input, "==[,.]{2}$")
      -- if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
      --「全，非精簡」 if ( string.find(o_input, "[@:]") or string.find(o_input, "'/") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-][-]$") or string.find(o_input, "=[;][;]$") or string.find(o_input, "=[,][,]$") or string.find(o_input, "=[.][.]$") or string.find(o_input, "=[/][/]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
        engine:commit_text(b_orig)
        context:clear()
        return 1 -- kAccepted
      end
    end
  end
  return 2 -- kNoop
end




--- @@ mix_apc_s2rm_3 注音mixin 3
--[[
（bo_mixin3）
合併 ascii_punct_change 和 s2r_mixin3，增進效能。
--]]
function mix_apc_s2rm_3(key, env)
  local c_b_d = env.engine.context:get_option("ascii_punct")
  local en_m = env.engine.context:get_option("ascii_mode")
  local engine = env.engine
  local context = engine.context
  local b_orig = context:get_commit_text()
  local o_input = context.input
  if (c_b_d) and (not en_m) then
    if (key:repr() == 'Shift+less') then
      engine:commit_text( b_orig .. ",")
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == 'Shift+greater') then
      engine:commit_text( b_orig .. ".")
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == 'space') and (context:is_composing()) then
      -- if (key:repr() == 'space') and (context:has_menu()) then
      if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") ) then  --or string.find(o_input, "==[,.]{2}$")
      -- if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
      --「全，非精簡」 if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-][-]$") or string.find(o_input, "=[;][;]$") or string.find(o_input, "=[,][,]$") or string.find(o_input, "=[.][.]$") or string.find(o_input, "=[/][/]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
        engine:commit_text(b_orig)
        context:clear()
        return 1 -- kAccepted
      end
    end
  elseif (not c_b_d) and (not en_m) then
    if (key:repr() == 'space') and (context:is_composing()) then
      if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") ) then  --or string.find(o_input, "==[,.]{2}$")
      -- if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-;,./][-;,./]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
      --「全，非精簡」 if ( string.find(o_input, "[@:]") or string.find(o_input, "^'/[';a-z0-9./-]*$") or string.find(o_input, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][0-9]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][][][][]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;=`]'/[';a-z0-9./-]*$") or string.find(o_input, "[=][-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(o_input, "=[-125890;,./]$") or string.find(o_input, "=[-][-]$") or string.find(o_input, "=[;][;]$") or string.find(o_input, "=[,][,]$") or string.find(o_input, "=[.][.]$") or string.find(o_input, "=[/][/]$") or string.find(o_input, "==[90]$") or string.find(o_input, "==[,][,]?$") or string.find(o_input, "==[.][.]?$") ) then
        engine:commit_text(b_orig)
        context:clear()
        return 1 -- kAccepted
      end
    end
  end
  return 2 -- kNoop
end




--- @@ mix_apc_pluss
--[[
（bopomo_onionplus_space）
以原 ascii_punct_change 增加功能
使初始空白可以直接上屏
於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
--]]
function mix_apc_pluss(key, env)
  local c_b_d = env.engine.context:get_option("ascii_punct")
  local en_m = env.engine.context:get_option("ascii_mode")
  local caret_pos = env.engine.context.caret_pos
  if (c_b_d) and (not en_m) then
    local engine = env.engine
    local context = engine.context
    if (key:repr() == 'Shift+less') then
      local b_orig = context:get_commit_text()
      engine:commit_text( b_orig .. ",")
      context:clear()
      return 1 -- kAccepted
    -- end
    elseif (key:repr() == 'Shift+greater') then
      local b_orig = context:get_commit_text()
      engine:commit_text( b_orig .. ".")
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == 'space') and (caret_pos == 0) then
      -- local b_orig = context:get_commit_text()
      engine:commit_text( " " )
      context:clear()
      return 1 -- kAccepted
    end
  elseif (not c_b_d) and (not en_m) then
    if (key:repr() == 'space') and (caret_pos == 0) then
      local engine = env.engine
      local context = engine.context
      -- local b_orig = context:get_commit_text()
      engine:commit_text( " " )
      context:clear() 
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end




--[[
--------------------------------------------
！！！！以下為 translator 掛接！！！！
--------------------------------------------
--]]




--- @@ email_url_translator
--[[
把 recognizer 正則輸入 email 使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
把 recognizer 正則輸入網址使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
--]]
function email_url_translator(input, seg)
  local email_in = string.match(input, "^([a-z][-_.0-9a-z]*@.*)$")
  local url1_in = string.match(input, "^(https?:.*)$")
  local url2_in = string.match(input, "^(ftp:.*)$")
  local url3_in = string.match(input, "^(mailto:.*)$")
  local url4_in = string.match(input, "^(file:.*)$")
  if (email_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, input , "〔e-mail〕"))
    return
  elseif (url1_in~=nil) or (url2_in~=nil) or (url3_in~=nil) or (url4_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, input , "〔URL〕"))
    return
  end
end




--- @@ email_urlw_translator
--[[
把 recognizer 正則輸入網址使用 lua 實現，使之有選項，避免設定空白清屏時無法上屏。
該項多加「www.」
--]]
function email_urlw_translator(input, seg)
  local email_in = string.match(input, "^([a-z][-_.0-9a-z]*@.*)$")
  local www_in = string.match(input, "^(www[.][-_0-9a-z]*[-_.0-9a-z]*)$")
  local url1_in = string.match(input, "^(https?:.*)$")
  local url2_in = string.match(input, "^(ftp:.*)$")
  local url3_in = string.match(input, "^(mailto:.*)$")
  local url4_in = string.match(input, "^(file:.*)$")
  if (www_in~=nil) or (url1_in~=nil) or (url2_in~=nil) or (url3_in~=nil) or (url4_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, input , "〔URL〕"))
    return
  end
  if (email_in~=nil) then
    yield(Candidate("englishtype", seg.start, seg._end, input , "〔e-mail〕"))
    return
  end
end




--[[
內碼輸入法，收入 unicode 碼得出該碼字元
--]]
local function utf8_out(cp)
  local string_char = string.char
  if cp < 128 then
    return string_char(cp)
  end
  local suffix = cp % 64
  local c4 = 128 + suffix
  cp = (cp - suffix) / 64
  if cp < 32 then
    return string_char(192 + cp, c4)
  end
  suffix = cp % 64
  local c3 = 128 + suffix
  cp = (cp - suffix) / 64
  if cp < 16 then
    return string_char(224 + cp, c3, c4)
  end
  suffix = cp % 64
  cp = (cp - suffix) / 64
  return string_char(240 + cp, 128 + suffix, c3, c4)
end




--[[
百分號編碼（英語：Percent-encoding），又稱：URL編碼（URL encoding）
從編碼到文字。
導出暫轉到十進位編碼，後續變成文字，要再用以下函數轉換。
--]]
local function url_decode(str_d)
  if string.match(str_d,'^[%x][%x]$') then
    local ch_1 = string.gsub(str_d,'^([%x][%x])$', '%1')
    local x_1 = tonumber(ch_1, 16)
    local o_1 = Dec2bin(x_1)
    local o_1=o_1-00000000
    local out_all=tonumber(string.format("%07d",o_1),2)
    return out_all
  elseif string.match(str_d,'^[%x][%x][%x][%x]$') then
    local ch_1 = string.gsub(str_d,'^([%x][%x])..$', '%1')
    local ch_2 = string.gsub(str_d,'^..([%x][%x])$', '%1')
    local x_1 = tonumber(ch_1, 16)
    local x_2 = tonumber(ch_2, 16)
    local o_1 = Dec2bin(x_1)
    local o_2 = Dec2bin(x_2)
    local o_1=o_1-11000000
    local o_2=o_2-10000000
    local out_all=tonumber(string.format("%05d",o_1) .. string.format("%06d",o_2),2)
    return out_all
  elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x]$') then
    local ch_1 = string.gsub(str_d,'^([%x][%x])....$', '%1')
    local ch_2 = string.gsub(str_d,'^..([%x][%x])..$', '%1')
    local ch_3 = string.gsub(str_d,'^....([%x][%x])$', '%1')
    local x_1 = tonumber(ch_1, 16)
    local x_2 = tonumber(ch_2, 16)
    local x_3 = tonumber(ch_3, 16)
    local o_1 = Dec2bin(x_1)
    local o_2 = Dec2bin(x_2)
    local o_3 = Dec2bin(x_3)
    local o_1=o_1-11100000
    local o_2=o_2-10000000
    local o_3=o_3-10000000
    local out_all=tonumber(string.format("%04d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3),2)
    return out_all
  elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x]$') then
    local ch_1 = string.gsub(str_d,'^([%x][%x])......$', '%1')
    local ch_2 = string.gsub(str_d,'^..([%x][%x])....$', '%1')
    local ch_3 = string.gsub(str_d,'^....([%x][%x])..$', '%1')
    local ch_4 = string.gsub(str_d,'^......([%x][%x])$', '%1')
    local x_1 = tonumber(ch_1, 16)
    local x_2 = tonumber(ch_2, 16)
    local x_3 = tonumber(ch_3, 16)
    local x_4 = tonumber(ch_4, 16)
    local o_1 = Dec2bin(x_1)
    local o_2 = Dec2bin(x_2)
    local o_3 = Dec2bin(x_3)
    local o_4 = Dec2bin(x_4)
    local o_1=o_1-11110000
    local o_2=o_2-10000000
    local o_3=o_3-10000000
    local o_4=o_4-10000000
    local out_all=tonumber(string.format("%03d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4),2)
    return out_all
  elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x][%x][%x]$') then
    local ch_1 = string.gsub(str_d,'^([%x][%x])........$', '%1')
    local ch_2 = string.gsub(str_d,'^..([%x][%x])......$', '%1')
    local ch_3 = string.gsub(str_d,'^....([%x][%x])....$', '%1')
    local ch_4 = string.gsub(str_d,'^......([%x][%x])..$', '%1')
    local ch_5 = string.gsub(str_d,'^........([%x][%x])$', '%1')
    local x_1 = tonumber(ch_1, 16)
    local x_2 = tonumber(ch_2, 16)
    local x_3 = tonumber(ch_3, 16)
    local x_4 = tonumber(ch_4, 16)
    local x_5 = tonumber(ch_5, 16)
    local o_1 = Dec2bin(x_1)
    local o_2 = Dec2bin(x_2)
    local o_3 = Dec2bin(x_3)
    local o_4 = Dec2bin(x_4)
    local o_5 = Dec2bin(x_5)
    local o_1=o_1-11111000
    local o_2=o_2-10000000
    local o_3=o_3-10000000
    local o_4=o_4-10000000
    local o_5=o_5-10000000
    local out_all=tonumber(string.format("%02d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4) .. string.format("%06d",o_5),2)
    return out_all
  elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x][%x][%x][%x]$') then
    local ch_1 = string.gsub(str_d,'^([%x][%x])..........$', '%1')
    local ch_2 = string.gsub(str_d,'^..([%x][%x])........$', '%1')
    local ch_3 = string.gsub(str_d,'^....([%x][%x])......$', '%1')
    local ch_4 = string.gsub(str_d,'^......([%x][%x])....$', '%1')
    local ch_5 = string.gsub(str_d,'^........([%x][%x])..$', '%1')
    local ch_6 = string.gsub(str_d,'^..........([%x][%x])$', '%1')
    local x_1 = tonumber(ch_1, 16)
    local x_2 = tonumber(ch_2, 16)
    local x_3 = tonumber(ch_3, 16)
    local x_4 = tonumber(ch_4, 16)
    local x_5 = tonumber(ch_5, 16)
    local x_6 = tonumber(ch_6, 16)
    local o_1 = Dec2bin(x_1)
    local o_2 = Dec2bin(x_2)
    local o_3 = Dec2bin(x_3)
    local o_4 = Dec2bin(x_4)
    local o_5 = Dec2bin(x_5)
    local o_6 = Dec2bin(x_6)
    local o_1=o_1-11111100
    local o_2=o_2-10000000
    local o_3=o_3-10000000
    local o_4=o_4-10000000
    local o_5=o_5-10000000
    local o_6=o_6-10000000
    local out_all=tonumber(string.format("%01d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4) .. string.format("%06d",o_5) .. string.format("%06d",o_6),2)
    return out_all
  elseif string.match(str_d,'^[a-z0-9]$') then
    return str_d
  else
    local out_all='無此編碼'
    return out_all
  end
end

-- -- 網上方法，但空碼無法再接後續，不適用
-- local function url_decode(str)
--   local str = string.gsub (str, "+", " ")
--   local str = string.gsub (str, "%%(%x%x)", function(h) return string.char(tonumber(h,16)) end)
--   local str = string.gsub (str, "\r\n", "\n")
--   return str
-- end
-- -- print(url_decode('EAb080'))


--[[
百分號編碼（英語：Percent-encoding），又稱：URL編碼（URL encoding）
從文字到編碼
--]]
local function url_encode(str_e)
  if (str_e) then
    str_e = string.gsub (str_e, "\n", "\r\n")
    str_e = string.gsub (str_e, "([^%w ])", function (c) return string.format ("%%%02X", string.byte(c)) end)
    str_e = string.gsub (str_e, " ", "+")
  end
  return str_e
end




--[[
數字日期字母各種轉寫
--]]
-- 日期轉大寫1
local function rqzdx1(a)
--a=1(二〇一九年)、2(六月)、3(二十三日)、12(二〇一九年六月)、23(六月二十三日)、其它為(二〇一九年六月二十三日)
-- 二〇一九年六月二十三日
  local result = ""
  local number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" }
  local year0=os.date("%Y")
  for i= 0, 9 do
    year0= string.gsub(year0,i,number[i])
  end
  local monthnumber = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" , "十", "十一", "十二"}
  local month0=monthnumber[os.date("%m")*1]
  local daynumber = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一" }
  local day0=daynumber[os.date("%d")*1]
  if a == 1 then
    result = year0.."年"
  elseif a == 2 then
    result = month0.."月"
  elseif a == 3 then
    result = day0.."日"
  elseif a == 12 then
    result = year0.."年"..month0.."月"
  elseif a == 23 then
    result = month0.."月"..day0.."日"
  else
    result = year0.."年"..month0.."月"..day0.."日"
  end
  return result;
end

-- 日期轉大寫2
local function rqzdx2(a)
-- 貳零零玖年零陸月貳拾參日
--a=1(貳零壹玖年)、2(零陸月)、3(貳拾參日)、12(貳零壹玖年零陸月)、23(零陸月貳拾參日)、其它為(貳零壹玖年零陸月貳拾參日)
  local result = ""
  local number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾" }
  local year0=os.date("%Y")
  for i= 0, 9 do
    year0= string.gsub(year0,i,number[i])
  end
-- for i= 1, 4 do
   -- year0=  string.gsub(year0,string.sub(year0,i,1),number[string.sub(year0,i,1)*1])
-- end
  local monthnumber = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳" }
  -- local monthnumber = { [0] = "零", "零壹", "零貳", "零參", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳" }
  local month0=monthnumber[os.date("%m")*1]
  -- local daynumber = { [0] = "零", "零壹", "零貳", "零參", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳", "壹拾參", "壹拾肆", "壹拾伍", "壹拾陸", "壹拾柒", "壹拾捌", "壹拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹" }
  local daynumber = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳", "拾參", "拾肆", "拾伍", "拾陸", "拾柒", "拾捌", "拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹" }
  local day0=daynumber[os.date("%d")*1]
  if a == 1 then
    result = year0.."年"
  elseif a == 2 then
    result = month0.."月"
  elseif a == 3 then
    result = day0.."日"
  elseif a == 12 then
    result = year0.."年"..month0.."月"
  elseif a == 23 then
    result = month0.."月"..day0.."日"
  else
    result = year0.."年"..month0.."月"..day0.."日"
  end
  return result;
end

--[[
以下日期數字轉寫函數
--]]
local function ch_y_date(a)
  if a == "" then return "" end
  local year_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" }
  for i= 0, 9 do
    a= string.gsub(a,i,year_number[i])
  end
  return a
end

local function ch_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" , "十", "十一", "十二"}
  local a=month_number[a*1]
  return a
end

local function ch_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一" }
  local a=day_number[a*1]
  return a
end

local function ch_h_date(a)
  if a == "" then return "" end
  local hour_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四" }
  local a=hour_number[a*1]
  return a
end

local function ch_minsec_date(a)
  if a == "" then return "" end
  local minsec_number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一", "三十二", "三十三", "三十四", "三十五", "三十六", "三十七", "三十八", "三十九", "四十", "四十一", "四十二", "四十三", "四十四", "四十五", "四十六", "四十七", "四十八", "四十九", "五十", "五十一", "五十二", "五十三", "五十四", "五十五", "五十六", "五十七", "五十八", "五十九", "六十" }
  local a=minsec_number[a*1]
  return a
end

local function chb_y_date(a)
  if a == "" then return "" end
  local year_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾" }
  for i= 0, 9 do
    a= string.gsub(a,i,year_number[i])
  end
  return a
end

local function chb_m_date(a)
  if a == "" then return "" end
  -- local month_number = { [0] = "零", "零壹", "零貳", "零參", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳" }
  local month_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳" }
  local a=month_number[a*1]
  return a
end

local function chb_d_date(a)
  if a == "" then return "" end
  -- local day_number = { [0] = "零", "零壹", "零貳", "零參", "零肆", "零伍", "零陸", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾貳", "壹拾參", "壹拾肆", "壹拾伍", "壹拾陸", "壹拾柒", "壹拾捌", "壹拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹" }
  local day_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳", "拾參", "拾肆", "拾伍", "拾陸", "拾柒", "拾捌", "拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹" }
  local a=day_number[a*1]
  return a
end

local function chb_h_date(a)
  if a == "" then return "" end
  local hour_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳", "拾參", "拾肆", "拾伍", "拾陸", "拾柒", "拾捌", "拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆" }
  local a=hour_number[a*1]
  return a
end

local function chb_minsec_date(a)
  if a == "" then return "" end
  local minsec_number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾", "拾壹", "拾貳", "拾參", "拾肆", "拾伍", "拾陸", "拾柒", "拾捌", "拾玖", "貳拾", "貳拾壹", "貳拾貳", "貳拾參", "貳拾肆", "貳拾伍", "貳拾陸", "貳拾柒", "貳拾捌", "貳拾玖", "參拾", "參拾壹", "參拾貳", "參拾參", "參拾肆", "參拾伍", "參拾陸", "參拾柒", "參拾捌", "參拾玖", "肆拾", "肆拾壹", "肆拾貳", "肆拾參", "肆拾肆", "肆拾伍", "肆拾陸", "肆拾柒", "肆拾捌", "肆拾玖", "伍拾", "伍拾壹", "伍拾貳", "伍拾參", "伍拾肆", "伍拾伍", "伍拾陸", "伍拾柒", "伍拾捌", "伍拾玖", "陸拾" }
  local a=minsec_number[a*1]
  return a
end

local function jp_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "0月", "㋀", "㋁", "㋂", "㋃", "㋄", "㋅", "㋆", "㋇", "㋈", "㋉", "㋊", "㋋" }
  local a=month_number[a*1]
  return a
end

local function jp_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "0日", "㏠", "㏡", "㏢", "㏣", "㏤", "㏥", "㏦", "㏧", "㏨", "㏩", "㏪", "㏫", "㏬", "㏭", "㏮", "㏯", "㏰", "㏱", "㏲", "㏳", "㏴", "㏵", "㏶", "㏷", "㏸", "㏹", "㏺", "㏻", "㏼", "㏽", "㏾" }
  local a=day_number[a*1]
  return a
end

local function eng1_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "〇", "January", "February", "March", "April", "May", "June", "July", "August", "Septemper", "October", "November", "December" }
  local a=month_number[a*1]
  return a
end

local function eng2_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "〇", "Jan.", "Feb.", "Mar.", "Apr.", "May.", "Jun.", "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec." }
  local a=month_number[a*1]
  return a
end

local function eng3_m_date(a)
  if a == "" then return "" end
  local month_number = { [0] = "〇", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }
  local a=month_number[a*1]
  return a
end

local function eng1_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "zero", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "egihteenth", "nineteenth", "twentieth", "twenty-first", "twenty-second", "twenty-third", "twenty-fouth", "twenty-fifth", "twenty-sixth", "twenty-seventh", "twenty-eighth", "twenty-ninth", "thirtieth", "thirty-first" }
  local a=day_number[a*1]
  return a
end

local function eng2_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "0", "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th", "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st" }
  local a=day_number[a*1]
  return a
end

local function eng3_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31" }
  local a=day_number[a*1]
  return a
end

local function eng4_d_date(a)
  if a == "" then return "" end
  local day_number = { [0] = "0", "1ˢᵗ", "2ⁿᵈ", "3ʳᵈ", "4ᵗʰ", "5ᵗʰ", "6ᵗʰ", "7ᵗʰ", "8ᵗʰ", "9ᵗʰ", "10ᵗʰ", "11ᵗʰ", "12ᵗʰ", "13ᵗʰ", "14ᵗʰ", "15ᵗʰ", "16ᵗʰ", "17ᵗʰ", "18ᵗʰ", "19ᵗʰ", "20ᵗʰ", "21ˢᵗ", "22ⁿᵈ", "23ʳᵈ", "24ᵗʰ", "25ᵗʰ", "26ᵗʰ", "27ᵗʰ", "28ᵗʰ", "29ᵗʰ", "30ᵗʰ", "31ˢᵗ" }
  local a=day_number[a*1]
  return a
end




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

--[[
number_translator: 將 `'/` + 阿拉伯數字 翻譯為大小寫漢字
--]]
local confs = {
  {
    comment = "〔小寫中文數字〕",
    number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" },
    suffix = { [0] = "", "十", "百", "千" },
    suffix2 = { [0] = "", "萬", "億", "兆", "京" }
  },
  {
    comment = "〔大寫中文數字〕",
    number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖" },
    suffix = { [0] = "", "拾", "佰", "仟" },
    suffix2 = { [0] = "", "萬", "億", "兆", "京" }
  },
}

local function read_seg(conf, n)
  local s = ""
  local i = 0
  local zf = true
  while string.len(n) > 0 do
    local d = tonumber(string.sub(n, -1, -1))
    if d ~= 0 then
      s = conf.number[d] .. conf.suffix[i] .. s
      zf = false
    else
      if not zf then
        s = conf.number[0] .. s
      end
      zf = true
    end
    i = i + 1
    n = string.sub(n, 1, -2)
  end
  return i < 4, s
end

local function read_number(conf, n)
  local s = ""
  local i = 0
  local zf = false
  n = string.gsub(n, "^0+", "")
  if n == "" then
    return conf.number[0]
  end
  while string.len(n) > 0 do
    local zf2, r = read_seg(conf, string.sub(n, -4, -1))
    if r ~= "" then
      if zf and s ~= "" then
        s = r .. conf.suffix2[i] .. conf.number[0] .. s
      else
        s = r .. conf.suffix2[i] .. s
      end
    end
    zf = zf2
    i = i + 1
    n = string.sub(n, 1, -5)
  end
  return s
end




--[[
~~~~轉換農曆函數~~~~
--]]
--十進制轉二進制
function Dec2bin(n)
	local t,t1,t2
	local tables={""}
	t=tonumber(n)
	while math.floor(t/2)>=1 do
		t1= math.fmod(t,2)
		if t1>0 then if #tables>0 then table.insert(tables,1,1) else tables[1]=1 end else if #tables>0 then table.insert(tables,1,0) else tables[1]=0 end end
		t=math.floor(t/2)
		if t==1 then if #tables>0 then table.insert(tables,1,1) else tables[1]=1 end end
	end
	return string.gsub(table.concat(tables),"^[0]+","")
end

--2/10/16進制互轉
local function system(x,inPuttype,outputtype)
	local r
	if (tonumber(inPuttype)==2) then
		if (tonumber(outputtype) == 10) then  --2進制-->10進制
			r= tonumber(tostring(x), 2)
		elseif (tonumber(outputtype)==16) then  --2進制-->16進制
			r= bin2hex(tostring(x))
		end
	elseif (tonumber(inPuttype)==10) then
		if (tonumber(outputtype)==2) then   --10進制-->2進制
			r= Dec2bin(tonumber(x))
		elseif (tonumber(outputtype)==16) then  --10進制-->16進制
			r= string.format("%x",x)
		end
	elseif (tonumber(inPuttype)==16) then
		if (tonumber(outputtype)==2) then  --16進制-->2進制
			r= Dec2bin(tonumber(tostring(x), 16))
		elseif (tonumber(outputtype)==10) then  --16進制-->10進制
			r= tonumber(tostring(x), 16)
		end
	end
	return r
end

--農歷16進制數據分解
local function Analyze(Data)
	local rtn1,rtn2,rtn3,rtn4
	rtn1=system(string.sub(Data,1,3),16,2)
	if string.len(rtn1)<12 then rtn1="0" .. rtn1 end
	rtn2=string.sub(Data,4,4)
	rtn3=system(string.sub(Data,5,5),16,10)
	rtn4=system(string.sub(Data,-2,-1),16,10)
	if string.len(rtn4)==3 then rtn4="0" .. system(string.sub(Data,-2,-1),16,10) end
	--string.gsub(rtn1, "^[0]*", "")
	return {rtn1,rtn2,rtn3,rtn4}
end

--年天數判斷
local function IsLeap(y)
	local year=tonumber(y)
	if math.fmod(year,400)~=0 and math.fmod(year,4)==0 or math.fmod(year,400)==0 then return 366
	else return 365 end
end

--返回當年過了多少天
local function leaveDate(y)
	local day,total
	total=0
	if IsLeap(tonumber(string.sub(y,1,4)))>365 then day={31,29,31,30,31,30,31,31,30,31,30,31}
	else day={31,28,31,30,31,30,31,31,30,31,30,31} end
	if tonumber(string.sub(y,5,6))>1 then
		for i=1,tonumber(string.sub(y,5,6))-1 do total=total+day[i] end
		total=total+tonumber(string.sub(y,7,8))
	else
		return tonumber(string.sub(y,7,8))
	end
	return tonumber(total)
end

--計算日期差，兩個8位數日期之間相隔的天數，date2>date1
local function diffDate(date1,date2)
	local t1,t2,n,total
	total=0 date1=tostring(date1) date2=tostring(date2)
	if tonumber(date2)>tonumber(date1) then
		n=tonumber(string.sub(date2,1,4))-tonumber(string.sub(date1,1,4))
		if n>1 then
			for i=1,n-1 do
				total=total+IsLeap(tonumber(string.sub(date1,1,4))+i)
			end
			total=total+leaveDate(tonumber(string.sub(date2,1,8)))+IsLeap(tonumber(string.sub(date1,1,4)))-leaveDate(tonumber(string.sub(date1,1,8)))
		elseif n==1 then
			total=IsLeap(tonumber(string.sub(date1,1,4)))-leaveDate(tonumber(string.sub(date1,1,8)))+leaveDate(tonumber(string.sub(date2,1,8)))
		else
			total=leaveDate(tonumber(string.sub(date2,1,8)))-leaveDate(tonumber(string.sub(date1,1,8)))
			--print(date1 .. "-" .. date2)
		end
	elseif tonumber(date2)==tonumber(date1) then
		return 0
	else
		return -1
	end
	return total
end

--公曆轉農歷，支持轉化範圍公元1900-2100年
--公曆日期 Gregorian:格式 YYYYMMDD
--<返回值>農歷日期 中文 天干地支屬相
local function Date2LunarDate(Gregorian)
	--天干名稱
	local cTianGan = {"甲","乙","丙","丁","戊","己","庚","辛","壬","癸"}
	--地支名稱
	local cDiZhi = {"子","丑","寅","卯","辰","巳","午", "未","申","酉","戌","亥"}
	--屬相名稱
	local cShuXiang = {"鼠","牛","虎","兔","龍","蛇", "馬","羊","猴","雞","狗","豬"}
	--農歷日期名
	local cDayName ={"初一","初二","初三","初四","初五","初六","初七","初八","初九","初十",
		"十一","十二","十三","十四","十五","十六","十七","十八","十九","二十",
		"廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"}
	--農歷月份名
	local cMonName = {"正月","二月","三月","四月","五月","六月", "七月","八月","九月","十月","冬月","臘月"}

	-- 農歷數據
	local wNongliData = {"AB500D2","4BD0883","4AE00DB","A5700D0","54D0581","D2600D8","D9500CC","655147D","56A00D5","9AD00CA","55D027A","4AE00D2"
		,"A5B0682","A4D00DA","D2500CE","D25157E","B5500D6","56A00CC","ADA027B","95B00D3","49717C9","49B00DC","A4B00D0","B4B0580"
		,"6A500D8","6D400CD","AB5147C","2B600D5","95700CA","52F027B","49700D2","6560682","D4A00D9","EA500CE","6A9157E","5AD00D6"
		,"2B600CC","86E137C","92E00D3","C8D1783","C9500DB","D4A00D0","D8A167F","B5500D7","56A00CD","A5B147D","25D00D5","92D00CA"
		,"D2B027A","A9500D2","B550781","6CA00D9","B5500CE","535157F","4DA00D6","A5B00CB","457037C","52B00D4","A9A0883","E9500DA"
		,"6AA00D0","AEA0680","AB500D7","4B600CD","AAE047D","A5700D5","52600CA","F260379","D9500D1","5B50782","56A00D9","96D00CE"
		,"4DD057F","4AD00D7","A4D00CB","D4D047B","D2500D3","D550883","B5400DA","B6A00CF","95A1680","95B00D8","49B00CD","A97047D"
		,"A4B00D5","B270ACA","6A500DC","6D400D1","AF40681","AB600D9","93700CE","4AF057F","49700D7","64B00CC","74A037B","EA500D2"
		,"6B50883","5AC00DB","AB600CF","96D0580","92E00D8","C9600CD","D95047C","D4A00D4","DA500C9","755027A","56A00D1","ABB0781"
		,"25D00DA","92D00CF","CAB057E","A9500D6","B4A00CB","BAA047B","AD500D2","55D0983","4BA00DB","A5B00D0","5171680","52B00D8"
		,"A9300CD","795047D","6AA00D4","AD500C9","5B5027A","4B600D2","96E0681","A4E00D9","D2600CE","EA6057E","D5300D5","5AA00CB"
		,"76A037B","96D00D3","4AB0B83","4AD00DB","A4D00D0","D0B1680","D2500D7","D5200CC","DD4057C","B5A00D4","56D00C9","55B027A"
		,"49B00D2","A570782","A4B00D9","AA500CE","B25157E","6D200D6","ADA00CA","4B6137B","93700D3","49F08C9","49700DB","64B00D0"
		,"68A1680","EA500D7","6AA00CC","A6C147C","AAE00D4","92E00CA","D2E0379","C9600D1","D550781","D4A00D9","DA400CD","5D5057E"
		,"56A00D6","A6C00CB","55D047B","52D00D3","A9B0883","A9500DB","B4A00CF","B6A067F","AD500D7","55A00CD","ABA047C","A5A00D4"
		,"52B00CA","B27037A","69300D1","7330781","6AA00D9","AD500CE","4B5157E","4B600D6","A5700CB","54E047C","D1600D2","E960882"
		,"D5200DA","DAA00CF","6AA167F","56D00D7","4AE00CD","A9D047D","A2D00D4","D1500C9","F250279","D5200D1"
	}
	Gregorian=tostring(Gregorian)
	local Year,Month,Day,Pos,Data0,Data1,MonthInfo,LeapInfo,Leap,Newyear,Data2,Data3,LYear,thisMonthInfo
	Year =tonumber(Gregorian.sub(Gregorian,1,4))  Month =tonumber(Gregorian.sub(Gregorian,5,6))
	Day =tonumber(Gregorian.sub(Gregorian,7,8))
	if (Year>2100 or Year<1899 or Month>12 or Month<1 or Day<1 or Day>31 or string.len(Gregorian)<8) then
		return "無效日期"
	end
	--print(Year .. "-" .. Month .. "-" .. Day)
	--獲取兩百年內的農歷數據
	Pos=Year-1900+2  Data0 =wNongliData[Pos-1]  Data1 =wNongliData[Pos]
	--判斷農歷年份
	local tb1=Analyze(Data1)
	MonthInfo=tb1[1] LeapInfo=tb1[2] Leap=tb1[3] Newyear=tb1[4]
	Date1 =Year .. Newyear  Date2 =Gregorian
	Date3 =diffDate(Date1,Date2)   --和當年農歷新年相差的天數
	--print(Date3 .. "-11")
	if (Date3<0) then
		--print(Data0 .. "-2")
		tb1=Analyze(Data0)  Year=Year-1
		MonthInfo=tb1[1] LeapInfo=tb1[2] Leap=tb1[3] Newyear=tb1[4]
		Date1 =Year .. Newyear  Date2=Gregorian
		Date3=diffDate(Date1,Date2)
		--print(Date2 .. "--" .. Date1 .. "--" .. Date3)
	end
	--print(MonthInfo .. "-" .. LeapInfo .. "-" .. Leap .. "-" .. Newyear .. "-" .. Year)
	Date3=Date3+1
	LYear=Year    --農歷年份，就是上面計算後的值
	if Leap>0 then    --有閏月
		thisMonthInfo=string.sub(MonthInfo,1,Leap) .. LeapInfo .. string.sub(MonthInfo,Leap+1)
	else
		thisMonthInfo=MonthInfo
	end
	local thisMonth,thisDays,LDay,Isleap,LunarYear,LunarMonth
	for i=1,13 do
		thisMonth=string.sub(thisMonthInfo,i,i)  thisDays=29+thisMonth
		if (Date3>thisDays) then
			Date3=Date3-thisDays
		else
			if (Leap>0) then
				if (Leap>=i) then
					LMonth=i  Isleap=0
				else
					LMonth=i-1
					if i-Leap==1 then Isleap=1 else Isleap=0 end
				end
			else
				LMonth=i  Isleap=0
			end
			LDay=math.floor(Date3)
			break
		end
	end
	--print(LYear .. "-" .. LMonth .. "-" .. LDay)
	if Isleap>0 then LunarMonth="閏" .. cMonName[LMonth] else LunarMonth=cMonName[LMonth] end
	--print(LDay)
	LunarYear=cTianGan[math.fmod(LYear-4,10)+1] .. cDiZhi[math.fmod(LYear-4,12)+1] .. "年" .. LunarMonth .. cDayName[LDay]
	LunarYear_sx=cTianGan[math.fmod(LYear-4,10)+1] .. cDiZhi[math.fmod(LYear-4,12)+1] .. "年(" .. cShuXiang[math.fmod(LYear-4,12)+1] .. ")" .. LunarMonth .. cDayName[LDay]
	LY=cTianGan[math.fmod(LYear-4,10)+1] .. cDiZhi[math.fmod(LYear-4,12)+1] .. "年"
	LY_sx=cTianGan[math.fmod(LYear-4,10)+1] .. cDiZhi[math.fmod(LYear-4,12)+1] .. "年(" .. cShuXiang[math.fmod(LYear-4,12)+1] .. ")"
	LM=LunarMonth
	LD=cDayName[LDay]
	--print(LunarYear)
	return LunarYear, LunarYear_sx, LY, LY_sx, LM, LD
end

--Date日期參數格式YYMMDD，dayCount累加的天數
--返回值：公曆日期
local function GettotalDay(Date,dayCount)
	local Year,Month,Day,days,total,t
	Date=tostring(Date)
	Year=tonumber(Date.sub(Date,1,4))
	Month=tonumber(Date.sub(Date,5,6))
	Day=tonumber(Date.sub(Date,7,8))
	if IsLeap(Year)>365 then days={31,29,31,30,31,30,31,31,30,31,30,31}
	else days={31,28,31,30,31,30,31,31,30,31,30,31} end
	if dayCount>days[Month]-Day then
		total=dayCount-days[Month]+Day Month=Month+1
		if Month>12 then Month=Month-12 Year=Year+1 end
		for i=Month,12+Month do
			if IsLeap(Year)>365 then days={31,29,31,30,31,30,31,31,30,31,30,31}
			else days={31,28,31,30,31,30,31,31,30,31,30,31} end
			if i>11 then t=i-12 else t=i end
			--print("<" ..i ..">" ..days[t+1] .. "-".. t+1)
			if (total>days[t+1]) then
				total=total-days[Month]
				Month=Month+1
				if Month>12 then Month=Month-12 Year=Year+1 end
				--print(Month .. "-" ..days[Month])
				--print(Year .. Month .. total)
			else
				break
			end
		end
	else
		total=Day+dayCount
	end
	--if string.len(Month)==1 then Month="0"..Month end
	--if string.len(total)==1 then total="0"..total end
	return Year .. "年" .. Month .. "月" .. total .. "日"
end

--農歷轉公曆
--農歷 Gregorian:數字格式 YYYYMMDD
--<返回值>公曆日期 格式YYYY年MM月DD日
--農歷日期月份為閏月需指定參數IsLeap為1，非閏月需指定參數IsLeap為0
local function LunarDate2Date(Gregorian,IsLeap)
	LunarData={"AB500D2","4BD0883",
		"4AE00DB","A5700D0","54D0581","D2600D8","D9500CC","655147D","56A00D5","9AD00CA","55D027A","4AE00D2",
		"A5B0682","A4D00DA","D2500CE","D25157E","B5500D6","56A00CC","ADA027B","95B00D3","49717C9","49B00DC",
		"A4B00D0","B4B0580","6A500D8","6D400CD","AB5147C","2B600D5","95700CA","52F027B","49700D2","6560682",
		"D4A00D9","EA500CE","6A9157E","5AD00D6","2B600CC","86E137C","92E00D3","C8D1783","C9500DB","D4A00D0",
		"D8A167F","B5500D7","56A00CD","A5B147D","25D00D5","92D00CA","D2B027A","A9500D2","B550781","6CA00D9",
		"B5500CE","535157F","4DA00D6","A5B00CB","457037C","52B00D4","A9A0883","E9500DA","6AA00D0","AEA0680",
		"AB500D7","4B600CD","AAE047D","A5700D5","52600CA","F260379","D9500D1","5B50782","56A00D9","96D00CE",
		"4DD057F","4AD00D7","A4D00CB","D4D047B","D2500D3","D550883","B5400DA","B6A00CF","95A1680","95B00D8",
		"49B00CD","A97047D","A4B00D5","B270ACA","6A500DC","6D400D1","AF40681","AB600D9","93700CE","4AF057F",
		"49700D7","64B00CC","74A037B","EA500D2","6B50883","5AC00DB","AB600CF","96D0580","92E00D8","C9600CD",
		"D95047C","D4A00D4","DA500C9","755027A","56A00D1","ABB0781","25D00DA","92D00CF","CAB057E","A9500D6",
		"B4A00CB","BAA047B","AD500D2","55D0983","4BA00DB","A5B00D0","5171680","52B00D8","A9300CD","795047D",
		"6AA00D4","AD500C9","5B5027A","4B600D2","96E0681","A4E00D9","D2600CE","EA6057E","D5300D5","5AA00CB",
		"76A037B","96D00D3","4AB0B83","4AD00DB","A4D00D0","D0B1680","D2500D7","D5200CC","DD4057C","B5A00D4",
		"56D00C9","55B027A","49B00D2","A570782","A4B00D9","AA500CE","B25157E","6D200D6","ADA00CA","4B6137B",
		"93700D3","49F08C9","49700DB","64B00D0","68A1680","EA500D7","6AA00CC","A6C147C","AAE00D4","92E00CA",
		"D2E0379","C9600D1","D550781","D4A00D9","DA400CD","5D5057E","56A00D6","A6C00CB","55D047B","52D00D3",
		"A9B0883","A9500DB","B4A00CF","B6A067F","AD500D7","55A00CD","ABA047C","A5A00D4","52B00CA","B27037A",
		"69300D1","7330781","6AA00D9","AD500CE","4B5157E","4B600D6","A5700CB","54E047C","D1600D2","E960882",
		"D5200DA","DAA00CF","6AA167F","56D00D7","4AE00CD","A9D047D","A2D00D4","D1500C9","F250279","D5200D1"
	}
	Gregorian=tostring(Gregorian)
	local Year,Month,Day,Pos,Data,MonthInfo,LeapInfo,Leap,Newyear,Sum,thisMonthInfo,GDate
	Year=tonumber(Gregorian.sub(Gregorian,1,4))  Month=tonumber(Gregorian.sub(Gregorian,5,6))
	Day=tonumber(Gregorian.sub(Gregorian,7,8))
	if (Year>2100 or Year<1900 or Month>12 or Month<1 or Day>30 or Day<1 or string.len(Gregorian)<8) then
		return "無效日期"
	end

	--獲取當年農歷數據
	Pos=(Year-1899)+1    Data=LunarData[Pos]
	--print(Data)
	--判斷公曆日期
	local tb1=Analyze(Data)
	MonthInfo=tb1[1]  LeapInfo=tb1[2]  Leap=tb1[3]  Newyear=tb1[4]
	--計算到當天到當年農歷新年的天數
	Sum=0

	if Leap>0 then    --有閏月
		thisMonthInfo=string.sub(MonthInfo,1,Leap) .. LeapInfo .. string.sub(MonthInfo,Leap+1)
		if (Leap~=Month and tonumber(IsLeap)==1) then
			return "該月不是閏月！"
		end
		if (Month<=Leap and tonumber(IsLeap)==0) then
			for i=1,Month-1 do Sum=Sum+29+string.sub(thisMonthInfo,i,i) end
		else
			for i=1,Month do Sum=Sum+29+string.sub(thisMonthInfo,i,i) end
		end
	else
		if (tonumber(IsLeap)==1) then
			return "該年沒有閏月！"
		end
		for i=1,Month-1 do
			thisMonthInfo=MonthInfo
			Sum=Sum+29+string.sub(thisMonthInfo,i,i)
		end
	end
	Sum=math.floor(Sum+Day-1)
	GDate=Year .. Newyear
	GDate=GettotalDay(GDate,Sum)

	return GDate
end


--[[
~~~~農歷節氣計算部分~~~~
--]]
--*******農歷節氣計算部分
--========角度變換===============
local rad = 180*3600/math.pi --每弧度的角秒數
local RAD = 180/math.pi      --每弧度的角度數
function int2(v) --取整數部分
	v=math.floor(v)
	if v<0 then return v+1
	else return v
	end
end

local function rad2mrad(v)   --對超過0-2PI的角度轉為0-2PI
	v=math.fmod(v ,2*math.pi)
	if v<0 then  return v+2*math.pi
	else return v
	end
end

local function rad2str(d,tim) --將弧度轉為字串
	---tim=0輸出格式示例: -23°59' 48.23"
	---tim=1輸出格式示例:  18h 29m 44.52s
	local s="+"
	local w1="°" w2="’"  w3="」"
	if d<0 then  d=-d  s='-'end
	if tim~= 0 then  d=d*12/math.pi w1="h " w2="m " w3="s "
	else     d=d*180/math.pi end
	local a=math.floor(d) d=(d-a)*60
	local b=math.floor(d) d=(d-b)*60
	local c=math.floor(d) d=(d-c)*100
	d=math.floor(d+0.5)
	if d>=100 then d=d-100 c=c+1 end
	if c>=60  then c=c-60  b=b+1 end
	if b>=60  then b=b-60  a=a+1 end
	a="   "+a b="0"+b c="0"+c d="0"+d
	local alen = string.len(a)
	local blen = string.len(b)
	local clen = string.len(c)
	local dlen = string.len(d)
	s = s .. string.sub(a, alen-3,alen)+w1
	s = s .. string.sub(b, blen-2,blen)+w2
	s = s .. string.sub(c, clen-2,clen)+"."
	s = s .. string.sub(d, dlen-2,dlen)+w3
	return s
end
--================日曆計算===============
local J2000=2451545 --2000年前儒略日數(2000-1-1 12:00:00格林威治平時)

local JDate={ --日期元件
Y=2000, M=1, D=1, h=12, m=0, s=0,
dts = { --世界時與原子時之差計算表
-4000, 108371.7,-13036.80,392.000, 0.0000, -500, 17201.0,  -627.82, 16.170,-0.3413,
 -150,  12200.6,  -346.41,  5.403,-0.1593,  150,  9113.8,  -328.13, -1.647, 0.0377,
  500,   5707.5,  -391.41,  0.915, 0.3145,  900,  2203.4,  -283.45, 13.034,-0.1778,
 1300,    490.1,   -57.35,  2.085,-0.0072, 1600,   120.0,    -9.81, -1.532, 0.1403,
 1700,     10.2,    -0.91,  0.510,-0.0370, 1800,    13.4,    -0.72,  0.202,-0.0193,
 1830,      7.8,    -1.81,  0.416,-0.0247, 1860,     8.3,    -0.13, -0.406, 0.0292,
 1880,     -5.4,     0.32, -0.183, 0.0173, 1900,    -2.3,     2.06,  0.169,-0.0135,
 1920,     21.2,     1.69, -0.304, 0.0167, 1940,    24.2,     1.22, -0.064, 0.0031,
 1960,     33.2,     0.51,  0.231,-0.0109, 1980,    51.0,     1.29, -0.026, 0.0032,
 2000,     64.7,    -1.66,  5.224,-0.2905, 2150,   279.4,   732.95,429.579, 0.0158, 6000},
deltatT = function(JDate, y) --計算世界時與原子時之差,傳入年
	local  i
	local d=JDate.dts
	for x=1,100, 5 do
		if y<d[x+5] or x==96 then  i=x break end
	end

	local t1=(y-d[i])/(d[i+5]-d[i])*10
	local t2=t1*t1
	local t3=t2*t1
	return d[i+1] +d[i+2]*t1 +d[i+3]*t2 +d[i+4]*t3
end,
deltatT2 = function(JDate,jd) --傳入儒略日(J2000起算),計算UTC與原子時的差(單位:日)
	return JDate:deltatT(jd/365.2425+2000)/86400.0
end,
toJD = function(JDate, UTC) --公曆轉儒略日,UTC=1表示原日期是UTC
	local  y=JDate.Y m=JDate.M n=0 --取出年月
	if m<=2 then  m=m+12 y=y-1 end
	if JDate.Y*372+JDate.M*31+JDate.D>=588829 then --判斷是否為格里高利歷日1582*372+10*31+15
		n =int2(y/100) n =2-n+int2(n/4)--加百年閏
	end
	n = n + int2(365.2500001*(y+4716))    --加上年引起的偏移日數
	n = n + int2(30.6*(m+1))+JDate.D       --加上月引起的偏移日數及日偏移數
	n = n + ((JDate.s/60+JDate.m)/60+JDate.h)/24 - 1524.5
	if(UTC == 1) then return n+JDate.deltatT2(n-J2000) end
	return n
end,
setFromJD = function(JDate, jd,UTC) --儒略日數轉公曆,UTC=1表示目標公曆是UTC
	if UTC==1 then  jd= jd - JDate:deltatT2(jd-J2000) end
	jd =jd+0.5
	local A=int2(jd) F=jd-A, D  --取得日數的整數部份A及小數部分F
	if A>2299161 then  D=int2((A-1867216.25)/36524.25) A=A+1+D-int2(D/4) end
	A = A + 1524 --向前移4年零2個月
	JDate.Y =int2((A-122.1)/365.25)--年
	D =A-int2(365.25*JDate.Y) --去除整年日數後余下日數
	JDate.M =int2(D/30.6001)       --月數
	JDate.D =D-int2(JDate.M*30.6001)--去除整月日數後余下日數
	JDate.Y=JDate.Y-4716 JDate.M=JDate.M-1
	if JDate.M>12 then  JDate.M=JDate.M - 12 end
	if JDate.M<=2 then  JDate.Y = JDate.Y+1 end
	--日的小數轉為時分秒
	F=F*24 JDate.h=int2(F) F=F - JDate.h
	F=F*60 JDate.m=int2(F) F=F - JDate.m
	F=F*60 JDate.s=F
end,

setFromStr = function(JDate, s) --設置時間,參數例:"20000101 120000"或"20000101"
	JDate.Y=string.sub(s, 1,4)    JDate.M=string.sub(s, 5, 6)  JDate.D=string.sub(s,7, 8)
	JDate.h=string.sub(s, 10, 11) JDate.m=string.sub(s, 12,13) JDate.s=string.sub(s, 14,18)
end,
toStr = function(JDate) --日期轉為串
	local Y="     " .. JDate.Y
	local M="0" .. JDate.M
	local D="0" .. JDate.D
	local h=JDate.h
	local m=JDate.m
	local s=math.floor(JDate.s+.5)
	if s>=60 then s=s-60 m=m+1 end
	if m>=60 then m=m-60 h=h+1 end
	h="0".. h m="0" .. m s="0" .. s
	local Ylen = string.len(Y)
	local Mlen = string.len(M)
	local Dlen = string.len(D)
	local hlen = string.len(h)
	local mlen = string.len(m)
	local slen = string.len(s)
	Y=string.sub(Y, Ylen -4,Ylen) M=string.sub(M, Mlen-1,Mlen) D=string.sub(D,Dlen-1, Dlen)
	h=string.sub(h, hlen-1, hlen) m=string.sub(m, mlen-1,mlen) s=string.sub(s, slen-1,slen)
	return Y .. "-" .. M .. "-" .. D .. " " .. h .. ":" .. m .. ":" .. s
end,

JQ = function(JDate) --輸出節氣日期的秒數
	local t = {}
	t.year=JDate.Y
	t.month=JDate.M
	t.day=JDate.D
	t.hour=JDate.h
	t.min=JDate.m
	t.sec=math.floor(JDate.s+.5)
	if t.sec>=60 then t.sec=t.sec-60 t.min=t.min+1 end
	if t.min>=60 then t.min=t.min-60 t.hour=t.hour+1 end
	return os.time(t)
end,

Dint_dec = function(JDate, jd,shiqu,int_dec) --算出:jd轉到當地UTC後,UTC日數的整數部分或小數部分
	--基於J2000力學時jd的起算點是12:00:00時,所以跳日時刻發生在12:00:00,這與日曆計算發生矛盾
	--把jd改正為00:00:00起算,這樣儒略日的跳日動作就與日期的跳日同步
	--改正方法為jd=jd+0.5-deltatT+shiqu/24
	--把儒略日的起點移動-0.5(即前移12小時)
	--式中shiqu是時區,北京的起算點是-8小時,shiqu取8
	local u=jd+0.5-JDate.deltatT2(jd)+shiqu/24
	if int_dec~= 0 then  return math.floor(u) --返回整數部分
	else return u-math.floor(u)      --返回小數部分
	end
end,

d1_d2 = function(JDate, d1,d2) --計算兩個日期的相差的天數,輸入字串格式日期,如:"20080101"
	local Y=JDate.Y M=JDate.M D=JDate.D h=JDate.h m=JDate.m s=JDate.s --備份原來的數據
	JDate.setFromStr(string.sub(d1,1,8)+" 120000")    local jd1=JDate.toJD(0)
	JDate.setFromStr(string.sub(d2,1,8)+" 120000")    local jd2=JDate.toJD(0)

	JDate.Y=Y JDate.M=M JDate.D=D JDate.h=h JDate.m=m JDate.s=s --還原
	if jd1>jd2 then  return  math.floor(jd1-jd2+.0001)
	else        return -Math.floor(jd2-jd1+.0001)
	end
end,
}
--=========黃赤交角及黃赤坐標變換===========
local hcjjB = {84381.448, -46.8150, -0.00059, 0.001813}--黃赤交角系數表
local preceB= {0,50287.92262,111.24406,0.07699,-0.23479,-0.00178,0.00018,0.00001}--Date黃道上的歲差p

local function hcjj1 (t) --返回黃赤交角(常規精度),短期精度很高
	local t1=t/36525 t2=t1*t1  t3=t2*t1
	return (hcjjB[1] +hcjjB[2]*t1 +hcjjB[3]*t2 +hcjjB[4]*t3)/rad
end

local function HCconv(JW,E) --黃赤轉換(黃赤坐標旋轉)
	--黃道赤道坐標變換,赤到黃E取負
	local HJ=rad2mrad(JW[1])  HW=JW[2]
	local sinE =math.sin(E) cosE =math.cos(E)
	local sinW=cosE*math.sin(HW)+sinE*math.cos(HW)*math.sin(HJ)
	local J=math.atan2( math.sin(HJ)*cosE-math.tan(HW)*sinE, math.cos(HJ) )
	JW[1]=rad2mrad(J)
	JW[2]=math.asin(sinW)
end

local function addPrece(jd,zb) --補歲差
	local i t=1 v=0  t1=jd/365250
	for i=2,8 do t=t*t1 v=v+preceB[i]*t end
	zb[1]=rad2mrad(zb[1]+(v+2.9965*t1)/rad)
end

--===============光行差==================
local GXC_e={0.016708634, -0.000042037,-0.0000001267} --離心率
local GXC_p={102.93735/RAD,1.71946/RAD, 0.00046/RAD}  --近點
local GXC_l={280.4664567/RAD,36000.76982779/RAD,0.0003032028/RAD,1/49931000/RAD,-1/153000000/RAD} --太平黃經
local GXC_k=20.49552/rad --光行差常數
function addGxc(t,zb)--恆星週年光行差計算(黃道坐標中)
	local t1=t/36525
	local t2=t1*t1
	local t3=t2*t1
	local t4=t3*t1
	local L=GXC_l[1] +GXC_l[2]*t1 +GXC_l[3]*t2 +GXC_l[4]*t3 +GXC_l[5]*t4
	local p=GXC_p[1] +GXC_p[2]*t1 +GXC_p[3]*t2
	local e=GXC_e[1] +GXC_e[2]*t1 +GXC_e[3]*t2
	local dL=L-zb[1]
	local dP=p-zb[1]
	zb[1]=zb[1] - (GXC_k * (math.cos(dL)-e*math.cos(dP)) / math.cos(zb[2]))
	zb[2]=zb[2] - (GXC_k * math.sin(zb[2]) * (math.sin(dL)-e*math.sin(dP)))
	--print('aa', L,p,e,dL,dP,zb[1], zb[2])
	zb[1]=rad2mrad(zb[1])
end

--===============章動計算==================
local nutB={--章動表
2.1824391966,   -33.757045954, 0.0000362262, 3.7340E-08,-2.8793E-10,-171996,-1742,92025, 89,
3.5069406862,  1256.663930738, 0.0000105845, 6.9813E-10,-2.2815E-10, -13187,  -16, 5736,-31,
1.3375032491, 16799.418221925,-0.0000511866, 6.4626E-08,-5.3543E-10,  -2274,   -2,  977, -5,
4.3648783932,   -67.514091907, 0.0000724525, 7.4681E-08,-5.7586E-10,   2062,    2, -895,  5,
0.0431251803,  -628.301955171, 0.0000026820, 6.5935E-10, 5.5705E-11,  -1426,   34,   54, -1,
2.3555557435,  8328.691425719, 0.0001545547, 2.5033E-07,-1.1863E-09,    712,    1,   -7,  0,
3.4638155059,  1884.965885909, 0.0000079025, 3.8785E-11,-2.8386E-10,   -517,   12,  224, -6,
5.4382493597, 16833.175267879,-0.0000874129, 2.7285E-08,-2.4750E-10,   -386,   -4,  200,  0,
3.6930589926, 25128.109647645, 0.0001033681, 3.1496E-07,-1.7218E-09,   -301,    0,  129, -1,
3.5500658664,   628.361975567, 0.0000132664, 1.3575E-09,-1.7245E-10,    217,   -5,  -95,  3}

local function nutation(t) --計算黃經章動及交角章動
	local d={}
	d.Lon=0  d.Obl=0  t=t/36525
	local i,c
	local t1=t
	local t2=t1*t1
	local t3=t2*t1
	local t4=t3*t1
	local t5=t4*t1
	for i=1,#nutB,9 do
		c=nutB[i] +nutB[i+1]*t1 +nutB[i+2]*t2 +nutB[i+3]*t3 +nutB[i+4]*t4
		d.Lon=d.Lon + (nutB[i+5]+nutB[i+6]*t/10)*math.sin(c) --黃經章動
		d.Obl=d.Obl + (nutB[i+7]+nutB[i+8]*t/10)*math.cos(c) --交角章動
	end
	d.Lon=d.Lon/(rad*10000) --黃經章動
	d.Obl=d.Obl/(rad*10000) --交角章動
	return d
end

local function nutationRaDec(t,zb) --本函數計算赤經章動及赤緯章動
	local Ra=zb[1]
	local Dec=zb[2]
	local E=hcjj1(t)
	local sinE=math.sin(E)
	local cosE=math.cos(E) --計算黃赤交角
	local d=nutation(t)  --計算黃經章動及交角章動
	local cosRa=math.cos(Ra)
	local sinRa=math.sin(Ra)
	local tanDec=math.tan(Dec)
	zb[1]=zb[1] + (cosE+sinE*sinRa*tanDec)*d.Lon-cosRa*tanDec*d.Obl --赤經章動
	zb[2]= zb[2] + sinE*cosRa*d.Lon+sinRa*d.Obl   --赤緯章動
	zb[1]=rad2mrad(zb[1])
end

--=================以下是月球及地球運動參數表===================
--[[***************************************
* 如果用記事本查看此代碼,請在"格式"菜單中去除"自動換行"
* E10是關於地球的,格式如下:
*    它是一個數組,每3個數看作一條記錄,每條記錄的3個數記為A,B,C
*    rec=A*cos(B+C*t)  式中t是J2000起算的儒略千年數
*    每條記錄的計算結果(即rec)取和即得地球的日心黃經的週期量L0
* E11格式如下: rec = A*cos*(B+C*t) *t,     取和後得泊松量L1
* E12格式如下: rec = A*cos*(B+C*t) *t*t,   取和後得泊松量L2
* E13格式如下: rec = A*cos*(B+C*t) *t*t*t, 取和後得泊松量L3
* 最後地球的地心黃經:L = L0+L1+L2+L3+...
* E20,E21,E22,E23...用於計算黃緯
* M10,M11等是關於月球的,參數的用法請閱讀Mnn()函數
***************************************** --]]
--地球運動VSOP87參數
local E10={ --黃經週期項
1.75347045673, 0.00000000000,     0.0000000000,  0.03341656456, 4.66925680417,  6283.0758499914,  0.00034894275, 4.62610241759, 12566.1516999828,  0.00003417571, 2.82886579606,     3.5231183490,
0.00003497056, 2.74411800971,  5753.3848848968,  0.00003135896, 3.62767041758, 77713.7714681205,  0.00002676218, 4.41808351397,  7860.4193924392,  0.00002342687, 6.13516237631,  3930.2096962196,
0.00001273166, 2.03709655772,   529.6909650946,  0.00001324292, 0.74246356352, 11506.7697697936,  0.00000901855, 2.04505443513,    26.2983197998,  0.00001199167, 1.10962944315,  1577.3435424478,
0.00000857223, 3.50849156957,   398.1490034082,  0.00000779786, 1.17882652114,  5223.6939198022,  0.00000990250, 5.23268129594,  5884.9268465832,  0.00000753141, 2.53339053818,  5507.5532386674,
0.00000505264, 4.58292563052, 18849.2275499742,  0.00000492379, 4.20506639861,   775.5226113240,  0.00000356655, 2.91954116867,     0.0673103028,  0.00000284125, 1.89869034186,   796.2980068164,
0.00000242810, 0.34481140906,  5486.7778431750,  0.00000317087, 5.84901952218, 11790.6290886588,  0.00000271039, 0.31488607649, 10977.0788046990,  0.00000206160, 4.80646606059,  2544.3144198834,
0.00000205385, 1.86947813692,  5573.1428014331,  0.00000202261, 2.45767795458,  6069.7767545534,  0.00000126184, 1.08302630210,    20.7753954924,  0.00000155516, 0.83306073807,   213.2990954380,
0.00000115132, 0.64544911683,     0.9803210682,  0.00000102851, 0.63599846727,  4694.0029547076,  0.00000101724, 4.26679821365,     7.1135470008,  0.00000099206, 6.20992940258,  2146.1654164752,
0.00000132212, 3.41118275555,  2942.4634232916,  0.00000097607, 0.68101272270,   155.4203994342,  0.00000085128, 1.29870743025,  6275.9623029906,  0.00000074651, 1.75508916159,  5088.6288397668,
0.00000101895, 0.97569221824, 15720.8387848784,  0.00000084711, 3.67080093025, 71430.6956181291,  0.00000073547, 4.67926565481,   801.8209311238,  0.00000073874, 3.50319443167,  3154.6870848956,
0.00000078756, 3.03698313141, 12036.4607348882,  0.00000079637, 1.80791330700, 17260.1546546904,  0.00000085803, 5.98322631256,161000.6857376741,  0.00000056963, 2.78430398043,  6286.5989683404,
0.00000061148, 1.81839811024,  7084.8967811152,  0.00000069627, 0.83297596966,  9437.7629348870,  0.00000056116, 4.38694880779, 14143.4952424306,  0.00000062449, 3.97763880587,  8827.3902698748,
0.00000051145, 0.28306864501,  5856.4776591154,  0.00000055577, 3.47006009062,  6279.5527316424,  0.00000041036, 5.36817351402,  8429.2412664666,  0.00000051605, 1.33282746983,  1748.0164130670,
0.00000051992, 0.18914945834, 12139.5535091068,  0.00000049000, 0.48735065033,  1194.4470102246,  0.00000039200, 6.16832995016, 10447.3878396044,  0.00000035566, 1.77597314691,  6812.7668150860,
0.00000036770, 6.04133859347, 10213.2855462110,  0.00000036596, 2.56955238628,  1059.3819301892,  0.00000033291, 0.59309499459, 17789.8456197850,  0.00000035954, 1.70876111898,  2352.8661537718}
local E11={ --黃經泊松1項
6283.31966747491,0.00000000000,     0.0000000000,  0.00206058863, 2.67823455584,  6283.0758499914,  0.00004303430, 2.63512650414, 12566.1516999828,  0.00000425264, 1.59046980729,     3.5231183490,
0.00000108977, 2.96618001993,  1577.3435424478,  0.00000093478, 2.59212835365, 18849.2275499742,  0.00000119261, 5.79557487799,    26.2983197998,  0.00000072122, 1.13846158196,   529.6909650946,
0.00000067768, 1.87472304791,   398.1490034082,  0.00000067327, 4.40918235168,  5507.5532386674,  0.00000059027, 2.88797038460,  5223.6939198022,  0.00000055976, 2.17471680261,   155.4203994342,
0.00000045407, 0.39803079805,   796.2980068164,  0.00000036369, 0.46624739835,   775.5226113240,  0.00000028958, 2.64707383882,     7.1135470008,  0.00000019097, 1.84628332577,  5486.7778431750,
0.00000020844, 5.34138275149,     0.9803210682,  0.00000018508, 4.96855124577,   213.2990954380,  0.00000016233, 0.03216483047,  2544.3144198834,  0.00000017293, 2.99116864949,  6275.9623029906}
local E12={ --黃經泊松2項
0.00052918870, 0.00000000000,     0.0000000000,  0.00008719837, 1.07209665242,  6283.0758499914,  0.00000309125, 0.86728818832, 12566.1516999828,  0.00000027339, 0.05297871691,     3.5231183490,
0.00000016334, 5.18826691036,    26.2983197998,  0.00000015752, 3.68457889430,   155.4203994342,  0.00000009541, 0.75742297675, 18849.2275499742,  0.00000008937, 2.05705419118, 77713.7714681205,
0.00000006952, 0.82673305410,   775.5226113240,  0.00000005064, 4.66284525271,  1577.3435424478}
local E13={ 0.00000289226, 5.84384198723,  6283.0758499914,  0.00000034955, 0.00000000000,     0.0000000000, 0.00000016819, 5.48766912348, 12566.1516999828}
local E14={ 0.00000114084, 3.14159265359,     0.0000000000,  0.00000007717, 4.13446589358,  6283.0758499914, 0.00000000765, 3.83803776214, 12566.1516999828}
local E15={ 0.00000000878, 3.14159265359,     0.0000000000 }
local E20={ --黃緯週期項
0.00000279620, 3.19870156017, 84334.6615813083,  0.00000101643, 5.42248619256,  5507.5532386674,  0.00000080445, 3.88013204458,  5223.6939198022,  0.00000043806, 3.70444689758,  2352.8661537718,
0.00000031933, 4.00026369781,  1577.3435424478,  0.00000022724, 3.98473831560,  1047.7473117547,  0.00000016392, 3.56456119782,  5856.4776591154,  0.00000018141, 4.98367470263,  6283.0758499914,
0.00000014443, 3.70275614914,  9437.7629348870,  0.00000014304, 3.41117857525, 10213.2855462110}
local E21={ 0.00000009030, 3.89729061890,  5507.5532386674,  0.00000006177, 1.73038850355,  5223.6939198022}
local E30={ --距離週期項
1.00013988799, 0.00000000000,     0.0000000000,  0.01670699626, 3.09846350771,  6283.0758499914,  0.00013956023, 3.05524609620, 12566.1516999828,  0.00003083720, 5.19846674381, 77713.7714681205,
0.00001628461, 1.17387749012,  5753.3848848968,  0.00001575568, 2.84685245825,  7860.4193924392,  0.00000924799, 5.45292234084, 11506.7697697936,  0.00000542444, 4.56409149777,  3930.2096962196}
local E31={ 0.00103018608, 1.10748969588,  6283.0758499914,  0.00001721238, 1.06442301418, 12566.1516999828, 0.00000702215, 3.14159265359,     0.0000000000}
local E32={ 0.00004359385, 5.78455133738,  6283.0758499914 }
local E33={ 0.00000144595, 4.27319435148,  6283.0758499914 }
--月球運動參數
local M10={
    22639.5858800,  2.3555545723,  8328.6914247251, 1.5231275E-04, 2.5041111E-07,-1.1863391E-09, 4586.4383203,  8.0413790709,  7214.0628654588,-2.1850087E-04,-1.8646419E-07, 8.7760973E-10, 2369.9139357, 10.3969336431, 15542.7542901840,-6.6188121E-05, 6.3946925E-08,-3.0872935E-10,  769.0257187,  4.7111091445, 16657.3828494503, 3.0462550E-04, 5.0082223E-07,-2.3726782E-09,
    -666.4175399, -0.0431256817,   628.3019552485,-2.6638815E-06, 6.1639211E-10,-5.4439728E-11, -411.5957339,  3.2558104895, 16866.9323152810,-1.2804259E-04,-9.8998954E-09, 4.0433461E-11,  211.6555524,  5.6858244986, -1114.6285592663,-3.7081362E-04,-4.3687530E-07, 2.0639488E-09,  205.4359530,  8.0845047526,  6585.7609102104,-2.1583699E-04,-1.8708058E-07, 9.3204945E-10,
    191.9561973, 12.7524882154, 23871.4457149091, 8.6124629E-05, 3.1435804E-07,-1.4950684E-09,  164.7286185, 10.4400593249, 14914.4523349355,-6.3524240E-05, 6.3330532E-08,-2.5428962E-10, -147.3213842, -2.3986802540, -7700.3894694766,-1.5497663E-04,-2.4979472E-07, 1.1318993E-09, -124.9881185,  5.1984668216,  7771.3771450920,-3.3094061E-05, 3.1973462E-08,-1.5436468E-10,
    -109.3803637,  2.3124288905,  8956.9933799736, 1.4964887E-04, 2.5102751E-07,-1.2407788E-09,   55.1770578,  7.1411231536, -1324.1780250970, 6.1854469E-05, 7.3846820E-08,-3.4916281E-10,  -45.0996092,  5.6113650618, 25195.6237400061, 2.4270161E-05, 2.4051122E-07,-1.1459056E-09,   39.5333010, -0.9002559173, -8538.2408905558, 2.8035534E-04, 2.6031101E-07,-1.2267725E-09,
    38.4298346, 18.4383127140, 22756.8171556428,-2.8468899E-04,-1.2251727E-07, 5.6888037E-10,   36.1238141,  7.0666637168, 24986.0742741754, 4.5693825E-04, 7.5123334E-07,-3.5590172E-09,   30.7725751, 16.0827581417, 14428.1257309177,-4.3700174E-04,-3.7292838E-07, 1.7552195E-09,  -28.3971008,  7.9982533891,  7842.3648207073,-2.2116475E-04,-1.8584780E-07, 8.2317000E-10,
    -24.3582283, 10.3538079614, 16171.0562454324,-6.8852003E-05, 6.4563317E-08,-3.6316908E-10,  -18.5847068,  2.8429122493,  -557.3142796331,-1.8540681E-04,-2.1843765E-07, 1.0319744E-09,   17.9544674,  5.1553411398,  8399.6791003405,-3.5757942E-05, 3.2589854E-08,-2.0880440E-10,   14.5302779, 12.7956138971, 23243.1437596606, 8.8788511E-05, 3.1374165E-07,-1.4406287E-09,
    14.3796974, 15.1080427876, 32200.1371396342, 2.3843738E-04, 5.6476915E-07,-2.6814075E-09,   14.2514576,-24.0810366320,    -2.3011998397, 1.5231275E-04, 2.5041111E-07,-1.1863391E-09,   13.8990596, 20.7938672862, 31085.5085803679,-1.3237624E-04, 1.2789385E-07,-6.1745870E-10,   13.1940636,  3.3302699264, -9443.3199839914,-5.2312637E-04,-6.8728642E-07, 3.2502879E-09,
    -9.6790568, -4.7542348263,-16029.0808942018,-3.0728938E-04,-5.0020584E-07, 2.3182384E-09,   -9.3658635, 11.2971895604, 24080.9951807398,-3.4654346E-04,-1.9636409E-07, 9.1804319E-10,    8.6055318,  5.7289501804, -1742.9305145148,-3.6814974E-04,-4.3749170E-07, 2.1183885E-09,   -8.4530982,  7.5540213938, 16100.0685698171, 1.1921869E-04, 2.8238458E-07,-1.3407038E-09,
    8.0501724, 10.4831850066, 14286.1503796870,-6.0860358E-05, 6.2714140E-08,-1.9984990E-10,   -7.6301553,  4.6679834628, 17285.6848046987, 3.0196162E-04, 5.0143862E-07,-2.4271179E-09,   -7.4474952, -0.0862513635,  1256.6039104970,-5.3277630E-06, 1.2327842E-09,-1.0887946E-10,    7.3712011,  8.1276304344,  5957.4589549619,-2.1317311E-04,-1.8769697E-07, 9.8648918E-10,
    7.0629900,  0.9591375719,    33.7570471374,-3.0829302E-05,-3.6967043E-08, 1.7385419E-10,   -6.3831491,  9.4966777258,  7004.5133996281, 2.1416722E-04, 3.2425793E-07,-1.5355019E-09,   -5.7416071, 13.6527441326, 32409.6866054649,-1.9423071E-04, 5.4047029E-08,-2.6829589E-10,    4.3740095, 18.4814383957, 22128.5152003943,-2.8202511E-04,-1.2313366E-07, 6.2332010E-10,
    -3.9976134,  7.9669196340, 33524.3151647312, 1.7658291E-04, 4.9092233E-07,-2.3322447E-09,   -3.2096876, 13.2398458924, 14985.4400105508,-2.5159493E-04,-1.5449073E-07, 7.2324505E-10,   -2.9145404, 12.7093625336, 24499.7476701576, 8.3460748E-05, 3.1497443E-07,-1.5495082E-09,    2.7318890, 16.1258838235, 13799.8237756692,-4.3433786E-04,-3.7354477E-07, 1.8096592E-09,
    -2.5679459, -2.4418059357, -7072.0875142282,-1.5764051E-04,-2.4917833E-07, 1.0774596E-09,   -2.5211990,  7.9551277074,  8470.6667759558,-2.2382863E-04,-1.8523141E-07, 7.6873027E-10,    2.4888871,  5.6426988169,  -486.3266040178,-3.7347750E-04,-4.3625891E-07, 2.0095091E-09,    2.1460741,  7.1842488353, -1952.4799803455, 6.4518350E-05, 7.3230428E-08,-2.9472308E-10,
    1.9777270, 23.1494218585, 39414.2000050930, 1.9936508E-05, 3.7830496E-07,-1.8037978E-09,    1.9336825,  9.4222182890, 33314.7656989005, 6.0925100E-04, 1.0016445E-06,-4.7453563E-09,    1.8707647, 20.8369929680, 30457.2066251194,-1.2971236E-04, 1.2727746E-07,-5.6301898E-10,   -1.7529659,  0.4873576771, -8886.0057043583,-3.3771956E-04,-4.6884877E-07, 2.2183135E-09,
    -1.4371624,  7.0979974718,  -695.8760698485, 5.9190587E-05, 7.4463212E-08,-4.0360254E-10,   -1.3725701,  1.4552986550,  -209.5494658307, 4.3266809E-04, 5.1072212E-07,-2.4131116E-09,    1.2618162,  7.5108957121, 16728.3705250656, 1.1655481E-04, 2.8300097E-07,-1.3951435E-09
}
local M11={
    1.6768000, -0.0431256817,   628.3019552485,-2.6638815E-06, 6.1639211E-10,-5.4439728E-11,    0.5164200, 11.2260974062,  6585.7609102104,-2.1583699E-04,-1.8708058E-07, 9.3204945E-10,    0.4138300, 13.5816519784, 14914.4523349355,-6.3524240E-05, 6.3330532E-08,-2.5428962E-10,    0.3711500,  5.5402729076,  7700.3894694766, 1.5497663E-04, 2.4979472E-07,-1.1318993E-09,
    0.2756000,  2.3124288905,  8956.9933799736, 1.4964887E-04, 2.5102751E-07,-1.2407788E-09,    0.2459863,-25.6198212459,    -2.3011998397, 1.5231275E-04, 2.5041111E-07,-1.1863391E-09,    0.0711800,  7.9982533891,  7842.3648207073,-2.2116475E-04,-1.8584780E-07, 8.2317000E-10,    0.0612800, 10.3538079614, 16171.0562454324,-6.8852003E-05, 6.4563317E-08,-3.6316908E-10
}
local M12={ 0.0048700, -0.0431256817,   628.3019552485,-2.6638815E-06, 6.1639211E-10,-5.4439728E-11,  0.0022800,-27.1705318325,	-2.3011998397, 1.5231275E-04, 2.5041111E-07,-1.1863391E-09,  0.0015000, 11.2260974062,  6585.7609102104,-2.1583699E-04,-1.8708058E-07, 9.3204945E-10
}
local M20={
    18461.2400600,  1.6279052448,  8433.4661576405,-6.4021295E-05,-4.9499477E-09, 2.0216731E-11, 1010.1671484,  3.9834598170, 16762.1575823656, 8.8291456E-05, 2.4546117E-07,-1.1661223E-09,  999.6936555,  0.7276493275,  -104.7747329154, 2.1633405E-04, 2.5536106E-07,-1.2065558E-09,  623.6524746,  8.7690283983,  7109.2881325435,-2.1668263E-06, 6.8896872E-08,-3.2894608E-10,
    199.4837596,  9.6692843156, 15647.5290230993,-2.8252217E-04,-1.9141414E-07, 8.9782646E-10,  166.5741153,  6.4134738261, -1219.4032921817,-1.5447958E-04,-1.8151424E-07, 8.5739300E-10,  117.2606951, 12.0248388879, 23976.2204478244,-1.3020942E-04, 5.8996977E-08,-2.8851262E-10,   61.9119504,  6.3390143893, 25090.8490070907, 2.4060421E-04, 4.9587228E-07,-2.3524614E-09,
    33.3572027, 11.1245829706, 15437.9795572686, 1.5014592E-04, 3.1930799E-07,-1.5152852E-09,   31.7596709,  3.0832038997,  8223.9166918098, 3.6864680E-04, 5.0577218E-07,-2.3928949E-09,   29.5766003,  8.8121540801,  6480.9861772950, 4.9705523E-07, 6.8280480E-08,-2.7450635E-10,   15.5662654,  4.0579192538, -9548.0947169068,-3.0679233E-04,-4.3192536E-07, 2.0437321E-09,
    15.1215543, 14.3803934601, 32304.9118725496, 2.2103334E-05, 3.0940809E-07,-1.4748517E-09,  -12.0941511,  8.7259027166,  7737.5900877920,-4.8307078E-06, 6.9513264E-08,-3.8338581E-10,    8.8681426,  9.7124099974, 15019.2270678508,-2.7985829E-04,-1.9203053E-07, 9.5226618E-10,    8.0450400,  0.6687636586,  8399.7091105030,-3.3191993E-05, 3.2017096E-08,-1.5363746E-10,
    7.9585542, 12.0679645696, 23347.9184925760,-1.2754553E-04, 5.8380585E-08,-2.3407289E-10,    7.4345550,  6.4565995078, -1847.7052474301,-1.5181570E-04,-1.8213063E-07, 9.1183272E-10,   -6.7314363, -4.0265854988,-16133.8556271171,-9.0955337E-05,-2.4484477E-07, 1.1116826E-09,    6.5795750, 16.8104074692, 14323.3509980023,-2.2066770E-04,-1.1756732E-07, 5.4866364E-10,
    -6.4600721,  1.5847795630,  9061.7681128890,-6.6685176E-05,-4.3335556E-09,-3.4222998E-11,   -6.2964773,  4.8837157343, 25300.3984729215,-1.9206388E-04,-1.4849843E-08, 6.0650192E-11,   -5.6323538, -0.7707750092,   733.0766881638,-2.1899793E-04,-2.5474467E-07, 1.1521161E-09,   -5.3683961,  6.8263720663, 16204.8433027325,-9.7115356E-05, 2.7023515E-08,-1.3414795E-10,
    -5.3112784,  3.9403341353, 17390.4595376141, 8.5627574E-05, 2.4607756E-07,-1.2205621E-09,   -5.0759179,  0.6845236457,   523.5272223331, 2.1367016E-04, 2.5597745E-07,-1.2609955E-09,   -4.8396143, -1.6710309265, -7805.1642023920, 6.1357413E-05, 5.5663398E-09,-7.4656459E-11,   -4.8057401,  3.5705615768,  -662.0890125485, 3.0927234E-05, 3.6923410E-08,-1.7458141E-10,
    3.9840545,  8.6945689615, 33419.5404318159, 3.9291696E-04, 7.4628340E-07,-3.5388005E-09,    3.6744619, 19.1659620415, 22652.0424227274,-6.8354947E-05, 1.3284380E-07,-6.3767543E-10,    2.9984815, 20.0662179587, 31190.2833132833,-3.4871029E-04,-1.2746721E-07, 5.8909710E-10,    2.7986413, -2.5281611620,-16971.7070481963, 3.4437664E-04, 2.6526096E-07,-1.2469893E-09,
    2.4138774, 17.7106633865, 22861.5918885581,-5.0102304E-04,-3.7787833E-07, 1.7754362E-09,    2.1863132,  5.5132179088, -9757.6441827375, 1.2587576E-04, 7.8796768E-08,-3.6937954E-10,    2.1461692, 13.4801375428, 23766.6709819937, 3.0245868E-04, 5.6971910E-07,-2.7016242E-09,    1.7659832, 11.1677086523, 14809.6776020201, 1.5280981E-04, 3.1869159E-07,-1.4608454E-09,
    -1.6244212,  7.3137297434,  7318.8375983742,-4.3483492E-04,-4.4182525E-07, 2.0841655E-09,    1.5813036,  5.4387584720, 16552.6081165349, 5.2095955E-04, 7.5618329E-07,-3.5792340E-09,    1.5197528, 16.7359480324, 40633.6032972747, 1.7441609E-04, 5.5981921E-07,-2.6611908E-09,    1.5156341,  1.7023646816,-17876.7861416319,-4.5910508E-04,-6.8233647E-07, 3.2300712E-09,
    1.5102092,  5.4977296450,  8399.6847301375,-3.3094061E-05, 3.1973462E-08,-1.5436468E-10,   -1.3178223,  9.6261586339, 16275.8309783478,-2.8518605E-04,-1.9079775E-07, 8.4338673E-10,   -1.2642739, 11.9817132061, 24604.5224030729,-1.3287330E-04, 5.9613369E-08,-3.4295235E-10,    1.1918723, 22.4217725310, 39518.9747380084,-1.9639754E-04, 1.2294390E-07,-5.9724197E-10,
    1.1346110, 14.4235191419, 31676.6099173011, 2.4767216E-05, 3.0879170E-07,-1.4204120E-09,    1.0857810,  8.8552797618,  5852.6842220465, 3.1609367E-06, 6.7664088E-08,-2.2006663E-10,   -1.0193852,  7.2392703065, 33629.0898976466,-3.9751134E-05, 2.3556127E-07,-1.1256889E-09,   -0.8227141, 11.0814572888, 16066.2815125171, 1.4748204E-04, 3.1992438E-07,-1.5697249E-09,
    0.8042238,  3.5274358950,   -33.7870573000, 2.8263353E-05, 3.7539802E-08,-2.2902113E-10,    0.8025939,  6.7832463846, 16833.1452579809,-9.9779237E-05, 2.7639907E-08,-1.8858767E-10,   -0.7931866, -6.3821400710,-24462.5470518423,-2.4326809E-04,-4.9525589E-07, 2.2980217E-09,   -0.7910153,  6.3703481443,  -591.1013369332,-1.5714346E-04,-1.8089785E-07, 8.0295327E-10,
    -0.6674056,  9.1819266386, 24533.5347274576, 5.5197395E-05, 2.7743463E-07,-1.3204870E-09,    0.6502226,  4.1010449356,-10176.3966721553,-3.0412845E-04,-4.3254175E-07, 2.0981718E-09,   -0.6388131,  6.2958887075, 25719.1509623392, 2.3794032E-04, 4.9648867E-07,-2.4069012E-09
}
local M21={
    0.0743000, 11.9537467337,  6480.9861772950, 4.9705523E-07, 6.8280480E-08,-2.7450635E-10,    0.0304300,  8.7259027166,  7737.5900877920,-4.8307078E-06, 6.9513264E-08,-3.8338581E-10,    0.0222900, 12.8540026510, 15019.2270678508,-2.7985829E-04,-1.9203053E-07, 9.5226618E-10,    0.0199900, 15.2095572232, 23347.9184925760,-1.2754553E-04, 5.8380585E-08,-2.3407289E-10,
    0.0186900,  9.5981921614, -1847.7052474301,-1.5181570E-04,-1.8213063E-07, 9.1183272E-10,    0.0169600,  7.1681781524, 16133.8556271171, 9.0955337E-05, 2.4484477E-07,-1.1116826E-09,    0.0162300,  1.5847795630,  9061.7681128890,-6.6685176E-05,-4.3335556E-09,-3.4222998E-11,    0.0141900, -0.7707750092,   733.0766881638,-2.1899793E-04,-2.5474467E-07, 1.1521161E-09
}
local M30={
    385000.5290396,  1.5707963268,     0.0000000000, 0.0000000E+00, 0.0000000E+00, 0.0000000E+00,-20905.3551378, 3.9263508990,  8328.6914247251, 1.5231275E-04, 2.5041111E-07,-1.1863391E-09,-3699.1109330,  9.6121753977,  7214.0628654588,-2.1850087E-04,-1.8646419E-07, 8.7760973E-10,-2955.9675626, 11.9677299699, 15542.7542901840,-6.6188121E-05, 6.3946925E-08,-3.0872935E-10,
    -569.9251264,  6.2819054713, 16657.3828494503, 3.0462550E-04, 5.0082223E-07,-2.3726782E-09,  246.1584797,  7.2566208254, -1114.6285592663,-3.7081362E-04,-4.3687530E-07, 2.0639488E-09, -204.5861179, 12.0108556517, 14914.4523349355,-6.3524240E-05, 6.3330532E-08,-2.5428962E-10, -170.7330791, 14.3232845422, 23871.4457149091, 8.6124629E-05, 3.1435804E-07,-1.4950684E-09,
    -152.1378118,  9.6553010794,  6585.7609102104,-2.1583699E-04,-1.8708058E-07, 9.3204945E-10, -129.6202242, -0.8278839272, -7700.3894694766,-1.5497663E-04,-2.4979472E-07, 1.1318993E-09,  108.7427014,  6.7692631483,  7771.3771450920,-3.3094061E-05, 3.1973462E-08,-1.5436468E-10,  104.7552944,  3.8832252173,  8956.9933799736, 1.4964887E-04, 2.5102751E-07,-1.2407788E-09,
    79.6605685,  0.6705404095, -8538.2408905558, 2.8035534E-04, 2.6031101E-07,-1.2267725E-09,   48.8883284,  1.5276706450,   628.3019552485,-2.6638815E-06, 6.1639211E-10,-5.4439728E-11,  -34.7825237, 20.0091090408, 22756.8171556428,-2.8468899E-04,-1.2251727E-07, 5.6888037E-10,   30.8238599, 11.9246042882, 16171.0562454324,-6.8852003E-05, 6.4563317E-08,-3.6316908E-10,
    24.2084985,  9.5690497159,  7842.3648207073,-2.2116475E-04,-1.8584780E-07, 8.2317000E-10,  -23.2104305,  8.6374600436, 24986.0742741754, 4.5693825E-04, 7.5123334E-07,-3.5590172E-09,  -21.6363439, 17.6535544685, 14428.1257309177,-4.3700174E-04,-3.7292838E-07, 1.7552195E-09,  -16.6747239,  6.7261374666,  8399.6791003405,-3.5757942E-05, 3.2589854E-08,-2.0880440E-10,
    14.4026890,  4.9010662531, -9443.3199839914,-5.2312637E-04,-6.8728642E-07, 3.2502879E-09,  -12.8314035, 14.3664102239, 23243.1437596606, 8.8788511E-05, 3.1374165E-07,-1.4406287E-09,  -11.6499478, 22.3646636130, 31085.5085803679,-1.3237624E-04, 1.2789385E-07,-6.1745870E-10,  -10.4447578, 16.6788391144, 32200.1371396342, 2.3843738E-04, 5.6476915E-07,-2.6814075E-09,
    10.3211071,  8.7119194804, -1324.1780250970, 6.1854469E-05, 7.3846820E-08,-3.4916281E-10,   10.0562033,  7.2997465071, -1742.9305145148,-3.6814974E-04,-4.3749170E-07, 2.1183885E-09,   -9.8844667, 12.0539813334, 14286.1503796870,-6.0860358E-05, 6.2714140E-08,-1.9984990E-10,    8.7515625,  6.3563649081, -9652.8694498221,-9.0458282E-05,-1.7656429E-07, 8.3717626E-10,
    -8.3791067,  4.4137085761,  -557.3142796331,-1.8540681E-04,-2.1843765E-07, 1.0319744E-09,   -7.0026961, -3.1834384995,-16029.0808942018,-3.0728938E-04,-5.0020584E-07, 2.3182384E-09,    6.3220032,  9.1248177206, 16100.0685698171, 1.1921869E-04, 2.8238458E-07,-1.3407038E-09,    5.7508579,  6.2387797896, 17285.6848046987, 3.0196162E-04, 5.0143862E-07,-2.4271179E-09,
    -4.9501349,  9.6984267611,  5957.4589549619,-2.1317311E-04,-1.8769697E-07, 9.8648918E-10,   -4.4211770,  3.0260949818,  -209.5494658307, 4.3266809E-04, 5.1072212E-07,-2.4131116E-09,    4.1311145, 11.0674740526,  7004.5133996281, 2.1416722E-04, 3.2425793E-07,-1.5355019E-09,   -3.9579827, 20.0522347225, 22128.5152003943,-2.8202511E-04,-1.2313366E-07, 6.2332010E-10,
    3.2582371, 14.8106422192, 14985.4400105508,-2.5159493E-04,-1.5449073E-07, 7.2324505E-10,   -3.1483020,  4.8266068163, 16866.9323152810,-1.2804259E-04,-9.8998954E-09, 4.0433461E-11,    2.6164092, 14.2801588604, 24499.7476701576, 8.3460748E-05, 3.1497443E-07,-1.5495082E-09,    2.3536310,  9.5259240342,  8470.6667759558,-2.2382863E-04,-1.8523141E-07, 7.6873027E-10,
    -2.1171283, -0.8710096090, -7072.0875142282,-1.5764051E-04,-2.4917833E-07, 1.0774596E-09,   -1.8970368, 17.6966801503, 13799.8237756692,-4.3433786E-04,-3.7354477E-07, 1.8096592E-09,   -1.7385258,  2.0581540038, -8886.0057043583,-3.3771956E-04,-4.6884877E-07, 2.2183135E-09,   -1.5713944, 22.4077892948, 30457.2066251194,-1.2971236E-04, 1.2727746E-07,-5.6301898E-10,
    -1.4225541, 24.7202181853, 39414.2000050930, 1.9936508E-05, 3.7830496E-07,-1.8037978E-09,   -1.4189284, 17.1661967915, 23314.1314352759,-9.9282182E-05, 9.5920387E-08,-4.6309403E-10,    1.1655364,  3.8400995356,  9585.2953352221, 1.4698499E-04, 2.5164390E-07,-1.2952185E-09,   -1.1169371, 10.9930146158, 33314.7656989005, 6.0925100E-04, 1.0016445E-06,-4.7453563E-09,
    1.0656723,  1.4845449633,  1256.6039104970,-5.3277630E-06, 1.2327842E-09,-1.0887946E-10,   1.0586190, 11.9220903668,  8364.7398411275,-2.1850087E-04,-1.8646419E-07, 8.7760973E-10,   -0.9333176,  9.0816920389, 16728.3705250656, 1.1655481E-04, 2.8300097E-07,-1.3951435E-09,    0.8624328, 12.4550876470,  6656.7485858257,-4.0390768E-04,-4.0490184E-07, 1.9095841E-09,
    0.8512404,  4.3705828944,  70.9876756153,-1.8807069E-04,-2.1782126E-07, 9.7753467E-10,   -0.8488018, 16.7219647962, 31571.8351843857, 2.4110126E-04, 5.6415276E-07,-2.6269678E-09,   -0.7956264,  3.5134526588, -9095.5551701890, 9.4948529E-05, 4.1873358E-08,-1.9479814E-10
}
local M31={
    0.5139500, 12.0108556517, 14914.4523349355,-6.3524240E-05, 6.3330532E-08,-2.5428962E-10, 0.3824500,  9.6553010794,  6585.7609102104,-2.1583699E-04,-1.8708058E-07, 9.3204945E-10,    0.3265400,  3.9694765808,  7700.3894694766, 1.5497663E-04, 2.4979472E-07,-1.1318993E-09,    0.2639600,  0.7416325637,  8956.9933799736, 1.4964887E-04, 2.5102751E-07,-1.2407788E-09,
    0.1230200, -1.6139220085,   628.3019552485,-2.6638815E-06, 6.1639211E-10,-5.4439728E-11, 0.0775400,  8.7830116346, 16171.0562454324,-6.8852003E-05, 6.4563317E-08,-3.6316908E-10,    0.0606800,  6.4274570623,  7842.3648207073,-2.2116475E-04,-1.8584780E-07, 8.2317000E-10,    0.0497000, 12.0539813334, 14286.1503796870,-6.0860358E-05, 6.2714140E-08,-1.9984990E-10
}
local M1n={3.81034392032, 8.39968473021E+03,-3.31919929753E-05, --月球平黃經系數
3.20170955005E-08,-1.53637455544E-10 }

--==================日位置計算===================
local EnnT=0 --調用Enn前先設置EnnT時間變量
local function Enn(F) --計算E10,E11,E20等,即:某一組週期項或泊松項算出,計算前先設置EnnT時間
	local i
	local v=0
	for i=1,#F,3 do
		v=v+F[i]*math.cos(F[i+1]+EnnT*F[i+2])
		--print('Fsize=' .. #F, 'i=' .. i, 'v='..v, 'F[i]='..F[i], 'm='..math.cos(F[i+1]+EnnT*F[i+2]))
	end
	return v
end

local function earCal(jd)--返回地球位置,日心Date黃道分點坐標
	EnnT=jd/365250
	--print('EnnT=' .. EnnT)
	local llr={}
	local t1=EnnT
	local t2=t1*t1
	local t3=t2*t1
	local t4=t3*t1
	local t5=t4*t1
	--print('t1='..t1, 't2='..t2, 't3='..t3, 't4='..t4, 't5='..t5)
	llr[1] =Enn(E10) +Enn(E11)*t1 +Enn(E12)*t2 +Enn(E13)*t3 +Enn(E14)*t4 +Enn(E15)*t5
	--print('sppp')
	llr[2] =Enn(E20) +Enn(E21)*t1
	--print('eppp')
	llr[3] =Enn(E30) +Enn(E31)*t1 +Enn(E32)*t2 +Enn(E33)*t3
	llr[1]=rad2mrad(llr[1])
	--print('llr[0]='..llr[1], 'llr[1]='..llr[2], 'llr[2]='..llr[3])
	return llr
end

local function sunCal2(jd) --傳回jd時刻太陽的地心視黃經及黃緯
	local sun=earCal(jd)  sun[1]=sun[1] + math.pi sun[2]=-sun[2] --計算太陽真位置
	local d=nutation(jd)  sun[1]=rad2mrad(sun[1]+d.Lon)   --補章動
	addGxc(jd,sun)  --補週年黃經光行差
	return sun      --返回太陽視位置
end

--==================月位置計算===================
local MnnT=0 --調用Mnn前先設置MnnT時間變量
local function Mnn(F) --計算M10,M11,M20等,計算前先設置MnnT時間
	local i
	local  v=0
	local t1=MnnT
	local t2=t1*t1
	local t3=t2*t1
	local t4=t3*t1
	for i=1,#F,6 do
		v=v+F[i]*math.sin(F[i+1] +t1*F[i+2] +t2*F[i+3] +t3*F[i+4] +t4*F[i+5])
	end
	return v
end

local function moonCal(jd)--返回月球位置,返回地心Date黃道坐標
	MnnT=jd/36525
	local t1=MnnT
	local t2=t1*t1
	local t3=t2*t1
	local t4=t3*t1
	local llr={}
	llr[1] =(Mnn(M10) +Mnn(M11)*t1 +Mnn(M12)*t2)/rad
	llr[2] =(Mnn(M20) +Mnn(M21)*t1)/rad
	llr[3] =(Mnn(M30) +Mnn(M31)*t1)*0.999999949827
	llr[1] =llr[1] +M1n[1] +M1n[2]*t1 +M1n[3]*t2 +M1n[4]*t3 +M1n[5]*t4
	llr[1] =rad2mrad(llr[1]) --地心Date黃道原點坐標(不含歲差)
	addPrece(jd,llr) --補歲差
	return llr
end

local function moonCal2(jd) --傳回月球的地心視黃經及視黃緯
	local moon=moonCal(jd)
	local d=nutation(jd)
	moon[1]=rad2mrad(moon[1]+d.Lon) --補章動
	return moon
end

local function moonCal3(jd) --傳回月球的地心視赤經及視赤緯
	local moon=moonCal(jd)
	HCconv(moon,hcjj1(jd))
	nutationRaDec(jd,moon) --補赤經及赤緯章動
	--如果黃赤轉換前補了黃經章動及交章動,就不能再補赤經赤緯章動
	return moon
end

--==================地心坐標中的日月位置計算===================
local function jiaoCai(lx,t,jiao)
	--lx=1時計算t時刻日月角距與jiao的差, lx=0計算t時刻太陽黃經與jiao的差
	local sun=earCal(t)  --計算太陽真位置(先算出日心坐標中地球的位置)
	sun[1]=sun[1] + math.pi sun[2]=-sun[2] --轉為地心坐標
	addGxc(t,sun)      --補週年光行差
	--print('sun[1]=' .. sun[1], 'sun[2]=' .. sun[2])
	if lx==0 then
		local d=nutation(t)
		sun[1]=sun[1] + d.Lon --補黃經章動
		return rad2mrad(jiao-sun[1])
	end
	local moon=moonCal(t) --日月角差與章動無關
	return rad2mrad(jiao-(moon[1]-sun[1]))
end

--==================已知位置反求時間===================
local function jiaoCal(t1,jiao,lx) --t1是J2000起算儒略日數
	--已知角度(jiao)求時間(t)
	--lx=0是太陽黃經達某角度的時刻計算(用於節氣計算)
	--lx=1是日月角距達某角度的時刻計算(用於定朔望等)
	--傳入的t1是指定角度對應真時刻t的前一些天
	--對於節氣計算,應滿足t在t1到t1+360天之間,對於Y年第n個節氣(n=0是春分),t1可取值Y*365.2422+n*15.2
	--對於朔望計算,應滿足t在t1到t1+25天之間,在此範圍之外,求右邊的根
	local t2=t1
	local t=0
	local v
	if lx==0 then  t2=t2+360  --在t1到t2範圍內求解(範氣360天範圍),結果置於t
	else t2=t2+25
	end
	jiao=jiao*math.pi/180  --待搜索目標角
	--利用截弦法計算
	--print('lx=' .. lx .. ', t1=' .. t1 .. ', t2=' .. t2 .. ', jiao=' .. jiao)
	local v1=jiaoCai(lx,t1,jiao)           --v1,v2為t1,t2時對應的黃經
	local v2=jiaoCai(lx,t2,jiao)
	--print('v1=' .. v1 .. ', v2=' ..v2)
	if v1<v2 then v2=v2 - 2*math.pi end  --減2pi作用是將週期性角度轉為連續角度
	local k=1,k2,i  --k是截弦的斜率
	for i=1,10 do       --快速截弦求根,通常截弦三四次就已達所需精度
		k2=(v2-v1)/(t2-t1)    --算出斜率
		if math.abs(k2)>1e-15 then k=k2  end   --差商可能為零,應排除
		t=t1-v1/k  v=jiaoCai(lx,t,jiao)--直線逼近法求根(直線方程的根)
		if v>1 then	 v=v-2*math.pi end        --一次逼近後,v1就已接近0,如果很大,則應減1周
		if math.abs(v)<1e-8 then  break  end     --已達精度
		t1=t2 v1=v2 t2=t v2=v          --下一次截弦
	end
	return t
end

--==================節氣計算===================
local jqB={ --節氣表
"春分","清明","谷雨","立夏","小滿","芒種","夏至","小暑","大暑","立秋","處暑","白露",
"秋分","寒露","霜降","立冬","小雪","大雪","冬至","小寒","大寒","立春","雨水","驚蟄"}

local function JQtest(y) --節氣使計算範例,y是年分,這是個測試函數
	local i,q,s1,s2  y=tostring(y)
	local jd=365.2422*(tonumber(y.sub(y,1,4))-2000)
	for i=0,23 do
		q=jiaoCal(jd+i*15.2,i*15,0)+J2000+8/24  --計算第i個節氣(i=0是春分),結果轉為北京時
		--print('q=' .. q)
		JDate:setFromJD(q,1)  s1=JDate:toStr()  --將儒略日轉成世界時
		JDate:setFromJD(q,0)  s2=JDate:toStr()  --將儒略日轉成日期格式(輸出日期形式的力學時)
		jqData=s1.sub(s1.gsub(s1, "^( )", ""),1,10)  jqData=jqData.gsub(jqData, "-", "")
		--print(jqB[i+1] .. " : " .. jqData .. " " .. jqData.len(jqData) ) --顯示
		if (jqData == y) then return "-" .. jqB[i+1] end
	end
	return ""
end

local function GetNextJQ(y) --節氣使計算範例,y是年分,這是個測試函數
	local i,obj,q,s1,s2  y=tostring(y)
	local jd=365.2422*(tonumber(y.sub(y,1,4))-2000)
	obj={}
	for i=0,23 do
		q=jiaoCal(jd+i*15.2,i*15,0)+J2000+8/24  --計算第i個節氣(i=0是春風),結果轉為北京時
		--print('q=' .. q)
		JDate:setFromJD(q,1)  s1=JDate:toStr()  --將儒略日轉成世界時
		JDate:setFromJD(q,0)  s2=JDate:toStr()  --將儒略日轉成日期格式(輸出日期形式的力學時)
		jqData=s1.sub(s1.gsub(s1, "^( )", ""),1,10)  jqData=jqData.gsub(jqData, "-", "")
		if (jqData>=y) then
			table.insert(obj,jqB[i+1] .." ".. s1.sub(s1.gsub(s1, "^( )", ""),1,10))
			--print(i .. s1.sub(s1.gsub(s1, "^( )", ""),1,10))
		end
	end
	return obj
end

local function getJQ(y) --返回一年中各個節氣的時間表，從春分開始
	local i
	local jd=365.2422*(y-2000)
	local q
	local jq = {}
	for i=0,23 do
		q=jiaoCal(jd+i*15.2,i*15,0)+J2000+8/24  --計算第i個節氣(i=0是春分),結果轉為北京時
		JDate:setFromJD(q,1)  jq[i+1] = JDate:JQ()  --將儒略日轉成世界時
	end
	return jq
end

--返回一年的二十四個節氣,從立春開始
local function getYearJQ(y)
	local jq1 = getJQ(y-1) --上一年
	local jq2 = getJQ(y) -- 當年
	local jq = {}
	for i=1,3 do jq[i] = jq1[i+21] end
	for i=1,21 do jq[i+3] = jq2[i] end
	return jq
end

--=================定朔弦望計算========================
local function dingSuo(y,arc) --這是個測試函數
	local i,jd=365.2422*(y-2000),q,s1,s2
	-- print("月份:世界時  原子時<br>")
	for i=0,11 do
		q=jiaoCal(jd+29.5*i,arc,1)+J2000+8/24    --計算第i個節氣(i=0是春風),結果轉為北京時
		JDate.setFromJD(q,1)  s1=JDate:toStr()  --將儒略日轉成世界時
		JDate.setFromJD(q,0)  s2=JDate:toStr()  --將儒略日轉成日期格式(輸出日期形式的力學時)
		-- print((i+1) .. "月 : ".. s1 .. " " .. s2 ) --顯示
	end
end

--=================農歷計算========================
--[[*****
1.冬至所在的UTC日期保存在A[0],根據"規定1"得知在A[0]之前(含A[0])的那個UTC朔日定為年首日期
冬至之後的中氣分保存在A[1],A[2],A[3]...A[13],其中A[12]又回到了冬至,共計算13次中氣
2.連續計算冬至後14個朔日,即起算時間時A[0]+1
14個朔日編號為0,1...12,保存在C[0],C[1]...C[13]
這14個朔日表示編號為0月,1月,...12月0月的各月終止日期,但要注意實際終止日是新月初一,不屬本月
這14個朔日同樣表示編號為1月,2月...的開始日期
設某月編號為n,那麼開始日期為C[n-1],結束日期為C[n],如果每月都含中氣,該月所含的中氣為A[n]
注:為了全總計算出13個月的大小月情況,須算出14個朔日。
3.閏年判斷:含有13個月的年份是閏年
當第13月(月編號12月)終止日期大於冬至日,  即C[12]〉A[12], 那麼該月是新年,本年沒月12月,本年共12個月
當第13月(月編號12月)終止日期小等於冬至日,即C[12]≤A[12],那麼該月是本年的有效月份,本年共13個月
4.閏年中處理閏月:
13個月中至少1個月份無中氣,首個無中氣的月置閏,在n=1...12月中找到閏月,即C[n]≤A[n]
從農歷年首的定義知道,0月一定含有中氣冬至,所以不可能是閏月。
首月有時很貪心,除冬至外還可能再吃掉本年或前年的另一個中氣
定出閏月後,該月及以後的月編號減1
5.以上所述的月編號不是日常生活中說的"正月","二月"等月名稱:
如果"建子",0月為首月,如果"建寅",2月的月名"正月",3月是"二月",其餘類推
*****--]]


--local yueMing={"正","二","三","四","五","六","七","八","九","十","冬","臘"}
--
--function paiYue(inYear) --農歷排月序計算,可定出農歷
--  --y=in1.value-0
--  local y = inYear-0
--  local zq={},jq={}, hs={}  --中氣表,節氣表,日月合朔表
--
--  --從冬至開始,連續計算14個中氣時刻
--  local i,t1=365.2422*(y-2000)-50 --農歷年首始於前一年的冬至,為了節氣中氣一起算,取前年大雪之前
--  for i=0,13 do   --計算節氣(從冬至開始),注意:返回的是力學時
--	zq[i+1]=jiaoCal(t1+i*30.4,i*30-90, 0) --中氣計算,冬至的太陽黃經是270度(或-90度)
--	jq[i+1]=jiaoCal(t1+i*30.4,i*30-105,0) --順便計算節氣,它不是農歷定朔計算所必需的
--end
--...
--end

local function GetNowTimeJq(date)
	local JQtable1,JQtable2
	date=tostring(date)
	if string.len(date)<8 then return "無效日期" end
	JQtable2=GetNextJQ(date)
	if tonumber(string.sub(date,5,8))<322 then
		JQtable1=GetNextJQ(tonumber(string.sub(date,1,4))-1 .. string.sub(date,5,8))
		--print(#JQtable1)
		if tonumber(string.sub(date,5,8))<108 then 
			for i=20,24 do table.insert(JQtable2,i-19,JQtable1[i]) end
		elseif tonumber(string.sub(date,5,8))<122 then
			for i=21,24 do table.insert(JQtable2,i-20,JQtable1[i]) end
		elseif tonumber(string.sub(date,5,8))<206 then
			for i=22,24 do table.insert(JQtable2,i-21,JQtable1[i]) end
		elseif tonumber(string.sub(date,5,8))<221 then
			for i=23,24 do table.insert(JQtable2,i-22,JQtable1[i]) end
		else
			table.insert(JQtable2,1,JQtable1[24])
		end
		--print(table.concat(JQtable2))
	end
	return JQtable2
end

local GanZhiLi = {
}

--創建干支歷對象
function GanZhiLi:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:setTime(os.time())
	return o
end

--將offset的數值轉化為特定偏移下的週期數，起始數，偏移量，週期
function GanZhiLi:calRound(start, offset, round)
	if start > round or start <=0 then return nil end --參數不對
	offset = math.floor(math.fmod(start+offset, round))
	if offset >=0 then
		if offset==0 then offset=round end
		return offset
	else
		return round + offset
	end
end

--週期循環數
local function calR2(n, round)
	local x = math.floor(math.fmod(n,round))
	if x==0 then x=round end
	return x
end

--設置用於轉換干支歷的公曆時間
function GanZhiLi:setTime(t)
	self.ttime = t
	self.tday = os.date('*t', t)
	--for k,v in pairs(self.tday) do
	--	print(k,v)
	--end
	--先取公曆今年的干支
	self.jqs = getYearJQ(self.tday.year)
	self.ganZhiYearNum = self:calGanZhiYearNum()
	if self.ganZhiYearNum ~= self.tday.year then
		--如果在節氣上還沒到今年的立春，則還沒到干支歷的今年，需要取干支歷的年份的24節氣
		self.jqs = getYearJQ(self.ganZhiYearNum)
	end
	self.ganZhiMonNum = self:calGanZhiMonthNum()
	self.curJq = self:getCurJQ()
end

function GanZhiLi:getCurJQ()
	--for i=1,24 do
	--	local x = os.date('*t', self.jqs[i])
	--	print(x.year, x.month, x.day, x.hour, x.min, x.sec)
	--end
	local x = 0
	if self.ttime < self.jqs[1] then return nil end --出錯，計算錯年了？
	for i=1,23 do
		if self.jqs[i] <= self.ttime and self.jqs[i+1] > self.ttime then x=i break end
	end
	if x==0 then x=24 end
	return x --返回以立春為起始序號1的節氣
end


--根據公曆年份和節氣計算干支歷的年份
function GanZhiLi:calGanZhiYearNum()
	if (self.ttime < self.jqs[1]) then return self.tday.year -1
	else return self.tday.year end
end

--獲取干支月份
function GanZhiLi:calGanZhiMonthNum()
	if self.ttime < self.jqs[1] then return nil end
	local x = 0
	if self.ttime < self.jqs[1] then return nil end --出錯，計算錯年了？
	for i=1,23 do
		if self.jqs[i] <= self.ttime and self.jqs[i+1] > self.ttime then x=i end
	end
	if x==0 then x=24 end
	return math.floor((x+1)/2)
end


--返回年的干支序號，1為甲子。。。
function GanZhiLi:getYearGanZhi()
	local jiaziYear = 1984 --甲子年
	--print(self.ganZhiYearNum)
	local yeardiff = self.ganZhiYearNum - jiaziYear
	return self:calRound(1,yeardiff,60)
end

--返回年的天干號，1為甲
function GanZhiLi:getYearGan()
	local idx = self:getYearGanZhi()
	return self:calR2(idx,10)
end

--返回年的地支號，1為子
function GanZhiLi:getYearZhi()
	local idx = self:getYearGanZhi()
	return self:calR2(idx,12)
end

--返回月的干支號
function GanZhiLi:getMonGanZhi()
	local ck ={year=2010,month=2,day=4,hour=6,min=42,sec=0}
	local x = os.time(ck) --參考月，立春時間2010-2-4 6:42:00對應的干支序號為15
	local ydiff = self.ganZhiYearNum - ck.year
	local mdiff = self.ganZhiMonNum-1
	if ydiff >=0 then
		mdiff = ydiff*12 + mdiff
	else
		mdiff = (ydiff+1)*12 + mdiff -12
	end
	return self:calRound(15,mdiff, 60)
end

function GanZhiLi:getMonGan()
	local idx = self:getMonGanZhi()
	return self:calR2(idx,10)
end

function GanZhiLi:getMonZhi()
	local idx = self:getMonGanZhi()
	return self:calR2(idx,12)
end

--返回日的干支號，甲子從1開始
function GanZhiLi:getDayGanZhi()
	local DAYSEC = 24*3600
	local jiaziDayTime = os.time({year=2012, month=8, day=30, hour=23, min=0,sec=0})
	local daydiff = math.floor((self.ttime - jiaziDayTime)/DAYSEC)
	return self:calRound(1,daydiff,60)
end

--返回日的天干號
function GanZhiLi:getDayGan()
	local idx = self:getDayGanZhi()
	return self:calR2(idx,10)
end

--返回日的地支號
function GanZhiLi:getDayZhi()
	local idx = self:getDayGanZhi()
	return self:calR2(idx,12)
end

--返回時辰的干支號
function GanZhiLi:getHourGanZhi()
	local SHICHENSEC=3600*2
	local jiaziShiTime = os.time({year=2012, month=8, day=30, hour=23, min=0, sec=0})
	local shiDiff = math.floor((self.ttime - jiaziShiTime)/SHICHENSEC)
	return self:calRound(1,shiDiff,60)
end

--返回時乾號
function GanZhiLi:getShiGan()
	local idx = self:getHourGanZhi()
	return self:calR2(idx,10)
end

--返回時支號
function GanZhiLi:getShiZhi()
	local idx = self:getHourGanZhi()
	return self:calR2(idx,12)
end

--====================以下是測試代碼=============
-- local jqB={ --節氣表
-- "立春","雨水","驚蟄","春分","清明","谷雨","立夏","小滿","芒種","夏至","小暑","大暑","立秋","處暑","白露",
-- "秋分","寒露","霜降","立冬","小雪","大雪","冬至","小寒","大寒",}

--天干
local tiangan = {'甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'}

--地支
local dizhi = {'子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'}


--根據六十甲子序號，返回六十甲子字符串,甲子從1開始
local function get60JiaZiStr(i)
local gan = i % 10
		if gan == 0  then gan = 10 end
		local zhi = i % 12
		if zhi == 0 then zhi = 12 end
		return tiangan[gan]..dizhi[zhi]
end

local function lunarJzl(y)
	local x,yidx,midx,didx,hidx
	y=tostring(y)
	x = GanZhiLi:new()
	x:setTime(os.time({year=tonumber(y.sub(y,1,4)),month=tonumber(y.sub(y,5,-5)), day=tonumber(y.sub(y,7,-3)),hour=tonumber(y.sub(y,9,-1)),min=4,sec=5}))
	yidx = x:getYearGanZhi()
	midx = x:getMonGanZhi()
	didx = x:getDayGanZhi()
	hidx = x:getHourGanZhi()
	GzData= get60JiaZiStr(yidx) .. '年' .. get60JiaZiStr(midx) .. '月' .. get60JiaZiStr(didx) .. '日' .. get60JiaZiStr(hidx) .. '時'
	--print('干支:'  .. GzData)
	return GzData, get60JiaZiStr(yidx), get60JiaZiStr(midx), get60JiaZiStr(didx), get60JiaZiStr(hidx)
end

--測試
-- print(lunarJzl(os.date("%Y%m%d%H")))

--[[
~~~~    ~~~~
--]]



--[[
~~~~轉換農曆月相等各種函數（有bug）~~~~
--]]
-- Celestial algorithms and data derived from https://ytliu0.github.io/ChineseCalendar/sunMoon.html
local moon_data = {
{0,4,6,6,6,5,4,3,4,5,3,7,3,6,3,3,4,3,5,6,5,5,5,1,4,2}, {1,5,6,6,6,5,3,4,2,4,5,3,7,5,5,6,4,5,5,4,6,3,5,4,3,5}, {0,4,4,5,5,4,6,2,6,3,5,6,5,6,7,6,6,6,3,6,1,4,3,4,5}, {0,5,5,3,3,2,5,3,8,5,8,6,6,6,5,6,7,7,6,6,2,4,1,4,5,4}, {1,5,4,3,3,2,1,5,3,6,6,6,6,5,4,6,4,6,5,5,5,4,5,5,5,5}, {0,6,3,6,3,4,4,4,4,4,4,4,5,4,5,2,5,1,5,4,6,7,7,7,7,6}, {1,3,7,2,8,4,6,5,5,4,4,3,4,5,3,6,2,4,2,4,5,6,7,7,6}, {1,4,5,3,6,5,8,7,6,5,4,3,4,3,4,5,4,4,3,3,4,5,4,6,3,7}, {0,4,6,7,6,6,7,5,6,6,3,7,1,5,2,4,3,4,5,5,5,5,4,2,5,1}, {1,7,5,7,7,6,4,4,4,3,6,3,7,2,5,4,4,6,5,6,7,6,4,4,1}, {1,5,3,6,6,6,5,4,2,3,3,4,7,4,6,6,5,6,5,4,6,4,6,3,4,4}, {0,4,4,5,4,5,5,3,7,4,7,6,6,7,7,7,8,6,5,6,1,5,1,5,4,4}, {1,5,4,3,3,2,1,6,2,7,5,7,5,5,6,6,6,7,7,5,6,1,4,3,5,6}, {0,5,4,4,1,2,2,1,5,4,6,5,4,4,5,4,7,4,6,6,5,5,5,4,5}, {0,5,4,6,2,6,2,4,3,3,4,4,4,4,5,3,6,2,5,3,6,6,6,6,7,5}, {1,4,5,2,6,3,7,6,6,4,3,3,3,4,3,5,1,4,1,4,4,5,6,7,6,6}, {0,5,4,6,4,7,7,7,7,5,3,4,1,3,3,3,4,2,3,3,3,4,5,4,7,3}, {1,6,5,5,6,6,5,6,5,4,5,2,6,2,4,3,3,5,5,6,6,6,3,6,1}, {1,7,4,7,7,6,6,5,3,3,5,3,7,2,6,2,4,4,4,5,6,5,5,4,2,5}, {0,2,6,7,7,7,6,4,5,3,4,6,5,7,5,6,5,4,5,5,3,5,2,4,3,3}, {1,4,5,4,6,5,4,6,3,7,4,6,5,5,7,7,7,6,6,3,6,0,4,3,5,5}, {0,5,4,4,2,2,4,3,8,4,7,6,6,6,6,6,8,7,7,6,3,5,1,4,5}, {0,5,5,4,3,3,2,2,5,4,7,6,7,6,6,5,7,5,7,6,6,6,4,5,5,4}, {1,5,4,3,5,1,5,4,5,5,4,5,6,6,5,6,2,6,2,6,4,6,6,6,6,5}, {0,5,3,6,2,7,5,7,5,5,4,4,4,4,5,3,5,1,3,1,3,5,5,6,7,5}, {1,5,5,3,7,5,7,6,5,5,4,2,4,3,4,4,4,5,4,5,5,4,4,6,3}, {1,7,4,5,5,5,5,5,5,5,5,3,6,2,5,2,4,4,5,6,6,6,5,6,2,6}, {0,2,7,6,8,6,6,4,4,4,4,6,3,7,3,4,4,3,5,5,6,7,5,3,5,1}, {1,5,4,7,7,6,5,5,3,4,3,4,6,4,6,5,4,5,5,4,6,3,6,4,4}, {1,5,4,5,5,4,4,5,3,6,2,5,4,5,6,6,6,7,6,5,5,1,5,2,5,4}, {0,5,5,4,3,3,2,2,6,3,8,5,6,5,5,6,7,7,8,7,5,5,1,4,3,5}, {1,6,5,4,4,2,2,3,3,6,5,6,6,5,5,6,4,6,4,7,5,5,6,4,5,6}, {0,6,5,6,3,7,3,5,5,5,5,5,4,5,5,2,6,1,5,2,5,5,6,7,6}, {0,5,4,6,2,7,4,9,6,6,5,4,3,4,4,4,6,3,4,2,4,3,5,6,6,5}, {1,5,3,3,5,3,7,7,7,7,5,4,5,2,4,3,4,5,4,5,5,4,4,5,3,6}, {0,3,6,5,6,6,6,6,7,6,6,7,3,6,2,5,3,3,5,6,5,6,5,2,5,1}, {1,6,4,8,6,6,6,4,3,4,5,4,8,3,6,3,3,4,4,6,7,6,5,4,2}, {1,5,2,6,6,6,6,5,3,4,2,4,5,4,7,5,5,5,4,5,5,3,6,3,4,4}, {0,3,5,4,4,5,4,4,6,3,6,4,5,6,6,7,8,8,7,6,4,6,1,5,3,5}, {1,5,4,4,3,2,2,4,3,7,4,7,5,5,6,6,6,8,8,7,7,3,5,2,5,6}, {0,5,6,4,2,3,2,2,5,4,6,5,5,6,4,4,6,4,7,5,6,6,5,6,6}, {0,6,5,6,3,6,2,5,3,4,4,4,5,5,5,4,6,2,6,2,6,5,6,8,7,6}, {1,6,5,4,7,3,8,5,7,5,5,4,4,4,5,5,3,5,1,4,2,4,5,6,6,7}, {0,5,5,6,4,7,6,8,8,7,6,5,3,5,3,5,4,3,4,3,4,4,4,4,6,4}, {1,7,4,7,6,6,7,7,6,6,5,4,6,2,5,2,4,4,4,6,6,6,5,5,2}, {1,6,3,7,7,7,7,6,5,5,4,4,7,3,6,2,4,3,4,5,6,6,7,4,3,4}, {0,2,5,5,6,7,6,5,5,3,5,4,5,7,6,6,6,5,5,5,4,6,2,5,3,4}, {1,4,4,5,5,4,4,5,3,7,3,7,5,6,7,6,7,8,6,5,6,1,6,2,5}, {1,5,5,5,4,3,2,2,1,6,3,7,5,6,5,5,6,7,6,7,7,5,5,1,5,4}, {0,5,6,5,4,3,1,2,2,3,6,4,6,6,5,5,5,4,7,5,7,6,6,6,5,6}, {1,6,5,4,5,2,6,2,4,4,4,5,5,5,5,5,4,7,2,5,3,6,6,6,7,6}, {0,6,4,5,3,8,5,9,6,6,6,4,4,5,5,5,6,2,4,2,4,4,5,7,7}, {0,5,6,4,4,6,4,8,7,8,7,5,4,5,2,5,3,5,4,3,4,4,5,5,6,5}, {1,7,4,6,5,6,6,5,6,6,6,5,6,3,5,1,4,3,4,5,5,6,6,5,3,6}, {0,3,8,5,8,7,7,6,6,4,5,6,4,8,3,6,3,4,5,4,6,6,6,5,5,3}, {1,5,3,7,7,7,7,6,4,5,3,5,5,5,7,5,6,5,4,5,5,3,6,3,5}, {1,5,4,6,5,5,6,5,4,7,3,7,4,6,6,5,7,7,7,7,6,3,5,0,5,4}, {0,5,6,5,4,3,3,2,4,3,7,4,7,5,6,7,6,7,9,9,7,7,3,5,3,5}, {1,6,5,5,4,1,3,1,2,5,4,6,6,5,6,6,5,7,4,8,6,6,6,5,6,6}, {0,5,6,5,4,6,2,5,4,5,6,5,5,6,6,5,6,3,5,2,5,4,6,7,6}, {0,6,6,4,3,6,3,8,6,8,6,4,4,4,4,5,6,4,6,1,4,2,4,6,6,6}, {1,6,5,4,4,3,7,5,7,7,6,5,4,3,4,3,5,5,4,5,4,4,5,4,4,6}, {0,3,7,4,6,6,5,7,6,5,6,6,4,7,2,5,2,4,4,5,6,7,6,5,4,2}, {1,6,3,7,6,8,6,6,5,5,5,5,6,4,7,2,4,4,3,6,6,6,6,5,4}, {1,5,3,7,6,8,8,7,5,5,3,5,3,4,6,4,6,5,5,5,5,4,6,3,5,4}, {0,5,5,5,5,6,4,5,5,3,7,2,6,4,6,7,7,7,8,7,6,6,2,7,2,6}, {1,6,6,6,4,3,2,3,2,6,3,8,5,6,6,5,7,8,7,9,7,5,6,2,5,6}, {0,7,8,6,5,5,2,4,4,3,7,6,6,6,5,5,6,5,7,4,7,5,5,6,5}, {0,6,7,5,5,7,4,7,3,6,5,5,6,5,5,6,6,4,6,1,5,3,6,6,7,7}, {1,6,5,4,6,3,8,5,8,6,7,5,5,4,5,5,5,6,3,5,1,4,4,5,7,6}, {0,5,5,3,4,6,5,8,7,8,7,6,6,5,4,5,5,6,5,4,5,4,4,4,5}, {0,4,6,3,6,4,5,6,6,6,7,7,6,7,3,6,2,5,3,4,5,5,6,6,5,4}, {1,6,3,7,5,8,7,7,6,6,4,5,6,4,7,2,6,1,4,4,5,6,6,5,5,4}, {0,3,5,3,7,6,7,7,5,4,4,3,5,6,5,7,6,6,6,5,6,6,4,7,3,5}, {1,4,4,5,5,4,5,4,3,5,2,6,3,6,6,7,7,8,7,8,7,4,7,2,7}, {1,4,7,7,6,4,4,2,2,4,3,7,4,6,5,5,5,6,7,9,8,7,7,3,6,4}, {0,6,7,6,7,5,2,3,1,2,4,4,6,5,5,5,5,4,6,5,7,5,6,7,6,7}, {1,6,6,6,6,4,6,3,6,3,5,5,5,5,6,5,4,5,2,5,2,6,5,7,8,7}, {0,7,5,5,4,6,4,9,6,8,7,5,6,5,5,6,5,5,6,2,3,2,4,6,6}, {0,7,6,4,5,5,4,8,7,9,8,7,7,5,4,5,3,5,4,4,4,3,4,5,4,5}, {1,6,4,7,5,7,7,7,8,7,6,6,6,5,6,1,5,2,4,4,5,5,6,5,4,4}, {0,2,6,3,8,6,8,8,7,6,6,5,5,7,4,7,3,4,4,4,6,6,6,6,4,3}, {1,4,2,6,5,7,8,6,6,5,4,6,5,6,7,6,7,6,6,5,5,4,6,3,6}, {1,3,5,5,4,5,5,5,5,5,4,7,3,7,5,7,7,8,8,8,7,5,6,2,7,2}, {0,7,6,6,5,5,2,3,2,2,6,3,7,4,5,6,5,7,8,8,9,8,5,7,3,7}, {1,6,7,7,5,3,3,1,2,3,3,6,4,5,5,5,5,6,5,7,5,7,5,6,7,6}, {0,6,6,6,5,6,3,6,3,6,5,5,6,6,6,7,6,4,7,2,6,3,6,7,7}, {0,7,6,4,4,5,3,8,5,9,6,6,5,5,5,5,6,6,6,3,5,2,5,5,5,7}, {1,7,5,5,4,4,6,4,9,7,8,7,6,4,4,2,5,3,4,5,4,5,4,5,6,6}, {0,4,7,4,7,5,7,6,6,6,7,6,6,6,3,6,1,5,3,5,6,6,6,6,5}, {0,4,5,3,8,5,9,8,7,6,6,5,6,6,5,7,3,6,2,4,5,4,6,6,5,5}, {1,4,4,6,5,8,9,8,8,7,5,6,4,6,6,6,7,5,5,6,5,4,5,3,6,3}, {0,6,5,5,6,6,5,6,5,5,7,3,7,3,6,6,6,8,8,8,7,7,3,6,2,6}, {1,4,7,6,5,4,4,2,2,5,3,7,3,6,5,5,6,7,7,9,7,7,6,4,6}, {1,4,6,6,6,6,4,2,3,2,3,5,4,6,5,5,7,6,5,6,4,7,5,6,6,6}, {0,6,6,5,6,5,3,6,2,6,4,5,5,5,6,6,6,5,6,3,5,1,6,5,7,7}, {1,7,6,6,4,4,7,3,8,5,7,5,5,5,4,5,6,6,4,5,1,4,2,5,6,6}, {0,7,6,4,4,4,3,7,6,8,7,6,6,5,4,6,3,6,5,5,6,4,5,5,5}, {0,5,6,4,6,4,7,6,6,7,7,7,7,6,5,7,2,5,3,5,5,6,7,7,5,5}, {1,4,3,6,5,9,7,9,8,6,5,6,5,6,7,4,6,3,5,3,4,6,5,6,6,4}, {0,4,4,3,6,6,8,8,6,5,5,3,5,4,5,7,6,6,6,6,7,5,5,6,4,6}, {1,5,5,6,5,5,6,4,5,5,3,6,3,6,4,6,7,7,7,9,7,6,6,2,7}, {1,3,7,7,7,7,5,3,3,3,3,7,4,7,4,6,5,6,7,8,7,8,7,5,7,3}, {0,7,6,7,7,6,5,4,2,4,4,4,6,5,6,6,4,5,6,5,7,4,7,5,6,7}, {1,7,6,8,6,5,7,3,7,3,6,5,5,5,5,5,6,5,4,5,1,6,3,6,6}, {1,6,7,6,5,4,5,3,7,5,9,6,6,7,5,6,7,6,7,6,4,5,2,4,4,6}, {0,7,6,4,4,3,4,5,5,8,7,8,7,6,5,5,4,6,4,6,5,5,5,5,5,6}, {1,6,5,6,3,7,5,7,7,6,7,7,7,7,7,4,6,2,5,3,5,6,6,6,5,4}, {0,3,6,3,8,6,9,7,7,6,6,5,6,7,5,7,4,5,3,4,5,5,7,6,5}, {0,5,4,3,6,4,7,7,7,7,6,3,5,3,6,5,6,7,5,6,7,5,5,6,4,6}, {1,3,6,4,5,6,5,5,6,5,5,6,3,7,3,6,6,6,7,8,8,8,6,3,6,2}, {0,7,5,6,6,6,4,3,2,3,4,3,7,3,6,4,5,6,6,8,8,7,7,6,4,7}, {1,5,7,8,7,7,5,3,4,2,4,4,4,6,5,4,5,4,5,6,4,7,5,6,7}, {1,6,7,7,6,7,6,4,6,2,6,4,5,5,5,6,7,6,6,6,2,6,2,6,6,7}, {0,8,7,6,5,5,4,6,3,8,6,8,6,6,6,6,6,7,6,5,5,2,4,3,5,7}, {1,6,7,7,5,6,5,5,8,6,9,8,7,6,5,4,6,3,5,4,4,5,4,4,5,4}, {0,6,6,4,7,4,7,7,7,8,8,7,7,7,6,7,3,6,2,5,5,6,6,6,5}, {0,4,4,3,6,4,8,7,8,7,6,5,6,6,6,7,4,7,3,5,4,5,7,6,6,5}, {1,3,3,4,2,6,6,8,8,7,7,6,5,6,6,7,7,6,7,6,6,6,5,4,6,2}, {0,6,4,5,5,5,5,5,5,5,6,4,7,3,7,4,6,7,8,7,8,7,6,6,2}, {0,7,3,8,7,6,6,4,3,3,3,3,5,3,6,3,5,5,5,7,7,8,8,7,5,6}, {1,4,7,7,7,7,5,3,4,1,3,3,4,6,5,6,6,5,6,6,5,8,4,8,6,6}, {0,7,6,6,6,5,4,6,3,7,3,6,4,4,5,6,6,6,6,5,6,2,7,4,7,7}, {1,7,8,6,5,4,5,4,8,5,8,6,6,6,4,5,6,6,6,6,4,5,3,5,6}, {1,6,7,7,5,5,3,4,6,4,8,7,7,7,5,4,4,3,5,4,5,6,5,6,6,5}, {0,6,6,5,7,3,7,5,6,7,6,6,7,6,6,6,3,5,1,4,3,5,6,6,6,5}, {1,5,3,6,3,8,6,9,9,8,8,6,6,6,7,6,7,3,5,3,4,4,5,6,5,4}, {0,5,3,3,5,5,8,8,8,8,6,5,6,4,6,6,6,6,6,5,6,5,5,5,4}, {0,6,3,6,5,5,5,6,5,6,5,5,6,3,6,3,5,5,6,7,8,8,7,6,4,6}, {1,2,7,5,7,6,5,4,4,2,3,5,3,7,4,6,4,5,7,7,8,9,7,6,6,4}, {0,6,5,7,7,6,6,5,2,3,2,4,6,5,6,5,6,6,5,5,7,5,8,5,6,6}, {1,6,7,7,6,6,6,4,7,3,6,4,6,6,5,6,6,6,6,5,3,5,2,6,5}, {1,7,8,7,5,5,4,3,6,3,8,4,6,6,5,6,5,6,7,6,6,5,3,5,4,6}, {0,7,6,7,5,3,3,4,4,6,5,8,7,6,6,5,5,5,3,6,5,6,6,5,5,5}, {1,4,6,6,4,7,4,7,6,7,7,7,7,7,6,6,6,3,6,2,5,5,6,7,6,4}, {0,4,4,2,6,3,9,7,8,7,7,6,6,5,6,7,5,6,3,4,4,4,7,6,6}, {0,5,4,4,4,4,7,6,8,8,6,6,5,3,5,4,5,5,5,6,5,5,6,5,5,6}, {1,4,6,4,5,5,5,6,6,4,5,5,3,6,2,7,4,6,7,7,8,8,7,6,6,3}, {0,7,4,8,7,7,6,4,3,4,3,4,5,3,7,3,5,5,5,6,7,7,8,6,5}, {0,7,4,8,7,8,9,6,5,4,2,4,4,4,5,4,5,5,4,6,5,4,6,3,6,5}, {1,6,7,7,6,7,6,5,6,3,7,3,5,4,4,6,6,6,7,6,5,5,1,6,3,7}, {0,7,6,7,5,4,3,4,3,7,4,8,5,5,6,5,5,7,6,6,6,4,5,2,5,6}, {1,6,8,6,4,5,3,4,5,5,8,7,7,7,5,5,5,4,6,3,5,4,4,5,4}, {1,4,5,5,4,6,3,7,5,7,7,6,8,7,7,6,6,4,5,2,5,3,4,6,5,6}, {0,5,4,3,5,3,8,5,8,7,7,6,5,5,6,6,6,7,4,5,3,4,5,4,6,5}, {1,4,3,2,2,5,4,7,7,7,7,5,5,5,4,6,6,6,7,6,6,6,5,6,5,4}, {0,5,2,5,4,5,5,6,5,5,4,4,6,3,6,3,6,6,6,8,9,8,8,7,5}, {0,7,3,8,6,8,8,6,4,4,2,4,5,3,6,3,5,4,4,6,6,7,8,6,6,6}, {1,4,7,6,8,8,7,6,5,2,3,2,4,4,4,6,5,5,6,5,5,7,5,7,5,7}, {0,7,7,8,8,6,6,5,4,6,3,5,4,4,5,5,6,7,6,6,6,3,5,2,7,6}, {1,8,9,7,6,5,4,4,6,5,8,6,7,6,5,6,6,6,6,6,5,5,1,4,3}, {1,5,8,7,7,6,3,4,5,5,8,6,8,7,6,6,5,4,5,3,6,4,5,5,4,5}, {0,6,4,5,5,4,6,4,7,6,7,7,7,7,7,6,6,5,2,5,1,5,4,5,6,5}, {1,4,3,3,2,6,4,8,6,8,7,7,7,6,6,7,7,5,7,3,5,4,4,6,5,5}, {0,5,2,3,3,2,6,6,7,7,6,6,6,5,7,5,7,7,6,6,6,6,6,5,4}, {0,6,3,6,3,6,5,5,5,6,5,5,6,4,6,2,6,3,6,7,7,8,7,7,5,5}, {1,2,7,4,7,7,6,5,4,2,3,3,3,5,2,6,3,5,5,5,8,8,7,7,6,5}, {0,7,4,7,7,7,7,5,4,3,1,2,2,3,5,4,5,5,4,6,6,5,6,4,7}, {0,5,6,7,6,6,7,5,5,6,3,6,2,5,4,5,6,5,6,7,5,4,5,1,6,4}, {1,7,7,7,7,6,4,4,4,3,7,4,8,5,5,5,4,6,5,5,6,6,3,5,3,6}, {0,6,6,8,6,5,4,3,4,5,5,8,6,6,6,4,5,4,3,5,3,5,4,5,6,5}, {1,5,6,5,5,6,3,7,5,7,7,7,8,8,7,7,6,4,6,2,5,3,5,6,5}, {1,6,4,3,2,4,2,7,5,9,8,7,7,7,6,7,7,7,7,4,5,2,4,5,4,6}, {0,5,4,4,3,3,5,5,8,8,8,7,6,6,6,4,6,5,6,7,6,6,5,5,6,5}, {1,3,5,3,5,5,5,6,5,6,6,5,4,6,3,6,3,6,6,6,8,9,7,7,5,3}, {0,5,3,7,5,7,7,5,4,4,3,3,4,3,6,3,5,4,5,6,6,8,7,7,6}, {0,5,4,7,5,7,8,6,7,5,2,4,3,4,5,5,6,5,5,6,5,5,5,4,6,4}, {1,6,6,5,7,6,5,6,5,3,6,3,6,4,4,5,5,6,7,6,6,5,3,5,2,7}, {0,7,7,8,7,5,4,3,3,5,3,7,4,6,5,4,5,4,5,6,5,5,4,2,5,4}, {1,6,7,6,6,5,2,4,3,4,7,6,7,7,6,6,4,5,6,4,6,4,4,5,4}, {1,5,5,4,5,4,3,6,3,6,5,6,7,7,7,7,6,5,6,2,6,2,5,5,6,6}, {0,5,4,4,3,2,6,4,8,7,8,7,6,6,6,6,6,6,4,6,2,4,4,5,6,5}, {1,5,4,3,3,3,3,6,5,7,7,6,6,4,4,6,4,6,5,6,7,6,6,6,5,5}, {0,6,3,6,4,5,5,5,5,5,5,4,4,3,5,2,5,3,5,6,7,7,7,6,6}, {0,5,3,7,5,8,8,8,6,5,3,3,4,4,5,3,5,2,4,4,4,6,6,6,6,5}, {1,4,6,4,7,8,8,9,6,5,4,2,4,3,4,5,4,5,5,4,5,4,3,6,3,6}, {0,5,6,7,6,6,7,5,5,5,3,6,2,4,3,4,5,5,6,6,5,4,5,1,5,3}, {1,6,6,6,6,5,4,3,4,3,7,4,8,5,6,6,5,6,7,6,6,5,3,4,2}, {1,5,6,5,6,5,4,4,2,4,5,5,8,6,7,7,5,5,5,4,6,3,5,4,5,5}, {0,5,5,6,4,4,5,3,7,5,6,6,6,7,7,7,7,6,4,5,1,5,3,5,6,5}, {1,6,5,2,3,3,2,6,5,7,6,6,7,5,6,7,7,7,7,4,6,3,5,6,5}, {1,6,5,3,3,1,2,4,4,6,7,5,6,4,5,5,4,7,5,6,7,6,6,7,5,5}, {0,5,3,6,2,5,4,5,5,5,5,5,5,5,5,2,6,2,5,5,7,7,7,7,6,5}, {1,3,5,3,7,6,8,7,5,4,3,3,3,4,3,5,2,4,3,4,6,5,7,7,6,5}, {0,6,4,7,6,8,8,7,6,4,3,3,1,3,4,4,5,4,4,5,4,5,6,4,6}, {0,5,7,6,7,7,6,5,6,4,4,6,2,6,3,4,5,5,6,6,6,5,4,2,5,2}, {1,7,6,7,8,6,5,5,3,3,6,4,8,4,6,5,4,5,5,6,6,5,4,4,2,4}, {0,4,6,8,7,7,5,3,4,4,4,7,5,7,6,5,6,4,4,4,3,5,3,4,5,4}, {1,5,5,4,5,4,3,6,3,6,5,6,7,7,7,8,6,6,6,2,5,2,5,5,5}, {1,7,5,3,2,1,1,5,3,7,5,7,7,6,7,6,6,7,7,5,6,3,5,4,4,6}, {0,5,5,4,1,2,3,2,6,5,7,7,5,6,5,4,6,4,6,5,5,6,5,5,5,4}, {1,4,4,3,5,3,5,4,5,5,5,5,5,5,3,5,1,5,2,5,6,7,8,7,6,4}, {0,5,2,7,5,8,7,6,6,4,3,3,3,3,4,2,4,2,4,4,4,6,6,6,6}, {0,5,4,6,4,7,6,7,7,5,4,3,2,4,3,4,5,4,5,5,4,5,5,4,6,3}, {1,6,4,6,6,6,6,6,5,5,5,2,5,2,5,4,4,6,6,6,6,5,4,5,1,6}, {0,5,7,8,7,7,5,4,3,4,4,7,4,6,4,4,4,3,5,5,6,6,5,3,5,3}, {1,6,7,7,8,6,4,4,2,3,5,5,7,6,6,6,4,6,4,4,6,4,5,5,5}, {1,6,5,5,6,4,4,5,2,6,4,6,7,6,7,8,7,7,6,3,5,1,4,3,5,7}, {0,6,5,4,3,3,3,3,7,5,9,7,7,8,6,6,7,6,7,6,3,4,2,4,5,4}, {1,6,4,2,3,1,2,4,4,7,7,6,7,5,5,5,4,6,5,6,6,5,6,6,5}, {1,5,5,3,6,2,6,4,5,6,5,5,5,4,4,4,2,5,1,4,4,6,7,7,7,6}, {0,4,3,5,2,7,5,7,7,5,5,4,3,4,5,4,5,2,4,3,3,6,6,7,7,5}, {1,5,4,3,6,4,7,8,5,6,4,3,3,2,4,4,4,6,4,4,6,4,5,5,3,6}, {0,3,6,6,6,7,7,5,6,4,4,5,1,4,2,4,4,5,6,6,5,5,5,2,5}, {0,2,7,6,7,8,6,4,4,2,3,4,2,7,3,5,5,4,6,5,7,7,5,5,4,2}, {1,5,4,6,8,5,5,4,2,4,2,4,6,4,6,6,5,6,4,5,5,3,5,3,5,5}, {0,5,5,6,4,5,4,3,5,3,7,5,6,6,7,7,7,6,6,5,1,4,1,5,5,5}, {1,6,4,3,3,1,2,4,3,7,6,7,6,5,6,6,6,7,6,5,5,3,5,4,5}, {1,7,5,6,3,2,3,2,3,6,5,6,6,5,5,3,3,5,3,6,5,6,5,5,6,6}, {0,4,4,5,3,6,3,5,4,5,5,5,5,5,4,3,5,2,4,3,5,6,7,7,6,5}, {1,4,4,3,6,4,9,7,7,6,4,3,4,4,4,5,3,5,2,3,4,4,6,6,5,6}, {0,4,4,6,5,8,8,8,9,5,4,4,2,4,2,4,5,4,4,5,3,5,4,4,5}, {0,3,6,4,5,7,6,6,7,5,5,5,3,5,2,5,3,4,6,5,6,7,5,4,4,1}, {1,5,3,7,8,6,6,5,2,3,3,3,6,4,7,4,4,5,4,7,6,5,6,4,3,5}, {0,3,5,6,6,7,5,4,3,2,4,5,5,7,6,6,7,4,6,4,4,5,2,4,4}, {0,4,5,5,4,6,4,4,5,2,6,3,5,6,6,7,7,6,7,6,4,5,1,4,3,5}, {1,7,5,4,3,2,2,2,2,5,3,6,6,5,5,5,6,7,6,7,6,4,5,3,4,6}, {0,5,6,4,2,2,0,2,3,3,6,6,6,6,4,4,5,4,6,4,7,7,6,6,6,4}, {1,5,3,3,4,2,5,3,4,4,4,4,5,4,4,5,2,4,1,5,4,6,7,7,7}, {1,6,4,3,5,3,8,5,7,7,5,5,3,3,3,4,3,4,1,3,2,3,6,5,6,6}, {0,4,5,4,4,7,5,8,8,6,6,3,2,3,1,3,3,4,4,4,4,5,4,5,5,4}, {1,6,4,6,6,6,7,6,5,5,5,3,5,2,5,2,3,4,4,6,6,5,5,3,2,4}, {0,2,7,7,8,8,6,6,5,4,4,5,4,6,4,5,5,3,5,4,5,5,3,3,3}, {0,2,5,5,6,8,6,7,4,3,4,3,4,5,5,6,6,4,5,3,4,4,2,5,3,4}, {1,4,4,4,5,3,5,4,3,6,3,6,5,5,6,6,7,7,5,5,5,1,4,2,5,5}, {0,4,5,3,2,1,1,1,4,3,7,6,7,7,5,7,6,6,8,6,5,5,3,5,4,5}, {1,7,4,3,3,0,1,1,2,5,5,6,7,5,6,4,4,5,4,6,5,6,6,6,5}, {1,6,4,5,5,2,5,2,5,4,4,5,5,4,5,4,4,4,1,5,2,5,6,6,7,7}, {0,4,4,4,2,5,3,7,6,6,6,3,3,3,3,4,4,3,4,2,4,5,4,7,6,6}, {1,5,3,3,4,3,7,7,7,7,4,4,3,2,4,2,4,5,4,5,5,4,6,4,4,5}, {0,4,6,5,5,7,6,6,7,5,5,5,3,5,1,3,3,3,6,5,6,6,4,4,4}, {0,1,6,4,8,8,7,7,5,3,3,4,3,6,3,6,3,3,4,3,6,5,5,5,4,3}, {1,5,3,6,7,6,7,5,3,3,2,3,4,4,6,5,5,5,3,4,4,3,5,2,4,4}, {0,5,6,6,4,5,3,4,5,3,6,3,6,6,6,7,7,6,7,5,4,5,1,4,3}, {0,4,6,5,5,3,1,1,3,2,6,4,7,6,6,7,5,6,7,6,7,5,3,5,3,5}, {1,7,5,7,3,2,2,1,2,4,4,6,6,5,6,3,4,4,3,5,4,5,6,5,5,5}, {0,5,5,3,3,4,2,5,3,5,5,4,5,5,4,5,4,2,5,2,4,4,5,8,6,6}, {1,5,3,2,4,2,7,5,7,6,5,5,3,4,4,4,4,5,2,4,2,3,6,4,6}, {1,5,3,4,3,3,6,6,8,8,6,6,4,3,3,2,3,3,3,5,4,4,4,3,4,4}, {0,3,5,3,6,6,6,6,6,5,6,4,4,5,1,4,2,3,4,5,6,6,5,5,4,2}, {1,4,2,7,7,8,7,6,5,4,2,3,4,2,6,3,4,4,2,5,4,5,5,4,3,3}, {0,2,4,5,6,7,5,6,4,3,4,2,5,5,6,6,6,5,6,4,5,4,3,5,3}, {0,3,5,5,4,5,3,5,4,3,5,3,6,4,6,7,7,7,8,6,6,5,2,5,2,6}, {1,6,6,6,4,2,2,1,2,4,2,7,5,5,6,4,6,6,6,7,6,5,5,2,5,5}, {0,5,7,4,5,3,0,1,1,2,5,4,5,6,5,6,3,4,5,4,6,6,6,7,6,5}, {1,6,4,4,4,3,5,2,4,4,4,5,4,5,5,4,4,5,1,4,3,5,6,6,7}, {1,6,5,4,4,3,7,5,9,8,7,7,4,5,4,3,5,4,3,4,1,2,4,3,6,5}, {0,5,4,3,3,5,4,8,7,8,8,4,5,4,2,4,3,4,4,4,5,4,4,5,3,4}, {1,4,2,5,4,5,6,6,6,6,5,5,4,3,4,1,3,3,3,5,5,6,5,4,3,3}, {0,1,5,4,7,7,6,6,4,3,4,4,4,6,3,6,4,3,5,3,6,4,5,4,3}, {0,1,4,3,5,7,6,7,4,3,3,2,4,4,5,7,5,6,6,3,5,4,3,4,2,4}, {1,4,4,5,5,4,5,3,3,4,2,5,3,5,5,5,7,6,6,6,5,3,4,1,5,4}, {0,5,6,5,4,2,1,1,1,1,5,3,5,5,4,6,5,6,7,6,7,5,4,5,3}, {0,5,7,5,6,3,1,1,0,1,3,3,5,5,5,6,3,4,4,3,6,4,5,6,6,7}, {1,6,5,6,4,3,5,3,6,4,5,5,4,5,5,4,5,4,2,4,1,4,4,5,7,6}, {0,6,5,4,2,4,3,7,6,7,7,5,5,3,3,4,3,3,4,1,3,2,4,7,5,7}, {1,5,4,4,3,3,6,5,7,7,6,7,3,3,3,2,3,3,3,4,4,3,5,3,5}, {1,4,4,6,4,6,6,7,7,6,6,7,5,5,5,3,4,2,3,4,4,6,5,5,4,2}, {0,1,4,2,6,7,8,8,6,5,4,4,5,5,4,5,3,4,4,2,6,4,5,4,3,3}, {1,3,2,5,6,7,8,6,6,5,3,5,3,5,5,5,6,6,4,6,3,5,4,2,4,3}, {0,4,4,4,4,5,3,5,3,3,5,3,6,5,5,7,6,7,8,7,6,5,3,4,2}, {0,5,5,5,6,4,2,1,0,0,3,3,6,4,5,6,5,7,6,7,7,6,5,6,3,5}, {1,5,5,7,5,5,2,0,1,2,2,5,4,6,7,4,6,4,4,5,4,5,5,5,6,5}, {0,5,6,4,4,4,2,5,2,4,4,4,4,5,5,5,4,4,3,2,4,2,5,7,7,7}, {1,6,4,4,3,2,6,4,7,6,5,6,3,4,3,3,3,4,3,3,2,4,4,4,7}, {1,5,5,4,2,2,3,3,7,7,7,8,4,5,3,2,4,2,4,4,4,4,5,4,5,4}, {0,4,5,3,5,4,6,6,6,6,6,5,5,4,3,4,1,3,3,3,5,5,6,5,4,3}, {1,4,3,6,5,8,9,7,6,5,4,3,4,4,5,3,4,2,2,4,2,5,4,4,4}, {1,3,2,4,3,6,7,6,8,4,4,3,2,4,4,4,6,6,5,6,3,5,4,3,4,2}, {0,5,4,5,5,5,4,5,3,3,4,2,5,3,5,5,5,7,7,7,7,5,3,4,1,5}, {1,4,6,7,5,5,4,2,2,3,2,5,4,6,6,5,7,5,7,6,6,6,4,2,5,3}, {0,5,7,5,6,4,2,2,1,2,3,4,6,5,4,6,3,4,5,3,5,4,5,6,6}, {0,6,6,5,5,3,3,5,2,5,3,4,5,5,5,5,4,5,3,3,4,1,4,5,6,8}, {1,6,5,5,2,2,4,2,7,6,7,7,5,7,4,5,5,4,5,4,2,3,3,3,6,4}, {0,6,5,3,3,2,2,5,5,7,8,6,7,4,3,3,3,4,3,4,4,4,5,5,4,5}, {1,4,3,5,3,6,5,6,6,7,5,6,5,4,5,2,4,2,3,4,4,6,5,5,4}, {1,3,1,4,3,6,7,8,7,6,5,4,3,4,5,4,6,4,4,4,4,6,5,6,5,3}, {0,3,3,2,5,5,6,7,6,5,3,3,4,3,4,5,6,6,7,5,7,4,5,5,3,5}, {1,3,5,5,5,5,6,4,5,3,3,5,3,5,4,5,6,6,7,8,6,6,5,2,5,3}, {0,5,7,6,7,4,2,2,1,1,4,2,6,4,4,5,4,7,5,7,7,6,5,6,4}, {0,6,7,7,8,5,4,2,0,2,1,2,5,4,5,6,4,5,3,4,5,3,5,4,6,6}, {1,6,6,7,4,5,4,3,5,3,5,4,5,5,5,6,6,5,4,4,1,4,2,4,6,5}, {0,7,6,4,4,3,3,6,4,8,7,6,7,4,5,4,4,5,4,3,4,2,3,4,4,7}, {1,4,5,4,2,3,4,5,7,7,7,8,4,5,3,2,4,3,3,3,4,4,4,4,5}, {1,4,4,4,3,5,4,5,6,6,6,7,5,6,5,3,4,2,4,3,3,6,5,6,5,3}, {0,3,3,2,5,5,7,7,6,6,4,4,4,4,5,6,4,5,4,3,5,4,6,4,4,4}, {1,3,2,4,4,6,7,6,8,4,4,4,2,4,5,6,6,6,6,7,4,6,4,3,3,2}, {0,4,4,4,5,5,4,6,2,4,4,2,5,2,4,5,5,8,8,7,7,6,4,5,2}, {0,5,4,6,8,5,4,3,0,1,2,1,5,2,5,4,4,6,5,7,7,6,6,5,4,5}, {1,5,6,8,6,7,4,2,2,0,3,3,4,6,5,5,7,4,6,4,4,6,4,6,6,6}, {0,7,7,5,6,4,4,4,2,5,3,4,5,5,5,6,5,5,3,3,4,2,4,5,6}, {0,9,7,6,5,3,3,4,3,7,6,7,6,4,6,3,4,4,4,4,3,2,4,4,4,7}, {1,5,7,5,3,3,3,3,5,5,7,8,5,7,4,5,4,3,4,3,4,5,5,5,6,3}, {0,5,4,4,5,3,6,6,7,7,7,5,7,5,6,4,3,4,2,4,5,5,6,5,5,4}, {1,2,2,4,4,7,8,9,8,7,6,6,5,5,5,5,6,3,4,5,3,6,4,5,4}, {1,2,3,2,2,4,6,7,8,5,6,4,3,4,3,5,5,6,7,6,5,7,4,5,4,3}, {0,5,3,4,4,4,4,5,3,4,3,3,5,2,4,4,5,7,6,8,8,6,6,4,3,4}, {1,2,6,6,6,6,3,2,1,1,2,4,3,6,4,5,6,4,8,6,6,7,5,4,5,3}, {0,6,7,6,8,4,4,2,0,1,1,2,4,5,5,6,4,6,3,4,5,3,5,5,6}, {0,7,6,6,6,4,5,4,3,5,2,4,4,4,5,5,4,6,4,4,4,1,4,2,5,7}, {1,6,8,6,4,3,2,2,5,4,7,6,6,7,3,5,4,4,6,4,3,4,3,4,6,5}, {0,8,4,5,3,2,3,3,3,6,7,7,7,4,5,3,3,4,2,4,5,5,5,5,5,6}, {1,4,5,4,3,6,5,6,7,7,7,7,6,7,4,4,4,1,3,3,4,6,5,6,5}, {1,4,3,3,3,6,5,8,9,7,7,5,5,4,4,5,5,3,4,4,3,6,4,7,4,5}, {0,4,3,3,4,4,6,8,6,8,5,5,4,2,4,4,5,6,6,6,6,4,6,3,3,4}, {1,2,4,5,5,5,6,5,6,4,5,5,3,5,4,5,6,6,8,7,7,7,5,3,4}, {1,1,5,5,6,7,5,5,4,1,2,3,4,5,4,6,5,4,7,5,7,7,6,6,5,4}, {0,5,5,6,8,6,8,4,2,3,1,3,4,4,6,6,5,7,4,5,4,3,5,3,5,6}, {1,6,6,7,5,6,3,3,4,2,5,4,5,5,5,6,7,5,6,4,3,4,2,5,5,6}, {0,8,6,5,4,2,2,4,3,7,5,7,7,4,7,4,5,6,5,5,4,2,4,4,5}, {0,7,5,7,5,3,3,3,3,6,6,8,8,6,7,4,5,3,2,4,3,5,5,5,5,6}, {1,3,5,3,4,5,3,6,5,6,7,7,6,6,5,5,4,2,3,3,4,5,5,8,6,5}, {0,4,2,2,3,4,7,7,7,8,5,6,4,4,5,4,4,5,3,4,5,3,7,4,6,4}, {1,2,2,2,3,5,6,7,8,5,7,4,4,5,4,6,5,6,7,7,5,7,4,5,4}, {1,3,5,3,5,5,5,5,5,4,6,3,3,5,2,4,4,5,7,6,8,8,6,7,5,3}, {0,6,4,7,8,7,8,5,3,3,1,2,3,3,5,3,3,5,3,7,6,6,6,5,5,5}, {1,4,7,8,7,9,6,5,3,1,2,2,3,5,5,6,6,3,7,3,5,5,4,5,5,6}, {0,7,6,6,8,5,5,4,3,5,3,5,5,4,6,6,6,6,5,5,4,2,4,3,5}, {0,7,6,8,6,5,4,3,4,7,5,8,7,6,7,4,6,4,5,5,4,3,4,2,3,5}, {1,5,8,5,5,4,3,3,4,5,7,7,8,8,5,6,4,4,4,3,4,4,5,6,5,5}, {0,6,3,4,3,3,5,5,6,6,6,7,7,6,7,5,5,4,2,3,3,4,7,5,6,5}, {1,3,2,3,2,5,6,8,9,7,8,5,6,5,5,6,6,5,5,4,3,6,4,7,4}, {1,4,3,2,2,4,4,6,8,7,8,5,5,4,4,5,5,6,7,7,6,7,5,7,4,4}, {0,4,3,5,4,5,5,6,4,6,3,4,3,2,4,3,5,6,5,8,8,7,8,5,5,4}, {1,3,6,6,7,8,5,5,2,2,2,2,3,5,4,4,6,4,7,5,8,7,7,7,5,4}, {0,6,6,6,8,5,7,4,2,2,0,2,3,4,6,6,4,7,4,6,5,4,5,5,6}, {0,7,7,7,8,6,7,4,4,5,3,5,3,5,5,5,6,6,5,6,4,3,4,2,5,6}, {1,6,9,7,6,5,3,3,4,4,7,6,6,7,4,6,4,5,5,4,5,4,3,4,5,6}, {0,9,6,8,5,3,4,2,4,6,6,8,7,5,7,3,4,3,2,4,3,4,5,5,5}, {0,7,4,6,4,5,5,4,6,7,7,8,7,8,8,6,6,5,3,4,2,3,5,5,7,5}, {1,4,3,2,2,4,4,8,8,9,9,6,7,5,6,6,6,5,6,4,4,5,4,7,4,5}, {0,4,2,2,3,2,5,6,6,9,5,8,4,5,4,3,5,6,5,7,6,6,7,4,5,4}, {1,3,4,3,5,4,4,5,5,3,6,4,4,4,3,5,4,5,7,6,9,8,7,6,4}, {1,3,5,4,7,7,7,7,4,3,2,1,2,4,4,5,4,4,6,5,8,5,7,6,5,5}, {0,5,4,7,8,7,10,6,5,3,1,3,2,3,4,4,6,6,4,7,3,4,4,3,6,5}, {1,5,7,7,6,8,4,6,4,3,5,3,5,5,4,6,6,7,7,5,6,4,2,5,4,6}, {0,9,7,8,6,3,3,3,2,6,4,6,6,5,7,3,6,4,6,6,5,5,5,4,4}, {0,7,6,8,5,6,4,2,4,4,5,7,7,7,9,5,7,3,4,4,4,5,5,5,6,6}, {1,4,6,4,5,4,4,6,5,6,7,7,8,8,6,8,5,4,4,2,4,3,5,7,6,7}, {0,5,3,3,3,3,6,6,8,9,7,8,5,6,5,5,5,6,4,5,4,4,6,4,8,4}, {1,5,3,2,2,4,4,6,8,6,8,4,6,4,4,5,6,6,7,7,7,8,5,7,3}, {1,5,4,3,5,4,6,6,5,5,6,4,5,4,3,4,3,5,5,6,9,8,8,8,5,4}, {0,4,3,6,6,8,9,7,6,4,2,3,3,4,5,4,4,5,4,7,5,8,6,6,6,5}, {1,4,5,5,7,9,6,8,4,4,3,1,2,4,4,5,6,5,8,4,6,5,5,6,5}, {1,6,7,7,7,7,4,6,4,4,4,2,5,4,4,6,4,6,7,5,7,4,3,4,3,5}, {0,7,7,9,6,5,4,3,2,4,3,7,6,7,7,5,8,4,6,6,5,5,3,3,3,4}, {1,5,9,6,7,4,3,3,3,4,6,6,8,8,6,8,4,6,4,3,4,4,5,5,6,5}, {0,7,4,7,4,5,5,4,6,5,6,7,6,6,7,5,6,4,3,4,2,4,5,5,8}, {0,6,5,4,1,2,4,3,7,8,7,8,6,7,5,5,7,6,6,5,5,5,6,4,8,4}, {1,7,4,2,2,2,3,5,6,6,9,6,7,4,4,5,4,6,5,6,7,7,6,8,5,6}, {0,5,4,6,4,5,6,6,6,7,5,6,4,5,4,3,4,3,5,7,7,8,8,7,6,4}, {1,3,6,5,7,9,7,8,5,4,3,3,3,4,3,4,4,4,7,4,8,6,8,7,5}, {1,5,6,5,7,9,8,10,5,6,3,2,2,2,3,4,5,6,7,4,7,4,5,5,4,5}, {0,5,6,7,8,7,8,5,7,5,4,6,4,5,5,5,7,7,7,7,5,5,4,2,4,4}, {1,6,8,7,9,5,4,4,4,4,6,5,7,7,5,7,4,7,5,5,6,4,4,4,4,5}, {0,7,6,10,5,5,4,2,3,4,6,8,7,7,9,4,7,4,4,4,3,4,4,4,6}, {0,6,4,6,3,5,4,3,5,5,7,7,7,8,8,8,8,6,6,4,3,4,5,5,7,5}, {1,6,5,3,2,1,2,4,6,7,8,7,8,6,7,7,6,7,6,5,5,4,4,7,5,7}, {0,4,5,3,2,2,3,5,6,8,7,9,4,6,4,4,5,5,6,7,7,7,8,4,7,4}, {1,5,5,4,5,5,5,6,6,4,6,4,5,3,3,4,3,5,6,7,9,8,8,9,6}, {1,5,5,4,6,7,8,9,6,6,3,2,2,3,3,4,4,4,5,4,8,5,9,7,6,6}, {0,5,4,6,7,8,9,7,9,4,5,3,2,3,4,4,5,5,5,7,3,6,4,4,5,4}, {1,6,7,6,7,8,6,7,4,5,4,3,5,4,4,5,5,7,6,6,6,4,3,3,3}, {1,6,8,8,10,7,7,5,3,3,5,4,6,5,6,7,3,7,4,6,5,5,4,3,3,4}, {0,6,6,9,6,8,5,4,4,3,4,6,7,8,9,6,9,4,6,4,3,4,3,4,5,5}, {1,5,6,4,6,3,5,5,5,7,7,7,8,8,8,8,6,8,5,4,4,3,4,5,5,7}, {0,5,4,3,2,3,4,5,8,9,8,10,7,8,6,6,6,6,6,5,4,4,6,4,8}, {0,4,7,3,2,1,1,3,5,7,7,9,5,9,4,6,4,4,5,6,7,7,8,7,9,5}, {1,6,4,3,4,3,5,5,5,6,6,5,6,4,5,4,3,4,4,5,8,7,9,9,6,6}, {0,4,3,5,5,7,8,7,8,5,4,3,3,4,4,4,5,5,4,7,4,8,5,7,6,5}, {1,4,4,4,7,8,8,10,6,7,4,3,3,3,4,5,5,6,7,5,7,4,6,4,5}, {1,6,6,6,8,8,7,8,4,6,4,3,4,3,4,4,4,6,6,6,7,5,5,3,3,4}, {0,5,6,10,7,9,6,4,3,3,3,5,5,6,6,5,7,4,7,5,6,6,5,4,4,4}, {1,6,8,6,9,5,6,3,2,3,4,5,7,8,7,9,4,7,4,5,4,4,5,5,6,6}, {0,7,6,8,4,6,5,5,5,5,7,8,7,8,8,7,8,5,5,3,2,3,4,4,8}, {0,6,8,5,3,3,2,3,5,6,8,9,7,8,5,7,6,6,6,5,5,5,4,4,8,5}, {1,9,5,5,3,2,2,3,5,7,8,6,9,4,6,4,4,5,5,6,6,7,7,8,5,8}, {0,4,5,4,4,5,5,6,7,6,6,7,4,6,4,4,4,3,5,5,5,9,8,7,6,4}, {1,3,4,3,6,7,8,9,7,7,5,4,4,4,4,5,4,3,4,3,7,5,8,6,6}, {1,5,4,4,5,7,7,10,7,9,5,4,3,3,2,4,4,5,6,4,7,4,7,4,5,5}, {0,4,6,7,7,7,8,6,6,4,5,4,4,5,4,5,6,5,7,7,6,7,4,4,4,3}, {1,5,8,7,9,6,6,4,3,3,4,4,6,6,6,8,4,8,5,8,6,5,4,4,3}, {1,4,6,6,10,6,8,5,4,4,3,4,6,6,7,9,5,8,3,6,4,4,4,4,5,5}, {0,5,6,7,4,6,3,5,5,4,6,6,6,8,7,7,9,6,7,5,5,4,4,5,8,6}, {1,9,5,5,3,1,2,3,4,6,7,7,9,6,8,5,7,7,6,7,6,5,5,6,5,9}, {0,5,7,4,2,2,2,4,6,7,7,10,6,9,4,5,4,4,6,6,7,7,8,6,8}, {0,4,7,4,4,5,4,5,6,6,6,7,5,6,4,5,3,2,4,4,5,7,7,9,8,7}, {1,6,5,4,6,6,8,9,8,9,5,5,4,3,4,3,3,3,3,3,6,4,9,5,7,6}, {0,5,4,5,6,7,9,8,11,6,8,3,3,3,3,4,5,6,6,8,5,7,4,5,4,3}, {1,5,5,6,8,7,7,8,5,6,5,4,5,3,4,5,4,7,6,8,8,5,6,3,3}, {1,4,5,7,9,8,9,6,5,4,3,4,6,6,7,7,4,7,4,7,5,5,5,4,4,4}, {0,4,5,8,6,10,5,6,4,3,4,4,6,7,8,7,9,4,8,4,5,4,4,4,5,5}, {1,7,6,5,6,3,4,3,3,4,4,5,7,7,8,9,7,9,6,6,4,3,4,5,5,8}, {0,6,7,5,2,3,2,3,5,5,7,9,6,9,5,7,6,7,7,5,5,5,5,5,7}, {0,4,9,4,4,3,1,2,3,4,6,8,6,9,4,6,4,4,5,5,6,6,7,7,8,6}, {1,8,4,6,5,4,5,5,5,6,5,5,6,3,6,3,4,3,3,3,6,6,9,7,8,7}, {0,4,5,4,4,6,7,8,9,6,6,4,4,4,3,4,4,4,3,5,4,8,5,9,6,6}, {1,5,4,4,6,6,8,10,7,9,4,5,3,2,3,4,4,5,6,5,8,4,6,3,5}, {1,5,5,6,7,7,8,8,6,8,4,6,5,3,4,4,3,5,4,7,6,6,7,3,4,3}, {0,4,6,8,8,11,8,7,5,3,4,4,5,6,5,5,7,4,8,4,7,6,5,4,4,4}, {1,5,7,6,11,6,9,4,4,3,3,4,6,6,7,9,5,9,3,7,4,4,4,3,4}, {1,6,6,6,8,4,7,3,5,5,5,6,7,7,9,8,8,9,6,7,4,3,4,3,3,7}, {0,5,8,5,4,3,1,2,3,5,7,8,7,9,6,9,6,7,7,6,7,6,5,4,6,5}, {1,9,5,7,3,2,2,1,3,4,6,6,9,5,8,4,6,4,4,6,5,6,7,7,6,8}, {0,5,7,3,4,4,4,5,6,5,6,6,5,7,4,6,4,4,4,4,5,8,7,9,7}, {0,6,5,4,3,4,5,7,8,7,8,4,5,3,4,4,4,4,4,5,4,6,4,9,5,7}, {1,5,4,3,4,5,7,9,8,10,5,7,3,3,2,2,3,4,5,5,7,4,8,3,6,4}, {0,4,5,6,6,7,8,7,7,4,7,4,4,4,3,4,4,4,8,6,8,8,5,6,4,3}, {1,4,6,7,10,7,8,5,4,4,3,4,4,4,5,6,3,8,3,8,5,6,5,4,4}, {1,4,5,6,9,7,10,5,7,4,3,4,5,6,7,7,6,9,4,8,3,5,3,3,4,5}, {0,5,6,6,5,7,3,6,4,4,5,6,6,7,6,8,8,7,8,4,5,3,2,3,5,5}, {1,10,6,7,5,3,3,1,3,5,5,6,9,5,9,4,7,6,6,6,5,4,4,5,4,8}, {0,5,9,4,4,2,1,2,3,5,7,8,6,9,4,7,4,5,5,5,6,6,6,7,8}, {0,5,7,3,5,3,3,5,5,6,6,6,6,7,4,7,4,4,4,3,4,6,5,9,7,8}, {1,6,4,3,3,4,6,7,8,10,6,8,5,4,4,3,4,4,4,3,5,3,7,4,9,5}, {0,5,4,3,3,5,6,7,10,7,9,4,6,3,3,4,4,4,5,6,5,8,4,7,3,4}, {1,4,4,6,6,6,7,7,5,7,3,5,4,4,4,4,4,7,5,8,7,7,6,4,4}, {1,4,4,6,8,7,10,7,6,5,4,4,5,5,5,5,5,7,3,8,4,7,5,4,4,3}, {0,3,4,7,6,10,5,9,4,4,3,3,4,6,6,7,8,6,9,4,7,4,4,4,5,4}, {1,6,6,6,7,4,6,3,5,4,4,4,5,5,7,7,8,9,7,8,4,4,3,3,5}, {1,7,6,9,5,3,3,0,2,2,4,6,7,6,9,5,8,5,7,7,6,6,6,5,5,7}, {0,6,10,5,7,2,2,2,1,3,4,6,6,9,5,8,3,6,3,4,5,6,7,7,7,7}, {1,9,4,7,4,4,4,4,5,6,5,6,6,5,7,4,5,2,2,3,3,4,7,6,9,8}, {0,6,6,4,4,5,6,8,9,6,9,4,6,3,4,4,3,4,4,4,3,7,4,9,5}, {0,7,5,4,3,4,5,7,9,7,10,5,8,3,4,2,2,3,5,5,5,7,4,8,3,6}, {1,3,4,5,5,6,8,8,7,9,6,8,5,5,5,4,4,4,4,7,5,8,6,4,5,2}, {0,2,4,6,7,10,7,9,6,5,5,4,5,5,5,4,6,3,7,2,8,4,6,4,4,3}, {1,3,5,5,8,6,10,5,6,3,3,3,4,4,6,7,6,8,4,8,3,4,3,3,3}, {1,5,5,6,6,4,7,2,5,2,4,5,5,6,8,6,9,8,8,10,6,6,4,3,3,5}, {0,5,8,5,6,4,2,2,0,2,4,6,6,8,5,9,5,9,6,7,7,5,5,5,6,5}, {1,9,5,9,4,4,2,1,2,2,4,6,8,5,9,4,7,3,5,4,5,5,7,7,7,8}, {0,5,8,3,5,3,3,4,5,4,6,5,5,6,4,6,3,4,3,3,4,7,6,10,8}, {0,8,6,4,3,3,3,5,7,7,9,5,7,3,4,4,3,4,4,4,3,5,4,9,5,9}, {1,5,5,4,4,4,5,7,7,11,7,10,4,6,3,3,2,4,3,5,6,5,8,3,7,4}, {0,5,5,5,5,7,7,8,8,6,8,4,6,4,3,3,3,3,6,4,8,6,6,6,3,3}, {1,3,4,6,9,8,10,7,7,5,4,4,4,4,5,5,3,7,3,8,3,7,4,4,4}, {1,2,3,4,7,7,10,5,9,4,5,4,3,4,6,7,7,8,5,9,3,7,3,3,3,4}, {0,3,5,4,5,6,3,6,3,5,4,4,6,6,5,9,6,9,9,7,8,5,4,4,3,5}, {1,8,6,8,4,4,2,1,2,2,4,6,7,5,9,4,8,5,7,7,6,5,4,5,5}, {1,7,5,9,4,6,3,1,1,1,2,4,5,6,9,5,8,3,7,4,5,5,5,6,8,7}, {0,6,8,4,6,3,4,3,3,4,5,4,6,5,5,7,3,5,3,3,3,4,4,8,6,9}, {1,7,5,4,2,3,4,6,7,8,7,9,4,7,4,4,4,3,4,3,4,3,7,3,9,4}, {0,6,4,4,3,3,4,6,9,7,10,5,7,3,4,2,2,3,4,5,5,7,5,8,3}, {0,6,4,4,4,6,5,7,6,7,7,4,6,3,4,3,2,1,3,3,6,5,8,7,4,4}, {1,2,2,4,6,7,10,7,10,5,5,4,3,5,5,5,4,5,3,8,3,8,4,6,4,3}, {0,3,3,4,6,9,6,11,5,7,4,3,4,4,5,6,7,6,8,3,8,3,5,3,3,4}, {1,5,5,6,7,5,7,3,6,3,4,5,4,5,7,5,8,8,8,8,5,5,2,2,4}, {1,5,6,9,6,7,4,1,2,1,3,4,5,6,8,4,9,4,8,6,7,7,5,5,5,6}, {0,6,9,5,10,4,4,1,1,2,2,4,6,7,5,9,3,7,3,5,4,5,5,6,6,7}, {1,8,5,8,4,5,3,4,4,6,5,7,6,7,7,5,7,3,4,2,2,3,6,5,9,6}, {0,7,5,3,3,2,4,5,8,7,10,5,8,4,5,4,3,4,3,3,2,5,3,8,4}, {0,9,4,5,3,2,3,5,6,7,9,6,9,3,6,2,3,3,3,4,5,5,4,8,4,6}, {1,2,5,3,4,5,6,6,7,7,6,7,4,6,4,4,3,4,3,7,4,8,6,6,5,2}, {0,3,2,4,5,8,7,10,6,7,4,3,4,4,5,4,5,3,6,3,9,4,7,4,4,3}, {1,3,2,4,7,6,11,5,8,3,4,3,2,4,5,5,6,8,4,9,3,7,3,3,3}, {1,4,3,6,5,5,6,2,6,2,4,3,3,4,4,4,7,7,9,9,7,8,4,4,4,4}, {0,4,8,6,8,4,4,2,-1,1,1,3,5,6,4,8,3,9,5,7,7,6,6,4,4,5}, {1,8,6,11,5,7,2,2,2,2,2,4,5,5,8,3,8,3,6,3,3,4,5,5,7,7}, {0,7,9,4,7,3,5,4,4,5,5,4,6,6,5,7,3,5,2,2,2,3,4,8,6}, {0,10,7,5,5,3,3,4,6,7,8,5,9,4,6,3,3,3,3,3,3,4,2,7,3,9}, {1,4,7,3,3,3,4,5,6,9,7,11,5,9,2,4,3,3,3,4,5,5,6,3,7,2}, {0,5,2,3,3,5,5,7,7,7,8,6,8,4,6,4,3,2,4,3,7,5,7,6,3}, {0,4,1,2,3,6,6,10,7,9,6,5,5,4,5,4,5,3,6,2,7,2,8,4,5,3}, {1,2,2,3,4,5,8,6,10,4,6,2,4,4,4,5,6,7,6,10,4,9,3,5,3,3}, {0,3,4,4,5,5,4,6,2,5,2,3,3,4,4,6,5,9,8,8,9,6,5,3,3,4}, {1,6,5,10,6,7,3,1,2,1,2,3,4,4,7,3,9,4,8,6,6,6,4,4,4}, {1,6,5,9,5,10,3,4,1,0,1,2,3,5,7,4,8,2,7,3,5,4,5,5,7,7}, {0,7,8,5,8,3,5,2,3,3,4,4,5,4,5,6,4,6,2,4,2,2,2,6,5,10}, {1,7,7,6,3,2,2,3,5,7,6,9,4,8,3,5,3,4,4,3,3,2,5,3,9,4}, {0,9,4,5,2,2,3,5,6,7,10,6,10,3,6,2,3,2,3,4,4,5,5,8,4}, {0,8,3,5,4,5,5,7,6,8,8,6,7,4,6,3,4,2,3,1,5,3,7,6,5,5}, {1,2,3,2,4,5,8,7,11,6,7,5,4,4,3,4,4,5,3,7,3,9,3,7,4,4}, {0,2,1,2,3,6,6,10,5,8,3,5,2,3,3,5,5,7,8,5,9,3,7,2,4,2}, {1,4,3,6,5,5,6,3,7,2,5,3,4,3,5,4,7,6,8,8,6,7,3,3,3}, {1,3,4,8,5,9,4,3,2,0,1,2,3,4,5,4,7,3,8,5,7,6,6,5,4,4}, {0,4,8,5,11,4,7,1,2,1,1,1,3,4,4,8,3,8,2,6,3,4,4,5,5,7}, {1,7,5,8,4,6,2,4,3,3,4,6,4,6,6,6,7,4,6,3,3,2,4,3,8,5}, {0,8,5,5,4,1,2,3,5,6,8,5,9,4,7,4,5,4,3,4,3,3,2,8,3}, {0,10,4,7,3,2,2,3,4,6,8,6,10,3,7,2,4,1,3,3,4,4,5,6,4,7}, {1,3,6,2,4,4,5,5,7,6,7,7,5,7,3,5,3,4,1,4,3,8,5,8,6,3}, {0,4,2,3,3,5,5,10,6,9,5,6,4,3,5,4,5,3,5,3,8,2,8,4,6}, {0,3,2,2,3,4,6,9,6,11,4,8,3,4,3,4,5,6,7,5,8,3,8,2,5,2}, {1,4,4,4,4,6,6,5,7,2,6,3,4,2,3,3,6,4,8,7,8,8,4,5,2,3}, {0,3,7,6,10,6,7,3,1,2,0,2,3,4,4,6,2,8,3,9,6,6,6,4,4,4}, {1,5,5,10,5,10,3,4,1,1,1,3,4,5,7,5,9,3,7,3,5,3,4,4,5}, {1,5,6,7,4,7,2,5,2,4,4,4,4,6,4,6,6,5,7,3,4,2,3,2,6,4}, {0,10,6,7,4,2,2,1,3,4,7,5,9,4,8,2,5,3,3,4,2,3,2,5,2,9}, {1,4,9,3,4,1,1,2,4,5,6,9,5,9,3,6,1,4,3,4,3,5,5,4,7,3}, {0,7,2,5,3,3,3,5,5,6,6,6,7,4,7,2,4,2,3,1,6,3,8,5,5}, {0,4,1,2,2,4,4,8,7,10,6,7,4,5,4,4,4,3,4,2,7,2,8,2,7,3}, {1,3,1,1,2,3,6,5,10,4,8,2,4,2,2,3,4,5,5,8,5,9,3,7,2,4}, {0,3,4,3,5,5,5,6,2,6,2,4,1,3,2,4,3,7,5,8,8,7,7,3,4,3}, {1,5,4,8,6,9,4,4,2,0,2,2,4,4,5,3,7,2,8,4,7,5,5,4,3}, {1,3,5,7,5,11,4,8,2,2,1,2,2,4,4,5,7,3,8,1,5,2,4,3,5,4}, {0,7,7,7,9,4,8,3,4,3,4,3,5,4,6,4,5,7,3,5,1,2,1,3,3,8}, {1,6,9,6,4,4,1,3,3,5,6,8,5,9,3,7,3,5,4,4,4,2,3,2,7}, {1,3,9,4,6,2,2,2,2,4,6,8,6,10,4,9,2,6,2,3,3,4,4,5,6,4}, {0,7,2,6,1,4,3,5,5,8,7,8,8,6,8,4,6,2,3,1,4,2,7,4,7,5}, {1,3,3,0,2,2,5,5,10,6,9,5,6,4,4,5,4,4,3,5,2,8,3,9,4,6}, {0,2,2,1,2,3,4,8,5,10,3,7,2,3,2,3,4,6,6,6,9,4,8,2,6}, {0,2,3,3,4,4,5,5,3,6,1,5,2,4,2,4,3,6,5,8,8,8,9,5,5,2}
}
local sun_data = {
{6,6,6,6,5,7,6,7,6,7,5,7,6,7,8,9,10,10,10,10,9,8,7,5}, {4,3,4,3,5,5,8,8,11,11,11,11,11,10,8,8,7,7,6,7,7,8,6,8}, {6,8,6,7,6,7,7,7,7,7,7,7,6,5,5,3,3,2,4,3,6,7,9,8}, {9,8,8,5,4,3,2,1,1,1,0,2,1,4,3,5,4,6,6,8,7,8,8,9}, {9,8,7,5,5,3,3,1,2,1,3,3,6,6,8,8,8,8,7,6,6,6,6,6}, {5,6,6,7,6,6,5,6,5,6,4,5,5,6,6,5,5,5,4,3,3,2,3,3}, {5,5,7,7,10,9,10,8,7,6,4,3,1,0,0,1,1,2,1,3,3,5,5,6}, {5,6,6,6,6,6,5,5,4,2,2,-1,-1,-1,0,0,2,2,5,5,6,7,7,7}, {6,5,4,3,3,3,2,4,3,5,4,5,4,5,5,5,4,5,4,6,6,6,6,5}, {6,4,5,4,5,4,6,6,7,8,8,8,9,7,6,5,3,3,1,1,0,3,3,5}, {6,8,8,9,9,8,8,7,7,5,5,4,4,3,4,2,3,1,1,0,2,2,5,4}, {6,7,8,8,7,8,6,6,3,4,2,2,3,4,4,6,7,7,7,7,6,6,6,5}, {5,4,5,4,6,4,5,5,6,6,7,7,8,9,10,11,11,11,10,10,9,9,6,6}, {4,5,3,4,5,6,7,8,9,10,11,11,11,11,10,9,10,8,9,7,9,8,8,8}, {8,7,8,7,8,9,8,9,8,8,7,7,6,7,5,5,4,5,5,8,8,10,10,11}, {11,11,9,8,8,6,5,3,4,3,4,2,4,4,5,5,7,8,9,9,9,10,9,10}, {9,9,8,8,6,7,4,5,3,5,4,7,7,8,9,10,10,10,9,8,9,7,7,6}, {7,6,7,6,7,7,8,8,8,8,8,8,8,8,7,7,6,7,5,5,4,4,3,5}, {4,5,5,6,7,7,8,8,8,5,6,3,3,2,2,2,4,3,4,4,5,6,6,6}, {6,5,5,4,3,4,2,3,2,3,1,1,0,2,1,3,4,6,6,8,8,7,8,6}, {5,3,3,0,0,-1,0,-1,0,0,3,3,5,5,6,6,6,6,6,6,6,7,6,7}, {5,5,4,4,3,4,3,4,4,5,6,6,7,6,6,5,5,3,3,2,3,3,6,5}, {7,8,9,9,9,9,7,6,4,4,2,2,1,2,1,2,1,2,2,2,3,4,5,6}, {8,8,10,9,9,7,7,5,5,2,1,-1,0,1,2,3,5,6,7,8,7,8,7,7}, {5,6,5,7,6,8,6,7,7,7,5,6,6,6,6,6,8,7,9,8,9,7,7,5}, {6,4,5,4,6,7,8,10,11,11,11,10,9,8,6,6,4,5,3,5,5,6,6,8}, {7,7,7,7,8,8,9,8,9,8,8,6,6,4,4,3,3,1,2,2,5,6,7,8}, {9,9,8,8,6,5,4,4,3,4,3,4,4,5,5,6,5,6,6,6,7,6,7,7}, {8,7,7,5,6,4,4,3,3,4,5,6,8,9,9,10,9,9,7,7,5,5,4,5}, {4,6,5,7,7,8,8,8,9,8,8,8,8,8,9,8,9,7,6,5,5,4,4,4}, {4,4,6,7,8,9,9,9,7,7,4,4,2,3,2,3,3,5,5,6,6,7,8,7}, {7,6,6,4,6,4,5,3,4,2,3,2,2,2,3,4,5,7,8,10,9,11,9,9}, {6,7,4,4,2,2,2,2,3,4,5,6,7,7,7,7,7,7,8,7,8,7,8,7}, {8,6,6,4,5,4,5,6,6,8,7,8,8,8,7,7,5,4,3,4,3,5,6,8}, {8,9,9,9,9,8,8,6,7,4,4,3,3,2,3,2,3,2,2,3,3,5,5,7}, {7,8,7,8,6,7,5,5,3,3,0,1,1,2,3,4,6,6,8,8,8,7,7,5}, {6,4,5,4,5,5,6,5,5,5,6,7,7,7,8,9,8,9,8,9,8,9,6,7}, {5,5,4,4,5,6,7,8,9,8,9,9,9,8,7,6,6,4,6,5,6,6,7,7}, {8,8,8,9,8,8,7,8,6,7,6,5,4,4,3,3,2,3,3,4,6,7,9,9}, {11,9,11,9,9,6,6,4,4,2,3,1,2,3,4,5,5,6,6,7,6,8,7,8}, {7,8,7,8,7,6,6,5,4,4,5,5,6,7,8,7,8,7,7,5,6,4,4,4}, {5,4,5,6,7,9,9,10,10,9,8,9,7,7,6,6,4,4,2,3,2,2,2,3}, {3,4,6,6,7,8,9,8,9,7,6,4,4,2,2,2,2,1,2,2,3,4,4,5}, {4,5,3,4,2,4,3,4,3,4,3,4,3,3,3,4,5,5,7,7,8,7,7,5}, {6,3,3,1,2,0,1,2,3,4,6,8,8,10,8,9,7,8,7,7,6,7,6,6}, {5,5,5,4,4,5,5,5,7,6,9,8,10,9,10,8,8,5,5,3,4,4,5,6}, {7,9,9,10,9,10,8,8,6,5,4,4,3,4,5,5,5,6,6,6,6,6,7,7}, {8,8,10,8,9,7,7,6,4,3,3,2,2,3,5,7,9,10,11,12,10,10,8,9}, {6,6,5,5,5,6,7,7,7,7,8,7,9,9,10,10,11,11,12,12,12,11,10,9}, {7,6,5,5,5,7,7,9,9,10,10,11,8,9,7,7,5,6,5,7,7,8,9,8}, {10,9,9,7,8,5,6,5,6,5,6,4,4,3,3,2,2,2,3,5,6,8,9,12}, {10,11,10,9,6,6,2,2,1,1,1,1,2,2,4,4,5,5,6,6,8,7,9,7}, {8,7,7,6,5,4,3,2,2,3,2,4,5,7,7,8,6,7,5,6,4,5,4,4}, {4,5,5,6,7,7,8,7,8,6,7,5,6,5,6,5,5,4,4,3,3,3,3,4}, {4,6,6,8,7,8,7,8,6,6,3,2,1,1,0,0,1,1,3,4,5,5,7,5}, {7,5,6,5,5,4,4,3,3,3,2,2,1,1,2,3,3,5,6,8,7,8,7,8}, {6,5,4,4,3,3,3,3,4,4,6,5,7,6,7,6,6,5,5,5,6,5,6,6}, {6,6,6,5,5,7,6,7,7,8,7,8,7,7,6,6,4,3,1,1,1,2,3,4}, {7,7,9,8,10,9,10,8,8,6,5,3,4,2,3,3,2,3,2,3,3,4,4,6}, {5,7,6,8,7,7,7,6,5,5,4,3,4,4,6,5,8,7,9,8,9,7,7,5}, {5,4,3,3,4,5,5,6,7,8,8,9,9,10,9,11,9,10,9,9,8,9,7,6}, {5,4,4,3,5,5,8,8,10,10,12,10,11,10,10,9,8,7,6,6,6,8,7,9}, {9,9,8,9,7,8,7,7,6,7,5,6,5,5,5,5,5,5,6,6,8,8,10,9}, {11,10,11,9,8,6,5,4,3,3,2,3,4,5,6,8,8,9,9,10,9,10,9,9}, {9,9,8,8,7,6,6,5,6,4,5,5,7,7,9,9,9,9,9,8,7,6,5,6}, {4,5,6,6,6,8,8,10,9,9,7,8,6,7,5,6,5,5,5,5,4,4,5,5}, {6,5,7,6,7,7,8,7,7,5,4,3,1,1,0,1,0,2,3,5,5,7,6,7}, {5,6,4,3,2,2,1,1,1,0,1,0,1,0,1,1,3,3,5,6,7,7,7,6}, {6,5,4,3,1,1,0,1,1,3,4,5,5,7,6,7,5,6,3,5,5,5,6,6}, {6,6,7,6,6,4,6,5,5,4,6,5,6,6,5,5,4,2,2,1,1,2,2,5}, {6,8,9,10,10,10,9,7,5,4,3,2,1,1,1,1,3,2,5,4,5,4,6,5}, {7,7,8,7,8,8,7,6,5,4,3,3,2,2,3,6,6,9,7,10,9,8,7,6}, {6,5,5,5,6,6,7,7,9,7,9,8,8,8,9,8,9,8,9,8,9,9,7,7}, {6,6,5,5,5,7,8,11,11,12,11,11,10,9,7,6,5,4,4,4,5,5,7,6}, {8,8,9,7,8,7,8,7,7,7,6,6,5,5,3,4,2,3,2,4,4,6,7,8}, {8,9,7,7,6,5,4,3,3,2,3,3,5,5,7,6,8,7,8,6,7,6,6,6}, {6,6,4,5,4,5,4,5,4,6,5,7,7,10,9,10,9,10,8,7,6,4,3,2}, {3,2,4,4,6,6,8,7,9,8,9,7,8,8,8,7,7,7,6,5,4,4,3,4}, {3,5,4,6,5,7,7,7,6,5,4,3,3,2,3,2,5,4,6,7,8,7,9,7}, {7,5,5,4,3,3,1,2,1,2,2,3,2,3,3,5,5,8,8,9,10,10,9,9}, {8,5,5,3,2,1,2,1,3,3,5,5,7,7,9,8,8,7,7,7,8,7,8,9}, {8,8,6,8,6,6,6,7,5,7,5,6,6,6,6,5,5,3,4,2,3,2,5,4}, {7,7,9,9,9,9,7,7,5,4,1,1,0,1,1,2,1,3,3,5,5,6,5,6}, {6,7,7,7,7,6,6,5,5,2,3,1,2,2,3,4,6,6,7,8,9,8,7,7}, {5,5,3,3,2,4,2,5,4,6,5,6,6,7,6,7,6,7,7,7,7,6,7,6}, {6,5,5,4,5,5,6,7,9,8,9,8,8,7,5,5,3,4,3,4,4,5,6,8}, {8,9,8,9,8,8,6,5,4,4,3,2,2,1,1,0,2,1,3,3,6,6,8,9}, {9,9,9,9,7,7,4,3,2,1,0,1,1,3,3,5,5,6,6,6,6,6,7,6}, {7,6,7,6,7,6,7,6,6,4,6,5,5,6,7,6,6,7,6,5,4,4,2,3}, {3,5,4,6,7,9,9,10,9,10,8,7,6,5,4,3,4,2,3,2,3,2,3,3}, {4,3,5,5,7,7,8,8,7,6,5,4,2,1,0,0,0,2,2,3,4,5,6,6}, {4,4,3,3,3,1,3,2,3,3,4,3,5,4,4,4,5,5,6,6,6,7,6,6}, {4,4,2,3,1,1,0,2,2,5,6,8,9,10,10,9,8,7,6,4,5,4,5,5}, {6,5,6,5,6,5,6,6,6,7,8,8,8,8,8,8,6,6,4,4,2,3,3,5}, {6,8,8,9,9,9,8,7,7,4,4,3,3,3,4,4,6,6,7,7,8,6,8,7}, {7,7,7,7,6,7,6,7,5,5,3,4,4,5,6,8,9,11,11,12,12,11,10,8}, {8,6,5,4,5,4,6,5,7,7,8,8,9,8,9,9,9,10,9,10,9,10,8,9}, {7,7,5,6,5,7,7,8,9,9,10,8,8,7,7,5,5,4,5,5,7,7,8,9}, {10,9,10,9,8,8,7,7,4,5,3,3,2,2,2,2,0,2,2,4,5,6,7,8}, {9,8,8,6,6,3,3,1,2,0,1,0,1,2,4,4,5,5,5,5,5,5,4,5}, {4,5,5,5,4,4,3,5,4,5,4,6,6,7,7,7,6,6,5,4,3,2,3,1}, {3,2,4,4,5,7,7,8,8,7,6,6,4,4,4,3,2,3,1,3,2,3,2,3}, {3,4,4,4,5,5,6,5,6,3,3,1,1,-1,0,0,1,2,4,4,6,7,7,7}, {6,6,4,4,2,2,1,1,0,2,1,1,1,2,3,4,4,5,5,6,7,8,8,7}, {8,5,6,3,3,2,3,2,3,3,5,5,6,6,6,7,5,5,4,5,4,5,4,6}, {5,7,6,8,7,8,8,8,7,6,7,5,6,5,6,3,4,2,2,1,1,1,3,4}, {5,7,8,9,9,10,9,9,6,6,4,3,1,1,1,2,2,3,4,5,4,5,5,5}, {5,4,5,4,5,5,6,5,5,4,5,4,5,4,5,6,7,7,8,8,8,8,7,6}, {4,3,1,3,2,3,4,5,7,8,9,10,10,10,10,9,9,7,9,7,8,6,7,5}, {5,4,4,4,4,4,6,7,7,9,9,10,9,9,8,8,6,6,4,5,5,7,7,8}, {8,8,8,8,7,6,5,4,4,3,4,3,4,4,5,5,6,5,6,7,8,8,8,10}, {9,10,8,8,5,4,2,2,0,0,0,1,2,4,6,8,9,9,9,8,9,7,8,6}, {7,5,6,4,5,4,5,4,4,4,4,5,5,7,7,8,8,9,8,8,7,7,5,6}, {4,5,4,5,6,8,8,8,8,7,6,4,4,2,3,2,2,2,3,2,4,4,4,4}, {4,4,4,5,4,5,4,5,3,3,1,0,-2,-2,-3,-2,-2,0,1,2,4,5,6,5}, {6,4,5,2,2,0,1,0,1,0,1,1,1,1,1,1,1,2,3,4,4,5,5,6}, {4,5,3,2,0,1,0,1,1,2,3,4,6,5,6,5,4,2,3,1,2,1,3,2}, {4,4,5,5,6,6,6,6,5,6,5,6,4,5,4,4,3,2,0,0,0,1,1,3}, {5,6,7,8,8,8,8,6,6,3,3,0,1,0,1,1,2,3,4,4,5,5,5,5}, {4,6,5,6,5,6,4,5,4,3,3,3,2,3,4,5,7,7,8,9,9,8,8,6}, {6,4,4,3,4,4,5,6,7,7,8,9,8,8,7,8,6,7,7,8,7,7,7,8}, {6,6,6,6,7,7,8,9,9,8,9,7,8,6,6,3,4,1,2,2,3,4,6,7}, {8,9,8,9,8,8,6,7,5,5,4,3,2,3,2,1,2,2,3,3,4,5,7,7}, {8,7,8,6,6,5,4,3,3,2,3,3,4,4,5,6,5,6,5,6,5,5,4,5}, {3,4,3,4,4,4,5,4,6,5,7,7,8,7,9,8,8,6,6,4,4,2,2,1}, {1,2,3,3,4,6,7,9,7,9,7,8,6,6,5,5,4,4,3,3,3,3,3,3}, {4,4,4,3,4,3,4,4,4,3,4,2,2,1,2,2,3,4,5,6,7,8,7,7}, {6,6,3,3,0,0,0,0,0,1,1,2,3,4,5,6,7,7,9,8,10,8,10,8}, {8,5,5,3,3,2,2,2,2,4,4,5,6,8,8,9,7,7,6,7,5,6,6,6}, {6,6,7,7,7,7,7,6,6,5,5,3,5,3,5,3,4,3,3,2,3,3,4,6}, {6,8,8,9,9,10,8,8,6,5,2,1,-1,0,-1,0,2,3,4,5,6,6,6,5}, {6,4,5,4,5,4,4,4,3,3,3,2,2,3,2,4,4,6,5,7,7,8,6,6}, {4,3,1,2,2,2,4,4,7,6,8,8,9,8,8,6,7,4,5,4,5,5,5,5}, {4,5,4,4,4,5,5,7,6,9,8,8,6,6,4,4,2,2,1,1,2,2,4,5}, {7,7,8,6,7,5,5,3,4,2,2,2,2,1,2,2,2,3,3,4,3,5,5,7}, {6,8,6,7,5,5,3,2,1,0,0,1,3,4,5,5,7,7,7,6,6,4,5,4}, {4,4,4,4,4,5,5,5,5,6,5,6,6,7,7,7,6,7,5,5,4,4,3,2}, {3,2,3,4,6,6,9,8,9,7,7,5,5,3,3,2,2,1,3,3,2,4,3,4}, {4,4,3,5,4,5,5,5,5,5,3,2,1,0,-1,-1,0,1,3,4,6,6,7,5}, {6,4,3,2,1,1,0,0,1,2,2,3,3,4,4,4,3,5,4,6,5,6,6,6}, {5,5,3,2,2,1,2,2,3,3,6,6,8,8,8,7,7,5,4,3,3,2,3,4}, {4,5,5,6,5,7,6,7,6,7,5,6,5,6,5,5,5,4,3,2,2,2,3,3}, {6,5,8,7,8,7,7,6,5,3,3,2,2,2,2,4,5,7,7,8,7,8,7,7}, {6,6,4,5,4,4,4,3,3,2,3,2,4,4,6,7,9,9,11,10,11,10,10,8}, {6,4,4,3,2,3,3,5,4,7,6,8,8,8,8,9,8,8,7,8,9,9,9,9}, {9,8,8,6,7,6,7,6,7,6,6,5,5,4,3,3,2,2,2,3,3,6,6,8}, {7,9,8,8,7,6,4,4,2,1,0,0,-1,-1,0,-1,0,0,3,3,5,5,6,6}, {7,6,7,5,5,4,3,2,1,1,0,1,0,2,2,4,4,5,3,4,3,4,3,3}, {3,3,3,3,3,3,5,4,6,4,5,4,5,4,5,4,4,3,2,2,1,1,0,1}, {0,1,1,3,4,5,5,8,7,7,6,6,3,2,2,1,0,0,0,1,1,1,2,2}, {3,2,3,3,4,3,4,3,3,2,1,1,0,0,-1,0,-1,1,1,3,4,6,5,7}, {5,5,3,2,1,0,1,0,0,-1,1,1,3,3,5,4,5,4,5,5,5,5,6,6}, {5,5,4,4,3,3,2,3,3,5,5,6,6,8,7,7,6,6,4,3,3,3,3,3}, {5,4,6,6,9,8,9,8,9,7,7,5,5,4,3,4,3,3,2,2,1,3,2,3}, {3,6,5,8,8,9,8,8,6,5,4,2,2,1,2,1,3,3,6,5,7,6,7,5}, {4,4,4,3,4,4,4,5,4,6,5,6,5,6,5,7,7,8,8,9,7,8,8,6}, {5,3,2,1,2,2,4,5,7,8,10,10,10,10,10,9,8,7,6,6,5,6,5,6}, {5,6,5,5,5,6,5,7,7,8,8,8,8,7,6,5,5,4,4,3,4,4,6,6}, {8,7,9,7,7,6,4,4,2,2,2,2,2,3,3,4,4,5,4,6,5,7,7,7}, {7,7,7,5,5,4,4,2,2,0,0,1,3,4,6,8,9,8,9,8,8,7,6,6}, {5,5,4,5,3,5,3,5,4,5,4,5,4,6,5,6,7,7,6,6,5,4,4,2}, {3,2,3,3,5,5,7,6,6,5,5,3,2,1,0,0,0,2,1,3,3,5,4,6}, {4,5,4,5,4,4,3,4,3,2,1,0,-1,-3,-2,-3,-1,-1,2,3,6,6,7,7}, {6,5,3,2,1,0,-1,0,-1,0,-1,0,1,2,2,2,1,2,2,3,3,4,5,4}, {5,4,4,2,2,1,2,2,3,3,5,4,6,6,6,5,5,3,2,1,0,1,1,2}, {2,5,4,7,6,7,7,7,6,6,5,4,3,3,2,1,3,1,1,1,1,0,2,2}, {4,3,6,5,6,7,7,6,4,4,2,1,0,1,1,2,2,4,4,6,6,7,6,6}, {5,4,3,3,3,3,4,3,4,3,5,4,5,4,6,7,8,7,9,8,9,9,7,7}, {5,5,3,3,2,3,3,6,6,8,8,10,10,9,8,7,7,6,7,6,6,5,6,6}, {7,6,7,6,7,7,7,7,8,8,7,7,7,6,4,4,2,3,1,3,3,4,5,6}, {7,8,8,8,7,7,6,4,4,3,3,1,2,1,3,2,2,2,4,3,5,5,5,5}, {5,6,5,5,4,4,3,4,3,3,2,3,3,5,5,6,7,7,5,5,5,4,3,2}, {3,1,2,2,3,2,5,5,6,6,8,7,8,8,7,7,6,6,5,4,2,3,1,2}, {0,2,1,2,2,4,6,6,7,7,6,5,5,4,4,2,3,2,3,2,4,3,4,4}, {4,3,4,2,2,2,2,2,1,2,1,1,1,1,1,2,2,4,4,6,7,9,9,8}, {7,6,5,2,1,-1,0,-2,-1,-2,1,1,3,4,6,6,7,6,7,6,7,7,7,8}, {6,7,5,5,3,3,2,2,2,3,3,5,5,6,7,7,8,6,6,4,5,4,5,5}, {7,6,9,9,10,10,9,9,7,6,3,3,2,2,1,2,1,3,2,4,3,5,4,5}, {5,6,6,7,8,8,8,6,6,2,2,-1,-1,-2,-2,-2,1,1,4,5,7,7,7,6}, {5,5,3,4,3,3,4,5,4,5,3,5,3,3,4,4,4,5,6,6,7,6,7,5}, {6,4,4,1,2,2,3,4,6,6,8,7,7,7,6,5,4,4,2,3,2,3,3,4}, {5,5,4,6,5,6,6,6,7,6,6,5,6,4,4,2,1,-1,1,-1,2,2,4,5}, {6,7,8,7,6,6,4,4,2,2,1,1,0,2,1,3,2,3,3,4,4,5,5,5}, {6,5,6,4,5,3,4,2,2,1,1,1,3,4,6,7,7,7,6,7,5,5,3,4}, {2,3,2,4,3,5,5,7,6,6,7,7,6,7,7,7,6,6,6,4,5,3,3,2}, {3,2,3,4,5,7,8,8,8,9,6,6,4,3,2,2,0,1,1,3,3,4,4,5}, {4,5,4,3,4,3,4,3,4,3,4,2,2,1,1,0,1,1,3,4,5,7,6,7}, {5,6,3,3,1,2,0,2,1,2,3,5,5,6,7,6,6,6,5,4,5,4,5,4}, {5,3,4,3,4,3,4,4,5,5,6,8,8,10,9,9,7,7,4,3,1,2,1,2}, {2,3,4,6,7,8,8,8,9,7,7,6,6,5,6,4,6,4,5,3,4,3,3,4}, {4,4,4,5,5,5,5,5,4,5,2,3,2,3,3,5,5,7,8,9,9,9,8,7}, {7,4,4,1,2,1,2,1,3,2,4,5,6,6,9,9,10,10,11,11,11,11,10,10}, {7,7,4,4,2,3,3,4,5,6,7,8,8,7,9,7,8,6,7,6,7,7,8,7}, {8,7,7,6,7,7,6,5,5,5,3,4,3,2,1,1,1,1,1,2,3,5,6,7}, {9,9,9,8,8,6,7,3,3,1,1,-1,-1,-2,-1,-1,1,2,3,4,4,5,5,6}, {5,6,5,6,4,4,3,3,2,1,1,1,0,2,2,3,4,4,4,4,4,3,3,1}, {2,1,2,2,3,4,5,6,6,6,6,6,5,5,4,4,2,3,1,2,0,2,1,1}, {1,0,2,2,3,4,6,6,8,6,6,4,3,1,1,-1,0,-1,0,0,1,2,3,4}, {3,4,2,2,1,2,0,1,0,1,0,1,0,1,0,0,1,1,2,3,5,5,7,5}, {7,4,5,2,2,0,-1,-2,-1,-1,1,2,3,4,5,6,5,6,5,6,5,6,5,5}, {4,5,4,5,4,4,4,4,4,4,6,6,7,7,8,7,7,5,5,4,4,2,3,3}, {4,5,6,8,9,10,10,10,8,8,5,5,3,3,2,3,3,4,4,4,4,4,4,4}, {5,5,7,7,8,7,9,7,7,5,4,2,2,1,2,3,4,5,6,7,8,8,7,8}, {6,6,3,3,3,4,4,5,5,6,6,7,6,7,7,7,8,7,9,7,9,8,8,6}, {6,4,3,2,3,4,4,6,7,9,9,10,10,10,9,9,7,6,5,5,4,5,5,5}, {6,6,6,6,7,5,7,6,8,7,8,6,7,6,5,4,4,2,2,2,2,4,5,6}, {6,7,7,7,5,5,3,4,2,2,1,2,2,3,4,5,5,6,7,6,7,6,7,6}, {6,5,5,4,4,3,2,2,1,1,1,2,3,5,6,8,8,9,8,9,7,7,5,5}, {2,2,1,1,2,3,4,5,5,5,5,5,6,5,6,6,7,6,6,5,5,5,5,4}, {4,4,3,4,4,7,6,8,6,7,4,4,1,1,-1,0,-1,0,1,3,4,5,7,6}, {7,6,6,4,5,2,2,1,2,0,1,-1,-2,-2,-2,-2,-1,0,1,4,4,6,6,8}, {6,7,5,4,3,2,1,1,1,1,1,3,3,3,4,3,4,2,4,2,3,3,5,4}, {5,5,6,5,5,5,6,6,6,7,6,6,5,7,5,5,4,4,1,1,-1,0,0,1}, {2,4,5,6,8,8,10,9,10,7,7,5,4,3,3,2,2,2,2,1,2,3,3,4}, {3,6,4,6,5,7,6,6,6,5,4,4,3,2,2,3,4,5,6,6,8,7,8,6}, {6,4,4,2,3,3,3,4,4,5,5,7,7,8,8,9,8,9,8,9,8,8,8,8}, {6,6,5,3,4,3,5,5,7,7,10,9,10,10,10,8,8,6,6,5,6,5,6,7}, {7,8,7,8,7,8,8,8,6,7,5,6,5,5,4,4,3,3,3,3,4,4,6,6}, {8,8,9,8,9,7,6,5,4,2,2,1,2,1,2,4,3,5,5,6,5,7,5,7}, {5,5,4,6,5,5,5,4,4,4,4,3,5,6,7,6,8,7,8,6,6,5,5,3}, {2,2,1,2,2,4,5,7,7,9,8,9,8,8,6,7,6,5,4,5,4,4,3,2}, {2,1,3,2,4,4,7,6,8,7,8,6,6,4,3,2,2,2,3,3,4,6,5,7}, {5,5,3,4,2,1,1,1,1,1,1,2,3,3,4,3,4,4,6,5,8,7,8,7}, {7,6,5,3,2,0,-1,0,-1,0,1,3,5,8,8,10,9,10,7,8,7,7,6,7}, {6,7,6,5,6,4,6,4,6,4,6,5,6,7,8,8,8,7,6,5,5,4,3,4}, {4,6,5,9,7,9,8,8,7,6,3,3,2,1,1,1,3,3,5,4,5,5,6,5}, {6,5,7,6,7,6,6,6,5,4,2,1,1,0,0,1,2,5,5,8,8,10,9,9}, {7,6,4,4,3,2,4,4,4,4,5,4,5,4,5,4,5,5,6,5,7,7,7,7}, {6,5,4,4,3,4,4,6,6,9,8,9,7,8,7,5,4,3,2,2,2,3,4,4}, {6,5,7,6,8,7,8,7,7,6,7,4,5,4,2,2,0,0,0,1,1,3,3,5}, {5,7,6,8,6,6,5,4,3,1,1,1,1,1,3,3,4,4,4,4,5,4,4,4}, {5,4,4,3,3,4,4,4,3,4,3,4,4,6,6,8,7,8,6,7,5,5,4,3}, {3,1,2,2,3,3,6,6,8,7,9,7,8,7,7,6,6,6,5,5,4,4,3,4}, {3,4,3,5,4,6,6,7,7,7,6,5,3,2,1,1,2,1,3,3,5,5,7,6}, {7,5,6,4,4,3,3,3,2,2,1,2,1,2,2,2,2,4,4,6,7,8,7,8}, {8,7,5,5,3,2,2,2,2,2,4,3,6,5,8,7,8,7,6,5,5,5,5,5}, {4,5,5,6,6,7,6,8,6,9,7,8,7,8,7,8,8,6,6,4,4,3,3,2}, {4,3,6,6,9,9,10,9,9,8,7,6,5,4,3,3,3,4,4,6,5,6,5,6}, {5,5,4,4,4,5,5,5,5,5,4,4,4,3,5,5,7,7,9,9,11,10,10,10}, {8,6,4,4,1,2,1,3,3,4,4,6,7,9,8,10,9,10,8,9,9,9,9,7}, {8,5,5,3,3,2,4,4,5,5,8,8,9,8,8,7,7,6,5,5,5,5,5,7}, {7,9,8,9,9,9,8,7,6,6,4,3,3,3,3,2,2,2,3,2,4,4,7,6}, {8,8,9,8,7,7,5,4,3,2,0,0,-1,0,0,2,2,4,4,6,5,5,5,5}, {5,4,4,4,5,4,5,4,5,4,5,3,4,4,6,5,6,6,6,5,4,4,3,3}, {1,3,1,3,2,5,5,8,8,9,8,8,6,5,5,4,3,3,2,2,2,1,2,1}, {3,1,2,3,4,5,6,6,7,7,7,5,4,3,1,0,-1,0,0,1,1,4,5,5}, {5,5,4,3,3,2,2,1,2,1,3,2,3,3,3,3,4,3,3,4,5,5,6,7}, {5,6,4,4,2,3,1,2,1,3,3,5,6,8,8,10,8,8,6,5,4,4,4,4}, {5,4,6,5,6,6,8,7,8,7,8,8,9,9,9,9,8,8,6,6,4,4,2,3}, {3,6,6,8,9,10,11,10,10,9,8,6,6,4,4,4,6,5,7,6,8,6,7,6}, {7,6,6,5,6,7,7,7,6,7,5,5,4,4,4,6,6,8,8,10,10,11,10,9}, {8,6,6,3,4,3,4,4,6,6,8,8,9,9,9,9,9,9,9,9,9,10,8,8}, {7,7,5,6,4,5,5,7,8,10,10,10,10,10,10,8,8,6,6,5,5,5,6,6}, {7,7,8,7,8,7,7,7,6,7,6,6,5,6,4,4,3,4,3,5,5,6,6,8}, {7,8,7,7,6,5,5,3,2,1,2,0,2,2,4,4,6,6,7,7,7,7,6,6}, {4,5,3,3,2,3,1,3,1,3,2,3,4,5,6,8,9,9,9,9,8,6,6,5}, {4,3,3,2,4,4,6,5,7,7,7,7,6,6,5,6,4,5,5,6,5,6,5,6}, {5,5,4,5,5,5,5,5,5,4,4,2,1,0,0,-1,0,0,2,2,5,5,7,7}, {7,8,6,6,4,3,2,3,1,1,0,1,0,0,0,1,2,3,3,5,5,7,8,7}, {8,7,7,5,5,3,3,1,3,2,3,3,4,5,6,6,6,5,5,4,4,4,3,5}, {3,5,5,6,6,8,8,9,8,8,8,7,7,6,6,6,5,4,4,2,3,1,2,1}, {3,3,6,6,8,9,10,11,10,10,8,7,4,4,2,3,2,2,2,4,4,6,5,5}, {5,4,5,4,5,5,6,5,6,4,5,4,5,4,4,4,6,6,7,7,8,8,8,8}, {7,6,3,3,2,3,2,4,4,6,7,8,9,9,9,10,9,8,9,8,7,6,7,6}, {6,5,6,5,5,5,5,6,7,9,9,10,10,11,9,9,6,7,4,6,4,5,4,6}, {6,8,8,9,9,9,9,8,8,6,6,5,5,4,5,3,4,3,4,3,4,4,5,6}, {7,8,7,8,7,8,6,7,4,4,2,3,2,3,3,5,6,7,8,7,8,6,6,5}, {6,4,4,3,5,4,5,5,6,6,6,6,6,6,7,8,8,9,7,8,7,7,4,4}, {2,2,1,2,3,5,6,8,10,10,10,9,9,8,7,6,6,4,5,5,5,4,5,4}, {4,3,4,4,3,5,5,7,6,7,6,6,5,4,2,2,1,2,2,4,5,6,8,8}, {8,6,6,4,3,1,2,0,1,0,2,2,4,3,4,4,5,6,6,6,7,8,8,9}, {8,9,6,6,3,3,2,1,1,2,2,4,6,6,8,8,9,8,8,6,7,4,5,4}, {5,5,7,5,6,6,6,6,6,7,6,6,5,6,5,7,6,7,5,5,4,4,3,4}, {5,5,7,8,10,9,11,10,10,7,6,3,3,2,2,1,3,2,5,5,6,7,7,8}, {7,7,6,7,5,6,5,6,5,5,3,3,1,2,2,3,3,5,6,7,8,9,9,8}, {9,6,7,4,4,3,4,4,5,6,7,7,8,8,7,7,7,7,6,6,6,7,6,8}, {6,7,5,6,6,7,7,7,9,9,10,9,10,8,7,5,5,3,3,1,2,2,4,4}, {6,6,7,8,8,9,8,9,7,8,6,6,4,4,3,3,1,2,1,1,2,3,4,4}, {6,6,7,6,6,5,6,4,5,3,4,3,4,3,4,5,5,7,6,6,5,5,4,4}, {2,3,2,3,2,3,3,4,5,6,6,6,7,8,9,9,10,8,9,7,7,5,4,2}, {2,0,1,1,2,3,5,7,8,10,9,10,9,9,7,7,5,7,4,5,4,5,4,4}, {4,4,4,4,5,5,6,6,6,5,6,4,5,4,3,3,3,3,4,4,5,7,7,9}, {7,7,5,6,4,4,2,2,1,2,2,3,3,3,4,5,6,6,7,7,7,7,8,7}, {8,7,7,5,5,4,5,3,4,4,5,6,7,8,9,10,9,10,8,8,5,6,5,5}, {4,5,5,6,6,8,10,9,10,9,10,8,9,8,8,7,8,6,7,5,6,4,4,4}, {4,4,4,6,7,9,9,11,9,9,7,8,5,5,3,4,4,5,5,6,8,8,9,7}, {8,6,6,4,4,3,4,4,4,4,5,4,5,5,5,6,6,8,8,9,9,10,9,9}, {7,6,4,3,1,1,1,2,2,3,5,6,8,9,10,9,9,8,9,8,9,7,9,8}, {8,7,7,6,6,6,6,6,6,7,7,8,7,8,7,7,6,5,4,4,4,5,6,7}, {8,8,9,9,9,8,8,6,5,3,2,1,0,0,1,1,2,2,2,3,3,4,5,7}, {7,8,7,8,7,7,6,5,3,2,0,-1,-1,0,1,2,4,5,6,6,6,6,6,5}, {5,4,5,4,5,5,5,5,5,4,4,5,3,4,4,5,4,5,5,5,5,4,4,3}, {3,2,2,2,4,4,7,7,10,8,10,7,7,5,4,2,3,1,2,2,2,2,3,4}, {3,4,4,4,4,5,5,7,5,7,5,5,3,2,1,-1,-1,-1,0,0,3,4,6,5}, {7,5,7,4,4,2,2,1,2,2,3,2,3,4,4,4,4,4,3,5,3,5,5,6}, {5,6,4,5,4,4,4,3,4,4,6,7,8,8,10,10,10,9,9,6,5,4,4,3}, {3,4,5,5,6,8,9,10,9,11,10,10,9,9,9,9,8,8,7,6,5,4,4,3}, {4,4,6,6,8,8,10,10,10,9,9,7,6,5,4,5,5,6,7,7,8,9,8,9}, {7,7,5,6,5,5,5,5,6,6,5,5,6,6,6,7,8,8,10,10,12,11,11,9}, {9,7,6,4,4,3,3,5,5,7,8,10,9,11,10,10,9,10,9,8,8,8,7,8}, {7,6,7,6,7,6,8,8,10,9,11,9,10,9,9,8,7,6,5,4,4,5,5,6}, {6,8,8,9,7,9,7,8,7,6,6,5,4,4,3,3,3,3,4,3,4,4,6,5}, {6,5,6,5,6,4,5,3,3,2,2,3,3,4,4,6,6,7,6,8,7,7,6,6}, {4,4,2,3,3,2,4,4,5,5,5,5,7,6,8,7,8,8,7,7,6,6,4,4}, {2,2,1,2,1,3,3,5,5,7,6,7,5,6,5,4,3,4,3,3,3,3,4,4}, {5,4,6,4,5,4,4,4,4,4,4,2,2,1,1,1,0,1,1,3,4,6,7,9}, {7,8,7,7,4,4,2,1,0,-1,0,0,0,1,2,3,4,4,5,4,6,5,7,6}, {7,6,7,6,6,5,5,5,4,5,4,5,5,6,7,8,7,8,5,6,4,3,3,3}, {4,4,6,5,8,8,11,11,11,10,11,7,8,6,5,4,4,3,3,3,3,4,3,4}, {3,5,4,7,7,9,9,10,9,9,8,7,5,3,2,1,2,1,3,3,6,6,7,7}, {7,5,5,4,5,4,4,5,5,5,5,6,5,6,5,7,6,6,6,7,7,8,8,8}, {6,6,4,3,3,2,3,3,5,6,8,8,11,11,11,10,10,8,7,6,7,6,6,6}, {5,6,5,5,5,5,6,7,7,9,9,11,9,10,9,8,7,6,5,3,3,3,4,4}, {7,6,9,7,9,8,8,6,6,5,5,4,4,4,4,5,4,6,4,6,5,6,5,6}, {6,7,5,6,5,6,5,4,4,2,2,1,3,3,5,6,8,8,9,9,9,8,7,6}, {5,4,3,2,3,3,4,5,5,7,6,8,6,8,8,9,8,9,8,9,8,7,6,5}, {4,2,3,1,3,3,6,7,9,9,10,8,7,7,5,5,4,4,3,4,5,6,5,6}, {5,6,4,5,4,5,4,5,4,4,5,5,4,3,3,1,1,0,2,3,6,6,9,8}, {9,7,7,5,4,3,2,1,0,0,0,1,2,4,4,5,5,6,4,6,4,6,6,6}, {6,5,5,3,3,2,3,2,3,2,4,4,6,6,8,8,9,8,7,5,5,4,2,3}, {2,4,4,5,6,8,7,10,8,9,8,8,6,6,6,5,5,5,5,3,4,3,4,3}, {4,4,6,6,7,7,8,8,7,6,5,3,2,1,0,1,1,3,3,5,5,7,7,8}, {7,7,5,4,4,3,4,4,4,3,4,3,4,3,4,4,6,6,7,8,8,9,9,9}, {8,8,5,6,4,4,3,5,4,6,6,8,7,8,7,7,7,6,6,5,5,5,6,5}, {6,6,7,6,8,7,8,8,9,9,9,7,7,6,5,4,3,2,1,1,1,2,2,4}, {4,7,7,9,9,9,9,8,7,5,5,3,3,1,1,1,1,0,2,1,3,2,4,3}, {5,5,5,5,5,6,5,5,4,4,2,3,2,4,3,5,5,6,5,6,5,5,4,2}, {2,1,1,1,2,1,4,4,6,6,8,8,8,7,8,8,8,7,6,5,5,4,2,3}, {1,2,0,2,1,3,5,7,8,10,10,10,9,8,6,5,4,3,3,3,4,3,4,3}, {5,4,5,4,5,4,4,5,4,5,4,4,4,4,2,3,2,3,3,4,4,7,7,7}, {8,8,6,6,4,3,3,1,2,0,2,1,4,4,6,7,8,7,8,8,7,7,6,7}, {6,7,6,6,5,6,4,6,4,6,5,7,7,9,9,10,10,10,9,8,7,5,5,3}, {4,3,6,4,7,8,10,10,11,10,10,10,9,8,7,7,6,7,6,7,6,7,6,6}, {5,6,5,6,6,8,8,8,9,8,7,5,5,3,4,1,4,3,6,6,8,8,9,8}, {8,7,5,4,3,3,2,3,3,4,3,5,5,6,6,7,6,8,8,9,9,9,9,8}, {8,6,6,4,4,2,3,2,4,5,7,8,9,9,9,8,8,7,6,6,5,5,5,5}, {5,6,5,6,5,6,5,6,6,7,7,6,7,7,6,5,5,2,3,1,2,1,2,3}, {5,6,7,7,8,8,7,7,5,5,2,2,1,1,1,2,2,3,3,4,3,4,4,5}, {5,4,4,4,5,4,5,3,3,2,2,0,2,1,3,3,5,6,6,6,6,5,4,4}, {2,2,1,2,1,3,3,5,5,6,6,7,6,6,6,6,6,6,6,6,5,3,4,2}, {3,1,2,1,3,3,6,8,8,9,9,9,6,6,4,3,1,1,0,2,2,3,3,5}, {4,5,4,4,4,4,4,4,5,4,5,3,4,2,2,0,0,-1,0,1,3,4,6,6}, {6,7,5,6,3,3,2,3,1,2,1,3,3,5,5,6,6,6,5,5,5,4,4,4}, {5,4,5,3,5,4,5,4,5,5,8,7,9,9,8,9,9,9,7,6,4,4,2,2}, {1,3,2,5,5,8,8,9,10,10,11,10,9,8,8,6,6,5,5,4,5,4,5,4}, {4,4,5,5,6,7,6,8,7,8,6,6,4,4,4,5,4,5,5,7,8,9,9,8}, {8,6,6,4,3,2,3,3,4,3,4,4,5,5,6,7,8,8,9,9,10,9,9,10}, {8,8,6,5,3,4,3,4,4,6,7,9,9,10,10,10,10,9,9,7,7,7,7,5}, {7,6,7,6,7,7,7,8,7,8,7,8,6,7,5,6,4,4,3,4,3,4,4,5}, {5,6,7,7,7,7,7,6,6,4,4,2,2,1,1,2,3,2,3,4,5,5,5,6}, {5,6,4,5,4,4,3,3,2,2,1,1,1,2,2,4,5,6,6,6,6,5,5,3}, {3,1,1,0,0,0,2,2,3,4,5,5,5,5,4,5,4,5,4,5,3,4,3,3}, {1,1,0,2,1,3,4,5,6,6,7,6,5,4,4,1,1,0,0,0,2,2,4,4}, {5,5,5,5,4,4,2,3,1,3,0,1,-1,0,0,0,-1,0,0,1,2,3,5,5}, {7,5,7,5,5,3,3,1,1,0,1,0,2,2,4,5,5,6,5,5,4,5,3,4}, {3,5,4,6,5,6,5,7,6,6,6,7,6,6,7,7,8,6,7,5,5,2,3,1}, {1,2,3,4,6,9,10,12,11,11,9,9,7,6,4,4,3,3,3,4,3,4,3,3}, {4,3,5,5,5,6,8,7,9,8,8,6,5,2,3,2,2,2,3,4,5,7,7,8}, {6,6,4,4,2,3,2,3,4,5,5,7,6,6,6,6,7,6,6,6,6,6,7,5}, {6,4,4,3,3,1,3,4,4,6,7,9,10,11,9,10,7,7,5,5,3,4,3,3}, {4,5,5,5,6,6,7,7,8,8,8,7,9,8,8,6,5,4,3,2,2,1,2,3}, {4,6,5,7,7,8,6,6,4,5,3,3,1,3,2,4,4,5,5,4,5,4,5,4}, {5,3,5,4,4,4,4,4,3,3,3,2,3,4,5,7,8,9,8,9,8,8,6,5}, {3,3,1,1,1,2,3,4,5,6,7,7,8,7,8,7,8,7,8,7,7,5,6,4}, {4,3,2,2,2,4,5,7,7,9,7,8,7,6,4,4,3,2,2,3,4,5,6,6}, {7,6,6,5,5,3,4,3,4,2,3,1,2,1,2,0,1,1,2,3,4,5,6,7}, {6,7,5,6,3,2,1,0,-1,0,0,1,2,3,5,5,6,5,6,5,5,3,4,3}, {4,3,4,4,5,4,4,5,5,6,6,6,6,7,6,7,7,7,6,6,4,3,2,2}, {2,1,2,3,4,6,7,7,9,8,8,6,6,4,4,3,3,2,3,3,3,3,4,4}, {3,5,4,5,4,5,4,6,5,6,4,4,3,2,1,2,2,3,4,5,7,7,8,7}, {8,6,6,3,4,2,2,1,3,3,3,3,4,4,5,5,5,7,7,8,6,7,7,8}, {7,7,4,4,4,3,4,4,5,5,7,7,8,8,9,8,8,6,6,5,4,3,4,4}, {5,5,5,6,7,9,8,10,8,10,7,7,6,5,5,5,3,2,1,1,1,1,2,2}, {4,5,6,5,7,7,8,7,7,5,4,3,2,1,1,1,2,2,2,3,3,3,3,4}, {2,3,1,3,2,4,4,4,4,4,4,4,4,4,5,4,5,6,6,5,6,3,3,2}, {1,-1,0,-2,-1,1,2,4,4,7,8,8,8,9,7,7,6,6,4,5,3,4,2,2}, {1,0,0,0,1,1,4,3,6,7,9,7,8,6,6,4,3,2,1,1,2,2,3,4}, {4,6,4,5,3,4,2,3,1,2,1,2,3,3,3,3,4,4,4,4,5,5,6,5}, {7,5,6,4,4,3,3,1,0,0,0,1,2,5,6,8,8,9,8,9,6,7,5,5}, {4,4,5,5,5,5,6,6,7,6,7,6,8,8,9,9,10,9,10,8,8,6,5,4}, {4,4,3,5,6,8,9,11,10,11,9,9,7,6,5,4,4,4,5,5,5,6,6,6}, {7,5,6,5,6,6,6,5,6,6,5,4,4,2,1,1,2,4,4,6,7,9,9,10}, {9,9,6,5,4,3,3,2,2,2,4,4,5,5,5,5,6,5,6,6,7,6,7,6}, {7,5,4,3,3,2,1,3,3,5,5,7,6,8,6,7,5,4,2,3,2,2,2,2}, {4,3,5,4,6,5,7,6,7,6,6,5,5,4,4,3,2,1,1,0,0,0,1,3}, {3,5,4,6,5,6,5,5,3,2,0,0,-1,-1,0,0,1,1,2,2,4,3,3,2}, {4,1,2,2,2,2,2,2,2,2,1,2,1,3,3,4,4,6,6,7,6,6,4,3}, {2,2,0,1,1,1,3,3,6,6,7,6,6,5,6,5,6,4,5,4,4,4,4,3}, {2,2,2,3,3,4,5,7,7,8,8,8,5,5,3,2,0,0,0,0,1,2,4,4}, {6,5,7,5,6,5,5,4,4,4,3,3,2,2,2,1,0,0,0,2,2,3,4,5}, {5,6,5,6,5,4,4,3,4,3,4,4,5,5,7,7,8,6,7,5,4,3,2,1}, {1,2,2,3,4,5,5,8,7,10,9,10,9,10,9,10,8,8,6,6,4,2,2,1}, {1,0,2,2,5,5,8,8,11,10,11,10,10,9,7,6,6,5,4,4,4,4,4,5}, {4,5,3,4,3,4,4,5,5,6,6,6,5,5,5,5,6,5,7,6,8,7,9,8}, {7,6,5,3,3,2,1,2,2,3,4,5,6,8,8,10,9,10,9,10,9,9,8,8}, {8,6,5,3,4,2,3,3,5,5,7,7,9,9,11,10,9,8,8,7,5,5,4,5}, {4,5,5,7,6,8,7,8,7,8,7,7,6,5,5,4,5,4,4,3,4,3,4,4}, {6,5,7,6,8,6,7,5,5,3,2,1,0,0,0,1,1,2,3,5,5,6,5,5}, {3,3,2,2,2,1,3,2,3,1,2,0,1,2,3,3,4,4,6,5,5,5,4,3}, {2,1,-1,-1,-1,1,1,4,4,6,6,7,6,6,5,4,3,3,3,2,2,2,2,2}, {2,1,1,0,2,2,3,3,5,5,5,5,5,3,2,1,-1,-1,-3,-1,-1,1,2,4}, {4,6,5,5,4,3,3,2,1,0,0,0,1,0,1,1,1,1,2,1,3,2,5,4}, {5,5,5,5,4,4,2,2,0,1,-1,2,1,3,4,6,6,8,6,7,5,5,4,3}, {3,3,3,3,4,4,6,6,7,6,7,7,7,6,7,8,8,7,7,6,5,5,3,3}, {2,3,3,5,6,8,9,10,11,10,9,8,6,5,4,2,3,3,3,3,5,5,6,5}, {7,5,6,5,6,5,6,6,6,6,5,5,4,3,2,2,1,3,3,5,5,7,7,7}, {7,7,5,4,4,2,3,2,4,3,6,5,7,6,7,6,7,6,6,5,6,6,5,6}, {4,5,3,4,2,4,3,5,5,8,8,10,9,10,9,9,7,6,4,3,2,1,2,1}, {3,2,4,4,6,6,7,8,8,7,8,7,7,7,6,5,4,4,1,2,1,2,1,3}, {2,4,3,5,5,6,6,5,5,3,4,2,3,2,4,4,5,5,6,6,6,5,5,4}, {3,2,1,1,1,1,1,2,2,4,3,4,4,5,6,8,8,9,9,8,8,7,6,4}, {4,0,0,-1,1,0,2,3,5,6,8,7,9,8,9,7,8,7,7,7,6,7,6,5}, {3,5,3,4,3,5,4,6,6,6,6,6,5,5,4,3,2,1,2,2,3,4,6,5}, {7,7,7,6,5,4,3,3,1,2,0,0,-1,1,0,2,1,3,2,3,3,5,5,6}, {7,6,7,5,6,5,5,2,3,2,2,2,3,3,4,5,6,6,6,5,4,4,3,3}, {2,3,2,4,3,5,5,7,6,8,8,9,7,6,6,5,5,4,4,3,3,2,2,1}, {1,1,2,3,4,6,7,9,10,10,9,8,7,6,3,3,1,1,0,2,2,4,4,5}, {5,6,4,4,4,4,5,4,6,4,5,3,4,2,3,2,3,2,3,4,5,6,7,7}, {7,7,4,4,2,2,1,3,2,3,3,5,5,7,7,8,7,7,7,6,6,5,6,5}, {7,4,6,5,5,4,6,5,6,6,7,7,9,9,9,9,7,6,4,4,3,3,2,3}, {3,5,4,7,8,9,9,9,9,8,7,6,5,4,4,2,3,2,3,1,2,2,2,3}, {4,4,5,6,6,7,7,7,5,5,3,3,1,1,1,1,1,3,3,4,4,4,4,3}, {3,2,2,2,2,2,3,3,5,5,5,4,5,4,5,5,5,6,6,6,5,5,4,3}, {1,1,-2,-1,-2,1,2,4,5,8,9,9,9,8,8,6,6,4,4,3,4,2,3,2}, {3,1,2,1,3,3,4,6,6,7,7,8,7,7,5,4,2,1,0,1,0,2,2,4}, {5,5,5,5,5,3,4,2,3,1,3,2,3,4,4,5,5,5,5,4,5,5,4,5}, {5,6,4,4,3,4,3,4,2,3,3,5,5,7,9,10,11,11,11,10,9,6,6,4}, {4,2,3,2,5,5,7,7,8,8,10,9,10,10,10,10,10,10,9,9,7,7,5,5}, {3,3,2,4,5,6,9,9,11,10,10,8,9,6,7,4,6,4,6,6,8,8,9,9}, {8,8,6,6,4,5,4,5,4,5,4,4,3,4,2,3,3,4,5,6,8,8,9,8}, {9,6,6,4,3,1,2,0,2,1,3,3,5,5,5,6,6,6,5,6,5,5,4,6}, {5,5,3,4,3,4,3,5,5,6,6,7,7,7,7,6,5,3,3,1,2,0,1,1}, {2,3,4,5,5,6,7,7,6,7,5,5,4,3,2,2,0,1,-1,-1,-1,0,0,1}, {2,3,4,4,4,4,5,4,5,3,2,0,1,0,1,1,2,2,3,3,4,3,3,4}, {2,2,1,1,0,1,1,2,2,3,3,4,4,5,5,5,6,6,6,6,6,5,4,3}, {2,0,0,-1,0,1,2,4,5,7,7,8,8,8,7,7,5,5,3,4,3,4,3,4}, {3,3,3,4,4,5,6,6,7,6,7,6,6,4,4,2,2,0,0,0,1,3,3,5}, {6,7,7,7,6,6,4,5,3,4,2,3,1,2,1,2,2,3,3,3,4,4,4,4}, {6,4,6,5,6,5,6,4,5,4,4,4,5,6,7,8,7,8,7,7,5,5,3,3}, {1,1,1,2,3,6,7,8,9,10,11,11,10,9,9,8,7,6,7,5,5,4,3,3}, {2,2,2,3,4,6,7,10,9,11,10,10,8,7,6,5,3,4,2,4,4,5,6,6}, {6,5,6,3,4,3,4,3,5,5,6,5,5,4,5,6,6,6,6,7,8,8,7,8}, {7,8,5,4,2,2,1,2,2,3,4,6,7,9,9,9,10,9,9,8,8,7,7,5}, {6,4,5,4,4,5,5,6,5,8,7,9,9,10,9,11,9,9,7,7,5,5,4,4}, {4,5,6,6,8,8,9,8,9,7,7,5,5,4,4,3,4,3,3,3,4,4,4,5}, {3,4,4,5,4,5,4,5,3,4,2,2,0,0,0,2,2,3,5,6,7,5,6,4}, {5,3,3,1,2,2,3,4,4,4,4,5,4,4,4,5,4,6,5,6,5,6,4,4}, {2,2,-1,0,0,0,2,3,5,6,8,7,8,6,5,3,3,1,2,0,2,2,2,3}, {3,3,2,3,3,4,4,6,5,7,6,6,4,5,3,3,0,0,-2,-1,-1,0,2,3}, {6,5,7,5,6,5,4,2,3,2,2,1,2,2,3,3,4,4,3,4,3,3,3,4}, {3,5,4,5,4,4,4,5,4,4,5,4,5,7,8,8,9,8,9,7,7,4,4,2}, {3,1,2,2,4,6,8,10,10,12,10,11,10,10,9,9,8,8,6,7,5,6,4,3}, {3,3,3,4,6,7,10,10,12,11,11,9,9,6,6,5,4,3,3,4,5,7,7,8}, {6,7,6,7,5,6,5,7,6,7,6,7,6,5,5,4,5,4,6,6,8,7,8,8}, {8,6,7,4,4,3,4,4,5,6,6,8,9,10,9,10,8,9,7,7,6,6,4,5}, {4,4,4,4,4,5,6,7,9,9,11,10,11,11,10,8,8,6,5,4,3,2,2,2}, {2,4,4,6,5,8,7,10,9,9,7,8,6,7,6,5,5,4,3,3,2,2,3,2}, {4,2,4,3,4,3,5,4,4,4,4,3,3,3,4,5,5,7,7,8,7,7,5,5}, {3,3,0,1,0,1,1,2,3,4,5,5,7,7,8,8,10,9,10,9,10,8,8,6}, {5,3,2,1,1,1,2,4,5,7,7,9,9,10,8,8,7,7,6,6,5,5,6,5}, {6,5,6,5,5,4,6,5,6,5,6,5,5,4,4,4,3,2,2,3,4,6,6,8}, {7,9,8,9,8,8,6,4,3,2,2,1,1,1,2,2,4,4,5,5,6,5,6,5}, {6,5,6,5,6,5,5,5,4,4,3,4,3,5,5,6,7,8,6,8,5,5,3,3}, {2,1,2,2,3,4,7,8,11,10,11,9,10,8,7,6,6,4,4,4,4,4,4,4}, {3,4,2,5,4,7,7,9,8,10,9,9,7,6,4,2,2,1,1,1,3,4,6,5}, {7,6,5,4,5,3,4,4,4,4,4,5,5,5,5,5,4,5,4,6,5,7,6,7}, {6,6,5,5,3,2,2,2,3,3,5,6,8,8,9,9,9,8,8,6,6,5,5,5}, {4,5,4,5,5,6,6,7,6,8,8,10,9,10,9,9,8,8,5,4,3,2,3,2}, {4,3,6,6,9,9,10,10,10,8,8,6,6,4,3,3,3,3,2,3,3,3,2,4}, {3,5,3,6,5,6,6,7,6,5,5,3,3,2,2,2,4,4,6,5,6,5,6,4}, {4,1,1,1,1,2,3,4,5,7,6,7,6,8,7,7,6,7,6,6,6,6,5,3}, {2,1,0,0,1,1,4,5,9,9,11,10,11,9,9,7,6,4,3,2,2,3,3,4}, {3,5,4,5,4,5,5,6,6,7,7,7,7,6,5,5,3,2,2,1,2,1,4,4}, {6,5,7,6,6,5,5,4,3,3,3,4,4,5,5,6,7,8,7,8,6,6,6,6}, {4,5,4,4,4,4,5,4,5,5,6,6,8,8,10,11,12,11,12,10,10,7,7,5}, {4,3,2,3,3,6,6,9,9,12,11,12,10,10,10,10,9,10,9,9,9,8,8,6}, {7,5,7,6,7,7,8,9,9,9,9,7,7,5,4,4,4,4,4,6,6,8,8,9}, {8,9,7,7,6,5,4,4,3,3,4,3,3,2,3,2,4,4,6,5,8,7,9,8}, {8,8,8,6,5,5,4,5,3,5,5,6,6,7,7,8,7,6,5,6,5,4,4,4}, {4,4,5,4,5,5,7,6,8,7,9,8,8,7,7,6,4,3,2,1,1,0,-1,1}, {1,3,3,5,6,8,8,9,9,8,7,6,5,4,3,1,1,0,1,0,1,1,2,1}, {3,1,3,3,4,4,5,5,4,5,4,4,3,3,3,3,3,5,5,6,5,5,4,3}, {2,1,0,-1,0,0,2,1,4,5,7,6,9,8,9,8,9,7,8,7,6,6,5,5}, {2,3,1,1,0,3,3,5,6,8,9,11,11,10,9,8,7,6,5,3,4,3,4,4}, {5,4,6,5,7,7,7,7,7,7,7,7,6,6,5,5,3,3,2,2,2,4,3,5}, {6,7,7,7,8,7,7,6,6,5,5,3,4,4,6,5,7,6,7,6,7,5,5,4}, {4,4,5,5,5,7,6,9,8,9,7,9,8,9,9,10,10,11,10,9,7,6,5,3}, {2,0,2,2,4,4,9,10,13,13,15,13,13,12,11,9,8,8,6,7,5,6,5,5}, {4,4,3,5,5,6,8,9,10,11,11,11,11,9,8,6,6,4,5,4,6,6,8,7}, {7,7,6,4,4,3,3,4,4,6,6,7,6,8,7,9,8,9,7,8,8,8,8,8}, {8,6,5,4,3,1,3,2,4,4,7,7,10,10,12,12,13,11,11,9,8,8,7,7}, {5,6,5,6,5,6,6,7,7,8,8,10,10,10,10,10,10,9,8,6,6,4,4,3}, {5,3,6,6,8,8,8,8,8,7,6,5,4,3,3,3,3,4,4,5,5,7,5,6}, {6,6,6,6,5,6,6,5,5,4,3,1,1,1,1,2,4,4,6,6,8,8,7,7}, {6,5,2,3,1,2,1,3,3,5,4,5,4,5,4,4,4,4,5,5,5,5,5,4}, {5,3,4,1,3,2,4,5,8,8,9,8,9,7,6,5,3,1,0,1,0,2,2,4}, {4,6,5,6,6,7,7,6,6,6,6,4,4,4,3,2,1,-1,0,-2,-1,0,2,3}, {4,6,6,6,7,6,5,6,4,5,3,4,3,4,4,6,5,6,5,5,4,5,4,3}, {4,2,4,3,5,4,6,6,8,6,9,7,10,8,10,10,10,10,9,9,8,6,5,4}, {1,3,2,3,3,6,7,10,11,13,12,13,12,12,11,10,9,8,7,6,7,6,6,5}, {6,4,5,5,7,8,9,9,10,11,10,10,8,8,6,6,4,5,5,6,6,8,8,8}
}

local solar_term_chinese = {"冬至", "小寒", "大寒", "立春", "雨水", "驚蟄", "春分", "清明", "穀雨", "立夏", "小滿", "芒種", "夏至", "小暑", "大暑", "立秋", "處暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪", "冬至", "小寒"}
local month_chinese = {"冬月","臘月","正月","二月","三月","四月","五月","六月","七月","八月","九月","十月"}
local day_chinese = {"初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"}
local celestial_stems = {"甲","乙","丙","丁","戊","己","庚","辛","壬","癸"}
local terrestrial_branches = {"子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"}

local function get_percent_day_chinese()
  local i = 0
  local j = 0
  local k = 0
  local percent_days = {}
  local chinese_numbers = {"一", "二", "三", "四"}
  local chinese_half_hours = {"初", "正"}
  while (i < 100) and (j < 25) do
    if (864 * i < 3600 * j) then
      k = k + 1
    elseif (864 * i == 3600 * j) then
      j = j + 1
      k = 0
    else
      j = j + 1
      k = 1
    end
    i = i + 1
    percent_day = {terrestrial_branches[j % 24 // 2 + 1] .. chinese_half_hours[j % 2 + 1]}
    if (k > 0) then
      table.insert(percent_day, chinese_numbers[k] .. "刻")
    end
    table.insert(percent_days, percent_day)
  end
  return percent_days
end

local percent_day_chinese = get_percent_day_chinese()

local function getJD(yyyy,mm,dd)
  local m1 = mm
  local yy = yyyy
  if (m1 <= 2) then
    m1 = m1 + 12
    yy = yy - 1
  end
  -- Gregorian calendar
  local b = yy // 400 - yy // 100 + yy // 4
  local jd = 365*yy - 679004 + b + math.floor(30.6001*(m1+1)) + dd + 2400000.5
  return jd
end

-- UT -> TT
local function DeltaT(T)
  local y = T*100 + 2000 + 0.5/365.25
  local DT = 0
  if (y > 2150) then
    local uu = 0.01*(y-1820)
    DT = -20 + 32*uu*uu
  elseif (y > 2050) then
    local uu = 0.01*(y-1820)
    DT = -20 + 32*uu*uu - 0.5628*(2150 - y)
  elseif (y > 2022) then
    local uu = y-2000
    -- DT = 62.92 + 0.32217*uu + 0.005589*uu*uu;
    DT = 59.59 + 0.32217*uu + 0.005589*uu*uu
  elseif (y > 2017.0020533881) then
    DT = 69.184
  elseif (y > 2015.4962354552) then
    DT = 68.184
  elseif (y > 2012.4982888433) then
    DT = 67.184
  elseif (y > 2009.0020533881) then
    DT = 66.184
  elseif (y > 2006.0013689254) then
    DT = 65.184
  elseif (y > 1999.0006844627) then
    DT = 64.184
  elseif (y > 1997.4976043806) then
    DT = 63.184
  elseif (y > 1996.0) then
    DT = 62.184
  elseif (y > 1994.4969199179) then
    DT = 61.184
  elseif (y > 1993.4976043806) then
    DT = 60.184
  elseif (y > 1992.4982888433) then
    DT = 59.184
  elseif (y > 1991.0006844627) then
    DT = 58.184
  elseif (y > 1990.0013689254) then
    DT = 57.184
  elseif (y > 1988.0) then
    DT = 56.184
  elseif (y > 1985.4976043806) then
    DT = 55.184
  elseif (y > 1983.4962354552) then
    DT = 54.184
  elseif (y > 1982.4969199179) then
    DT = 53.184
  elseif (y > 1981.4976043806) then
    DT = 52.184
  elseif (y > 1980.0) then
    DT = 51.184
  elseif (y > 1979.0006844627) then
    DT = 50.184
  elseif (y > 1978.0013689254) then
    DT = 49.184
  elseif (y > 1977.0020533881) then
    DT = 48.184
  elseif (y > 1976.0) then
    DT = 47.184
  elseif (y > 1975.0006844627) then
    DT = 46.184
  elseif (y > 1974.0013689254) then
    DT = 45.184
  elseif (y > 1973.0020533881) then
    DT = 44.184
  elseif (y > 1972.4982888433) then
    DT = 43.184
  elseif (y > 1972.0) then
    DT = 42.184
  elseif (y > 1961) then
    uu = y-1975
    uu2 = uu*uu
    uu3 = uu*uu2
    DT = 45.45 + 1.067*uu - uu2/260 - uu3/718
  elseif (y > 1941) then
    local uu = y-1950
    local uu2 = uu*uu
    local uu3 = uu*uu2
    DT = 29.07 + 0.407*uu - uu2/233 + uu3/2547
  elseif (y > 1920) then
    local uu = y-1920
    local uu2 = uu*uu
    local uu3 = uu2*uu
    DT = 21.2 + 0.84493*uu - 0.0761*uu2 + 0.0020936*uu3
  elseif (y > 1900) then
    local uu = y-1900
    local uu2=uu*uu
    local uu3=uu*uu2
    local uu4=uu2*uu2
    DT = -2.79 + 1.494119*uu - 0.0598939*uu2 + 0.0061966*uu3 - 0.000197*uu4
  end
  return DT/86400.0
end

local function mod2pi_de(x)
  return x - 2 * math.pi * math.floor(0.5 * x/math.pi + 0.5)
end

local function decode_solar_terms(y, istart, offset_comp, solar_comp)
  local jd0 = getJD(y-1,12,31) - 1.0/3
  local delta_T = DeltaT((jd0-2451545 + 365.25*0.5)/36525)
  local offset = 2451545 - jd0 - delta_T
  local w = {2*math.pi, 6.282886, 12.565772, 0.337563, 83.99505, 77.712164, 5.7533, 3.9301}
  local poly_coefs = {}
  local amp = {}
  local ph = {}
  if (y > 2500) then
    poly_coefs = {-10.60617210417765, 365.2421759265393, -2.701502510496315e-08, 2.303900971263569e-12}
    amp = {0.1736157870707964, 1.914572713893651, 0.0113716862045686, 0.004885711219368455, 0.0004032584498264633, 0.001736052092601642, 0.002035081600709588, 0.001360448706185977}
    ph = {-2.012792258215681, 2.824063083728992, -0.4826844382278376, 0.9488391363261893, 2.646697770061209, -0.2675341497460084, 0.9646288791219602, -1.808852094435626}
  elseif (y > 1500) then
    poly_coefs = {-10.6111079510509, 365.2421925947405, -3.888654930760874e-08, -5.434707919089998e-12}
    amp = {0.1633918030382493, 1.95409759473169, 0.01184405584067255, 0.004842563463555804, 0.0004137082581449113, 0.001732513547029885, 0.002025850272284684, 0.001363226024948773}
    ph = {-1.767045717746641, 2.832417615687159, -0.465176623256009, 0.9461667782644696, 2.713020913181211, -0.2031148059020781, 0.9980808019332812, -1.832536089597202}
  end

  local sterm = {}
  for i=1, #solar_comp do
    local Ls = (y - 2000) + (i-1 + istart)/24.0
    local s = poly_coefs[1] + offset + Ls*(poly_coefs[2] + Ls*(poly_coefs[3] + Ls*poly_coefs[4]))
    for j=1, 8 do
      local ang = mod2pi_de(w[j] * Ls) + ph[j]
      s = s + amp[j] * math.sin(ang)
    end
    local s1 = math.floor((s-math.floor(s))*1440 + 0.5)
    local datetime = s1 + 1441 * math.floor(s) + solar_comp[i] - offset_comp
    local day = datetime // 1441
    local hourminute = datetime - 1441 * day
    local hour = hourminute // 60
    local minute = hourminute - 60 * hour
    local the_date = os.time({year=y, month=1, day=day, hour=hour, min=minute})
    table.insert(sterm, the_date)
  end
  return sterm
end

local function decode_moon_phases(y, offset_comp, lunar_comp, dp)
  local w = {2*math.pi, 6.733776, 13.467552, 0.507989, 0.0273143, 0.507984, 20.201328, 6.225791, 7.24176, 5.32461, 12.058386, 0.901181, 5.832595, 12.56637061435917, 19.300146, 11.665189, 18.398965, 6.791174, 13.636974, 1.015968, 6.903198, 13.07437, 1.070354, 6.340578614359172}
  local poly_coefs = {}
  local amp = {}
  local ph = {}
  if (y > 2500) then
    poly_coefs = {5.093879710922470, 29.53058981687484, 2.670339910922144e-11, 1.807808217274283e-15}
    amp = {0.00306380948959271, 6.08567588841838, 0.3023856209133756, 0.07481389897992345, 0.0001587661348338354, 0.1740759063081489, 0.0004131985233772993, 0.005796584475300004, 0.008268929076163079, 0.003256244384807976, 0.000520983165608148, 0.003742624708965854, 1.709506053530008, 28216.70389751519, 1.598844831045378, 0.314745599206173, 6.602993931108911, 0.0003387269181720862, 0.009226112317341887, 0.00196073145843697, 0.001457643607929487, 6.467401779992282e-05, 0.0007716739483064076, 0.001378880922256705}
    ph = {-0.0001879456766404132, -2.745704167588171, -2.348884895288619, 1.420037528559222, -2.393586904955103, -0.3914194006325855, 1.183088056748942, -2.782692143601458, 0.4430565056744425, -0.4357413971405519, -3.081209195003025, 0.7945051912707899, -0.4010911170136437, 3.003035462639878e-10, 0.4040070684461441, 2.351831380989509, 2.748612213507844, 3.133002890683667, -0.6902922380876192, 0.09563473131477442, 2.056490394534053, 2.017507533465959, 2.394015964756036, -0.3466427504049927}
  elseif (y > 1500) then
    poly_coefs = {5.097475813506625, 29.53058886049267, 1.095399949433705e-10, -6.926279905270773e-16}
    amp = {0.003064332812182054, 0.8973816160666801, 0.03119866094731004, 0.07068988004978655, 0.0001583070735157395, 0.1762683983928151, 0.0004131592685474231, 0.005950873973350208, 0.008489324571543966, 0.00334306526160656, 0.00052946042568393, 0.003743585488835091, 0.2156913373736315, 44576.30467073629, 0.1050203948601217, 0.01883710371633125, 0.380047745859265, 0.0003472930592917774, 0.009225665415301823, 0.002061407071938891, 0.001454599562245767, 5.856419090840883e-05, 0.0007688706809666596, 0.001415547168551922}
    ph = {-0.0003231124735555465, 0.380955331199635, 0.762645225819612, 1.4676293538949, -2.15595770830073, -0.3633370464549665, 1.134950591549256, -2.808169363709888, 0.422381840383887, -0.4226859182049138, -3.091797336860658, 0.7563140142610324, -0.3787677293480213, 1.863828515720658e-10, 0.3794794147818532, -0.7671105159156101, -0.3850942687637987, -3.098506117162865, -0.6738173539748421, 0.09011906278589261, 2.089832317302934, 2.160228985413543, -0.6734226930504117, -0.3333652792566645}
  end

  local jd0 = getJD(y-1,12,31) - 1.0/3
  local delta_T = DeltaT((jd0-2451545 + 365.25*0.5)/36525)
  local offset = 2451545 - jd0 - delta_T
  local lsyn = 29.5306
  local p0 = lunar_comp[1]
  local jdL0 = 2451550.259469 + 0.5*p0*lsyn

  -- Find the lunation number of the first moon phase in the year
  local Lm0 = math.floor((jd0 + 1 - jdL0)/lsyn)-1
  local Lm = 0
  local s = 0
  local s1 = 0
  for i=1, 10 do
    Lm = Lm0 + 0.5*p0 + i-1
    s = poly_coefs[1] + offset + Lm*(poly_coefs[2] + Lm*(poly_coefs[3] + Lm*poly_coefs[4]))
    for j=1, 24 do
      local ang = mod2pi_de(w[j]*Lm) + ph[j]
      s = s + amp[j]*math.sin(ang)
    end
    s1 = math.floor((s-math.floor(s))*1440 + 0.5)
    s = s1 + 1441*math.floor(s) + lunar_comp[2] - offset_comp
    if (s > 1440) then
      break
    end
  end
  Lm0 = Lm
  local mphase = {}
  -- Now decompress the remaining moon-phase times
  for i=2, #lunar_comp do
    Lm = Lm0 + (i-2)*dp
    s = poly_coefs[1] + offset + Lm*(poly_coefs[2] + Lm*(poly_coefs[3] + Lm*poly_coefs[4]))
    for j=1, 24 do
      local ang = mod2pi_de(w[j]*Lm) + ph[j]
      s = s + amp[j]*math.sin(ang)
    end
    s1 = math.floor((s-math.floor(s))*1440 + 0.5)
    local datetime = s1 + 1441*math.floor(s) + lunar_comp[i] - offset_comp
    local day = datetime // 1441
    local hourminute = datetime - 1441 * day
    local hour = hourminute // 60
    local minute = hourminute - 60 * hour
    local the_date = os.time({year=y, month=1, day=day, hour=hour, min=minute})
    table.insert(mphase, the_date)
  end
  return mphase
end

local function solar_terms_in_year(year)
  -- year in [2000, 2500]
  return decode_solar_terms(year, 0, 5, sun_data[year + 1 - 2000])
end

local function moon_phase_in_year(year)
  -- year in [2000, 2500]
  return decode_moon_phases(year, 5, moon_data[year + 1 - 2000], 0.5), moon_data[year + 1 - 2000][1]
end

local function union(a, b)
  local result = {}
  for k,v in pairs ( a ) do
    table.insert( result, v )
  end
  for k,v in pairs ( b ) do
     table.insert( result, v )
  end
  return result
end

local function slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced+1] = tbl[i]
  end

  return sliced
end

local function stride(old_table, steplength)
  local new_table = {}
  local i = 0
  while i < #old_table do
    table.insert(new_table, old_table[i])
    i = i + 2
  end
  return new_table
end

local function datetime_to_date(datetime)
  local date_table = os.date("*t",datetime)
  date_table["hour"] = 0
  date_table["min"] = 0
  date_table["sec"] = 0
  return os.time(date_table)
end

local function to_local_timezone(time, tz)
  local unformated = os.date("%z")
  local sign, hours, minutes = string.match(unformated, "(-?)(%d%d)(%d%d)")
  hours = tonumber(hours)
  minutes = tonumber(minutes)
  if (sign == "-") then
    hours = -hours
    minutes = -minutes
  end
  local date_table = os.date("*t",time)
  date_table["hour"] = date_table["hour"] - tz + hours
  date_table["min"] = date_table["min"] + minutes
  return os.time(date_table)
end

local function ranked_index(date, dates)
  local i = 1
  while i <= #dates do
    if (to_local_timezone(dates[i], 8) > date) then
      break
    end
    i = i + 1
  end
  local date_diff = datetime_to_date(date) - datetime_to_date(to_local_timezone(dates[i - 1], 8))
  return i - 1, math.floor(date_diff / 3600 / 24 + 0.5)
end

local function chinese_number(num)
  local zhChar = {'一','二','三','四','五','六','七','八','九'}
  local places = {'','十','百','千','萬','十','百','千','億','十','百','千','萬'}
  if  type(num) ~=  'number' then
    return num .. 'is not a num'
  end
  local numStr = tostring(num)
  local len = string.len(numStr)
  local str = ''
  local has0 = false
  for i = 1, len do
    local n = tonumber(string.sub(numStr,i,i))
    local p = len - i + 1
    --連續多個零衹顯示一個
    if n > 0 and has0 == true then
      str = str .. '零'
      has0 = false
    end
    --十位數如果是首位則不顯示一十這樣的
    if p % 4 == 2 and n == 1 then
      if len > p then
        str = str .. zhChar[n]
      end
      str = str .. places[p]
    elseif n > 0 then
      str = str .. zhChar[n]
      str = str .. places[p]
    elseif n == 0 then
      --個位是零則補單位
      if p % 4 == 1 then
        str = str .. places[p]
      else
        has0 = true
      end
    end
  end
  return str
end

local function chinese_calendar_months(year)
  local moon_phase_previous_year, first_event = moon_phase_in_year(year - 1)
  local moon_phase = moon_phase_in_year(year)
  local moon_phase_next_year = moon_phase_in_year(year + 1)
  moon_phase = union(moon_phase_previous_year, union(moon_phase, {moon_phase_next_year[1]}))
  moon_phase = slice(moon_phase, first_event + 1, #moon_phase, 2)
  local solar_terms = solar_terms_in_year(year)
  local solar_terms_next_year = solar_terms_in_year(year + 1)
  solar_terms = union(solar_terms, solar_terms_next_year)
  solar_terms = stride(solar_terms, 2)

  local i = 7
  while i <= #moon_phase do
    if (solar_terms[1] < moon_phase[i]) then
      break
    end
    i = i + 1
  end
  moon_phase = slice(moon_phase, i - 1, #moon_phase)
  local months = {}
  i = 7
  while i <= #moon_phase do
    if (solar_terms[13] < moon_phase[i]) then
      break
    end
    i = i + 1
  end
  local month_in_year = i
  if (month_in_year == 14) then
    months = slice(union(month_chinese, month_chinese), 1, #moon_phase)
  elseif (month_in_year == 15) then
    local i = 1
    local j = 1
    local count = 0
    local solatice_in_month = {}
    while (i+1 <= #moon_phase) and (j <= #solar_terms) do
      if ((moon_phase[i] <= solar_terms[j]) and (moon_phase[i+1] > solar_terms[j])) then
        count = count + 1
        j = j + 1
      else
        table.insert(solatice_in_month, count)
        count = 0
        i = i + 1
      end
    end
    local leap = 0
    local leapLabel = ""
    for i=1, #solatice_in_month do
      if ((solatice_in_month[i] == 0) and leap == 0) then
        leap = 1
        leapLabel = "閏"
      else
        leapLabel = ""
      end
      local month_name = leapLabel .. month_chinese[(i -1 - leap) % 12 + 1]
      if (month_name == "閏正月") then
        month_name = "閏一月"
      end
      table.insert(months, month_name)
    end
  end
  return moon_phase, months
end

local function utc_timezone(unformated)
  local sign, hours, minutes = string.match(unformated, "(-?)(%d%d)(%d%d)")
  local fraction_hours = tonumber(hours) + tonumber(minutes) / 60
  if (sign == "") then
    sign = "+"
  end
  local timezone = "UTC " .. sign .. tostring(fraction_hours)
  timezone = string.gsub(timezone, "%.?0+$", "")
  return timezone
end

-- local function chinese_weekday(wday)
--   local wday_num = tonumber(wday) + 1
--   local chinese_weekdays = {"日", "月", "火", "水", "木", "金", "土"}
--   return chinese_weekdays[wday_num]
-- end

local function time_to_num(time)
  local pattern = "(%d+):(%d+) +([AP]M)"
  if string.match(time, pattern) ~= nil then
    local hours, minutes, am = string.match(time, pattern)
    if ((am == "AM") and (tonumber(hours) >= 12)) then
      hours = hours - 12
    elseif ((am == "PM") and (tonumber(hours) < 12)) then
      hours = hours + 12
    end
  else
    pattern = "(%d+):(%d+)"
    hours, minutes = string.match(time, pattern)
  end
  return (hours*60) + minutes
end

local function time_description_chinese(time)
  local time_table = os.date("*t", time)
  local time_in_seconds = time_table["hour"] * 3600 + time_table["min"] * 60 + time_table["sec"]
  local time_in_hours = time_in_seconds // 3600
  local chinese_half_hours = {"初", "正"}
  local chinese_hour = terrestrial_branches[(time_in_hours + 1) % 24 // 2 + 1] .. chinese_half_hours[(time_in_hours + 1) % 2 + 1]
  local percent_day = time_in_seconds // 864
  percent_day = percent_day_chinese[percent_day + 1]
  if (chinese_hour == percent_day[1]) then
    if (#percent_day > 1) then
      return  percent_day[1] .. percent_day[2]
    else
       return percent_day[1]
    end
  else
    return chinese_hour
  end
end

-- -- 西曆轉農曆
-- local function to_chinese_cal_local(time)
--   --西曆每月初已歷天数
--   local month_cum_passed_days = {0,31,59,90,120,151,181,212,243,273,304,334}
--   local curr_year = tonumber(os.date("%Y", time))
--   local curr_month = tonumber(os.date("%m", time))
--   local curr_day = tonumber(os.date("%d", time))
--   local days_since_reference_day = (curr_year - 1921) * 365 + math.floor((curr_year - 1921) / 4) + curr_day + month_cum_passed_days[curr_month] - 38
--   if (((curr_year % 4) == 0) and (curr_month > 2)) then
--     days_since_reference_day = days_since_reference_day + 1
--   end
--   local celeterre_date = celestial_stems[(days_since_reference_day - 3) % 10 + 1] .. terrestrial_branches[(days_since_reference_day + 1) % 12 + 1]

--   local eclipse, months = chinese_calendar_months(tonumber(os.date("%Y", time)))
--   local month_index, day_index = ranked_index(time, eclipse)
--   local chinese_month = months[month_index]
--   local chinese_day = day_chinese[day_index+1]
--   if ((chinese_month == "冬月") or (chinese_month == "閏冬月") or (chinese_month == "臘月") or (chinese_month == "閏臘月")) then
--     curr_year = curr_year - 1
--   end
--   local chinese_year = celestial_stems[(((curr_year - 4) % 60) % 10)+1] .. terrestrial_branches[(((curr_year - 4) % 60) % 12) + 1] .. "年"
--   return chinese_year .. chinese_month .. chinese_day, celeterre_date, chinese_year, chinese_month, chinese_day
-- end

-- local function to_chinese_cal(year, month, day)
--   --西曆每月初已歷天数
--   local month_cum_passed_days = {0,31,59,90,120,151,181,212,243,273,304,334}
--   --華曆數據
--   local chinese_cal_data = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
--   ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
--   ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
--   ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
--   ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
--   ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
--   ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
--   ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
--   ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
--   ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877}

--   local curr_year, curr_month, curr_day;
--   local days_since_reference_day, is_end, m, k, n, i, bit;
--   local chinese_year, chinese_date, celeterre_date;
--   --取西曆年、月、日
--   local curr_year = tonumber(year);
--   local curr_month = tonumber(month);
--   local curr_day = tonumber(day);
--   --計算自1921年2月8日正月初一已歷天數
--   local days_since_reference_day = (curr_year - 1921) * 365 + math.floor((curr_year - 1921) / 4) + curr_day + month_cum_passed_days[curr_month] - 38
--   if (((curr_year % 4) == 0) and (curr_month > 2)) then
--     days_since_reference_day = days_since_reference_day + 1
--   end

--   --干支計日
--   local celeterre_date = celestial_stems[(days_since_reference_day - 3) % 10 + 1] .. terrestrial_branches[(days_since_reference_day + 1) % 12 + 1]
--   --計算華曆天干、地支、月、日
--   local is_end = 0;
--   local m = 0;
--   while is_end ~= 1 do
--     if chinese_cal_data[m+1] < 4095 then
--       k = 11;
--     else
--       k = 12;
--     end
--     n = k;
--     while n >= 0 do
--       --獲取chinese_cal_data(m)的第n個二進制位值
--       bit = chinese_cal_data[m + 1];
--       for i=1, n do
--         bit = math.floor(bit / 2);
--       end
--       bit = bit % 2;
--       if days_since_reference_day <= (29 + bit) then
--         is_end = 1;
--         break
--       end
--       days_since_reference_day = days_since_reference_day - 29 - bit;
--       n = n - 1;
--     end
--     if is_end ~= 0 then
--       break;
--     end
--     m = m + 1;
--   end

--   curr_year = 1921 + m;
--   curr_month = k - n + 1;
--   curr_day = days_since_reference_day;
--   if k == 12 then
--     if curr_month == math.floor(chinese_cal_data[m+1] / 65536) + 1 then
--       curr_month = 1 - curr_month;
--     elseif curr_month > math.floor(chinese_cal_data[m+1] / 65536) + 1 then
--       curr_month = curr_month - 1;
--     end
--   end
--   curr_day = math.floor(curr_day)
--   --華曆天干、地支 -> chinese_year
--   chinese_year = celestial_stems[(((curr_year - 4) % 60) % 10)+1] .. terrestrial_branches[(((curr_year - 4) % 60) % 12) + 1] .. "年"

--   --華曆月、日 -> chinese_date
--   if curr_month < 1 then
--     chinese_date = "閏" .. month_chinese[(-1 * curr_month) + 1]
--   else
--     chinese_date = month_chinese[curr_month+1]
--   end

--   chinese_date = chinese_date .. "月" .. day_chinese[curr_day+1]
--   return chinese_year .. chinese_date, celeterre_date
-- end

local function date_diff_chinese(diff)
  local desp
  if (diff > 2) then
    desp = chinese_number(diff) .. "日後"
  elseif (diff == 2) then
    desp = "後日"
  elseif (diff == 1) then
    desp = "明日"
  elseif (diff == 0) then
    desp = "今日"
  elseif (diff == -1) then
    desp = "昨日"
  elseif (diff == -2) then
    desp = "前日"
  elseif (diff < -2) then
    desp = chinese_number(-diff) .. "日前"
  end
  return desp
end

-- 月相（圖示）
local function Moonphase_out1()
  local moon_phase_previous = moon_phase_in_year(tonumber(os.date("%Y")) - 1)
  local moon_phase, first_event = moon_phase_in_year(tonumber(os.date("%Y")))
  local moon_phase_next = moon_phase_in_year(tonumber(os.date("%Y")) + 1)
  local moon_phase = union({moon_phase_previous[#moon_phase_previous]}, union(moon_phase, {moon_phase_next[1]}))
  local first_event = 1 - first_event
  local index = ranked_index(os.time(), moon_phase)

  local date_diff_to_previous = os.time() - to_local_timezone(moon_phase[index], 8)
  local date_diff_to_approaching = to_local_timezone(moon_phase[index+1], 8) - os.time()
  local moon_phase_fraction = date_diff_to_previous / (date_diff_to_previous + date_diff_to_approaching) * 0.5
  if ((first_event + index - 1) % 2 == 1) then
    moon_phase_fraction = moon_phase_fraction + 0.5
  end
  local moon_phase_emojis = {"🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘"}
  local choice = math.floor((moon_phase_fraction * 8 + 0.5) % 8.0) + 1
  local Moonphase1 = moon_phase_emojis[choice]
  local Moonphase2 = string.format("%.f °", moon_phase_fraction * 360)
  return Moonphase1, Moonphase2
end

-- 月相（朔望文字）
local function Moonphase_out2()
  local moon_phase_previous = moon_phase_in_year(tonumber(os.date("%Y")) - 1)
  local moon_phase, first_event = moon_phase_in_year(tonumber(os.date("%Y")))
  local moon_phase_next = moon_phase_in_year(tonumber(os.date("%Y")) + 1)
  local moon_phase = union({moon_phase_previous[#moon_phase_previous]}, union(moon_phase, {moon_phase_next[1]}))
  local first_event = 1 - first_event
  local index = ranked_index(os.time(), moon_phase)
  local luna_event_names = {"朔", "望"}

  local previous_lunar_event = luna_event_names[(first_event + index - 1) % 2 + 1]
  local date_diff_to_previous = datetime_to_date(os.time()) - datetime_to_date(to_local_timezone(moon_phase[index], 8))
  local date_diff_to_previous = math.floor(date_diff_to_previous // 3600 //24 + 0.5)
  local date_diff_to_previous = date_diff_chinese(-date_diff_to_previous)
  local date_diff_to_previous = date_diff_to_previous .. time_description_chinese(to_local_timezone(moon_phase[index], 8))
  return previous_lunar_event, date_diff_to_previous
end

-- 前後節氣（文字）
local function jieqi_out1()
  local solar_terms = solar_terms_in_year(tonumber(os.date("%Y")))
  local solar_terms_next = solar_terms_in_year(tonumber(os.date("%Y")) + 1)
  local solar_terms = union(solar_terms, slice(solar_terms_next, 1, 2))
  local index = ranked_index(os.time(), solar_terms)

  local previous_solar_event = solar_term_chinese[index]
  local date_diff_to_previous = datetime_to_date(os.time()) - datetime_to_date(to_local_timezone(solar_terms[index], 8))
  local date_diff_to_previous = math.floor(date_diff_to_previous // 3600 //24 + 0.5)
  local date_diff_to_previous = date_diff_chinese(-date_diff_to_previous)
  local date_diff_to_previous = date_diff_to_previous .. time_description_chinese(to_local_timezone(solar_terms[index], 8))
  -- local candidate = Candidate("date", seg.start, seg._end, previous_solar_event, date_diff_to_previous)

  local approching_solar_event = solar_term_chinese[index+1]
  local date_diff_to_approaching = datetime_to_date(to_local_timezone(solar_terms[index+1], 8)) - datetime_to_date(os.time())
  local date_diff_to_approaching = math.floor(date_diff_to_approaching // 3600 //24 + 0.5)
  local date_diff_to_approaching = date_diff_chinese(date_diff_to_approaching)
  local date_diff_to_approaching = date_diff_to_approaching .. time_description_chinese( to_local_timezone(solar_terms[index+1], 8))
  -- candidate = Candidate("date", seg.start, seg._end, approching_solar_event, date_diff_to_approaching)
  return previous_solar_event, date_diff_to_previous, approching_solar_event, date_diff_to_approaching
end

-- 時區
local function timezone_out1()
  local timezone = utc_timezone(os.date("%z"))
  local timezone_discrpt = os.date("%Z")
  -- local candidate = Candidate("timezone", seg.start, seg._end, timezone, timezone_discrpt)
  return timezone, timezone_discrpt
end

-- 上下午時間
local function time_out1()
  -- local time = os.time()
  -- local time_string = string.gsub(os.date("%H:%M", time), "^0+", "")
  -- local time_discrpt = time_description_chinese(time)
  -- local candidate = Candidate("time", seg.start, seg._end, time_string, time_discrpt)
  -- 時分（前面去零）
  local time_string = string.gsub(os.date("%I:%M %p"), "^0", "")
  local time_string_2 = string.gsub(time_string, "AM", "a.m.")
  local time_string_2 = string.gsub(time_string_2, "PM", "p.m.")
  local time_string_3 = string.gsub(time_string, "AM", "A.M.")
  local time_string_3 = string.gsub(time_string_3, "PM", "P.M.")
  local time_string_4 = string.gsub(time_string, "AM", "am")
  local time_string_4 = string.gsub(time_string_4, "PM", "pm")
  -- 時分（前面有零）
  local time_string_0_1 = os.date("%I:%M %p")
  local time_string_0_2 = string.gsub(time_string_0_1, "AM", "a.m.")
  local time_string_0_2 = string.gsub(time_string_0_2, "PM", "p.m.")
  local time_string_0_3 = string.gsub(time_string_0_1, "AM", "A.M.")
  local time_string_0_3 = string.gsub(time_string_0_3, "PM", "P.M.")
  local time_string_0_4 = string.gsub(time_string_0_1, "AM", "am")
  local time_string_0_4 = string.gsub(time_string_0_4, "PM", "pm")
  -- 時分秒（前面去零）
  local time_string_5 = string.gsub(os.date("%I:%M:%S %p"), "^0", "")
  local time_string_6 = string.gsub(time_string_5, "AM", "a.m.")
  local time_string_6 = string.gsub(time_string_6, "PM", "p.m.")
  local time_string_7 = string.gsub(time_string_5, "AM", "A.M.")
  local time_string_7 = string.gsub(time_string_7, "PM", "P.M.")
  local time_string_8 = string.gsub(time_string_5, "AM", "am")
  local time_string_8 = string.gsub(time_string_8, "PM", "pm")
  -- 時分秒（前面有零）
  local time_string_00_1 = os.date("%I:%M:%S %p")
  local time_string_00_2 = string.gsub(time_string_00_1, "AM", "a.m.")
  local time_string_00_2 = string.gsub(time_string_00_2, "PM", "p.m.")
  local time_string_00_3 = string.gsub(time_string_00_1, "AM", "A.M.")
  local time_string_00_3 = string.gsub(time_string_00_3, "PM", "P.M.")
  local time_string_00_4 = string.gsub(time_string_00_1, "AM", "am")
  local time_string_00_4 = string.gsub(time_string_00_4, "PM", "pm")
  -- candidate = Candidate("time", seg.start, seg._end, time_string, time_discrpt)
  return time_string, time_string_2, time_string_3, time_string_4 , time_string_5, time_string_6, time_string_7, time_string_8, time_string_0_1, time_string_0_2, time_string_0_3, time_string_0_4, time_string_00_1, time_string_00_2, time_string_00_3, time_string_00_4
end

-- 中文上下午時間
local function time_out2()
  -- 時分（前面有零）
  local time_c_string = os.date("%p %I時%M分")
  local time_c_string = string.gsub(time_c_string, "AM", "上午")
  local time_c_string = string.gsub(time_c_string, "PM", "下午")
  local time_c_string_2 = os.date("%p %I點%M分")
  local time_c_string_2 = string.gsub(time_c_string_2, "AM", "上午")
  local time_c_string_2 = string.gsub(time_c_string_2, "PM", "下午")
  -- 時分秒（前面有零）
  local time_c_string_3 = os.date("%p %I時%M分%S秒")
  local time_c_string_3 = string.gsub(time_c_string_3, "AM", "上午")
  local time_c_string_3 = string.gsub(time_c_string_3, "PM", "下午")
  local time_c_string_4 = os.date("%p %I點%M分%S秒")
  local time_c_string_4 = string.gsub(time_c_string_4, "AM", "上午")
  local time_c_string_4 = string.gsub(time_c_string_4, "PM", "下午")
  -- 只有上下午
  local ampm = os.date("%p")
  local ampm =  string.gsub(ampm, "AM", "上午")
  local ampm =  string.gsub(ampm, "PM", "下午")
  return time_c_string, time_c_string_2, time_c_string_3, time_c_string_4, ampm
end




--- @@ date/t translator
--[[
掛載 t_translator 函數開始
--]]
function t_translator(input, seg)
  if (string.match(input, "`")~=nil) then
    -- 先展示星期，以便後面使用
    if (os.date("%w") == "0") then
      weekstr = "日"
      weekstr_c = "日"
      weekstr_jp1 = "㈰"
      weekstr_jp2 = "㊐"
      weekstr_jp3 = "日"
      weekstr_eng1 = "Sunday"
      weekstr_eng2 = "Sun."
      weekstr_eng3 = "Sun"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
      weekstr_c = "壹"
      weekstr_jp1 = "㈪"
      weekstr_jp2 = "㊊"
      weekstr_jp3 = "月"
      weekstr_eng1 = "Monday"
      weekstr_eng2 = "Mon."
      weekstr_eng3 = "Mon"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
      weekstr_c = "貳"
      weekstr_jp1 = "㈫"
      weekstr_jp2 = "㊋"
      weekstr_jp3 = "火"
      weekstr_eng1 = "Tuesday"
      weekstr_eng2 = "Tues."
      weekstr_eng3 = "Tues"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
      weekstr_c = "參"
      weekstr_jp1 = "㈬"
      weekstr_jp2 = "㊌"
      weekstr_jp3 = "水"
      weekstr_eng1 = "Wednesday"
      weekstr_eng2 = "Wed."
      weekstr_eng3 = "Wed"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
      weekstr_c = "肆"
      weekstr_jp1 = "㈭"
      weekstr_jp2 = "㊍"
      weekstr_jp3 = "木"
      weekstr_eng1 = "Thursday"
      weekstr_eng2 = "Thur."
      weekstr_eng3 = "Thur"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
      weekstr_c = "伍"
      weekstr_jp1 = "㈮"
      weekstr_jp2 = "㊎"
      weekstr_jp3 = "金"
      weekstr_eng1 = "Friday"
      weekstr_eng2 = "Fri."
      weekstr_eng3 = "Fri"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
      weekstr_c = "陸"
      weekstr_jp1 = "㈯"
      weekstr_jp2 = "㊏"
      weekstr_jp3 = "土"
      weekstr_eng1 = "Saturday"
      weekstr_eng2 = "Sat."
      weekstr_eng3 = "Sat"
    end

    -- lua 程式原生時間
    if (input == "`p") then
      yield(Candidate("time", seg.start, seg._end, os.date(), "〔 os.date() 〕"))
      yield(Candidate("time", seg.start, seg._end, os.time(), "〔 os.time()，當前距 1970.1.1.08:00 秒數〕"))
      return
    end

    -- Candidate(type, start, end, text, comment)
    if (input == "`t") then
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~d"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M:%S"), "^0", ""), "〔時:分:秒〕 ~d"))
      local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime6 , "〔時:分:秒〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕 ~c"))
      local a, b, aptime_c3, aptime_c4, ap = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c3, "0([%d])", "%1"), "〔時:分:秒〕 ~w"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~z"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~u"))
      return
    end

    if (input == "`tw") then
      local a, b, aptime_c3, aptime_c4 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c3, "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c4, "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(aptime_c3, "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(aptime_c4, "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime_c3, "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime_c4, "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(aptime_c3), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(aptime_c4), "〔時:分:秒〕"))
      return
    end

    if (input == "`tu") then
      local a, b, aptime_c3, aptime_c4, ap = time_out2()
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..chb_h_date(os.date("%I")).."時"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..chb_h_date(os.date("%I")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      return
    end

    if (input == "`td") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M:%S"), "^0", ""), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H"), "^0", "")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      return
    end

    if (input == "`tm") then
      local a, b, c, d, aptime5, aptime6, aptime7, aptime8, e, f, g, h, aptime00_1, aptime00_2,  aptime00_3, aptime00_4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime6 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime8 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime7 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime5 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime00_2 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime00_4 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime00_3 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime00_1 , "〔時:分:秒〕"))
      return
    end

    if (input == "`tc") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H點%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H點%M分%S秒"), "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分%S秒"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分%S秒"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H時%M分%S秒")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H點%M分%S秒")), "〔時:分:秒〕"))
      return
    end

    if (input == "`tz") then
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      return
    end

    -- if (input == "`tm") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
    --   return
    -- end

    if (input == "`u") then
      local tz, tzd = timezone_out1()
      yield(Candidate("time", seg.start, seg._end, tz, tzd))
      return
    end

    if (input == "`n") then
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~d"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M"), "^0", ""), "〔時:分〕 ~d"))
      local aptime1, aptime2, aptime3, aptime4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime2, "〔時:分〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕 ~c"))
      local aptime_c1, aptime_c2, a, b, ap = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c1, "0([%d])", "%1"), "〔時:分〕 ~w"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~z"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~u"))
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, chinese_time, "〔農曆〕 ~l"))
      return
    end

    if (input == "`nw") then
      local aptime_c1, aptime_c2 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c1, "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c2, "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(aptime_c1, "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(aptime_c2, "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime_c1, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime_c2, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(aptime_c1), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(aptime_c2), "〔時:分〕"))
      return
    end

    if (input == "`nu") then
      local a, b, c, d, ap = time_out2()
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..chb_h_date(os.date("%I")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..chb_h_date(os.date("%I")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      return
    end

    if (input == "`nd") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M"), "^0", ""), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H"), "^0", "")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      return
    end

    if (input == "`nm") then
      local aptime1, aptime2, aptime3, aptime4 , a, b, c, d, aptime0_1, aptime0_2,  aptime0_3, aptime0_4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime2, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime4, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime3, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime1, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime0_2, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime0_4, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime0_3, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime0_1, "〔時:分〕"))
      return
    end

    if (input == "`nc") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H點%M分"), "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H時%M分"), "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H點%M分"), "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H時%M分")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H點%M分")), "〔時:分〕"))
      return
    end

    if (input == "`nz") then
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      return
    end

    if (input == "`nl") then
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, chinese_time, "〔農曆〕"))
      local a, Y_g, M_g, D_g, H_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, H_g.."時" , "〔農曆干支〕"))
      return
    end

    -- if (input == "`ns") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
    --   return
    -- end

    if (input == "`l") then
      local Moonshape, Moonangle = Moonphase_out1()
      yield(Candidate("date", seg.start, seg._end, Moonshape, Moonangle))
      local p, d = Moonphase_out2()
      yield(Candidate("date", seg.start, seg._end, p, d))
      return
    end

    if (input == "`s") then
      local jq1, jq2, jq3 ,jq4 = jieqi_out1()
      yield(Candidate("date", seg.start, seg._end, jq1, jq2))
      yield(Candidate("date", seg.start, seg._end, jq3, jq4))
      -- local jqs = GetNowTimeJq(os.date("%Y%m%d"))
      local jqs = GetNextJQ(os.date("%Y"))
      for i =1,#jqs do
        yield(Candidate("date", seg.start, seg._end, jqs[i], "〔節氣〕"))
      end
      jqs = nil
      return
    end

    if (input == "`f") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕 ~j"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1, "〔農曆〕 ~l"))
      return
    end

    if (input == "`fl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ll_2, "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日" , "〔農曆干支〕"))
      return
    end

    if (input == "`fj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕"))
      return
    end

    if (input == "`fa") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fe") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔日月年〕"))
      return
    end

    if (input == "`fc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 "), "([^%d])0", "%1"), "〔*年月日*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 "), "〔*年月日*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔年月日〕"))
      return
    end

    if (input == "`fd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fs") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y"), "〔月日年〕"))
      return
    end

    if (input == "`fz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(), "〔年月日〕"))
      return
    end

    if (input == "`fn") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕 ~j"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local chinese_time = time_description_chinese(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1 .." ".. chinese_time, "〔農曆〕 ~l"))
      return
    end

    if (input == "`fnl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local chinese_time = time_description_chinese(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1 .." ".. chinese_time, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ll_2 .." ".. chinese_time, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, lunarJzl(os.date("%Y%m%d%H")), "〔農曆干支〕"))
      return
    end

    if (input == "`fnj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕"))
      return
    end

    if (input == "`fnc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 "), "([^%d])0", "%1"), "〔*年月日 時:分*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分"), "([^%d])0", "%1")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 "), "〔*年月日 時:分*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分", "〔年月日 時:分〕"))
      return
    end

    if (input == "`fnd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fns") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fnm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fnu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fnp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "`fnz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕"))
      return
    end

    if (input == "`ft") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕 ~j"))
      return
    end

    if (input == "`ftj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕"))
      return
    end

    if (input == "`ftc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒 "), "([^%d])0", "%1"), "〔*年月日 時:分:秒*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分%S秒"), "([^%d])0", "%1")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒 "), "〔*年月日 時:分:秒*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分%S秒"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分"..fullshape_number(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      return
    end

    if (input == "`ftd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`fts") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`ftm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`ftu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`ftp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "`ftz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔年月日 時:分〕"))
      return
    end

    if (input == "`y") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕 ~d"))
      -- local a, b, chinese_y = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1, "〔農曆〕 ~l"))
      return
    end

    if (input == "`yl") then
      -- local a, b, chinese_y = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ly_2, "〔農曆〕"))
      -- local a, Y_g = lunarJzl(os.date("%Y%m%d%H"))
      -- yield(Candidate("date", seg.start, seg._end, Y_g.."年", "〔農曆干支〕"))
      return
    end

    if (input == "`yc") then
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年"), "〔*年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年", "〔年〕"))
      return
    end

    if (input == "`yd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")), "〔年〕"))
      return
    end

    if (input == "`yz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      return
    end

    if (input == "`m") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0", ""), "〔月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕 ~j"))
      -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm, "〔農曆〕 ~l"))
      return
    end

    if (input == "`ml") then
      -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm, "〔農曆〕"))
      local a, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月", "〔農曆干支〕"))
      return
    end

    if (input == "`ma") then
      yield(Candidate("date", seg.start, seg._end, " "..eng1_m_date(os.date("%m")).." ", "〔*月*〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`me") then
      yield(Candidate("date", seg.start, seg._end, " "..eng2_m_date(os.date("%m")).." ", "〔*月*〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng3_m_date(os.date("%m")).." ", "〔*月*〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`mj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`mc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月"), "([ ])0", "%1"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0", ""), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月"), "^0", "")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月", "〔月〕"))
      return
    end

    if (input == "`mm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "`mz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      return
    end

    if (input == "`d") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0", ""), "〔日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕 ~j"))
      -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ld, "〔農曆〕 ~l"))
      return
    end

    if (input == "`dl") then
      -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ld, "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, D_g.."日", "〔農曆干支〕"))
      return
    end

    if (input == "`da") then
      yield(Candidate("date", seg.start, seg._end, " the "..eng1_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " The "..eng1_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "`de") then
      yield(Candidate("date", seg.start, seg._end, " "..eng2_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng4_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, eng4_d_date(os.date("%d")), "〔日〕"))
      -- yield(Candidate("date", seg.start, seg._end, " "..eng3_d_date(os.date("%d")).." ", "〔*日*〕"))
      return
    end

    if (input == "`dj") then
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "`dc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %d 日"), "([ ])0", "%1"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0", ""), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%d日"), "^0", "")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %d 日"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")).."日", "〔日〕"))
      return
    end

    if (input == "`dd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "`dz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      return
    end

    if (input == "`md") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕 ~j"))
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm .. ld, "〔農曆〕 ~l"))
      return
    end

    if (input == "`mdl") then
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm .. ld, "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月"..D_g.."日", "〔農曆干支〕"))
      return
    end

    if (input == "`mda") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔月日〕"))
      return
    end

    if (input == "`mde") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔日月〕"))
      return
    end

    if (input == "`mdj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕"))
      return
    end

    if (input == "`mdc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日 "), "([ ])0", "%1"), "〔*月日*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 "), "〔*月日*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔月日〕"))
      return
    end

    if (input == "`mdd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m"), "〔日月〕"))
      return
    end

    if (input == "`mds") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m"), "〔日月〕"))
      return
    end

    if (input == "`mdm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m"), "〔日月〕"))
      return
    end

    if (input == "`mdu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m"), "〔日月〕"))
      return
    end

    if (input == "`mdp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m"), "〔日月〕"))
      return
    end

    if (input == "`mdz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23), "〔月日〕"))
      return
    end

    if (input == "`mdw") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." ".."星期"..weekstr.." ", "〔月日週〕 ~c"))
      -- yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕 ~j"))
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld.." "..weekstr_jp3.." ", "〔農曆〕 ~l"))
      return
    end

    if (input == "`mdwl") then
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld.." "..weekstr_jp3.." ", "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月"..D_g.."日".." "..weekstr_jp3.." " , "〔農曆干支〕"))
      return
    end

    if (input == "`mdwa") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng3.." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔週月日〕"))
      return
    end

    if (input == "`mdwe") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月〕"))
      return
    end

    if (input == "`mdwc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日"), "([ ])0", "%1").." ".."星期"..weekstr.." ", "〔*月日週*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日").." ".."星期"..weekstr.." ", "〔*月日週*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日".." ".."星期"..weekstr.." ", "〔月日週〕"))
      return
    end

    if (input == "`mdwj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." "..weekstr_jp3.."曜日 ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."("..weekstr_jp3.."曜日)", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."（"..weekstr_jp3.."曜日）", "〔月日週〕"))
      return
    end

    if (input == "`mdwz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr_c.." ", "〔月日週〕"))
      return
    end

    if (input == "`ym") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕 ~j"))
      -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1 .. lm, "〔農曆〕 ~l"))
      return
    end

    if (input == "`yml") then
      -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1 .. lm, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ly_2 .. lm, "〔農曆〕"))
      local a, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月", "〔農曆干支〕"))
      return
    end

    if (input == "`yma") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕"))
      return
    end

    if (input == "`yme") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 "), "([^%d])0", "%1"), "〔*年月*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 "), "〔*年月*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月", "〔年月〕"))
      return
    end

    if (input == "`ymj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕"))
      return
    end

    if (input == "`ymd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%Y"), "〔月年〕"))
      return
    end

    if (input == "`yms") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%Y"), "〔月年〕"))
      return
    end

    if (input == "`ymz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(12), "〔年月〕"))
      return
    end

-- function week_translator0(input, seg)
    if (input == "`w") then
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstr, "〔週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, "週"..weekstr, "〔週〕 ~z"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕 ~a"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕 ~e"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕 ~j"))
      return
    end

    if (input == "`wa") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng1.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕"))
      return
    end

    if (input == "`we") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng2.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng3.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng3, "〔週〕"))
      return
    end

    if (input == "`wc") then
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstr, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."星期"..weekstr..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."星期"..weekstr.."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr_c.." ", "〔*週*〕"))
      return
    end

    if (input == "`wz") then
      yield(Candidate("qsj", seg.start, seg._end, " ".."週"..weekstr.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, "週"..weekstr, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."週"..weekstr..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."週"..weekstr.."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."週"..weekstr_c.." ", "〔*週*〕"))
      return
    end

    if (input == "`wj") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_jp3.."曜日 ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "("..weekstr_jp3.."曜日)", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（"..weekstr_jp3.."曜日）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp1, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp2, "〔週〕"))
      return
    end

-- function week_translator1(input, seg)
    if (input == "`fw") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔年月日週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕 ~z"))
      -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕 ~e"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕 ~j"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("qsj", seg.start, seg._end, ll_1.." "..weekstr_jp3.." ", "〔農曆〕 ~l"))
      return
    end

    if (input == "`fwl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("qsj", seg.start, seg._end, ll_1.." "..weekstr_jp3.." ", "〔農曆〕"))
      yield(Candidate("qsj", seg.start, seg._end, ll_2.." "..weekstr_jp3.." ", "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日".." "..weekstr_jp3.." " , "〔農曆干支〕"))
      return
    end

    if (input == "`fwa") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng3.." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      return
    end

    if (input == "`fwe") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      return
    end

    if (input == "`fwc") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔*年月日週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")).." 星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." ", "〔*年月日週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." ", "〔年月日週〕"))
      return
    end

    if (input == "`fwj") then
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕"))
      -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."("..weekstr_jp3.."曜日)", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."（"..weekstr_jp3.."曜日）", "〔年月日週〕"))
      return
    end

    if (input == "`fwz") then
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr_c.." ", "〔年月日週〕"))
      return
    end

-- function week_translator2(input, seg)
    -- if (input == "`fwt") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end

    -- if (input == "`fwtz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end
-- function week_translator3(input, seg)
    -- if (input == "`fwn") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔*年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

    -- if (input == "`fwnz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

--- 擴充模式 \r\n    日期 (年月日) ~d \r\n    年 ~y  月 ~m  日 ~day \r\n    年月 ~ym  月日 ~md \r\n    時間 (時分) ~n   (時分秒) ~t \r\n    日期時間 (年月日時分) ~dn\r\n    日期時間 (年月日時分秒) ~dt
    if(input=="`") then
    -- if input:find('^`$') then
      -- yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
      -- yield(Candidate("date", seg.start, seg._end, "║　d〔年月日〕┃   ym〔年月〕┃　md〔月日〕║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　y〔年〕　┃　　m〔月〕 ┃　　dy〔日〕 ║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　　n〔時:分〕　　 ┃　　　t〔時:分:秒〕　║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　dn〔年月日 時:分〕  ┃ dt〔年月日 時:分:秒〕║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║*/*/*〔 * 年 * 月 * 日〕┃　*-*-*〔*年*月*日〕 ║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　*/*〔 * 月 * 日〕   ┃　　 *-*〔*月*日〕　 ║" , ""))

      -- yield(Candidate("date", seg.start, seg._end, "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , ""))
      -- -- yield(Candidate("date", seg.start, seg._end, "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕┇ ○○○〔數字〕" , ""))
      -- -- yield(Candidate("date", seg.start, seg._end, "┃ ○○○〔數字〕" , ""))

      local date_table = {
        -- { '〔半角〕', '`' }
        { '  f〔年月日〕  ym〔年月〕  md〔月日〕', '⓪' }
      , { '  y〔年〕  m〔月〕  d〔日〕  w〔週〕', '①' }
      , { '  n〔時:分〕  t〔時:分:秒〕', '②' }
      , { '  fw〔年月日週〕  mdw〔月日週〕', '③' }
      , { '  fn〔年月日 時:分〕  ft〔年月日 時:分:秒〕', '④' }
      , { '  p〔程式格式〕  u〔時區〕  s〔節氣〕  l〔月相〕', '⑤' }
      , { '  ○○○〔數字〕', '⑥' }
      , { '  ○/○/○〔 ○ 年 ○ 月 ○ 日〕  ○/○〔 ○ 月 ○ 日〕', '⑦' }
      , { '  ○-○-○〔○年○月○日〕  ○-○〔○月○日〕', '⑧' }
      , { '  / [a-z]+〔小寫字母〕', '⑨' }
      , { '  ; [a-z]+〔大寫字母〕', '⑩' }
      , { '  \' [a-z]+〔開頭大寫字母〕', '⑪' }
      , { '  e [0-9a-f]+〔Percent/URL encoding〕', '⑫' }
      , { '  x [0-9a-f]+〔內碼十六進制 Hex〕', '⑬' }
      , { '  c [0-9]+〔內碼十進制 Dec〕', '⑭' }
      , { '  o [0-7]+〔內碼八進制 Oct〕', '⑮' }

      -- , { '〔夜思‧李白〕', '床前明月光，疑是地上霜。\r舉頭望明月，低頭思故鄉。' }
      }
      for k, v in ipairs(date_table) do
        local cand = Candidate('date', seg.start, seg._end, v[2], ' ' .. v[1])
        cand.preedit = input .. '\t《時間日期數字字母》▶'
        yield(cand)
      end
      return
    end

    if(input=="`/") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔小寫字母〕")
      cand2.preedit = input .. '\t《小寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="`;") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔大寫字母〕")
      cand2.preedit = input .. '\t《大寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="`'") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔開頭大寫字母〕")
      cand2.preedit = input .. '\t《開頭大寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="`x") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔內碼十六進制 Hex〕")
      cand2.preedit = input .. '\t《內碼十六進制》▶'
      yield(cand2)
      return
    end

    if(input=="`c") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9]+〔內碼十進制 Dec〕")
      cand2.preedit = input .. '\t《內碼十進制》▶'
      yield(cand2)
      return
    end

    if(input=="`o") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-7]+〔內碼八進制 Oct〕")
      cand2.preedit = input .. '\t《內碼八進制》▶'
      yield(cand2)
      return
    end

    if(input=="`e") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔Percent/URL encoding〕")
      cand2.preedit = input .. '\t《Percent/URL encoding》▶'
      yield(cand2)
      return
    end

    local englishout1 = string.match(input, "`/(%l+)$")
    if (englishout1~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, englishout1 , "〔一般字母小寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_l(englishout1) , "〔全形字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_1(englishout1) , "〔數學字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_2(englishout1) , "〔數學字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_3(englishout1) , "〔帶圈字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_4(englishout1) , "〔帶圈字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_5(englishout1) , "〔括號字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_6(englishout1) , "〔括號字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_7(englishout1) , "〔方框字母〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_8(englishout1) , "〔黑圈字母〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_9(englishout1) , "〔黑框字母〕"))
      return
    end

    local englishout2 = string.match(input, "`'(%l+)$")
    if (englishout2~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, string.upper(string.sub(englishout2,1,1)) .. string.sub(englishout2,2,-1) , "〔一般字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_ul(englishout2) , "〔全形字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1_2(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3_4(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5_6(englishout2) , "〔帶圈字母開頭大寫〕"))
      return
    end

    local englishout3 = string.match(input, "`;(%l+)$")
    if (englishout3~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, string.upper(englishout3) , "〔一般字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_u(englishout3) , "〔全形字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1(englishout3) , "〔數學字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3(englishout3) , "〔帶圈字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5(englishout3) , "〔括號字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_7(englishout3) , "〔方框字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_8(englishout3) , "〔黑圈字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_9(englishout3) , "〔黑框字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_s_u(englishout3) , "〔小型字母大寫〕"))
      return
    end

    local utf_input = string.match(input, "`([xco][0-9a-f]+)$")
    if (utf_input~=nil) then
      -- if string.sub(input, 1, 2) ~= "'/" then return end
      local dict = { c=10, x=16, o=8 } --{ u=16 } --{ d=10, u=16, e=8 }
      local snd = string.sub(utf_input, 1, 1)
      local n_bit = dict[snd]
      if n_bit == nil then return end
      local str = string.sub(utf_input, 2)
      local c = tonumber(str, n_bit)
      if c == nil then return end
      local utf_x = string.match(utf_input, "^x")
      local utf_o = string.match(utf_input, "^o")
      local utf_c = string.match(utf_input, "^c")
      if ( utf_x ~= nil) then
          -- local fmt = "U"..snd.."%"..(n_bit==16 and "X" or snd)
        fmt = "U+".."%X"
      elseif ( utf_o ~= nil) then
        fmt = "0o".."%o"
      else
        fmt = "&#".."%d"..";"
      end
      -- 單獨查找
      local cand_ui_s = Candidate("number", seg.start, seg._end, utf8_out(c), string.format(fmt, c) )
      cand_ui_s.preedit = "`" .. snd .. " " .. string.upper(string.sub(input, 3))
      yield(cand_ui_s)
      -- 區間查找
      -- if c*n_bit+n_bit-1 < 1048575 then
      --   for i = c*n_bit, c*n_bit+n_bit-1 do
      if c+16 < 1048575 then
        for i = c+1, c+16 do
          local cand_ui_m = Candidate("number", seg.start, seg._end, utf8_out(i), string.format(fmt, i) )
          cand_ui_m.preedit = "`" .. snd .. " " .. string.upper(string.sub(input, 3))
          yield(cand_ui_m)
        end
      end
    end


    local url_c_input = string.match(input, "`e([0-9a-z][0-9a-f]*)$")
    if (url_c_input~=nil) then
      local u_1 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f])$")
      local u_2 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
      local u_3 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
      local u_4 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
      if (u_1 ~= nil) or (u_2 ~= nil) or (u_3 ~= nil) or (u_4 ~= nil) then
        url_c_input = url_c_input .. '0'
      end
      local url_10 = url_decode(url_c_input)
      local uc_i = string.upper(string.sub(input, 3, 4)) .. " " .. string.upper(string.sub(input, 5, 6)) .. " " .. string.upper(string.sub(input, 7, 8)) .. " " .. string.upper(string.sub(input, 9, 10)) .. " " .. string.upper(string.sub(input, 11, 12)) .. " " .. string.upper(string.sub(input, 13, 14))
      local uc_i = string.gsub(uc_i, " +$", "" )
      if string.match(url_10, "無此編碼") ~= nil then
        yield(Candidate("number", seg.start, seg._end, url_10, '' ))
      elseif string.match(url_c_input, "^[0-9a-z]$") ~= nil then
        local cand_uci_a = Candidate("number", seg.start, seg._end, url_10, url_10 )
        cand_uci_a.preedit = "`e " .. uc_i
        yield(cand_uci_a)
      else
        -- local u_c = string.upper(url_c_input)
        -- local u_c = string.gsub(u_c, '^', '%%')
        -- local u_c = string.gsub(u_c, '^(%%..)(..)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(%%..%%..)(.+)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(%%..%%..%%..)(.+)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(%%..%%..%%..%%..)(.+)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(%%..%%..%%..%%..%%..)(.+)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(..)(.?.?)(.?.?)(.?.?)(.?.?)(.?.?)$', '%%%1%%%2%%%3%%%4%%%5%%%6')
        -- local u_c = string.gsub(u_c, '[%%]+$', '')
        -- yield(Candidate("number", seg.start, seg._end, utf8_out(url_10), u_c ))
        local cand_uci_s = Candidate("number", seg.start, seg._end, utf8_out(url_10), url_encode(utf8_out(url_10)) )
        cand_uci_s.preedit = "`e " .. uc_i
        yield(cand_uci_s)
      end
      -- if url_10*10+10-1 < 1048575 then
      --   for i = url_10*10, url_10*10+10-1 do
      if url_10+16 < 1048575 then
        for i = url_10+1, url_10+16 do
          local cand_uci_m = Candidate("number", seg.start, seg._end, utf8_out(i), url_encode(utf8_out(i)) )
          cand_uci_m.preedit = "`e " .. uc_i
          yield(cand_uci_m)
        end
      end
      return
    end


    local y, m, d = string.match(input, "`(%d+)/(%d?%d)/(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d).." "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      local ll_1, ll_2 = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
      if(Date2LunarDate~=nil) then
        yield(Candidate("date", seg.start, seg._end, ll_1, "〔西曆→農曆〕"))
        yield(Candidate("date", seg.start, seg._end, ll_2, "〔西曆→農曆〕"))
      end
      local All_g, Y_g, M_g, D_g = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
      if(All_g~=nil) then
        yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日", "〔西曆→農曆干支〕"))
      end
      local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
      local LDD2D_leap_year  = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
      if(Date2LunarDate~=nil) then
        yield(Candidate("date", seg.start, seg._end, LDD2D, "〔農曆→西曆〕"))
        yield(Candidate("date", seg.start, seg._end, LDD2D_leap_year, "〔農曆(閏)→西曆〕"))
      end
      return
    end

    local m, d = string.match(input, "`(%d?%d)/(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      return
    end

    local y, m, d = string.match(input, "`(%d+)-(%d?%d)-(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d).." "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      local ll_1, ll_2 = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
      if(Date2LunarDate~=nil) then
        yield(Candidate("date", seg.start, seg._end, ll_1, "〔西曆→農曆〕"))
        yield(Candidate("date", seg.start, seg._end, ll_2, "〔西曆→農曆〕"))
      end
      local All_g, Y_g, M_g, D_g = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
      if(All_g~=nil) then
        yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日", "〔西曆→農曆干支〕"))
      end
      local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
      local LDD2D_leap_year  = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
      if(Date2LunarDate~=nil) then
        yield(Candidate("date", seg.start, seg._end, LDD2D, "〔農曆→西曆〕"))
        yield(Candidate("date", seg.start, seg._end, LDD2D_leap_year, "〔農曆(閏)→西曆〕"))
      end
      -- local chinese_date_input2 = to_chinese_cal(y, m, d)
      -- if(chinese_date_input2~=nil) then
      --   yield(Candidate("date", seg.start, seg._end, chinese_date_input2 .. " ", "〔農曆，可能有誤！〕"))
      -- end
      return
    end

    local m, d = string.match(input, "`(%d?%d)-(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      return
    end

    -- local numberout = string.match(input, "'//?(%d+)$")
    local numberout, dot1, afterdot = string.match(input, "`(%d+)(%.?)(%d*)$")
    local nn = string.sub(numberout, 1)
    if (numberout~=nil) and (tonumber(nn)~=nil) then
      --[[ 用 yield 產生一個候選項
      候選項的構造函數是 Candidate，它有五個參數：
      - type: 字符串，表示候選項的類型（可隨意取）
      - start: 候選項對應的輸入串的起始位置
      - _end:  候選項對應的輸入串的結束位置
      - text:  候選項的文本
      - comment: 候選項的注釋
      --]]
      yield(Candidate("number", seg.start, seg._end, numberout .. dot1 .. afterdot , "〔一般數字〕"))

      if (string.len(numberout) < 4) then
        yield(Candidate("number", seg.start, seg._end, "," , "〔千分位〕"))
      else
        -- local k = string.sub(numberout, 1, -1) -- 取參數
        local result = formatnumberthousands(numberout) --- 調用算法
        yield(Candidate("number", seg.start, seg._end, result .. dot1 .. afterdot , "〔千分位〕"))
      end

      yield(Candidate("number", seg.start, seg._end, string.format("%E", numberout .. dot1 .. afterdot ), "〔科學計數〕"))
      yield(Candidate("number", seg.start, seg._end, string.format("%e", numberout .. dot1 .. afterdot ), "〔科學計數〕"))
      yield(Candidate("number", seg.start, seg._end, math1_number(numberout) .. dot1 .. math1_number(afterdot), "〔數學粗體數字〕"))
      yield(Candidate("number", seg.start, seg._end, math2_number(numberout) .. dot1 .. math2_number(afterdot), "〔數學空心數字〕"))
      yield(Candidate("number", seg.start, seg._end, fullshape_number(numberout) .. dot1 .. fullshape_number(afterdot), "〔全形數字〕"))

      if (dot1~='.') then
        yield(Candidate("number", seg.start, seg._end, little1_number(numberout), "〔上標數字〕"))
        yield(Candidate("number", seg.start, seg._end, little2_number(numberout), "〔下標數字〕"))

        for _, conf in ipairs(confs) do
          local r = read_number(conf, nn)
          yield(Candidate("number", seg.start, seg._end, r, conf.comment))
        end

        if (string.len(numberout) < 2) then
          yield(Candidate("number", seg.start, seg._end, "元整", "〔純中文數字〕"))
        else
          yield(Candidate("number", seg.start, seg._end, purech_number(numberout), "〔純中文數字〕"))
        end

        yield(Candidate("number", seg.start, seg._end, circled1_number(numberout), "〔帶圈數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled2_number(numberout), "〔帶圈無襯線數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled3_number(numberout), "〔反白帶圈數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled4_number(numberout), "〔反白帶圈無襯線數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled5_number(numberout), "〔帶圈中文數字〕"))

        if (tonumber(numberout)==1) or (tonumber(numberout)==0) then
          yield(Candidate("number", seg.start, seg._end, string.sub(numberout, -1), "〔二進位〕"))
        else
          yield(Candidate("number", seg.start, seg._end, Dec2bin(numberout), "〔二進位〕"))
        end

        yield(Candidate("number", seg.start, seg._end, string.format("%o",numberout), "〔八進位〕"))
        yield(Candidate("number", seg.start, seg._end, string.format("%X",numberout), "〔十六進位〕"))
        yield(Candidate("number", seg.start, seg._end, string.format("%x",numberout), "〔十六進位〕"))
      end
      return
    end

  end
end




--- @@ date/t2 translator
--[[
掛載 t2_translator 函數開始
--]]
function t2_translator(input, seg)
  if (string.match(input, "'/")~=nil) then
    -- 先展示星期，以便後面使用
    if (os.date("%w") == "0") then
      weekstr = "日"
      weekstr_c = "日"
      weekstr_jp1 = "㈰"
      weekstr_jp2 = "㊐"
      weekstr_jp3 = "日"
      weekstr_eng1 = "Sunday"
      weekstr_eng2 = "Sun."
      weekstr_eng3 = "Sun"
    end
    if (os.date("%w") == "1") then
      weekstr = "一"
      weekstr_c = "壹"
      weekstr_jp1 = "㈪"
      weekstr_jp2 = "㊊"
      weekstr_jp3 = "月"
      weekstr_eng1 = "Monday"
      weekstr_eng2 = "Mon."
      weekstr_eng3 = "Mon"
    end
    if (os.date("%w") == "2") then
      weekstr = "二"
      weekstr_c = "貳"
      weekstr_jp1 = "㈫"
      weekstr_jp2 = "㊋"
      weekstr_jp3 = "火"
      weekstr_eng1 = "Tuesday"
      weekstr_eng2 = "Tues."
      weekstr_eng3 = "Tues"
    end
    if (os.date("%w") == "3") then
      weekstr = "三"
      weekstr_c = "參"
      weekstr_jp1 = "㈬"
      weekstr_jp2 = "㊌"
      weekstr_jp3 = "水"
      weekstr_eng1 = "Wednesday"
      weekstr_eng2 = "Wed."
      weekstr_eng3 = "Wed"
    end
    if (os.date("%w") == "4") then
      weekstr = "四"
      weekstr_c = "肆"
      weekstr_jp1 = "㈭"
      weekstr_jp2 = "㊍"
      weekstr_jp3 = "木"
      weekstr_eng1 = "Thursday"
      weekstr_eng2 = "Thur."
      weekstr_eng3 = "Thur"
    end
    if (os.date("%w") == "5") then
      weekstr = "五"
      weekstr_c = "伍"
      weekstr_jp1 = "㈮"
      weekstr_jp2 = "㊎"
      weekstr_jp3 = "金"
      weekstr_eng1 = "Friday"
      weekstr_eng2 = "Fri."
      weekstr_eng3 = "Fri"
    end
    if (os.date("%w") == "6") then
      weekstr = "六"
      weekstr_c = "陸"
      weekstr_jp1 = "㈯"
      weekstr_jp2 = "㊏"
      weekstr_jp3 = "土"
      weekstr_eng1 = "Saturday"
      weekstr_eng2 = "Sat."
      weekstr_eng3 = "Sat"
    end

    -- lua 程式原生時間
    if (input == "'/p") then
      yield(Candidate("time", seg.start, seg._end, os.date(), "〔 os.date() 〕"))
      yield(Candidate("time", seg.start, seg._end, os.time(), "〔 os.time()，當前距 1970.1.1.08:00 秒數〕"))
      return
    end

    -- Candidate(type, start, end, text, comment)
    if (input == "'/t") then
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~m"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~d"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M:%S"), "^0", ""), "〔時:分:秒〕 ~d"))
      local a, b, c, d, aptime5, aptime6, aptime7, aptime8 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime6 , "〔時:分:秒〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕 ~c"))
      local a, b, aptime_c3, aptime_c4, ap = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c3, "0([%d])", "%1"), "〔時:分:秒〕 ~w"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~z"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕 ~u"))
      return
    end

    if (input == "'/tw") then
      local a, b, aptime_c3, aptime_c4 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c3, "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c4, "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(aptime_c3, "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(aptime_c4, "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime_c3, "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime_c4, "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(aptime_c3), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(aptime_c4), "〔時:分:秒〕"))
      return
    end

    if (input == "'/tu") then
      local a, b, aptime_c3, aptime_c4, ap = time_out2()
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..chb_h_date(os.date("%I")).."時"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..chb_h_date(os.date("%I")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      return
    end

    if (input == "'/td") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M:%S"), "^0", ""), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H"), "^0", "")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔時:分:秒〕"))
      return
    end

    if (input == "'/tm") then
      local a, b, c, d, aptime5, aptime6, aptime7, aptime8, e, f, g, h, aptime00_1, aptime00_2,  aptime00_3, aptime00_4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime6 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime8 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime7 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime5 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime00_2 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime00_4 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime00_3 , "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, aptime00_1 , "〔時:分:秒〕"))
      return
    end

    if (input == "'/tc") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H點%M分%S秒"), "0([%d])", "%1"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H時%M分%S秒"), "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H點%M分%S秒"), "0([%d])", "%1")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分%S秒"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分%S秒"), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H時%M分%S秒")), "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H點%M分%S秒")), "〔時:分:秒〕"))
      return
    end

    if (input == "'/tz") then
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔時:分:秒〕"))
      return
    end

    -- if (input == "'/tm") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
    --   return
    -- end

    if (input == "'/u") then
      local tz, tzd = timezone_out1()
      yield(Candidate("time", seg.start, seg._end, tz, tzd))
      return
    end

    if (input == "'/n") then
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕 ~s"))
      -- yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕 ~d"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M"), "^0", ""), "〔時:分〕 ~d"))
      local aptime1, aptime2, aptime3, aptime4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime2, "〔時:分〕 ~m"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕 ~c"))
      local aptime_c1, aptime_c2, a, b, ap = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c1, "0([%d])", "%1"), "〔時:分〕 ~w"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~z"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕 ~u"))
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, chinese_time, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/nw") then
      local aptime_c1, aptime_c2 = time_out2()
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c1, "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(aptime_c2, "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(aptime_c1, "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(aptime_c2, "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime_c1, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime_c2, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(aptime_c1), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(aptime_c2), "〔時:分〕"))
      return
    end

    if (input == "'/nu") then
      local a, b, c, d, ap = time_out2()
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..ch_h_date(os.date("%I")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..chb_h_date(os.date("%I")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ap.." "..chb_h_date(os.date("%I")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      return
    end

    if (input == "'/nd") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H:%M"), "^0", ""), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H"), "^0", "")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔時:分〕"))
      return
    end

    if (input == "'/nm") then
      local aptime1, aptime2, aptime3, aptime4 , a, b, c, d, aptime0_1, aptime0_2,  aptime0_3, aptime0_4 = time_out1()
      yield(Candidate("time", seg.start, seg._end, aptime2, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime4, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime3, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime1, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime0_2, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime0_4, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime0_3, "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, aptime0_1, "〔時:分〕"))
      return
    end

    if (input == "'/nc") then
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H時%M分"), "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, string.gsub(os.date("%H點%M分"), "0([%d])", "%1"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H時%M分"), "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(string.gsub(os.date("%H點%M分"), "0([%d])", "%1")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H時%M分"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, os.date("%H點%M分"), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H時%M分")), "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, fullshape_number(os.date("%H點%M分")), "〔時:分〕"))
      return
    end

    if (input == "'/nz") then
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."時"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."時"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      yield(Candidate("time", seg.start, seg._end, chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔時:分〕"))
      return
    end

    if (input == "'/nl") then
      local chinese_time = time_description_chinese(os.time())
      yield(Candidate("time", seg.start, seg._end, chinese_time, "〔農曆〕"))
      local a, Y_g, M_g, D_g, H_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, H_g.."時" , "〔農曆干支〕"))
      return
    end

    -- if (input == "'/ns") then
    --   yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔時:分:秒〕"))
    --   return
    -- end

    if (input == "'/l") then
      local Moonshape, Moonangle = Moonphase_out1()
      yield(Candidate("date", seg.start, seg._end, Moonshape, Moonangle))
      local p, d = Moonphase_out2()
      yield(Candidate("date", seg.start, seg._end, p, d))
      return
    end

    if (input == "'/s") then
      local jq1, jq2, jq3 ,jq4 = jieqi_out1()
      yield(Candidate("date", seg.start, seg._end, jq1, jq2))
      yield(Candidate("date", seg.start, seg._end, jq3, jq4))
      -- local jqs = GetNowTimeJq(os.date("%Y%m%d"))
      local jqs = GetNextJQ(os.date("%Y"))
      for i =1,#jqs do
        yield(Candidate("date", seg.start, seg._end, jqs[i], "〔節氣〕"))
      end
      jqs = nil
      return
    end

    if (input == "'/f") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕 ~j"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/fl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ll_2, "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日" , "〔農曆干支〕"))
      return
    end

    if (input == "'/fj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔年月日〕"))
      return
    end

    if (input == "'/fa") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fe") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔日月年〕"))
      return
    end

    if (input == "'/fc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 "), "([^%d])0", "%1"), "〔*年月日*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 "), "〔*年月日*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔年月日〕"))
      return
    end

    if (input == "'/fd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fs") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), "〔年月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y"), "〔日月年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y"), "〔月日年〕"))
      return
    end

    if (input == "'/fz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), "〔年月日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(), "〔年月日〕"))
      return
    end

    if (input == "'/fn") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕 ~j"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local chinese_time = time_description_chinese(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1 .." ".. chinese_time, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/fnl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local chinese_time = time_description_chinese(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ll_1 .." ".. chinese_time, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ll_2 .." ".. chinese_time, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, lunarJzl(os.date("%Y%m%d%H")), "〔農曆干支〕"))
      return
    end

    if (input == "'/fnj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M"), "〔年月日 時:分〕"))
      return
    end

    if (input == "'/fnc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 "), "([^%d])0", "%1"), "〔*年月日 時:分*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分"), "([^%d])0", "%1"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分"), "([^%d])0", "%1")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 "), "〔*年月日 時:分*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分", "〔年月日 時:分〕"))
      return
    end

    if (input == "'/fnd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fns") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fnm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fnu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fnp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), "〔年月日 時:分〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y %H:%M"), "〔日月年 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y %H:%M"), "〔月日年 時:分〕"))
      return
    end

    if (input == "'/fnz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分", "〔年月日 時:分〕"))
      return
    end

    if (input == "'/ft") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕 ~j"))
      return
    end

    if (input == "'/ftj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日 時:分:秒〕"))
      return
    end

    if (input == "'/ftc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒 "), "([^%d])0", "%1"), "〔*年月日 時:分:秒*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日 %H點%M分%S秒"), "([^%d])0", "%1"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日　%H點%M分%S秒"), "([^%d])0", "%1")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日 %H 點 %M 分 %S 秒 "), "〔*年月日 時:分:秒*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H點%M分%S秒"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日　"..fullshape_number(os.date("%H")).."點"..fullshape_number(os.date("%M")).."分"..fullshape_number(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      return
    end

    if (input == "'/ftd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/fts") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m/%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d/%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/ftm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m-%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d-%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/ftu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m_%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m_%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d_%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/ftp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M:%S"), "〔年月日 時:分:秒〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")).." "..fullshape_number(os.date("%H"))..":"..fullshape_number(os.date("%M"))..":"..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")).."　"..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m.%Y %H:%M:%S"), "〔日月年 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d.%Y %H:%M:%S"), "〔月日年 時:分:秒〕"))
      return
    end

    if (input == "'/ftz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1().." "..ch_h_date(os.date("%H")).."點"..ch_minsec_date(os.date("%M")).."分"..ch_minsec_date(os.date("%S")).."秒", "〔年月日 時:分:秒〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2().." "..chb_h_date(os.date("%H")).."點"..chb_minsec_date(os.date("%M")).."分"..chb_minsec_date(os.date("%S")).."秒", "〔年月日 時:分〕"))
      return
    end

    if (input == "'/y") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕 ~d"))
      -- local a, b, chinese_y = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/yl") then
      -- local a, b, chinese_y = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ly_2, "〔農曆〕"))
      -- local a, Y_g = lunarJzl(os.date("%Y%m%d%H"))
      -- yield(Candidate("date", seg.start, seg._end, Y_g.."年", "〔農曆干支〕"))
      return
    end

    if (input == "'/yc") then
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年"), "〔*年〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年", "〔年〕"))
      return
    end

    if (input == "'/yd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y"), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")), "〔年〕"))
      return
    end

    if (input == "'/yz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), "〔年〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(1), "〔年〕"))
      return
    end

    if (input == "'/m") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0", ""), "〔月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕 ~j"))
      -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/ml") then
      -- local a, b, y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm, "〔農曆〕"))
      local a, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月", "〔農曆干支〕"))
      return
    end

    if (input == "'/ma") then
      yield(Candidate("date", seg.start, seg._end, " "..eng1_m_date(os.date("%m")).." ", "〔*月*〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/me") then
      yield(Candidate("date", seg.start, seg._end, " "..eng2_m_date(os.date("%m")).." ", "〔*月*〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng3_m_date(os.date("%m")).." ", "〔*月*〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/mj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/mc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月"), "([ ])0", "%1"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月"), "^0", ""), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月"), "^0", "")), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月"), "〔*月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月", "〔月〕"))
      return
    end

    if (input == "'/mm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m"), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")), "〔月〕"))
      return
    end

    if (input == "'/mz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), "〔月〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(2), "〔月〕"))
      return
    end

    if (input == "'/d") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0", ""), "〔日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕 ~j"))
      -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ld, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/dl") then
      -- local a, b, y, m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, e, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ld, "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, D_g.."日", "〔農曆干支〕"))
      return
    end

    if (input == "'/da") then
      yield(Candidate("date", seg.start, seg._end, " the "..eng1_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " The "..eng1_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "'/de") then
      yield(Candidate("date", seg.start, seg._end, " "..eng2_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, " "..eng4_d_date(os.date("%d")).." ", "〔*日*〕"))
      yield(Candidate("date", seg.start, seg._end, eng4_d_date(os.date("%d")), "〔日〕"))
      -- yield(Candidate("date", seg.start, seg._end, " "..eng3_d_date(os.date("%d")).." ", "〔*日*〕"))
      return
    end

    if (input == "'/dj") then
      yield(Candidate("date", seg.start, seg._end, jp_d_date(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "'/dc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %d 日"), "([ ])0", "%1"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%d日"), "^0", ""), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%d日"), "^0", "")), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %d 日"), "〔*日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d日"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")).."日", "〔日〕"))
      return
    end

    if (input == "'/dd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%d"), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%d")), "〔日〕"))
      return
    end

    if (input == "'/dz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), "〔日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(3), "〔日〕"))
      return
    end

    if (input == "'/md") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔月日〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕 ~j"))
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm .. ld, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/mdl") then
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm .. ld, "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月"..D_g.."日", "〔農曆干支〕"))
      return
    end

    if (input == "'/mda") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔月日〕"))
      return
    end

    if (input == "'/mde") then
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔日月〕"))
      return
    end

    if (input == "'/mdj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")), "〔月日〕"))
      return
    end

    if (input == "'/mdc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日 "), "([ ])0", "%1"), "〔*月日*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日 "), "〔*月日*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日", "〔月日〕"))
      return
    end

    if (input == "'/mdd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m%d"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m"))..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d%m"), "〔日月〕"))
      return
    end

    if (input == "'/mds") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."/"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."／"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d/%m"), "〔日月〕"))
      return
    end

    if (input == "'/mdm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%d"), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."－"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d-%m"), "〔日月〕"))
      return
    end

    if (input == "'/mdu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."_"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."＿"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d_%m"), "〔日月〕"))
      return
    end

    if (input == "'/mdp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%d"), "〔月日〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."."..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."．"..fullshape_number(os.date("%d")), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%d.%m"), "〔日月〕"))
      return
    end

    if (input == "'/mdz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), "〔月日〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23), "〔月日〕"))
      return
    end

    if (input == "'/mdw") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." ".."星期"..weekstr.." ", "〔月日週〕 ~c"))
      -- yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕 ~z"))
      -- yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕 ~j"))
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld.." "..weekstr_jp3.." ", "〔農曆〕 ~l"))
      return
    end

    if (input == "'/mdwl") then
      -- local a, b, y, chinese_m, chinese_d = to_chinese_cal_local(os.time())
      local a, b, c, d, lm, ld = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, lm..ld.." "..weekstr_jp3.." ", "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, M_g.."月"..D_g.."日".." "..weekstr_jp3.." " , "〔農曆干支〕"))
      return
    end

    if (input == "'/mdwa") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng3.." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")), "〔週月日〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d")), "〔週月日〕"))
      return
    end

    if (input == "'/mdwe") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")), "〔週日月〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m")), "〔週日月〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月〕"))
      return
    end

    if (input == "'/mdwc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %m 月 %d 日"), "([ ])0", "%1").." ".."星期"..weekstr.." ", "〔*月日週*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%m月%d日"), "0([%d])", "%1").." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%m月%d日"), "0([%d])", "%1")).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %m 月 %d 日").." ".."星期"..weekstr.." ", "〔*月日週*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日".." ".."星期"..weekstr.." ", "〔月日週〕"))
      return
    end

    if (input == "'/mdwj") then
      yield(Candidate("date", seg.start, seg._end, jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").." "..weekstr_jp3.."曜日 ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."("..weekstr_jp3.."曜日)", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m月%d日").."（"..weekstr_jp3.."曜日）", "〔月日週〕"))
      return
    end

    if (input == "'/mdwz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23).." ".."星期"..weekstr.." ", "〔月日週〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23).." ".."星期"..weekstr_c.." ", "〔月日週〕"))
      return
    end

    if (input == "'/ym") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕 ~c"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕 ~z"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕 ~d"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕 ~p"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕 ~s"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕 ~m"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕 ~u"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕 ~e"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕 ~j"))
      -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1 .. lm, "〔農曆〕 ~l"))
      return
    end

    if (input == "'/yml") then
      -- local a, b, chinese_y, chinese_m = to_chinese_cal_local(os.time())
      local a, b, ly_1, ly_2, lm = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("date", seg.start, seg._end, ly_1 .. lm, "〔農曆〕"))
      yield(Candidate("date", seg.start, seg._end, ly_2 .. lm, "〔農曆〕"))
      local a, Y_g, M_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月", "〔農曆干支〕"))
      return
    end

    if (input == "'/yma") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m"))..", "..os.date("%Y"), "〔月年〕"))
      return
    end

    if (input == "'/yme") then
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(os.date("%m")).." "..os.date("%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymc") then
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 "), "([^%d])0", "%1"), "〔*年月*〕"))
      yield(Candidate("date", seg.start, seg._end, string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月"), "([^%d])0", "%1")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date(" %Y 年 %m 月 "), "〔*年月*〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月", "〔年月〕"))
      return
    end

    if (input == "'/ymj") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m")), "〔年月〕"))
      return
    end

    if (input == "'/ymd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y"))..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m%Y"), "〔月年〕"))
      return
    end

    if (input == "'/yms") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."/"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."／"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymm") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m"), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."－"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m-%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymu") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y_%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."_"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."＿"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m_%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymp") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m"), "〔年月〕"))
      -- yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."."..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(os.date("%Y")).."．"..fullshape_number(os.date("%m")), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, os.date("%m.%Y"), "〔月年〕"))
      return
    end

    if (input == "'/ymz") then
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), "〔年月〕"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(12), "〔年月〕"))
      return
    end

-- function week_translator0(input, seg)
    if (input == "'/w") then
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstr, "〔週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, "週"..weekstr, "〔週〕 ~z"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕 ~a"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕 ~e"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕 ~j"))
      return
    end

    if (input == "'/wa") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng1.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng1, "〔週〕"))
      return
    end

    if (input == "'/we") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng2.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng2, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_eng3.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_eng3, "〔週〕"))
      return
    end

    if (input == "'/wc") then
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, "星期"..weekstr, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."星期"..weekstr..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."星期"..weekstr.."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."星期"..weekstr_c.." ", "〔*週*〕"))
      return
    end

    if (input == "'/wz") then
      yield(Candidate("qsj", seg.start, seg._end, " ".."週"..weekstr.." ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, "週"..weekstr, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "(".."週"..weekstr..")", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（".."週"..weekstr.."）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, " ".."週"..weekstr_c.." ", "〔*週*〕"))
      return
    end

    if (input == "'/wj") then
      yield(Candidate("qsj", seg.start, seg._end, " "..weekstr_jp3.."曜日 ", "〔*週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp3.."曜日", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "("..weekstr_jp3.."曜日)", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, "（"..weekstr_jp3.."曜日）", "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp1, "〔週〕"))
      yield(Candidate("qsj", seg.start, seg._end, weekstr_jp2, "〔週〕"))
      return
    end

-- function week_translator1(input, seg)
    if (input == "'/fw") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔年月日週〕 ~c"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕 ~z"))
      -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕 ~a"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕 ~e"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕 ~j"))
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("qsj", seg.start, seg._end, ll_1.." "..weekstr_jp3.." ", "〔農曆〕 ~l"))
      return
    end

    if (input == "'/fwl") then
      -- local chinese_date = to_chinese_cal_local(os.time())
      local ll_1, ll_2 = Date2LunarDate(os.date("%Y%m%d"))
      yield(Candidate("qsj", seg.start, seg._end, ll_1.." "..weekstr_jp3.." ", "〔農曆〕"))
      yield(Candidate("qsj", seg.start, seg._end, ll_2.." "..weekstr_jp3.." ", "〔農曆〕"))
      local a, Y_g, M_g, D_g = lunarJzl(os.date("%Y%m%d%H"))
      yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日".." "..weekstr_jp3.." " , "〔農曆干支〕"))
      return
    end

    if (input == "'/fwa") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng2_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_m_date(os.date("%m")).." "..eng3_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng3.." "..eng3_m_date(os.date("%m")).." "..eng4_d_date(os.date("%d")).." "..os.date("%Y"), "〔週月日年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng1_m_date(os.date("%m")).." the "..eng1_d_date(os.date("%d"))..", "..os.date("%Y"), "〔週月日年〕"))
      return
    end

    if (input == "'/fwe") then
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng2_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", "..eng3_d_date(os.date("%d")).." "..eng1_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng2..", "..eng2_d_date(os.date("%d")).." "..eng2_m_date(os.date("%m")).." "..os.date("%Y"), "〔週日月年〕"))
      yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."the "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      -- yield(Candidate("date", seg.start, seg._end, weekstr_eng1..", ".."The "..eng1_d_date(os.date("%d")).." of "..eng1_m_date(os.date("%m"))..", "..os.date("%Y"), "〔週日月年〕"))
      return
    end

    if (input == "'/fwc") then
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date(" %Y 年 %m 月 %d 日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔*年月日週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1").." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(string.gsub(os.date("%Y年%m月%d日"), "([^%d])0", "%1")).." 星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." ", "〔*年月日週*〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." ", "〔年月日週〕"))
      return
    end

    if (input == "'/fwj") then
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." ", "〔年月日週〕"))
      -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."("..weekstr_jp3.."曜日)", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").."（"..weekstr_jp3.."曜日）", "〔年月日週〕"))
      return
    end

    if (input == "'/fwz") then
      yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." ", "〔年月日週〕"))
      yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr_c.." ", "〔年月日週〕"))
      return
    end

-- function week_translator2(input, seg)
    -- if (input == "'/fwt") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔*年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")).."："..fullshape_number(os.date("%S")), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end

    -- if (input == "'/fwtz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔年月日週 時:分:秒〕"))
    --   return
    -- end
-- function week_translator3(input, seg)
    -- if (input == "'/fwn") then
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date(" %Y 年 %m 月 %d 日").." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔*年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, fullshape_number(os.date("%Y")).."年"..fullshape_number(os.date("%m")).."月"..fullshape_number(os.date("%d")).."日 ".."星期"..weekstr.." "..fullshape_number(os.date("%H")).."："..fullshape_number(os.date("%M")), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." "..weekstr_jp3.."曜日 "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." ".."星期"..weekstr.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, os.date("%Y").."年 "..jp_m_date(os.date("%m"))..jp_d_date(os.date("%d")).." "..weekstr_jp1.." "..os.date("%H")..":"..os.date("%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕 ~z"))
    --   -- yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

    -- if (input == "'/fwnz") then
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx1().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   yield(Candidate("qsj", seg.start, seg._end, rqzdx2().." ".."星期"..weekstr.." "..os.date("%H:%M"), "〔年月日週 時:分〕"))
    --   return
    -- end

--- 擴充模式 \r\n    日期 (年月日) ~d \r\n    年 ~y  月 ~m  日 ~day \r\n    年月 ~ym  月日 ~md \r\n    時間 (時分) ~n   (時分秒) ~t \r\n    日期時間 (年月日時分) ~dn\r\n    日期時間 (年月日時分秒) ~dt
    if(input=="'/") then
    -- if input:find("^'/$") then
      -- yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
      -- yield(Candidate("date", seg.start, seg._end, "║　d〔年月日〕┃   ym〔年月〕┃　md〔月日〕║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　y〔年〕　┃　　m〔月〕 ┃　　dy〔日〕 ║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　　n〔時:分〕　　 ┃　　　t〔時:分:秒〕　║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　dn〔年月日 時:分〕  ┃ dt〔年月日 時:分:秒〕║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║*/*/*〔 * 年 * 月 * 日〕┃　*-*-*〔*年*月*日〕 ║" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "║　　*/*〔 * 月 * 日〕   ┃　　 *-*〔*月*日〕　 ║" , ""))

      -- yield(Candidate("date", seg.start, seg._end, "┃ f〔年月日〕┇ ym〔年月〕┇ md〔月日〕┇ fw〔年月日週〕┇ mdw〔月日週〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ y〔年〕┇ m〔月〕┇ d〔日〕┇ w〔週〕┇ n〔時:分〕┇ t〔時:分:秒〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ fn〔年月日 時:分〕┇ ft〔年月日 時:分:秒〕" , ""))
      -- -- yield(Candidate("date", seg.start, seg._end, "┃ fwn〔年月日週 時:分〕┇ fwt〔年月日週 時:分:秒〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○/○/○〔 ○ 年 ○ 月 ○ 日〕┇ ○/○〔 ○ 月 ○ 日〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○-○-○〔○年○月○日〕┇ ○-○〔○月○日〕" , ""))
      -- yield(Candidate("date", seg.start, seg._end, "┃ ○○○〔數字〕" , ""))

      local date_table = {
        { '  f〔年月日〕  ym〔年月〕  md〔月日〕', '⓪' }
      , { '  y〔年〕  m〔月〕  d〔日〕  w〔週〕', '①' }
      , { '  n〔時:分〕  t〔時:分:秒〕', '②' }
      , { '  fw〔年月日週〕  mdw〔月日週〕', '③' }
      , { '  fn〔年月日 時:分〕  ft〔年月日 時:分:秒〕', '④' }
      , { '  p〔程式格式〕  u〔時區〕  s〔節氣〕  l〔月相〕', '⑤' }
      , { '  ○○○〔數字〕', '⑥' }
      , { '  ○/○/○〔 ○ 年 ○ 月 ○ 日〕  ○/○〔 ○ 月 ○ 日〕', '⑦' }
      , { '  ○-○-○〔○年○月○日〕  ○-○〔○月○日〕', '⑧' }
      , { '  / [a-z]+〔小寫字母〕', '⑨' }
      , { '  ; [a-z]+〔大寫字母〕', '⑩' }
      , { '  \' [a-z]+〔開頭大寫字母〕', '⑪' }
      , { '  e [0-9a-f]+〔Percent/URL encoding〕', '⑫' }
      , { '  x [0-9a-f]+〔內碼十六進制 Hex〕', '⑬' }
      , { '  c [0-9]+〔內碼十進制 Dec〕', '⑭' }
      , { '  o [0-7]+〔內碼八進制 Oct〕', '⑮' }

      -- , { '〔夜思‧李白〕', '床前明月光，疑是地上霜。\r舉頭望明月，低頭思故鄉。' }
      }
      for k, v in ipairs(date_table) do
        local cand = Candidate('date', seg.start, seg._end, v[2], ' ' .. v[1])
        cand.preedit = input .. '\t《時間日期數字字母》▶'
        yield(cand)
      end
      return
    end

    if(input=="'//") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔小寫字母〕")
      cand2.preedit = input .. '\t《小寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="'/;") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔大寫字母〕")
      cand2.preedit = input .. '\t《大寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="'/'") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [a-z]+〔開頭大寫字母〕")
      cand2.preedit = input .. '\t《開頭大寫字母》▶'
      yield(cand2)
      return
    end

    if(input=="'/x") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔內碼十六進制 Hex〕")
      cand2.preedit = input .. '\t《內碼十六進制》▶'
      yield(cand2)
      return
    end

    if(input=="'/c") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9]+〔內碼十進制 Dec〕")
      cand2.preedit = input .. '\t《內碼十進制》▶'
      yield(cand2)
      return
    end

    if(input=="'/o") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-7]+〔內碼八進制 Oct〕")
      cand2.preedit = input .. '\t《內碼八進制》▶'
      yield(cand2)
      return
    end

    if(input=="'/e") then
      local cand2 = Candidate("letter", seg.start, seg._end, " " , "  [0-9a-f]+〔Percent/URL encoding〕")
      cand2.preedit = input .. '\t《Percent/URL encoding》▶'
      yield(cand2)
      return
    end

    local englishout1 = string.match(input, "'//(%l+)$")
    if (englishout1~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, englishout1 , "〔一般字母小寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_l(englishout1) , "〔全形字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_1(englishout1) , "〔數學字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_2(englishout1) , "〔數學字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_3(englishout1) , "〔帶圈字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_4(englishout1) , "〔帶圈字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_5(englishout1) , "〔括號字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_6(englishout1) , "〔括號字母小寫〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_7(englishout1) , "〔方框字母〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_8(englishout1) , "〔黑圈字母〕"))
      -- yield(Candidate("englishtype", seg.start, seg._end, english_9(englishout1) , "〔黑框字母〕"))
      return
    end

    local englishout2 = string.match(input, "'/'(%l+)$")
    if (englishout2~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, string.upper(string.sub(englishout2,1,1)) .. string.sub(englishout2,2,-1) , "〔一般字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_ul(englishout2) , "〔全形字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1_2(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3_4(englishout2) , "〔數學字母開頭大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5_6(englishout2) , "〔帶圈字母開頭大寫〕"))
      return
    end

    local englishout3 = string.match(input, "'/;(%l+)$")
    if (englishout3~=nil) then
      yield(Candidate("englishtype", seg.start, seg._end, string.upper(englishout3) , "〔一般字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_f_u(englishout3) , "〔全形字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_1(englishout3) , "〔數學字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_3(englishout3) , "〔帶圈字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_5(englishout3) , "〔括號字母大寫〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_7(englishout3) , "〔方框字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_8(englishout3) , "〔黑圈字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_9(englishout3) , "〔黑框字母〕"))
      yield(Candidate("englishtype", seg.start, seg._end, english_s_u(englishout3) , "〔小型字母大寫〕"))
      return
    end

    local utf_input = string.match(input, "'/([xco][0-9a-f]+)$")
    if (utf_input~=nil) then
      -- if string.sub(input, 1, 2) ~= "'/" then return end
      local dict = { c=10, x=16, o=8 } --{ u=16 } --{ d=10, u=16, e=8 }
      local snd = string.sub(utf_input, 1, 1)
      local n_bit = dict[snd]
      if n_bit == nil then return end
      local str = string.sub(utf_input, 2)
      local c = tonumber(str, n_bit)
      if c == nil then return end
      local utf_x = string.match(utf_input, "^x")
      local utf_o = string.match(utf_input, "^o")
      local utf_c = string.match(utf_input, "^c")
      if ( utf_x ~= nil) then
          -- local fmt = "U"..snd.."%"..(n_bit==16 and "X" or snd)
        fmt = "U+".."%X"
      elseif ( utf_o ~= nil) then
        fmt = "0o".."%o"
      else
        fmt = "&#".."%d"..";"
      end
      -- 單獨查找
      local cand_ui_s = Candidate("number", seg.start, seg._end, utf8_out(c), string.format(fmt, c) )
      cand_ui_s.preedit = "'/" .. snd .. " " .. string.upper(string.sub(input, 4))
      yield(cand_ui_s)
      -- 區間查找
      -- if c*n_bit+n_bit-1 < 1048575 then
      --   for i = c*n_bit, c*n_bit+n_bit-1 do
      if c+16 < 1048575 then
        for i = c+1, c+16 do
          local cand_ui_m = Candidate("number", seg.start, seg._end, utf8_out(i), string.format(fmt, i) )
          cand_ui_m.preedit = "'/" .. snd .. " " .. string.upper(string.sub(input, 4))
          yield(cand_ui_m)
        end
      end
    end


    local url_c_input = string.match(input, "'/e([0-9a-z][0-9a-f]*)$")
    if (url_c_input~=nil) then
      local u_1 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f])$")
      local u_2 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
      local u_3 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
      local u_4 = string.match(url_c_input,"^([0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])$")
      if (u_1 ~= nil) or (u_2 ~= nil) or (u_3 ~= nil) or (u_4 ~= nil) then
        url_c_input = url_c_input .. '0'
      end
      local url_10 = url_decode(url_c_input)
      local uc_i = string.upper(string.sub(input, 4, 5)) .. " " .. string.upper(string.sub(input, 6, 7)) .. " " .. string.upper(string.sub(input, 8, 9)) .. " " .. string.upper(string.sub(input, 10, 11)) .. " " .. string.upper(string.sub(input, 12, 13)) .. " " .. string.upper(string.sub(input, 14, 15))
      local uc_i = string.gsub(uc_i, " +$", "" )
      if string.match(url_10, "無此編碼") ~= nil then
        yield(Candidate("number", seg.start, seg._end, url_10, '' ))
      elseif string.match(url_c_input, "^[0-9a-z]$") ~= nil then
        local cand_uci_a = Candidate("number", seg.start, seg._end, url_10, url_10 )
        cand_uci_a.preedit = "'/e " .. uc_i
        yield(cand_uci_a)
      else
        -- local u_c = string.upper(url_c_input)
        -- local u_c = string.gsub(u_c, '^', '%%')
        -- local u_c = string.gsub(u_c, '^(%%..)(..)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(%%..%%..)(.+)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(%%..%%..%%..)(.+)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(%%..%%..%%..%%..)(.+)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(%%..%%..%%..%%..%%..)(.+)', '%1%%%2')
        -- local u_c = string.gsub(u_c, '^(..)(.?.?)(.?.?)(.?.?)(.?.?)(.?.?)$', '%%%1%%%2%%%3%%%4%%%5%%%6')
        -- local u_c = string.gsub(u_c, '[%%]+$', '')
        -- yield(Candidate("number", seg.start, seg._end, utf8_out(url_10), u_c ))
        local cand_uci_s = Candidate("number", seg.start, seg._end, utf8_out(url_10), url_encode(utf8_out(url_10)) )
        cand_uci_s.preedit = "'/e " .. uc_i
        yield(cand_uci_s)
      end
      -- if url_10*10+10-1 < 1048575 then
      --   for i = url_10*10, url_10*10+10-1 do
      if url_10+16 < 1048575 then
        for i = url_10+1, url_10+16 do
          local cand_uci_m = Candidate("number", seg.start, seg._end, utf8_out(i), url_encode(utf8_out(i)) )
          cand_uci_m.preedit = "'/e " .. uc_i
          yield(cand_uci_m)
        end
      end
      return
    end


    local y, m, d = string.match(input, "'/(%d+)/(%d?%d)/(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d).." "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      local ll_1, ll_2 = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
      if(Date2LunarDate~=nil) then
        yield(Candidate("date", seg.start, seg._end, ll_1, "〔西曆→農曆〕"))
        yield(Candidate("date", seg.start, seg._end, ll_2, "〔西曆→農曆〕"))
      end
      local All_g, Y_g, M_g, D_g = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
      if(All_g~=nil) then
        yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日", "〔西曆→農曆干支〕"))
      end
      local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
      local LDD2D_leap_year  = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
      if(Date2LunarDate~=nil) then
        yield(Candidate("date", seg.start, seg._end, LDD2D, "〔農曆→西曆〕"))
        yield(Candidate("date", seg.start, seg._end, LDD2D_leap_year, "〔農曆(閏)→西曆〕"))
      end
      return
    end

    local m, d = string.match(input, "'/(%d?%d)/(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      return
    end

    local y, m, d = string.match(input, "'/(%d+)-(%d?%d)-(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..y.." 年 "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(y).."年"..fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_y_date(y).."年"..ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_y_date(y).."年"..chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d).." "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d)..", "..y, "〔美式月日年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m).." "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m)..", "..y, "〔英式日月年〕"))
      yield(Candidate("date", seg.start, seg._end, y.."年 "..jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      -- local chinese_date_input = to_chinese_cal_local(os.time({year = y, month = m, day = d, hour = 12}))
      local ll_1, ll_2 = Date2LunarDate(y .. string.format("%02d", m) .. string.format("%02d", d))
      if(Date2LunarDate~=nil) then
        yield(Candidate("date", seg.start, seg._end, ll_1, "〔西曆→農曆〕"))
        yield(Candidate("date", seg.start, seg._end, ll_2, "〔西曆→農曆〕"))
      end
      local All_g, Y_g, M_g, D_g = lunarJzl(y .. string.format("%02d", m) .. string.format("%02d", d) .. 12)
      if(All_g~=nil) then
        yield(Candidate("date", seg.start, seg._end, Y_g.."年"..M_g.."月"..D_g.."日", "〔西曆→農曆干支〕"))
      end
      local LDD2D = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 0 )
      local LDD2D_leap_year  = LunarDate2Date(y .. string.format("%02d", m) .. string.format("%02d", d), 1 )
      if(Date2LunarDate~=nil) then
        yield(Candidate("date", seg.start, seg._end, LDD2D, "〔農曆→西曆〕"))
        yield(Candidate("date", seg.start, seg._end, LDD2D_leap_year, "〔農曆(閏)→西曆〕"))
      end
      -- local chinese_date_input2 = to_chinese_cal(y, m, d)
      -- if(chinese_date_input2~=nil) then
      --   yield(Candidate("date", seg.start, seg._end, chinese_date_input2 .. " ", "〔農曆，可能有誤！〕"))
      -- end
      return
    end

    local m, d = string.match(input, "'/(%d?%d)-(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , "〔日期〕"))
      yield(Candidate("date", seg.start, seg._end, " "..m.." 月 "..d.." 日 " , "〔*日期*〕"))
      yield(Candidate("date", seg.start, seg._end, fullshape_number(m).."月"..fullshape_number(d).."日" , "〔全形日期〕"))
      yield(Candidate("date", seg.start, seg._end, ch_m_date(m).."月"..ch_d_date(d).."日" , "〔小寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, chb_m_date(m).."月"..chb_d_date(d).."日" , "〔大寫中文日期〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng2_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_m_date(m).." "..eng3_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_m_date(m).." "..eng4_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng1_m_date(m).." the "..eng1_d_date(d), "〔美式月日〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng3_d_date(d).." "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, eng2_d_date(d).." "..eng2_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "the "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, "The "..eng1_d_date(d).." of "..eng1_m_date(m), "〔英式日月〕"))
      yield(Candidate("date", seg.start, seg._end, jp_m_date(m)..jp_d_date(d), "〔日文日期〕"))
      return
    end

    -- local numberout = string.match(input, "'//?(%d+)$")
    local numberout, dot1, afterdot = string.match(input, "'/(%d+)(%.?)(%d*)$")
    local nn = string.sub(numberout, 1)
    if (numberout~=nil) and (tonumber(nn)~=nil) then
      --[[ 用 yield 產生一個候選項
      候選項的構造函數是 Candidate，它有五個參數：
      - type: 字符串，表示候選項的類型（可隨意取）
      - start: 候選項對應的輸入串的起始位置
      - _end:  候選項對應的輸入串的結束位置
      - text:  候選項的文本
      - comment: 候選項的注釋
      --]]
      yield(Candidate("number", seg.start, seg._end, numberout .. dot1 .. afterdot , "〔一般數字〕"))

      if (string.len(numberout) < 4) then
        yield(Candidate("number", seg.start, seg._end, "," , "〔千分位〕"))
      else
        -- local k = string.sub(numberout, 1, -1) -- 取參數
        local result = formatnumberthousands(numberout) --- 調用算法
        yield(Candidate("number", seg.start, seg._end, result .. dot1 .. afterdot , "〔千分位〕"))
      end

      yield(Candidate("number", seg.start, seg._end, string.format("%E", numberout .. dot1 .. afterdot ), "〔科學計數〕"))
      yield(Candidate("number", seg.start, seg._end, string.format("%e", numberout .. dot1 .. afterdot ), "〔科學計數〕"))
      yield(Candidate("number", seg.start, seg._end, math1_number(numberout) .. dot1 .. math1_number(afterdot), "〔數學粗體數字〕"))
      yield(Candidate("number", seg.start, seg._end, math2_number(numberout) .. dot1 .. math2_number(afterdot), "〔數學空心數字〕"))
      yield(Candidate("number", seg.start, seg._end, fullshape_number(numberout) .. dot1 .. fullshape_number(afterdot), "〔全形數字〕"))

      if (dot1~='.') then
        yield(Candidate("number", seg.start, seg._end, little1_number(numberout), "〔上標數字〕"))
        yield(Candidate("number", seg.start, seg._end, little2_number(numberout), "〔下標數字〕"))

        for _, conf in ipairs(confs) do
          local r = read_number(conf, nn)
          yield(Candidate("number", seg.start, seg._end, r, conf.comment))
        end

        if (string.len(numberout) < 2) then
          yield(Candidate("number", seg.start, seg._end, "元整", "〔純中文數字〕"))
        else
          yield(Candidate("number", seg.start, seg._end, purech_number(numberout), "〔純中文數字〕"))
        end

        yield(Candidate("number", seg.start, seg._end, circled1_number(numberout), "〔帶圈數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled2_number(numberout), "〔帶圈無襯線數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled3_number(numberout), "〔反白帶圈數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled4_number(numberout), "〔反白帶圈無襯線數字〕"))
        yield(Candidate("number", seg.start, seg._end, circled5_number(numberout), "〔帶圈中文數字〕"))

        if (tonumber(numberout)==1) or (tonumber(numberout)==0) then
          yield(Candidate("number", seg.start, seg._end, string.sub(numberout, -1), "〔二進位〕"))
        else
          yield(Candidate("number", seg.start, seg._end, Dec2bin(numberout), "〔二進位〕"))
        end

        yield(Candidate("number", seg.start, seg._end, string.format("%o",numberout), "〔八進位〕"))
        yield(Candidate("number", seg.start, seg._end, string.format("%X",numberout), "〔十六進位〕"))
        yield(Candidate("number", seg.start, seg._end, string.format("%x",numberout), "〔十六進位〕"))
      end
      return
    end

    -- -- 測試空白不上屏在 translator 中直接處理！
    -- -- local engine = env.engine
    -- -- local context = engine.context
    -- -- local kkk = string.match(o_input, "'/")
    -- -- local engine = env.engine
    -- -- local context = engine.context
    -- -- local o_input = context.input
    -- local kkk = string.match(input, "( )$")
    -- -- local page_size = engine.schema.page_size
    -- if (kkk~=nil) then --and (context:is_composing())
    --   -- local s_orig = context:get_commit_text()
    --   -- local o_input = context.input
    --   -- engine:commit_text(s_orig .. "a")
    --   -- context:clear()
    --   -- yield(Candidate("number", seg.start, seg._end, "nnnnnm", "〔千分位數字〕"))
    --   return 1 -- kAccepted
    -- end

  end
end




--- @@ date/time translator
--[[
有些網上方案會掛載該項
--]]
function date_translator(input, seg)
  if (string.match(input, "``")~=nil) then
    -- Candidate(type, start, end, text, comment)
    if (input == "``time") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " 現在時間"))
      return
    end

    if (input == "``now") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), " 現在日期"))
      return
    end

    if(input=="``") then
      yield(Candidate("date", seg.start, seg._end, "" , "擴充模式"))
      return
    end

    local y, m, d = string.match(input, "``(%d+)/(%d?%d)/(%d?%d)$")
    if(y~=nil) then
      yield(Candidate("date", seg.start, seg._end, y.."年"..m.."月"..d.."日" , " 日期"))
      return
    end

    local m, d = string.match(input, "``(%d?%d)/(%d?%d)$")
    if(m~=nil) then
      yield(Candidate("date", seg.start, seg._end, m.."月"..d.."日" , " 日期"))
      return
    end
  end
end

-- function mytranslator(input, seg)
--   date_translator(input, seg)
--   time_translator(input, seg)
-- end




--- @@ instruction_grave_bpmf
--[[
說明注音「`」開頭之符號集
--]]
function instruction_grave_bpmf(input, seg)
  -- if input:find('^`$') then
  if (string.match(input, "^`$")~=nil) then
    -- for cand in input:iter() do
    --   yield(cand)
    -- end
    local table_gb_1 = {
          { ' ※ 輸入【項目】每字第一個注音，調出相關符號。', '𝟎' }
        , { '【表情】【自然】【飲食】【活動】【旅遊】【物品】', '𝟏' }
        , { '【符號】【國旗】【微笑】【大笑】【冒汗】【喜愛】', '𝟐' }
        , { '【討厭】【無奈】【哭泣】【冷淡】【驚訝】【生氣】', '𝟑' }
        , { '【懷疑】【大頭】【人物】【獸面】【貓頭】【怪物】', '𝟒' }
        , { '【五官】【手勢】【亞裔】【白人】【黑人】【天氣】', '𝟓' }
        , { '【下雪】【天體】【夜空】【地球】【景色】【景點】', '𝟔' }
        , { '【名勝】【日本】【美國】【法國】【建築】【節日】', '𝟕' }
        , { '【娛樂】【遊戲】【運動】【球具】【獎項】【獎牌】', '𝟖' }
        , { '【食物】【正飯】【午餐】【早餐】【早點】【中餐】', '𝟗' }
        , { '【西餐】【快餐】【速食】【米飯】【麵包】【捲物】', '𝟏𝟎' }
        , { '【串物】【甜點】【零食】【飲料】【熱飲】【酒精】', '𝟏𝟏' }
        , { '【酒類】【植物】【水果】【蔬菜】【粗糧】【花卉】', '𝟏𝟐' }
        , { '【葉子】【肉類】【肉品】【牲畜】【畜牲】【禽類】', '𝟏𝟑' }
        , { '【鳥類】【魚圖】【鳥圖】【衣物】【衣服】【褲子】', '𝟏𝟒' }
        , { '【帽子】【包包】【頭髮】【膚色】【化妝】【愛情】', '𝟏𝟓' }
        , { '【愛心】【兩性】【效果】【色塊】【宗教】【音樂】', '𝟏𝟔' }
        , { '【樂器】【時鐘】【標誌】【圖示】【圖標】【箭標】', '𝟏𝟕' }
        , { '【指示】【回收】【有害】【科學】【通訊】【電腦】', '𝟏𝟖' }
        , { '【電子】【武器】【象棋】【麻將】【骰子】【撲克】', '𝟏𝟗' }
        , { '【船隻】【飛機】【汽車】【車輛】【公交】【城軌】', '𝟐𝟎' }
        , { '【捷運】【火車】【錢財】【鈔票】【紙鈔】【紙幣】', '𝟐𝟏' }
        , { '【貨幣】【單位】【數學】【分數】【打勾】【星號】', '𝟐𝟐' }
        , { '【箭頭】【線段】【幾何】【三角】【方塊】【圓形】', '𝟐𝟑' }
        , { '【填色】【文化】【占星】【星座】【易經】【八卦】', '𝟐𝟒' }
        , { '【卦名】【天干】【地支】【干支】【節氣】【月份】', '𝟐𝟓' }
        , { '【日期】【曜日】【時間】【符碼】【標點】【合字】', '𝟐𝟔' }
        , { '【部首】【偏旁】【筆畫】【倉頡】【結構】【拼音】', '𝟐𝟕' }
        , { '【注音】【聲調】【上標】【下標】【羅馬】【希臘】', '𝟐𝟖' }
        , { '【俄語】【韓文】【(平)假名】', '𝟐𝟗' }
        , { '【幾何圖】【鞋子圖】【眼鏡圖】【工具圖】【電器圖】', '𝟑𝟎' }
        , { '【甜食圖】【餐具圖】【動物圖】【生肖圖】【家禽圖】', '𝟑𝟏' }
        , { '【魚類圖】【精怪圖】【月相圖】【交通圖】【飛行器】', '𝟑𝟐' }
        , { '【黃種人】【拉美裔】【棕色人】【白種人】【阿拉伯】', '𝟑𝟑' }
        , { '【動物臉】【猴子頭】【咧嘴笑】【做運動】【日本菜】', '𝟑𝟒' }
        , { '【食物捲】【辦公室】【警消護】【大自然】【遊樂園】', '𝟑𝟓' }
        , { '【撲克牌】【西洋棋】【輸入法】【日用品】【單線框】', '𝟑𝟔' }
        , { '【雙線框】【色塊心】【色塊方】【色塊圓】【十字架】', '𝟑𝟕' }
        , { '【星座名】【十二宮】【太玄經】【蘇州碼】【標點直】', '𝟑𝟖' }
        , { '【羅馬大】【希臘大】【俄語大】【字母圈】【字母括】', '𝟑𝟗' }
        , { '【字母方】【字母框】【數字圈】【數字括】【數字點】', '𝟒𝟎' }
        , { '【數字標】【漢字圈】【漢字框】【漢字括】【韓文圈】', '𝟒𝟏' }
        , { '【韓文括】【假名圈】【片假名】【IRO(いろは順)】', '𝟒𝟐' }
        , { '【假名半(形)】【日本年】【填色塊】', '𝟒𝟑' }
        , { '【猴子表情】【十二生肖】【交通工具】【公共運輸】', '𝟒𝟒' }
        , { '【日式料理】【日本料理】【日本星期】【羅馬數字】', '𝟒𝟓' }
        , { '【數字圈黑】【數字黑圈】【字母圈大】【字母括大】', '𝟒𝟔' }
        , { '【字母黑圈】【字母圈黑】【字母黑方】【字母方黑】', '𝟒𝟕' }
        , { '【字母框黑】【字母黑框】【易經卦名】【六十四卦】', '𝟒𝟖' }
        , { '【六十四卦名】【羅馬數字大】', '𝟒𝟗' }
        , { '【運動ㄋㄩ(女)】【運動ㄋㄢ(男)】', '𝟓𝟎' }
        , { '【精怪ㄋㄩ(女)】【精怪ㄋㄢ(男)】', '𝟓𝟏' }
        , { '【 a 假名】【 i 假名】【 u 假名】【 e 假名】【 o 假名】', '𝟓𝟐' }
        , { '【 k 假名】【 g 假名】【 s 假名】【 z 假名】【 t 假名】', '𝟓𝟑' }
        , { '【 d 假名】【 n 假名】【 h 假名】【 b 假名】【 p 假名】', '𝟓𝟒' }
        , { '【 m 假名】【 y 假名】【 r 假名】【 w 假名】', '𝟓𝟓' }
        , { '｢圈｣｢框｣｢括｣數字字母：【 0 ~ 10 】【 1-0 ~ 5-0 】【 a ~ z 】', '𝟓𝟔' }
    }
    for k, v in ipairs(table_gb_1) do
      local cand = Candidate('help', seg.start, seg._end, v[2], ' ' .. v[1])
      -- cand.preedit = input .. '\t※ 輸入【項目】每字第一個注音，調出相關符號。'
      yield(cand)
    end
  end
  -- if input:find('^``$') then
  if(string.match(input, "^``$")~=nil) then
    local table_gb_2 = {
          { '〖 a ~ z 〗字母變化      ※ 以下 顏文字：', '𝟘' }
        , { '〖 1 〗開心 〖 2 〗喜歡 〖 3 〗傷心', '𝟙' }
        , { '〖 4 〗生氣 〖 5 〗驚訝 〖 6 〗無奈', '𝟐' }
        , { '〖 7 〗喜     〖 8 〗樂     〖 9 〗怒', '𝟑' }
        , { '〖 0 〗指示和圖示          〖 - 〗回話', '𝟒' }
    }
    for k, v in ipairs(table_gb_2) do
      local cand = Candidate('help', seg.start, seg._end, v[2], ' ' .. v[1])
      -- cand.preedit = input .. '\t※ 輸入【項目】每字第一個注音，調出相關符號。'
      yield(cand)
    end
  end
end




--- @@ instruction_dbpmf
--[[
說明雙拼注音各種掛接
--]]
function instruction_dbpmf(input, seg, env)
  -- if input:find('^;$') then
  local caret_pos = env.engine.context.caret_pos
  if (string.match(input, "^;$")~=nil) and (caret_pos == 1) then
    -- for cand in input:iter() do
    --   yield(cand)
    -- end
    local table_sd_1 = {
          { ' ※ 輸入【項目】每字第一個注音，調出相關符號。', '𝟎' }
        , { '【表情】【自然】【飲食】【活動】【旅遊】【物品】', '𝟏' }
        , { '【符號】【國旗】【微笑】【大笑】【冒汗】【喜愛】', '𝟐' }
        , { '【討厭】【無奈】【哭泣】【冷淡】【驚訝】【生氣】', '𝟑' }
        , { '【懷疑】【大頭】【人物】【獸面】【貓頭】【怪物】', '𝟒' }
        , { '【五官】【手勢】【亞裔】【白人】【黑人】【天氣】', '𝟓' }
        , { '【下雪】【天體】【夜空】【地球】【景色】【景點】', '𝟔' }
        , { '【名勝】【日本】【美國】【法國】【建築】【節日】', '𝟕' }
        , { '【娛樂】【遊戲】【運動】【球具】【獎項】【獎牌】', '𝟖' }
        , { '【食物】【正飯】【午餐】【早餐】【早點】【中餐】', '𝟗' }
        , { '【西餐】【快餐】【速食】【米飯】【麵包】【捲物】', '𝟏𝟎' }
        , { '【串物】【甜點】【零食】【飲料】【熱飲】【酒精】', '𝟏𝟏' }
        , { '【酒類】【植物】【水果】【蔬菜】【粗糧】【花卉】', '𝟏𝟐' }
        , { '【葉子】【肉類】【肉品】【牲畜】【畜牲】【禽類】', '𝟏𝟑' }
        , { '【鳥類】【魚圖】【鳥圖】【衣物】【衣服】【褲子】', '𝟏𝟒' }
        , { '【帽子】【包包】【頭髮】【膚色】【化妝】【愛情】', '𝟏𝟓' }
        , { '【愛心】【兩性】【效果】【色塊】【宗教】【音樂】', '𝟏𝟔' }
        , { '【樂器】【時鐘】【標誌】【圖示】【圖標】【箭標】', '𝟏𝟕' }
        , { '【指示】【回收】【有害】【科學】【通訊】【電腦】', '𝟏𝟖' }
        , { '【電子】【武器】【象棋】【麻將】【骰子】【撲克】', '𝟏𝟗' }
        , { '【船隻】【飛機】【汽車】【車輛】【公交】【城軌】', '𝟐𝟎' }
        , { '【捷運】【火車】【錢財】【鈔票】【紙鈔】【紙幣】', '𝟐𝟏' }
        , { '【貨幣】【單位】【數學】【分數】【打勾】【星號】', '𝟐𝟐' }
        , { '【箭頭】【線段】【幾何】【三角】【方塊】【圓形】', '𝟐𝟑' }
        , { '【填色】【文化】【占星】【星座】【易經】【八卦】', '𝟐𝟒' }
        , { '【卦名】【天干】【地支】【干支】【節氣】【月份】', '𝟐𝟓' }
        , { '【日期】【曜日】【時間】【符碼】【標點】【合字】', '𝟐𝟔' }
        , { '【部首】【偏旁】【筆畫】【倉頡】【結構】【拼音】', '𝟐𝟕' }
        , { '【注音】【聲調】【上標】【下標】【羅馬】【希臘】', '𝟐𝟖' }
        , { '【俄語】【韓文】【(平)假名】', '𝟐𝟗' }
        , { '【幾何圖】【鞋子圖】【眼鏡圖】【工具圖】【電器圖】', '𝟑𝟎' }
        , { '【甜食圖】【餐具圖】【動物圖】【生肖圖】【家禽圖】', '𝟑𝟏' }
        , { '【魚類圖】【精怪圖】【月相圖】【交通圖】【飛行器】', '𝟑𝟐' }
        , { '【黃種人】【拉美裔】【棕色人】【白種人】【阿拉伯】', '𝟑𝟑' }
        , { '【動物臉】【猴子頭】【咧嘴笑】【做運動】【日本菜】', '𝟑𝟒' }
        , { '【食物捲】【辦公室】【警消護】【大自然】【遊樂園】', '𝟑𝟓' }
        , { '【撲克牌】【西洋棋】【輸入法】【日用品】【單線框】', '𝟑𝟔' }
        , { '【雙線框】【色塊心】【色塊方】【色塊圓】【十字架】', '𝟑𝟕' }
        , { '【星座名】【十二宮】【太玄經】【蘇州碼】【標點直】', '𝟑𝟖' }
        , { '【羅馬大】【希臘大】【俄語大】【字母圈】【字母括】', '𝟑𝟗' }
        , { '【字母方】【字母框】【數字圈】【數字括】【數字點】', '𝟒𝟎' }
        , { '【數字標】【漢字圈】【漢字框】【漢字括】【韓文圈】', '𝟒𝟏' }
        , { '【韓文括】【假名圈】【IRO(いろは順)】', '𝟒𝟐' }
        , { '【假名半(形)】【日本年】【填色塊】', '𝟒𝟑' }
        , { '【猴子表情】【十二生肖】【交通工具】【公共運輸】', '𝟒𝟒' }
        , { '【日式料理】【日本料理】【日本星期】【羅馬數字】', '𝟒𝟓' }
        , { '【數字圈黑】【數字黑圈】【字母圈大】【字母括大】', '𝟒𝟔' }
        , { '【字母黑圈】【字母圈黑】【字母黑方】【字母方黑】', '𝟒𝟕' }
        , { '【字母框黑】【字母黑框】【易經卦名】【六十四卦】', '𝟒𝟖' }
        , { '【六十四卦名】【羅馬數字大】', '𝟒𝟗' }
        , { '【PM(片)假名】【運動NY(女)】【運動NH(男)】', '𝟓𝟎' }
        , { '【精怪NY(女)】【精怪NH(男)】', '𝟓𝟏' }
        , { '【 a 假名】【 i 假名】【 u 假名】【 e 假名】【 o 假名】', '𝟓𝟐' }
        , { '【 k 假名】【 g 假名】【 s 假名】【 z 假名】【 t 假名】', '𝟓𝟑' }
        , { '【 d 假名】【 n 假名】【 h 假名】【 b 假名】【 p 假名】', '𝟓𝟒' }
        , { '【 m 假名】【 y 假名】【 r 假名】【 w 假名】', '𝟓𝟓' }
        , { ' ｢圈｣｢框｣｢括｣數字字母：【 0 ~ 10 】【 1-0 ~ 5-0 】【 a ~ z 】', '𝟓𝟔' }
    }
    for k, v in ipairs(table_sd_1) do
      local cand = Candidate('help', seg.start, seg._end, v[2], ' ' .. v[1])
      -- cand.preedit = input .. '\t※ 輸入【項目】每字第一個注音，調出相關符號。'
      yield(cand)
    end
  end
  -- if input:find('^;;$') then
  if(string.match(input, "^;;$")~=nil) and (caret_pos == 2) then
    local table_sd_2 = {
          { '〖 a ~ z 〗字母變化      ※ 以下 顏文字：', '𝟘' }
        , { '〖 1 〗開心 〖 2 〗喜歡 〖 3 〗傷心', '𝟙' }
        , { '〖 4 〗生氣 〖 5 〗驚訝 〖 6 〗無奈', '𝟚' }
        , { '〖 7 〗喜     〖 8 〗樂     〖 9 〗怒', '𝟛' }
        , { '〖 0 〗指示和圖示          〖 - 〗回話', '𝟜' }
    }
    for k, v in ipairs(table_sd_2) do
      local cand = Candidate('help', seg.start, seg._end, v[2], ' ' .. v[1])
      -- cand.preedit = input .. '\t※ 輸入【項目】每字第一個注音，調出相關符號。'
      yield(cand)
    end
  end
  -- if input:find('^e$') then
  if(string.match(input, "^e$")~=nil) then
    local table_sd_2 = {
          { 'ㄅⒷ ㄆⓟ ㄇⓂ ㄈⒻ ｜ ㄉⒹ ㄊⓉ ㄋⓃ ㄌⓁ ｜ ㄍⒼ ㄎⓀ ㄏⒽ', '⓿' }
        , { 'ㄐⒿ ㄑⓆ ㄒⓍ ｜ㄓⓌ ㄔⓋ ㄕⒶ ㄖⓇ ｜ ㄗⓏ ㄘⒸ ㄙⓈ', '❶' }
        , { 'ㄧⒾ ㄨⓊ ㄩⓎ      ║ 空韻碼： ㄭⒾ　(ㄧㄨㄩ)ㄭⒺ　◌Ⓞ ║', '❷' }
        , { 'ㄚⒶ ㄛⓄ ㄜⒺ ㄝⓀ ｜ ㄞⒿ ㄟⓀ ㄠⓌ ㄡⒹ', '❸' }
        , { 'ㄢⒽ ㄣⒻ ㄤⓈ ㄥⒼ ㄦⓇ', '❹' }
        , { 'ㄧㄚⓏ ㄧㄝⓟ ㄧㄠⓆ ㄧㄡⒸ ㄧㄢⓂ ㄧㄣⓇ ㄧㄤⓍ ㄧㄥⓉ', '❺' }
        , { 'ㄨㄚⓏ ㄨㄞⓂ ㄨㄟⓁ ㄨㄢⓃ ㄨㄣⓋ ㄨㄤⓍ ㄨㄥⒷ', '❻' }
        , { 'ㄩㄢⓃ ㄩㄝⓁ ㄩㄣⓋ ㄩㄥⒷ', '❼' }
    }
    for k, v in ipairs(table_sd_2) do
      local cand = Candidate('help', seg.start, seg._end, v[2], ' ' .. v[1])
      cand.preedit = input .. '\t《查詢鍵位注音》▶'
      yield(cand)
    end
  end
end



--- @@ instruction_ocm
--[[
說明蝦米各種掛接
--]]
function instruction_ocm(input, seg, env)
  -- if input:find('^;$') then
  local caret_pos = env.engine.context.caret_pos
  if (string.match(input, "^;$")~=nil) and (caret_pos == 1) then
    -- for cand in input:iter() do
    --   yield(cand)
    -- end
    local table_sd_1 = {
          { ' ※ 輸入【項目】每字第一碼（正碼），調出相關符號。', '𝟎' }
        , { '【表情】【自然】【飲食】【活動】【旅遊】【物品】', '𝟏' }
        , { '【符號】【國旗】【微笑】【大笑】【冒汗】【喜愛】', '𝟐' }
        , { '【討厭】【無奈】【哭泣】【冷淡】【驚訝】【生氣】', '𝟑' }
        , { '【懷疑】【頭像】【人物】【獸面】【貓頭】【怪物】', '𝟒' }
        , { '【五官】【手勢】【亞裔】【白人】【黑人】【天氣】', '𝟓' }
        , { '【下雪】【天體】【夜空】【地球】【景色】【月相】', '𝟔' }
        , { '【名勝】【日本】【美國】【法國】【建築】【生肖】', '𝟕' }
        , { '【娛樂】【遊戲】【運動】【球具】【獎項】【獎牌】', '𝟖' }
        , { '【食物】【正飯】【午餐】【午飯】【早飯】【早點】', '𝟗' }
        , { '【中餐】【西食】【快餐】【速食】【米飯】【捲物】', '𝟏𝟎' }
        , { '【串物】【甜食】【零食】【飲料】【熱飲】【酒精】', '𝟏𝟏' }
        , { '【酒類】【植物】【水果】【蔬菜】【粗糧】【餐具】', '𝟏𝟐' }
        , { '【花卉】【葉子】【肉類】【肉品】【牲畜】【禽類】', '𝟏𝟑' }
        , { '【魚圖】【魚類】【家禽】【衣物】【衣服】【褲子】', '𝟏𝟒' }
        , { '【眼鏡】【帽子】【包包】【頭髮】【膚色】【化妝】', '𝟏𝟓' }
        , { '【愛情】【兩性】【效果】【宗教】【音樂】【工具】', '𝟏𝟔' }
        , { '【時鐘】【號誌】【圖示】【介面】【箭標】【精怪】', '𝟏𝟕' }
        , { '【指示】【回收】【有害】【通訊】【電腦】【交通】', '𝟏𝟖' }
        , { '【電子】【武器】【象棋】【麻將】【骰子】【撲克】', '𝟏𝟗' }
        , { '【船隻】【飛機】【汽車】【車輛】【公交】【軌道】', '𝟐𝟎' }
        , { '【火車】【錢財】【金錢】【鈔票】【紙鈔】【動物】', '𝟐𝟏' }
        , { '【貨幣】【單位】【數學】【分數】【打勾】【星號】', '𝟐𝟐' }
        , { '【箭頭】【線段】【幾何】【三角】【方塊】【圓形】', '𝟐𝟑' }
        , { '【填色】【單線】【雙線】【星座】【易經】【八卦】', '𝟐𝟒' }
        , { '【卦名】【天干】【地支】【干支】【節氣】【月份】', '𝟐𝟓' }
        , { '【日期】【曜日】【時間】【符碼】【標點】【合字】', '𝟐𝟔' }
        , { '【部首】【偏旁】【筆畫】【倉頡】【結構】【拼音】', '𝟐𝟕' }
        , { '【注音】【聲調】【羅馬】【希臘】【俄語】【韓文】', '𝟐𝟖' }
        , { '【麵包(gn)】', '𝟐𝟗' }
        , { '【幾何圖】【鞋子圖】【電器圖】【節日圖】【佳節圖】', '𝟑𝟎' }
        , { '【甜點圖】【動物圖】【禽類圖】【鳥類圖】【標誌圖】', '𝟑𝟏' }
        , { '【科學圖】【交通圖】【景點圖】【飛行器】【愛心圖】', '𝟑𝟐' }
        , { '【黃種人】【拉美裔】【棕色人】【白種人】【阿拉伯】', '𝟑𝟑' }
        , { '【顏色塊】【動物臉】【猴子頭】【咧嘴笑】【做運動】', '𝟑𝟒' }
        , { '【日本菜】【食物捲】【辦公室】【警消護】【大自然】', '𝟑𝟓' }
        , { '【遊樂園】【撲克牌】【西洋棋】【樂器圖】【日用品】', '𝟑𝟔' }
        , { '【單線框】【雙線框】【色塊心】【色塊方】【色塊圓】', '𝟑𝟕' }
        , { '【填色塊】【占星術】【十字架】【星座名】【十二宮】', '𝟑𝟖' }
        , { '【太玄經】【蘇州碼】【標點直】【輸入法】【羅馬大】', '𝟑𝟗' }
        , { '【希臘大】【俄語大】【字母圈】【字母括】【字母方】', '𝟒𝟎' }
        , { '【字母框】【數字圈】【數字括】【數字點】【數字標】', '𝟒𝟏' }
        , { '【漢字圈】【漢字框】【漢字括】【韓文圈】【韓文括】', '𝟒𝟐' }
        , { '【假名圈】【運動女】【運動男】【精怪女】【精怪男】', '𝟒𝟑' }
        , { '【日本年】【假名半(形)】', '𝟒𝟒' }
        , { '【IRO(いろは順)】【文化(第一字全碼)】', '𝟒𝟓' }
        , { '【平假名(第一碼全碼)】【片假名(第一碼全碼)】', '𝟒𝟔' }
        , { '【上標(第一字全碼)】【下標(第一字全碼)】', '𝟒𝟕' }
        , { '【猴子表情】【十二生肖】【交通工具】【公共運輸】', '𝟒𝟖' }
        , { '【日式料理】【日本料理】【日本星期】【羅馬數字】', '𝟒𝟗' }
        , { '【數字圈黑】【數字黑圈】【字母圈大】【字母括大】', '𝟓𝟎' }
        , { '【字母黑圈】【字母圈黑】【字母黑方】【字母方黑】', '𝟓𝟏' }
        , { '【字母框黑】【字母黑框】【易經卦名】【六十四卦】', '𝟓𝟐' }
        , { '【六十四卦名】【羅馬數字大】', '𝟓𝟑' }
        , { '【 a 假名】【 i 假名】【 u 假名】【 e 假名】【 o 假名】', '𝟓𝟒' }
        , { '【 k 假名】【 g 假名】【 s 假名】【 z 假名】【 t 假名】', '𝟓𝟓' }
        , { '【 d 假名】【 n 假名】【 h 假名】【 b 假名】【 p 假名】', '𝟓𝟔' }
        , { '【 m 假名】【 y 假名】【 r 假名】【 w 假名】', '𝟓𝟕' }
        , { ' ｢圈｣｢框｣｢括｣數字字母：【 0 ~ 10 】【 1-0 ~ 5-0 】【 a ~ z 】', '𝟓𝟖' }
    }
    for k, v in ipairs(table_sd_1) do
      local cand = Candidate('help', seg.start, seg._end, v[2], ' ' .. v[1])
      -- cand.preedit = input .. '\t※ 輸入〔項目〕每字第一個注音，調出相關符號。'
      yield(cand)
    end
  end
  -- if input:find('^;;$') then
  if(string.match(input, "^;;$")~=nil) and (caret_pos == 2) then
    local table_sd_2 = {
          { '〖 a ~ z 〗字母變化      ※ 以下 顏文字：', '𝟘' }
        , { '〖 1 〗開心 〖 2 〗喜歡 〖 3 〗傷心', '𝟙' }
        , { '〖 4 〗生氣 〖 5 〗驚訝 〖 6 〗無奈', '𝟚' }
        , { '〖 7 〗喜     〖 8 〗樂     〖 9 〗怒', '𝟛' }
        , { '〖 0 〗指示和圖示          〖 - 〗回話', '𝟜' }
    }
    for k, v in ipairs(table_sd_2) do
      local cand = Candidate('help', seg.start, seg._end, v[2], ' ' .. v[1])
      -- cand.preedit = input .. '\t※ 輸入【項目】每字第一個注音，調出相關符號。'
      yield(cand)
    end
  end
end




--- @@ select_word_keys
--[[
修改選字鍵
--]]
-- function select_character_keys(input, seg, env)
--   env.engine.schema.select_keys="YHNUJMIKOL"
--   -- env.engine.schema.set_select_keys=[ QY, AH, ZN, WU, SJ, XM ] -- 試驗，無法
--   -- env.engine.schema.selected_index=[ QY, AH, ZN, WU, SJ, XM ] -- 試驗，無法
--   -- env.engine.schema.select_labels=[ QY, AH, ZN, WU, SJ, XM ] -- 試驗，無法
-- end



