--[[
快捷開啟（join/joint）檔案/程式/網址列表生成選單。
（選單選擇就直開，搭配「processor_mix_apc_s2rm_ltk_menu.lua」施行，尚有問題，實驗性質！）
--]]

local function run_menu_s(pattern)
  -- keys_table 不能放在 run_menu() 外，開啟其他檔案後，選單會亂掉
  local keys_table = {
      { "   ", "※ 限起始輸入英文 [a-z]+  " }
    , { "　", "※ 編輯後須「重新部署」生效  " }
    , { "    ", "═════ 預設 ═════" }  --════════════  
    , { "  【 編輯 快捷開啟 table 】", "  ~t  " }
    , { "  【 編輯 custom 短語 】", "  ~c  " }
    , { " 　", "═════ 自訂 ═════" }  --────────────  
    -- , { "❻", "" }
    -- , { "❼", "" }
    -- , { "❽", "" }
    -- , { "❾", "" }
    -- , { "❿", "" }
    -- , { "⓫", "" }
    -- , { "⓬", "" }
    -- , { "⓭", "" }
    -- , { "⓮", "" }
    -- , { "⓯", "" }
    -- , { "⓰", "" }
    -- , { "⓱", "" }
    -- , { "⓲", "" }
    -- , { "⓳", "" }
    -- , { "⓴", "" }
    }

  local insert_table = {}
  for i, v in pairs(pattern) do
    local name = v.name or "NONAME：無法開啟 🛑"  -- 防疏漏
    local s = tonumber(v.s) and v.s or 100  -- 防疏漏
    insert_table[#insert_table + 1] = {i, name, s}
  end
  -- i (開啟碼)排序：a[1]<b[1]； v.name (名稱)排序：a[2]<b[2]； v.s (指定)排序：a[3]<b[3]。
  -- 以(指定)排序 v.s (a[3]<b[3])優先比較，如 v.s (a[3]==b[3])一樣，比 i (開啟碼)。
  table.sort(insert_table, function(a,b) return (a[3]==b[3] and a[1]<b[1] or a[3]<b[3]) end)

  local end_mark = "═══  結束  ═══  "
  for k, v in ipairs(insert_table) do
    local comment = "  ~" .. v[1] .. "  "
    local j_item = v[1]== "t" and "  【 撞碼預設：編輯 快捷開啟 table ⚠️ 】" or
                   v[1]== "c" and "  【 撞碼預設：編輯 custom 短語 ⚠️ 】" or
                                  "  【 " .. v[2] .. " 】"
    table.insert(keys_table, {j_item, comment})
  end
  table.insert(keys_table, {" ", end_mark})

  return keys_table
end

return run_menu_s