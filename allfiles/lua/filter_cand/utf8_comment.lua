--- comment 附加 Unicode 和 url_encode 編碼

----------------------------------------------------------------------------------------
local url_encode = require("f_components/f_url_encode")
----------------------------------------------------------------------------------------
---- 寫法一

-- local function utf8_comment(char)
--   if utf8.len(char) == 1 then
--     local unicode_d = utf8.codepoint(char)
--     local unicode_h = string.format('%X', unicode_d)
--     local urlcode = url_encode(char)
--     comment = "  U+" .. unicode_h .. " (" .. urlcode .. "）" or ""
--   else
--     comment = ""
--   end
--   return comment
-- end

----------------------------------------------------------------------------------------
---- 寫法二

-- local function utf8_comment(char)
--   local comment = utf8.len(char) == 1 and "  U+" .. string.format("%X",utf8.codepoint(char)) .. "  ( " .. url_encode(char) .. " ）" or ""
--   return comment
-- end

----------------------------------------------------------------------------------------
---- 寫法三

-- local function utf8_comment(char)
--   return utf8.len(char) == 1 and "  U+" .. string.format("%X",utf8.codepoint(char)) .. "  ( " .. url_encode(char) .. " ）" or ""
-- end

----------------------------------------------------------------------------------------
---- 沒限定字數一

-- local function utf8_comment(char)
--   local unicode_d = utf8.codepoint(char)
--   local unicode_h = string.format('%X', unicode_d)
--   local urlcode = url_encode(char)
--   return "  U+" .. unicode_h .. " (" .. urlcode .. "）" or ""
-- end

----------------------------------------------------------------------------------------
---- 沒限定字數二

local function utf8_comment(char)
  -- local char = char ~= "" and char or "0空碼"  --如 char 為""空碼，下方會出錯！
  return "  U+" .. string.format("%X",utf8.codepoint(char)) .. " (" .. url_encode(char) .. "）"
  -- return char ~= "" and "  U+" .. string.format("%X",utf8.codepoint(char)) .. " (" .. url_encode(char) .. "）" or "  U+0000(空碼)"
end

----------------------------------------------------------------------------------------

-- local function t_utf8_comment(tran)
--   for cand in tran:iter() do
--     local cand_text = cand.text
--     if utf8.len(cand_text) == 1 then
--       cand = UniquifiedCandidate(cand, "uniq_unicode", cand_text, utf8_comment(cand_text) .. cand.comment)
--     end
--     -- local cand = UniquifiedCandidate(cand, "uniq_unicode", cand_text, utf8_comment(cand_text) .. cand.comment)
--     yield(cand)
--   end
-- end

----------------------------------------------------------------------------------------

return utf8_comment
-- return { utf8_comment = utf8_comment, t_utf8_comment = t_utf8_comment }