--[[
簡易計算機
--]]

local function str_to_cal(str)
  return load("return "..str)()
end

local function check_14_digits(n)  -- 14位數檢查，超過14位或小數點以下14位數。
  local check_1 = string.match(n, "%.%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d+") and true
  local check_2 = string.match(n, "%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d+") and true
  -- local check_3 = string.match(n, "%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d+") and true
  local check_3 = tonumber(string.match(n, "e[-](%d+)") or 0) > 14 and true
  -- local check_3 = false
  local check_n = check_1 or check_2
  return {check_1, check_2, check_3, check_n}
end

-- local function check_number_values(n)
--   local check_1 = tonumber(string.match(n, "e[-](%d+)") or 0) > 14 and true
--   -- local check_2 = tonumber(string.match(n, "([%d]+)") or 0) > 10^18 and true
--   -- local check_2 = tonumber(string.match(n, "([%d]+)") or 0) > 9223372036854775807 and true
--   local check_2 = false
--   return {check_1, check_2}
-- end

local function simple_calculator(input)
  -- print('原始輸入：'..input)
  local error_check = string.match(input, "^[-.(%d][-+*/^().%d]*$")
  -- local error_2oper = string.match(input, "[-+*/^][-+*/^]")
  local error_dot = string.match(input, "%.%d+%.%d") or
                    string.match(input, "%.%.")
  local error_paren = string.match(input, "^[^(]+[)]") or
                      string.match(input, "[-+*/^(][)]") or
                      string.match(input, "[(][+*/^]")
                      -- string.match(input, "[)]%d")
  -- local error_digits = tonumber(string.match(input, "%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d+")) or 0  --19位數以上檢查

  -- if not ok_1 then return print("輸入錯誤1") end
  -- if error_1 or error_2 then return print("輸入錯誤2") end
  if not error_check then return {"Error (check)", input, ""} end
  -- if error_2oper then return {"Error (2oper)", input, ""} end
  if error_dot then return {"Error (dot)", input, ""} end
  if error_paren then return {"Error (paren)", input, ""} end
  -- if check_14_digits(input)[4] then over14d = true end
  -- if not check_14_digits(input)[4] then over14d = false end
  -- if check_14_digits(input)[4] then return {"Warning (Input over 14 digits)", input, ""} end
  -- if error_digits > 9223372036854775807 then return {"Error (over 2⁶³-1)", input, ""} end

  local input = string.gsub(input, "[-+*/]+([-+*/^])", "%1")  --重複(誤按)算符，不用回刪(一)
  local input = string.gsub(input, "[%^]+([+*/^])", "%1")  --重複(誤按)算符，不用回刪(二)，使次方後負號可行，如： 3^-2 等
  local input = string.gsub(input, "%.([-+*/^()])", "%1")  -- 允許小數點末尾多加，如：237.+271
  local input = string.gsub(input, "([)%d])[(]", "%1*(")  -- 2(9) 或 (2)(9) 中間轉為乘法
  local input = string.gsub(input, "[)]([%d])", ")*%1")  -- (2)9 中間轉為乘法
  -- local input = string.gsub(input, "[(]+([-]?[.%d]+)$", "%1")  -- 未完成前，括號後，末尾為數字
  -- local input = string.gsub(input, "[(]+([^()]*)$", "%1")  -- 未完成前，括號後，末尾為計算符號
  local input = string.gsub(input, "[-+*/^(.]+$", "")  -- 未完成前，末尾為計算符號，先略
  local input = string.gsub(input, "[(]+([-+*/^.%d]+)$", "(%1)")  -- 未完成前，前端有括號，末尾為數字和計算符號，後端補括號
  local input = string.gsub(input, "[(]+([-+*/^.%d]*%b()[-+*/^.%d]*)$", "(%1)")  -- 未完成前，前端有括號，末尾含有一個括號組，後端補括號
  local input = string.gsub(input, "[(]+([-+*/^.%d]*%b()[-+*/^.%d]*%b()[-+*/^.%d]*)$", "(%1)")  -- 未完成前，前端有括號，末尾含有二個括號組，後端補括號
  local input = string.gsub(input, "[(]+([-+*/^.%d]*%b()[-+*/^.%d]*%b()[-+*/^.%d]*%b()[-+*/^.%d]*)$", "(%1)")  -- 未完成前，前端有括號，末尾含有三個括號組，後端補括號
  local input = string.gsub(input, "[(](%b())[)]", "%1")  -- 雙重括號，減為單一個
  -- print('轉換後：'..input)

  local ok, res = pcall(str_to_cal, input)
  if ok then
    -- print('最終結果：'..str_to_cal(input))
    -- print(ok)
    -- print(res)
    -- result = string.gsub(str_to_cal(input), "%.0$", "")
    -- result = string.format("%f", str_to_cal(input))  -- 小數點位數太短
    local result = str_to_cal(input)
    -- local result_f = string.format("%.19f", result)
    local over14d = check_14_digits(input)[4]
    local check_14_digits = check_14_digits(result)
    -- local check_number_values = check_number_values(result)

    -- if 1.000000e+14 > result and result >= 1.000000e-14 then
    -- if result >= 1.000000e+14 then  --%f下，大於14位數可能出現誤差
    -- if result >= 1.000000e-14 then
    if over14d then
      shadow = string.gsub(result, "%.0$", "")
      result = "Warning (Input over 14 digits)"
    elseif check_14_digits[3] then  -- 校正於 0.1+0.2-0.3 會出現e科學記號且不為0
    -- if check_number_values[1] then  -- 校正於 0.1+0.2-0.3 會出現e科學記號且不為0
    -- if result < 1.000000e-14 then  --小數點以下超過14位數可能出現誤差
      shadow = ""
      -- shadow = string.gsub(result, "%.0$", "")
      result = string.format("%.14f", result)
      result = string.gsub(result, "(%.%d*0)$", function(n) return string.gsub(n,"0+$", "") end)  --去除小數點後末尾0
      result = string.gsub(result, "%.$", "")
      result = string.gsub(result, "^[-]0$", "0")
    elseif not check_14_digits[4] then
    -- elseif not check_14_digits[1] and not check_14_digits[3] then
    -- elseif not check_14_digits[2] then
    -- elseif not check_number_values[2] then
    -- elseif result < 9223372036854775807 and result >= 1.000000e-14 then
      shadow = ""
      result = string.gsub(result, "%.0$", "")
      -- result = string.gsub(result, "%.$", "")
      -- result = string.gsub(result, "^[-]0$", "0")
      -- result = string.format("%f", result)  -- 小數點位數太短
    else
      shadow = string.gsub(result, "%.0$", "")
      result = "Warning (Output over 14 digits)"
      -- result = "Ban (Output over 14 digits)"
      -- result = "Warning (over 2⁶³-1)"
    end

    return {result, input , shadow}
  else
    -- print('輸入錯誤！')
    -- print(ok)
    -- print(res)
    return {"Error！ (by_pcall)", input, ""}
  end
end

--- 測試
-- print(simple_calculator('5^(1+1+1)+(9+9)'))
-- print(simple_calculator('27^(1/3)'))
-- print(simple_calculator('9/(3.3.'))
-- print(simple_calculator('(-1/3)'))
-- print(simple_calculator('3+(.3'))

return simple_calculator