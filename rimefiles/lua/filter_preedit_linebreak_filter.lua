--- @@ preedit_linebreak_filter
--[[
（bo_mixin 全系列）
注音 mixin 方案選字後，「英文」和「注音」之 preedit 無法對齊，開頭換行修改之。
後來修改不限定於注音「abc」之下，掛接方案也換行。
--]]

----------------
local change_preedit = require("filter_cand/change_preedit")
----------------

local function tags_match(seg, env)
  local engine = env.engine
  local context = engine.context
  local start = context:get_preedit().sel_start
  local seg_punct = seg:has_tag("punct")
  -- local seg_abc = seg:has_tag("abc")
  -- return seg_abc and start > 0  -- 限定在注音（abc）時。
  -- return seg.start > 0  -- 掛接方案開頭會換行，有bug！
  -- return start > 0
  return start > 0 and not seg_punct
end

local function filter(inp, env)
  -- --- 以下三行測試用
  -- local engine = env.engine
  -- local context = engine.context
  -- local start = context:get_preedit().sel_start
  for cand in inp:iter() do
    local new_preedit = string.gsub(cand.preedit,  "^", "\n")
    yield(change_preedit(cand,new_preedit))
  end
end


return { func = filter, tags_match = tags_match }