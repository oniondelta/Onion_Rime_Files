--- @@ mix_apc_s2rm_ltk 注音mixin 1_2_4 和 plus 專用
--[[
（bo_mixin 1、2、4；bopomo_onionplus）
合併 ascii_punct_change、s2r_most、lua_tran_kp，增進效能。
新增快捷鍵開啟檔案/程式/網站
--]]

----------------------------------------------------------------------------------------
local generic_open = require("p_components/p_generic_open")
local run_pattern = require("p_components/p_run_pattern")
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
  env.en_prefix = config:get_string("easy_en/prefix") or ""
  env.jp_prefix = config:get_string("japan/prefix") or ""
  env.cyr_prefix = config:get_string("cyr2/prefix") or ""
  env.gr_prefix = config:get_string("gr2/prefix") or ""
  env.fs_prefix = config:get_string("fs2/prefix") or ""
  env.rl_prefix = config:get_string("reverse2_lookup/prefix") or ""
  env.eu_prefix = config:get_string("european/prefix") or ""
  env.kr_prefix = config:get_string("korea/prefix") or ""
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

-- local function mix_apc_s2rm_ltk(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  -- local g_s_t = context:get_script_text()
  -- local _end = context:get_preedit().sel_end
  local g_c_t = context:get_commit_text()
  local o_ascii_punct = context:get_option("ascii_punct")
  local o_ascii_mode = context:get_option("ascii_mode")
  -- local c_i_c = context:is_composing()

  -- local check_i1 = string.match(c_input, "[@:]")
  -- local check_i2 = string.match(c_input, "'/")
  -- local check_i3 = string.match(c_input, "=[-125890;,./]$")
  -- local check_i4 = string.match(c_input, "=[-;,./][-;,./]$")
  -- local check_i5 = string.match(c_input, "==[90]$")
  -- local check_i = string.match(c_input, "[@:]") or
  --                 string.match(c_input, "'/") or
  --                 string.match(c_input, "=[-125890;,./]$") or
  --                 string.match(c_input, "=[-;,./][-;,./]$") or
  --                 string.match(c_input, "==[90]$")
  -- local check_punct = string.match(c_input, "=[-125890;,./]$") or
  --                     string.match(c_input, "=[-;,./][-;,./]$") or
  --                     string.match(c_input, "==[90]$")

  local check_pre = string.match(c_input, "'/[-]?[.]?$")
  local check_num_cal = string.match(c_input, "'/[-]?[.]?%d+%.?%d*$") or
                        string.match(c_input, "'/[-.rq(]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*$")
  -- local key_kp = key:repr():match("KP_([%d%a]+)")  -- KP_([ASDM%d][%a]*)
  -- local kp_p = env.kp_pattern[key_kp]

---------------------------------------------------------------------------

  if o_ascii_mode then
    return 2

  -- --- 該條目移到下方，這邊開啟 Shift+less 和 Shift+greater 啟始無法作用
  -- --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  -- elseif comp:empty() then
  --   return 2

  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2

---------------------------------------------------------------------------
--[[
以下 ascii_punct 標點轉寫
--]]

  elseif o_ascii_punct and key:repr() == "Shift+less" then
    if context:is_composing() then
    -- if c_i_c then
      -- local cand = context:get_selected_candidate()
      -- engine:commit_text( cand.text .. "," )  -- ascii_punct 時選擇選項與其他標點不統一
      engine:commit_text( g_c_t .. "," )
    else
      engine:commit_text( "," )
    end
    context:clear()
    return 1 -- kAccepted

  elseif o_ascii_punct and key:repr() == "Shift+greater" then
    if context:is_composing() then
    -- if c_i_c then
      -- local cand = context:get_selected_candidate()
      -- engine:commit_text( cand.text .. "." )  -- ascii_punct 時選擇選項與其他標點不統一
      engine:commit_text( g_c_t .. "." )
    else
      engine:commit_text( "." )
    end
    context:clear()
    return 1 -- kAccepted

---------------------------------------------------------------------------
--[[
以下特殊時 space 直上屏和修正
以下掛接 return 上屏修正
--]]

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  elseif not context:is_composing() then
    return 2

  elseif seg:has_tag("abc") or seg:has_tag("all_bpm") then
    return 2

  elseif key:repr() == "space" or key:repr() == "Return" or key:repr() == "KP_Enter" then
  -- elseif key:repr() == "space" then
  -- elseif key:repr() == "space" and context:is_composing() then
  -- elseif key:repr() == "space" and context:has_menu() then
  -- elseif key:repr() == "space" and c_i_c then

    -- if comp:empty() then
    --   return 2
    -- if not context:is_composing() then
    --   return 2
    -- elseif seg:has_tag("abc") or seg:has_tag("all_bpm") then
    --   return 2

    local op_code_index = #c_input == caret_pos and string.match(c_input, "^" .. env.prefix .. "j$")
    local op_code_check = not string.match(c_input, env.prefix .. "['/;]") and string.match(c_input, env.prefix .. "j[a-z]+$")
    local op_code = string.match(c_input, "^" .. env.prefix .. "j([a-z]+)$")
    if  seg:has_tag("mf_translator") and op_code_index then
      -- local set_explain = Set { 0, 1, 2, 5}
      local selected_candidate_index = seg.selected_index or 0
      local cand = context:get_selected_candidate()
      local op_code = string.match(cand.comment, "^[ ]+~([a-z]+)")
      local run_in = run_pattern[ op_code ]
      -- if set_explain[selected_candidate_index] then
      --   -- engine:commit_text(selected_candidate_index)  -- 測試用
      --   context:clear()
      --   return 1
      if selected_candidate_index == 3 then
        generic_open(env.run_pattern)
        context:clear()
        return 1
      elseif run_in ~= nil and selected_candidate_index ~= 4 then
        -- engine:commit_text(run_in)  -- 測試用
        generic_open(run_in.open)  -- 要確定 run_in 不為 nil，才能加.open
        context:clear()
        return 1
      elseif env.textdict == "" then
        return 2
      elseif selected_candidate_index == 4 then
        generic_open(env.custom_phrase)
        context:clear()
        return 1
      else  -- 沒有該碼，空白鍵清空
        -- context:confirm_current_selection()
        context:clear()
        return 1
      end
    elseif seg:has_tag("mf_translator") and op_code_check then  -- 開頭
      local run_in = run_pattern[ op_code ] -- 此處不能「.open」，如 op_code 不符合會報錯！
      if not op_code then
        return 1
      elseif #c_input ~= caret_pos then
        -- context:clear()
        return 1
      -- elseif #c_input == caret_pos then
      elseif op_code == "t" then
        -- engine:commit_text( "TEST！！！" )  -- 測試用
        generic_open(env.run_pattern)
        context:clear()
        return 1
      elseif run_in ~= nil then
        -- engine:commit_text(run_in)  -- 測試用
        generic_open(run_in.open)  -- 要確定 run_in 不為 nil，才能加.open
        context:clear()
        return 1
      elseif env.textdict == "" then
        return 2
      elseif op_code == "c" then
        -- io.popen("env.custom_phrase")  -- 無效！
        generic_open(env.custom_phrase)
        context:clear()
        return 1
      else  -- 沒有該碼，空白鍵清空
        -- context:confirm_current_selection()
        context:clear()
        return 1
      end

    elseif seg:has_tag("paging") and #c_input == caret_pos then  -- 加限定防止游標移中時，不能翻頁選字。
      return 2
    -- elseif #c_input == caret_pos and (key:repr() == "Return" or key:repr() == "KP_Enter") then
    --   return 2

    -- elseif #c_input == caret_pos and key:repr() == "space" then
    elseif #c_input == caret_pos then
      context:confirm_current_selection()  -- 可記憶
      -- engine:process_key( KeyEvent("Return") )  -- 可能會報錯
      -- engine:commit_text(g_c_t)  -- 不會記憶
      -- context:clear()
      return 1 -- kAccepted

    -- elseif seg:has_tag("punct") or seg:has_tag("mf_translator") or seg:has_tag("email_url_translator") or seg:has_tag("emoji_series") then
    -- -- if check_punct or seg:has_tag("mf_translator") or seg:has_tag("email_url_translator") then
    -- -- if check_i then
    -- -- if check_i1 or check_i2 or check_i3 or check_i4 or check_i5 then
    -- -- if ( string.match(c_input, "[@:]") or string.match(c_input, "'/") or string.match(c_input, "=[-125890;,./]$") or string.match(c_input, "=[-;,./][-;,./]$") or string.match(c_input, "==[90]$") ) then  --or string.match(c_input, "==[,.]{2}$")
    -- -- if ( string.match(c_input, "[@:]") or string.match(c_input, "'/") or string.match(c_input, "=[-125890;,./]$") or string.match(c_input, "=[-;,./][-;,./]$") or string.match(c_input, "==[90]$") or string.match(c_input, "==[,][,]?$") or string.match(c_input, "==[.][.]?$") ) then
    -- -- -- 「全，非精簡」 if ( string.match(c_input, "[@:]") or string.match(c_input, "'/") or string.match(c_input, "=[-125890;,./]$") or string.match(c_input, "=[-][-]$") or string.match(c_input, "=[;][;]$") or string.match(c_input, "=[,][,]$") or string.match(c_input, "=[.][.]$") or string.match(c_input, "=[/][/]$") or string.match(c_input, "==[90]$") or string.match(c_input, "==[,][,]?$") or string.match(c_input, "==[.][.]?$") ) then
    --   engine:commit_text(g_c_t)
    --   context:clear()
    --   return 1 -- kAccepted

    -- elseif #c_input == caret_pos then
    -- -- elseif caret_pos == c_input:len() then
    --   return 2

    --- 以下掛接上屏 bug 修正
    elseif seg:has_tag("easy_en") or seg:has_tag("japan") or seg:has_tag("cyr2") or seg:has_tag("gr2") or seg:has_tag("fs2") or seg:has_tag("reverse2_lookup") or seg:has_tag("european") or seg:has_tag("korea") then
    -- elseif seg:has_tag("japan") or seg:has_tag("cyr2") or seg:has_tag("gr2") or seg:has_tag("fs2") or seg:has_tag("reverse2_lookup") or seg:has_tag("european") or seg:has_tag("korea") then
    -- elseif not seg:has_tag("punct") and not seg:has_tag("mf_translator") and not not seg:has_tag("email_url_translator") then
      local prefix_key = seg:has_tag("japan") and env.jp_prefix
                      or seg:has_tag("cyr2") and env.cyr_prefix
                      or seg:has_tag("gr2") and env.gr_prefix
                      or seg:has_tag("fs2") and env.fs_prefix
                      or seg:has_tag("reverse2_lookup") and env.rl_prefix
                      or seg:has_tag("european") and env.eu_prefix
                      or seg:has_tag("korea") and env.kr_prefix
                      or seg:has_tag("easy_en") and env.en_prefix
                      or ""

      -- if seg:has_tag("paging") and #c_input == caret_pos then
      --   return 2

      -- if #c_input == caret_pos then       --- 直接上屏，不用尾綴
      -- -- if caret_pos == c_input:len() then
      --   -- context:push_input( " " )
      --   engine:commit_text(g_c_t)
      --   context:clear()
      --   return 1 -- kAccepted

    -- if #c_input ~= caret_pos then
    -- elseif caret_pos ~= c_input:len() then
      -- engine:commit_text(g_c_t)

      --- 上屏選擇選項。
      local cand = context:get_selected_candidate()
      local up_number = #g_c_t + cand._end - caret_pos
      local f_cand = string.sub(g_c_t, 1, up_number)
      engine:commit_text(f_cand)  -- 數字鍵選字時會消失
      -- engine:commit_text(cand.text)  -- 一般abc輸入後接掛接，一般輸入會消失
      -- context:confirm_current_selection()  -- 此處該條目無法出字

      -- local gst_cut = string.match(g_s_t, "》([-A-Z,.;/ ]+)$")
      -- local gst_cut = string.gsub(gst_cut, " ", "")
      -- local cinput_cut = string.match(c_input, "4([-a-z,.;/]+)$")
      -- local retain_number = #cinput_cut - #gst_cut

      -- local segmentation = comp:toSegmentation()
      -- local confirmed_pos = segmentation and segmentation:get_current_end_position() or 0
      -- local confirmed_pos = segmentation and segmentation:get_confirmed_position() or 0
      -- local confirmed_pos = segmentation and segmentation:get_current_segment_length() or 0
      -- local _end2 = comp:get_current_end_position()
      -- local retain_number = #c_input - confirmed_pos
      -- local new_c_input = prefix_key .. string.sub(c_input, -retain_number)

      -- local retain_number = #c_input - caret_pos
      -- local new_c_input = prefix_key .. string.sub(c_input, -retain_number)

      --- 計算末尾殘留的非中文字元數（未被選擇的 cand.input 字元數）
      local retain_number = #c_input - cand._end
      local new_c_input = prefix_key .. string.sub(c_input, -retain_number)

      --- 補前綴，導入未上屏編碼，避免跳回主方案
      -- if retain_number < 1 then
      --   context:clear()
      -- else
      context.input = new_c_input
      --   return 2
      -- end
      return 1 -- kAccepted
    -- end

    end

---------------------------------------------------------------------------
--[[
以下掛接 return 上屏修正
--]]

  -- elseif key:repr() == "Return" or key:repr() == "KP_Enter" then

  --   -- if comp:empty() then
  --   --   return 2
  --   if not context:is_composing() then
  --     return 2
  --   elseif seg:has_tag("abc") or seg:has_tag("all_bpm") then
  --     return 2
  --   elseif #c_input == caret_pos then
  --     return 2
  --   elseif seg:has_tag("paging") then  --省略 #c_input == caret_pos
  --     return 2

  --   elseif seg:has_tag("japan") or seg:has_tag("cyr2") or seg:has_tag("gr2") or seg:has_tag("fs2") or seg:has_tag("reverse2_lookup") or seg:has_tag("european") or seg:has_tag("korea") then
  --     local prefix_key = seg:has_tag("japan") and env.jp_prefix
  --                     or seg:has_tag("cyr2") and env.cyr_prefix
  --                     or seg:has_tag("gr2") and env.gr_prefix
  --                     or seg:has_tag("fs2") and env.fs_prefix
  --                     or seg:has_tag("reverse2_lookup") and env.rl_prefix
  --                     or seg:has_tag("european") and env.eu_prefix
  --                     or seg:has_tag("korea") and env.kr_prefix
  --                     or ""
  --     local cand = context:get_selected_candidate()
  --     local up_number = #g_c_t + cand._end - caret_pos
  --     local f_cand = string.sub(g_c_t, 1, up_number)
  --     engine:commit_text(f_cand)  -- 數字鍵選字時會消失
  --     -- engine:commit_text(cand.text)  -- 一般abc輸入後接掛接，一般輸入會消失
  --     local retain_number = #c_input - cand._end
  --     local new_c_input = prefix_key .. string.sub(c_input, -retain_number)
  --     -- if retain_number < 1 then
  --     --   context:clear()
  --     -- else
  --     context.input = new_c_input
  --     --   return 2
  --     -- end
  --     return 1 -- kAccepted
  --   end

---------------------------------------------------------------------------
--[[
以下使得純數字和計算機時，於小鍵盤可輸入數字和運算符
以下使得輸入開啟碼可開啟檔案程式網址
--]]

  elseif seg:has_tag("mf_translator") then
  -- elseif seg:has_tag("lua") then

    local key_kp = key:repr():match("^KP_([%d%a]+)$")  -- KP_([ASDM%d][%a]*)
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
    -- -- if c_input == env.prefix .. "r" then
    -- if op_code then
    --   local key_kp = key:repr():match("^([a-z])$")
    --   local kp_p = op_pattern[ op_code .. key_kp ]
    --   if op_code == "f" and key:repr() == "t" then
    --     generic_open(env.op_pattern)
    --     context:clear()
    --     return 1
    --   elseif kp_p ~= nil then
    --     -- engine:commit_text(kp_p)  -- 測試用
    --     generic_open(kp_p)
    --     context:clear()
    --     return 1
    --   elseif env.textdict == "" then
    --     return 2
    --   elseif op_code == "f" and key:repr() == "c" then
    --     -- io.popen("env.custom_phrase")  -- 無效！
    --     generic_open(env.custom_phrase)
    --     context:clear()
    --     return 1
    --   end
    -- end

---------------------------------------------------------------------------

  end

  return 2 -- kNoop
end

-- return mix_apc_s2rm_ltk
-- return { func = processor }
return { init = init, func = processor }