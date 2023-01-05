

local function revise_t(t)
  if t == "" then return "" end
    t = string.gsub(t, "[.,;]", "")
  return t
end


local function fullshape_t(t)
  if t == "" then return "" end
  t = string.gsub(t, "a", "ａ")
  t = string.gsub(t, "b", "ｂ")
  t = string.gsub(t, "c", "ｃ")
  t = string.gsub(t, "d", "ｄ")
  t = string.gsub(t, "e", "ｅ")
  t = string.gsub(t, "f", "ｆ")
  t = string.gsub(t, "g", "ｇ")
  t = string.gsub(t, "h", "ｈ")
  t = string.gsub(t, "i", "ｉ")
  t = string.gsub(t, "j", "ｊ")
  t = string.gsub(t, "k", "ｋ")
  t = string.gsub(t, "l", "ｌ")
  t = string.gsub(t, "m", "ｍ")
  t = string.gsub(t, "n", "ｎ")
  t = string.gsub(t, "o", "ｏ")
  t = string.gsub(t, "p", "ｐ")
  t = string.gsub(t, "q", "ｑ")
  t = string.gsub(t, "r", "ｒ")
  t = string.gsub(t, "s", "ｓ")
  t = string.gsub(t, "t", "ｔ")
  t = string.gsub(t, "u", "ｕ")
  t = string.gsub(t, "v", "ｖ")
  t = string.gsub(t, "w", "ｗ")
  t = string.gsub(t, "x", "ｘ")
  t = string.gsub(t, "y", "ｙ")
  t = string.gsub(t, "z", "ｚ")
  t = string.gsub(t, "-", "－")
  t = string.gsub(t, "/", "／")
  t = string.gsub(t, "[.,;]", "")
  return t
end

