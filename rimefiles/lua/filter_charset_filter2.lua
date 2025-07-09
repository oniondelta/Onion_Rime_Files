--- @@ charset_filter2
--[[
（ocm_onionmix）（手機全方案會用到）
把 opencc 轉換成「᰼」(或某個符號)，再用 lua 功能去除「᰼」
--]]


-- charset2 = {
--  ["Deletesymbol"] = { first = 0x1C3C } }

-- function exists2(single_filter2, text)
--   for i in utf8.codes(text) do
--    local c = utf8.codepoint(text, i)
--    if (not single_filter2(c)) then
--   return false
--    end
--   end
--   return true
-- end

-- function is_charset2(s)
--  return function (c)
--     return c == charset2[s].first
--  end
-- end

-- function is_symbol_ext(c)
--  return is_charset2("Deletesymbol")(c)
-- end

-- function charset_filter2(input)
--  for cand in input:iter() do
--     if (not exists2(is_symbol_ext, cand.text))
--     then
--     yield(cand)
--     end
--  end
-- end




--- 以下新的寫法

----------------

local drop_cand = require("filter_cand/drop_cand")

----------------
-- local M={}
-- local function init(env)
-- function M.init(env)
-- end

-- function M.fini(env)
-- end

-- local function charset_filter2(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local c_f2_s = context:get_option("character_range_bhjm")
  local tran = c_f2_s and Translation(drop_cand, inp, "᰼᰼") or inp
  for cand in tran:iter() do
    yield(cand)
  end
end
----------------
-- return charset_filter2
return { func = filter }
-- return M

-- return { charset_filter2 = charset_filter2 }

----------------





--- 以下舊的寫法
--[[
local function charset_filter2(input, env)
-- local function filter2(input, env)
  local c_f2_s = env.engine.context:get_option("character_range_bhjm")
  if c_f2_s then
    for cand in input:iter() do
      if not string.match(cand.text, "᰼᰼" ) then
      -- if not string.match(cand.text, ".*᰼᰼.*" ) then
        yield(cand)
      end
    end
  else
    for cand in input:iter() do
      yield(cand)
    end
    -- if input == nil then
    --   cand = nil
    -- end
  end
  -- return nil
end

return { charset_filter2 = charset_filter2 }
-- return filter2
--]]