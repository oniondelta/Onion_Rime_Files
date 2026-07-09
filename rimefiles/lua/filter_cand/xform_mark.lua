--- opencc 附註 comment 無法直接標註空格，由此轉換

local function xform_mark(inp)
  if inp == "" or nil then return "" end
  inp = string.gsub(inp, "@@+", "") --@@@@
  inp = string.gsub(inp, "@", " ")
  return inp
end

return xform_mark