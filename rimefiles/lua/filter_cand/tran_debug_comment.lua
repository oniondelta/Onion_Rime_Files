--- comment 附加該選項 debug 訊息

----------------------------------------------------------------------------------------
local debug_comment = require("filter_cand/debug_comment")
----------------------------------------------------------------------------------------

local function tran_debug_comment(tran)
  for cand in tran:iter() do
    local cand = UniquifiedCandidate(cand, "Uniq_debug", cand.text, debug_comment(cand) .. cand.comment)
    yield(cand)
  end
end

----------------------------------------------------------------------------------------

return tran_debug_comment