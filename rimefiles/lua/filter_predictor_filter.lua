--- @@ predictor_filter
--[[
（onion-array30 和 onion-array10）
改進預測詞 predictor 用
預測詞第一候選生成一個空選項，好快速明顯的關閉預測詞。
--]]




-- local M={}
local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  env.schema_s_k = config:get_string("menu/alternative_select_keys") or ""
  env.schema_p_s = config:get_string("menu/page_size") or 10
end

-- local function fini(env)  --只在切換方案時影響？？？和 init 相對？
-- -- function M.fini(env)
--   local engine = env.engine
--   local schema = engine.schema
--   schema.select_keys = env.schema_s_k
-- end

-- local function tags_match(seg, env)
--   local engine = env.engine
--   local context = engine.context
--   local pd = context:get_option("prediction")
--   seg_pd = seg:has_tag("prediction")  -- 這邊 return 後不好用此限定，因 select_keys 變過去，需要變回來。
--   return pd
-- end

-- local function predictor_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp, env)
  local engine = env.engine
  local context = engine.context
  local schema = engine.schema
  -- local c_input = context.input  -- 原始未轉換輸入碼
  local comp = context.composition
  local seg = comp:back()
  local seg_pd = seg:has_tag("prediction")

  --- 注意！因轉換方案時，會沿用上個方案「prediction」變換後之「select_keys」。
  --- 注意！「prediction」關閉，也會發生同樣「select_keys」問題。

  -- if c_input ~= "" then
  if not seg_pd then
    if schema.select_keys ~= env.schema_s_k then
      schema.select_keys = env.schema_s_k  --"1234567890"
    end
    for cand in inp:iter() do
      yield(cand)
    end
  else
    --- 以下「schema.select_keys」之用「" "」，空白會被誤認為變選字鍵，需用「processor」處理校正。
    --- 以下「" "」不能換成非鍵盤上的符號，如「" "」，會不能數字選字！
    if schema.select_keys ~= " " .. env.schema_s_k then
      schema.select_keys = " " .. env.schema_s_k  --" 1234567890"
    end
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
return { init = init, func = filter }
-- return { init = init, func = filter, tags_match = tags_match }
-- return { init = init, func = filter, tags_match = tags_match, fini = fini }
-- return M
----------------