--- 補充時辰
-- local GetLunarSichen = function(time,t)
-- local GetLunarSichen = function(time)
local function GetLunarSichen(time)
  local LunarSichen = {"子時(夜半︱三更)", "丑時(雞鳴︱四更)", "寅時(平旦︱五更)", "卯時(日出)", "辰時(食時)", "巳時(隅中)", "午時(日中)", "未時(日昳)", "申時(哺時)", "酉時(日入)", "戌時(黃昏︱一更)", "亥時(人定︱二更)"}
  local time = tonumber(time)
  local sj = math.floor((time+1)/2)+1  -- math.floor 實現四捨五入
  -- if tonumber(t) == 1 then
  --   sj = math.floor((time+1)/2)+1
  -- elseif tonumber(t) == 0 then
  --   sj = math.floor((time+13)/2)+1
  -- end
  if sj > 12 then
    return LunarSichen[sj-12] or "無效時間"
  else
    return LunarSichen[sj] or "無效時間"
  end
end




return GetLunarSichen