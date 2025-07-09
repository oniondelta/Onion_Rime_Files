--[[
百分號編碼（英語：Percent-encoding），又稱：URL編碼（URL encoding）
從編碼到文字。
--]]

local lc_1 = require("lunar_calendar/lunar_calendar_1")
local Dec2bin = lc_1.Dec2bin


local function url_decode(url_str)
-- 不能為的輸入「字符」和「奇數」個數。
  local error_mark = "E38088E8BCB8E585A5E98CAFE8AAA4E38089"  --〈輸入錯誤〉
  local tail_mark = "20E280A6E280A620"  --未完成碼標示：「 …… 」
  local tail_single = false
  if not string.match(url_str, "^[0-9a-fA-F]+$") then
    url_str = error_mark
  elseif #url_str%2 == 1 then
    url_str = string.gsub(url_str, ".$", "")
    tail_single = true
  end
-- 排除 ASCII 控制字元，避免錯誤
  local ascii_ccheck = {}
  for match_two in string.gmatch(url_str, "(%x%x)") do
    table.insert(ascii_ccheck, tonumber(match_two,16))
  end
  for i = 1, #ascii_ccheck do
    if ascii_ccheck[i] < 32 or ascii_ccheck[i] == 127 then  --32為十進位，十六進位為20；127為十進位，十六進位為7f。為ASCII控制字元。
      -- url_str = error_mark
      url_str = error_mark .. '21'  --「21」為「!」
    end
  end
  -- 列印 table 表
  -- for i = 1,#ascii_ccheck do
  --     print(ascii_ccheck[i])
  -- end
  -- local zero_check = string.gsub(url_str, "(%x%x)", function(h) return "_" .. string.format("%02d",tonumber(h, 16)) end)
  -- if string.match(zero_check, "_0") then
  --   url_str = error_mark
  -- end
  -- print(zero_check)
-- 轉成二進制並補齊「0」成八位數，例：「00101111」，以利接下來判別：輸入途中錯誤。
  local binary_check = string.gsub(url_str, "(%x%x)", function(h) return "_" .. string.format("%08d",Dec2bin(tonumber(h, 16))) end)
  -- print(binary_check)
-- 絕對不為開頭或兩個組合。
  if string.match(binary_check, "^_10") then
    url_str = error_mark
  elseif string.match(binary_check, "_11......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_11......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_0......._10") then
    url_str = error_mark
-- 開頭 n 個「1」，後面 n-1 個「10」，不能多也不能少。中間有「_11」則錯誤。
  elseif string.match(binary_check, "_1111110._10......_10......_10......_10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_1111110._10......_10......_10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_111110.._10......_10......_10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_1111110._10......_10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_111110.._10......_10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_11110..._10......_10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_1111110._10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_111110.._10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_11110..._10......_11") then
    url_str = error_mark
  elseif string.match(binary_check, "_1110...._10......_11") then
    url_str = error_mark
-- 開頭 n 個「1」，後面 n-1 個「10」，不能多也不能少。中間有「_0」則錯誤。
  elseif string.match(binary_check, "_1111110._10......_10......_10......_10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_1111110._10......_10......_10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_111110.._10......_10......_10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_1111110._10......_10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_111110.._10......_10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_11110..._10......_10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_1111110._10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_111110.._10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_11110..._10......_0") then
    url_str = error_mark
  elseif string.match(binary_check, "_1110...._10......_0") then
    url_str = error_mark
-- 開頭 n 個「1」，後面 n-1 個「10」，不能多也不能少。後面多出「_10」則錯誤，且「_10」不為開頭。
  elseif string.match(binary_check, "_1111110._10......_10......_10......_10......_10......_10") then
    url_str = error_mark
  elseif string.match(binary_check, "_111110.._10......_10......_10......_10......_10") then
    url_str = error_mark
  elseif string.match(binary_check, "_11110..._10......_10......_10......_10") then
    url_str = error_mark
  elseif string.match(binary_check, "_1110...._10......_10......_10") then
    url_str = error_mark
  elseif string.match(binary_check, "_110....._10......_10") then
    url_str = error_mark
-- 待輸入補齊狀況，開頭 n 個「1」，後面 n-1 個「10」。「_11」需接後續。
  elseif string.match(binary_check, "11......$") then
    url_str = string.gsub(url_str, "..$", tail_mark)
-- 待輸入補齊狀況，開頭 n 個「1」，後面 n-1 個「10」。「_10」還未補齊。
  elseif string.match(binary_check, "_1111110._10......_10......_10......_10......$") then
    url_str = string.gsub(url_str, "..........$", tail_mark)
  elseif string.match(binary_check, "_1111110._10......_10......_10......$") then
    url_str = string.gsub(url_str, "........$", tail_mark)
  elseif string.match(binary_check, "_111110.._10......_10......_10......$") then
    url_str = string.gsub(url_str, "........$", tail_mark)
  elseif string.match(binary_check, "_1111110._10......_10......$") then
    url_str = string.gsub(url_str, "......$", tail_mark)
  elseif string.match(binary_check, "_111110.._10......_10......$") then
    url_str = string.gsub(url_str, "......$", tail_mark)
  elseif string.match(binary_check, "_11110..._10......_10......$") then
    url_str = string.gsub(url_str, "......$", tail_mark)
  elseif string.match(binary_check, "_1111110._10......$") then
    url_str = string.gsub(url_str, "....$", tail_mark)
  elseif string.match(binary_check, "_111110.._10......$") then
    url_str = string.gsub(url_str, "....$", tail_mark)
  elseif string.match(binary_check, "_11110..._10......$") then
    url_str = string.gsub(url_str, "....$", tail_mark)
  elseif string.match(binary_check, "_1110...._10......$") then
    url_str = string.gsub(url_str, "....$", tail_mark)
  end
