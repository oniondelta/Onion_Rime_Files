--- @@ seg_test_filter
--[[
測試 lua 更動 segmentor/tag 名稱是否作用
--]]


-- local M={}
local function init(env)
-- function M.init(env)
  env.namespace1 = "reverse2_lookup"
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  -- env.prefix = config:get_string(env.namespace1 .. "/prefix") or ""
  env.pattern = config:get_string("recognizer/patterns/" .. env.namespace1) or ""
  -- env.pattern = string.gsub(env.pattern, "^.*" .. env.prefix, "")  -- 去除開頭如：(?<!=)，lua 無法運行之正則。
end

-- function M.fini(env)
-- end

local function tags_match(seg, env)
-- function M.tags_match(seg, env)
  local engine = env.engine
  local context = engine.context
  local seg_tag = seg:has_tag(env.namespace1)
  -- local seg_tag = seg:has_tag("test_seg_name")
  -- local seg_tag = seg:has_tag("all_bpm")
  -- local seg_tag = seg:has_tag("reverse2_lookup")
  -- local seg_tag = seg:has_tag("reverse3_lookup")
  return seg_tag
end


local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  -- local c_input = context.input
  local composition = context.composition
  local seg = composition:back()

  -- local cand_test = Candidate("test", 0, 2, "檢驗 segmentor/tag 名稱", "〔‹seg:has_tag›: " .. env.namespace1 .. " 正則〕")
  -- local cand_test = Candidate("test", 0, seg._end, "檢驗 segmentor/tag 名稱", "〔‹seg:has_tag›: " .. env.namespace1 .. " 正則〕")
  -- local cand_test = Candidate("test", seg.start, seg._end, "檢驗 segmentor/tag 名稱", "〔‹seg:has_tag›: " .. env.namespace1 .. " 正則〕")
  local cand_test = Candidate("seg_test", seg.start, seg._end, env.pattern, "〔‹seg:has_tag›: " .. env.namespace1 .. " 之正則〕")
  yield(cand_test)

  --- 以下於完全沒有選字單時，會 iter() 不出東西，因此不會置換成想要的「cand_test」，故不要拿來測試「segmentor/tag」名稱！
  for cand in inp:iter() do
    -- yield(cand_test)
    yield(cand)
  end

end


return { init = init, func = filter, tags_match = tags_match }
-- return M