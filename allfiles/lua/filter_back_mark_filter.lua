--- @@ back_mark_filter
--[[
（dif、1bopomo_onion_double、bopomo_onionplus 和 bo_mixin 全系列）
不直接用 opencc 去 comment，改 lua 間接 comment，防「兩個字符」以上無法標注，和一個字串被多個標注。
--]]




----------------

-- local drop_cand = require("filter_cand/drop_cand")
local change_comment = require("filter_cand/change_comment")

--------------
----------------
local function xform_mark(inp)
  if inp == "" or nil then return "" end
  inp = string.gsub(inp, "@@+", "") --@@@@
  inp = string.gsub(inp, "@", " ")
  return inp
end
----------------
-- local M={}
local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local opencc_js = config:get_string(env.name_space .. "/opencc_config") or "back_mark.json"
  env.option_n = config:get_string(env.name_space .. "/option_name") or "back_mark"
  -- env.bm_opencc = Opencc("back_mark.json") or {''}
  env.bm_opencc = Opencc(opencc_js) or {''}
end

-- local function fini(env)
-- -- function M.fini(env)
--   env.bm_opencc = nil  -- 可能會記憶體洩漏？！故加此兩條。
--   collectgarbage('collect')
-- end

-- --- 方案內 tags 限定和 tags_match，只能選一個，否則只有 tags_match 會作用。
-- local function tags_match(seg,env)
--   local engine = env.engine
--   local context = engine.context
--   local b_k = context:get_option("back_mark")
--   return b_k
-- end

-- local function back_mark_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local b_k = context:get_option(env.option_n)
  for cand in inp:iter() do
    local b_mark = env.bm_opencc:convert_word(cand.text) or {''}
    local b_mark_1 = b_mark[1] or ""
    -- yield( cand )
    -- yield( change_comment(cand, cand.comment .. xform_mark(b_mark[1])) )
    -- yield( b_k and change_comment(cand, cand.comment .. xform_mark(b_mark[1]))
    --     or cand )
    -- yield( b_k and change_comment(cand, xform_mark(b_mark[1]))
    --     or cand )
    -- yield( b_k and (cand.comment ~= "" or b_mark == "") and cand
    --     or b_k and change_comment(cand, xform_mark(b_mark))
    --     or cand )
    yield( b_k and b_mark_1 ~= "" and change_comment(cand, xform_mark(b_mark_1))
        or cand )
  end
end

----------------
-- return back_mark_filter
return { init = init, func = filter }
-- return { init = init, func = filter, fini = fini }
-- return { init = init, func = filter, tags_match = tags_match, fini = fini }
-- return M
----------------