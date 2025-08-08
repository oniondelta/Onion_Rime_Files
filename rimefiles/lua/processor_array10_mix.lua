--- @@ processor_array10_mix
--[[
（onion-array10）
array10 數字和英文相互轉換。
「BackSpace」和「Escape」於 array10 狀態，不用按多次，可一次就刪除。
注音反查 Return 和 space 和 小鍵盤數字鍵 上屏修正
尚有bug待處理
--]]


-- local function status(ctx)
--     local stat = metatable()
--     local comp = ctx.composition
--     stat.always = true
--     stat.composing = ctx:is_composing()
--     stat.empty = not stat.composing
--     stat.has_menu = ctx:has_menu()
--     stat.paging = not comp:empty() and comp:back():has_tag("paging")
--     return stat
-- end


----------------------------------------------------------------------------------------
-- local utf8_sub = require("f_components/f_utf8_sub")
local array10_conversion = require("p_components/p_array10_conversion")
local array10_to_num = array10_conversion.to_num
local array10_to_abc = array10_conversion.to_abc
----------------------------------------------------------------------------------------

-- local function init(env)
--   local engine = env.engine
--   local schema = engine.schema
--   local config = schema.config
--   -- env.kp_change_pattern = {
--   --   ["0"] = "Z",
--   --   ["1"] = "X",
--   --   ["2"] = "C",
--   --   ["3"] = "V",
--   --   ["4"] = "S",
--   --   ["5"] = "D",
--   --   ["6"] = "F",
--   --   ["7"] = "W",
--   --   ["8"] = "E",
--   --   ["9"] = "R",
--   --   ["Add"] = "A",
--   --   -- ["Add"] = "+",
--   --   -- ["Subtract"] = "-",
--   --   -- ["Multiply"] = "*",
--   --   -- ["Divide"] = "/",
--   --   -- ["Decimal"] = ".",
--   --  }
-- end

-- local set_char_bpmf = Set {"ㄅ", "ㄆ", "ㄇ", "ㄈ", "ㄉ", "ㄊ", "ㄋ", "ㄌ", "ㄍ", "ㄎ", "ㄏ", "ㄐ", "ㄑ", "ㄒ", "ㄓ", "ㄔ", "ㄕ", "ㄖ", "ㄗ", "ㄘ", "ㄙ", "ㄧ", "ㄨ", "ㄩ", "ㄚ", "ㄛ", "ㄜ", "ㄝ", "ㄞ", "ㄟ", "ㄠ", "ㄡ", "ㄢ", "ㄣ", "ㄤ", "ㄥ", "ㄦ", "ˉ", "ˊ", "ˇ", "ˋ", "˙", "ㄪ", "ㄫ", "ㄫ", "ㄬ", "ㄭ", "ㄮ", "ㄮ", "ㄯ", "ㄯ", "ㆠ", "ㆡ", "ㆢ", "ㆣ", "ㆤ", "ㆥ", "ㆦ", "ㆧ", "ㆨ", "ㆩ", "ㆪ", "ㆫ", "ㆬ", "ㆭ", "ㆭ", "ㆮ", "ㆯ", "ㆰ", "ㆰ", "ㆱ", "ㆱ", "ㆲ", "ㆲ", "ㆳ", "ㆴ", "ㆵ", "ㆶ", "ㆷ", "ㆸ", "ㆹ", "ㆺ"}

-- local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}

-- --- return char(0x20~0x7f) or ""
-- local function ascii_c(key,pat)
--   local pat = pat and ('^[%s]$'):format(pat) or "^.$"
--   local code = key.keycode
--   return key.modifier <=1 and
--          code >=0x20 and code <=0x7f and
--          string.char(code):match(pat) or ""
-- end