local function halfwidth_kata_t(t)
  if t == "" then return "" end
  t = string.gsub(t, "zzyi", "ｯｼﾞｨ")
  t = string.gsub(t, "zzye", "ｯｼﾞｪ")
  t = string.gsub(t, "ttyi", "ｯﾁｨ")
  t = string.gsub(t, "ttye", "ｯﾁｪ")
  t = string.gsub(t, "ttsu", "ｯﾂ")
  t = string.gsub(t, "tsyu", "ﾂｭ")
  t = string.gsub(t, "ssyi", "ｯｼｨ")
  t = string.gsub(t, "ssye", "ｯｼｪ")
  t = string.gsub(t, "sshu", "ｯｼｭ")
  t = string.gsub(t, "ssho", "ｯｼｮ")
  t = string.gsub(t, "ssha", "ｯｼｬ")
  t = string.gsub(t, "sshi", "ｯｼ")
  t = string.gsub(t, "rryu", "ｯﾘｭ")
  t = string.gsub(t, "rryo", "ｯﾘｮ")
  t = string.gsub(t, "rryi", "ｯﾘｨ")
  t = string.gsub(t, "rrye", "ｯﾘｪ")
  t = string.gsub(t, "rrya", "ｯﾘｬ")
  t = string.gsub(t, "ppyu", "ｯﾋﾟｭ")
  t = string.gsub(t, "ppyo", "ｯﾋﾟｮ")
  t = string.gsub(t, "ppyi", "ｯﾋﾟｨ")
  t = string.gsub(t, "ppye", "ｯﾋﾟｪ")
  t = string.gsub(t, "ppya", "ｯﾋﾟｬ")
  -- t = string.gsub(t, "nnyu", "ｯﾆｭ")  --少有，多是出：ンユ
  -- t = string.gsub(t, "nnyo", "ｯﾆｮ")  --少有，多是出：ンヨ
  -- t = string.gsub(t, "nnya", "ｯﾆｬ")  --少有，多是出：ンヤ
  -- t = string.gsub(t, "ngyu", "ｷﾟｭ")  --少有，多是出：ﾝｷﾞｭ
  -- t = string.gsub(t, "ngyo", "ｷﾟｮ")  --少有，多是出：ﾝｷﾞｮ
  -- t = string.gsub(t, "ngya", "ｷﾟｬ")  --少有，多是出：ンギャ
  t = string.gsub(t, "mmyu", "ｯﾐｭ")
  t = string.gsub(t, "mmyo", "ｯﾐｮ")
  t = string.gsub(t, "mmyi", "ｯﾐｨ")
  t = string.gsub(t, "mmye", "ｯﾐｪ")
  t = string.gsub(t, "mmya", "ｯﾐｬ")
  t = string.gsub(t, "kkyu", "ｯｷｭ")
  t = string.gsub(t, "kkyo", "ｯｷｮ")
  t = string.gsub(t, "kkyi", "ｯｷｨ")
  t = string.gsub(t, "kkye", "ｯｷｪ")
  t = string.gsub(t, "kkya", "ｯｷｬ")
  t = string.gsub(t, "jjyi", "ｯｼﾞｨ")
  t = string.gsub(t, "jjye", "ｯｼﾞｪ")
  t = string.gsub(t, "hhyu", "ｯﾋｭ")
  t = string.gsub(t, "hhyo", "ｯﾋｮ")
  t = string.gsub(t, "hhyi", "ｯﾋｨ")
  t = string.gsub(t, "hhye", "ｯﾋｪ")
  t = string.gsub(t, "hhya", "ｯﾋｬ")
  t = string.gsub(t, "ggyu", "ｯｷﾞｭ")
  t = string.gsub(t, "ggyo", "ｯｷﾞｮ")
  t = string.gsub(t, "ggyi", "ｯｷﾞｨ")
  t = string.gsub(t, "ggye", "ｯｷﾞｪ")
  t = string.gsub(t, "ggya", "ｯｷﾞｬ")
  -- t = string.gsub(t, "dvyu", "ﾃﾞｭ")  --轉寫後重複dyu
  t = string.gsub(t, "ddyu", "ｯﾁﾞｭ")
  t = string.gsub(t, "ddyo", "ｯﾁﾞｮ")
  t = string.gsub(t, "ddya", "ｯﾁﾞｬ")
  t = string.gsub(t, "ddyi", "ｯﾁﾞｨ")
  t = string.gsub(t, "ddye", "ｯﾁﾞｪ")
  t = string.gsub(t, "cchu", "ｯﾁｭ")
  t = string.gsub(t, "ccho", "ｯﾁｮ")
  t = string.gsub(t, "ccha", "ｯﾁｬ")
  t = string.gsub(t, "cchi", "ｯﾁ")
  t = string.gsub(t, "bbyu", "ｯﾋﾞｭ")
  t = string.gsub(t, "bbyo", "ｯﾋﾞｮ")
  t = string.gsub(t, "bbyi", "ｯﾋﾞｨ")
  t = string.gsub(t, "bbye", "ｯﾋﾞｪ")
  t = string.gsub(t, "bbya", "ｯﾋﾞｬ")
  t = string.gsub(t, "ccyu", "ｯﾁｭ")  --增
  t = string.gsub(t, "ccyo", "ｯﾁｮ")  --增
  t = string.gsub(t, "ccya", "ｯﾁｬ")  --增
  t = string.gsub(t, "ttyu", "ｯﾁｭ")  --增
  t = string.gsub(t, "ttyo", "ｯﾁｮ")  --增
  t = string.gsub(t, "ttya", "ｯﾁｬ")  --增
  t = string.gsub(t, "zzyu", "ｯﾁﾞｭ")  --增
  t = string.gsub(t, "zzyo", "ｯﾁﾞｮ")  --增
  t = string.gsub(t, "zzya", "ｯﾁﾞｬ")  --增
  -- t = string.gsub(t, "zzyu", "ｯｼﾞｭ")  --增
  -- t = string.gsub(t, "zzyo", "ｯｼﾞｮ")  --增
  -- t = string.gsub(t, "zzya", "ｯｼﾞｬ")  --增
  -- t = string.gsub(t, "jjyu", "ｯﾁﾞｭ")  --增
  -- t = string.gsub(t, "jjyo", "ｯﾁﾞｮ")  --增
  -- t = string.gsub(t, "jjya", "ｯﾁﾞｬ")  --增
  t = string.gsub(t, "jjyu", "ｯｼﾞｭ")  --增
  t = string.gsub(t, "jjyo", "ｯｼﾞｮ")  --增
  t = string.gsub(t, "jjya", "ｯｼﾞｬ")  --增
  t = string.gsub(t, "xtsu", "ｯ")  --增
  t = string.gsub(t, "ltsu", "ｯ")  --增
  t = string.gsub(t, "cche", "ｯﾁｪ")  --增
  t = string.gsub(t, "ccye", "ｯﾁｪ")  --增
  t = string.gsub(t, "ssyu", "ｯｼｭ")  --增
  t = string.gsub(t, "ssyo", "ｯｼｮ")  --增
  t = string.gsub(t, "ssya", "ｯｼｬ")  --增
  t = string.gsub(t, "zzu", "ｯｽﾞ")
  t = string.gsub(t, "zzo", "ｯｿﾞ")
  t = string.gsub(t, "zze", "ｯｾﾞ")
  t = string.gsub(t, "zza", "ｯｻﾞ")
  -- t = string.gsub(t, "zyu", "ｽﾞｭ")  --？
  t = string.gsub(t, "zyi", "ｼﾞｨ")
  t = string.gsub(t, "zye", "ｼﾞｪ")
  t = string.gsub(t, "zwi", "ｽﾞｨ")
  t = string.gsub(t, "yyu", "ｯﾕ")
  t = string.gsub(t, "yyo", "ｯﾖ")
  t = string.gsub(t, "yyi", "ｯｲｨ")
  t = string.gsub(t, "yye", "ｯｲｪ")
  t = string.gsub(t, "yya", "ｯﾔ")
  t = string.gsub(t, "xyu", "ｭ")
  t = string.gsub(t, "xyo", "ｮ")
  t = string.gsub(t, "xya", "ｬ")
  t = string.gsub(t, "wyu", "ｳｭ")
  t = string.gsub(t, "wwo", "ｯｦ")
  t = string.gsub(t, "wwa", "ｯﾜ")
  t = string.gsub(t, "whu", "ｳｩ")
  t = string.gsub(t, "who", "ｳｫ")
  t = string.gsub(t, "whi", "ｳｨ")
  t = string.gsub(t, "whe", "ｳｪ")
  t = string.gsub(t, "wha", "ｳｧ")
  t = string.gsub(t, "vyu", "ｳﾞｭ")
  t = string.gsub(t, "vyo", "ｳﾞｮ")
  t = string.gsub(t, "vyi", "ｳﾞｨ")
  t = string.gsub(t, "vye", "ｳﾞｪ")
  t = string.gsub(t, "vya", "ｳﾞｬ")
  -- t = string.gsub(t, "tyu", "ﾃｭ")
  t = string.gsub(t, "tyi", "ﾁｨ")
  t = string.gsub(t, "tye", "ﾁｪ")
  t = string.gsub(t, "twu", "ﾄｩ")
  t = string.gsub(t, "two", "ﾄｫ")
  t = string.gsub(t, "twi", "ﾄｨ")
  t = string.gsub(t, "twe", "ﾄｪ")
  t = string.gsub(t, "twa", "ﾄｧ")
  t = string.gsub(t, "tto", "ｯﾄ")
  t = string.gsub(t, "tte", "ｯﾃ")
  t = string.gsub(t, "tta", "ｯﾀ")
  t = string.gsub(t, "tsu", "ﾂ")
  t = string.gsub(t, "tso", "ﾂｫ")
  t = string.gsub(t, "tsi", "ﾂｨ")
  t = string.gsub(t, "tse", "ﾂｪ")
  t = string.gsub(t, "tsa", "ﾂｧ")
  t = string.gsub(t, "thu", "ﾃｭ")
  t = string.gsub(t, "tho", "ﾃｮ")
  t = string.gsub(t, "thi", "ﾃｨ")
  t = string.gsub(t, "the", "ﾃｪ")
  t = string.gsub(t, "tha", "ﾃｬ")
  -- t = string.gsub(t, "syu", "ｽｭ")
  t = string.gsub(t, "syi", "ｼｨ")
  t = string.gsub(t, "sye", "ｼｪ")
  t = string.gsub(t, "swu", "ｽｩ")
  t = string.gsub(t, "swo", "ｽｫ")
  t = string.gsub(t, "swi", "ｽｨ")
  t = string.gsub(t, "swe", "ｽｪ")
  t = string.gsub(t, "swa", "ｽｧ")
  t = string.gsub(t, "ssu", "ｯｽ")
  t = string.gsub(t, "sso", "ｯｿ")
  t = string.gsub(t, "sse", "ｯｾ")
  t = string.gsub(t, "ssa", "ｯｻ")
  t = string.gsub(t, "shu", "ｼｭ")
  t = string.gsub(t, "sho", "ｼｮ")
  t = string.gsub(t, "sha", "ｼｬ")
  t = string.gsub(t, "shi", "ｼ")
  t = string.gsub(t, "she", "ｼｪ")
  t = string.gsub(t, "ryu", "ﾘｭ")
  t = string.gsub(t, "ryo", "ﾘｮ")
  t = string.gsub(t, "ryi", "ﾘｨ")
  t = string.gsub(t, "rye", "ﾘｪ")
  t = string.gsub(t, "rya", "ﾘｬ")
  t = string.gsub(t, "rru", "ｯﾙ")
  t = string.gsub(t, "rro", "ｯﾛ")
  t = string.gsub(t, "rri", "ｯﾘ")
  t = string.gsub(t, "rre", "ｯﾚ")
  t = string.gsub(t, "rra", "ｯﾗ")
  t = string.gsub(t, "qyu", "ｸｭ")
  t = string.gsub(t, "qyo", "ｸｮ")
  t = string.gsub(t, "qyi", "ｸｨ")
  t = string.gsub(t, "qye", "ｸｪ")
  t = string.gsub(t, "qya", "ｸｬ")
  t = string.gsub(t, "qwu", "ｸｩ")
  t = string.gsub(t, "qwo", "ｸｫ")
  t = string.gsub(t, "qwi", "ｸｨ")
  t = string.gsub(t, "qwe", "ｸｪ")
  t = string.gsub(t, "qwa", "ｸｧ")
  t = string.gsub(t, "pyu", "ﾋﾟｭ")
  t = string.gsub(t, "pyo", "ﾋﾟｮ")
  t = string.gsub(t, "pyi", "ﾋﾟｨ")
  t = string.gsub(t, "pye", "ﾋﾟｪ")
  t = string.gsub(t, "pya", "ﾋﾟｬ")
  t = string.gsub(t, "ppu", "ｯﾌﾟ")
  t = string.gsub(t, "ppo", "ｯﾎﾟ")
  t = string.gsub(t, "ppi", "ｯﾋﾟ")
  t = string.gsub(t, "ppe", "ｯﾍﾟ")
  t = string.gsub(t, "ppa", "ｯﾊﾟ")
  t = string.gsub(t, "nyu", "ﾆｭ")
  t = string.gsub(t, "nyo", "ﾆｮ")
  t = string.gsub(t, "nyi", "ﾆｨ")
  t = string.gsub(t, "nye", "ﾆｪ")
  t = string.gsub(t, "nya", "ﾆｬ")
  -- t = string.gsub(t, "nnu", "ｯﾇ")  --少有
  -- t = string.gsub(t, "nno", "ｯﾉ")  --少有
  -- t = string.gsub(t, "nni", "ｯﾆ")  --少有
  -- t = string.gsub(t, "nne", "ｯﾈ")  --少有
  -- t = string.gsub(t, "nna", "ｯﾅ")  --少有
  t = string.gsub(t, "ngu", "ｸﾟ")
  t = string.gsub(t, "ngo", "ｺﾟ")
  t = string.gsub(t, "ngi", "ｷﾟ")
  t = string.gsub(t, "nge", "ｹﾟ")
  t = string.gsub(t, "nga", "ｶﾟ")
  t = string.gsub(t, "myu", "ﾐｭ")
  t = string.gsub(t, "myo", "ﾐｮ")
  t = string.gsub(t, "myi", "ﾐｨ")
  t = string.gsub(t, "mye", "ﾐｪ")
  t = string.gsub(t, "mya", "ﾐｬ")
  t = string.gsub(t, "mmu", "ｯﾑ")
  t = string.gsub(t, "mmo", "ｯﾓ")
  t = string.gsub(t, "mmi", "ｯﾐ")
  t = string.gsub(t, "mme", "ｯﾒ")
  t = string.gsub(t, "mma", "ｯﾏ")
  t = string.gsub(t, "lyi", "ﾘｨ")
  t = string.gsub(t, "lye", "ﾘｪ")
  t = string.gsub(t, "kyu", "ｷｭ")
  t = string.gsub(t, "kyo", "ｷｮ")
  t = string.gsub(t, "kye", "ｷｪ")
  t = string.gsub(t, "kya", "ｷｬ")
  t = string.gsub(t, "kwu", "ｸｩ")
  t = string.gsub(t, "kwo", "ｸｫ")
  t = string.gsub(t, "kwi", "ｸｨ")
  t = string.gsub(t, "kwe", "ｸｪ")
  t = string.gsub(t, "kwa", "ｸｧ")
  t = string.gsub(t, "kku", "ｯｸ")
  t = string.gsub(t, "kko", "ｯｺ")
  t = string.gsub(t, "kki", "ｯｷ")
  t = string.gsub(t, "kke", "ｯｹ")
  t = string.gsub(t, "kka", "ｯｶ")
  t = string.gsub(t, "jyi", "ｼﾞｨ")
  t = string.gsub(t, "jye", "ｼﾞｪ")
  t = string.gsub(t, "jju", "ｯｼﾞｭ")
  t = string.gsub(t, "jjo", "ｯｼﾞｮ")
  t = string.gsub(t, "jja", "ｯｼﾞｬ")
  t = string.gsub(t, "jji", "ｯｼﾞ")
  t = string.gsub(t, "hyu", "ﾋｭ")
  t = string.gsub(t, "hyo", "ﾋｮ")
  t = string.gsub(t, "hyi", "ﾋｨ")
  t = string.gsub(t, "hye", "ﾋｪ")
  t = string.gsub(t, "hya", "ﾋｬ")
  t = string.gsub(t, "hwu", "ﾎｩ")
  t = string.gsub(t, "hho", "ｯﾎ")
  t = string.gsub(t, "hhi", "ｯﾋ")
  t = string.gsub(t, "hhe", "ｯﾍ")
  t = string.gsub(t, "hha", "ｯﾊ")
  t = string.gsub(t, "gyu", "ｷﾞｭ")
  t = string.gsub(t, "gyo", "ｷﾞｮ")
  t = string.gsub(t, "gyi", "ｷﾞｨ")
  t = string.gsub(t, "gye", "ｷﾞｪ")
  t = string.gsub(t, "gya", "ｷﾞｬ")
  t = string.gsub(t, "gwu", "ｸﾞｩ")
  t = string.gsub(t, "gwo", "ｸﾞｫ")
  t = string.gsub(t, "gwi", "ｸﾞｨ")
  t = string.gsub(t, "gwe", "ｸﾞｪ")
  t = string.gsub(t, "gwa", "ｸﾞｧ")
  t = string.gsub(t, "ggu", "ｯｸﾞ")
  t = string.gsub(t, "ggo", "ｯｺﾞ")
  t = string.gsub(t, "ggi", "ｯｷﾞ")
  t = string.gsub(t, "gge", "ｯｹﾞ")
  t = string.gsub(t, "gga", "ｯｶﾞ")
  t = string.gsub(t, "fyu", "ﾌｭ")
  t = string.gsub(t, "fyo", "ﾌｮ")
  t = string.gsub(t, "fyi", "ﾌｨ")
  t = string.gsub(t, "fye", "ﾌｪ")
  t = string.gsub(t, "fya", "ﾌｬ")
  t = string.gsub(t, "fwu", "ﾌｩ")
  t = string.gsub(t, "fwo", "ﾌｫ")
  t = string.gsub(t, "fwi", "ﾌｨ")
  t = string.gsub(t, "fwe", "ﾌｪ")
  t = string.gsub(t, "fwa", "ﾌｧ")
  t = string.gsub(t, "ffu", "ｯﾌ")
  t = string.gsub(t, "dyu", "ﾁﾞｭ")
  t = string.gsub(t, "dyo", "ﾁﾞｮ")
  t = string.gsub(t, "dya", "ﾁﾞｬ")
  t = string.gsub(t, "dyi", "ﾁﾞｨ")
  t = string.gsub(t, "dye", "ﾁﾞｪ")
  t = string.gsub(t, "dwu", "ﾄﾞｩ")
  t = string.gsub(t, "dwo", "ﾄﾞｫ")
  t = string.gsub(t, "dwi", "ﾄﾞｨ")
  t = string.gsub(t, "dwe", "ﾄﾞｪ")
  t = string.gsub(t, "dwa", "ﾄﾞｧ")
  t = string.gsub(t, "dhu", "ﾃﾞｭ")
  t = string.gsub(t, "dho", "ﾃﾞｮ")
  t = string.gsub(t, "dhi", "ﾃﾞｨ")
  t = string.gsub(t, "dhe", "ﾃﾞｪ")
  t = string.gsub(t, "dha", "ﾃﾞｬ")
  t = string.gsub(t, "ddu", "ｯﾂﾞ")
  t = string.gsub(t, "ddo", "ｯﾄﾞ")
  t = string.gsub(t, "ddi", "ｯﾁﾞ")
  t = string.gsub(t, "dde", "ｯﾃﾞ")
  t = string.gsub(t, "dda", "ｯﾀﾞ")
  t = string.gsub(t, "cyi", "ﾁｨ")
  t = string.gsub(t, "chu", "ﾁｭ")
  t = string.gsub(t, "cho", "ﾁｮ")
  t = string.gsub(t, "cha", "ﾁｬ")
  t = string.gsub(t, "chi", "ﾁ")
  t = string.gsub(t, "byu", "ﾋﾞｭ")
  t = string.gsub(t, "byo", "ﾋﾞｮ")
  t = string.gsub(t, "bye", "ﾋﾞｪ")
  t = string.gsub(t, "bya", "ﾋﾞｬ")
  t = string.gsub(t, "bbu", "ｯﾌﾞ")
  t = string.gsub(t, "bbo", "ｯﾎﾞ")
  t = string.gsub(t, "bbi", "ｯﾋﾞ")
  t = string.gsub(t, "bbe", "ｯﾍﾞ")
  t = string.gsub(t, "bba", "ｯﾊﾞ")
  t = string.gsub(t, "tyu", "ﾁｭ")  --增
  t = string.gsub(t, "tyo", "ﾁｮ")  --增
  t = string.gsub(t, "tya", "ﾁｬ")  --增
  t = string.gsub(t, "xtu", "ｯ")  --增
  t = string.gsub(t, "ltu", "ｯ")  --增
  t = string.gsub(t, "zyu", "ﾁﾞｭ")  --增
  t = string.gsub(t, "zyo", "ﾁﾞｮ")  --增
  t = string.gsub(t, "zya", "ﾁﾞｬ")  --增
  -- t = string.gsub(t, "zyu", "ｼﾞｭ")  --增
  -- t = string.gsub(t, "zyo", "ｼﾞｮ")  --增
  -- t = string.gsub(t, "zya", "ｼﾞｬ")  --增
  t = string.gsub(t, "zzi", "ｯｼﾞｬ")  --增
  t = string.gsub(t, "jyu", "ｼﾞｭ")  --增
  t = string.gsub(t, "jyo", "ｼﾞｮ")  --增
  t = string.gsub(t, "jya", "ｼﾞｬ")  --增
  t = string.gsub(t, "tti", "ｯﾁ")  --增
  t = string.gsub(t, "syu", "ｼｭ")  --增
  t = string.gsub(t, "syo", "ｼｮ")  --增
  t = string.gsub(t, "sya", "ｼｬ")  --增
  t = string.gsub(t, "che", "ﾁｪ")  --增
  t = string.gsub(t, "cye", "ﾁｪ")  --增
  t = string.gsub(t, "ttu", "ｯﾂ")  --增
  t = string.gsub(t, "ssi", "ｯｼ")  --增
  t = string.gsub(t, "lyu", "ｭ")  --增
  t = string.gsub(t, "lyo", "ｮ")  --增
  t = string.gsub(t, "lya", "ｬ")  --增
  t = string.gsub(t, "hhu", "ｯﾌ")  --增
  -- t = string.gsub(t, "jju", "ｯﾁﾞｭ")  --增
  -- t = string.gsub(t, "jjo", "ｯﾁﾞｮ")  --增
  -- t = string.gsub(t, "jja", "ｯﾁﾞｬ")  --增
  t = string.gsub(t, "zu", "ｽﾞ")
  t = string.gsub(t, "zo", "ｿﾞ")
  t = string.gsub(t, "ze", "ｾﾞ")
  t = string.gsub(t, "za", "ｻﾞ")
  t = string.gsub(t, "yu", "ﾕ")
  t = string.gsub(t, "yo", "ﾖ")
  t = string.gsub(t, "yi", "ｲｨ")
  t = string.gsub(t, "ye", "ｲｪ")
  t = string.gsub(t, "ya", "ﾔ")
  t = string.gsub(t, "xu", "ｩ")
  t = string.gsub(t, "xo", "ｫ")
  t = string.gsub(t, "xi", "ｨ")
  t = string.gsub(t, "xe", "ｪ")
  t = string.gsub(t, "xa", "ｧ")
  t = string.gsub(t, "wo", "ｦ")
  t = string.gsub(t, "wi", "ｳｨ")
  t = string.gsub(t, "we", "ｳｪ")
  t = string.gsub(t, "wa", "ﾜ")
  t = string.gsub(t, "vu", "ｳﾞ")
  t = string.gsub(t, "vo", "ｦﾞ")
  -- t = string.gsub(t, "vo", "ｳﾞｫ")
  t = string.gsub(t, "vi", "ｳﾞｨ")
  t = string.gsub(t, "ve", "ｳﾞｪ")
  t = string.gsub(t, "va", "ﾜﾞ")
  -- t = string.gsub(t, "va", "ｳﾞｧ")
  t = string.gsub(t, "to", "ﾄ")
  t = string.gsub(t, "te", "ﾃ")
  t = string.gsub(t, "ta", "ﾀ")
  t = string.gsub(t, "su", "ｽ")
  t = string.gsub(t, "so", "ｿ")
  t = string.gsub(t, "se", "ｾ")
  t = string.gsub(t, "sa", "ｻ")
  t = string.gsub(t, "ru", "ﾙ")
  t = string.gsub(t, "ro", "ﾛ")
  t = string.gsub(t, "ri", "ﾘ")
  t = string.gsub(t, "re", "ﾚ")
  t = string.gsub(t, "ra", "ﾗ")
  t = string.gsub(t, "pu", "ﾌﾟ")
  t = string.gsub(t, "po", "ﾎﾟ")
  t = string.gsub(t, "pi", "ﾋﾟ")
  t = string.gsub(t, "pe", "ﾍﾟ")
  t = string.gsub(t, "pa", "ﾊﾟ")
  t = string.gsub(t, "ov", "ﾟ")
  t = string.gsub(t, "nu", "ﾇ")
  t = string.gsub(t, "no", "ﾉ")
  t = string.gsub(t, "ni", "ﾆ")
  t = string.gsub(t, "ne", "ﾈ")
  t = string.gsub(t, "na", "ﾅ")
  t = string.gsub(t, "mu", "ﾑ")
  t = string.gsub(t, "mo", "ﾓ")
  t = string.gsub(t, "mi", "ﾐ")
  t = string.gsub(t, "me", "ﾒ")
  t = string.gsub(t, "ma", "ﾏ")
  t = string.gsub(t, "lu", "ﾙﾟ")
  t = string.gsub(t, "lo", "ﾛﾟ")
  t = string.gsub(t, "li", "ﾘﾟ")
  t = string.gsub(t, "le", "ﾚﾟ")
  t = string.gsub(t, "la", "ﾗﾟ")
  t = string.gsub(t, "ku", "ｸ")
  t = string.gsub(t, "ko", "ｺ")
  t = string.gsub(t, "ki", "ｷ")
  t = string.gsub(t, "ke", "ｹ")
  t = string.gsub(t, "ka", "ｶ")
  t = string.gsub(t, "ju", "ｼﾞｭ")
  t = string.gsub(t, "jo", "ｼﾞｮ")
  t = string.gsub(t, "ja", "ｼﾞｬ")
  t = string.gsub(t, "ji", "ｼﾞ")
  t = string.gsub(t, "je", "ｼﾞｪ")
  t = string.gsub(t, "ho", "ﾎ")
  t = string.gsub(t, "hi", "ﾋ")
  t = string.gsub(t, "he", "ﾍ")
  t = string.gsub(t, "ha", "ﾊ")
  t = string.gsub(t, "gu", "ｸﾞ")
  t = string.gsub(t, "go", "ｺﾞ")
  t = string.gsub(t, "gi", "ｷﾞ")
  t = string.gsub(t, "ge", "ｹﾞ")
  t = string.gsub(t, "ga", "ｶﾞ")
  t = string.gsub(t, "fu", "ﾌ")
  t = string.gsub(t, "fo", "ﾌｫ")
  t = string.gsub(t, "fi", "ﾌｨ")
  t = string.gsub(t, "fe", "ﾌｪ")
  t = string.gsub(t, "fa", "ﾌｧ")
  t = string.gsub(t, "du", "ﾂﾞ")
  t = string.gsub(t, "do", "ﾄﾞ")
  t = string.gsub(t, "di", "ﾁﾞ")
  t = string.gsub(t, "de", "ﾃﾞ")
  t = string.gsub(t, "da", "ﾀﾞ")
  t = string.gsub(t, "bu", "ﾌﾞ")
  t = string.gsub(t, "bo", "ﾎﾞ")
  t = string.gsub(t, "bi", "ﾋﾞ")
  t = string.gsub(t, "be", "ﾍﾞ")
  t = string.gsub(t, "ba", "ﾊﾞ")
  t = string.gsub(t, "ev", "ｰ")
  t = string.gsub(t, "bv", "ﾞ")
  t = string.gsub(t, "av", "･")
  t = string.gsub(t, "si", "ｼ")  --增
  t = string.gsub(t, "ti", "ﾁ")  --增
  t = string.gsub(t, "hu", "ﾌ")  --增
  t = string.gsub(t, "zi", "ｼﾞ")  --增
  t = string.gsub(t, "tu", "ﾂ")  --增
  -- t = string.gsub(t, "lu", "ｩ")  --增
  -- t = string.gsub(t, "lo", "ｫ")  --增
  -- t = string.gsub(t, "li", "ｨ")  --增
  -- t = string.gsub(t, "le", "ｪ")  --增
  -- t = string.gsub(t, "la", "ｧ")  --增
  t = string.gsub(t, "q", "ｯ")
  t = string.gsub(t, "u", "ｳ")
  t = string.gsub(t, "o", "ｵ")
  t = string.gsub(t, "n", "ﾝ")
  t = string.gsub(t, "i", "ｲ")
  t = string.gsub(t, "e", "ｴ")
  t = string.gsub(t, "a", "ｱ")
  t = string.gsub(t, "/", "･")
  t = string.gsub(t, "-", "ｰ")
  t = string.gsub(t, "[.,;]", "")
  return t
