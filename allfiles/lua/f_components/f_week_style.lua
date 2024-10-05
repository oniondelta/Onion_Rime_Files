-- 星期格式

local function weekstyle()
  local week_n = os.date("%w")
  local l_w = { "日", "一", "二", "三", "四", "五", "六" }
  local l_w_c = { "日", "壹", "貳", "參", "肆", "伍", "陸" }
  local l_w_jp1 = { "㈰", "㈪", "㈫", "㈬", "㈭", "㈮", "㈯" }
  local l_w_jp2 = { "㈰", "㈪", "㈫", "㈬", "㈭", "㈮", "㊏" }
  local l_w_jp3 = { "日", "月", "火", "水", "木", "金", "土" }
  local l_w_eng1 = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
  local l_w_eng2 = { "Sun.", "Mon.", "Tues.", "Wed.", "Thur.", "Fri.", "Sat." }
  local l_w_eng3 = { "Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat" }
  local weekstr = l_w[week_n+1]
  local weekstr_c = l_w_c[week_n+1]
  local weekstr_jp1 = l_w_jp1[week_n+1]
  local weekstr_jp2 = l_w_jp2[week_n+1]
  local weekstr_jp3 = l_w_jp3[week_n+1]
  local weekstr_eng1 = l_w_eng1[week_n+1]
  local weekstr_eng2 = l_w_eng2[week_n+1]
  local weekstr_eng3 = l_w_eng3[week_n+1]
  -- 先展示星期，以便後面使用
  -- if (os.date("%w") == "0") then
  --     weekstr = "日"
  --     weekstr_c = "日"
  --     weekstr_jp1 = "㈰"
  --     weekstr_jp2 = "㊐"
  --     weekstr_jp3 = "日"
  --     weekstr_eng1 = "Sunday"
  --     weekstr_eng2 = "Sun."
  --     weekstr_eng3 = "Sun"
  -- elseif (os.date("%w") == "1") then
  --     weekstr = "一"
  --     weekstr_c = "壹"
  --     weekstr_jp1 = "㈪"
  --     weekstr_jp2 = "㊊"
  --     weekstr_jp3 = "月"
  --     weekstr_eng1 = "Monday"
  --     weekstr_eng2 = "Mon."
  --     weekstr_eng3 = "Mon"
  -- elseif (os.date("%w") == "2") then
  --     weekstr = "二"
  --     weekstr_c = "貳"
  --     weekstr_jp1 = "㈫"
  --     weekstr_jp2 = "㊋"
  --     weekstr_jp3 = "火"
  --     weekstr_eng1 = "Tuesday"
  --     weekstr_eng2 = "Tues."
  --     weekstr_eng3 = "Tues"
  -- elseif (os.date("%w") == "3") then
  --     weekstr = "三"
  --     weekstr_c = "參"
  --     weekstr_jp1 = "㈬"
  --     weekstr_jp2 = "㊌"
  --     weekstr_jp3 = "水"
  --     weekstr_eng1 = "Wednesday"
  --     weekstr_eng2 = "Wed."
  --     weekstr_eng3 = "Wed"
  -- elseif (os.date("%w") == "4") then
  --     weekstr = "四"
  --     weekstr_c = "肆"
  --     weekstr_jp1 = "㈭"
  --     weekstr_jp2 = "㊍"
  --     weekstr_jp3 = "木"
  --     weekstr_eng1 = "Thursday"
  --     weekstr_eng2 = "Thur."
  --     weekstr_eng3 = "Thur"
  -- elseif (os.date("%w") == "5") then
  --     weekstr = "五"
  --     weekstr_c = "伍"
  --     weekstr_jp1 = "㈮"
  --     weekstr_jp2 = "㊎"
  --     weekstr_jp3 = "金"
  --     weekstr_eng1 = "Friday"
  --     weekstr_eng2 = "Fri."
  --     weekstr_eng3 = "Fri"
  -- elseif (os.date("%w") == "6") then
  --     weekstr = "六"
  --     weekstr_c = "陸"
  --     weekstr_jp1 = "㈯"
  --     weekstr_jp2 = "㊏"
  --     weekstr_jp3 = "土"
  --     weekstr_eng1 = "Saturday"
  --     weekstr_eng2 = "Sat."
  --     weekstr_eng3 = "Sat"
  -- end
  return {weekstr, weekstr_c, weekstr_jp1, weekstr_jp2, weekstr_jp3, weekstr_eng1, weekstr_eng2, weekstr_eng3 }
end

return weekstyle