--- @@ 合併 array30up_zy 等
--[[
（onion-array30）
行列30注音反查 Return 和 space 和 小鍵盤數字鍵 上屏修正
尚有bug待處理
合併 lua_tran_kp
新增快捷鍵開啟檔案/程式/網站
--]]

----------------------------------------------------------------------------------------
-- local utf8_sub = require("f_components/f_utf8_sub")
local oscmd = require("p_components/p_oscmd")
local run_open = require("p_components/p_run_open")
-- local generic_open = require("p_components/p_generic_open")
-- local run_pattern = require("p_components/p_run_pattern")
-- local op_pattern = require("p_components/p_op_pattern")
----------------------------------------------------------------------------------------

local function init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local namespace1 = "mf_translator"
  -- local namespace2 = "lua_custom_phrase"
  local path = rime_api.get_user_data_dir()
  env.prefix = config:get_string(namespace1 .. "/prefix") or ""
  -- env.textdict = config:get_string(namespace2 .. "/user_dict") or ""
  -- env.custom_phrase = path .. "/" .. env.textdict .. ".txt" or ""
  env.run_pattern = path .. "/lua/p_components/p_run_pattern.lua" or ""
  -- env.op_pattern = path .. "/lua/p_components/p_op_pattern.lua" or ""
  -- log.info("lua_custom_phrase: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
  env.oscmd = oscmd
  -- env.kp_pattern = {
  --   ["0"] = "0",
  --   ["1"] = "1",
  --   ["2"] = "2",
  --   ["3"] = "3",
  --   ["4"] = "4",
  --   ["5"] = "5",
  --   ["6"] = "6",
  --   ["7"] = "7",
  --   ["8"] = "8",
  --   ["9"] = "9",
  --   ["Add"] = "+",
  --   ["Subtract"] = "-",
  --   ["Multiply"] = "*",
  --   ["Divide"] = "/",
  --   ["Decimal"] = ".",
  --  }
  -- env.set_char_bpmf = Set {"ㄅ", "ㄆ", "ㄇ", "ㄈ", "ㄉ", "ㄊ", "ㄋ", "ㄌ", "ㄍ", "ㄎ", "ㄏ", "ㄐ", "ㄑ", "ㄒ", "ㄓ", "ㄔ", "ㄕ", "ㄖ", "ㄗ", "ㄘ", "ㄙ", "ㄧ", "ㄨ", "ㄩ", "ㄚ", "ㄛ", "ㄜ", "ㄝ", "ㄞ", "ㄟ", "ㄠ", "ㄡ", "ㄢ", "ㄣ", "ㄤ", "ㄥ", "ㄦ", "ˉ", "ˊ", "ˇ", "ˋ", "˙", "ㄪ", "ㄫ", "ㄫ", "ㄬ", "ㄭ", "ㄮ", "ㄮ", "ㄯ", "ㄯ", "ㆠ", "ㆡ", "ㆢ", "ㆣ", "ㆤ", "ㆥ", "ㆦ", "ㆧ", "ㆨ", "ㆩ", "ㆪ", "ㆫ", "ㆬ", "ㆭ", "ㆭ", "ㆮ", "ㆯ", "ㆰ", "ㆰ", "ㆱ", "ㆱ", "ㆲ", "ㆲ", "ㆳ", "ㆴ", "ㆵ", "ㆶ", "ㆷ", "ㆸ", "ㆹ", "ㆺ"}
  env.n = 0  -- wsymbols計數用
end

local kp_pattern = {
  ["0"] = "0",
  ["1"] = "1",
  ["2"] = "2",
  ["3"] = "3",
  ["4"] = "4",
  ["5"] = "5",
  ["6"] = "6",
  ["7"] = "7",
  ["8"] = "8",
  ["9"] = "9",
  ["Add"] = "+",
  ["Subtract"] = "-",
  ["Multiply"] = "*",
  ["Divide"] = "/",
  ["Decimal"] = ".",
 }

local k4_pattern = {
  ["comma"] = ",",
  ["period"] = ".",
  ["slash"] = "/",
  ["semicolon"] = ";",
 }

-- local set_char_bpmf = Set {"ㄅ", "ㄆ", "ㄇ", "ㄈ", "ㄉ", "ㄊ", "ㄋ", "ㄌ", "ㄍ", "ㄎ", "ㄏ", "ㄐ", "ㄑ", "ㄒ", "ㄓ", "ㄔ", "ㄕ", "ㄖ", "ㄗ", "ㄘ", "ㄙ", "ㄧ", "ㄨ", "ㄩ", "ㄚ", "ㄛ", "ㄜ", "ㄝ", "ㄞ", "ㄟ", "ㄠ", "ㄡ", "ㄢ", "ㄣ", "ㄤ", "ㄥ", "ㄦ", "ˉ", "ˊ", "ˇ", "ˋ", "˙", "ㄪ", "ㄫ", "ㄫ", "ㄬ", "ㄭ", "ㄮ", "ㄮ", "ㄯ", "ㄯ", "ㆠ", "ㆡ", "ㆢ", "ㆣ", "ㆤ", "ㆥ", "ㆦ", "ㆧ", "ㆨ", "ㆩ", "ㆪ", "ㆫ", "ㆬ", "ㆭ", "ㆭ", "ㆮ", "ㆯ", "ㆰ", "ㆰ", "ㆱ", "ㆱ", "ㆲ", "ㆲ", "ㆳ", "ㆴ", "ㆵ", "ㆶ", "ㆷ", "ㆸ", "ㆹ", "ㆺ"}

-- local function array30new_mix(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  local loaded_candidate_count = seg.menu:candidate_count()    -- 獲得（已加載）候選詞數量
  -- local page_size = engine.schema.page_size    -- 每頁最大候選詞數
  -- local g_s_t = context:get_script_text()
  local g_c_t = context:get_commit_text()
  local o_ascii_mode = context:get_option("ascii_mode")
  -- local s_up = context:get_option("1_2_straight_up")
  local a_s_wp = context:get_option("array30_space_wp")
  -- local a_r_abc = context:get_option("array30_return_abc")
  local key_repr = key:repr()
  -- local key_select_keys = key_repr:match("^KP_([0-9])$") or key_repr:match("^Control%+([0-9])$")
  local key_abc = key_repr:match("^([%l])$") or k4_pattern[key_repr]

  -- local check_i_end = string.match(c_input, "^[a-z,./;][a-z,./;]?[ ']$") or string.match(c_input, "^w%d$")
  -- local check_i_end = string.match(c_input, "[a-z,./;][ ']$") or string.match(c_input, "w%d$")
  local check_i_end = string.match(c_input, "[ '%d]$")
  local check_i_reverse_space = string.match(c_input, "^==[a-z,./;][a-z,./;]?$")
  -- local check_i_phrases_space = string.match(c_input, "^[a-z,./;][a-z,./;]$")  -- mf_translator 在前，不影響到。（「詞句」加空格目前設不作用，故該條目關閉）
  -- local check_i_3_or_more = string.match(c_input, "[a-z,./;][a-z,./;][a-z,./;][a-z,./;]?i?$")  -- mf_translator 在前，不影響到。
  -- local check_i1 = string.match(c_input, "^[a-z,./;][a-z,./;][a-z,./;][a-z,./;]?i?$")  -- 因 check_i_3_or_more 已涵蓋，故遮屏。
  -- local check_i2 = string.match(c_input, "^==[a-z,./;][a-z,./;][a-z,./;][a-z,./;]?i?$")  -- 因 check_i_3_or_more 已涵蓋，故遮屏。

  -- local check_i3 = string.match(c_input, "`.+$")
  -- local check_i4 = string.match(c_input, "^[a-z][-_.0-9a-z]*@.*$")
  -- local check_i5 = string.match(c_input, "^https?:.*$")
  -- local check_i6 = string.match(c_input, "^ftp:.*$")
  -- local check_i7 = string.match(c_input, "^mailto:.*$")
  -- local check_i8 = string.match(c_input, "^file:.*$")
  -- local check_i4 = string.match(c_input, "^[a-z][-_.0-9a-z]*@.*$") or
  --                  string.match(c_input, "^https?:.*$") or
  --                  string.match(c_input, "^ftp:.*$") or
  --                  string.match(c_input, "^mailto:.*$") or
  --                  string.match(c_input, "^file:.*$")

  -- local check_zh = string.match(c_input, "^=[a-z0-9,.;/-]+$")
  -- local check_w = string.match(c_input, "^w[0-9]$")
  -- local check_abc = string.match(c_input, "^[a-z,./;]+$")

  local check_pre = string.match(c_input, "`[-]?[.]?$")
  local check_num_cal = string.match(c_input, "`[-]?[.]?%d+%.?%d*$") or
                        string.match(c_input, "`[-.rq(]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*$")
  -- local key_kp = key_repr:match("KP_([%d%a]+)")  -- KP_([ASDM%d][%a]*)
  -- local kp_p = env.kp_pattern[key_kp]

  -- -- local s_prefix = seg:has_tag("reverse2_lookup") and "';" or seg:has_tag("all_bpm") and "';'" or ""
  -- local s_prefix = "="

-----------------------------------------------------------------------------

  if o_ascii_mode then
    return 2

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  --- pass release alt super (not pass ctrl)
  elseif key:release() or key:alt() or key:super() then
    return 2

-----------------------------------------------------------------------------
--[[
以下開始使得純數字和計算機時，於小鍵盤可輸入數字和運算符
--]]

  elseif seg:has_tag("mf_translator") and key_repr ~= "space" and key_repr ~= "Return" and key_repr ~= "KP_Enter" and key_repr ~= "Shift+space" then
  -- elseif seg:has_tag("lua") and key_repr ~= "space" then
  -- elseif seg:has_tag("lua") and kp_p ~= nil then

    local key_kp = key_repr:match("KP_([%d%a]+)$")  -- KP_([ASDM%d][%a]*)
    local kp_p = kp_pattern[key_kp]
    if kp_p ~= nil then
      if not check_pre and not check_num_cal then
        return 2
      elseif string.match(kp_p, "[%d.-]") then
        -- context.input = c_input .. kp_p
        context:push_input( kp_p )
        return 1
      --- 防開頭後接[+*/]
      elseif check_pre then
        return 2
      elseif string.match(kp_p, "[+*/]") then
        -- context.input = c_input .. kp_p
        context:push_input( kp_p )
        return 1
      end
    end

    -- if env.prefix == "" then  -- 前面 seg:has_tag 已確定
    --   return 2

    -- local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]*)$")
    -- -- if c_input == env.prefix .. "j" then
    -- if op_code then
    --   local key_kp = key_repr:match("^([a-z])$")
    --   local kp_p = op_pattern[ op_code .. key_kp ]
    --   if op_code == "f" and key_repr == "t" then
    --     generic_open(env.op_pattern, env.oscmd)
    --     context:clear()
    --     return 1
    --   elseif kp_p ~= nil then
    --     -- engine:commit_text(kp_p)  -- 測試用
    --     generic_open(kp_p, env.oscmd)
    --     context:clear()
    --     return 1
    --   -- elseif env.textdict == "" then
    --   --   return 2
    --   -- elseif op_code == "f" and key_repr == "c" then
    --   --   -- io.popen("env.custom_phrase")  -- 無效！
    --   --   generic_open(env.custom_phrase, env.oscmd)
    --   --   context:clear()
    --   --   return 1
    --   end
    -- end

