--- @@ punct_preedit_revise_filter
--[[
（ bopomo_onion_double 和 onion-array30 和 onion-array10 ）
punct 下，附加 preedit 後面 prompt 缺漏之標示。
另修正 ascii_punct 下，分號(;)和冒號(:)無法變半形問題。
--]]

----------------------------------------------------------------------------------------

local change_preedit = require("filter_cand/change_preedit")
local change_comment = require("filter_cand/change_comment")

----------------------------------------------------------------------------------------
-- local M={}

local function init(env)
-- function M.init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local schema_id = config:get_string("schema/schema_id")
  local bd = string.match(schema_id, "^bo")  --^bopomo_onion_double
  local ar30 = string.match(schema_id, "array30$")  --^on  -- ^onion%-array30
  local ar10 = string.match(schema_id, "array10$")  --^on  -- ^onion%-array10
  -- env.bd = string.match(schema_id, "^bo")  --^bopomo_onion_double
  -- env.ar30 = string.match(schema_id, "^onion%-array30")  --^on
  -- env.ar30 = string.match(schema_id, "^onion%-array10")  --^on
  if bd then
    function env.c1(n) return string.match(n, "^`$") or string.match(n, "[^=`]`$") end
    function env.c2(n) return false end
    function env.c3(n) return string.match(n, "^;$") or string.match(n, "[^=];$") end
    function env.c4(n) return string.match(n, "^;;$") or string.match(n, "[^=];;$") end
    function env.c5(n) return string.match(n, "=./$") end
    -- function env.c5(n) return true end
  elseif ar30 then
    function env.c1(n) return string.match(n, "`$") end
    function env.c2(n) return false end
    function env.c3(n) return false end
    function env.c4(n) return false end
    function env.c5(n) return false end
  elseif ar10 then
    function env.c1(n) return false end
    function env.c2(n) return string.match(n, "``$") end
    function env.c3(n) return false end
    function env.c4(n) return false end
    function env.c5(n) return false end
  else
    function env.c1(n) return false end
    function env.c2(n) return false end
    function env.c3(n) return false end
    function env.c4(n) return false end
    function env.c5(n) return false end
  end
end

-- local function fini(env)
-- function M.fini(env)
-- end

-- --- 「tags_match」和 shcema 中的「tags:」建議擇其一使用。
-- local function tags_match(seg, env)
-- -- function M.tags_match(seg, env)
--   local engine = env.engine
--   local context = engine.context
--   local c_input = context.input
--   -- local caret_pos = context.caret_pos
--   local o_ascii_punct = context:get_option("ascii_punct")
--   local seg_punct = seg:has_tag("punct")  -- 可改在 schema 限定
--   -- local seg_punct = seg.has_tag(seg,"punct")  -- 另一種寫法
--   -- local seg_punct = not seg:has_tag("abc")  -- 可使用
--   -- local seg_punct = seg:has_tag("punct") and not seg:has_tag("mf_translator")  -- 無法
--   check_1 = env.c1(c_input)
--   check_3 = o_ascii_punct and env.c3(c_input)
--   check_4 = o_ascii_punct and env.c4(c_input)
--   -- check_1 = env.bd and (string.match(c_input, "^`$") or string.match(c_input, "[^=`]`$")) or  -- 雙拼
--   --           env.ar and string.match(c_input, "`$")  -- 行列30
--   -- -- check_2 = caret_pos == #c_input and string.match(c_input, "^e([a-z,./;'][a-z]?[,./;']?)$")
--   -- check_3 = o_ascii_punct and (string.match(c_input, "^;$") or string.match(c_input, "[^=];$"))
--   -- check_4 = o_ascii_punct and (string.match(c_input, "^;;$") or string.match(c_input, "[^=];;$"))
--   return seg_punct and (check_1 or check_3 or check_4)
--   -- return check_1 or check_3 or check_4
--   -- return seg_punct and (check_1 or check_2 or check_3 or check_4)
--   -- return check_1 or check_2 or check_3 or check_4
-- end