-- local function processor_array10_mix(key,env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  -- local g_s_t = context:get_script_text()
  local g_c_t = context:get_commit_text()
  -- local page_size = engine.schema.page_size
  local o_ascii_mode = context:get_option("ascii_mode")
  local o_switch_key_board = context:get_option("switch_key_board")
  local key_abc = key:repr():match("^([zxcvsdfweratgb])$")
  local key_num = key:repr():match("KP_([0-9])") or key:repr():match("Control%+([0-9])")
  -- local key_num_array10 = key:repr():match("KP_([0-9])") or key:repr():match("KP_(Decimal)")
  local shadow_top_b = string.match(c_input, "```[zxcvsdfwera]$")
  local shadow_top_e = string.match(c_input, "(```[zxcvsdfwera]+)$")
  local abc_words = string.match(c_input, "([zxcvsdfwera]+)$")
  local num_words = string.match(c_input, "([0-9.]+)$")
  local lookup_end = string.match(c_input, "[']$")

  -- local s = status(context)
  --- 不要使用以下作為選擇項和未選擇項計算，太困難了，因 preedit 除注音字節，還包含不確定的分節空白。
  -- local start = context:get_preedit().sel_start
  -- local _end = context:get_preedit().sel_end
  -- local es = _end - start
  -- local caret_pos = context.caret_pos

-----------------------------------------------------------------------------

  if o_ascii_mode then
    return 2

---------------------------------------------------------------------------
--[[
以下針對「switch_key」轉換
《第一部分：起始處》
--]]

  elseif o_switch_key_board and comp:empty() and key_abc then
    engine:commit_text(key_abc)
    -- context:clear()
    return 1

---------------------------------------------------------------------------

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  --- pass release alt super (not pass ctrl)
  elseif key:release() or key:alt() or key:super() then
    return 2

---------------------------------------------------------------------------
--[[
以下針對小鍵盤輸入（非起始，不能生效！）
--]]

  -- elseif key_num_array10 and not seg:has_tag("reverse2_lookup") then
  --   engine:commit_text("GGG")
  --   context:clear()
  --   return 1
  --   if key_num_array10 == "Decimal" then
  --     context:push_input( "V" )
  --     -- context.input
  --   else
  --     local num2key = env.kp_change_pattern[key_num_array10] or ""
  --     context:push_input( num2key )
  --     -- context:push_input( "A" )
  --     return 1
  --   end

---------------------------------------------------------------------------
--[[
以下針對 seg:has_tag("shadow_top") 時，刪除最後「```[zxcvsdfwera]」之修正
--]]

  elseif key:repr() == "BackSpace" and seg:has_tag("shadow_top") and shadow_top_b then
    -- engine:process_key(KeyEvent("Escape"))
    -- engine:process_key(KeyEvent("Escape"))
    context:pop_input(4)  -- 回刪（刪到「0」時會有狀況？！）
    -- context:clear()  -- 前面有接其他「seg」，會全部消失
    return 1
  elseif key:repr() == "Escape" and seg:has_tag("shadow_top") and shadow_top_e then
    -- engine:process_key(KeyEvent("Escape"))
    -- engine:process_key(KeyEvent("Escape"))
    n = #shadow_top_e
    context:pop_input(n)  -- 回刪（刪到「0」時會有狀況？！）
    -- context:clear()  -- 前面有接其他「seg」，會全部消失
    return 1

---------------------------------------------------------------------------
--[[
以下針對「switch_key」轉換
《第二部分：前有「seg」輸入》

「seg」不為： seg:has_tag("reverse2_lookup") or seg:has_tag("reverse3_lookup")
--]]

  elseif o_switch_key_board and lookup_end and key_abc then
    context:commit()
    engine:commit_text(key_abc)
    return 1

---------------------------------------------------------------------------
--[[
以下針對功能：「轉換對映數字」！
--]]

  elseif key:repr() == "q" and abc_words and (seg:has_tag("shadow_top") or seg:has_tag("abc") or seg:has_tag("reverse3_lookup")) then
    local atn = array10_to_num(abc_words) or ""
    local n = #atn
    context:pop_input(n)
    context:push_input(atn)
    -- engine:commit_text("測試")
    -- context:clear()
    return 1

  elseif key:repr() == "q" and num_words and not seg:has_tag("reverse2_lookup") and not context:has_menu() then  -- and context:is_composing()
    local ata = array10_to_abc(num_words) or ""
    local n = #ata
    context:pop_input(n)
    context:push_input(ata)
    -- engine:commit_text("測試")
    -- context:clear()
    return 1

---------------------------------------------------------------------------
--[[
以下針對反查注音和注音文 Bug 作修正
--]]

  elseif not seg:has_tag("reverse2_lookup") then  -- and not seg:has_tag("abc")
    return 2

  elseif not context:has_menu() then
  -- elseif not context:is_composing() then  --無法空碼清屏
    return 2

  --- pass not space Return KP_Enter key_num
  elseif key:repr() ~= "space" and key:repr() ~= "Return" and key:repr() ~= "KP_Enter" and not key_num then
    return 2

-----------------------

  --- 以下修正：附加方案鍵盤範圍大於主方案時，小板數字鍵選擇出現之 bug。
  elseif key_num then
    --- 確定選項編號
    -- 以下針對選字編碼為：1234567890
    local page_n = 10 * (seg.selected_index // 10)    -- 先確定在第幾頁
    local key_num2 = tonumber(key_num)
    if key_num2 > 0 then
      key_num2 = key_num2 - 1 + page_n
    elseif key_num2 == 0 then
      key_num2 = key_num2 - 1 + page_n + 10
    end

    --- 上屏選擇選項。
    -- local cand = context:get_selected_candidate()  -- 只是當前位置
    local cand = seg:get_candidate_at(key_num2)
    -- local up_number = #g_c_t + cand._end - caret_pos
    -- local f_cand = string.sub(g_c_t, 1, up_number)
    -- engine:commit_text(f_cand)  -- 數字鍵選字時會消失
    engine:commit_text(cand.text)  -- 一般abc輸入後接掛接，一般輸入會消失

    --- 刪除已上屏字詞的前頭字元
    local retain_number = #c_input - cand._end  -- 刪除中文編碼後，計算字數。
    local ci_cut = string.sub(c_input, -retain_number)

    --- 補前綴，導入未上屏編碼，避免跳回主方案
    if retain_number == 0 then
      context:clear()
    elseif seg:has_tag("reverse2_lookup") then
      context.input = "`" .. ci_cut
    end

    -- --- 判別掛載方案，依不同方案分別處理：
    -- --- 刪除已上屏字詞的前頭字元。
    -- if seg:has_tag("reverse2_lookup") then

    --   -- local cand_len = utf8.len(cand.text)
    --   -- local ci_cut = string.gsub(c_input, "^';", "")
    --   -- -- 上屏詞彙為單個注音
    --   -- if set_char_bpmf[cand.text] then
    --   --   ci_cut = string.gsub(ci_cut, "^[.,;/ %w-]", "")
    --   -- -- 上屏詞彙為兩個注音
    --   -- elseif (cand_len == 2) and set_char_bpmf[utf8_sub(cand.text, 1, 1)] and set_char_bpmf[utf8_sub(cand.text, 2, 2)] then
    --   --   ci_cut = string.gsub(ci_cut, "^[.,;/ %w-][.,;/ %w-]", "")
    --   -- -- 上屏詞彙為三個注音
    --   -- elseif (cand_len == 3) and set_char_bpmf[utf8_sub(cand.text, 1, 1)] and set_char_bpmf[utf8_sub(cand.text, 2, 2)] and set_char_bpmf[utf8_sub(cand.text, 3, 3)] then
    --   --   ci_cut = string.gsub(ci_cut, "^[.,;/ %w-][.,;/ %w-][.,;/ %w-]", "")
    --   -- -- 上屏詞彙為全中文不含注音，但有狀況會缺漏出現 bug
    --   -- else
    --   --   for i = 1, cand_len do
    --   --     ci_cut = string.gsub(ci_cut, "^[.,;/a-z125890-][.,;/a-z125890-]?[.,;/a-z125890-]?[ 3467]", "")
    --   --   end
    --   -- end

    --   --- 補前綴 "';"，導入未上屏編碼，避免跳回主方案
    --   -- if #ci_cut == 0 then
    --   if retain_number == 0 then
    --     context:clear()
    --   else
    --     context.input = "';" .. ci_cut
    --   end

    -- elseif seg:has_tag("all_bpm") then
    --   -- local cand_len = utf8.len(cand.text)
    --   -- local ci_cut = string.gsub(c_input, "^';'", "")
    --   -- for i = 1, cand_len do
    --   --   ci_cut = string.gsub(ci_cut, "^[.,;/ %w-]", "")
    --   -- end

    --   --- 補前綴 "';'"，導入未上屏編碼，避免跳回主方案
    --   -- if #ci_cut == 0 then
    --   if retain_number == 0 then
    --     context:clear()
    --   else
    --     context.input = "';'" .. ci_cut
    --   end
    -- end

    return 1

-----------------------

  --- 以下修正：附加方案鍵盤範圍大於主方案時，選字時出現的 bug。
  -- elseif key:repr() == "space" or key:repr() == "Return" or key:repr() == "KP_Enter" then
  -- elseif not key_num then
  else

    --- paging 時和游標不在尾端時，需分割上屏之處理
    if seg:has_tag("paging") or #c_input ~= caret_pos then
      --- 先上屏 paging 時選擇的選項
      -- local selected_candidate_index = seg.selected_index
      -- context:select(selected_candidate_index)

      --- 中途插入空白（一聲）不會直上屏
      local f_c_input = string.sub(c_input, 1, caret_pos)
      if key:repr() == "space" and #c_input ~= caret_pos and not seg:has_tag("paging") and not string.match(f_c_input, "[ 3467]$") then
        local b_c_input = string.sub(c_input, caret_pos - #c_input)
        context.input = f_c_input .. " " .. b_c_input

      else
        --- 上屏選擇選項。
        local cand = context:get_selected_candidate()
        local up_number = #g_c_t + cand._end - caret_pos
        local f_cand = string.sub(g_c_t, 1, up_number)
        engine:commit_text(f_cand)
        -- engine:commit_text(cand.text)  -- 一般abc輸入後接掛接，一般輸入會消失
        -- engine:commit_text(cand.text..start.." ".._end.." "..#c_input.." "..caret_pos )  --測試各個位置數值用

        --- 計算末尾殘留的非中文字元數（未被選擇的 cand.input 字元數）
        local retain_number = #c_input - cand._end  -- 刪除中文編碼後，計算字數。
        local new_c_input = string.sub(c_input, -retain_number)
        -- local retain_number = #string.gsub(g_c_t, "[^.,;/ %w-]", "")  -- 刪除中文編碼後，計算字數。
        -- context:confirm_current_selection()
        -- context:refresh_non_confirmed_composition()

        --- 補前綴 "';" 或 "';'"，導入未上屏編碼，避免跳回主方案
        if retain_number == 0 then
          context:clear()
        elseif seg:has_tag("reverse2_lookup") then
          context.input = "`" .. new_c_input
        end
      end
      return 1


    --- 某些方案輸入 Return 出英文，該條限定注音 Return 一律直上中文。
    elseif key:repr() == "Return" or key:repr() == "KP_Enter" then
      context:commit()  -- 可記憶
      -- context:confirm_current_selection()  -- 可記憶
      -- engine:process_key( KeyEvent("Return") )  -- 可能會報錯
      -- engine:commit_text(g_c_t)  -- 不會記憶
      -- context:clear()
      return 1
      -- return 2

    --- 如果末尾為聲調則跳掉，按空白鍵，則 Rime 上屏，非 lua 作用。
    elseif string.match(c_input, "[ 3467]$") then
      return 2

    --- 補掛接反查注音不能使用空白當作一聲
    elseif key:repr() == "space" then
    -- elseif key:repr() == "space" then
    -- elseif key:repr() == "space" and context:has_menu() then
      -- engine:commit_text(c_input .. "_")
      -- context.input = c_input .. " "
      context:push_input( " " )
      -- context:clear()
      return 1

    end

---------------------------------------------------------------------------

  end

  return 2
end


-- return processor_array10_mix
return { func = processor }
-- return { init = init, func = processor }