--[[
快捷開啟（join/joint）檔案/程式/網址之運行程序。
--]]

----------------------------------------------------------------------------------------
local generic_open = require("p_components/p_generic_open")
local run_pattern = require("p_components/p_run_pattern")
----------------------------------------------------------------------------------------

-- local function run_open(engine, context, c_input, caret_pos, op_code, env_run_pattern, env_textdict, env_custom_phrase, oscmd)  -- 測試「engine:commit_text("cmd 程式碼")」用。
local function run_open(context, c_input, caret_pos, op_code, env_run_pattern, env_textdict, env_custom_phrase, oscmd)
  local run_in = run_pattern[ op_code ] -- 此處不能「.open」，如 op_code 不符合會報錯！
  if not op_code or not oscmd then  -- 確認 op_code、oscmd 不為 nil。
    return 1
  elseif #c_input ~= caret_pos then
    -- context:clear()
    return 1
  elseif op_code == "t" then
    context:clear()
    -- engine:commit_text( "TEST！！！" )  -- 測試用
    -- engine:commit_text(oscmd .. env_run_pattern)  -- 上屏 cmd 程式碼之內容！！！
    generic_open(env_run_pattern, oscmd)
    return 1
  elseif op_code == "c" then
    if env_textdict == "" then  -- 行列30無短語功能，但「c」還是設定不作用，不被下方自定義開啟影響。
      context:clear()
      return 1
      -- return 2
    else
      context:clear()
      -- engine:commit_text(oscmd .. env_custom_phrase)  -- 上屏 cmd 程式碼之內容！！！
      generic_open(env_custom_phrase, oscmd)
      return 1
    end
  elseif run_in ~= nil then  -- 要確定 run_in 不為 nil，才能加.open，不然會報錯！
  -- elseif run_in ~= nil and context:get_selected_candidate() ~= nil then  -- 後面判斷防未知觸發。
  -- elseif run_in ~= nil and g_c_t == "" then  -- 後面判斷防未知觸發。如果「run_pattern」條目缺「name」，「g_c_t」會是「preedit」，不為""。
    -- engine:commit_text(run_in)  -- 測試用
    -- engine:commit_text( generic_open(run_in.open, oscmd) )  -- 測試用
    context:clear()
    if run_in.open and run_in.name then  -- 確認 run_in.open、run_in.name 不為 nil。
      -- engine:commit_text(oscmd .. run_in.open)  -- 上屏 cmd 程式碼之內容！！！
      generic_open(run_in.open, oscmd)  -- 要確定 run_in 不為 nil，才能加.open，不然會報錯！
    -- else
    --   engine:commit_text("沒﹛open﹦﹜⚠️")  -- 測試用
    end
    return 1
  -- elseif env_textdict == "" then
  --   return 2
  -- elseif op_code == "c" then
  --   context:clear()
  --   generic_open(env_custom_phrase, oscmd)
  --   return 1
  else  -- 沒有該碼，空白鍵清空
    -- context:confirm_current_selection()
    context:clear()
    return 1
  end
end

return run_open
----------------------------------------------------------------------------------------
-- 以下備份原本程式碼（方案有短語 custom_phrase 用）
----------------------------------------------------------------------------------------
--[[
      local run_in = run_pattern[ op_code ] -- 此處不能「.open」，如 op_code 不符合會報錯！
      if not op_code then
        return 1
      elseif #c_input ~= caret_pos then
        -- context:clear()
        return 1
      elseif op_code == "t" then
        -- engine:commit_text( "TEST！！！" )  -- 測試用
        generic_open(env.run_pattern, oscmd)
        context:clear()
        return 1
      elseif op_code == "c" then
        if env.textdict == "" then
          context:clear()
          return 1
          -- return 2
        else
          generic_open(env.custom_phrase, oscmd)
          context:clear()
          return 1
        end
      elseif run_in ~= nil then
      -- elseif run_in ~= nil and context:get_selected_candidate() ~= nil then  -- 後面判斷防未知觸發。
      -- elseif run_in ~= nil and g_c_t == "" then  -- 後面判斷防未知觸發。如果「run_pattern」條目缺「name」，「g_c_t」會是「preedit」，不為""。
        -- engine:commit_text(run_in)  -- 測試用
        -- engine:commit_text( generic_open(run_in.open, oscmd) )  -- 測試用
        if run_in.open and run_in.name then
          generic_open(run_in.open, oscmd)  -- 要確定 run_in 不為 nil，才能加.open
        -- else
        --   engine:commit_text("沒﹛open﹦﹜⚠️")  -- 測試用
        end
        context:clear()
        return 1
      -- elseif env.textdict == "" then
      --   return 2
      -- elseif op_code == "c" then
      --   generic_open(env.custom_phrase, oscmd)
      --   context:clear()
      --   return 1
      else  -- 沒有該碼，空白鍵清空
        -- context:confirm_current_selection()
        context:clear()
        return 1
      end
--]]
----------------------------------------------------------------------------------------
-- 以下備份原本程式碼（原行列 30 用；方案沒有短語 custom_phrase 用）
----------------------------------------------------------------------------------------
--[[
      local run_in = run_pattern[ op_code ] -- 此處不能「.open」，如 op_code 不符合會報錯！
      if not op_code then
        return 1
      elseif #c_input ~= caret_pos then
        -- context:clear()
        return 1
      elseif op_code == "t" then
        -- engine:commit_text( "TEST！！！" )  -- 測試用
        generic_open(env.run_pattern, oscmd)
        context:clear()
        return 1
      elseif op_code == "c" then
        context:clear()
        return 1  -- 行列30無短語功能，但「c」還是設定不作用，不被下方自定義開啟影響。
        -- if env.textdict == "" then
        --   context:clear()
        --   return 1
        --   -- return 2
        -- else
        --   generic_open(env.custom_phrase, oscmd)
        --   context:clear()
        --   return 1
        -- end
      elseif run_in ~= nil then
      -- elseif run_in ~= nil and context:get_selected_candidate() ~= nil then  -- 後面判斷防未知觸發。
      -- elseif run_in ~= nil and g_c_t == "" then  -- 後面判斷防未知觸發。如果「run_pattern」條目缺「name」，「g_c_t」會是「preedit」，不為""。
        -- engine:commit_text(run_in)  -- 測試用
        -- engine:commit_text( generic_open(run_in.open, oscmd) )  -- 測試用
        if run_in.open and run_in.name then
          generic_open(run_in.open, oscmd)  -- 要確定 run_in 不為 nil，才能加.open
        -- else
        --   engine:commit_text("沒﹛open﹦﹜⚠️")  -- 測試用
        end
        context:clear()
        return 1
      -- elseif env.textdict == "" then
      --   return 2
      -- elseif op_code == "c" then
      --   generic_open(env.custom_phrase, oscmd)
      --   context:clear()
      --   return 1
      else  -- 沒有該碼，空白鍵清空
        -- context:confirm_current_selection()
        context:clear()
        return 1
      end
--]]
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------