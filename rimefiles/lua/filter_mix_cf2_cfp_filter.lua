--- @@ mix_cf2_cfp_filter
--[[
（dif1）
合併 charset_filter2 和 comment_filter_plus，兩個 lua filter 太耗效能。
--]]




--- 以下新的寫法

----------------

local drop_cand = require("filter_cand/drop_cand")
local change_comment = require("filter_cand/change_comment")

----------------
-- local M={}
-- local function init(env)
-- function M.init(env)
-- end


-- function M.fini(env)
-- end

-- local function mix_cf2_cfp_filter(inp,env)
local function filter(inp, env)
-- function M.func(inp,env)
  local engine = env.engine
  local context = engine.context
  local c_f2_s = context:get_option("character_range_bhjm")
  local s_c_f_p_s = context:get_option("simplify_comment")
  -- 當 c_f2_s true 去掉 cand.text 有 "᰼᰼" 的 cand
  local tran = c_f2_s and Translation(drop_cand, inp, "᰼᰼") or inp
  
  for cand in tran:iter() do
    -- s_c_f_p_s true 時 清除 comment
    yield( s_c_f_p_s and change_comment(cand,"") or cand )
  end
end
----------------
-- return mix_cf2_cfp_filter
return { init = init, func = filter }
-- return M
----------------





--- 以下舊的寫法
--[[
local function mix_cf2_cfp_filter(input, env)
  local c_f2_s = env.engine.context:get_option("character_range_bhjm")
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  -- local c_input = env.engine.context.input
  -- local pun1 = string.match(c_input, "^'/" )
  -- local pun2 = string.match(c_input, "==?[]`0-9-=';,./[]*$" )
  -- local pun3 = string.match(c_input, "[]\\[]+$" )
  -- local pun4 = string.match(c_input, "^[;|][;]?$" )
  if (c_f2_s) then
    for cand in input:iter() do
      if (not string.match(cand.text, '᰼᰼' )) and (not s_c_f_p_s) then
      -- if (not string.match(cand.text, '᰼᰼' )) and (not s_c_f_p_s) or (pun1) or (pun2) or (pun3) or (pun4) then
        yield(cand)
      elseif (not string.match(cand.text, '᰼᰼' )) and (s_c_f_p_s) then
      -- elseif (not string.match(cand.text, '᰼᰼' )) and (s_c_f_p_s) and (not pun1) and (not pun2) and (not pun3) and (not pun4) then
        cand:get_genuine().comment = ""
        yield(cand)
      end
    end
  else
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

return mix_cf2_cfp_filter
--]]