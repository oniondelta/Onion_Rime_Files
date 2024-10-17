--[[
number_translator: 將 `'/` + 阿拉伯數字 和 英文字母 各種轉譯
--]]

------------------------------------

local convert_format = require("filter_cand/convert_format")

------------------------------------

local function english_s(en)
  if en == "" then return "" end
  return string.gsub(en, "%./", " ")
end

local function english_u2(en)
  if en == "" then return "" end
  -- if string.match(en, "^[/.'-][a-z]") then
  --   en = string.upper(string.sub(en,1,2)) .. string.sub(en,3)
  -- end
  en = string.gsub(en, "^['.]%l", string.upper)
  return string.gsub(en, "[/-]%l", string.upper)
end

local function english_u1(en)
  if en == "" then return "" end
  -- en = string.upper(string.sub(en,1,1)) .. string.sub(english_u2(english_s(en)),2)
  -- return en
  en = english_s(en)
  return string.gsub(en, "^%l", string.upper)
end

local function english_s2u(en)
  if en == "" then return "" end
  en = english_u1(en)
  en = english_u2(en)
  return string.gsub(en, " %l", string.upper)
end

------------------------------------
--- 以下新的寫法

local function english_mds_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝔸𝔹ℂ𝔻𝔼𝔽𝔾ℍ𝕀𝕁𝕂𝕃𝕄ℕ𝕆ℙℚℝ𝕊𝕋𝕌𝕍𝕎𝕏𝕐ℤ|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mds_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝕒𝕓𝕔𝕕𝕖𝕗𝕘𝕙𝕚𝕛𝕜𝕝𝕞𝕟𝕠𝕡𝕢𝕣𝕤𝕥𝕦𝕧𝕨𝕩𝕪𝕫|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_3(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ |ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ　|"
  local format2 = "xform|[.]/|　|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_4(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz |ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ　|"
  local format2 = "xform|[.]/|　|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_5(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ |🄐🄑🄒🄓🄔🄕🄖🄗🄘🄙🄚🄛🄜🄝🄞🄟🄠🄡🄢🄣🄤🄥🄦🄧🄨🄩　|"
  local format2 = "xform|[.]/|　|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_6(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz |⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨⒩⒪⒫⒬⒭⒮⒯⒰⒱⒲⒳⒴⒵　|"
  local format2 = "xform|[.]/|　|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_7(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|🄰🄱🄲🄳🄴🄵🄶🄷🄸🄹🄺🄻🄼🄽🄾🄿🅀🅁🅂🅃🅄🅅🅆🅇🅈🅉|"
  local format2 = "xform|[.]/|　|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_8(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|🅐🅑🅒🅓🅔🅕🅖🅗🅘🅙🅚🅛🅜🅝🅞🅟🅠🅡🅢🅣🅤🅥🅦🅧🅨🅩|"
  local format2 = "xform|[.]/|　|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_9(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|🅰🅱🅲🅳🅴🅵🅶🅷🅸🅹🅺🅻🅼🅽🅾🅿🆀🆁🆂🆃🆄🆅🆆🆇🆈🆉|"
  local format2 = "xform|[.]/|　|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_f_u(t)
  if t == "" then return "" end
  local format1 = "xform|[.]/|　|"
  local format2 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-/'|ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ　，．－／＇|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_f_l(t)
  if t == "" then return "" end
  local format1 = "xform|[.]/|　|"
  local format2 = "xlit|abcdefghijklmnopqrstuvwxyz ,.-/'|ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ　，．－／＇|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_s_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ|"
  local format2 = "xform|[.]/|　|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_ms_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝒜ℬ𝒞𝒟ℰℱ𝒢ℋℐ𝒥𝒦ℒℳ𝒩𝒪𝒫𝒬ℛ𝒮𝒯𝒰𝒱𝒲𝒳𝒴𝒵|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_ms_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝒶𝒷𝒸𝒹ℯ𝒻ℊ𝒽𝒾𝒿𝓀𝓁𝓂𝓃ℴ𝓅𝓆𝓇𝓈𝓉𝓊𝓋𝓌𝓍𝓎𝓏|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mf_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝔄𝔅ℭ𝔇𝔈𝔉𝔊ℌℑ𝔍𝔎𝔏𝔐𝔑𝔒𝔓𝔔ℜ𝔖𝔗𝔘𝔙𝔚𝔛𝔜ℨ|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mf_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝔞𝔟𝔠𝔡𝔢𝔣𝔤𝔥𝔦𝔧𝔨𝔩𝔪𝔫𝔬𝔭𝔮𝔯𝔰𝔱𝔲𝔳𝔴𝔵𝔶𝔷|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mss_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝖠𝖡𝖢𝖣𝖤𝖥𝖦𝖧𝖨𝖩𝖪𝖫𝖬𝖭𝖮𝖯𝖰𝖱𝖲𝖳𝖴𝖵𝖶𝖷𝖸𝖹|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mss_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝖺𝖻𝖼𝖽𝖾𝖿𝗀𝗁𝗂𝗃𝗄𝗅𝗆𝗇𝗈𝗉𝗊𝗋𝗌𝗍𝗎𝗏𝗐𝗑𝗒𝗓|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mssi_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝘈𝘉𝘊𝘋𝘌𝘍𝘎𝘏𝘐𝘑𝘒𝘓𝘔𝘕𝘖𝘗𝘘𝘙𝘚𝘛𝘜𝘝𝘞𝘟𝘠𝘡|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mssi_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝘢𝘣𝘤𝘥𝘦𝘧𝘨𝘩𝘪𝘫𝘬𝘭𝘮𝘯𝘰𝘱𝘲𝘳𝘴𝘵𝘶𝘷𝘸𝘹𝘺𝘻|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mssb_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝗔𝗕𝗖𝗗𝗘𝗙𝗚𝗛𝗜𝗝𝗞𝗟𝗠𝗡𝗢𝗣𝗤𝗥𝗦𝗧𝗨𝗩𝗪𝗫𝗬𝗭|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mssb_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝗮𝗯𝗰𝗱𝗲𝗳𝗴𝗵𝗶𝗷𝗸𝗹𝗺𝗻𝗼𝗽𝗾𝗿𝘀𝘁𝘂𝘃𝘄𝘅𝘆𝘇|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mssbi_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝘼𝘽𝘾𝘿𝙀𝙁𝙂𝙃𝙄𝙅𝙆𝙇𝙈𝙉𝙊𝙋𝙌𝙍𝙎𝙏𝙐𝙑𝙒𝙓𝙔𝙕|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mssbi_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝙖𝙗𝙘𝙙𝙚𝙛𝙜𝙝𝙞𝙟𝙠𝙡𝙢𝙣𝙤𝙥𝙦𝙧𝙨𝙩𝙪𝙫𝙬𝙭𝙮𝙯|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mi_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑋𝑌𝑍|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mi_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝑎𝑏𝑐𝑑𝑒𝑓𝑔ℎ𝑖𝑗𝑘𝑙𝑚𝑛𝑜𝑝𝑞𝑟𝑠𝑡𝑢𝑣𝑤𝑥𝑦𝑧|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mm_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝙰𝙱𝙲𝙳𝙴𝙵𝙶𝙷𝙸𝙹𝙺𝙻𝙼𝙽𝙾𝙿𝚀𝚁𝚂𝚃𝚄𝚅𝚆𝚇𝚈𝚉|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mm_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝚊𝚋𝚌𝚍𝚎𝚏𝚐𝚑𝚒𝚓𝚔𝚕𝚖𝚗𝚘𝚙𝚚𝚛𝚜𝚝𝚞𝚟𝚠𝚡𝚢𝚣|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mb_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝐀𝐁𝐂𝐃𝐄𝐅𝐆𝐇𝐈𝐉𝐊𝐋𝐌𝐍𝐎𝐏𝐐𝐑𝐒𝐓𝐔𝐕𝐖𝐗𝐘𝐙|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mb_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝐚𝐛𝐜𝐝𝐞𝐟𝐠𝐡𝐢𝐣𝐤𝐥𝐦𝐧𝐨𝐩𝐪𝐫𝐬𝐭𝐮𝐯𝐰𝐱𝐲𝐳|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mbi_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝑨𝑩𝑪𝑫𝑬𝑭𝑮𝑯𝑰𝑱𝑲𝑳𝑴𝑵𝑶𝑷𝑸𝑹𝑺𝑻𝑼𝑽𝑾𝑿𝒀𝒁|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mbi_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝒂𝒃𝒄𝒅𝒆𝒇𝒈𝒉𝒊𝒋𝒌𝒍𝒎𝒏𝒐𝒑𝒒𝒓𝒔𝒕𝒖𝒗𝒘𝒙𝒚𝒛|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mbs_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝓐𝓑𝓒𝓓𝓔𝓕𝓖𝓗𝓘𝓙𝓚𝓛𝓜𝓝𝓞𝓟𝓠𝓡𝓢𝓣𝓤𝓥𝓦𝓧𝓨𝓩|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mbs_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝓪𝓫𝓬𝓭𝓮𝓯𝓰𝓱𝓲𝓳𝓴𝓵𝓶𝓷𝓸𝓹𝓺𝓻𝓼𝓽𝓾𝓿𝔀𝔁𝔂𝔃|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mbf_u(t)
  if t == "" then return "" end
  local format1 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ|𝕬𝕭𝕮𝕯𝕰𝕱𝕲𝕳𝕴𝕵𝕶𝕷𝕸𝕹𝕺𝕻𝕼𝕽𝕾𝕿𝖀𝖁𝖂𝖃𝖄𝖅|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_mbf_l(t)
  if t == "" then return "" end
  local format1 = "xlit|abcdefghijklmnopqrstuvwxyz|𝖆𝖇𝖈𝖉𝖊𝖋𝖌𝖍𝖎𝖏𝖐𝖑𝖒𝖓𝖔𝖕𝖖𝖗𝖘𝖙𝖚𝖛𝖜𝖝𝖞𝖟|"
  local format2 = "xform|[.]/| |"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end


--- 以下參考：https://liblouis.io/translate/

local function english_braille_c_u(t)
  if t == "" then return "" end
  local format1 = "xform|[.]/|⠀|"
  local format2 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-/'|⡁⡃⡉⡙⡑⡋⡛⡓⡊⡚⡅⡇⡍⡝⡕⡏⡟⡗⡎⡞⡥⡧⡺⡭⡽⡵⠀⠠⠨⠤⠌⠄|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_braille_c_l(t)
  if t == "" then return "" end
  local format1 = "xform|[.]/|⠀|"
  local format2 = "xlit|abcdefghijklmnopqrstuvwxyz ,.-/'|⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵⠀⠠⠨⠤⠌⠄|"
  local proj = convert_format(format1,format2)
  return proj:apply(t)
end

local function english_braille_u_u(t)
  if t == "" then return "" end
  local format1 = "xform|[.]/|⠀|"
  local format2 = "xform|([A-Za-z]),([A-Za-z])|$1⠰⠂$2|"  -- "xform|([^.,/'-])[,]([^.,/'-])|$1⠰⠂$2|"
  local format3 = "xform|([^A-Z])([A-Z]+)|$1⠠$2|"
  local format4 = "xform|^([A-Z])|⠠$1|"
  local format5 = "xform|(⠠)([A-Z][A-Z]+)|$1$1$2|"
  local format6 = "xform|[/]|⠸⠌|"
  -- local format7 = "xform|([^.])[.]$|$1⠲|"
  -- local format8 = "xform|[']⠀|⠴⠄⠀|"
  local format7 = "xlit|ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'|⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵⠀⠂⠲⠤⠄|"
  local proj = convert_format(format1,format2,format3,format4,format5,format6,format7)
  return proj:apply(t)
end

local function english_braille_u_l(t)
  if t == "" then return "" end
  local format1 = "xform|[.]/|⠀|"
  local format2 = "xform|([A-Za-z]),([A-Za-z])|$1⠰⠂$2|"
  local format3 = "xform|[/]|⠸⠌|"
  -- local format3 = "xform|([^.])[.]$|$1⠲|"
  -- local format3 = "xform|[']⠀|⠴⠄⠀|"
  local format4 = "xlit|abcdefghijklmnopqrstuvwxyz ,.-/'|⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵⠀⠂⠲⠤⠌⠄|"
  local proj = convert_format(format1,format2,format3,format4)
  return proj:apply(t)
end

------------------------------------
--- 以下舊的寫法（備份參考）
--[[
local function english_mds_u(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "𝔸")
  en = string.gsub(en, "B", "𝔹")
  en = string.gsub(en, "C", "ℂ")
  en = string.gsub(en, "D", "𝔻")
  en = string.gsub(en, "E", "𝔼")
  en = string.gsub(en, "F", "𝔽")
  en = string.gsub(en, "G", "𝔾")
  en = string.gsub(en, "H", "ℍ")
  en = string.gsub(en, "I", "𝕀")
  en = string.gsub(en, "J", "𝕁")
  en = string.gsub(en, "K", "𝕂")
  en = string.gsub(en, "L", "𝕃")
  en = string.gsub(en, "M", "𝕄")
  en = string.gsub(en, "N", "ℕ")
  en = string.gsub(en, "O", "𝕆")
  en = string.gsub(en, "P", "ℙ")
  en = string.gsub(en, "Q", "ℚ")
  en = string.gsub(en, "R", "ℝ")
  en = string.gsub(en, "S", "𝕊")
  en = string.gsub(en, "T", "𝕋")
  en = string.gsub(en, "U", "𝕌")
  en = string.gsub(en, "V", "𝕍")
  en = string.gsub(en, "W", "𝕎")
  en = string.gsub(en, "X", "𝕏")
  en = string.gsub(en, "Y", "𝕐")
  en = string.gsub(en, "Z", "ℤ")
  en = string.gsub(en, "%./", " ")
  return en
end

local function english_mds_l(en)
  if en == "" then return "" end
  en = string.gsub(en, "a", "𝕒")
  en = string.gsub(en, "b", "𝕓")
  en = string.gsub(en, "c", "𝕔")
  en = string.gsub(en, "d", "𝕕")
  en = string.gsub(en, "e", "𝕖")
  en = string.gsub(en, "f", "𝕗")
  en = string.gsub(en, "g", "𝕘")
  en = string.gsub(en, "h", "𝕙")
  en = string.gsub(en, "i", "𝕚")
  en = string.gsub(en, "j", "𝕛")
  en = string.gsub(en, "k", "𝕜")
  en = string.gsub(en, "l", "𝕝")
  en = string.gsub(en, "m", "𝕞")
  en = string.gsub(en, "n", "𝕟")
  en = string.gsub(en, "o", "𝕠")
  en = string.gsub(en, "p", "𝕡")
  en = string.gsub(en, "q", "𝕢")
  en = string.gsub(en, "r", "𝕣")
  en = string.gsub(en, "s", "𝕤")
  en = string.gsub(en, "t", "𝕥")
  en = string.gsub(en, "u", "𝕦")
  en = string.gsub(en, "v", "𝕧")
  en = string.gsub(en, "w", "𝕨")
  en = string.gsub(en, "x", "𝕩")
  en = string.gsub(en, "y", "𝕪")
  en = string.gsub(en, "z", "𝕫")
  en = string.gsub(en, "%./", " ")
  return en
end

local function english_3(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "Ⓐ")
  en = string.gsub(en, "B", "Ⓑ")
  en = string.gsub(en, "C", "Ⓒ")
  en = string.gsub(en, "D", "Ⓓ")
  en = string.gsub(en, "E", "Ⓔ")
  en = string.gsub(en, "F", "Ⓕ")
  en = string.gsub(en, "G", "Ⓖ")
  en = string.gsub(en, "H", "Ⓗ")
  en = string.gsub(en, "I", "Ⓘ")
  en = string.gsub(en, "J", "Ⓙ")
  en = string.gsub(en, "K", "Ⓚ")
  en = string.gsub(en, "L", "Ⓛ")
  en = string.gsub(en, "M", "Ⓜ")
  en = string.gsub(en, "N", "Ⓝ")
  en = string.gsub(en, "O", "Ⓞ")
  en = string.gsub(en, "P", "Ⓟ")
  en = string.gsub(en, "Q", "Ⓠ")
  en = string.gsub(en, "R", "Ⓡ")
  en = string.gsub(en, "S", "Ⓢ")
  en = string.gsub(en, "T", "Ⓣ")
  en = string.gsub(en, "U", "Ⓤ")
  en = string.gsub(en, "V", "Ⓥ")
  en = string.gsub(en, "W", "Ⓦ")
  en = string.gsub(en, "X", "Ⓧ")
  en = string.gsub(en, "Y", "Ⓨ")
  en = string.gsub(en, "Z", "Ⓩ")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  return en
end

local function english_4(en)
  if en == "" then return "" end
  en = string.gsub(en, "a", "ⓐ")
  en = string.gsub(en, "b", "ⓑ")
  en = string.gsub(en, "c", "ⓒ")
  en = string.gsub(en, "d", "ⓓ")
  en = string.gsub(en, "e", "ⓔ")
  en = string.gsub(en, "f", "ⓕ")
  en = string.gsub(en, "g", "ⓖ")
  en = string.gsub(en, "h", "ⓗ")
  en = string.gsub(en, "i", "ⓘ")
  en = string.gsub(en, "j", "ⓙ")
  en = string.gsub(en, "k", "ⓚ")
  en = string.gsub(en, "l", "ⓛ")
  en = string.gsub(en, "m", "ⓜ")
  en = string.gsub(en, "n", "ⓝ")
  en = string.gsub(en, "o", "ⓞ")
  en = string.gsub(en, "p", "ⓟ")
  en = string.gsub(en, "q", "ⓠ")
  en = string.gsub(en, "r", "ⓡ")
  en = string.gsub(en, "s", "ⓢ")
  en = string.gsub(en, "t", "ⓣ")
  en = string.gsub(en, "u", "ⓤ")
  en = string.gsub(en, "v", "ⓥ")
  en = string.gsub(en, "w", "ⓦ")
  en = string.gsub(en, "x", "ⓧ")
  en = string.gsub(en, "y", "ⓨ")
  en = string.gsub(en, "z", "ⓩ")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  return en
end

local function english_5(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "🄐")
  en = string.gsub(en, "B", "🄑")
  en = string.gsub(en, "C", "🄒")
  en = string.gsub(en, "D", "🄓")
  en = string.gsub(en, "E", "🄔")
  en = string.gsub(en, "F", "🄕")
  en = string.gsub(en, "G", "🄖")
  en = string.gsub(en, "H", "🄗")
  en = string.gsub(en, "I", "🄘")
  en = string.gsub(en, "J", "🄙")
  en = string.gsub(en, "K", "🄚")
  en = string.gsub(en, "L", "🄛")
  en = string.gsub(en, "M", "🄜")
  en = string.gsub(en, "N", "🄝")
  en = string.gsub(en, "O", "🄞")
  en = string.gsub(en, "P", "🄟")
  en = string.gsub(en, "Q", "🄠")
  en = string.gsub(en, "R", "🄡")
  en = string.gsub(en, "S", "🄢")
  en = string.gsub(en, "T", "🄣")
  en = string.gsub(en, "U", "🄤")
  en = string.gsub(en, "V", "🄥")
  en = string.gsub(en, "W", "🄦")
  en = string.gsub(en, "X", "🄧")
  en = string.gsub(en, "Y", "🄨")
  en = string.gsub(en, "Z", "🄩")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  return en
end

local function english_6(en)
  if en == "" then return "" end
  en = string.gsub(en, "a", "⒜")
  en = string.gsub(en, "b", "⒝")
  en = string.gsub(en, "c", "⒞")
  en = string.gsub(en, "d", "⒟")
  en = string.gsub(en, "e", "⒠")
  en = string.gsub(en, "f", "⒡")
  en = string.gsub(en, "g", "⒢")
  en = string.gsub(en, "h", "⒣")
  en = string.gsub(en, "i", "⒤")
  en = string.gsub(en, "j", "⒥")
  en = string.gsub(en, "k", "⒦")
  en = string.gsub(en, "l", "⒧")
  en = string.gsub(en, "m", "⒨")
  en = string.gsub(en, "n", "⒩")
  en = string.gsub(en, "o", "⒪")
  en = string.gsub(en, "p", "⒫")
  en = string.gsub(en, "q", "⒬")
  en = string.gsub(en, "r", "⒭")
  en = string.gsub(en, "s", "⒮")
  en = string.gsub(en, "t", "⒯")
  en = string.gsub(en, "u", "⒰")
  en = string.gsub(en, "v", "⒱")
  en = string.gsub(en, "w", "⒲")
  en = string.gsub(en, "x", "⒳")
  en = string.gsub(en, "y", "⒴")
  en = string.gsub(en, "z", "⒵")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  return en
end

local function english_7(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "🄰")
  en = string.gsub(en, "B", "🄱")
  en = string.gsub(en, "C", "🄲")
  en = string.gsub(en, "D", "🄳")
  en = string.gsub(en, "E", "🄴")
  en = string.gsub(en, "F", "🄵")
  en = string.gsub(en, "G", "🄶")
  en = string.gsub(en, "H", "🄷")
  en = string.gsub(en, "I", "🄸")
  en = string.gsub(en, "J", "🄹")
  en = string.gsub(en, "K", "🄺")
  en = string.gsub(en, "L", "🄻")
  en = string.gsub(en, "M", "🄼")
  en = string.gsub(en, "N", "🄽")
  en = string.gsub(en, "O", "🄾")
  en = string.gsub(en, "P", "🄿")
  en = string.gsub(en, "Q", "🅀")
  en = string.gsub(en, "R", "🅁")
  en = string.gsub(en, "S", "🅂")
  en = string.gsub(en, "T", "🅃")
  en = string.gsub(en, "U", "🅄")
  en = string.gsub(en, "V", "🅅")
  en = string.gsub(en, "W", "🅆")
  en = string.gsub(en, "X", "🅇")
  en = string.gsub(en, "Y", "🅈")
  en = string.gsub(en, "Z", "🅉")
  en = string.gsub(en, "%./", "　")
  return en
end

local function english_8(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "🅐")
  en = string.gsub(en, "B", "🅑")
  en = string.gsub(en, "C", "🅒")
  en = string.gsub(en, "D", "🅓")
  en = string.gsub(en, "E", "🅔")
  en = string.gsub(en, "F", "🅕")
  en = string.gsub(en, "G", "🅖")
  en = string.gsub(en, "H", "🅗")
  en = string.gsub(en, "I", "🅘")
  en = string.gsub(en, "J", "🅙")
  en = string.gsub(en, "K", "🅚")
  en = string.gsub(en, "L", "🅛")
  en = string.gsub(en, "M", "🅜")
  en = string.gsub(en, "N", "🅝")
  en = string.gsub(en, "O", "🅞")
  en = string.gsub(en, "P", "🅟")
  en = string.gsub(en, "Q", "🅠")
  en = string.gsub(en, "R", "🅡")
  en = string.gsub(en, "S", "🅢")
  en = string.gsub(en, "T", "🅣")
  en = string.gsub(en, "U", "🅤")
  en = string.gsub(en, "V", "🅥")
  en = string.gsub(en, "W", "🅦")
  en = string.gsub(en, "X", "🅧")
  en = string.gsub(en, "Y", "🅨")
  en = string.gsub(en, "Z", "🅩")
  en = string.gsub(en, "%./", "　")
  return en
end

local function english_9(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "🅰")
  en = string.gsub(en, "B", "🅱")
  en = string.gsub(en, "C", "🅲")
  en = string.gsub(en, "D", "🅳")
  en = string.gsub(en, "E", "🅴")
  en = string.gsub(en, "F", "🅵")
  en = string.gsub(en, "G", "🅶")
  en = string.gsub(en, "H", "🅷")
  en = string.gsub(en, "I", "🅸")
  en = string.gsub(en, "J", "🅹")
  en = string.gsub(en, "K", "🅺")
  en = string.gsub(en, "L", "🅻")
  en = string.gsub(en, "M", "🅼")
  en = string.gsub(en, "N", "🅽")
  en = string.gsub(en, "O", "🅾")
  en = string.gsub(en, "P", "🅿")
  en = string.gsub(en, "Q", "🆀")
  en = string.gsub(en, "R", "🆁")
  en = string.gsub(en, "S", "🆂")
  en = string.gsub(en, "T", "🆃")
  en = string.gsub(en, "U", "🆄")
  en = string.gsub(en, "V", "🆅")
  en = string.gsub(en, "W", "🆆")
  en = string.gsub(en, "X", "🆇")
  en = string.gsub(en, "Y", "🆈")
  en = string.gsub(en, "Z", "🆉")
  en = string.gsub(en, "%./", "　")
  return en
end

local function english_f_u(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "Ａ")
  en = string.gsub(en, "B", "Ｂ")
  en = string.gsub(en, "C", "Ｃ")
  en = string.gsub(en, "D", "Ｄ")
  en = string.gsub(en, "E", "Ｅ")
  en = string.gsub(en, "F", "Ｆ")
  en = string.gsub(en, "G", "Ｇ")
  en = string.gsub(en, "H", "Ｈ")
  en = string.gsub(en, "I", "Ｉ")
  en = string.gsub(en, "J", "Ｊ")
  en = string.gsub(en, "K", "Ｋ")
  en = string.gsub(en, "L", "Ｌ")
  en = string.gsub(en, "M", "Ｍ")
  en = string.gsub(en, "N", "Ｎ")
  en = string.gsub(en, "O", "Ｏ")
  en = string.gsub(en, "P", "Ｐ")
  en = string.gsub(en, "Q", "Ｑ")
  en = string.gsub(en, "R", "Ｒ")
  en = string.gsub(en, "S", "Ｓ")
  en = string.gsub(en, "T", "Ｔ")
  en = string.gsub(en, "U", "Ｕ")
  en = string.gsub(en, "V", "Ｖ")
  en = string.gsub(en, "W", "Ｗ")
  en = string.gsub(en, "X", "Ｘ")
  en = string.gsub(en, "Y", "Ｙ")
  en = string.gsub(en, "Z", "Ｚ")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  en = string.gsub(en, ",", "，")
  en = string.gsub(en, "%.", "．")
  en = string.gsub(en, "-", "－")
  en = string.gsub(en, "/", "／")
  en = string.gsub(en, "'", "＇")
  return en
end

local function english_f_l(en)
  if en == "" then return "" end
  en = string.gsub(en, "a", "ａ")
  en = string.gsub(en, "b", "ｂ")
  en = string.gsub(en, "c", "ｃ")
  en = string.gsub(en, "d", "ｄ")
  en = string.gsub(en, "e", "ｅ")
  en = string.gsub(en, "f", "ｆ")
  en = string.gsub(en, "g", "ｇ")
  en = string.gsub(en, "h", "ｈ")
  en = string.gsub(en, "i", "ｉ")
  en = string.gsub(en, "j", "ｊ")
  en = string.gsub(en, "k", "ｋ")
  en = string.gsub(en, "l", "ｌ")
  en = string.gsub(en, "m", "ｍ")
  en = string.gsub(en, "n", "ｎ")
  en = string.gsub(en, "o", "ｏ")
  en = string.gsub(en, "p", "ｐ")
  en = string.gsub(en, "q", "ｑ")
  en = string.gsub(en, "r", "ｒ")
  en = string.gsub(en, "s", "ｓ")
  en = string.gsub(en, "t", "ｔ")
  en = string.gsub(en, "u", "ｕ")
  en = string.gsub(en, "v", "ｖ")
  en = string.gsub(en, "w", "ｗ")
  en = string.gsub(en, "x", "ｘ")
  en = string.gsub(en, "y", "ｙ")
  en = string.gsub(en, "z", "ｚ")
  en = string.gsub(en, "%./", "　")
  en = string.gsub(en, " ", "　")
  en = string.gsub(en, ",", "，")
  en = string.gsub(en, "%.", "．")
  en = string.gsub(en, "-", "－")
  en = string.gsub(en, "/", "／")
  en = string.gsub(en, "'", "＇")
  return en
end

local function english_s_u(en)
  if en == "" then return "" end
  en = string.gsub(en, "A", "ᴀ")
  en = string.gsub(en, "B", "ʙ")
  en = string.gsub(en, "C", "ᴄ")
  en = string.gsub(en, "D", "ᴅ")
  en = string.gsub(en, "E", "ᴇ")
  en = string.gsub(en, "F", "ꜰ")
  en = string.gsub(en, "G", "ɢ")
  en = string.gsub(en, "H", "ʜ")
  en = string.gsub(en, "I", "ɪ")
  en = string.gsub(en, "J", "ᴊ")
  en = string.gsub(en, "K", "ᴋ")
  en = string.gsub(en, "L", "ʟ")
  en = string.gsub(en, "M", "ᴍ")
  en = string.gsub(en, "N", "ɴ")
  en = string.gsub(en, "O", "ᴏ")
  en = string.gsub(en, "P", "ᴘ")
  en = string.gsub(en, "Q", "ǫ")
  en = string.gsub(en, "R", "ʀ")
  en = string.gsub(en, "S", "s")
  en = string.gsub(en, "T", "ᴛ")
  en = string.gsub(en, "U", "ᴜ")
  en = string.gsub(en, "V", "ᴠ")
  en = string.gsub(en, "W", "ᴡ")
  en = string.gsub(en, "X", "x")
  en = string.gsub(en, "Y", "ʏ")
  en = string.gsub(en, "Z", "ᴢ")
  en = string.gsub(en, "%./", " ")
  return en
end
--]]
------------------------------------

local function english_mds_ul(en)
  if en == "" then return "" end
  -- en = english_mds_u(string.sub(en,1,1)) .. english_mds_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mds_u(en)
  if string.match(en,"%l") then
    en = english_mds_l(en)
  end
  return en
end

local function english_3_4(en)
  if en == "" then return "" end
  -- en = english_3(string.sub(en,1,1)) .. english_4(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_3(en)
  if string.match(en,"%l") then
    en = english_4(en)
  end
  return en
end

local function english_5_6(en)
  if en == "" then return "" end
  -- en = english_5(string.sub(en,1,1)) .. english_6(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_5(en)
  if string.match(en,"%l") then
    en = english_6(en)
  end
  return en
end

local function english_f_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_f_u(en)
  if string.match(en,"%l") then
    en = english_f_l(en)
  end
  return en
end

local function english_ms_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_ms_u(en)
  if string.match(en,"%l") then
    en = english_ms_l(en)
  end
  return en
end

local function english_mf_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mf_u(en)
  if string.match(en,"%l") then
    en = english_mf_l(en)
  end
  return en
end

local function english_mss_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mss_u(en)
  if string.match(en,"%l") then
    en = english_mss_l(en)
  end
  return en
end

local function english_mssi_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mssi_u(en)
  if string.match(en,"%l") then
    en = english_mssi_l(en)
  end
  return en
end

local function english_mssb_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mssb_u(en)
  if string.match(en,"%l") then
    en = english_mssb_l(en)
  end
  return en
end

local function english_mssbi_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mssbi_u(en)
  if string.match(en,"%l") then
    en = english_mssbi_l(en)
  end
  return en
end

local function english_mi_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mi_u(en)
  if string.match(en,"%l") then
    en = english_mi_l(en)
  end
  return en
end

local function english_mm_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mm_u(en)
  if string.match(en,"%l") then
    en = english_mm_l(en)
  end
  return en
end

local function english_mb_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mb_u(en)
  if string.match(en,"%l") then
    en = english_mb_l(en)
  end
  return en
end

local function english_mbi_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mbi_u(en)
  if string.match(en,"%l") then
    en = english_mbi_l(en)
  end
  return en
end

local function english_mbs_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mbs_u(en)
  if string.match(en,"%l") then
    en = english_mbs_l(en)
  end
  return en
end

local function english_mbf_ul(en)
  if en == "" then return "" end
  -- en = english_f_u(string.sub(en,1,1)) .. english_f_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_mbf_u(en)
  if string.match(en,"%l") then
    en = english_mbf_l(en)
  end
  return en
end

local function english_braille_c_ul(en)
  if en == "" then return "" end
  -- en = english_braille_c_u(string.sub(en,1,1)) .. english_braille_c_l(string.sub(en,2,-1))
  en = english_s2u(en)
  en = english_braille_c_u(en)
  if string.match(en,"%l") then
    en = english_braille_c_l(en)
  end
  return en
end

local function english_braille_u_ul(en)
  if en == "" then return "" end
  -- en = english_braille_u_u(string.sub(en,1,1)) .. english_braille_u_l(string.sub(en,2,-1))
  en = english_s2u(en)
  -- en = string.gsub(en, "([A-Z][A-Z]+)([a-z]+)", "%1⠠⠄%2")  -- AAa=>AA⠠⠄a
  en = english_braille_u_u(en)
  if string.match(en,"%l") then
    en = english_braille_u_l(en)
  end
  return en
end


return {
        english_s = english_s,
        english_u1 = english_u1,
        -- english_u2 = english_u2,
        english_s2u = english_s2u,

        english_3 = english_3,
        english_4 = english_4,
        english_5 = english_5,
        english_6 = english_6,
        english_7 = english_7,
        english_8 = english_8,
        english_9 = english_9,
        english_f_u = english_f_u,
        english_f_l = english_f_l,
        english_s_u = english_s_u,
        english_mds_u = english_mds_u,
        english_mds_l = english_mds_l,
        english_ms_u = english_ms_u,
        english_ms_l = english_ms_l,
        english_mf_u = english_mf_u,
        english_mf_l = english_mf_l,
        english_mss_u = english_mss_u,
        english_mss_l = english_mss_l,
        english_mssi_u = english_mssi_u,
        english_mssi_l = english_mssi_l,
        english_mssb_u = english_mssb_u,
        english_mssb_l = english_mssb_l,
        english_mssbi_u = english_mssbi_u,
        english_mssbi_l = english_mssbi_l,
        english_mi_u = english_mi_u,
        english_mi_l = english_mi_l,
        english_mm_u = english_mm_u,
        english_mm_l = english_mm_l,
        english_mb_u = english_mb_u,
        english_mb_l = english_mb_l,
        english_mbi_u = english_mbi_u,
        english_mbi_l = english_mbi_l,
        english_mbs_u = english_mbs_u,
        english_mbs_l = english_mbs_l,
        english_mbf_u = english_mbf_u,
        english_mbf_l = english_mbf_l,
        english_3_4 = english_3_4,
        english_5_6 = english_5_6,
        english_f_ul = english_f_ul,
        english_mds_ul = english_mds_ul,
        english_ms_ul = english_ms_ul,
        english_mf_ul = english_mf_ul,
        english_mss_ul = english_mss_ul,
        english_mssi_ul = english_mssi_ul,
        english_mssb_ul = english_mssb_ul,
        english_mssbi_ul = english_mssbi_ul,
        english_mi_ul = english_mi_ul,
        english_mm_ul = english_mm_ul,
        english_mb_ul = english_mb_ul,
        english_mbi_ul = english_mbi_ul,
        english_mbs_ul = english_mbs_ul,
        english_mbf_ul = english_mbf_ul,

        english_braille_c_u = english_braille_c_u,
        english_braille_c_l = english_braille_c_l,
        english_braille_c_ul = english_braille_c_ul,
        english_braille_u_u = english_braille_u_u,
        english_braille_u_l = english_braille_u_l,
        english_braille_u_ul = english_braille_u_ul,
        }