--- 修改 comment 長度防在 Windows 中崩潰
-- 可用 local tran = Translation(revise_comment_by_os, inp) 導出

----------------------------------------------------------------------------------------

local truncate_comment = require("filter_cand/truncate_comment")

local change_comment = require("filter_cand/change_comment")

-- local get_os_name = require("f_components/f_get_os_name")

----------------------------------------------------------------------------------------

local function revise_comment_by_os(os_name, cand, comment)

  --- 使用 init(env) 可定住參數，不用一直跑，故遮屏。
  -- local os_name = get_os_name() or ""
  -- env.os_name = os_name == "Mac" and 1
  --            or os_name == "Windows" and 2
  --            or os_name == "Linux" and 3
  --            or 4

  if os_name ~= 1 and os_name ~= 3 then
  -- if os_name == 2 or os_name == 0 then
  -- if os_name == 1 then  -- 測試用
    local comment = string.gsub(comment, "\n", "")
    local comment = string.gsub(comment, "﹙.+﹚", "")
    local comment = string.gsub(comment, "%b[]", "")  -- %b 匹配對稱字符
    local comment = string.gsub(comment, "%s+", " ")  -- %s 為空白符
    local comment = truncate_comment(comment)
    cand = change_comment(cand, comment)
  end

  return cand
end

local function output(os_name, tran)
  for cand in tran:iter() do
    local cand = revise_comment_by_os(os_name, cand, cand.comment)
    yield(cand)
  end
end

return output