-----------------------------------------------------------------------------
--[[
仿香草模式，但不管是否為香草模式，碰到[ '%d]後接字碼，前面直接上屏，後面續輸入。
--]]

  elseif check_i_end and key_abc then
    if ( seg:has_tag("abc") or seg:has_tag("reverse3_lookup") or seg:has_tag("wsymbols") ) then
      -- local loaded_candidate_count = seg.menu:candidate_count()    -- 獲得（已加載）候選詞數量
      -- if string.match(g_c_t, "'$") then  -- 輸入「'」後詞庫沒有對應詞，接續輸入，清前面字碼。
      if loaded_candidate_count == 0 then  -- 輸入「'」後詞庫沒有對應詞，接續輸入，清前面字碼。
        context.input = key_abc
        return 1
      else
        engine:commit_text(g_c_t)
        context.input = key_abc
        return 1
      end
    else
      return 2
    end

  -- --- 限定香草模式下
  -- -- elseif not s_up and check_i_end and ( key_repr:match("^[%l]$") or k4_pattern[key_repr] ) then
  -- --- 非限定香草模式下
  -- elseif check_i_end and ( key_repr:match("^[%l]$") or k4_pattern[key_repr] ) then
  --   if ( seg:has_tag("abc") or seg:has_tag("reverse3_lookup") or seg:has_tag("wsymbols") ) then
  --     local k_r = k4_pattern[key_repr] or key_repr
  --     engine:commit_text(g_c_t)
  --     context.input = k_r
  --     return 1
  --   else
  --     return 2
  --   end

-----------------------------------------------------------------------------
--[[
使「Shift+space」可循環翻頁
--]]

  elseif key_repr == "Shift+space" then
    -- --- 以下可循環翻頁！(末頁會停頓！有提示效果！)
    -- -- local loaded_candidate_count = seg.menu:candidate_count()    -- 獲得（已加載）候選詞數量
    -- if env.n == loaded_candidate_count and env.n > 10 then
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- else
    --   env.n = loaded_candidate_count
    --   -- engine:process_key(KeyEvent("Page_Down"))  -- 方案內已皆設置翻頁。
    --   -- return 1
    --   return 2
    -- end
    --- 以下可循環翻頁！(末頁不會停頓！)
    engine:process_key(KeyEvent("Page_Down"))  --會執行
    local g_c_t_update = context:get_commit_text()
    if loaded_candidate_count > 10 and g_c_t == g_c_t_update then
      -- engine:commit_text("test1「r」！")
      context:refresh_non_confirmed_composition()
      return 1
    else
      return 1  -- 不能為「2」，會兩次「Page_Down」
    end

-----------------------------------------------------------------------------

  --- pass not space Return KP_Enter key_select_keys ( Shift+space ?)
  -- elseif key_repr ~= "space" and key_repr ~= "Return" and key_repr ~= "KP_Enter" and not key_select_keys then
  elseif key_repr ~= "space" and key_repr ~= "Return" and key_repr ~= "KP_Enter" then
  -- elseif key_repr ~= "space" and key_repr ~= "Return" and key_repr ~= "KP_Enter" and key_repr ~= "Shift+space" and not key_select_keys then
    return 2

-----------------------------------------------------------------------------
--[[
以下 return 上屏候選字或英文，設開關
--]]

  -- --- 以下 abc 非英文，而是中文主 segmentor
  -- elseif (a_r_abc) and (seg:has_tag("abc") or seg:has_tag("mf_translator")) and (key_repr == "Return" or key_repr == "KP_Enter") then
  -- -- elseif a_r_abc and check_abc and key_repr == "Return" or key_repr == "KP_Enter" then

  --   -- --- 選字時 Return 上屏選項
  --   -- if not seg:has_tag("paging") then
  --   --   engine:commit_text(c_input)
  --   --   context:clear()
  --   --   return 1
  --   -- end

  --   --- 全狀態（開關符號以 space 翻頁時除外） Return 都上屏英文
  --   engine:commit_text(c_input)
  --   context:clear()
  --   return 1

  --- 改用「a_s_wp」連動控制
  elseif not a_s_wp and not seg:has_tag("reverse2_lookup") and (key_repr == "Return" or key_repr == "KP_Enter") then
    engine:commit_text(c_input)
    context:clear()
    return 1

-----------------------------------------------------------------------------
--[[
開啟檔案程式網址功能
--]]

  elseif seg:has_tag("mf_translator") and not string.match(c_input, env.prefix .. "['/;]") and string.match(c_input, env.prefix .. "j[a-z]+$") then  -- 開頭
    if key_repr == "space" or key_repr == "Return" or key_repr == "KP_Enter" then
      local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]+)$")
      return run_open(context, c_input, caret_pos, op_code, env.run_pattern, "", "", env.oscmd)
      -- return run_open(engine, context, c_input, caret_pos, op_code, env.run_pattern, "", "", env.oscmd)
    end

