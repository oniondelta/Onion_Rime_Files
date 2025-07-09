--[[
網友 shewer 提供依照 Unicode 字符縮減 comment 碼
直接增加 utf8.sub() -- 用法同 strnig.sub(str,si,ei)
--]]
local function utf8_sub(str,si,ei)
  local function index(ustr,i)
    return i>=0 and ( utf8.offset(ustr,i) or ustr:len() +1 )
    or ( utf8.offset(ustr,i) or 1 )
  end

  local u_si= index(str,si)
  ei = ei or utf8.len(str)
  ei = ei >=0 and ei +1 or ei
  local u_ei= index(str, ei ) -1
  return str:sub(u_si,u_ei)
end

return utf8_sub