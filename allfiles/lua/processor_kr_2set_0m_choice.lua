--- @@ kr_2set_0m_choice
--[[
（hangeul2set_zeromenu）
韓語 2set 零選項方案專用，使選單變為零。
增加是否折疊選單之開關選項。
開關（space_mode）：輸出末位空白
開關（kr_0m）：是否折疊選單
--]]


local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "Q", "W", "E", "R", "T", "O", "P"}  --> {a=true,b=true...}
-- local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}  --> {a=true,b=true...}
-- local set_number = Set {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}

--- return char(0x20~0x7f) or ""
local function ascii_c(key,pat)
  local pat = pat and ('^[%s]$'):format(pat) or "^.$"
  local code = key.keycode
  return key.modifier <=1 and
         code >=0x20 and code <=0x7f and
         string.char(code):match(pat) or ""
end

local function is_koreapart(c)
  return 4352 <= c and c <= 4607    -- Hangul Jamo
     or 12592 <= c and c <= 12687   -- Hangul Compatibility Jamo
     or 43360 <= c and c <= 43391   -- Hangul Jamo Extended-A
     or 44032 <= c and c <= 55295   -- 合併以下兩個
     -- or 44032 <= c and c <= 55215   -- Hangul Syllables
     -- or 55216 <= c and c <= 55295   -- Hangul Jamo Extended-B
     or 65441 <= c and c <= 65500   -- Halfwidth Jamo
end

local function check_korea(text)
  -- for _, c in utf8.codes(text) do
  for i in utf8.codes(text) do
    local c = utf8.codepoint(text, i)
    if not is_koreapart(c) then
      return false
    end
  end
  return true
end




