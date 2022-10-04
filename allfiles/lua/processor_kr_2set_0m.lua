--- @@ kr_2set_0m
--[[
（hangeul2set_zeromenu）
韓語 2set 零選項方案專用，使選單變為零。
--]]


local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"}  --> {a=true,b=true...}
local set_number = Set {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}


local function kr_2set_0m(key,env)
  local engine = env.engine
  local context = engine.context
  local hangul = context:get_commit_text()
  -- local caret_pos = context.caret_pos

  --- pass ascii_mode
  if context:get_option('ascii_mode') then
    return 2

  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2

  --- pass reverse_lookup prefix （使反查鍵可展示全部選項）
  elseif string.find(context.input, '=[a-z]?[a-z]?[a-z]?[a-z]?[a-z]?$') then
    return 2

  --- 修正「Shift+Return」commit_raw_input 設定失效問題
  elseif key:eq(KeyEvent("Shift+Return")) and (context:is_composing()) then
    engine:commit_text(context.input)
    context:clear()
    return 1

  --- 修正組字時，按「向下」鍵輸入消失問題
  elseif key:eq(KeyEvent("Down")) and (context:is_composing()) and (not context:has_menu()) and string.find(context.input, '[^0-9]$') then
    context:reopen_previous_segment()
    -- context:confirm_current_selection()
    -- key:repr('Release+Right')
    -- engine:process_key("Right")  #輸入法會崩潰
    return 1

  --- 《最主要部分》使 [a-zQWERTOP] 組字且半上屏
  -- local asciikeys = string.char(key.keycode)
  elseif set_char[string.char(key.keycode)] then
    context:reopen_previous_segment()
    context.input = context.input .. string.char(key.keycode)
    context:confirm_current_selection()
    return 1

  --- 修正尾綴「;」出漢字，使其可展示選單
  elseif key:repr() == 'semicolon' then
    context:reopen_previous_segment()
    context.input = context.input .. ';'
    return 1

  --- 修正開頭輸入「數字」，不能直接上屏問題
  elseif set_number[key:repr()] and (not context:is_composing()) then
    engine:commit_text(key:repr())
    -- context:clear()
    return 1

  --- 修正輸入途中插入「數字」，無法半上屏，需按2次 enter 之問題
  elseif set_number[key:repr()] and (context:is_composing()) and (not context:has_menu()) then
    context.input = context.input .. key:repr()
    context:confirm_current_selection()
    return 1

  --- 增加一般韓文輸入法操作，空格上屏自動末端空一格。
  elseif context:get_option('space_mode') and key:repr() == 'space' then
    if (context:is_composing()) and (not context:has_menu()) and string.find(context.input, '^[a-zQWERTOP]+$') then  --只有韓文，不含漢字。如果漢字如此出字會不能記憶。
    -- if key:repr() == 'space' and (context:is_composing()) and (not context:has_menu()) then
    -- if key:repr() == 'space' and (context:is_composing()) and (not context:has_menu()) and (not string.find(hangul, "[%a%c%s]")) and (caret_pos == context.input:len()) then
      engine:commit_text(hangul .. " ")
      context:clear()
      return 1
    end

  end

  return 2
end


return kr_2set_0m