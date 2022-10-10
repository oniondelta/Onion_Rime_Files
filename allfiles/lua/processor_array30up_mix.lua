--- @@ 合併 array30up 和 array30up_zy
--[[
（onion-array30）
行列30三四碼字按空格直接上屏
行列30注音反查 Return 和 space 上屏修正
--]]
local function array30up_mix(key, env)
  local engine = env.engine
  local context = engine.context
  local input_array = context.input
  local orig_array = context:get_commit_text()
  -- if context:get_option("ascii_mode") then
  --   return 2
  -- elseif (not context:has_menu()) then
  --   return 2
  if (key:repr() == "space") and (context:has_menu()) then
  -- if (key:repr() == "space") then
  -- if (key:repr() == "space") and (context:is_composing()) then
    -- local input_array = context.input
    if (string.find(input_array, "^[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.find(input_array, "^==[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.find(input_array, "`.+$")) or (string.find(input_array, "^[a-z][-_.0-9a-z]*@.*$")) or (string.find(input_array, "^https?:.*$")) or (string.find(input_array, "^ftp:.*$")) or (string.find(input_array, "^mailto:.*$")) or (string.find(input_array, "^file:.*$")) or (string.find(input_array, "^=[a-z0-9,.;/-]+$")) then
    -- if (string.find(input_array, "^[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.find(input_array, "^==[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.find(input_array, "`.+$")) or (string.find(input_array, "^[a-z][-_.0-9a-z]*@.*$")) or (string.find(input_array, "^https?:.*$")) or (string.find(input_array, "^ftp:.*$")) or (string.find(input_array, "^mailto:.*$")) or (string.find(input_array, "^file:.*$")) or (string.find(input_array, "^www%..+$")) or (string.find(input_array, "^=[a-z0-9,.;/-]+$")) then
      -- local orig_array = context:get_commit_text()
      engine:commit_text(orig_array)
      context:clear()
      return 1 -- kAccepted
    end
  elseif (key:repr() == "Return") and (context:has_menu()) then
  -- elseif (key:repr() == "Return") then
  -- elseif (key:repr() == "Return") and (context:is_composing()) then
    -- local input_array = context.input
    if (string.find(input_array, "^=[a-z0-9,.;/-]+$")) then
      -- local orig_array = context:get_commit_text()
      engine:commit_text(orig_array)
      context:clear()
      return 1 -- kAccepted
    end
  end
  return 2
end

return array30up_mix