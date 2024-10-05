--- @@ comment_filter_unicode_debug
--[[
（注音plus、注音mixin、ocm全系列）
註釋 Unicode 編碼 和 debug 訊息
--]]
----------------

-- local change_comment = require("filter_cand/change_comment")
-- local change_preedit = require("filter_cand/change_preedit")
-- local url_encode = require("f_components/f_url_encode")

local tran_utf8_comment = require("filter_cand/tran_utf8_comment")
local tran_debug_comment = require("filter_cand/tran_debug_comment")
local tran_utf8_debug_comment = require("filter_cand/tran_utf8_debug_comment")
-- local utf8_comment = require("filter_cand/utf8_comment")
-- local debug_comment = require("filter_cand/debug_comment")
-- local comment1 = require("filter_cand/utf8_comment")
-- local utf8_comment = comment1.utf8_comment
-- local t_utf8_comment = comment1.t_utf8_comment
-- local comment2 = require("filter_cand/debug_comment")
-- local debug_comment = comment2.debug_comment
-- local t_debug_comment = comment2.t_debug_comment


-- local function t_utf8_debug_comment(tran)
--   for cand in tran:iter() do
--     local cand_text = cand.text
--     if utf8.len(cand_text) == 1 then
--       cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. utf8_comment(cand_text) .. cand.comment)
--     else
--       cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. cand.comment)
--     end
--     -- local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. utf8_comment(cand_text) .. cand.comment)
--     yield(cand)
--   end
-- end

----------------
-- local M={}
local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local schema_id = config:get_string("schema/schema_id")
  -- local s_bo = string.match( schema_id, "^bo")
  local s_1 = string.match( schema_id, "^bo_mixin")
  local s_2 = string.match( schema_id, "^bopomo_onionplus")
  -- -- local s_3 = string.match( schema_id, "^bopomo_onion_double")
  -- -- local s_4 = string.match( schema_id, "^onion[-]array30") -- 開頭含有空碼「⎔」，選單會整個消失。
  -- local s_5 = string.match( schema_id, "^ocm_")
  -- local s_6 = string.match( schema_id, "^dif1")
  check_schema = function(input)
    -- if s_bo then
    if s_1 or s_2 then
      check_input = not string.match(input, "``?$") or string.match(input, "=``?$")
    else
      check_input = not string.match(input, "^;;?$")
    end
    return check_input
  end
end

-- function M.fini(env)
-- end

-- local function check_schema(input)
--   -- if s_bo then
--   if s_1 or s_2 then
--     check_input = not string.match(input, "``?$") or string.match(input, "=``?$")
--   else
--     check_input = not string.match(input, "^;;?$")
--   end
--   return check_input
-- end

local function tags_match(seg,env)
  local engine = env.engine
  local context = engine.context
  local u_c = context:get_option("unicode_comment")
  d_c = context:get_option("debug_comment")
  local seg_1 = seg:has_tag("mf_translator")
  local seg_2 = seg:has_tag("email_url_translator")
  local seg_3 = seg:has_tag("easy_en")
  local seg_4 = seg:has_tag("easy_en_upper")
  local exclude_seg = seg_1 or seg_2 or seg_3 or seg_4
  local c_input = context.input
  local check_inp = check_schema(c_input)
  local u_c2 = u_c and not exclude_seg and check_inp
  -- d_c_only = not u_c and d_c
  u_c2_only = u_c2 and not d_c
  u_c2_d_c = u_c2 and d_c
  return u_c2_only or u_c2_d_c or d_c
end

-- local function comment_filter_unicode_debug(inp,env)
local function filter(inp, env)
  -- local engine = env.engine
  -- local context = engine.context
  -- local c_input = context.input
  -- local check_inp = check_schema(c_input)
  -- local tab={}