-----------------------------------------------------------------------------
--[[
以下特殊時 space 直上屏或其他作用
--]]

  elseif not context:has_menu() then
  -- elseif not context:is_composing() then  -- 無法空碼清屏
    return 2

  -- elseif check_i1 or check_i2 or seg:has_tag("mf_translator") or seg:has_tag("email_url_translator") then
  -- -- elseif check_i1 or check_i2 or check_i3 or check_i4 then
  -- -- elseif check_i1 or check_i2 or check_i3 or check_i4 or check_i5 or check_i6 or check_i7 or check_i8 then
  --   if key_repr == "space" then
  --     -- local g_c_t = context:get_commit_text()
  --     engine:commit_text(g_c_t)
  --     context:clear()
  --     return 1 -- kAccepted
  --   else
  --     return 2
  --   end

  --- 「mf_translator」確認模式：空白鍵相關切換（與下條目分開，減少層數效能較好？）
  elseif ((not a_s_wp and seg:has_tag("mf_translator")) or seg:has_tag("email_url_translator")) and key_repr == "space" then
    -- local g_c_t = context:get_commit_text()
    engine:commit_text(g_c_t)
    context:clear()
    return 1

  --- 「mf_translator」翻頁模式：空白鍵相關切換（與上條目分開，減少層數效能較好？）
  elseif a_s_wp and seg:has_tag("mf_translator") and key_repr == "space" then
    -- --- 以下可循環翻頁！(末頁會停頓！有提示效果！)
    -- if env.n == loaded_candidate_count and env.n > 10 then
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- else
    --   env.n = loaded_candidate_count
    --   engine:process_key(KeyEvent("Page_Down"))
    --   local g_c_t_update = context:get_commit_text()
    --   if env.n < 11 and g_c_t == g_c_t_update then
    --     engine:commit_text(g_c_t)
    --     context:clear()
    --   end
    --   return 1
    -- end
    --- 以下可循環翻頁！(末頁不會停頓！)
    engine:process_key(KeyEvent("Page_Down"))  --會執行
    local g_c_t_update = context:get_commit_text()
    if loaded_candidate_count > 10 and g_c_t == g_c_t_update then
      -- engine:commit_text("test1「r」！")
      context:refresh_non_confirmed_composition()
      return 1
    else
      if g_c_t == g_c_t_update then
        engine:commit_text(g_c_t)
        context:clear()
      end
      return 1
    end

  --- 行列30反查注音，不能直接上屏。
  elseif check_i_reverse_space then
    if key_repr == "space" then
      context:push_input(" ")
      return 1
    else
      return 2
    end

  -- --- 三碼以上，「直上模式」時直上。
  -- elseif s_up and check_i_3_or_more then  -- mf_translator 在前，不用擔心影響到。
  --   if key_repr == "space" then
  --     -- local g_c_t = context:get_commit_text()
  --     engine:commit_text(g_c_t)
  --     context:clear()
  --     return 1 -- kAccepted
  --   -- elseif not s_up then
  --   --   -- local loaded_candidate_count = seg.menu:candidate_count()
  --   --   if loaded_candidate_count == 1 then
  --   --     engine:commit_text(g_c_t)
  --   --     context:clear()
  --   --     return 1 -- kAccepted
  --   else
  --     return 2
  --   end

  -- -- --- 二碼「詞句」加空格，「直上模式」時忽略。（「詞句」加空格目前設不作用，故該條目關閉）
  -- -- elseif s_up and check_i_phrases_space then  -- mf_translator 在前，不用擔心影響到。
  -- --   if key_repr == "space" then
  -- --     context:push_input(" ")
  -- --     -- engine:commit_text("test")
  -- --     -- context:refresh_non_confirmed_composition()
  -- --     engine:commit_text(context:get_commit_text())  --不能用 g_c_t
  -- --     context:clear()
  -- --     return 1 -- kAccepted
  -- --   else
  -- --     return 2
  -- --   end

