--- @@ predictor_improve
--[[
（onion-array30）
改進預測詞 predictor 用
針對「return」和「space」按鍵和「shifit+space」翻頁作用改善。
--]]




-- local function init(env)
--   env.n = 0  -- 計數用
-- end

-- local function predictor_improve(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local comp = context.composition
  local seg = comp:back()
  local loaded_candidate_count = seg.menu:candidate_count()    -- 獲得（已加載）候選詞數量
  local o_ascii_mode = context:get_option("ascii_mode")
  local a_s_wp = context:get_option("array30_space_wp")
  local pd = context:get_option("prediction")
  local cand = context:get_selected_candidate()
  local g_c_t = context:get_commit_text()
  local seg_pd = seg:has_tag("prediction")
  local s_s_i = seg.selected_index  -- 選中的 index
  local g_c_a_2 = seg:get_candidate_at(s_s_i+1) or seg:get_candidate_at(s_s_i) -- 第二候選項（最候選項+1會產生錯誤，故用「or」防止）
  local key_repr = key:repr()
  local key_select_keys = key_repr:match("^KP_(%d)$") or key_repr:match("^Control%+(%d)$")

-----------------------------------------------------------------------------

  if o_ascii_mode or not pd then
    return 2

  -- --- 修 bug，測試用！
  -- elseif seg:has_tag("paging") and key_repr == "space" then
  --   -- engine:process_key(KeyEvent("Page_Down"))
  --   engine:commit_text(cand.type)
  --   return 1

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  -- -- pass release ctrl alt super
  -- elseif key:release() or key:ctrl() or key:alt() or key:super() then
  --   return 2

  --- pass release alt super (not pass ctrl)
  elseif key:release() or key:alt() or key:super() then
    return 2

  elseif not context:has_menu() then
    return 2

  -- elseif c_input ~= "" then
  elseif not seg_pd then
    return 2

--------------------------------------
--[[
修正 ctrl_num 和 kp_num 選字錯誤
--]]

  elseif key_select_keys then
    -- local ctrl_num = "Control+" .. key_select_keys
    -- engine:process_key(KeyEvent(ctrl_num))
    context:select(key_select_keys)
    -- engine:commit_text(key_select_keys)
    -- engine:commit_text(key_repr)
    return 1

--------------------------------------

  elseif key_repr ~= "space" and key_repr ~= "Return" and key_repr ~= "KP_Enter" and key_repr ~= "Shift+space" then
  -- elseif key_repr ~= "space" and key_repr ~= "Shift+space" then
    return 2

  -- elseif cand.type ~= "prediction_first" and cand.type ~= "prediction" then
  --   return 2

--------------------------------------
--[[
使「Shift+space」翻頁
--]]

  elseif key_repr == "Shift+space" then

    -- --- 簡捷會止住翻頁
    -- engine:process_key(KeyEvent("Page_Down"))
    -- return 1

    -- --- 以下可循環翻頁！(末頁會停頓！有提示效果！)(上頁後再下頁會有問題！)
    -- -- local loaded_candidate_count = seg.menu:candidate_count()    -- 獲得（已加載）候選詞數量
    -- if env.n == loaded_candidate_count and env.n > 10 then
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- else
    --   env.n = loaded_candidate_count
    --   engine:process_key(KeyEvent("Page_Down"))  -- 方案內已皆設置翻頁。
    --   return 1
    --   -- return 2  -- 這邊不要使用！
    -- end

    --- 以下可循環翻頁！(末頁不會停頓！)
    engine:process_key(KeyEvent("Page_Down"))  --會執行
    local g_c_t_update = context:get_commit_text()
    local s_s_i_update = seg.selected_index  -- 選中的 index
    local g_c_a_2_update = seg:get_candidate_at(s_s_i_update+1) or seg:get_candidate_at(s_s_i_update)  -- 第二候選項更新（最候選項+1會產生錯誤，故用「or」防止）
    -- --- 以下不能使用，上頁後再下頁會有問題！
    -- local l_c_c_update = seg.menu:candidate_count()
    -- if loaded_candidate_count > 10 and loaded_candidate_count_update == loaded_candidate_count then
    --   -- engine:process_key(KeyEvent("Down"))
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- --- 以下有跳轉回首頁問題！
    -- if loaded_candidate_count > 10 and g_c_a_2.text == g_c_a_2_update.text then
    --   -- engine:commit_text("test2「r」！")
    --   context:refresh_non_confirmed_composition()
    --   return 1
    --- 以下完成版！
    if loaded_candidate_count > 10 and g_c_t == "" and g_c_a_2.text == g_c_a_2_update.text then
      -- engine:commit_text("test2「r」！")
      context:refresh_non_confirmed_composition()
      return 1
    elseif loaded_candidate_count > 10 and g_c_t ~= "" and g_c_t == g_c_t_update then
      -- engine:commit_text("test1「r」！")
      context:refresh_non_confirmed_composition()
      return 1
    else
      -- engine:commit_text(loaded_candidate_count)
      return 1  -- 不能為「2」，會兩次「Page_Down」
    end

--------------------------------------
--[[
使「space」翻頁
--]]

  --- 翻頁模式：空白鍵相關切換
  elseif a_s_wp and key_repr == "space" and cand.type == "prediction" then

    --- 簡捷會止住翻頁
    engine:process_key(KeyEvent("Page_Down"))
    local g_c_t_update = context:get_commit_text()
    --- 上方「cand.type == "prediction"」已限定「g_c_t」不會為""！
    -- if loaded_candidate_count < 11 and g_c_t ~= "" and g_c_t == g_c_t_update then
    if loaded_candidate_count < 11 and g_c_t == g_c_t_update then
      -- engine:commit_text(g_c_t .. "test！")
      -- context:clear()
      context:confirm_current_selection()  -- 不能翻頁（只有一頁）時，space 改上屏。
    end
    return 1

    -- --- 以下可循環翻頁！(末頁會停頓！有提示效果！)(上頁後再下頁會有問題！)
    -- if env.n == loaded_candidate_count and env.n > 10 then
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- else
    --   env.n = loaded_candidate_count
    --   engine:process_key(KeyEvent("Page_Down"))
    --   -- local g_c_t_update = context:get_commit_text()
    --   -- if env.n < 11 and g_c_t == g_c_t_update then
    --   --   -- engine:commit_text(g_c_t .. "test！")
    --   --   -- context:clear()
    --   --   context:confirm_current_selection()
    --   -- end
    --   return 1
    -- end

    -- --- 以下可循環翻頁！〈一〉(末頁不會停頓！)（留給開頭選項不為""參考用）
    -- engine:process_key(KeyEvent("Page_Down"))  --會執行
    -- local g_c_t_update = context:get_commit_text()
    -- if loaded_candidate_count > 10 and g_c_t == g_c_t_update then
    --   -- engine:commit_text("test1「r」！")
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- else
    --   if g_c_t == g_c_t_update then
    --     -- engine:commit_text(g_c_t .. "test！")
    --     -- context:clear()
    --     context:confirm_current_selection()
    --   end
    --   return 1
    -- end

    -- --- 以下可循環翻頁！〈二〉(末頁不會停頓！)
    -- engine:process_key(KeyEvent("Page_Down"))  --會執行
    -- local g_c_t_update = context:get_commit_text()
    -- local s_s_i_update = seg.selected_index  -- 選中的 index
    -- local g_c_a_2_update = seg:get_candidate_at(s_s_i_update+1) or seg:get_candidate_at(s_s_i_update)  -- 第二候選項更新（最候選項+1會產生錯誤，故用「or」防止）
    -- -- --- 以下上頁後再下頁會有問題！
    -- -- local l_c_c_update = seg.menu:candidate_count()
    -- -- if loaded_candidate_count > 10 and loaded_candidate_count_update == loaded_candidate_count then
    -- --   -- engine:process_key(KeyEvent("Down"))
    -- --   context:refresh_non_confirmed_composition()
    -- --   return 1
    -- -- --- 以下有跳轉回首頁問題！
    -- -- if loaded_candidate_count > 10 and g_c_a_2.text == g_c_a_2_update.text then
    -- --   -- engine:commit_text("test2「r」！")
    -- --   context:refresh_non_confirmed_composition()
    -- --   return 1
    -- --- 以下完成版！
    -- if loaded_candidate_count > 10 and g_c_t == "" and g_c_a_2.text == g_c_a_2_update.text then
    --   -- engine:commit_text("test2「r」！")
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- elseif loaded_candidate_count > 10 and g_c_t ~= "" and g_c_t == g_c_t_update then
    --   -- engine:commit_text("test1「r」！")
    --   context:refresh_non_confirmed_composition()
    --   return 1
    -- else
    --   -- if g_c_t ~= "" and g_c_t == g_c_t_update then
    --   -- -- if loaded_candidate_count < 11 and g_c_t ~= "" and g_c_t == g_c_t_update then
    --   --   -- engine:commit_text(g_c_t .. "test！")
    --   --   -- context:clear()
    --   --   context:confirm_current_selection()
    --   -- end
    --   return 1
    -- end

--------------------------------------
--[[
使「space」和「return」直接出功能：空格和 enter 換行。
--]]

  elseif a_s_wp then
    return 2

  elseif not seg:has_tag("paging") then
    -- engine:commit_text(cand.type)
    -- engine:commit_text(" ")
    -- engine:process_key( KeyEvent("KP_Space") )
    -- engine:process_key( KeyEvent("Return") )
    engine:process_key( KeyEvent("Escape") )
    -- context:clear()  -- 消掉「選單」後，就無法再操作 Key 了？！釋放「2」也無法？！
    return 2

--------------------------------------

  -- elseif not seg:has_tag("paging") then
  --   engine:commit_text(cand.type)
  --   -- engine:commit_text(" ")
  --   -- engine:process_key( KeyEvent("KP_Space") )
  --   -- engine:process_key( KeyEvent("Return") )
  --   -- engine:process_key( KeyEvent("Escape") )
  --   context:clear()
  --   return 1

  -- elseif key_repr ~= "Return" and a_s_wp then
  --   return 2

  -- elseif c_input == "" then  -- and seg:has_tag("paging") and cand.type == "prediction"
  --   -- engine:commit_text(cand.type)
  --   engine:commit_text(cand.type)
  --   -- context:confirm_current_selection()
  --   return 1

--------------------------------------

  end

  return 2
end

-- return predictor_improve
return { func = processor }
-- return { init = init, func = processor }