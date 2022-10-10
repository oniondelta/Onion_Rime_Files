--- @@ mix_apc_pluss
--[[
（bopomo_onionplus_space）
以原 ascii_punct_change 增加功能
使初始空白可以直接上屏
於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
--]]
local function mix_apc_pluss(key, env)
  local engine = env.engine
  local context = engine.context
  local caret_pos = context.caret_pos
  local orig_ps = context:get_commit_text()
  local o_ascii_punct = context:get_option("ascii_punct")
  local o_ascii_mode = context:get_option("ascii_mode")
  -- if (context:get_option("ascii_mode")) then
  --   return 2
  if (o_ascii_punct) and (not o_ascii_mode) then
  -- if (context:get_option("ascii_punct")) and (not context:get_option("ascii_mode")) then
    -- local caret_pos = context.caret_pos
    if (key:repr() == 'Shift+less') then
      if (context:is_composing()) then
        -- local orig_ps = context:get_commit_text()
        engine:commit_text( orig_ps .. "," )
      else
        engine:commit_text( "," )
      end
      context:clear()
      return 1 -- kAccepted
    -- end
    elseif (key:repr() == "Shift+greater") then
      if (context:is_composing()) then
        -- local orig_ps = context:get_commit_text()
        engine:commit_text( orig_ps .. "." )
      else
        engine:commit_text( "." )
      end
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == "space") and (caret_pos == 0) then
      engine:commit_text( " " )
      context:clear()
      return 1 -- kAccepted
    end
  elseif (not o_ascii_punct) and (not o_ascii_mode) then
  -- elseif (not context:get_option("ascii_punct")) and (not context:get_option("ascii_mode")) then
    -- local caret_pos = context.caret_pos
    if (key:repr() == "space") and (caret_pos == 0) then
      engine:commit_text( " " )
      context:clear() 
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end

return mix_apc_pluss