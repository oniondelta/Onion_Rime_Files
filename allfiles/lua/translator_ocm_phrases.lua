-- lua/translator_ocm_phrases.lua
-- schema.yaml   replace   table_translator@ocm_phrases ----> lua_translator@*translator_ocm_phrases@ocm_phrases
-- 效果未完成！

local function translate(inp, seg, env) 
  env.tran =  env.tran or Component.Translator(env.engine, "","table_translator@ocm_phrases")

  -- local inp = string.gsub(inp, ";$", "")

  for cand in env.tran:query(inp, seg):iter() do
    -- cand.comment = "『自定义』"
    -- cand.text = cand.text .. "、"
    -- cand.preedit = "、、"
    -- cand.preedit = cand.preedit .. ";"
    cand.type = "A_" .. cand.type  -- <   A_table  A_user_table
    yield(cand)
  end
end

return {func = translate}