--- @@ kr_hnc_1m_filter
--[[
（hangeul_hnc）
韓語遮屏只剩一個選項。開關（kr_1m）
--]]

-- local M={}
-- local function init(env)
-- function M.init(env)
-- end

-- function M.fini(env)
-- end

-- local function kr_hnc_1m_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local kr_1m = context:get_option("kr_1m")
  local c_input = context.input  -- 原始未轉換輸入碼
  -- local special_key_v = string.match(c_input, "[v;]$")
  -- local special_key_qq = string.match(c_input, "qq$")
  -- local special_key_slash = string.match(c_input, "//$")
  local special_key = string.match(c_input, "[v;]$") or
                      string.match(c_input, "qq$") or
                      string.match(c_input, "//$")

  -- local han_key = string.match(c_input, ";$")
  -- local han_key = string.match(c_input, ";")
  -- local prefix = env.engine.schema.config:get_string("easy_en/prefix")
  -- local input_n = string.len(c_input)
  -- local caret_pos = env.engine.context.caret_pos

  local cands = {}
  for cand in inp:iter() do
    -- local kr_preedit = cand.preedit
    -- local special_key = string.match(kr_preedit, "[›]$")
    -- local han_key = string.match(kr_preedit, "；$")
    -- if kr_1m and not special_key_v and not special_key_qq and not special_key_slash then
    if kr_1m and not special_key then
      -- table.insert(cands, cand)
      yield(cand)
      return
      -- yield(cands[1])
  -- elseif (kr_1m) then
  --   local cands = {}
  --   for cand in inp:iter() do
  --     table.insert(cands, cand)
  --   end
  --   yield(cands[1])
    else
      yield(cand)
    end
  end

  -- if kr_1m and cands[1] then
  --   -- if not special_key_v and not special_key_qq and not special_key_slash then
  --   if not special_key then
  --     yield(cands[1])
  --   end
  -- end

end

-- return kr_hnc_1m_filter
return { func = filter }
-- return M