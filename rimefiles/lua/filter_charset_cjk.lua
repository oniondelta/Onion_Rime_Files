--- @@ charset cjk filter
--[[
charset_cjk_filter: 濾除含 CJK 擴展漢字的候選項
charset_comment_filter: 為候選項加上其所屬字符集的註釋
本例說明了 filter 最基本的寫法。
請見 `charset_cjk_filter` 和 `charset_comment_filter` 上方註釋。
--]]
-- 幫助函數（可跳過）
local charset = {
  ["CJK"] = { first = 0x4E00, last = 0x9FFF },         -- CJK Unified Ideographs - https://unicode.org/charts/PDF/U4E00.pdf
  ["ExtA"] = { first = 0x3400, last = 0x4DBF },        -- CJK Unified Ideographs Extension A - https://unicode.org/charts/PDF/U3400.pdf
  ["ExtB"] = { first = 0x20000, last = 0x2A6DF },      -- CJK Unified Ideographs Extension B - https://unicode.org/charts/PDF/U20000.pdf
  ["ExtC"] = { first = 0x2A700, last = 0x2B73F },      -- CJK Unified Ideographs Extension C - https://unicode.org/charts/PDF/U2A700.pdf
  ["ExtD"] = { first = 0x2B740, last = 0x2B81F },      -- CJK Unified Ideographs Extension D - https://unicode.org/charts/PDF/U2B740.pdf
  ["ExtE"] = { first = 0x2B820, last = 0x2CEAF },      -- CJK Unified Ideographs Extension E - https://unicode.org/charts/PDF/U2B820.pdf
  ["ExtF"] = { first = 0x2CEB0, last = 0x2EBEF },      -- CJK Unified Ideographs Extension F - https://unicode.org/charts/PDF/U2CEB0.pdf
  ["ExtG"] = { first = 0x30000, last = 0x3134A },      -- CJK Unified Ideographs Extension G - https://unicode.org/charts/PDF/U30000.pdf
  -- ["Compat"] = { first = 0x2F800, last = 0x2FA1F }  -- CJK Compatibility Ideographs Supplement - https://unicode.org/charts/PDF/U2F800.pdf
  ["Compat"] = { first = 0xF900, last = 0xFAFF },      -- CJK Compatibility Ideographs - https://unicode.org/charts/PDF/UF900.pdf
  ["CompatSupp"] = { first = 0x2F800, last = 0x2FA1F } -- CJK Compatibility Ideographs Supplement - https://unicode.org/charts/PDF/U2F800.pdf
  }

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
    is_charset("ExtG")(c) or is_charset("Compat")(c) or
    is_charset("CompatSupp")(c)
end




--- @@ charset_cjk_filter
--[[
filter 的功能是對 translator 翻譯而來的候選項做修飾，
如去除不想要的候選、為候選加註釋、候選項重排序等。
欲定義的 filter 包含兩個輸入參數：
 - input: 候選項列表
 - env: 可選參數，表示 filter 所處的環境（本例沒有體現）
filter 的輸出與 translator 相同，也是若干候選項，也要求您使用 `yield` 產生候選項。
如下例所示，charset_cjk_filter 將濾除含 CJK 擴展漢字的候選項：
--]]
local function charset_cjk_filter(input)
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




--- @@ charset_cjk_filter_plus
--[[
（bopomo_onion_double）
同上，將濾除含 CJK 擴展漢字的候選項
增加開關設置
--]]
local function charset_cjk_filter_plus(input, env)
  -- 使用 `iter()` 遍歷所有輸入候選項
  local engine = env.engine
  local context = engine.context
  local c_f_p_s = context:get_option("only_cjk_filter")
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
local function charset_comment_filter(input)
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
-- return { filter = charset_cjk_filter,
--   comment_filter = charset_comment_filter }

return { charset_cjk_filter = charset_cjk_filter, charset_cjk_filter_plus = charset_cjk_filter_plus, charset_comment_filter = charset_comment_filter }