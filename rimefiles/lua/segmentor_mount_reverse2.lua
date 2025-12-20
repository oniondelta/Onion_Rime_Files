--- @@ mount_reverse2
--[[
（onion-array30，關閉：onion-array10、Mount_ocm、Mount_ocm_encoder）
單獨針對注音反查 reverse2_lookup。避免掛接方案發生跳回主方案(abc)和無法記憶等 bug。
--]]


local function init(env)
  env.namespace = "reverse2_lookup"
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local prefix = config:get_string(env.namespace .. "/prefix")
  -- local suffix = config:get_string(env.namespace .. "/suffix")
  local pattern = config:get_string("recognizer/patterns/" .. env.namespace) or config:get_string("recognizer2/patterns/" .. env.namespace)
  -- local pattern = "^=[-.,;/0-9a-z ]*'?$"  -- 測試用
  -- env.suffix = suffix and suffix .. "$" or ""
  -- env.pattern = prefix and pattern and pattern or ""
  -- env.pattern = prefix and pattern and string.gsub(pattern, ".*" .. prefix, prefix) or ""  -- 去除開頭如：(?<!=)，lua 無法運行之正則。
  env.pattern = prefix and pattern and string.gsub(pattern, "$|.*$", "$") or ""  -- 取第一個正則。
end


local function segmentor(segs, env)
  local context = env.engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local startpos = segs:get_current_start_position()
  -- local endpos = segs:get_current_end_position()
  -- local cofmpos = segs:get_confirmed_position()
  -- local segpos = segs:get_current_segment_length()
  -- local segname = "reverse2_lookup"
  -- local check_prefix = string.match(c_input, "^" .. env.prefix)  -- "[']/[']"
  -- local check_suffix = string.match(c_input, env.suffix)
  local check_pattern = string.match(c_input, env.pattern)

  --- 檢查是否跳開（打tag）之條件
  --- pass 此 segmentor 由後面 segmentor 處理。
  if env.pattern == "" then
    return true  -- 跳開續打tag。
  -- elseif not c_input:match("^=[^=]") then  -- 測試用
  --   return true
  elseif not check_pattern then
    return true
  -- elseif env.suffix ~= "" and check_suffix then  -- 出現尾綴，跳掉不處理。
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
  seg.tags = Set({env.namespace})
  -- seg.tags = Set({segname})
  -- seg.tags = { reverse2_lookup = true }
  -- seg.tags = { "reverse2_lookup" = true }  -- 錯誤格式，無法作用！
  -- seg.tags = { test_seg_name = true }  -- 配合 filter 測試用
  -- seg.tags = { segname = true }
  -- seg.tags = { abc = false }
  -- seg.prompt = "〖 TEST: " .. env.namespace .. " 〗" .. " startpos: " .. startpos .. " endpos: " .. endpos .. " cofmpos: " .. cofmpos .. " segpos: " .. segpos .. " segs.input:len(): " .. segs.input:len() .. " caret_pos: " .. caret_pos .. " #c_input: " .. #c_input .. " «end» "
  -- seg.prompt = "〖 TEST: " .. env.namespace .. " 〗 正則：".. env.pattern .. " «end» "  -- "  尾綴：" .. env.suffix .. 
  segs:add_segment(seg)

  -- --- 以下測試末尾 0 長度 Segment 是否能改變，使接續打字不會跳回 abc。
  -- -- local seg2 = Segment(#c_input, #c_input)
  -- local seg2 = Segment(cofmpos, caret_pos)
  -- seg2.tags = Set({env.namespace})
  -- seg2.prompt = "〖 TEST: " .. env.namespace .. " 〗" .. " startpos: " .. startpos .. " endpos: " .. endpos .. " cofmpos: " .. cofmpos .. " segpos: " .. segpos .. " segs.input:len(): " .. segs.input:len() .. " caret_pos: " .. caret_pos .. " #c_input: " .. #c_input .. " «end» "
  -- segs:add_segment(seg2)
  -- -- segs:trim()

  --- 決定是否終止後面附加 segmentor（打tag）
  return false  -- 停止處理，可如此設置，但 lua_segmentor@mount_reverse2 須放在 affix_segmentor@reverse2_lookup 之後。
  -- return true  -- 不停止處理，補打完 tag，讓後面 affix_segmentor@reverse2_lookup 可去處理。
end


return { init = init, func = segmentor }