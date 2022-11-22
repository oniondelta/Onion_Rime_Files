--- @@ en_sort_filter
--[[
（easy_en_super）
如同英漢字典一樣排序，候選項重新排序。開關（en_sort）
--]]
local function en_sort_filter(input, env)
  local en_sort = env.engine.context:get_option("en_sort")
  local input_in = env.engine.context.input  -- 原始未轉換輸入碼
  -- local prefix = env.engine.schema.config:get_string("easy_en/prefix")
  -- local input_n = string.len(input_in)
  -- local caret_pos = env.engine.context.caret_pos

  if (en_sort) then
    -- if prefix ~= nil then
    --   prefix_n = string.len(prefix)
    -- else
    --   prefix_n = 0
    -- end
    local cands = {}
    local u = {}
    -- local l = {}
    for cand in input:iter() do
      -- local en_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      -- local nnn = cand._end - cand.start
      -- local nnn = caret_pos - prefix_n
      local start = env.engine.context:get_preedit().sel_start
      local _end = env.engine.context:get_preedit().sel_end
      local nnn = _end - start
      if ((string.len(cand.text) >= nnn) and (not string.find(input_in, ' $' ))) then  --空格避免注音掛接出現 Bug
      -- if (string.find(cand.text, '%u' )) or ((string.len(cand.text) >= nnn) and (not string.find(input_in, ' $' ))) then  --空格避免注音掛接出現 Bug
        table.insert(cands, cand)
        -- table.insert(cands, {text = cand.text , comment = cand.comment, index = #cands})
        -- table.insert(cands, {text = preedit.t .. cand.comment:sub(2), comment = cand.text, index = #cands})
        -- table.insert(cands, {text = cand.text , comment = cand.comment})

      elseif (string.find(cand.text, '%u' )) then
      -- elseif (string.find(cand.text, '%u' )) or (string.find(input_in, "'" )) then
        table.insert(u, cand)

      -- elseif (string.find(en_preedit, " " )) then  --放在注音掛接，可能會衝突？
      --   table.insert(u, cand)
      -- elseif (string.find(en_preedit, " [;']" )) then
      --   table.insert(u, cand)
      -- else
      --   table.insert(l, cand)
      end
    end

    if #cands ~=0 then
      table.sort(cands, function (a, b) return a.text == b.text and string.len(a.text) < string.len(b.text) or a.text < b.text end )
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

    for _, cand in ipairs(u) do
      yield(cand)
    end

    -- for _, cand in ipairs(l) do
    --   yield(cand)
    -- end

  elseif (not en_sort) then
    for cand in input:iter() do
      yield(cand)
    end
  end

end

return en_sort_filter