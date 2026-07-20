--- @@ filter_predictor_s_filter
--[[
（onion-array10-and-bpmf）
改進預測詞 predictor 用
預測詞第一候選生成一個空選項，好快速明顯的關閉預測詞。
--]]




-- local M={}
local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  env.schema_p_s = config:get_string("menu/page_size") or 10
end

-- local function fini(env)
-- -- function M.fini(env)
-- end

local function tags_match(seg, env)
  seg_pd = seg:has_tag("prediction")
  return seg_pd
end

-- local function predictor_s_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp, env)
  local engine = env.engine
  -- local context = engine.context
  local schema = engine.schema
  -- local c_input = context.input  -- 原始未轉換輸入碼
  -- local comp = context.composition
  -- local seg = comp:back()
  -- local seg_pd = seg:has_tag("prediction")

  -- if c_input ~= "" then
  if not seg_pd then
    for cand in inp:iter() do
      yield(cand)
    end
  else
    local n = 1
    local p_s = env.schema_p_s-1
    for cand in inp:iter() do
      local nr = n%p_s --9
      if nr == 1 and cand.type == "prediction" then
        -- local first_cand = Candidate("prediction_first", seg.start, seg._end, "", "《預測詞》")
        local first_cand = Candidate("prediction_first", 0, 0, "", "《預測詞》")
        yield(first_cand)
      end
      n = n+1 --不能有 local
      yield(cand)
    end
  end

end


----------------
-- return predictor_filter
-- return { init = init, func = filter }
return { init = init, func = filter, tags_match = tags_match }
-- return { init = init, func = filter, tags_match = tags_match, fini = fini }
-- return M
----------------