end

local function kata_t(t)
  if t == "" then return "" end
  t = string.gsub(t, "ｶﾞ", "ガ")
  t = string.gsub(t, "ｷﾞ", "ギ")
  t = string.gsub(t, "ｸﾞ", "グ")
  t = string.gsub(t, "ｹﾞ", "ゲ")
  t = string.gsub(t, "ｺﾞ", "ゴ")
  t = string.gsub(t, "ｻﾞ", "ザ")
  t = string.gsub(t, "ｼﾞ", "ジ")
  t = string.gsub(t, "ｽﾞ", "ズ")
  t = string.gsub(t, "ｾﾞ", "ゼ")
  t = string.gsub(t, "ｿﾞ", "ゾ")
  t = string.gsub(t, "ﾀﾞ", "ダ")
  t = string.gsub(t, "ﾁﾞ", "ヂ")
  t = string.gsub(t, "ﾂﾞ", "ヅ")
  t = string.gsub(t, "ﾃﾞ", "デ")
  t = string.gsub(t, "ﾄﾞ", "ド")
  t = string.gsub(t, "ﾊﾞ", "バ")
  t = string.gsub(t, "ﾋﾞ", "ビ")
  t = string.gsub(t, "ﾌﾞ", "ブ")
  t = string.gsub(t, "ﾍﾞ", "ベ")
  t = string.gsub(t, "ﾎﾞ", "ボ")
  t = string.gsub(t, "ﾊﾟ", "パ")
  t = string.gsub(t, "ﾋﾟ", "ピ")
  t = string.gsub(t, "ﾌﾟ", "プ")
  t = string.gsub(t, "ﾍﾟ", "ぺ")
  t = string.gsub(t, "ﾎﾟ", "ポ")
  t = string.gsub(t, "ｳﾞ", "ヴ")
  t = string.gsub(t, "ﾜﾞ", "ヷ")
  t = string.gsub(t, "ｦﾞ", "ヺ")
  t = string.gsub(t, "ｱ", "ア")
  t = string.gsub(t, "ｲ", "イ")
  t = string.gsub(t, "ｳ", "ウ")
  t = string.gsub(t, "ｴ", "エ")
  t = string.gsub(t, "ｵ", "オ")
  t = string.gsub(t, "ｶ", "カ")
  t = string.gsub(t, "ｷ", "キ")
  t = string.gsub(t, "ｸ", "ク")
  t = string.gsub(t, "ｹ", "ケ")
  t = string.gsub(t, "ｺ", "コ")
  t = string.gsub(t, "ｻ", "サ")
  t = string.gsub(t, "ｼ", "シ")
  t = string.gsub(t, "ｽ", "ス")
  t = string.gsub(t, "ｾ", "セ")
  t = string.gsub(t, "ｿ", "ソ")
  t = string.gsub(t, "ﾀ", "タ")
  t = string.gsub(t, "ﾁ", "チ")
  t = string.gsub(t, "ﾂ", "ツ")
  t = string.gsub(t, "ﾃ", "テ")
  t = string.gsub(t, "ﾄ", "ト")
  t = string.gsub(t, "ﾅ", "ナ")
  t = string.gsub(t, "ﾆ", "ニ")
  t = string.gsub(t, "ﾇ", "ヌ")
  t = string.gsub(t, "ﾈ", "ネ")
  t = string.gsub(t, "ﾉ", "ノ")
  t = string.gsub(t, "ﾊ", "ハ")
  t = string.gsub(t, "ﾋ", "ヒ")
  t = string.gsub(t, "ﾌ", "フ")
  t = string.gsub(t, "ﾍ", "ヘ")
  t = string.gsub(t, "ﾎ", "ホ")
  t = string.gsub(t, "ﾏ", "マ")
  t = string.gsub(t, "ﾐ", "ミ")
  t = string.gsub(t, "ﾑ", "ム")
  t = string.gsub(t, "ﾒ", "メ")
  t = string.gsub(t, "ﾓ", "モ")
  t = string.gsub(t, "ﾔ", "ヤ")
  t = string.gsub(t, "ﾕ", "ユ")
  t = string.gsub(t, "ﾖ", "ヨ")
  t = string.gsub(t, "ﾗ", "ラ")
  t = string.gsub(t, "ﾘ", "リ")
  t = string.gsub(t, "ﾙ", "ル")
  t = string.gsub(t, "ﾚ", "レ")
  t = string.gsub(t, "ﾛ", "ロ")
  t = string.gsub(t, "ﾜ", "ワ")
  t = string.gsub(t, "ｦ", "ヲ")
  t = string.gsub(t, "ﾝ", "ン")
  t = string.gsub(t, "ｧ", "ァ")
  t = string.gsub(t, "ｨ", "ィ")
  t = string.gsub(t, "ｩ", "ゥ")
  t = string.gsub(t, "ｪ", "ェ")
  t = string.gsub(t, "ｫ", "ォ")
  t = string.gsub(t, "ｬ", "ャ")
  t = string.gsub(t, "ｭ", "ュ")
  t = string.gsub(t, "ｮ", "ョ")
  t = string.gsub(t, "ｯ", "ッ")
  t = string.gsub(t, "･", "・")
  t = string.gsub(t, "ｰ", "ー")
  t = string.gsub(t, "ﾞ", "゛")
  t = string.gsub(t, "ﾟ", "゜")
  -- t = string.gsub(t, "[.,;]", "")
  return t
