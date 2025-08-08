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
  local g_c_t = context:get_commit_text()
  -- local page_size = engine.schema.page_size
  local o_ascii_mode = context:get_option("ascii_mode")
  --------
  local key_num_array10 = key:repr():match("KP_([0-9])") or key:repr():match("KP_(Decimal)")
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

  elseif key:repr() == "BackSpace" and seg_shadow_top and shadow_top_b then
    -- engine:process_key(KeyEvent("Escape"))
    -- engine:process_key(KeyEvent("Escape"))
    context:pop_input(4)  -- 回刪（刪到「0」時會有狀況？！）
    -- context:clear()  -- 前面有接其他「seg」，會全部消失
    return 1
  elseif key:repr() == "Escape" and seg_shadow_top and shadow_top_e then
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

  end

  return 2
end


-- return processor_array10_and_bpmf_mix
return { func = processor }
-- return { init = init, func = processor }


