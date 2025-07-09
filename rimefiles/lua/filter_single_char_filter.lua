--- @@ single_char_filter
--[[
single_char_filter: 候選項重排序，使單字優先
--]]
local function single_char_filter(input)
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

return single_char_filter