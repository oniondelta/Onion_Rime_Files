--[[
lua/key_binder.lua

rime.lua
key_binder = require("key_binder")

尚有問題，某些軟體中可以，某些錯亂失效！
--]]

local function swap_item(config, path1, path2)
  local c1 = config:get_item(path1)
  local c2 = config:get_item(path2)
  -- config:set_item(path1, c2)
  config:set_item(path2, c1)
end

local P = {}

function P.init(env)
  local sub_path = "/bindings"
  env.p1 = "key_binder" .. sub_path
  env.p2 = env.name_space .. sub_path
  -- env.v = 0
  -- --- 以下為原本程式碼（放在初始 init 不變動，故功能不能實現？）
  -- local config = env.engine.schema.config
  -- local sub_path = "/bindings"
  -- local p1 = "key_binder" .. sub_path
  -- local p2 = env.name_space .. sub_path

  -- swap_item(config, p1, p2)  -- swap
  -- env.key_binder = Component.Processor(env.engine, "", "key_binder")   -- key_binder@key1
  -- swap_item(conifg, p1, p2) -- restory

end

function P.fini(env)
end

local Rejected, Accepted, Noop = 0, 1, 2
function P.func(key, env)
  local engine = env.engine
  local context = engine.context
  local schema = engine.schema
  local config = schema.config
  -- local sub_path = "/bindings"
  -- local p1 = "key_binder" .. sub_path
  -- local p2 = env.name_space .. sub_path
  local s_k_b = context:get_option("switch_key_binder")

  -- swap_item(config, p1, p2)  -- swap
  -- c_p_key_binder = Component.Processor(engine, "", "key_binder")   -- key_binder@key1
  -- swap_item(conifg, p1, p2) -- restory

  swap_item(config, env.p1, env.p2)  -- swap
  env.key_binder = Component.Processor(engine, "", "key_binder")   -- key_binder@key1
  -- swap_item(conifg, env.p1, env.p2) -- restory

  if s_k_b then
    return env.key_binder:process_key_event(key)
    -- return c_p_key_binder:process_key_event(key)
  end

  -- --- 以下測試用：
  -- --- 「key_binder:process_key_event(key)」無法放在「init」！
  -- --- 無法用「env.v」判別，因為不經過「key_binder:process_key_event」，會恢復成原「key_binder」。
  -- if s_k_b and env.v == 1 then
  --   engine:commit_text("測試一" .. env.v)  -- 測試用
  --   return 2
  -- elseif not s_k_b then
  --   env.v = 0
  --   engine:commit_text("測試二" .. env.v)  -- 測試用
  --   return 2
  -- elseif s_k_b then
  --   env.v = 1
  --   engine:commit_text("測試三" .. env.v)  -- 測試用
  --   swap_item(config, env.p1, env.p2)  -- swap
  --   return c_p_key_binder:process_key_event(key)
  -- end

  return Noop
end
return P