--[[
檢查各種組件版本
執行時記憶體會暴增
--]]
local function Version(env)
  -- local ver
  if rime_api.get_time_ms then
    return 409
  elseif Spans then
    return Spans().clear and 366 or 361
  elseif pcall(Segment, 0, 3) and Segment(0, 3).active_text then
    return 329
  elseif pcall(ConfigValue, 3) and ConfigValue(3).element and ConfigValue(3).element.get_obj then
    return 323
  elseif pcall(KeyEvent, 65, 1) and pcall(KeyEvent, "Shift+A") and KeyEvent(65, 1):eq(KeyEvent("Shift+A")) then    -- 65 == string.byte("A") == ("A"):byte()
  -- elseif pcall(KeyEvent, string.byte("A"), 1) and pcall(KeyEvent, "Shift+A") and KeyEvent(string.byte("A"), 1):eq(KeyEvent("Shift+A")) then
  -- elseif pcall(KeyEvent, ("A"):byte(), 1) and pcall(KeyEvent, "Shift+A") and KeyEvent(("A"):byte(), 1):eq(KeyEvent("Shift+A")) then
  -- elseif pcall(KeyEvent, 0x41, 0) and KeyEvent(0x41, 0):repr() == "A" then    -- 0x41 == 65 (十六進位 vs 十進位)
    return 321
  elseif ShadowCandidate then
    return 296
  elseif Component and Component.TableTranslator then
    return 287
  elseif UserDb and TableDb then
    return 240
  elseif UserDb then
    return 220
  elseif type(env) == "table" and env.engine then
    if env.engine.context.composition:toSegmentation().get_segments then
      return 215
    end
  end
  if Opencc and Opencc('s2t.json') and Opencc('s2t.json').convert_word then
    return 200
  elseif rime_api.regex_match then
    return 197
  elseif rime_api.get_distribution_name then
    return 185
  elseif LevelDb then
    return 177
  elseif Opencc then
    return 147
  elseif KeySequence and KeySequence().repr then
    return 139
  elseif  ConfigMap and ConfigMap().keys then
    return 127
  elseif Projection then
    return 102
  elseif KeyEvent then
    return 100
  elseif Memory then
    return 80
  elseif rime_api.get_user_data_dir then
    return 9
  elseif log then
    return 9
  else
    return 0
  end
end

local function Ver_info(env)
  local version_n = pcall(Version, env) and Version(env) or 0
  local unknowns = {
    ["no"] = "⚠️ 無法識別",
    ["l_185"] = "🛑 librime-lua 小於 #185，無識別",
    ["l_9"] = "🛑 librime-lua 小於 #9，無識別",
   }
  local items = {
    [1] = "〈介面 名稱和版本〉",
    [2] = "〈librime / rime 版本〉",
    [3] = "〈librime-lua 版本〉",
    [4] = "〈lua 版本〉",
    [5] = "〈ID〉",
    [6] = "〈用戶資料夾〉",
    [7] = "〈同步資料夾〉",
    [8] = "〈程序資料夾〉",
   }
  local fw = "函式"
  local distribution_v = rime_api.get_distribution_code_name and rime_api.get_distribution_version and rime_api.get_distribution_name
                     and string.format("%s %s（%s）",
                                       rime_api.get_distribution_code_name(),
                                       rime_api.get_distribution_version(),
                                       rime_api.get_distribution_name())
                      or unknowns.no .. items[1]
  local librime_v = rime_api.get_rime_version and string.format("librime %s", rime_api.get_rime_version()) or unknowns.no .. items[2]
  local librime_lua_v = version_n ~= 0 and string.format("librime-lua #%s", version_n) or unknowns.no .. items[3]
  local lua_v = _VERSION and string.format("%s", _VERSION) or unknowns.no .. items[4]
  local i_id = rime_api.get_user_id and string.format("%s", rime_api.get_user_id()) or unknowns.no .. items[5]
  local user_dir = rime_api.get_user_data_dir and rime_api.get_user_data_dir() or unknowns.no .. items[6]
  local syn_dir = rime_api.get_sync_dir and rime_api.get_sync_dir() or unknowns.no .. items[7]
  local shared_dir = rime_api.get_shared_data_dir and rime_api.get_shared_data_dir() or unknowns.no .. items[8]
  if version_n >= 185 then
  elseif version_n >= 9 then
    distribution_v = unknowns.l_185 .. items[1] .. fw
    i_id = unknowns.l_185 .. items[5] .. fw
  else
    distribution_v = unknowns.l_9 .. items[1] .. fw
    librime_v = unknowns.l_9 .. items[2] .. fw
    librime_lua_v = unknowns.l_9 .. items[3] .. fw
    lua_v = unknowns.l_9 .. items[4] .. fw
    i_id = unknowns.l_9 .. items[5] .. fw
    user_dir = unknowns.l_9 .. items[6] .. fw
    syn_dir = unknowns.l_9 .. items[7] .. fw
    shared_dir = unknowns.l_9 .. items[8] .. fw
  end
  return {distribution_v, librime_v, librime_lua_v, lua_v, i_id, user_dir, syn_dir, shared_dir}
end

return Ver_info