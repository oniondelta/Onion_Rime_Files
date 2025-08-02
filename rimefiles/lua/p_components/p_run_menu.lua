--[[
快捷開啟（join/joint）檔案/程式/網址列表生成選單。
--]]

local function run_menu(pattern)
  -- keys_table 不能放在 run_menu() 外，開啟其他檔案後，選單會亂掉
  local keys_table = {
      { "⓿", "※ 限起始輸入英文 [a-z]+  " }
    , { "❶", "※ 編輯後須「重新部署」生效  " }
    , { "❷", "═════ 預設 ═════  " }  --════════════  
    , { "❸", "  ~t  〔 編輯 快捷開啟 table 〕" }
    , { "❹", "  ~c  〔 編輯 custom 短語 〕" }
    , { "❺", "═════ 自訂 ═════  " }  --────────────  
    , { "❻", "" }
    , { "❼", "" }
    , { "❽", "" }
    , { "❾", "" }
    , { "❿", "" }
    , { "⓫", "" }
    , { "⓬", "" }
    , { "⓭", "" }
    , { "⓮", "" }
    , { "⓯", "" }
    , { "⓰", "" }
    , { "⓱", "" }
    , { "⓲", "" }
    , { "⓳", "" }
    , { "⓴", "" }
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
  local n_insert = 1  -- 插入條目數（-1也為空條目數）
  local f = 0  -- 檢驗是否末尾
  for k, v in ipairs(keys_table) do
    if v[2] == "" and n_insert < 16 and f == 0 then
    -- if v[2] == "" and f == 0 then
      if insert_table[n_insert] ~= nil then
        v[2] = "  ~" .. insert_table[n_insert][1] .. "  〔 " .. insert_table[n_insert][2] .. " 〕"
        n_insert = n_insert+1
      elseif insert_table[n_insert] == nil then
        v[2] = end_mark
        f = f+1
      end
    elseif v[2] == "" then  -- 繼續計算空條目(n_insert-1)，後面有用到。
      n_insert = n_insert+1
      -- v[2] = n_insert  -- 測試顯示用
    end
  end

  local n_empty = n_insert-1  -- n_empty：預設為 15
  if #insert_table == n_empty and keys_table[21] ~= nil then
    if keys_table[21][2] ~= end_mark then
      table.insert(keys_table, {"21", end_mark})
    end
  elseif #insert_table > n_empty then
    local n_all = 22  -- 總條目數
    for k, v in ipairs(insert_table) do
      if k > n_empty then
        local comment = v[1]== "t" and "  ~" .. v[1] .. "  〔 撞碼預設：編輯 快捷開啟 table ⚠️ 〕" or
                        v[1]== "c" and "  ~" .. v[1] .. "  〔 撞碼預設：編輯 custom 短語 ⚠️ 〕" or
                                       "  ~" .. v[1] .. "  〔 " .. v[2] .. " 〕"
        table.insert(keys_table, {n_all-1, comment})
       -- keys_table[n_all] = {n_all-1, comment}
        n_all=n_all+1
      end
    end
    table.insert(keys_table, {n_all-1, end_mark})
  end

  return keys_table
end

return run_menu