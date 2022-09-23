--- @@ mix30_nil_comment_up_filter
--[[
（onion-array30）
合併 array30_nil_filter 和 array30_comment_filter 和 array30_spaceup_filter，三個 lua filter 太耗效能。
--]]
local function mix30_nil_comment_up_filter(input, env)
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  local s_up = env.engine.context:get_option("1_2_straight_up")
  local find_prefix = env.engine.context.input  -- 原始未轉換輸入碼
  local _end = env.engine.context:get_preedit().sel_end
  if (not s_c_f_p_s) then
  -- if (not s_c_f_p_s) or (string.find(find_prefix, "`" )) then
    for cand in input:iter() do
      -- local find_prefix = env.engine.context.input  -- 原始未轉換輸入碼
      local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      local array30_nil_cand = Candidate("array30nil", 0, _end, "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      -- local array30_nil_cand = Candidate("array30nil", 0, string.len(find_prefix) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      if (string.find(cand.text, '^⎔%d$' )) then
        array30_nil_cand.preedit = array30_preedit
        yield(array30_nil_cand)
      else
        if (s_up) then
          if (string.find(find_prefix, "^[a-z,./;][a-z,./;]? $" )) and (not string.find(cand.comment, '▪' )) then
            yield(cand)
          -- elseif (string.find(find_prefix, "^www%..*$")) then
          --   yield(cand)
          elseif (string.find(find_prefix, "^[a-z.,/;][a-z.,/;]?[a-z.,/;']?[a-z.,/;']?[i']?$" )) or (string.find(find_prefix, "^a[k,] $" )) or (string.find(find_prefix, "^lr $" )) or (string.find(find_prefix, "^ol $" )) or (string.find(find_prefix, "^q[ka] $" )) or (string.find(find_prefix, "^%.b $" )) or (string.find(find_prefix, "^/%. $" )) or (string.find(find_prefix, "^pe $" )) then
            yield(cand)
          elseif (string.find(find_prefix, "^sf $" )) and (string.find(cand.text, '毋' )) then
            yield(cand)
          elseif (string.find(find_prefix, "^lb $" )) and (string.find(cand.text, '及' )) then
            yield(cand)
          elseif (string.find(find_prefix, "^ou $" )) and (string.find(cand.text, '○' )) then
            yield(cand)
          -- elseif (string.find(find_prefix, "`.*$" )) or (string.find(find_prefix, "^w[0-9]$" ))  or (string.find(find_prefix, "^[a-z][-_.0-9a-z]*@.*$" )) or (string.find(find_prefix, "^(www[.]|https?:|ftp:|mailto:|file:).*$" )) then
          --   yield(cand)
          end
        elseif (not s_up) then
          yield(cand)
        end
      end
    end
  else
    for cand in input:iter() do
      -- local find_prefix = env.engine.context.input  -- 原始未轉換輸入碼
      local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      local array30_nil_cand = Candidate("array30nil", 0, _end, "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      -- local array30_nil_cand = Candidate("array30nil", 0, string.len(find_prefix) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      if (string.find(cand.text, '^⎔%d$' )) then
        array30_nil_cand.preedit = array30_preedit
        yield(array30_nil_cand)
      else
        if (s_up) then
          if (string.find(find_prefix, "^[a-z,./;][a-z,./;]? $" )) and (not string.find(cand.comment, '▪' )) then
            cand:get_genuine().comment = ""
            yield(cand)
          -- elseif (string.find(find_prefix, "^www%..*$")) then
          --   yield(cand)
          elseif (string.find(find_prefix, "^[a-z.,/;][a-z.,/;]?[a-z.,/;']?[a-z.,/;']?[i']?$" )) or (string.find(find_prefix, "^a[k,] $" )) or (string.find(find_prefix, "^lr $" )) or (string.find(find_prefix, "^ol $" )) or (string.find(find_prefix, "^q[ka] $" )) or (string.find(find_prefix, "^%.b $" )) or (string.find(find_prefix, "^/%. $" )) or (string.find(find_prefix, "^pe $" )) then
            cand:get_genuine().comment = ""
            yield(cand)
          elseif (string.find(find_prefix, "^sf $" )) and (string.find(cand.text, '毋' )) then
            cand:get_genuine().comment = ""
            yield(cand)
          elseif (string.find(find_prefix, "^lb $" )) and (string.find(cand.text, '及' )) then
            cand:get_genuine().comment = ""
            yield(cand)
          elseif (string.find(find_prefix, "^ou $" )) and (string.find(cand.text, '○' )) then
            cand:get_genuine().comment = ""
            yield(cand)
          -- elseif (string.find(find_prefix, "`.*$" )) or (string.find(find_prefix, "^w[0-9]$" ))  or (string.find(find_prefix, "^[a-z][-_.0-9a-z]*@.*$" )) or (string.find(find_prefix, "^(www[.]|https?:|ftp:|mailto:|file:).*$" )) then
          --   yield(cand)
          end
        elseif (not s_up) then
          cand:get_genuine().comment = ""
          yield(cand)
        end
      end
    end
  end
end

return mix30_nil_comment_up_filter