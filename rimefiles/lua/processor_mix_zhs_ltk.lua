--- @@ mix_zhs_ltk
--[[
（ocm_mixin、dif1、ocm_onionmix）
注音反查 Return 和 space 和 小鍵盤數字鍵 上屏修正
尚有bug待處理
合併 zhuyin_space、lua_tran_kp
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
  local namespace2 = "lua_custom_phrase"
  local path = rime_api.get_user_data_dir()
  env.prefix = config:get_string(namespace1 .. "/prefix") or ""
  env.textdict = config:get_string(namespace2 .. "/user_dict") or ""
  env.custom_phrase = path .. "/" .. env.textdict .. ".txt" or ""
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

-- local set_char_bpmf = Set {"ㄅ", "ㄆ", "ㄇ", "ㄈ", "ㄉ", "ㄊ", "ㄋ", "ㄌ", "ㄍ", "ㄎ", "ㄏ", "ㄐ", "ㄑ", "ㄒ", "ㄓ", "ㄔ", "ㄕ", "ㄖ", "ㄗ", "ㄘ", "ㄙ", "ㄧ", "ㄨ", "ㄩ", "ㄚ", "ㄛ", "ㄜ", "ㄝ", "ㄞ", "ㄟ", "ㄠ", "ㄡ", "ㄢ", "ㄣ", "ㄤ", "ㄥ", "ㄦ", "ˉ", "ˊ", "ˇ", "ˋ", "˙", "ㄪ", "ㄫ", "ㄫ", "ㄬ", "ㄭ", "ㄮ", "ㄮ", "ㄯ", "ㄯ", "ㆠ", "ㆡ", "ㆢ", "ㆣ", "ㆤ", "ㆥ", "ㆦ", "ㆧ", "ㆨ", "ㆩ", "ㆪ", "ㆫ", "ㆬ", "ㆭ", "ㆭ", "ㆮ", "ㆯ", "ㆰ", "ㆰ", "ㆱ", "ㆱ", "ㆲ", "ㆲ", "ㆳ", "ㆴ", "ㆵ", "ㆶ", "ㆷ", "ㆸ", "ㆹ", "ㆺ"}

-- local function mix_zhs_ltk(key,env)
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
  local key_repr = key:repr()
  -- local key_select_keys = key_repr:match("^KP_([0-9])$") or key_repr:match("^Control%+([0-9])$")

  local check_pre = string.match(c_input, "'/[-]?[.]?$")
  local check_num_cal = string.match(c_input, "'/[-]?[.]?%d+%.?%d*$") or
                        string.match(c_input, "'/[-.rq(]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*$")
  -- local key_kp = key_repr:match("KP_([%d%a]+)")  -- KP_([ASDM%d][%a]*)
  -- local kp_p = env.kp_pattern[key_kp]
  -- local s_prefix = seg:has_tag("reverse2_lookup") and "';" or seg:has_tag("all_bpm") and "';'" or ""
-----------------------------------------------------------------------------

  if o_ascii_mode then
    return 2

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  --- pass release alt super (not pass ctrl)
  elseif key:release() or key:alt() or key:super() then
    return 2

---------------------------------------------------------------------------
--[[
以下開始使得純數字和計算機時，於小鍵盤可輸入數字和運算符
--]]

  elseif seg:has_tag("mf_translator") then
  -- elseif seg:has_tag("lua") then
  -- elseif seg:has_tag("lua") and kp_p ~= nil then

    local key_kp = key_repr:match("^KP_([%d%a]+)$")  -- KP_([ASDM%d][%a]*)
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

    local op_code_check = not string.match(c_input, env.prefix .. "['/;]") and string.match(c_input, env.prefix .. "j[a-z]+$")
    local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]+)$")
    if op_code_check and (key_repr == "space" or key_repr == "Return" or key_repr == "KP_Enter") then
      return run_open(context, c_input, caret_pos, op_code, env.run_pattern, env.textdict, env.custom_phrase, env.oscmd)
      -- return run_open(engine, context, c_input, caret_pos, op_code, env.run_pattern, env.textdict, env.custom_phrase, env.oscmd)
    end

    -- if env.prefix == "" then  -- 前面 seg:has_tag 已確定
    --   return 2

    -- local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]*)$")
    -- -- if c_input == env.prefix .. "r" then
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
    --   elseif env.textdict == "" then
    --     return 2
    --   elseif op_code == "f" and key_repr == "c" then
    --     -- io.popen("env.custom_phrase")  -- 無效！
    --     generic_open(env.custom_phrase, env.oscmd)
    --     context:clear()
    --     return 1
    --   end
    -- end

---------------------------------------------------------------------------
--[[
以下針對反查注音和注音文 Bug 作修正
--]]

  elseif not seg:has_tag("reverse2_lookup") and not seg:has_tag("all_bpm") then
    return 2

  elseif not context:has_menu() then
  -- elseif not context:is_composing() then  --無法空碼清屏
    return 2

  --- pass not space Return KP_Enter key_select_keys
  -- elseif key_repr ~= "space" and key_repr ~= "Return" and key_repr ~= "KP_Enter" and not key_select_keys then
  elseif key_repr ~= "space" and key_repr ~= "Return" and key_repr ~= "KP_Enter" then
    return 2

-----------------------

  --- 以下遮屏（到「 --- 舊的寫法（直上）」前）改用 segmentor 方法解決，因此可避免無法記憶字詞之 bug 問題。
  -- --- 以下修正：附加方案鍵盤範圍大於主方案時，小板數字鍵選擇出現之 bug。
  -- elseif key_select_keys then
  --   --- 確定選項編號
  --   -- 以下針對選字編碼為：012345678
  --   local page_n = 9 * (seg.selected_index // 9)    -- 先確定在第幾頁
  --   local ksk_n = tonumber(key_select_keys)
  --   if ksk_n == 9 then    -- 方案預設沒有選項9，故跳掉。
  --     return 1
  --   elseif ksk_n > 0 then
  --     ksk_n = ksk_n + page_n
  --   elseif ksk_n == 0 then
  --     ksk_n = ksk_n + page_n
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

    -- --- 補前綴，導入未上屏編碼，避免跳回主方案
    -- if retain_number == 0 then
    --   context:clear()
    -- elseif seg:has_tag("reverse2_lookup") then
    --   context.input = "';" .. ci_cut
    -- elseif seg:has_tag("all_bpm") then
    --   context.input = "';'" .. ci_cut
    -- end

    -- return 1

    ---------------
    -- --- 更舊的寫法

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
    --     elseif seg:has_tag("reverse2_lookup") then
    --       context.input = "';" .. new_c_input
    --     elseif seg:has_tag("all_bpm") then
    --       context.input = "';'" .. new_c_input
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


-- return mix_zhs_ltk
-- return { func = processor }
return { init = init, func = processor }