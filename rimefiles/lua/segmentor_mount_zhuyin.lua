--- @@ mount_zhuyin
--[[
（ocm_mixin、dif1、ocm_mix、onion-array30、onion-array10、Mount_ocm）
避免注音 reverse2_lookup 掛載在 26/30 鍵等方案時，發生跳回主方案(abc)和無法記憶等 bug。
另加上注音文同上。
--]]


local function init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local namespace1 = "reverse2_lookup"
  local namespace2 = "all_bpm"
  local prefix1 = config:get_string(namespace1 .. "/prefix")
  local prefix2 = config:get_string(namespace2 .. "/prefix")
  local suffix1 = config:get_string(namespace1 .. "/suffix")
  local suffix2 = config:get_string(namespace2 .. "/suffix")
  local pattern1 = config:get_string("recognizer/patterns/" .. namespace1)
  local pattern2 = config:get_string("recognizer/patterns/" .. namespace2)
  env.suffix1 = suffix1 and suffix1 .. "$" or ""
  env.suffix2 = suffix2 and suffix2 .. "$" or ""
  env.pattern1 = prefix1 and pattern1 and pattern1 or ""
  env.pattern2 = prefix2 and pattern2 and pattern2 or ""
  -- env.pattern1 = prefix1 and pattern1 and string.gsub(pattern1, ".*" .. prefix1, prefix1) or ""  -- 去除開頭如：(?<!=)，lua 無法運行之正則。
  -- env.pattern2 = prefix2 and pattern2 and string.gsub(pattern2, ".*" .. prefix2, prefix2) or ""  -- 去除開頭如：(?<!=)，lua 無法運行之正則。
end


local function segmentor(segs, env)
  local context = env.engine.context
  local c_input = context.input
  -- local caret_pos = context.caret_pos
  -- local startpos = segs:get_current_start_position()
  -- local endpos = segs:get_current_end_position()
  -- local segpos = segs:get_current_segment_length()
  local cofmpos = segs:get_confirmed_position()
  -- local segname = "test_seg_name"
  -- local segname1 = "reverse2_lookup"
  -- local segname2 = "all_bpm"
  -- local segname3 = "reverse3_lookup"
  -- local check_prefix1 = string.match(c_input, "^" .. env.prefix1)
  -- local check_prefix2 = string.match(c_input, env.prefix2)  -- "[']/[']"
  local check_suffix1 = string.match(c_input, env.suffix1)
  local check_suffix2 = string.match(c_input, env.suffix2)
  local check_pattern1 = string.match(c_input, env.pattern1)
  local check_pattern2 = string.match(c_input, env.pattern2)

  --- 檢查是否跳開（打tag）之條件
  if env.pattern1 == "" then
    return true  -- 跳開續打tag。
  -- -- 以下兩項與前項組合去跳開有缺失的 code。遮屏為不針對特殊缺失之精簡寫法。
  -- elseif env.pattern2 ~= "" then
  --   return true  -- 跳開續打tag。
  -- elseif not c_input:match("^" ..env.prefix1 .. "[-.,;/0-9a-z ]*'?$") then  -- 測試用
  --   return true  -- 跳開續打tag。
  -- elseif not c_input:match("^=[^=]") then  -- 測試用
  --   return true  -- 跳開續打tag。
  elseif env.pattern1 ~= "" and env.pattern2 == "" and not check_pattern1 then
    return true  -- 跳開續打tag。
  elseif env.pattern1 ~= "" and env.pattern2 ~= "" and not check_pattern1 and not check_pattern2 then
    return true  -- 跳開續打tag。
  -- elseif env.pattern1 == "" and env.pattern2 ~= "" and not check_pattern2 then  -- 無方案有該種設定。
  --   return true  -- 跳開續打tag。
  elseif env.suffix1 ~= "" and check_suffix1 then  -- 出現尾綴，跳掉不處理。
    return true  -- 跳開續打tag。
  elseif env.suffix2 ~= "" and check_suffix2 then  -- 出現尾綴，跳掉不處理。
    return true  -- 跳開續打tag。
  end

  --- 建立 segment
  -- if segpos ~= segs.input:len() then
  --   seg = Segment(segpos, segs.input:len())
  -- else
  --   seg = Segment(cofmpos, segs.input:len())
  -- end
  local seg = Segment(cofmpos, segs.input:len())
  -- local seg = Segment(startpos, segs.input:len())
  -- local seg = Segment(cofmpos, #input)
  -- local seg = Segment(startpos, #input)
  -- local seg = Segment(cofmpos, caret_pos)
  -- local seg = Segment(0, segs.input:len())
  -- local seg = Segment(0, cofmpos)
  -- local seg = Segment(0, startpos)
  -- local seg = Segment(0, #input)
  --- 以下不能顛倒！因為 "^['];" vs "^['];[']" 會重疊誤判。
  if env.pattern2 ~= "" and check_pattern2 then  -- "^['];[']"  -- 需要 env.pattern2 ~= ""，前面沒限定 env.pattern2 == "" 會有誤。
    seg.tags = { all_bpm = true }
    -- seg.prompt = "〖 TEST_all_bpm 〗" .. " startpos: " .. startpos .. " endpos: " .. endpos .. " cofmpos: " .. cofmpos .. " segpos: " .. segpos .. " segs.input:len(): " .. segs.input:len() .. " caret_pos: " .. caret_pos .. " #c_input: " .. #c_input
    -- seg.prompt = "〖 TEST_all_bpm 〗 正則：".. env.pattern2 .. " 尾綴：".. env.suffix2
  else
    seg.tags = { reverse2_lookup = true }
    -- seg.prompt = "〖 TEST_r2 〗" .. " startpos: " .. startpos .. " endpos: " .. endpos .. " cofmpos: " .. cofmpos .. " segpos: " .. segpos .. " segs.input:len(): " .. segs.input:len() .. " caret_pos: " .. caret_pos .. " #c_input: " .. #c_input
    -- seg.prompt = "〖 TEST_r2 〗 正則：".. env.pattern1 .. " 尾綴：".. env.suffix1
  end
  -- seg.tags = { reverse2_lookup = true }
  -- seg.tags = { reverse3_lookup = true }
  -- seg.tags = { "reverse2_lookup" = true }  -- 會無法作用！
  -- seg.tags = { segname = true }
  -- seg.tags = { abc = false }
  -- seg.tags = Set({segname1})
  -- seg.tags = Set({segname2})
  segs:add_segment(seg)

  --- 決定是否終止後面附加 segmentor（打tag）
  -- return false  -- 停止處理
  return true  -- 不停止處理，補打完 tag，讓後面 affix_segmentor@reverse2_lookup 接續處理。
end


return { init = init, func = segmentor }