local function filter(inp, env)
-- function M.func(inp, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  -- local caret_pos = context.caret_pos
  -- local comp = context.composition
  -- local seg = comp:back()
  -- local promp = comp:get_prompt()  -- 都為""空碼？
  -- local start = context:get_preedit().sel_start
  -- local _end = context:get_preedit().sel_end
  local o_ascii_punct = context:get_option("ascii_punct")
  -- local c_preedit = context:get_preedit()
  -- local c_preedit_text = string.gsub(c_preedit.text, "‸", "") or "xxxxxxx"  -- 末尾"‸"佔4個字元：string.sub(c_preedit_text, 1, -4)

  local check_1 = env.c1(c_input)
  local check_2 = env.c2(c_input)
  local check_3 = o_ascii_punct and env.c3(c_input)
  local check_4 = o_ascii_punct and env.c4(c_input)
  local check_5 = env.c5(c_input)
  -- ---
  -- local check_1 = env.bd and (string.match(c_input, "^`$") or string.match(c_input, "[^=`]`$")) or  -- 雙拼
  --                 env.ar and string.match(c_input, "`$")  -- 行列30
  -- -- local check_2 = caret_pos == #c_input and string.match(c_input, "^e([a-z,./;'][a-z]?[,./;']?)$")
  -- -- -- local check_2 = string.match(c_input, "^e[a-z,./;'][a-z]?[,./;']?$")
  -- local check_3 = o_ascii_punct and (string.match(c_input, "^;$") or string.match(c_input, "[^=];$"))
  -- local check_4 = o_ascii_punct and (string.match(c_input, "^;;$") or string.match(c_input, "[^=];;$"))

  -- seg.prompt = "《特殊功能集》▶"  -- 全部的 prompt 都會改寫
  -- if check_2 then
  --   seg.prompt = "《查詢鍵位注音》"  -- 全部的 prompt 都會改寫
  -- end

  -- local cand_semicolon = Candidate("simp_semicolon", start, _end, ";", "〔半角〕")
  -- local cand_semicolon = Candidate("simp_semicolon", 0, 1, ";", "〔半角〕")  -- 掛接方案後接，有bug。
  -- local cand_colon = Candidate("simp_colon", 0, 2, ":", "〔半角〕")  -- 掛接方案後接，有bug。
  -- local cand_semicolon = Candidate("simp_semicolon", seg.start, seg._end, ";", "〔半角〕")
  -- local cand_colon = Candidate("simp_colon", seg.start, seg._end, ":", "〔半角〕")
  -- --- 以下測試觀察用
  -- local cand_semicolon = Candidate("simp_semicolon", seg.start, seg._end, ";"..seg.start.." "..seg._end, "〔半角〕")
  -- local cand_colon = Candidate("simp_colon", seg.start, seg._end, ":"..seg.start.." "..seg._end, "〔半角〕")
  for cand in inp:iter() do
    local cand_text = cand.text
    yield(check_1 and cand_text == "`" and change_preedit(cand, cand.preedit .. "\t《特殊功能集》▶") or
          check_2 and cand_text == "``" and change_preedit(cand, cand.preedit .. "``\t《查注音》▶") or
          -- check_2 and change_preedit(cand, "《查詢鍵位注音》" .. string.upper(check_2) ) or
          -- -- check_2 and change_preedit(cand, "《查詢鍵位注音》" .. c_preedit_text ) or
          -- -- check_2 and change_preedit(cand, "e " .. string.upper(check_2) .. "\t《查詢鍵位注音》") or
          -- check_3 and cand_text == "；" and cand_semicolon or
          -- check_4 and cand_text == "：" and cand_colon or
          check_3 and cand_text == "；" and Candidate("simp_semicolon", cand.start, cand._end, ";", "〔半角〕") or
          check_4 and cand_text == "：" and Candidate("simp_colon", cand.start, cand._end, ":", "〔半角〕") or
          -- --- 以下兩則測試觀察用
          -- check_3 and cand_text == "；" and Candidate("simp_semicolon", cand.start, cand._end, ";"..cand.start.." "..cand._end, "〔半角〕") or
          -- check_4 and cand_text == "：" and Candidate("simp_colon", cand.start, cand._end, ":"..cand.start.." "..cand._end, "〔半角〕") or
          check_5 and cand_text == "\t" and change_comment(cand, "〔Tab製表符〕") or
          -- cand_text == "\t" and change_comment(cand, "〔Tab製表符〕") or
          cand
         )
    -- yield(check_1 and cand.text == "`" and change_preedit(cand, cand.preedit .."\t《特殊功能集》▶") or
    --       cand
    --      )
  end

end

-- return { func = filter }
return { init = init, func = filter }
-- return { init = init, func = filter, tags_match = tags_match }
-- return M