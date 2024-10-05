--- @@ mix_apc_ltk_pluss
--[[
（bopomo_onionplus_space）
合併 ascii_punct_change、lua_tran_kp 並增加功能
使初始空白可以直接上屏
於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
新增快捷鍵開啟檔案/程式/網站
--]]

----------------------------------------------------------------------------------------
local generic_open = require("p_components/p_generic_open")
local run_pattern = require("p_components/p_run_pattern")
-- local op_pattern = require("p_components/p_op_pattern")
----------------------------------------------------------------------------------------

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
  -- env.op_pattern = path .. "/lua/p_components/p_op_pattern.lua" or ""
  -- log.info("lua_custom_phrase: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
  -- env.kp_pattern = {
  --   ["0"] = "0",
  --   ["1"] = "1",
  --   ["2"] = "2",
  --   ["3"] = "3",
  --   ["4"] = "4",
  --   ["5"] = "5",
  --   ["6"] = "6",
  --   ["7"] = "7",
  --   ["8"] = "8",
  --   ["9"] = "9",
  --   ["Add"] = "+",
  --   ["Subtract"] = "-",
  --   ["Multiply"] = "*",
  --   ["Divide"] = "/",
  --   ["Decimal"] = ".",
  --  }
end

local kp_pattern = {
  ["0"] = "0",
  ["1"] = "1",
  ["2"] = "2",
  ["3"] = "3",
  ["4"] = "4",
  ["5"] = "5",
  ["6"] = "6",
  ["7"] = "7",
  ["8"] = "8",
  ["9"] = "9",
  ["Add"] = "+",
  ["Subtract"] = "-",
  ["Multiply"] = "*",
  ["Divide"] = "/",
  ["Decimal"] = ".",
 }

-- local function mix_apc_ltk_pluss(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  local g_c_t = context:get_commit_text()
  local o_ascii_punct = context:get_option("ascii_punct")
  local o_ascii_mode = context:get_option("ascii_mode")

  local check_pre = string.match(c_input, "'/[-]?[.]?$")
  local check_num_cal = string.match(c_input, "'/[-]?[.]?%d+%.?%d*$") or
                        string.match(c_input, "'/[-.rq(]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*$")
  -- local key_kp = key:repr():match("KP_([%d%a]+)")  -- KP_([ASDM%d][%a]*)
  -- local kp_p = env.kp_pattern[key_kp]

---------------------------------------------------------------------------

  if o_ascii_mode then
    return 2

  -- --- 該條目移到下方，這邊開啟 Shift+less 和 Shift+greater 啟始無法作用
  -- --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  -- elseif comp:empty() then
  --   return 2

  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2

---------------------------------------------------------------------------
--[[
以下特殊時 space 直上屏
--]]

  elseif key:repr() == "space" and caret_pos == 0 then
      engine:commit_text( " " )
      context:clear()
      return 1 -- kAccepted

---------------------------------------------------------------------------
--[[
以下 ascii_punct 標點轉寫
--]]

  elseif o_ascii_punct and key:repr() == "Shift+less" then
    if context:is_composing() then
      -- local cand = context:get_selected_candidate()
      -- engine:commit_text( cand.text .. "," )  -- ascii_punct 時選擇選項與其他標點不統一
      engine:commit_text( g_c_t .. "," )
    else
      engine:commit_text( "," )
    end
    context:clear()
    return 1 -- kAccepted

  elseif o_ascii_punct and key:repr() == "Shift+greater" then
    if context:is_composing() then
      -- local cand = context:get_selected_candidate()
      -- engine:commit_text( cand.text .. "." )  -- ascii_punct 時選擇選項與其他標點不統一
      engine:commit_text( g_c_t .. "." )
    else
      engine:commit_text( "." )
    end
    context:clear()
    return 1 -- kAccepted

---------------------------------------------------------------------------
--[[
以下使得純數字和計算機時，於小鍵盤可輸入數字和運算符
以下使得輸入開啟碼可開啟檔案程式網址
--]]

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  elseif seg:has_tag("mf_translator") then
  -- elseif seg:has_tag("lua") then

    local key_kp = key:repr():match("^KP_([%d%a]+)$")  -- KP_([ASDM%d][%a]*)
    local kp_p = kp_pattern[key_kp]
    if kp_p ~= nil then
      if not check_pre and not check_num_cal then
        return 2
      elseif string.match(kp_p, "[%d.-]") then
        -- context.input = c_input .. kp_p
        context:push_input( kp_p )
        return 1
      --- 防開頭後接[+*/]
      elseif check_pre then
        return 2
      elseif string.match(kp_p, "[+*/]") then
        -- context.input = c_input .. kp_p
        context:push_input( kp_p )
        return 1
      end
    end

    local op_code_check = not string.match(c_input, env.prefix .. "['/;]") and string.match(c_input, env.prefix .. "j[a-z]+$")
    local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]+)$")
    if op_code_check and (key:repr() == "space" or key:repr() == "Return" or key:repr() == "KP_Enter") then
      local run_in = run_pattern[ op_code ] -- 此處不能「.open」，如 op_code 不符合會報錯！
      if not op_code then
        return 1
      elseif #c_input ~= caret_pos then
        -- context:clear()
        return 1
      elseif op_code == "t" then
        -- engine:commit_text( "TEST！！！" )  -- 測試用
        generic_open(env.run_pattern)
        context:clear()
        return 1
      elseif run_in ~= nil then
        -- engine:commit_text(run_in)  -- 測試用
        generic_open(run_in.open)  -- 要確定 run_in 不為 nil，才能加.open
        context:clear()
        return 1
      elseif env.textdict == "" then
        return 2
      elseif op_code == "c" then
        -- io.popen("env.custom_phrase")  -- 無效！
        generic_open(env.custom_phrase)
        context:clear()
        return 1
      else  -- 沒有該碼，空白鍵清空
        -- context:confirm_current_selection()
        context:clear()
        return 1
      end
    end

    -- if env.prefix == "" then  -- 前面 seg:has_tag 已確定
    --   return 2

    -- local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]*)$")
    -- -- if c_input == env.prefix .. "r" then
    -- if op_code then
    --   local key_kp = key:repr():match("^([a-z])$")
    --   local kp_p = op_pattern[ op_code .. key_kp ]
    --   if op_code == "f" and key:repr() == "t" then
    --     generic_open(env.op_pattern)
    --     context:clear()
    --     return 1
    --   elseif kp_p ~= nil then
    --     -- engine:commit_text(kp_p)  -- 測試用
    --     generic_open(kp_p)
    --     context:clear()
    --     return 1
    --   elseif env.textdict == "" then
    --     return 2
    --   elseif op_code == "f" and key:repr() == "c" then
    --     -- io.popen("env.custom_phrase")  -- 無效！
    --     generic_open(env.custom_phrase)
    --     context:clear()
    --     return 1
    --   end
    -- end

---------------------------------------------------------------------------
--- 測試
  -- elseif seg:has_tag("japan") then
  --   if key:repr() == "space" then
  --     context:push_input( "|" )
  --     return 1
  --   end

---------------------------------------------------------------------------

  end

  return 2 -- kNoop
end

-- return mix_apc_ltk_pluss
-- return { func = processor }
return { init = init, func = processor }