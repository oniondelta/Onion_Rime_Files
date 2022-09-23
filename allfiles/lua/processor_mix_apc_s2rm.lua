--- @@ mix_apc_s2rm 注音mixin 1_2_4 和 plus 專用
--[[
（bo_mixin 1、2、4；bopomo_onionplus）
合併 ascii_punct_change 和 s2r_most，增進效能。
--]]
local function mix_apc_s2rm(key, env)
  local engine = env.engine
  local context = engine.context
  local input_124 = context.input
  local orig_124 = context:get_commit_text()
  local c_b_d = context:get_option("ascii_punct")
  local en_m = context:get_option("ascii_mode")
  if (c_b_d) and (not en_m) then
    if (key:repr() == 'Shift+less') then
      if (context:is_composing()) then
        -- local orig_124 = context:get_commit_text()
        engine:commit_text( orig_124 .. "," )
      else
        engine:commit_text( "," )
      end
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == 'Shift+greater') then
      if (context:is_composing()) then
        -- local orig_124 = context:get_commit_text()
        engine:commit_text( orig_124 .. "." )
      else
        engine:commit_text( "." )
      end
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == "space") and (context:is_composing()) then
    -- elseif (key:repr() == "space") and (context:has_menu()) then
    -- elseif (key:repr() == "space") then
      -- local input_124 = context.input
      if ( string.find(input_124, "[@:]") or string.find(input_124, "'/") or string.find(input_124, "=[-125890;,./]$") or string.find(input_124, "=[-;,./][-;,./]$") or string.find(input_124, "==[90]$") ) then  --or string.find(input_124, "==[,.]{2}$")
      -- if ( string.find(input_124, "[@:]") or string.find(input_124, "'/") or string.find(input_124, "=[-125890;,./]$") or string.find(input_124, "=[-;,./][-;,./]$") or string.find(input_124, "==[90]$") or string.find(input_124, "==[,][,]?$") or string.find(input_124, "==[.][.]?$") ) then
      --「全，非精簡」 if ( string.find(input_124, "[@:]") or string.find(input_124, "'/") or string.find(input_124, "=[-125890;,./]$") or string.find(input_124, "=[-][-]$") or string.find(input_124, "=[;][;]$") or string.find(input_124, "=[,][,]$") or string.find(input_124, "=[.][.]$") or string.find(input_124, "=[/][/]$") or string.find(input_124, "==[90]$") or string.find(input_124, "==[,][,]?$") or string.find(input_124, "==[.][.]?$") ) then
        -- local orig_124 = context:get_commit_text()
        engine:commit_text(orig_124)
        context:clear()
        return 1 -- kAccepted
      end
    end
  elseif (not c_b_d) and (not en_m) then
    if (key:repr() == "space") and (context:is_composing()) then
    -- if (key:repr() == "space") and (context:has_menu()) then
    -- if (key:repr() == "space") then
      -- local input_124 = context.input
      if ( string.find(input_124, "[@:]") or string.find(input_124, "'/") or string.find(input_124, "=[-125890;,./]$") or string.find(input_124, "=[-;,./][-;,./]$") or string.find(input_124, "==[90]$") ) then  --or string.find(input_124, "==[,.]{2}$")
      -- if ( string.find(input_124, "[@:]") or string.find(input_124, "'/") or string.find(input_124, "=[-125890;,./]$") or string.find(input_124, "=[-;,./][-;,./]$") or string.find(input_124, "==[90]$") or string.find(input_124, "==[,][,]?$") or string.find(input_124, "==[.][.]?$") ) then
      --「全，非精簡」 if ( string.find(input_124, "[@:]") or string.find(input_124, "'/") or string.find(input_124, "=[-125890;,./]$") or string.find(input_124, "=[-][-]$") or string.find(input_124, "=[;][;]$") or string.find(input_124, "=[,][,]$") or string.find(input_124, "=[.][.]$") or string.find(input_124, "=[/][/]$") or string.find(input_124, "==[90]$") or string.find(input_124, "==[,][,]?$") or string.find(input_124, "==[.][.]?$") ) then
        -- local orig_124 = context:get_commit_text()
        engine:commit_text(orig_124)
        context:clear()
        return 1 -- kAccepted
      end
    end
  end
  return 2 -- kNoop
end

return mix_apc_s2rm