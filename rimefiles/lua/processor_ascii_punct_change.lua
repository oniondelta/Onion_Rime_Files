--- @@ ascii_punct_change
--[[
（bopomo_onionplus_2和3）
改變標點符號
於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
--]]

-- local function ascii_punct_change(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local g_c_t = context:get_commit_text()
  local o_ascii_punct = context:get_option("ascii_punct")
  local o_ascii_mode = context:get_option("ascii_mode")

  if o_ascii_mode then
    return 2

  elseif o_ascii_punct then
    if key:repr() == "Shift+less" then
      if context:is_composing() then
        engine:commit_text( g_c_t .. "," )
      else
        engine:commit_text( "," )
      end
      context:clear()
      return 1 -- kAccepted
    elseif key:repr() == "Shift+greater" then
      if context:is_composing() then
        engine:commit_text( g_c_t .. "." )
      else
        engine:commit_text( "." )
      end
      context:clear()
      return 1 -- kAccepted
    end

  end

  return 2 -- kNoop
end

-- return ascii_punct_change
return { func = processor }