--------------------------------------------
---- 寫法一

  -- if not u_c and d_c then
  --   for cand in inp:iter() do
  --     local debugcomment = debug_comment(cand)
  --     local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand.text, debugcomment .. cand.comment)
  --     yield(cand)
  --   end
  -- elseif u_c and not d_c then
  --   for cand in inp:iter() do
  --     if utf8.len(cand.text) == 1 and not exclude_seg and check_inp then
  --       local utf8comment = utf8_comment(cand.text)
  --       -- local cand = change_comment(cand, utf8comment .. cand.comment)
  --       -- local cand = ShadowCandidate(cand, "Shad", cand.text, utf8comment .. cand.comment)
  --       local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand.text, utf8comment .. cand.comment)
  --       yield(cand)
  --     else
  --       yield(cand)
  --     end
  --   end
  -- elseif u_c and d_c then
  --   for cand in inp:iter() do
  --     local debugcomment = debug_comment(cand)
  --     if utf8.len(cand.text) == 1 and not exclude_seg and check_inp then
  --       local utf8comment = utf8_comment(cand.text)
  --       local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand.text, debugcomment .. utf8comment .. cand.comment )
  --       yield(cand)
  --     else
  --       local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand.text, debugcomment .. cand.comment)
  --       yield(cand)
  --     end
  --   end
  -- end

--------------------------------------------
---- 寫法二

  -- for cand in inp:iter() do
  --   local utf8comment = utf8_comment(cand.text)
  --   local debugcomment = debug_comment(cand)
  --   -- local utf8comment = "  U+" .. string.format("%X",utf8.codepoint(cand.text)) .. "  ( " .. url_encode(cand.text) .. " ）"
  --   -- local debugcomment = "【"..cand:get_dynamic_type()..":"..cand.type.."| $ "..string.format("%6.6f", cand.quality).." | ‸ "..cand.start.."~"..cand._end.." 】"
  --   -- -- local debugcomment = "【 "..cand:get_dynamic_type().."|"..cand.type.."┃q: "..string.format("%6.6f", cand.quality).."┃s: "..cand.start.." e: "..cand._end.." 】"

  --   if not u_c and d_c then
  --     local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand.text, debugcomment .. cand.comment)
  --     yield(cand)

  --   elseif u_c and not d_c and utf8.len(cand.text) == 1 and not exclude_seg and check_inp then
  --     -- local cand = change_comment(cand, utf8comment .. cand.comment)
  --     -- local cand = ShadowCandidate(cand, "Shad", cand.text, utf8comment .. cand.comment)
  --     local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand.text, utf8comment .. cand.comment)
  --     yield(cand)

  --     -- if tab[cand.text] then
  --     --   tab[cand.text]:append(cand)
  --     -- else
  --     --   tab[cand.text] = cand:to_uniquified_candidate("uniquified", cand.text, cand.type .. utf8comment .. cand.comment)
  --     --   yield(tab[cand.text])
  --     -- end

  --   elseif u_c and d_c then
  --     if utf8.len(cand.text) == 1 and not exclude_seg and check_inp then
  --       local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand.text, debugcomment .. utf8comment .. cand.comment )
  --       yield(cand)
  --     else
  --       local cand = UniquifiedCandidate(cand, "uniq_unicode_debug", cand.text, debugcomment .. cand.comment)
  --       yield(cand)
  --     end

  --   -- if u_c and utf8.len(cand.text) == 1 and cand.type == "simplified" then
  --   --   local newpreedit = cand.preedit
  --   --   local _end2 = context:get_preedit().sel_end
  --   --   local cand = Candidate("newcand", 0, _end2, cand.text, cand.type .. utf8comment .. cand.comment)
  --   --   yield(change_preedit(cand,newpreedit))
  --   --   yield(cand)
  --   -- elseif u_c and utf8.len(cand.text) == 1 then
  --   --   yield(change_comment(cand, cand.type .. utf8comment .. cand.comment ))
  --   --   -- yield(change_comment(cand, ""))  -- 測試用

  --   -- ----  u_c true 時
  --   -- -- yield( u_c and utf8.len(cand.text)==1 and change_comment(cand,"") or cand )

  --   else
  --     cand

  --   end
  -- end

