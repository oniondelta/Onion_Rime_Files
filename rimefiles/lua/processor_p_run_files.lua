--- @@ p_run_files
--[[
（bopomo_onionplus_2）
快捷鍵開啟檔案/程式/網站
--]]

----------------------------------------------------------------------------------------
local oscmd = require("p_components/p_oscmd")
local run_open = require("p_components/p_run_open")
-- local generic_open = require("p_components/p_generic_open")
-- local run_pattern = require("p_components/p_run_pattern")
----------------------------------------------------------------------------------------

-- local function generic_open(dest)
--   if os.execute('start "" ' .. dest) then
--     return true
--   elseif os.execute('open ' .. dest) then
--     return true
--   elseif os.execute('xdg-open ' .. dest) then
--     return true
--   end
-- end


local function init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local namespace1 = "mf_translator"
  local namespace2 = "lua_custom_phrase"
  local path = rime_api.get_user_data_dir()
  env.prefix = config:get_string(namespace1 .. "/prefix") or ""
  env.textdict = config:get_string(namespace2 .. "/user_dict") or ""
  env.custom_phrase = path .. "/" .. env.textdict .. ".txt" or ""
  env.run_pattern = path .. "/lua/p_components/p_run_pattern.lua" or ""
  -- log.info("lua_custom_phrase: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
  env.oscmd = oscmd
end


-- local function p_open_files(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  -- local g_c_t = context:get_commit_text()
  local o_ascii_mode = context:get_option("ascii_mode")
  local key_repr = key:repr()

  -- if env.textdict == "" or env.prefix == "" then
  if env.prefix == "" then
    return 2

  elseif o_ascii_mode then
    return 2
  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2
  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2

-----------------------------------------------------------------------------

  --- pass not space Return KP_Enter key_num
  elseif key_repr ~= "space" and key_repr ~= "Return" and key_repr ~= "KP_Enter" then
    return 2

-----------------------------------------------------------------------------

  elseif seg:has_tag("mf_translator") then  -- 開頭
    local op_code_check = not string.match(c_input, env.prefix .. "['/;]") and string.match(c_input, env.prefix .. "j[a-z]+$")
    local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]+)$")
    if op_code_check then
      return run_open(context, c_input, caret_pos, op_code, env.run_pattern, env.textdict, env.custom_phrase, env.oscmd)
      -- return run_open(engine, context, c_input, caret_pos, op_code, env.run_pattern, env.textdict, env.custom_phrase, env.oscmd)
    end
  end

  return 2 -- kNoop
end

-- return p_run_files
-- return { func = processor }
return { init = init, func = processor }