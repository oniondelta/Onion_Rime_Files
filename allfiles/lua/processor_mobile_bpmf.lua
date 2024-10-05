--- @@ mobile_bpmf
--[[
（手機注音用）
使 email_url_translator 功能按空白都能直接上屏
--]]

-- local function mobile_bpmf(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local comp = context.composition
  local seg = comp:back()
  local g_c_t = context:get_commit_text()
  local o_ascii_mode = context:get_option("ascii_mode")
  -- local check_i1 = string.match(c_input, "^[a-z][-_.0-9a-z]*@.*$")
  -- local check_i2 = string.match(c_input, "^https?:.*$")
  -- local check_i3 = string.match(c_input, "^ftp:.*$")
  -- local check_i4 = string.match(c_input, "^mailto:.*$")
  -- local check_i5 = string.match(c_input, "^file:.*$")
  -- local check_i = string.match(c_input, "^[a-z][-_.0-9a-z]*@.*$") or
  --                 string.match(c_input, "^https?:.*$") or
  --                 string.match(c_input, "^ftp:.*$") or
  --                 string.match(c_input, "^mailto:.*$") or
  --                 string.match(c_input, "^file:.*$")

  -- if context:get_option("ascii_mode") then
  if o_ascii_mode then
    return 2
  elseif not context:is_composing() then
    return 2
  elseif key:repr() == "space" then
  -- if key:repr() == "space" and context:is_composing() then
    if seg:has_tag("email_url_translator") then
    -- if check_i then
    -- if check_i1 or check_i2 or check_i3 or check_i4 or check_i5 then
    -- if ( string.match(c_input, "[@:]")) then
      engine:commit_text(g_c_t)
      context:clear()
      return 1 -- kAccepted
    end
  end

  return 2 -- kNoop
end

-- return mobile_bpmf
-- return { mobile_bpmf = mobile_bpmf }
return { func = processor }
-- return { init = init, func = selector }