-----------------------------------------------------------------------------
--[[
使「空白鍵」在"[ '%d]$"後變為翻頁（非輸入空白碼），可循環翻頁。
KeyEvent 函數在舊版 librime-lua 中不支持。
--]]

  elseif a_s_wp and check_i_end and not seg:has_tag("reverse2_lookup") and key_repr == "space" then
    -- --- 以下可循環翻頁！(末頁會停頓！有提示效果！)
    -- -- local loaded_candidate_count = seg.menu:candidate_count()    -- 獲得（已加載）候選詞數量
    -- -- local page_n = 10 * (seg.selected_index // 10)    -- 先確定在第幾頁，「//」為整除運算符。
    -- if env.n == loaded_candidate_count and env.n > 10 then
    --   -- engine:commit_text(loaded_candidate_count)  -- 測試用
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- else
    --   -- local check_text = g_c_t
    --   -- engine:commit_text(loaded_candidate_count)  -- 測試用
    --   env.n = loaded_candidate_count
    --   engine:process_key(KeyEvent("Page_Down"))
    --   local g_c_t_update = context:get_commit_text()
    --   if env.n < 11 and g_c_t == g_c_t_update then
    --     engine:commit_text(g_c_t)
    --     context:clear()
    --   end
    --   return 1
    -- end
    --- 以下可循環翻頁！(末頁不會停頓！)
    engine:process_key(KeyEvent("Page_Down"))  --會執行
    local g_c_t_update = context:get_commit_text()
    if loaded_candidate_count > 10 and g_c_t == g_c_t_update then
      -- engine:commit_text("test1「r」！")
      context:refresh_non_confirmed_composition()
      return 1
    else
      if g_c_t == g_c_t_update then
        engine:commit_text(g_c_t)
        context:clear()
      end
      return 1
    end

  --- 補在「a_s_wp」時，翻頁時，空格還是直上。
  elseif a_s_wp and seg:has_tag("paging") and seg:has_tag("abc") and not seg:has_tag("reverse2_lookup") and key_repr == "space" then
    -- engine:process_key(KeyEvent("space"))  -- 會跳到「KP_Space」=>「confirm」。
    -- engine:commit_text("@@")  -- 測試掛接「注音」莫名空格，確認此處問題！已加 not seg:has_tag("reverse2_lookup") 排除修正。
    context:push_input(" ")
    return 1

-----------------------------------------------------------------------------
--[[
使 w[0-9] 輸入符號時：空白鍵同某些行列 30 一樣為翻頁。
KeyEvent 函數在舊版 librime-lua 中不支持。
增設開關。
以下遮屏，因改用「a_s_wp」連動切換，故用上條目，不限「wsymbols」，以「全局」（排除「注音反查」）作用。
--]]

  -- -- elseif a_s_wp and seg:has_tag("wsymbols") then
  -- -- -- elseif a_s_wp and check_w then
  -- --   if key_repr == "space" then
  -- --     engine:process_key(KeyEvent("Page_Down"))
  -- --     return 1 -- kAccepted
  -- --   --- 修正 w[0-9] 空白鍵 設翻頁時，無上屏鍵問題。
  -- --   --- 搭配前面「空白鍵同某些行列 30 一樣為翻頁」，並且用 custom 檔設「return 上屏候選字」，校正 Return 能上屏候選項！
  -- --   elseif key_repr == "Return" or key_repr == "KP_Enter" then
  -- --     engine:commit_text(g_c_t)
  -- --     context:clear()
  -- --     return 1 -- kAccepted
  -- --   end

  -- -- --- 修正 Return 都上屏英文時， w[0-9] 空白鍵為上屏鍵，Return 還是上屏候選項問題。
  -- -- elseif (a_r_abc) and (not a_s_wp) and (seg:has_tag("wsymbols")) and (key_repr == "Return" or key_repr == "KP_Enter") then
  -- --   engine:commit_text(c_input)
  -- --   context:clear()
  -- --   return 1

  -- elseif seg:has_tag("wsymbols") then
  --   --- 以下設置可循環翻頁！
  --   if a_s_wp and key_repr == "space" then
  --     -- local loaded_candidate_count = seg.menu:candidate_count()    -- 獲得（已加載）候選詞數量
  --     -- local page_n = 10 * (seg.selected_index // 10)    -- 先確定在第幾頁，「//」為整除運算符。
  --     if env.n == loaded_candidate_count and env.n > 10 then
  --       context:refresh_non_confirmed_composition()
  --       return 1
  --     else
  --       -- engine:commit_text(loaded_candidate_count)  -- 測試用
  --       env.n = loaded_candidate_count
  --       engine:process_key(KeyEvent("Page_Down"))
  --       return 1
  --     end
  --   -- elseif a_s_wp and key_repr == "Shift+space" then
  --   --   env.n = 0
  --   --   engine:process_key(KeyEvent("Page_Up"))
  --   --   return 1
  --   --- 修正 w[0-9] 空白鍵 設翻頁時，無上屏鍵問題。
  --   --- 搭配前面「空白鍵同某些行列 30 一樣為翻頁」，並且用 custom 檔設「return 上屏候選字」，校正 Return 能上屏候選項！
  --   elseif a_s_wp and (key_repr == "Return" or key_repr == "KP_Enter") then
  --     engine:commit_text(g_c_t)
  --     context:clear()
  --     return 1
  --   -- --- 以下設置可循環翻頁！
  --   -- elseif key_repr == "Shift+space" then
  --   --   -- local loaded_candidate_count = seg.menu:candidate_count()    -- 獲得（已加載）候選詞數量
  --   --   if env.n == loaded_candidate_count and env.n > 10 then
  --   --     context:refresh_non_confirmed_composition()
  --   --     return 1
  --   --   else
  --   --     env.n = loaded_candidate_count
  --   --     -- engine:process_key(KeyEvent("Page_Down"))  -- 方案內已皆設置翻頁。
  --   --     -- return 1
  --   --     return 2
  --   --   end
  --   --- 修正 Return 都上屏英文時， w[0-9] 空白鍵為上屏鍵，Return 還是上屏候選項問題。
  --   elseif a_r_abc and (key_repr == "Return" or key_repr == "KP_Enter") then
  --   -- elseif not a_s_wp and a_r_abc then
  --     engine:commit_text(c_input)
  --     context:clear()
  --     return 1
  --   else
  --     return 2
  --   end

---------------------------------------------------------------------------
--[[
以下針對反查注音 Bug 作修正
--]]

  elseif not seg:has_tag("reverse2_lookup") then
    return 2

-----------------------

  --- 以下遮屏（到「 --- 舊的寫法（直上）」前）改用 segmentor 方法解決，因此可避免無法記憶字詞之 bug 問題。
  -- --- 以下修正：附加方案鍵盤範圍大於主方案時，小板數字鍵選擇出現之 bug。
  -- elseif key_select_keys then
  --   --- 確定選項編號
  --   -- 以下針對選字編碼為：1234567890
  --   local page_n = 10 * (seg.selected_index // 10)    -- 先確定在第幾頁
  --   local ksk_n = tonumber(key_select_keys)
  --   if ksk_n > 0 then
  --     ksk_n = ksk_n - 1 + page_n
  --   elseif ksk_n == 0 then
  --     ksk_n = ksk_n - 1 + page_n + 10
  --   end

  --   ---------------
  --   --- 新的寫法（不直上）

  --   local cand = seg:get_candidate_at(ksk_n)
  --   local miss_number = caret_pos - cand._end  -- miss_number 為「光標位置」和「選項碼數」不匹配時之差數。
  --   local retain_number = #c_input - cand._end  -- 刪除中文編碼後，計算字數。
  --   local back_input = string.sub(c_input, cand._end + 1, caret_pos)
  --   local new_c_input = string.sub(c_input, -retain_number)

  --   if retain_number == 0 then
  --     context:select(ksk_n)
  --   elseif #c_input ~= caret_pos then
  --     engine:commit_text(cand.text)  -- 數字鍵選字時會消失？
  --     context.input = s_prefix .. new_c_input
  --     -- --- 以下切分兩次以上，前面輸入會跳掉！
  --     -- context.input = cand.text .. s_prefix .. new_c_input
  --     -- context.caret_pos = #c_input + #s_prefix
  --   elseif miss_number ~= 0 then
  --     context:select(ksk_n)
  --     context:pop_input(miss_number)
  --     context:push_input(s_prefix .. back_input)
  --     context.caret_pos = #c_input + #s_prefix
  --   else
  --     context:select(ksk_n)
  --   end
  --   -- engine:commit_text("測試")

  --   return 1

    ---------------
    -- --- 舊的寫法（直上）

    -- --- 上屏選擇選項。
    -- -- local cand = context:get_selected_candidate()  -- 只是當前位置
    -- local cand = seg:get_candidate_at(ksk_n)
    -- -- local up_number = #g_c_t + cand._end - caret_pos
    -- -- local f_cand = string.sub(g_c_t, 1, up_number)
    -- -- engine:commit_text(f_cand)  -- 數字鍵選字時會消失
    -- engine:commit_text(cand.text)  -- 一般abc輸入後接掛接，一般輸入會消失

    -- --- 刪除已上屏字詞的前頭字元
    -- local retain_number = #c_input - cand._end  -- 刪除中文編碼後，計算字數。
    -- local ci_cut = string.sub(c_input, -retain_number)

    -- --- 補前綴 "="，導入未上屏編碼，避免跳回主方案
    -- -- if #ci_cut == 0 then
    -- if retain_number == 0 then
    --   context:clear()
    -- else
    --   context.input = "=" .. ci_cut
    -- end

    -- return 1

    ---------------
    -- --- 更舊的寫法

    -- context:select(key_select_keys)
    -- context:confirm_current_selection()
    -- local s_index = seg.selected_index
    -- engine:commit_text(s_index)
    -- engine:commit_text(g_s_t)
    -- engine:commit_text(g_c_t)
    -- engine:commit_text(ksk_n)

    -- --- 刪除已上屏字詞的前頭字元
    -- -- local cand_len = #cand.text // 3
    -- local cand_len = utf8.len(cand.text)
    -- local ci_cut = string.gsub(c_input, "^=", "")
    -- -- 上屏詞彙為單個注音
    -- if set_char_bpmf[cand.text] then
    --   ci_cut = string.gsub(ci_cut, "^[.,;/ %w-]", "")
    -- -- 上屏詞彙為兩個注音
    -- elseif (cand_len == 2) and set_char_bpmf[utf8_sub(cand.text, 1, 1)] and set_char_bpmf[utf8_sub(cand.text, 2, 2)] then
    --   ci_cut = string.gsub(ci_cut, "^[.,;/ %w-][.,;/ %w-]", "")
    -- -- 上屏詞彙為三個注音
    -- elseif (cand_len == 3) and set_char_bpmf[utf8_sub(cand.text, 1, 1)] and set_char_bpmf[utf8_sub(cand.text, 2, 2)] and set_char_bpmf[utf8_sub(cand.text, 3, 3)] then
    --   ci_cut = string.gsub(ci_cut, "^[.,;/ %w-][.,;/ %w-][.,;/ %w-]", "")
    -- -- 上屏詞彙為全中文不含注音，但有狀況會缺漏出現 bug
    -- else
    --   for i = 1, cand_len do
    --     ci_cut = string.gsub(ci_cut, "^[.,;/a-z125890-][.,;/a-z125890-]?[.,;/a-z125890-]?[ 3467]", "")
    --   end
    -- end

    -- --- 補前綴 "="，導入未上屏編碼，避免跳回主方案
    -- -- if #ci_cut == 0 then
    -- if retain_number == 0 then
    --   context:clear()
    -- else
    --   context.input = "=" .. ci_cut
    -- end

    -- return 1

-----------------------

  --- 以下修正：附加方案鍵盤範圍大於主方案時，選字時出現的 bug。
  -- elseif key_repr == "space" or key_repr == "Return" or key_repr == "KP_Enter" then
  -- elseif not key_select_keys then
  else

    ---------------
    -- --- 新的寫法（不直上）

    -- local cand = context:get_selected_candidate()
    -- local miss_number = caret_pos - cand._end  -- miss_number 為「光標位置」和「選項碼數」不匹配時之差數。
    -- local retain_number = #c_input - cand._end  -- 刪除中文編碼後，計算字數。
    local f_c_input = string.sub(c_input, 1, caret_pos)
    -- local back_input = string.sub(c_input, cand._end + 1, caret_pos)
    -- local new_c_input = string.sub(c_input, -retain_number)

    --- 中途插入空白（一聲）不會直上屏
    if key_repr == "space" and #c_input ~= caret_pos and not seg:has_tag("paging") and not string.match(f_c_input, "[ 3467]$") then
      local b_c_input = string.sub(c_input, caret_pos - #c_input)
      context.input = f_c_input .. " " .. b_c_input
      return 1

    --- 以下遮屏（到「 --- 舊的寫法（直上）」前）改用 segmentor 方法解決，因此可避免無法記憶字詞之 bug 問題。
    -- --- paging 時和游標不在尾端時，需分割上屏之處理
    -- elseif seg:has_tag("paging") or #c_input ~= caret_pos then  --miss_number ~= 0
    --   --- 先上屏 paging 時選擇的選項
    --   -- local selected_candidate_index = seg.selected_index
    --   -- context:select(selected_candidate_index)

    --   --- 以下不管是否在 paging 時
    --   if retain_number == 0 then
    --     context:confirm_current_selection()
    --   elseif #c_input ~= caret_pos then
    --     engine:commit_text(cand.text)  -- 數字鍵選字時會消失？
    --     context.input = s_prefix .. new_c_input
    --     -- --- 以下切分兩次以上，前面輸入會跳掉！
    --     -- context.input = cand.text .. s_prefix .. new_c_input
    --     -- context.caret_pos = #c_input + #s_prefix
    --   elseif miss_number ~= 0 then
    --     context:confirm_current_selection()  -- 一定要有，不然只會上屏第一個選項或記憶？
    --     context:pop_input(miss_number)
    --     context:push_input(s_prefix .. back_input)
    --     context.caret_pos = #c_input + #s_prefix
    --   else  -- else 部分效果等同「retain_number == 0」，兩者擇一可遮屏，留「retain_number == 0」去提前判斷省下面複雜判斷，留 else 防萬一。
    --     context:confirm_current_selection()
    --   end
    --   -- engine:commit_text("測試")
    --   -- engine:commit_text(cand.text)
    --   return 1

    ---------------
    -- --- 舊的寫法（直上）

    -- --- paging 時和游標不在尾端時，需分割上屏之處理
    -- if seg:has_tag("paging") or #c_input ~= caret_pos then
    --   --- 先上屏 paging 時選擇的選項
    --   -- local selected_candidate_index = seg.selected_index
    --   -- context:select(selected_candidate_index)

    --   --- 中途插入空白（一聲）不會直上屏
    --   local f_c_input = string.sub(c_input, 1, caret_pos)
    --   if key_repr == "space" and #c_input ~= caret_pos and not seg:has_tag("paging") and not string.match(f_c_input, "[ 3467]$") then
    --     local b_c_input = string.sub(c_input, caret_pos - #c_input)
    --     context.input = f_c_input .. " " .. b_c_input

    --   else
    --     --- 上屏選擇選項。
    --     local cand = context:get_selected_candidate()
    --     local up_number = #g_c_t + cand._end - caret_pos
    --     local f_cand = string.sub(g_c_t, 1, up_number)
    --     engine:commit_text(f_cand)  -- 數字鍵選字時會消失
    --     -- engine:commit_text(cand.text)  -- 一般abc輸入後接掛接，一般輸入會消失
    --     -- engine:commit_text(cand.text..start.." ".._end.." "..#c_input.." "..caret_pos )  --測試各個位置數值用

    --     --- 計算末尾殘留的非中文字元數（未被選擇的 cand.input 字元數）
    --     local retain_number = #c_input - cand._end  -- 刪除中文編碼後，計算字數。
    --     local new_c_input = string.sub(c_input, -retain_number)
    --     -- local retain_number = #string.gsub(g_c_t, "[^.,;/ %w-]", "")  -- 刪除中文編碼後，計算字數。
    --     -- context:confirm_current_selection()
    --     -- context:refresh_non_confirmed_composition()

    --     --- 補前綴 "';" 或 "';'"，導入未上屏編碼，避免跳回主方案
    --     if retain_number == 0 then
    --       context:clear()
    --     else
    --       context.input = "=" .. new_c_input
    --     end
    --   end
    --   return 1

      ---------------


    --- 某些方案輸入 Return 出英文，該條限定注音 Return 一律直上中文。
    elseif key_repr == "Return" or key_repr == "KP_Enter" then
      context:confirm_current_selection()  -- 可記憶
      -- context:commit()  -- 可記憶
      -- engine:process_key( KeyEvent("Return") )  -- 可能會報錯
      -- engine:commit_text(g_c_t)  -- 不會記憶
      -- context:clear()
      return 1
      -- return 2

    --- 如果末尾為聲調則跳掉，按空白鍵，則 Rime 上屏，非 lua 作用。
    elseif string.match(c_input, "[ 3467]$") then
      return 2
      -- engine:commit_text("@@")  -- 測試用
      -- context:confirm_current_selection()  -- 測試用
      -- return 1  -- 測試用

    --- 補掛接反查注音不能使用空白當作一聲
    elseif key_repr == "space" then
    -- elseif key_repr == "space" then
    -- elseif key_repr == "space" and context:has_menu() then
      -- engine:commit_text(c_input .. "_")
      -- context.input = c_input .. " "
      context:push_input(" ")
      -- context:clear()
      return 1

    end

---------------------------------------------------------------------------

  end

  return 2
end

-- return array30new_mix
-- return { func = processor }
return { init = init, func = processor }