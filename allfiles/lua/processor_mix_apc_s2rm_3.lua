--- @@ mix_apc_s2rm_3 注音mixin 3
--[[
（bo_mixin3）
合併 ascii_punct_change 和 s2r_mixin3，增進效能。
--]]
local function mix_apc_s2rm_3(key, env)
  local engine = env.engine
  local context = engine.context
  local input_3 = context.input
  local orig_3 = context:get_commit_text()
  -- local c_b_d = context:get_option("ascii_punct")
  -- local en_m = context:get_option("ascii_mode")
  -- if (context:get_option('ascii_mode')) then
  --   return 2
  if (context:get_option("ascii_punct")) and (not context:get_option('ascii_mode')) then
  -- if (c_b_d) and (not en_m) then
    if (key:repr() == 'Shift+less') then
      if (context:is_composing()) then
        -- local orig_3 = context:get_commit_text()
        engine:commit_text( orig_3 .. "," )
      else
        engine:commit_text( "," )
      end
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == 'Shift+greater') then
      if (context:is_composing()) then
        -- local orig_3 = context:get_commit_text()
        engine:commit_text( orig_3 .. "." )
      else
        engine:commit_text( "." )
      end
      context:clear()
      return 1 -- kAccepted
    elseif (key:repr() == "space") and (context:is_composing()) then
    -- elseif (key:repr() == "space") and (context:has_menu()) then
      -- local input_3 = context.input
      if ( string.find(input_3, "[@:]") or string.find(input_3, "^'/[';a-z0-9./-]*$") or string.find(input_3, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(input_3, "=[0-9]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][][][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-125890;,./]$") or string.find(input_3, "=[-;,./][-;,./]$") or string.find(input_3, "==[90]$") ) then  --or string.find(input_3, "==[,.]{2}$")
      -- if ( string.find(input_3, "[@:]") or string.find(input_3, "^'/[';a-z0-9./-]*$") or string.find(input_3, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(input_3, "=[0-9]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][][][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-125890;,./]$") or string.find(input_3, "=[-;,./][-;,./]$") or string.find(input_3, "==[90]$") or string.find(input_3, "==[,][,]?$") or string.find(input_3, "==[.][.]?$") ) then
      --「全，非精簡」 if ( string.find(input_3, "[@:]") or string.find(input_3, "^'/[';a-z0-9./-]*$") or string.find(input_3, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(input_3, "=[0-9]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][][][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-125890;,./]$") or string.find(input_3, "=[-][-]$") or string.find(input_3, "=[;][;]$") or string.find(input_3, "=[,][,]$") or string.find(input_3, "=[.][.]$") or string.find(input_3, "=[/][/]$") or string.find(input_3, "==[90]$") or string.find(input_3, "==[,][,]?$") or string.find(input_3, "==[.][.]?$") ) then
        -- local orig_3 = context:get_commit_text()
        engine:commit_text(orig_3)
        context:clear()
        return 1 -- kAccepted
      end
    end
  elseif (not context:get_option("ascii_punct")) and (not context:get_option('ascii_mode')) then
  -- elseif (not c_b_d) and (not en_m) then
    if (key:repr() == "space") and (context:is_composing()) then
    -- if (key:repr() == "space") and (context:has_menu()) then
      -- local input_3 = context.input
      if ( string.find(input_3, "[@:]") or string.find(input_3, "^'/[';a-z0-9./-]*$") or string.find(input_3, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(input_3, "=[0-9]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][][][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-125890;,./]$") or string.find(input_3, "=[-;,./][-;,./]$") or string.find(input_3, "==[90]$") ) then  --or string.find(input_3, "==[,.]{2}$")
      -- if ( string.find(input_3, "[@:]") or string.find(input_3, "^'/[';a-z0-9./-]*$") or string.find(input_3, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(input_3, "=[0-9]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][][][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-125890;,./]$") or string.find(input_3, "=[-;,./][-;,./]$") or string.find(input_3, "==[90]$") or string.find(input_3, "==[,][,]?$") or string.find(input_3, "==[.][.]?$") ) then
      --「全，非精簡」 if ( string.find(input_3, "[@:]") or string.find(input_3, "^'/[';a-z0-9./-]*$") or string.find(input_3, "[-,./;a-z125890][]['3467%s]'/[';a-z0-9./-]*$") or string.find(input_3, "=[0-9]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[][][][]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-,.;'=`][-,.;'=`]'/[';a-z0-9./-]*$") or string.find(input_3, "=[-125890;,./]$") or string.find(input_3, "=[-][-]$") or string.find(input_3, "=[;][;]$") or string.find(input_3, "=[,][,]$") or string.find(input_3, "=[.][.]$") or string.find(input_3, "=[/][/]$") or string.find(input_3, "==[90]$") or string.find(input_3, "==[,][,]?$") or string.find(input_3, "==[.][.]?$") ) then
        -- local orig_3 = context:get_commit_text()
        engine:commit_text(orig_3)
        context:clear()
        return 1 -- kAccepted
      end
    end
  end
  return 2 -- kNoop
end

return mix_apc_s2rm_3