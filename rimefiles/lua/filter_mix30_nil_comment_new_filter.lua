--- @@ mix30_nil_comment_new_filter
--[[
（onion-array30）
合併 array30_nil_filter 和 array30_comment_filter，二個 lua filter。
--]]




--- 以下新的寫法

----------------

local change_comment = require("filter_cand/change_comment")
local change_preedit = require("filter_cand/change_preedit")

----------------
-- local M={}
-- local function init(env)
-- function M.init(env)
-- end

-- function M.fini(env)
-- end

-- local function mix30_nil_comment_new_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp, env)
  local engine = env.engine
  local context = engine.context
  local s_c_f_p_s = context:get_option("simplify_comment")
  local c_input = context.input  -- 原始未轉換輸入碼
  -- local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  local array30_nil_cand = Candidate("simp_mix30nil", 0, _end, "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len("⎔")等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
  -- local array30_nil_cand = Candidate("simp_mix30nil", 0, string.len(c_input) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len("⎔")等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
  local check_i_end = string.match(c_input, "[ ']$")  -- 已在方案用 tags: [ abc ] 限定，不會影響其他掛載方案。
  -- local check_i_end = string.match(c_input, "[a-z,./;][ ']$")
  local check_www = string.match(c_input, "^www[.]" )  -- 直接判別 comment 即可

  for cand in inp:iter() do

    if string.match(cand.text, "^⎔%d$" ) then
      yield(change_preedit(array30_nil_cand, cand.preedit))
      goto nil_label
    elseif check_www then
    -- elseif #c_input>3 then
      if cand.comment == "〔URL〕" then
        yield(cand)
        -- yield(change_comment(cand,"測試用"))
        goto nil_label
      else
        goto normal_label
      end
    else
      goto normal_label
    end

    -- ---- 以下先以輸入字數評判來處理，但在符號 w[0-9] 後接行列30字碼，"^⎔%d$"會無法作用。
    -- if #c_input<3 then
    --   if string.match(cand.text, "^⎔%d$" ) then
    --     yield(change_preedit(array30_nil_cand, cand.preedit))
    --     goto nil_label
    --   else
    --     goto normal_label
    --   end
    -- elseif #c_input>3 then
    --   if check_www then
    --     if cand.comment == "〔URL〕" then
    --       yield(cand)
    --       goto nil_label
    --     else
    --       goto normal_label
    --     end
    --   else
    --     goto normal_label
    --   end
    -- end

    -- if #c_input<3 and string.match(cand.text, "^⎔%d$" ) then
    --   yield(change_preedit(array30_nil_cand, cand.preedit))
    -- -- if string.match(cand.text, "^⎔%d$" ) then
    -- --   -- local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
    -- --   -- array30_nil_cand.preedit = array30_preedit
    -- --   array30_nil_cand.preedit = cand.preedit
    -- --   yield(array30_nil_cand)
    -- elseif #c_input>3 and cand.comment == "〔URL〕" then
    -- -- elseif string.match(cand.comment, "〔URL〕" ) then
    -- -- elseif check_www and string.match(cand.comment, "〔URL〕" ) then  -- 直接判別 comment 即可
    --   yield(cand)

    ::normal_label::

    if check_i_end then
      local cand = change_preedit(cand, cand.text)
      yield( s_c_f_p_s and change_comment(cand,"") or cand )
    else
      yield( s_c_f_p_s and change_comment(cand,"") or cand )
    end

    ::nil_label::

    -- end
  end

end
----------------
-- return mix30_nil_comment_new_filter
return { func = filter }
-- return M
----------------
