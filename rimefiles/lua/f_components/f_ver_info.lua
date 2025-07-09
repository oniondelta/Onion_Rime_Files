--[[
檢查各種組件版本
執行時記憶體會暴增
--]]
local function Version(env)

  -- if KeyEvent(0x41,0):repr() == "A" then  -- 如果非該版，會報錯！
  if KeyEvent("A",1):repr() == "Shift+A" then
    return 321
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
  local ver
  if Opencc and Opencc('s2t.json').convert_word then
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
  local version_n = Version(env) or 0
  if version_n >= 185 then
    distribution_v = string.format("%s %s  (%s)",
    rime_api.get_distribution_code_name(),
    rime_api.get_distribution_version(),
    rime_api.get_distribution_name()) or ""
    librime_v = string.format("librime %s", rime_api.get_rime_version()) or ""
    librime_lua_v = string.format("librime-lua #%s", version_n) or ""
    lua_v = string.format("%s", _VERSION) or ""
    i_id = string.format("%s", rime_api.get_user_id()) or ""
  elseif version_n >= 9 then
    distribution_v = "librime-lua 小於 185，無判定函數"
    librime_v = string.format("librime %s", rime_api.get_rime_version()) or ""
    librime_lua_v = string.format("librime-lua #%s", version_n) or ""
    lua_v = string.format("%s", _VERSION) or ""
    i_id = "librime-lua 小於 185，無判定 id 函數"
  else
    distribution_v = "librime-lua 小於 9，皆無法判定"
    librime_v = "librime-lua 小於 9，皆無法判定"
    librime_lua_v = "librime-lua 小於 9，皆無法判定"
    lua_v = "librime-lua 小於 9，皆無法判定"
    i_id = "librime-lua 小於 9，皆無法判定"
  end
  return {distribution_v, librime_v, librime_lua_v, lua_v, i_id}
end

return Ver_info