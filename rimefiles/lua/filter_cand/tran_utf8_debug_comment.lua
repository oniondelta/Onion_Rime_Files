--- comment 附加 Unicode 和 url_encode 編碼和 debug 訊息

----------------------------------------------------------------------------------------
local utf8_comment = require("filter_cand/utf8_comment")
local debug_comment = require("filter_cand/debug_comment")
----------------------------------------------------------------------------------------

local function tran_utf8_debug_comment(tran)
  for cand in tran:iter() do
    local cand_text = cand.text  -- cand.text ~= "" and cand.text or "〖空碼〗"
    -- yield(u_c2_only and utf8.len(cand_text) == 1 -- 可改用 utf8_comment(cand_text) 內限定
    --       and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, utf8_comment(cand_text) .. cand.comment) or
    --       u_c2_d_c and utf8.len(cand_text) == 1 -- 可改用 utf8_comment(cand_text) 內限定
    --       and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. utf8_comment(cand_text) .. cand.comment) or
    --       d_c
    --       and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. cand.comment) or
    --       cand
    --       )
    if utf8.len(cand_text) == 1 then
      cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. utf8_comment(cand_text) .. cand.comment)
    else
      cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. cand.comment)
    end
    -- local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. utf8_comment(cand_text) .. cand.comment)
    yield(cand)
  end
end

----------------------------------------------------------------------------------------

return tran_utf8_debug_comment