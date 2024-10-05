--- 修改 comment

local function change_comment(cand,comment)
  cand:get_genuine().comment = comment
  return cand
end

return change_comment