end

local function hira_t(t)
  if t == "" then return "" end
  t = string.gsub(t, "ｶﾞ", "が")
  t = string.gsub(t, "ｷﾞ", "ぎ")
  t = string.gsub(t, "ｸﾞ", "ぐ")
  t = string.gsub(t, "ｹﾞ", "げ")
  t = string.gsub(t, "ｺﾞ", "ご")
  t = string.gsub(t, "ｻﾞ", "ざ")
  t = string.gsub(t, "ｼﾞ", "じ")
  t = string.gsub(t, "ｽﾞ", "ず")
  t = string.gsub(t, "ｾﾞ", "ぜ")
  t = string.gsub(t, "ｿﾞ", "ぞ")
  t = string.gsub(t, "ﾀﾞ", "だ")
  t = string.gsub(t, "ﾁﾞ", "ぢ")
  t = string.gsub(t, "ﾂﾞ", "づ")
  t = string.gsub(t, "ﾃﾞ", "で")
  t = string.gsub(t, "ﾄﾞ", "ど")
  t = string.gsub(t, "ﾊﾞ", "ば")
  t = string.gsub(t, "ﾋﾞ", "び")
  t = string.gsub(t, "ﾌﾞ", "ぶ")
  t = string.gsub(t, "ﾍﾞ", "べ")
  t = string.gsub(t, "ﾎﾞ", "ぼ")
  t = string.gsub(t, "ﾊﾟ", "ぱ")
  t = string.gsub(t, "ﾋﾟ", "ぴ")
  t = string.gsub(t, "ﾌﾟ", "ぷ")
  t = string.gsub(t, "ﾍﾟ", "ぺ")
  t = string.gsub(t, "ﾎﾟ", "ぽ")
  t = string.gsub(t, "ｳﾞ", "ゔ")
  -- t = string.gsub(t, "ﾜﾞ", "")
  -- t = string.gsub(t, "ｦﾞ", "")
  t = string.gsub(t, "ｱ", "あ")
  t = string.gsub(t, "ｲ", "い")
  t = string.gsub(t, "ｳ", "う")
  t = string.gsub(t, "ｴ", "え")
  t = string.gsub(t, "ｵ", "お")
  t = string.gsub(t, "ｶ", "か")
  t = string.gsub(t, "ｷ", "き")
  t = string.gsub(t, "ｸ", "く")
  t = string.gsub(t, "ｹ", "け")
  t = string.gsub(t, "ｺ", "こ")
  t = string.gsub(t, "ｻ", "さ")
  t = string.gsub(t, "ｼ", "し")
  t = string.gsub(t, "ｽ", "す")
  t = string.gsub(t, "ｾ", "せ")
  t = string.gsub(t, "ｿ", "そ")
  t = string.gsub(t, "ﾀ", "た")
  t = string.gsub(t, "ﾁ", "ち")
  t = string.gsub(t, "ﾂ", "つ")
  t = string.gsub(t, "ﾃ", "て")
  t = string.gsub(t, "ﾄ", "と")
  t = string.gsub(t, "ﾅ", "な")
  t = string.gsub(t, "ﾆ", "に")
  t = string.gsub(t, "ﾇ", "ぬ")
  t = string.gsub(t, "ﾈ", "ね")
  t = string.gsub(t, "ﾉ", "の")
  t = string.gsub(t, "ﾊ", "は")
  t = string.gsub(t, "ﾋ", "ひ")
  t = string.gsub(t, "ﾌ", "ふ")
  t = string.gsub(t, "ﾍ", "へ")
  t = string.gsub(t, "ﾎ", "ほ")
  t = string.gsub(t, "ﾏ", "ま")
  t = string.gsub(t, "ﾐ", "み")
  t = string.gsub(t, "ﾑ", "む")
  t = string.gsub(t, "ﾒ", "め")
  t = string.gsub(t, "ﾓ", "も")
  t = string.gsub(t, "ﾔ", "や")
  t = string.gsub(t, "ﾕ", "ゆ")
  t = string.gsub(t, "ﾖ", "よ")
  t = string.gsub(t, "ﾗ", "ら")
  t = string.gsub(t, "ﾘ", "り")
  t = string.gsub(t, "ﾙ", "る")
  t = string.gsub(t, "ﾚ", "れ")
  t = string.gsub(t, "ﾛ", "ろ")
  t = string.gsub(t, "ﾜ", "わ")
  t = string.gsub(t, "ｦ", "を")
  t = string.gsub(t, "ﾝ", "ん")
  t = string.gsub(t, "ｧ", "ぁ")
  t = string.gsub(t, "ｨ", "ぃ")
  t = string.gsub(t, "ｩ", "ぅ")
  t = string.gsub(t, "ｪ", "ぇ")
  t = string.gsub(t, "ｫ", "ぉ")
  t = string.gsub(t, "ｬ", "ゃ")
  t = string.gsub(t, "ｭ", "ゅ")
  t = string.gsub(t, "ｮ", "ょ")
  t = string.gsub(t, "ｯ", "っ")
  t = string.gsub(t, "･", "・")
  t = string.gsub(t, "ｰ", "ー")
  t = string.gsub(t, "ﾞ", "゛")
  t = string.gsub(t, "ﾟ", "゜")
  -- t = string.gsub(t, "[.,;]", "")
  return t
end

return {
    revise_t = revise_t,
    fullshape_t = fullshape_t,
    halfwidth_kata_t = halfwidth_kata_t,
    kata_t = kata_t,
    hira_t = hira_t,
}