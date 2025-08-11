--- @@ processor_array10_and_bpmf_mix
--[[
（onion-array10-and-bpmf）
array10 數字和英文相互轉換。
「BackSpace」和「Escape」於 array10 狀態，不用按多次，可一次就刪除。
--]]


----------------------------------------------------------------------------------------
local array10_conversion = require("p_components/p_array10_conversion")
local array10_to_num = array10_conversion.to_num
local array10_to_abc = array10_conversion.to_abc
----------------------------------------------------------------------------------------


-- local function init(env)
--   local engine = env.engine
--   local schema = engine.schema
--   local config = schema.config
-- end


-- local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}  --> {a=true,b=true...}

-- --- return char(0x20~0x7f) or ""
-- local function ascii_c(key,pat)
--   local pat = pat and ('^[%s]$'):format(pat) or "^.$"
--   local code = key.keycode
--   return key.modifier <=1 and
--          code >=0x20 and code <=0x7f and
--          string.char(code):match(pat) or ""
-- end


-- local function processor_array10_and_bpmf_mix(key,env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  -- local g_s_t = context:get_script_text()
  -- local g_c_t = context:get_commit_text()
  -- local page_size = engine.schema.page_size
  local o_ascii_mode = context:get_option("ascii_mode")
  --------
  local key_num_array10 = key:repr():match("^KP_([0-9])$") or key:repr():match("^KP_(Decimal)$")
  -- local key_select_keys = key:repr():match("^Shift%+[QAZWSXYHNUJM]$") or key:repr():match("^Control%+([1-6])$")
  -- local key_select_keys = key:repr():match("^Control%+([1-6])$")
  -- local key_bpmf = set_char[ascii_c(key, "a-z")]
  --------
  -- local seg_punct = seg:has_tag("punct")
  local seg_abc = seg:has_tag("abc")
  local seg_shadow_top = seg:has_tag("shadow_top")
  local seg_reverse2_lookup = seg:has_tag("reverse2_lookup")
  local seg_reverse3_lookup = seg:has_tag("reverse3_lookup")
  --------
  local shadow_top_b = string.match(c_input, "```[zxcvsdfwera]$")
  local shadow_top_e = string.match(c_input, "(```[zxcvsdfwera]+)$")
  local shadow_top_abc = string.match(c_input, "```([zxcvsdfwera]+)$")
  local shadow_top_num = string.match(c_input, "```([0-9.]+)$")
  --------

-----------------------------------------------------------------------------

  if o_ascii_mode then
    return 2

---------------------------------------------------------------------------

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  --- pass release alt super (not pass ctrl)
  elseif key:release() or key:alt() or key:super() then
    return 2

---------------------------------------------------------------------------
--[[
以下針對 seg:has_tag("shadow_top") 時，刪除最後「```[zxcvsdfwera]」之修正
--]]

  elseif key:repr() == "BackSpace" and seg_shadow_top and shadow_top_b and #c_input == caret_pos then
    -- engine:process_key(KeyEvent("Escape"))
    -- engine:process_key(KeyEvent("Escape"))
    context:pop_input(4)  -- 回刪（刪到「0」時會有狀況？！）
    -- context:clear()  -- 前面有接其他「seg」，會全部消失
    return 1
  elseif key:repr() == "Escape" and seg_shadow_top and shadow_top_e and #c_input == caret_pos then
    -- engine:process_key(KeyEvent("Escape"))
    -- engine:process_key(KeyEvent("Escape"))
    n = #shadow_top_e
    context:pop_input(n)  -- 回刪（刪到「0」時會有狀況？！）
    -- context:clear()  -- 前面有接其他「seg」，會全部消失
    return 1

---------------------------------------------------------------------------
--[[
以下針對功能：「轉換對映數字」！
--]]

  elseif key:repr() == "q" and shadow_top_abc and (seg_shadow_top or seg_reverse3_lookup) then
    local atn = array10_to_num(shadow_top_abc) or ""
    local n = #atn
    context:pop_input(n)
    context:push_input(atn)
    -- engine:commit_text("測試")
    ------------------------------
    -- local n = 3 + #atn
    -- context:pop_input(n)
    -- context:commit()
    -- engine:commit_text(atn)
    -- context:clear()
    ------------------------------
    return 1

  elseif key:repr() == "q" and shadow_top_num and not seg_abc and not seg_reverse2_lookup and not context:has_menu() then  -- and context:is_composing()
    local ata = array10_to_abc(shadow_top_num) or ""
    local n = #ata
    context:pop_input(n)
    context:push_input(ata)
    -- engine:commit_text("測試")
    -- context:clear()
    return 1

---------------------------------------------------------------------------
--[[
以下針對功能：使英文鍵盤和數字鍵盤兩邊輸入會轉換，不互相影響。
--]]

  -- elseif key_num_array10 and (seg_abc or seg_punct or seg_reverse2_lookup) then
  elseif key_num_array10 and not seg_shadow_top and context:is_composing() then
    context:push_input("```")
    return 2

  -- elseif shadow_top_abc and seg_shadow_top and not key_num_array10 then
  --   context:push_input(" ")
  --   return 2

---------------------------------------------------------------------------
--[[
以下針對《影》掛接上屏 Bug 作修正
--]]

  elseif not seg_shadow_top then  -- and not seg:has_tag("abc")
    return 2

  elseif not context:has_menu() then
  -- elseif not context:is_composing() then  --無法空碼清屏
    return 2

  --- pass not space Return KP_Enter key_select_keys
  elseif key:repr() ~= "space" and key:repr() ~= "Return" and key:repr() ~= "KP_Enter" then  --and not key_select_keys
  -- elseif key:repr() ~= "space" and key:repr() ~= "Return" and key:repr() ~= "KP_Enter" and not key_select_keys then
    return 2

-----------------------
  -- --- 以下測試「key_select_keys」之「key:repr()」用

  -- elseif key_select_keys then
  --   engine:commit_text("key:repr()=" .. key:repr() .. ", " .. key_select_keys)
  --   context:clear()
  --   return 1

-----------------------
  -- --- 以下修正：小板數字鍵選擇出現之 bug。

  -- elseif key_select_keys then
  --   local ksk_n = tonumber(key_select_keys)
  --   local cand = seg:get_candidate_at(ksk_n)
  --   local miss_number = caret_pos - cand._end  -- miss_number 為「光標位置」和「選項碼數」不匹配時之差數。
  --   local retain_number = #c_input - cand._end  -- 刪除中文編碼後，計算字數。
  --   local back_input = string.sub(c_input, cand._end + 1, caret_pos)
  --   local new_c_input = string.sub(c_input, -retain_number)

  --   if retain_number == 0 then
  --     context:select(ksk_n)
  --   elseif miss_number ~= 0 then
  --     context:select(ksk_n)
  --     context:pop_input(miss_number)
  --     context:push_input("```" .. back_input)
  --     context.caret_pos = #c_input + 3
  --   elseif miss_number == 0 and #c_input ~= caret_pos then
  --     context.input = cand.text .. "```" .. new_c_input
  --     context.caret_pos = #c_input + 3
  --   else
  --     context:select(ksk_n)
  --   end
  --   -- engine:commit_text("測試")

  --   return 1

-----------------------

  -- elseif seg:has_tag("paging") or #c_input ~= caret_pos then
  elseif #c_input ~= caret_pos then
    -- local ksk_n = tonumber(key_select_keys)
    -- local cand = seg:get_candidate_at(ksk_n)
    local cand = context:get_selected_candidate()
    local miss_number = caret_pos - cand._end  -- miss_number 為「光標位置」和「選項碼數」不匹配時之差數。
    local back_input = string.sub(c_input, cand._end + 1, caret_pos)

    if miss_number ~= 0 then
      -- context:confirm_current_selection()  -- 開啟會有 bug！「切分」時「space」上屏，有問題。
      context:pop_input(miss_number)
      context:push_input("```" .. back_input)
      context.caret_pos = #c_input + 3
      -- engine:commit_text("測試")
    else
      -- context:confirm_current_selection()  -- 開啟會有 bug！「切分」時「space」上屏，有問題。
      context:push_input("```" .. back_input)
      context.caret_pos = #c_input + 3
      -- engine:commit_text("測試")
    end
    return 1

  elseif key:repr() == "space" and #c_input == caret_pos then
  --   context:commit()  -- 會有 bug！
    context:confirm_current_selection()
    return 1

---------------------------------------------------------------------------

  end

  return 2
end


-- return processor_array10_and_bpmf_mix
return { func = processor }
-- return { init = init, func = processor }


