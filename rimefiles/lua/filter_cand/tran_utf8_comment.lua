--- comment 附加 Unicode 和 url_encode 編碼

----------------------------------------------------------------------------------------
local utf8_comment = require("filter_cand/utf8_comment")
----------------------------------------------------------------------------------------

local function tran_utf8_comment(tran)
  for cand in tran:iter() do
    local cand_text = cand.text  -- cand.text ~= "" and cand.text or "〖空碼〗"
    if utf8.len(cand_text) == 1 then
      cand = UniquifiedCandidate(cand, "uniq_unicode", cand_text, utf8_comment(cand_text) .. cand.comment)
    end
    -- local cand = UniquifiedCandidate(cand, "uniq_unicode", cand_text, utf8_comment(cand_text) .. cand.comment)
    yield(cand)
  end
end

----------------------------------------------------------------------------------------

return tran_utf8_comment