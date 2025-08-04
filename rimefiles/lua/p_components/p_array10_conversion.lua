--[[
行列 10「英文↔數字」相互轉換。
--]]

------------------------------------
local convert_format = require("filter_cand/convert_format")
------------------------------------

local function to_num(t)
  if t == "" then return "" end
  local format1 = "xlit|zxcasdqwefv|1234567890.|"
  -- local format2 = ""
  -- local proj = convert_format(format1,format2)
  local proj = convert_format(format1)
  local p_a_t = proj:apply(t)
  return p_a_t == "" and t or p_a_t
end

local function to_abc(t)
  if t == "" then return "" end
  local format1 = "xlit|1234567890.|zxcasdqwefv|"
  -- local format2 = ""
  -- local proj = convert_format(format1,format2)
  local proj = convert_format(format1)
  local p_a_t = proj:apply(t)
  return p_a_t == "" and t or p_a_t
end


return {
        to_num = to_num,
        to_abc = to_abc,
       }