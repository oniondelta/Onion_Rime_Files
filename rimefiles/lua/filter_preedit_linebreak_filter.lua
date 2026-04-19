--- @@ preedit_linebreak_filter
--[[
（bo_mixin 全系列）
注音 mixin 方案選字後，「英文」和「注音」之 preedit 無法對齊，開頭換行修改之。
後來修改不限定於注音「abc」之下，掛接方案也換行。
--]]

----------------

-- local change_comment = require("filter_cand/change_comment")
local change_preedit = require("filter_cand/change_preedit")

----------------

local function tags_match(seg, env)
  local engine = env.engine
  local context = engine.context
  local p_start = context:get_preedit().sel_start  -- 不使用「seg.start」，因開頭掛接方案不需換行。
  local seg_punct = seg:has_tag("punct")  -- mix_cf2_miss_filter 有全域變數，seg_punct 會透出，但限定在 abc 和 punct 範圍，emoji_series 範圍會出錯。此條目關閉，seg_punct 範圍還是有作用，但這邊不能關閉，「`」相關會有bug。
  -- local seg_abc = seg:has_tag("abc")
  -- return seg_abc and p_start > 0  -- 限定在注音（abc）時。
  return p_start > 0 and not seg_punct  -- 排除後接 punct 標點符號時。
  -- return p_start > 0  -- 符號兩碼（例：「=!」）以上，preedit 會換行，但輸入碼顯示會消失。
  -- return seg.start > 0  -- 掛接方案開頭會換行成空行，有bug！
  -- return not seg_punct  -- 檢視測試用，使之不換行下，也能查看數據用。
end

local function filter(inp, env)
  -- ---- 以下檢視測試用
  -- local engine = env.engine
  -- local context = engine.context
  -- -- 以下測試「游標」位置。
  -- local caret_pos = context.caret_pos
  -- -- 以下測試「seg」參數。
  -- local comp = context.composition
  -- local seg = comp:back()
  -- -- 以下測試「preedit」選擇位置參數。
  -- -- 備註：「.sel_start」為 preedit 上的字元數（一個漢字為3）；「.start」或「._start」為 原始輸入「context.input」的位置數。
  -- local p_start = context:get_preedit().sel_start
  -- local p_end = context:get_preedit().sel_end
  -- -- 以下測試「segmentation」參數，注意！非「Segment」和上方「tags_match」中的「seg」。
  -- local segmentation = comp:toSegmentation()
  -- local segt_input = segmentation.input
  -- local segt_length = segmentation:get_current_segment_length()
  -- local confirmed_pos = segmentation:get_confirmed_position()
  -- local start_pos = segmentation:get_current_start_position()
  -- local end_pos = segmentation:get_current_end_position()
  -- --
  -- for cand in inp:iter() do
  --   local test_cand = cand
  --   local new_preedit = string.gsub(test_cand.preedit, "^", "\n")
  --   local test_cand = change_preedit(test_cand, new_preedit)
  --   local test_cand = change_comment(test_cand, "‖caret_pos: " .. caret_pos .. "‖.sel_start: " .. p_start .. "  .sel_end: " .. p_end .. "‖seg._start: " .. seg._start .. "  seg._end: " .. seg._end .. "‖cand._start: " .. test_cand._start .. "  cand._end: " .. test_cand._end .. "‖ （segt_i: " .. segt_input .. "‖segt_l: " .. segt_length .. " ‖segt_cp: " .. confirmed_pos .. " |segt_sp: " .. start_pos .. "  segt_ep: " .. end_pos .. "）")
  --   yield(test_cand)
  -- end
  -- ---- 檢視測試結束處
  for cand in inp:iter() do
    local new_preedit = string.gsub(cand.preedit, "^", "\n")
    yield( change_preedit(cand, new_preedit) )
  end
end


return { func = filter, tags_match = tags_match }