--------------------------------------------
---- 寫法三

  -- for cand in inp:iter() do

  --   -- local cand_text = cand.text  -- cand.text ~= "" and cand.text or "〖空碼〗"
  --   -- local utf8comment = utf8_comment(cand_text)  -- 遮屏後，utf8.len(cand_text) == 1再跑
  --   -- local debugcomment = debug_comment(cand)  -- 遮屏後，utf8.len(cand_text) == 1再跑
  --   -- yield(-- not u_c and d_c
  --   --       -- and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debugcomment .. cand.comment) or
  --   --       u_c and not d_c and not exclude_seg and check_inp and utf8.len(cand_text) == 1 -- 可改用 utf8_comment(cand_text) 內限定
  --   --       and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, utf8comment .. cand.comment) or
  --   --       u_c and d_c and not exclude_seg and check_inp and utf8.len(cand_text) == 1 -- 可改用 utf8_comment(cand_text) 內限定
  --   --       and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debugcomment .. utf8comment .. cand.comment) or
  --   --       -- u_c and d_c
  --   --       d_c
  --   --       and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debugcomment .. cand.comment) or
  --   --       cand
  --   --       )

  --   local cand_text = cand.text  -- cand.text ~= "" and cand.text or "〖空碼〗"
  --   yield(u_c2_only and utf8.len(cand_text) == 1 -- 可改用 utf8_comment(cand_text) 內限定
  --         and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, utf8_comment(cand_text) .. cand.comment) or
  --         u_c2_d_c and utf8.len(cand_text) == 1 -- 可改用 utf8_comment(cand_text) 內限定
  --         and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. utf8_comment(cand_text) .. cand.comment) or
  --         d_c
  --         and UniquifiedCandidate(cand, "uniq_unicode_debug", cand_text, debug_comment(cand) .. cand.comment) or
  --         cand
  --         )

  -- end

--------------------------------------------
---- 寫法四

  -- local tran = u_c and not d_c and not exclude_seg and check_inp and Translation(t_utf8_comment, inp) or
  --              u_c and d_c and not exclude_seg and check_inp and Translation(t_utf8_debug_comment, inp) or
  --              d_c and Translation(t_debug_comment, inp) or
  --              inp
  local tran = u_c2_only and Translation(tran_utf8_comment, inp) or
               u_c2_d_c and Translation(tran_utf8_debug_comment, inp) or
               d_c and Translation(tran_debug_comment, inp) or
               inp
  for cand in tran:iter() do
    yield(cand)
  end

--------------------------------------------

end


----------------
---- 他人方法

-- local function C2U(char)
--     local unicode_d = utf8.codepoint(char)
--     local unicode_h = string.format('%x', unicode_d)
--     --DEBUG
-- --    sm("C2U char="..char)
-- --    sm("C2U d="..unicode_d)
-- --    sm("C2U h="..unicode_h)
--     return unicode_h
-- end

-- local function filter(input, env)
--     local context = env.engine.context
--     local input_text = context.input
--     local udpf_switch = context:get_option("unicode_comment")
--     for cand in input:iter() do
--         if #input_text >= 1 and udpf_switch then
--             local char = cand.text
--             if utf8.len(char) == 1 then
--                 local unicode_h = C2U(char)
--                 --yield(Candidate(input_text, cand.start, cand._end, cand.text, cand.comment.."["..unicode_h.."]"))    --DEL
--                 cand:get_genuine().comment = cand.comment.."[U+"..unicode_h.."]"
--             end  --if
--         end  --if
--         yield(cand)
--     end  --for
-- end

----------------
-- return comment_filter_unicode_debug
return { init = init , func = filter , tags_match = tags_match }
-- return M
----------------