--- comment 附加該選項 debug 訊息

local function debug_comment(cand)
  local dt = cand:get_dynamic_type()
  local t = cand.type
  local q = cand.quality
  local s = cand.start
  local e = cand._end
  return "【"..dt..":"..t.."|$"..string.format("%6.6f", q).."|‸"..s.."~"..e.."】"
end

----------------------------------------------------------------------------------------

-- local function t_debug_comment(tran)
--   for cand in tran:iter() do
--     local cand = UniquifiedCandidate(cand, "uniq_debug", cand.text, debug_comment(cand) .. cand.comment)
--     yield(cand)
--   end
-- end

----------------------------------------------------------------------------------------

return debug_comment
-- return { debug_comment = debug_comment, t_debug_comment = t_debug_comment }