--- @@ p_open_files
--[[
快捷鍵開啟檔案/程式/網站
--]]

----------------------------------------------------------------------------------------
local generic_open = require("p_components/p_generic_open")
local op_pattern = require("p_components/p_op_pattern")
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
  env.op_pattern = path .. "/lua/p_components/p_op_pattern.lua" or ""
  -- log.info("lua_custom_phrase: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
end


-- local function p_open_files(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local comp = context.composition
  local seg = comp:back()
  local o_ascii_mode = context:get_option("ascii_mode")

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

  elseif seg:has_tag("mf_translator") then  -- 開頭
    local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]*)$")
    -- if c_input == env.prefix .. "r" then
    if op_code then
      local key_kp = key:repr():match("^([a-z])$")
      local kp_p = op_pattern[ op_code .. key_kp ]
      if op_code == "f" and key:repr() == "t" then
        generic_open(env.op_pattern)
        context:clear()
        return 1
      elseif kp_p ~= nil then
        -- engine:commit_text(kp_p)  -- 測試用
        generic_open(kp_p)
        context:clear()
        return 1
      elseif env.textdict == "" then
        return 2
      elseif op_code == "f" and key:repr() == "c" then
        -- io.popen("env.custom_phrase")  -- 無效！
        generic_open(env.custom_phrase)
        context:clear()
        return 1
      end
    end

  end

  return 2 -- kNoop
end

-- return p_open_files
-- return { func = processor }
return { init = init, func = processor }