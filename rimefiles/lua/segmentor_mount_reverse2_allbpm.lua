--- @@ mount_reverse2_allbpm
--[[
（ocm_mixin、dif1、ocm_mix）
避免注音方案 reverse2_lookup 和注音文 all_bpm 掛接在 26/30 鍵等方案時，發生跳回主方案(abc)和無法記憶等 bug。
--]]


local function init(env)
  env.namespace1 = "reverse2_lookup"
  env.namespace2 = "all_bpm"
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local prefix1 = config:get_string(env.namespace1 .. "/prefix")
  local prefix2 = config:get_string(env.namespace2 .. "/prefix")
  -- local suffix1 = config:get_string(env.namespace1 .. "/suffix")
  -- local suffix2 = config:get_string(env.namespace2 .. "/suffix")
  local pattern1 = config:get_string("recognizer/patterns/" .. env.namespace1)  -- or config:get_string("recognizer2/patterns/" .. env.namespace1)
  local pattern2 = config:get_string("recognizer/patterns/" .. env.namespace2)  -- or config:get_string("recognizer2/patterns/" .. env.namespace2)
  -- env.suffix1 = suffix1 and suffix1 .. "$" or ""
  -- env.suffix2 = suffix2 and suffix2 .. "$" or ""
  -- env.pattern1 = prefix1 and pattern1 and pattern1 or ""
  -- env.pattern2 = prefix2 and pattern2 and pattern2 or ""
  -- env.pattern1 = prefix1 and pattern1 and string.gsub(pattern1, ".*" .. prefix1, prefix1) or ""  -- 去除開頭如：(?<!=)，lua 無法運行之正則。
  -- env.pattern2 = prefix2 and pattern2 and string.gsub(pattern2, ".*" .. prefix2, prefix2) or ""  -- 去除開頭如：(?<!=)，lua 無法運行之正則。
  env.pattern1 = prefix1 and pattern1 and string.gsub(pattern1, "$|.*$", "$") or ""  -- 取第一個正則。
  env.pattern2 = prefix2 and pattern2 and string.gsub(pattern2, "$|.*$", "$") or ""  -- 取第一個正則。
end


