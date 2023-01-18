--- 過濾選項中特定字符，使該選項遮屏。

local function drop_cand(tran,mstr)
  for cand in tran:iter() do
    if not cand.text:match(mstr) then
      yield(cand)
    end
  end
end

return drop_cand