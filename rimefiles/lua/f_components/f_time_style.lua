-- 上下午時間
local function time_out1()
  -- local time = os.time()
  -- local time_string = string.gsub(os.date("%H:%M", time), "^0+", "")
  -- local time_discrpt = time_description_chinese(time)
  -- local candidate = Candidate("time", seg.start, seg._end, time_string, time_discrpt)
  -- 時分（前面去零）
  local time_string = string.gsub(os.date("%I:%M %p"), "^0", "")
  local time_string_2 = string.gsub(time_string, "AM", "a.m.")
  local time_string_2 = string.gsub(time_string_2, "PM", "p.m.")
  local time_string_3 = string.gsub(time_string, "AM", "A.M.")
  local time_string_3 = string.gsub(time_string_3, "PM", "P.M.")
  local time_string_4 = string.gsub(time_string, "AM", "am")
  local time_string_4 = string.gsub(time_string_4, "PM", "pm")
  -- 時分（前面有零）
  local time_string_0_1 = os.date("%I:%M %p")
  local time_string_0_2 = string.gsub(time_string_0_1, "AM", "a.m.")
  local time_string_0_2 = string.gsub(time_string_0_2, "PM", "p.m.")
  local time_string_0_3 = string.gsub(time_string_0_1, "AM", "A.M.")
  local time_string_0_3 = string.gsub(time_string_0_3, "PM", "P.M.")
  local time_string_0_4 = string.gsub(time_string_0_1, "AM", "am")
  local time_string_0_4 = string.gsub(time_string_0_4, "PM", "pm")
  -- 時分秒（前面去零）
  local time_string_5 = string.gsub(os.date("%I:%M:%S %p"), "^0", "")
  local time_string_6 = string.gsub(time_string_5, "AM", "a.m.")
  local time_string_6 = string.gsub(time_string_6, "PM", "p.m.")
  local time_string_7 = string.gsub(time_string_5, "AM", "A.M.")
  local time_string_7 = string.gsub(time_string_7, "PM", "P.M.")
  local time_string_8 = string.gsub(time_string_5, "AM", "am")
  local time_string_8 = string.gsub(time_string_8, "PM", "pm")
  -- 時分秒（前面有零）
  local time_string_00_1 = os.date("%I:%M:%S %p")
  local time_string_00_2 = string.gsub(time_string_00_1, "AM", "a.m.")
  local time_string_00_2 = string.gsub(time_string_00_2, "PM", "p.m.")
  local time_string_00_3 = string.gsub(time_string_00_1, "AM", "A.M.")
  local time_string_00_3 = string.gsub(time_string_00_3, "PM", "P.M.")
  local time_string_00_4 = string.gsub(time_string_00_1, "AM", "am")
  local time_string_00_4 = string.gsub(time_string_00_4, "PM", "pm")
  -- candidate = Candidate("time", seg.start, seg._end, time_string, time_discrpt)
  return {time_string, time_string_2, time_string_3, time_string_4 , time_string_5, time_string_6, time_string_7, time_string_8, time_string_0_1, time_string_0_2, time_string_0_3, time_string_0_4, time_string_00_1, time_string_00_2, time_string_00_3, time_string_00_4}
end

-- 中文上下午時間
local function time_out2()
  -- 時分（前面有零）
  local time_c_string = os.date("%p %I時%M分")
  local time_c_string = string.gsub(time_c_string, "AM", "上午")
  local time_c_string = string.gsub(time_c_string, "PM", "下午")
  local time_c_string_2 = os.date("%p %I點%M分")
  local time_c_string_2 = string.gsub(time_c_string_2, "AM", "上午")
  local time_c_string_2 = string.gsub(time_c_string_2, "PM", "下午")
  local time_c_string_6 = os.date("%p %I:%M")
  local time_c_string_6 = string.gsub(time_c_string_6, "AM", "上午")
  local time_c_string_6 = string.gsub(time_c_string_6, "PM", "下午")
  -- 時分秒（前面有零）
  local time_c_string_3 = os.date("%p %I時%M分%S秒")
  local time_c_string_3 = string.gsub(time_c_string_3, "AM", "上午")
  local time_c_string_3 = string.gsub(time_c_string_3, "PM", "下午")
  local time_c_string_4 = os.date("%p %I點%M分%S秒")
  local time_c_string_4 = string.gsub(time_c_string_4, "AM", "上午")
  local time_c_string_4 = string.gsub(time_c_string_4, "PM", "下午")
  local time_c_string_7 = os.date("%p %I:%M:%S")
  local time_c_string_7 = string.gsub(time_c_string_7, "AM", "上午")
  local time_c_string_7 = string.gsub(time_c_string_7, "PM", "下午")
  -- 只有上下午
  local ampm = os.date("%p")
  local ampm = string.gsub(ampm, "AM", "上午")
  local ampm = string.gsub(ampm, "PM", "下午")
  return {time_c_string, time_c_string_2, time_c_string_3, time_c_string_4, ampm, time_c_string_6, time_c_string_7}
end

return { time_out1 = time_out1, time_out2 = time_out2 }