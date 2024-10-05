--- 修改 preedit

local function change_preedit(cand,preedit)
  cand.preedit = preedit
  return cand
end

return change_preedit