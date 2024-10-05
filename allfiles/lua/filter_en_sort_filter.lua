--- @@ en_sort_filter
--[[
（easy_en_super）
如同英漢字典一樣排序，候選項重新排序。開關（en_sort）
--]]

----------------------------------------------------------------------------------------

-- local truncate_comment = require("filter_cand/truncate_comment")

-- local change_comment = require("filter_cand/change_comment")

local get_os_name = require("f_components/f_get_os_name")

local revise_comment_by_os = require("filter_cand/revise_comment_by_os")

----------------------------------------------------------------------------------------

-- local function revise_comment_by_os(os_name, cand, comment)
--   if os_name ~= 1 and os_name ~= 3 then
--   -- if os_name == 2 or os_name == 0 then
--   -- if os_name == 1 then  -- 測試用
--     local comment = string.gsub(truncate_comment(comment), "[\n%s]", "")  -- %s 為空白符
--     local cand = change_comment(cand, comment)
--   end
--   return cand
-- end


-- local M={}
local function init(env)
-- function M.init(env)
  local os_name = get_os_name() or ""
  env.os_name = os_name == "Mac" and 1
             or os_name == "Windows" and 2
             or os_name == "Linux" and 3
             or 4
end


-- function M.fini(env)
-- end


-- local function en_sort_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local en_sort = context:get_option("en_sort")
  -- local c_input = context.input  -- 原始未轉換輸入碼
  -- local caret_pos = context.caret_pos
  local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  local es = _end - start
  -- local prefix = env.engine.schema.config:get_string("easy_en/prefix")
  -- local input_n = string.len(c_input)

  if en_sort then

    if es < 3 then

      -- for cand in inp:iter() do
      --   cand.preedit = cand.preedit .. "\t（序排：二字母以下按個排）"  -- （序排：單字母按個排）
      --   local cand = revise_comment_by_os(env.os_name, cand, cand.comment)
      --   yield(cand)
      -- end
      -- -- yield(Candidate("simp_ensort", start, _end, c_input, "〔小於〕"))  -- 測試用

      local tran = Translation(revise_comment_by_os, env.os_name, inp) or inp
      for cand in tran:iter() do
        cand.preedit = cand.preedit .. "\t（序排：二字母以下按個排）"  -- （序排：單字母按個排）
        yield(cand)
      end
      -- tran = nil  -- 記憶體較易回退

    else

      local cands = {}
      local c = 1
      for cand in inp:iter() do  -- 封進 cands 中，供後面排序。
        --- 使用 table 的 size（效率較高）
        -- cands[#cands+1] = cand

        --- 使用計數器（秒數最短）
        cands[c] = cand
        c = c+1

        --- 原始（效率較低）
        -- table.insert(cands, cand)

        --- 以下用遍尋重組一個精簡 table，再排序，再新組 Candidate，還是太慢！且 comment 附加尚需解決。
        -- table.insert(cands, {text = cand.text, index = #cands})
        -- -- cand.preedit = '測試' .. cand:get_genuine().text .. cand.text ..'測試'
        -- yield(cand)
      end

      if (#cands ~= 0) then  -- 按字母順序進行排序。
        table.sort(cands, function(a, b) return a.text == b.text and string.len(a.text) < string.len(b.text) or a.text < b.text end)

        -- --- 以下用遍尋重組一個table，再排序，再新組 Candidate，還是太慢！
        -- -- table.sort(cands, function(a, b) return a.text == b.text and a.index < b.index or a.text < b.text end)  --Rime是按編碼長度排序,所以要重排

        -- --- ipairs 比 pairs 更快，效能更好。但 ipairs 遇不連續數組會中斷。
        -- --- pairs：迭代 table，可遍歷表中所有的 key 可以返回 nil。
        -- --- ipairs: 迭代數組，不能返回 nil,如果遇到 nil 則退出。
        -- for _, cand in ipairs(cands) do  -- 顯示
        --   cand.preedit = cand.preedit .. "\t（序排：a~z）"  -- （序排：ａ～ｚ）
        --   local cand = revise_comment_by_os(env.os_name, cand, cand.comment)
        --   yield(cand)

        --   --- 以下用遍尋重組一個精簡 table，再排序，再新組 Candidate，還是太慢！且 comment 附加尚需解決。
        --   -- newcand = Candidate("simp_ensort",0,caret_pos,cand.text," ")
        --   -- yield(newcand)
        -- end

        local tran = Translation(function() for _, cand in ipairs(cands) do yield(cand) end end)
        local tran = Translation(revise_comment_by_os, env.os_name, tran) or tran
        for cand in tran:iter() do
          cand.preedit = cand.preedit .. "\t（序排：a~z）"  -- （序排：ａ～ｚ）
          yield(cand)
        end
        -- --- 以下防止記憶體洩漏暴漲？！不會立即清理記憶體，但會回退，測試！
        -- -- local cands = {}  -- 理論上不對，這邊不應該加local，但實際又有效果？觀察！
        -- -- local cands = nil
        -- cands = nil  -- 記憶體較易回退
        -- tran = nil  -- 記憶體較易回退

        -- --- 以下執行清理記憶體
        -- -- if collectgarbage("count") > 3000 then
        -- --   collectgarbage("collect")
        -- -- end
        -- if collectgarbage("count") < 3000 then
        --   collectgarbage("step")
        -- else
        --   collectgarbage("collect")
        --   -- collectgarbage()
        -- end

      end

      -- --- 以下防止記憶體洩漏暴漲？！不會立即清理記憶體，但會回退，測試！
      -- cands = nil
      -- --- 以下執行清理記憶體
      -- -- if collectgarbage("count") > 3000 then
      -- --   collectgarbage("collect")
      -- -- end
      -- if collectgarbage("count") < 3000 then
      --     collectgarbage("step")
      -- else
      --     collectgarbage("collect")
      --     -- collectgarbage()
      -- end

    end

  elseif not en_sort then

    -- for cand in inp:iter() do
    --   -- cand.preedit = cand.preedit .. "\t　　　開始：" .. start .. "結束：" .. _end  -- 測試位置用
    --   cand.preedit = cand.preedit .. "\t（個排：字數）"  -- （個排：字母數）
    --   local cand = revise_comment_by_os(env.os_name, cand, cand.comment)
    --   yield(cand)
    -- end

    local tran = Translation(revise_comment_by_os, env.os_name, inp) or inp
    for cand in tran:iter() do
      cand.preedit = cand.preedit .. "\t（個排：字數）"  -- （個排：字母數）
      yield(cand)
    end
    -- tran = nil  -- 記憶體較易回退

  end

end




-- return en_sort_filter
-- return { func = filter }
return { init = init, func = filter }
-- return M
------------------------------------------------




--- 以下舊的寫法
--[[
-- local function en_sort_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local en_sort = context:get_option("en_sort")
  -- local c_input = context.input  -- 原始未轉換輸入碼
  -- local caret_pos = context.caret_pos
  local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  local es = _end-start
  -- local prefix = env.engine.schema.config:get_string("easy_en/prefix")
  -- local input_n = string.len(c_input)

  if en_sort then
    -- if prefix ~= nil then
    --   prefix_n = string.len(prefix)
    -- else
    --   prefix_n = 0
    -- end
    local cands = {}
    -- local u = {}
    -- local l = {}
    for cand in inp:iter() do
      table.insert(cands, cand)


      -- local en_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      -- local nnn = cand._end - cand.start
      -- local nnn = caret_pos - prefix_n
      -- local start = env.engine.context:get_preedit().sel_start
      -- local _end = env.engine.context:get_preedit().sel_end
      -- local nnn = _end - start
      -- if (not string.match(c_input, ' $' )) then  --空格避免注音掛接出現 Bug
      -- if (not string.match(c_input, ' $' )) and (not string.match(cand.text, ' ' )) then  --空格避免注音掛接出現 Bug
      -- if ((string.len(cand.text) >= nnn) and (not string.match(c_input, ' $' ))) then  --空格避免注音掛接出現 Bug
      -- if (string.match(cand.text, '%u' )) or ((string.len(cand.text) >= nnn) and (not string.match(c_input, ' $' ))) then  --空格避免注音掛接出現 Bug

        -- table.insert(cands, {text = cand.text , comment = cand.comment, index = #cands})
        -- table.insert(cands, {text = preedit.t .. cand.comment:sub(2), comment = cand.text, index = #cands})
        -- table.insert(cands, {text = cand.text , comment = cand.comment})

      -- elseif (string.match(cand.text, '%u' )) then
      -- -- elseif (string.match(cand.text, '%u' )) or (string.match(c_input, "'" )) then
      --   table.insert(u, cand)

      -- elseif (string.match(en_preedit, " " )) then  --放在注音掛接，可能會衝突？
      --   table.insert(u, cand)
      -- elseif (string.match(en_preedit, " [;']" )) then
      --   table.insert(u, cand)
      -- else
      --   table.insert(l, cand)
      -- end
    end


    if (#cands ~= 0) then
      table.sort(cands, function(a, b) return a.text == b.text and string.len(a.text) < string.len(b.text) or a.text < b.text end)

      -- table.sort(cands, function (a, b) return a.text:lower() == b.text:lower() and string.len(a.text:lower()) < string.len(b.text:lower()) or a.text:lower() < b.text:lower() end )
      -- table.sort(cands, function (a, b) return a.text:lower() == b.text:lower() and utf8.len(a.text) > utf8.len(b.text) or a.text:lower() < b.text:lower() end )
      -- table.sort(cands, function (a, b) return a.text:byte > b.text:byte end )
      -- table.sort(cands, function (a, b) return end )
      -- table.sort(cands.text)
      -- table.sort(cands)
      -- table.remove(cands, 2)  --不知為何前兩個選項會重複，刪除第二個選項（刪除第一個選項連打會有問題）。
    end
    -- if #cands ~=0 then
    --   table.sort(cands, function(a, b) return a.text:lower() == b.text:lower() and a.index < b.index or a.text:lower() < b.text:lower() end)  --Rime是按編碼長度排序,所以要重排
    --   table.insert(cands, {text = ""})
    --   prevcand.comment = cands[1].text:lower() ~= preedit.l and " " or ""
    -- end


    for _, cand in ipairs(cands) do
      yield(cand)
    end

    -- for k,v in pairs(cands) do
    --   yield(v)
    -- end
    -- for i, cand in ipairs(cands) do
    --   yield(Candidate("word", cand.start, cand._end, cand.text .. " ", cand.comment))
    -- end

    -- for _, cand in ipairs(u) do
    --   yield(cand)
    -- end

    -- for _, cand in ipairs(l) do
    --   yield(cand)
    -- end


  elseif not en_sort then
    for cand in inp:iter() do
      yield(cand)
    end
  end

end


-- return en_sort_filter
return { func = filter }
-- return M
--]]