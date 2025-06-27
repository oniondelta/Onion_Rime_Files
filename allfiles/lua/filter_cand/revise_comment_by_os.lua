--- 修改 comment 長度防在 Windows 中崩潰
-- 可用 local tran = Translation(revise_comment_by_os, inp) 導出

----------------------------------------------------------------------------------------

local truncate_comment = require("filter_cand/truncate_comment")
local linebreak_comment = require("filter_cand/linebreak_comment")

local change_comment = require("filter_cand/change_comment")

-- local get_os_name = require("f_components/f_get_os_name")

----------------------------------------------------------------------------------------

local function to_revise_comment_by_os(os_name, cand, comment)

  --- 使用 init(env) 可定住參數，不用一直跑，故遮屏。
  -- local os_name = get_os_name() or ""
  -- env.os_name = os_name == "Mac" and 1
  --            or os_name == "Windows" and 2
  --            or os_name == "Linux" and 3
  --            or 4

  -- if os_name ~= 1 and os_name ~= 3 then
  -- if os_name == 2 or os_name == 0 then
  -- if os_name == 1 then  -- 測試用
  if os_name == 2 or os_name == 4 then  -- 舊版小狼毫防 comment 太長崩潰用。
    local comment = comment:gsub("\n", "")
    local comment = comment:gsub("﹙.+﹚", "")
    local comment = comment:gsub("%b[]", "")  -- %b 匹配對稱字符
    local comment = comment:gsub("%s+", " ")  -- %s 為空白符
    local comment = truncate_comment(comment)
    cand = change_comment(cand, comment)
  elseif os_name == 170 then  -- 小狼毫 0.17.4 後可換行，但超過長度不會自動換行，故補充。
    local comment = comment:gsub("﹙.+﹚", "")
    local comment = comment:gsub("%b[]", "")  -- %b 匹配對稱字符
    local comment = comment:gsub("          +", "")  -- 去掉影響計算字數之空格。comment 開頭中空格前的「\n」此時需保留。
    local comment = linebreak_comment(comment)  -- 因計算字數，故前幾項先去除不想被計算之符號。
    -- local comment = comment:gsub("^%s+", "")  -- "^[\n ]+"
    local comment = comment:gsub("\n *", "\n      ")
    -- local comment = comment:gsub("^", "   \n      ")  -- 每個英文字詞間空一行
    -- local comment = comment:gsub("^", "      ")
    cand = change_comment(cand, comment)
  -- elseif os_name == 1 or os_name == 3 then  -- mac 超過長度，會自動換行，故不用特別轉換。
  end

  return cand
end

local function output(os_name, tran)
  for cand in tran:iter() do
    local cand = to_revise_comment_by_os(os_name, cand, cand.comment)
    yield(cand)
  end
end

return output