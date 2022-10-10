--- @@ ascii_punct_change 改變標點符號
--[[
（bopomo_onionplus_2和3）
於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
--]]
local function ascii_punct_change(key, env)
  local engine = env.engine
  local context = engine.context
  local orig_p23 = context:get_commit_text()
  local o_ascii_punct = context:get_option("ascii_punct")
  local o_ascii_mode = context:get_option("ascii_mode")
  -- if (context:get_option("ascii_mode")) then
  --   return 2
  if (o_ascii_punct) and (not o_ascii_mode) then
  -- if (context:get_option("ascii_punct")) and (not context:get_option("ascii_mode")) then
    -- local orig_p23 = context:get_commit_text()
    if (key:repr() == "Shift+less") then
      if (context:is_composing()) then
        -- local orig_p23 = context:get_commit_text()
        engine:commit_text( orig_p23 .. "," )
      else
        engine:commit_text( "," )
      end
      context:clear()
      return 1 -- kAccepted
    -- end
    elseif (key:repr() == "Shift+greater") then
      if (context:is_composing()) then
        -- local orig_p23 = context:get_commit_text()
        engine:commit_text( orig_p23 .. "." )
      else
        engine:commit_text( "." )
      end
      context:clear()
      return 1 -- kAccepted
    end
  end
  return 2 -- kNoop
end

return ascii_punct_change