-- 前方檢驗沒問題，才開始轉換成「URL encoding」，不然會有許多錯誤。
  local url_str = string.gsub (url_str, "(%x%x)", function(h) return string.char(tonumber(h,16)) end)
-- 已檢驗出錯誤，就不補「 … 」尾碼待補判別。
  -- if tail_single == true and url_str ~= "〈輸入錯誤〉"then
  if tail_single == true and not string.match(url_str, "〈輸入錯誤〉")then
    url_str = string.gsub(url_str, "$", " … ")
  end
  return url_str
end

--- 舊寫，錯誤
-- --[[
-- 百分號編碼（英語：Percent-encoding），又稱：URL編碼（URL encoding）
-- 從編碼到文字。
-- 導出暫轉到十進位編碼，後續變成文字，要再用以下函數轉換。
-- --]]
-- local function url_decode(str_d)
--   if string.match(str_d,'^[%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_1=o_1-00000000
--     local out_all=tonumber(string.format("%07d",o_1),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])..$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_1=o_1-11000000
--     local o_2=o_2-10000000
--     local out_all=tonumber(string.format("%05d",o_1) .. string.format("%06d",o_2),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])....$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])..$', '%1')
--     local ch_3 = string.gsub(str_d,'^....([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local x_3 = tonumber(ch_3, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_3 = Dec2bin(x_3)
--     local o_1=o_1-11100000
--     local o_2=o_2-10000000
--     local o_3=o_3-10000000
--     local out_all=tonumber(string.format("%04d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])......$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])....$', '%1')
--     local ch_3 = string.gsub(str_d,'^....([%x][%x])..$', '%1')
--     local ch_4 = string.gsub(str_d,'^......([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local x_3 = tonumber(ch_3, 16)
--     local x_4 = tonumber(ch_4, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_3 = Dec2bin(x_3)
--     local o_4 = Dec2bin(x_4)
--     local o_1=o_1-11110000
--     local o_2=o_2-10000000
--     local o_3=o_3-10000000
--     local o_4=o_4-10000000
--     local out_all=tonumber(string.format("%03d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])........$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])......$', '%1')
--     local ch_3 = string.gsub(str_d,'^....([%x][%x])....$', '%1')
--     local ch_4 = string.gsub(str_d,'^......([%x][%x])..$', '%1')
--     local ch_5 = string.gsub(str_d,'^........([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local x_3 = tonumber(ch_3, 16)
--     local x_4 = tonumber(ch_4, 16)
--     local x_5 = tonumber(ch_5, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_3 = Dec2bin(x_3)
--     local o_4 = Dec2bin(x_4)
--     local o_5 = Dec2bin(x_5)
--     local o_1=o_1-11111000
--     local o_2=o_2-10000000
--     local o_3=o_3-10000000
--     local o_4=o_4-10000000
--     local o_5=o_5-10000000
--     local out_all=tonumber(string.format("%02d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4) .. string.format("%06d",o_5),2)
--     return out_all
--   elseif string.match(str_d,'^[%x][%x][%x][%x][%x][%x][%x][%x][%x][%x][%x]$') then
--     local ch_1 = string.gsub(str_d,'^([%x][%x])..........$', '%1')
--     local ch_2 = string.gsub(str_d,'^..([%x][%x])........$', '%1')
--     local ch_3 = string.gsub(str_d,'^....([%x][%x])......$', '%1')
--     local ch_4 = string.gsub(str_d,'^......([%x][%x])....$', '%1')
--     local ch_5 = string.gsub(str_d,'^........([%x][%x])..$', '%1')
--     local ch_6 = string.gsub(str_d,'^..........([%x][%x])$', '%1')
--     local x_1 = tonumber(ch_1, 16)
--     local x_2 = tonumber(ch_2, 16)
--     local x_3 = tonumber(ch_3, 16)
--     local x_4 = tonumber(ch_4, 16)
--     local x_5 = tonumber(ch_5, 16)
--     local x_6 = tonumber(ch_6, 16)
--     local o_1 = Dec2bin(x_1)
--     local o_2 = Dec2bin(x_2)
--     local o_3 = Dec2bin(x_3)
--     local o_4 = Dec2bin(x_4)
--     local o_5 = Dec2bin(x_5)
--     local o_6 = Dec2bin(x_6)
--     local o_1=o_1-11111100
--     local o_2=o_2-10000000
--     local o_3=o_3-10000000
--     local o_4=o_4-10000000
--     local o_5=o_5-10000000
--     local o_6=o_6-10000000
--     local out_all=tonumber(string.format("%01d",o_1) .. string.format("%06d",o_2) .. string.format("%06d",o_3) .. string.format("%06d",o_4) .. string.format("%06d",o_5) .. string.format("%06d",o_6),2)
--     return out_all
--   elseif string.match(str_d,'^[a-z0-9]$') then
--     return str_d
--   else
--     local out_all='無此編碼'
--     return out_all
--   end
-- end

-- -- 網上方法，但空碼無法再接後續，不適用
-- local out_all = string.gsub(str_d, "%x%x", function(h) return string.char(tonumber(h,16)) end)
-- local function url_decode(str)
--   local str = string.gsub (str, "+", " ")
--   local str = string.gsub (str, "%%(%x%x)", function(h) return string.char(tonumber(h,16)) end)
--   local str = string.gsub (str, "\r\n", "\n")
--   return str
-- end
-- -- print(url_decode('EAb080'))

return url_decode