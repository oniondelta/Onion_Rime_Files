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

    if (string.match(input_array, "^[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.match(input_array, "^==[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.match(input_array, "`.+$")) or (string.match(input_array, "^[a-z][-_.0-9a-z]*@.*$")) or (string.match(input_array, "^https?:.*$")) or (string.match(input_array, "^ftp:.*$")) or (string.match(input_array, "^mailto:.*$")) or (string.match(input_array, "^file:.*$")) or (string.match(input_array, "^=[a-z0-9,.;/-]+$")) then
    -- if (string.match(input_array, "^[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.match(input_array, "^==[a-z.,/;][a-z.,/;][a-z.,/;][a-z.,/;]?i?$")) or (string.match(input_array, "`.+$")) or (string.match(input_array, "^[a-z][-_.0-9a-z]*@.*$")) or (string.match(input_array, "^https?:.*$")) or (string.match(input_array, "^ftp:.*$")) or (string.match(input_array, "^mailto:.*$")) or (string.match(input_array, "^file:.*$")) or (string.match(input_array, "^www%..+$")) or (string.match(input_array, "^=[a-z0-9,.;/-]+$")) then
      -- local orig_array = context:get_commit_text()
      engine:commit_text(orig_array)
      context:clear()
      return 1 -- kAccepted

    -- --- 使 w[0-9] 輸入符號時：空白鍵同某些行列 30 一樣為翻頁。
    -- --- KeyEvent 函數在舊版 librime-lua 中不支持，故遮屏。
    -- elseif (string.match(input_array, "^w[0-9]$")) then
    --   engine:process_key(KeyEvent("Page_Down"))
    --   return 1 -- kAccepted

    end
  elseif (key:repr() == "Return") and (context:has_menu()) then
  -- elseif (key:repr() == "Return") then
  -- elseif (key:repr() == "Return") and (context:is_composing()) then
    -- local input_array = context.input

    if (string.match(input_array, "^=[a-z0-9,.;/-]+$")) then
      -- local orig_array = context:get_commit_text()
      engine:commit_text(orig_array)
      context:clear()
      return 1 -- kAccepted

    -- --- 使 w[0-9] 輸入符號時：
    -- --- 搭配前面「空白鍵同某些行列 30 一樣為翻頁」，並且用 custom 檔設「return 上屏候選字」，校正 Return 能上屏候選項！
    -- --- KeyEvent 函數在舊版 librime-lua 中不支持，故遮屏。
    -- elseif (string.match(input_array, "^w[0-9]$")) then
    --   engine:commit_text(orig_array)
    --   context:clear()
    --   return 1 -- kAccepted

    end
  end
  return 2
end

return array30up_mix