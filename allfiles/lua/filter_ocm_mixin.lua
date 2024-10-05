--- @@ ocm_mixin_filter
--[[
（ocm_mixin）
合併 charset_filter2 和 comment_filter_plus 和 symbols_mark_filter，三個 lua filter 太耗效能。
原 lua 為 filter_mix_cf2_cfp_smf_filter.lua 使用 ReverseDb("build/symbols-mark.reverse.bin") 會有情況找不到。
故改用新版 lua 之引入 opencc 方法。
--]]


----------------
local function xform_mark(inp)
  if inp == "" or nil then return "" end
  inp = string.gsub(inp, "@@+", "") --@@@@
  inp = string.gsub(inp, "@", " ")
  return inp
end
----------------




--- 以下新的寫法

----------------

local drop_cand = require("filter_cand/drop_cand")
local change_comment = require("filter_cand/change_comment")

----------------
-- local M={}
local function init(env)
-- function M.init(env)
  env.bm_opencc = Opencc("back_mark.json") or {''}
end

-- function M.fini(env)
-- end

-- local function ocm_mixin_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local c_f2_s = context:get_option("character_range_bhjm")
  local s_c_f_p_s = context:get_option("simplify_comment")
  local b_k = context:get_option("back_mark")
  local tran = c_f2_s and Translation(drop_cand, inp, "᰼᰼") or inp
  -- local bm_opencc = {}
  -- local bm_opencc = Opencc("back_mark.json") or {''}
  for cand in tran:iter() do
    -- local b_mark = {}
    local b_mark = env.bm_opencc:convert_word(cand.text) or {''}
    yield( not s_c_f_p_s and b_k and change_comment(cand, cand.comment .. xform_mark(b_mark[1]))
        or s_c_f_p_s and b_k and change_comment(cand, xform_mark(b_mark[1]))
        or s_c_f_p_s and not b_k and change_comment(cand, "")
        -- or not s_c_f_p_s and not b_k and cand  --效果同下，省略
        or cand )
  end
end
----------------
-- return ocm_mixin_filter
return { init = init, func = filter }
-- return M


-- return { ocm_mixin_filter = ocm_mixin_filter }
-- return { filter = charset_filter } --可變更名稱
-- return mix_cf2_cfp_smf_filter -- 無法

--[[ 導出帶環境初始化的組件。
需要兩個屬性：
 - init: 指向初始化函數
 - func: 指向實際函數
--]]
-- return { init = init, func = filter }
----------------





--- 以下舊的寫法
--[[
local function ocm_mixin_filter(input, env)
  local c_f2_s = env.engine.context:get_option("character_range_bhjm")
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  local b_k = env.engine.context:get_option("back_mark")
  -- local c_input = env.engine.context.input
  -- local pun1 = string.match(c_input, "^'/" )
  -- local pun2 = string.match(c_input, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.match(c_input, "[]\\[]+$" )
  -- local pun4 = string.match(c_input, "^[;|][;]?$" )
  if (c_f2_s) and (b_k) then
    -- local bm_opencc = {}
    local bm_opencc = Opencc("back_mark.json") or {''}
    for cand in input:iter() do
      -- local b_mark = {}
      local b_mark = bm_opencc:convert_word(cand.text) or {''}
      if (not string.match(cand.text, "᰼᰼" )) and (not s_c_f_p_s) then
      -- if (not string.match(cand.text, "᰼᰼" )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
        cand:get_genuine().comment = cand.comment .. xform_mark(b_mark[1])
        yield(cand)
      elseif (not string.match(cand.text, "᰼᰼" )) and (s_c_f_p_s) then
      -- elseif (not string.match(cand.text, "᰼᰼" )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
        -- cand:get_genuine().comment = ""
        -- cand:get_genuine().comment = cand.comment .. xform_mark(b_mark[1])
        cand:get_genuine().comment = xform_mark(b_mark[1])
        yield(cand)
      end
    end
  elseif (not c_f2_s) and (b_k) then
    -- local bm_opencc = {}
    local bm_opencc = Opencc("back_mark.json") or {''}
    if (not s_c_f_p_s) then
    -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
      for cand in input:iter() do
        -- local b_mark = {}
        local b_mark = bm_opencc:convert_word(cand.text) or {''}
        cand:get_genuine().comment = cand.comment .. xform_mark(b_mark[1])
        yield(cand)
      end
    else
      for cand in input:iter() do
        -- local b_mark = {}
        local b_mark = bm_opencc:convert_word(cand.text) or {''}
        -- cand:get_genuine().comment = ""
        -- cand:get_genuine().comment = cand.comment .. xform_mark(b_mark[1])
        cand:get_genuine().comment = xform_mark(b_mark[1])
        yield(cand)
      end
    end
  elseif (c_f2_s) and (not b_k) then
    for cand in input:iter() do
      if (not string.match(cand.text, "᰼᰼" )) and (not s_c_f_p_s) then
      -- if (not string.match(cand.text, "᰼᰼" )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
        yield(cand)
      elseif (not string.match(cand.text, "᰼᰼" )) and (s_c_f_p_s) then
      -- elseif (not string.match(cand.text, "᰼᰼" )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  elseif (not c_f2_s) and (not b_k) then
    if (not s_c_f_p_s) then
    -- if (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
      for cand in input:iter() do
        yield(cand)
      end
    else
      for cand in input:iter() do
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  end
end

return { ocm_mixin_filter = ocm_mixin_filter }
--]]