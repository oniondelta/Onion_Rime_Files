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
  local caret_pos_ps = context.caret_pos
  local orig_ps = context:get_commit_text()
  local c_b_d = context:get_option("ascii_punct")
  local en_m = context:get_option("ascii_mode")
  if (c_b_d) and (not en_m) then
    -- local caret_pos_ps = context.caret_pos
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
    elseif (key:repr() == 'Shift+greater') then
      if (context:is_composing()) then
        -- local orig_ps = context:get_commit_text()
        engine:commit_text( orig_ps .. "." )
      else
        engine:commit_text( "." )
      end
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == "space") and (caret_pos_ps == 0) then
      engine:commit_text( " " )
      context:clear()
      return 1 -- kAccepted
    end
  elseif (not c_b_d) and (not en_m) then
    -- local caret_pos_ps = context.caret_pos
    if (key:repr() == "space") and (caret_pos_ps == 0) then
      engine:commit_text( " " )
      context:clear() 
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end

return mix_apc_pluss