-- local function kr_2set_0m_choice(key,env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  local g_c_t = context:get_commit_text()
  local o_ascii_mode = context:get_option("ascii_mode")
  local o_kr_0m = context:get_option("kr_0m")
  local o_space_mode = context:get_option("space_mode")

  -- local hangul_b = string.sub(g_c_t,-6,-4)  -- 確認倒數第二字是否為諺文用


  --- pass ascii_mode
  if o_ascii_mode then
  -- if context:get_option('ascii_mode') then
    return 2


  -- --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  -- elseif comp:empty() then
  --   return 2


  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2


  --- 修正「Shift+Return」commit_raw_input 設定失效問題
  elseif key:repr() == "Shift+Return" and context:is_composing() then
  -- elseif key:eq(KeyEvent("Shift+Return")) and (context:is_composing()) then  -- KeyEvent 在官版小狼毫中會有問題
    engine:commit_text(c_input)
    context:clear()
    return 1

  --- pass reverse_lookup prefix （使反查鍵可展示全部選項）(沒開，即使 commit_composition 上屏，還是無法顯示選單)
  elseif context:is_composing() and seg:has_tag("reverse_lookup")then
  -- elseif not comp:empty() and seg:has_tag("reverse_lookup")then
  -- elseif string.match(c_input, "=[a-z]?[a-z]?[a-z]?[a-z]?[a-z]?$") then
    return 2


  -- --- 修正開頭輸入「數字」，不能直接上屏問題（ schema 內可設定，故關閉）
  -- elseif set_number[key:repr()] and (not context:is_composing()) then
  -- -- elseif set_number[ascii_c(key, "0-9")] and (not context:is_composing()) then
  --   engine:commit_text(key:repr())
  --   -- context:clear()
  --   return 1


  --- 避免中途插入碼變到最後
  elseif caret_pos ~= #c_input then
  -- elseif (caret_pos ~= c_input:len()) then
    return 2


  elseif o_kr_0m then  -- 提到前面限定 and (caret_pos == c_input:len())
  -- elseif context:get_option("kr_0m") then
    -- local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "Q", "W", "E", "R", "T", "O", "P"}  --> {a=true,b=true...}

    --------------------------------------------
    --- 《最主要部分》使 [a-zQWERTOP] 組字且半上屏
    --- 函數格式 ascii_c(key, "a-zQWERTOP")，function ascii_c(key,pat) 該函數需打開
    if set_char[ascii_c(key, "a-zQWERTOP")] then
      --- 避開頭，和使一般諺文減少漢字亂跳（還是會）
      if string.match(c_input, "^$") or string.match(c_input, ";$") then
        -- context:select(0)  --打開，漢字會一個一個分開，不連動變換
        -- context.input = c_input .. ascii_c(key, "a-zQWERTOP")
        context:push_input( ascii_c(key, "a-zQWERTOP") )
        context:confirm_current_selection()
        return 1
      --- 以下為原本，上方補充漢字「;」接後續輸入，前面選字亂跑問題
      else
        context:reopen_previous_segment()
        -- context.input = c_input .. ascii_c(key, "a-zQWERTOP")
        context:push_input( ascii_c(key, "a-zQWERTOP") )
        -- context:confirm_current_selection()
        context:select(0)  -- 也可以使用
        return 1
      end


    --------------------------------------------
    -- ---- 功能正常，但輸入時，錯誤日誌會報錯 char 超出範圍

    -- --- 《最主要部分》使 [a-zQWERTOP] 組字且半上屏
    -- -- local asciikeys = string.char(key.keycode)  -- char 沒限定範圍會報錯
    -- if set_char[string.char(key.keycode)] then  -- char 沒限定範圍會報錯
    --   context:reopen_previous_segment()
    --   context.input = c_input .. string.char(key.keycode)  -- char 沒限定範圍會報錯
    --   context:confirm_current_selection()
    --   return 1

    --------------------------------------------
    -- ---- 最初方法，function check_qwertop() 該函數需打開

    -- local function check_qwertop()
    --   if key:eq(KeyEvent("Shift+Q")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+W")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+E")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+R")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+T")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+O")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+P")) then
    --     return true
    --   else
    --     return false
    --   end
    -- end

    -- ---- 與上例函數一樣，只是用向下相容寫法
    -- local function check_qwertop()
    --   if key:repr() == "Shift+Q" then
    --     return true
    --   elseif key:repr() == "Shift+W" then
    --     return true
    --   elseif key:repr() == "Shift+E" then
    --     return true
    --   elseif key:repr() == "Shift+R" then
    --     return true
    --   elseif key:repr() == "Shift+T" then
    --     return true
    --   elseif key:repr() == "Shift+O" then
    --     return true
    --   elseif key:repr() == "Shift+P" then
    --     return true
    --   else
    --     return false
    --   end
    -- end

    -- --- 《最主要部分》使 [a-zQWERTOP] 組字且半上屏
    -- if set_char[key:repr()] or check_qwertop() then
    --   local lastword = string.gsub(key:repr(), "Shift%+", "")
    --   -- local lastword = key:repr():match("^[a-z]$") or ""
    --   context:reopen_previous_segment()
    --   context.input = c_input .. lastword
    --   context:confirm_current_selection()
    --   return 1

    --------------------------------------------


    -- --- 漢字選字直接上屏，有 bug，會影響諺文選字。
    -- --- 且詞語不能共同記憶組合出字。
    -- elseif set_number[key:repr()] and (context:has_menu()) then
    -- -- elseif set_number[ascii_c(key, "0-9")] and (context:has_menu()) then
    --   -- local in_number = string.char(key.keycode)
    --   local in_number = ascii_c(key, "0-9") or 1
    --   if in_number == '0' then
    --     in_number = 9
    --   else
    --     in_number = in_number - 1
    --   end
    --   context:select(in_number)
    --   context:commit()
    --   -- context.input:push('space')
    --   -- context.input = c_input .. "\\"
    --   -- context:confirm_previous_selection()
    --   -- context:confirm_current_selection()
    --   -- context:clear()
    --   return 1


    --- 不在輸入狀態或是有選單時略過處理
    elseif not context:is_composing() or context:has_menu() then
      return 2


    --- 修正尾綴「;」出漢字，使其可展示選單
    elseif key:repr() == "semicolon" then
      local hangul_b = string.sub(g_c_t,-6,-4)  -- 確認倒數第二字是否為諺文用
      -- local cxtil = string.len(g_c_t) - caret_pos
      --- 開頭防止漢字不 reopen 去組字。
      if #g_c_t == 3 then  -- 3等同一個諺文單位的字符長度
      -- if (string.len(g_c_t) == 3) then  -- 3等同一個諺文單位的字符長度
      -- if string.match(c_input, "^..$") then
        context:reopen_previous_segment()
        -- context.input = c_input .. ";"
        context:push_input( ";" )
        return 1
      --- 檢視倒數第二個字是否為諺文，如果是讓選單只選漢字，避免還要從諺文開始選。
      elseif check_korea(hangul_b) == true then
        context:reopen_previous_segment()
        engine:process_key( KeyEvent("Shift+Tab") )
        -- context:confirm_current_selection()
        context:select(0)  -- 也可以使用
        -- context.input = c_input .. ";"
        context:push_input( ";" )
        return 1
      --- 防止前面選字後，後面不 reopen 去組字；並且一系列漢字可一同選，非拆開。
      elseif string.match(c_input, ";[a-zQWERTOP]+$") then
      -- elseif (cxtil == 1) then
        context:reopen_previous_segment()
        -- context.input = c_input .. ";"
        context:push_input( ";" )
        -- 測試用 engine:commit_text(caret_pos .. " " .. c_input:len() .. " " .. string.len(g_c_t))
        return 1
      --- 防止前面為一般諺文，後面漢字不組字，並且讓選單只選漢字，避免還要從諺文開始選。
      else
        context:reopen_previous_segment()
        engine:process_key( KeyEvent("Shift+Tab") )
        -- context:confirm_current_selection()
        context:select(0)  -- 也可以使用
        -- context.input = c_input .. ";"
        context:push_input( ";" )
        -- 測試用 engine:commit_text(caret_pos .. " " .. c_input:len() .. " " .. string.len(g_c_t))
        return 1
      end
      -- --- 以下原本設定，由於各種狀況都 reopen，漢字容易亂跳
      -- context:reopen_previous_segment()
      -- context.input = c_input .. ";"
      -- return 1


    --- 使「\\」可分節
    elseif key:repr() == "backslash" then
      context:reopen_previous_segment()
      -- context.input = c_input .. "\\"
      context:push_input( "\\" )
      context:confirm_current_selection()
      return 1


    -- --- 修正組字時，按「向下」鍵輸入消失問題（ schema 內可設定，故關閉）
    -- elseif key:eq(KeyEvent("Down")) and string.match(c_input, "[^0-9]$") then
    --   context:reopen_previous_segment()
    --   -- context:confirm_current_selection()
    --   -- key:repr("Release+Right")  -- 無法作用
    --   -- engine:process_key("Right")  -- 輸入法會崩潰
    --   -- engine:process_key(KeyEvent("Right"))  -- 測試OK!
    --   return 1


    -- --- 修正輸入途中插入「數字」，無法半上屏，需按2次 enter 之問題，改直上屏（ schema 內可設定，故關閉）
    -- elseif set_number[key:repr()] then
    -- -- elseif set_number[ascii_c(key, "0-9")] then
    --   -- context.input = c_input .. key:repr()
    --   -- context:confirm_current_selection()
    --   engine:commit_text(g_c_t .. key:repr())
    --   context:clear()
    --   return 1


    --- 增加一般韓文輸入法操作，空格上屏自動末端空一格。
    elseif o_space_mode and key:repr() == "space" and string.match(c_input, "^[a-zQWERTOP]+$") then  --只有韓文，不含漢字。如果漢字如此出字會不能記憶？
      -- if key:repr() == "space" and (context:is_composing()) and (not context:has_menu()) then
      -- if key:repr() == "space" and (context:is_composing()) and (not context:has_menu()) and (not string.match(g_c_t, "[%a%c%s]")) and (caret_pos == c_input:len()) then
      engine:commit_text(g_c_t .. " ")
      context:clear()
      return 1

    end


  elseif not o_kr_0m then
  -- elseif not context:get_option("kr_0m") then

    --- 不在輸入狀態略過處理
    if not context:has_menu() or not o_space_mode or key:repr() ~= "space" then
    -- if not context:is_composing() or not o_space_mode or key:repr() ~= "space" then
      return 2

    elseif string.match(c_input, "^[a-zQWERTOP]+$") then  -- 提到前面限定 and (caret_pos == c_input:len())
    -- elseif string.match(c_input, "^[a-zQWERTOP]+$") and not string.match(g_c_t, "[%a%c%s]") then  -- 提到前面限定 and (caret_pos == c_input:len())
      engine:commit_text(g_c_t .. " ")
      context:clear()
      return 1

    end

  end


  return 2
end


-- return kr_2set_0m_choice
return { func = processor }