local function segmentor(segs, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local startpos = segs:get_current_start_position()
  -- local endpos = segs:get_current_end_position()
  -- local cofmpos = segs:get_confirmed_position()
  -- local segpos = segs:get_current_segment_length()
  -- local segname = "test_seg_name"
  -- local segname1 = "reverse2_lookup"
  -- local segname2 = "all_bpm"
  -- local check_prefix1 = string.match(c_input, "^" .. env.prefix1)
  -- local check_prefix2 = string.match(c_input, env.prefix2)  -- "[']/[']"
  -- local check_suffix1 = string.match(c_input, env.suffix1)
  -- local check_suffix2 = string.match(c_input, env.suffix2)
  local check_pattern1 = string.match(c_input, env.pattern1)
  local check_pattern2 = string.match(c_input, env.pattern2)

  --- 檢查是否跳開（打tag）之條件
  --- pass 此 segmentor 由後面 segmentor 處理。
  -- if env.pattern1 == "" or env.pattern2 == "" then
  if env.pattern1 == "" then
    return true  -- 跳開續打tag。
  -- elseif not c_input:match("^=[^=]") then  -- 測試用
  --   return true
  elseif env.pattern2 == "" and not check_pattern1 then  -- env.pattern1 ~= "" (前面 env.pattern1 == "" 已可排除)
    return true
  elseif env.pattern2 ~= "" and not check_pattern1 and not check_pattern2 then  -- env.pattern1 ~= "" (前面 env.pattern1 == "" 已可排除)
    return true
  -- elseif env.pattern2 ~= "" and not check_pattern2 then  -- 無方案有該種設定。  -- env.pattern1 ~= "" (前面 env.pattern1 == "" 已可排除)
  --   return true
  -- elseif env.suffix1 ~= "" and check_suffix1 then  -- 出現尾綴，跳掉不處理。
  --   return true
  -- elseif env.suffix2 ~= "" and check_suffix2 then  -- 出現尾綴，跳掉不處理。
  --   return true
  end

  --- 建立 segment
  -- local seg = Segment(cofmpos, segs.input:len())  -- ok！
  -- local seg = Segment(startpos, segs.input:len())  -- ok！
  -- local seg = Segment(cofmpos, caret_pos)  -- ok！
  local seg = Segment(startpos, caret_pos)  -- ok！
  -- -- local seg = Segment(cofmpos, #c_input)  -- 用 #c_input，回切會有bug。
  -- -- local seg = Segment(startpos, #c_input)  -- 用 #c_input，回切會有bug。
  -- -- local seg = Segment(0, segs.input:len())  -- 開頭用 0 會有問題。
  -- -- local seg = Segment(0, cofmpos)  -- 開頭用 0 會有問題。
  -- -- local seg = Segment(0, startpos)  -- 開頭用 0 會有問題。
  -- -- local seg = Segment(0, #c_input)  -- 開頭用 0 會有問題。
  --- 以下不能顛倒！因為 "^['];" vs "^['];[']" 會重疊誤判。
  if env.pattern2 ~= "" and check_pattern2 then  -- "^['];[']"  -- 需要 env.pattern2 ~= ""，前面沒限定 env.pattern2 == "" 會有誤。
    seg.tags = Set({env.namespace2})
    -- seg.tags = { all_bpm = true }
    -- seg.tags = { test_seg_name = true }  -- 配合 filter 測試用
    -- seg.prompt = "〖 TEST: " .. env.namespace2 .. " 〗" .. " startpos: " .. startpos .. " endpos: " .. endpos .. " cofmpos: " .. cofmpos .. " segpos: " .. segpos .. " segs.input:len(): " .. segs.input:len() .. " caret_pos: " .. caret_pos .. " #c_input: " .. #c_input .. " «end» "
    -- seg.prompt = "〖 TEST: " .. env.namespace2 .. " 〗 正則：".. env.pattern2 .. " «end» "  -- "  尾綴：" .. env.suffix2 .. 
  else
    seg.tags = Set({env.namespace1})
    -- seg.tags = { reverse2_lookup = true }
    -- seg.tags = { test_seg_name = true }  -- 配合 filter 測試用
    -- seg.prompt = "〖 TEST: " .. env.namespace1 .. " 〗" .. " startpos: " .. startpos .. " endpos: " .. endpos .. " cofmpos: " .. cofmpos .. " segpos: " .. segpos .. " segs.input:len(): " .. segs.input:len() .. " caret_pos: " .. caret_pos .. " #c_input: " .. #c_input .. " «end» "
    -- seg.prompt = "〖 TEST: " .. env.namespace1 .. " 〗 正則：".. env.pattern1 .. " «end» "  -- "  尾綴：" .. env.suffix1 .. 
  end
  -- seg.tags = Set({segname})
  -- seg.tags = Set({segname1})
  -- seg.tags = Set({segname2})
  -- seg.tags = { reverse2_lookup = true }
  -- seg.tags = { "reverse2_lookup" = true }  -- 錯誤格式，無法作用！
  -- seg.tags = { segname = true }
  -- seg.tags = { abc = false }
  segs:add_segment(seg)

  -- --- 以下測試末尾 0 長度 Segment 是否能改變，使接續打字不會跳回 abc。
  -- -- local seg2 = Segment(#c_input, #c_input)
  -- local seg2 = Segment(cofmpos, caret_pos)
  -- seg2.tags = Set({env.namespace1})
  -- seg2.prompt = "〖 TEST: " .. env.namespace1 .. " 〗" .. " startpos: " .. startpos .. " endpos: " .. endpos .. " cofmpos: " .. cofmpos .. " segpos: " .. segpos .. " segs.input:len(): " .. segs.input:len() .. " caret_pos: " .. caret_pos .. " #c_input: " .. #c_input .. " «end» "
  -- segs:add_segment(seg2)
  -- -- segs:trim()

  --- 決定是否終止後面附加 segmentor（打tag）
  return false  -- 停止處理，可如此設置，但 lua_segmentor@mount_zhuyin 須放在 affix_segmentor@reverse2_lookup 和 affix_segmentor@all_bpm 之後。
  -- return true  -- 不停止處理，補打完 tag，讓後面 affix_segmentor@reverse2_lookup 和 affix_segmentor@all_bpm 可去處理。
end


return { init = init, func = segmentor }