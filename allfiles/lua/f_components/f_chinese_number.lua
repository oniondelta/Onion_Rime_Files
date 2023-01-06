--[[
number_translator: 將 `'/` + 阿拉伯數字 翻譯為大小寫漢字
--]]
local confs = {
  {
    comment = "〔小寫中文數字〕",
    number = { [0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九" },
    suffix1 = { [0] = "", "十", "百", "千" },
    suffix2 = { [0] = "", "萬", "億", "兆", "京" }
  },
  {
    comment = "〔大寫中文數字〕",
    number = { [0] = "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖" },
    suffix1 = { [0] = "", "拾", "佰", "仟" },
    suffix2 = { [0] = "", "萬", "億", "兆", "京" }
  },
}

local function read_seg(conf, n)
  local s = ""
  local i = 0
  local zf = true
  while string.len(n) > 0 do
    local d = tonumber(string.sub(n, -1, -1))
    if d ~= 0 then
      s = conf.number[d] .. conf.suffix1[i] .. s
      zf = false
    else
      if not zf then
        s = conf.number[0] .. s
      end
      zf = true
    end
    i = i + 1
    n = string.sub(n, 1, -2)
  end
  return i < 4, s
end

local function read_number(conf, n)
  local s = ""
  local i = 0
  local zf = false
  n = string.gsub(n, "^0+", "")
  if n == "" then
    return conf.number[0]
  end
  while string.len(n) > 0 do
    local zf2, r = read_seg(conf, string.sub(n, -4, -1))
    if r ~= "" then
      if zf and s ~= "" then
        s = r .. conf.suffix2[i] .. conf.number[0] .. s
      else
        s = r .. conf.suffix2[i] .. s
      end
    end
    zf = zf2
    i = i + 1
    n = string.sub(n, 1, -5)
  end
  return s
end

return {confs = confs, read_number = read_number}