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
  local o_ascii_punct = context:get_option("ascii_punct")
  local o_ascii_mode = context:get_option("ascii_mode")
  -- local c_i_c = context:is_composing()
  -- if (context:get_option("ascii_mode")) then
  --   return 2
  if (o_ascii_punct) and (not o_ascii_mode) then
  -- if (context:get_option("ascii_punct")) and (not context:get_option("ascii_mode")) then
    if (key:repr() == "Shift+less") then
      if (context:is_composing()) then
      -- if (c_i_c) then
        -- local orig_124 = context:get_commit_text()
        engine:commit_text( orig_124 .. "," )
      else
        engine:commit_text( "," )
      end
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == "Shift+greater") then
      if (context:is_composing()) then
      -- if (c_i_c) then
        -- local orig_124 = context:get_commit_text()
        engine:commit_text( orig_124 .. "." )
      else
        engine:commit_text( "." )
      end
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == "space") and (context:is_composing()) then
    -- elseif (key:repr() == "space") and (c_i_c) then
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
  elseif (not o_ascii_punct) and (not o_ascii_mode) then
  -- elseif (not context:get_option("ascii_punct")) and (not context:get_option('ascii_mode')) then
    if (key:repr() == "space") and (context:is_composing()) then
    -- if (key:repr() == "space") and (c_i_c) then
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