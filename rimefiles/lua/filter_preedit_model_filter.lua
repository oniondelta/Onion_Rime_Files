--- @@ preedit_model_filter
--[[
（ mixin 全方案）
改變 preedit 樣式
--]]

----------------------------------------------------------------------------------------

-- local change_preedit = require("filter_cand/change_preedit")

local get_os_name = require("f_components/f_get_os_name")

local revise_preedit_by_os = require("filter_cand/revise_preedit_by_os")


----------------------------------------------------------------------------------------

-- local function revise_preedit_by_os(os_name, model, cand, preedit)
--   -- if model == 2 then
--   --   preedit = string.gsub(preedit, "\n", "")
--   --   preedit = string.gsub(preedit, "⁞", "@")
--   --   preedit = string.gsub(preedit, "　", " ")
--   --   preedit = string.gsub(preedit, "([^ ]+) ([^ ]+)$", "%2‹%1›")
--   --   n = 14
--   --   while string.match(preedit, "%s") and n>1 do
--   --     preedit = string.gsub(preedit, "([^ ]+) ([^ ]+)@([^@]+)$", "%2‹%1›%3")
--   --     n = n-1
--   --   end
--   --   -- for i = 1,14 do
--   --   --   preedit = string.gsub(preedit, "([^ ]+) ([^ ]+)@([^@]+)$", "%2‹%1›%3")
--   --   -- end
--   -- elseif model == 3 and os_name == 1 then
--   --   preedit = string.gsub(preedit, "　", " ")
--   --   preedit = string.gsub(preedit, "^([^\n]+) \n([^\n]+)", "%2　%1")
--   if model == 1 then
--     preedit = string.gsub(preedit, "^(.+)　(.+)", "%1\t（ %2 ）")
--   elseif model == 2 then
--     preedit = string.gsub(preedit, "⁞", "@")
--     preedit = string.gsub(preedit, "　", " ")
--     n = 14
--     while string.match(preedit, " ") and n>1 do
--       preedit = string.gsub(preedit, "^([^@]+)@([^ ]+) ([^ ]+)", "%1‹%3›%2")
--       n = n-1
--     end
--     preedit = string.gsub(preedit, " ([^ ]+)$", "‹%1›")
--   elseif model == 3 and os_name == 1 then
--     preedit = string.gsub(preedit, "^(.+)　(.+)", "%2　\n%1")
--     preedit = string.gsub(preedit, " ", "　")
--   end
--   local cand = change_preedit(cand, preedit)
--   return cand
-- end


-- local M={}
local function init(env)
-- function M.init(env)
  local os_name = get_os_name() or ""
  env.os_name = os_name == "Mac" and 1
             or os_name == "Windows" and 2
             or os_name == "Linux" and 3
             or 4
end


-- function M.fini(env)
-- end


local function tags_match(seg,env)
  local engine = env.engine
  local context = engine.context
  local seg_abc = seg:has_tag("abc")
  local p_1 = context:get_option("preedit_1")
  local p_2 = context:get_option("preedit_2")
  local p_3 = context:get_option("preedit_3")
  local p_4 = context:get_option("preedit_4")
  g_op = p_1 and 0 or p_2 and 1 or p_3 and 2 or p_4 and 3 or 4
  return seg_abc and g_op~=0
end


-- local function preedit_model_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp,env)

  -- for cand in tran:iter() do  --舊的非 Translation 方法，已經不可用。
  --   local cand = revise_preedit_by_os(env.os_name, g_op, cand, cand.preedit)
  --   yield(cand)
  -- end

  --- 以下用導入 Translation
  local tran = Translation(revise_preedit_by_os, env.os_name, g_op, inp) or inp
  for cand in tran:iter() do
    yield(cand)
  end
  -- tran = nil  -- 記憶體較易回退

end


-- return preedit_model_filter
return { init = init, func = filter, tags_match = tags_match }
-- return { init = init, func = filter }
-- return M