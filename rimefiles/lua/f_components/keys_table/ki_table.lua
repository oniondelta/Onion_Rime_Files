--[[
各種語言編碼鍵位說明
--]]


local ki_table = {
    { "⁰", "  ※  (…) 內為編碼，前為 IPA 字符" }
  , { "¹", "  ※  (;)→ 大寫　('')→ 組合附加符號，注音方案改(;;)" }
  , { "²", "  ════════════  " }
  , { "³", "  『 母音/元音 』" }
  , { "⁴", "  　　 ｜     前     ┊     央     ┊     後     ｜" }
  , { "⁵", "  閉　 ｜ i(i)　y(y) ┊ ɨ(it)　ʉ(ut) ┊ ɯ(mq)　u(u) ｜" }
  , { "⁶", "  次閉 ｜ ɪ(ii;)　ʏ(yi;) ┊  ┊ ʊ(wk) ｜" }
  , { "⁷", "  半閉 ｜ e(e)　ø(ox) ┊ ɘ(ek) ɵ(qi) ┊ ɤ(vo/yo/oy)　o(o) ｜" }
  , { "⁸", "  中　 ｜ 　 ┊ ə(eq) ┊ 　 ｜" }
  , { "⁹", "  半開 ｜ ɛ(ei)　œ(ohe) ┊ ɜ(zi)　ɞ(bf) ┊ ʌ(li/vk)　ɔ(jf/ck) ｜" }
  , { "¹⁰", "次開 ｜ æ(ahe) ┊ ɐ(aq) ┊ 　 ｜" }
  , { "¹¹", "開　 ｜ a(a)　ɶ(ohe;) ┊  ┊ ɑ(ai)　ɒ(aq) ｜" }
  , { "¹²", "════════════  " }
  , { "¹³", "『 子音/輔音（肺部氣流音） 』" }
  , { "¹⁴", "塞音：p(p)　b(b)　t(t)　d(d)　ʈ(ti/tc)　ɖ(dc/dt)　c(c)" }
  , { "¹⁵", "　　　ɟ(jt)　k(k)　ɡ(gi)　q(q)　ɢ(gi;)　ʔ(jfy/jy/jfk)" }
  , { "¹⁶", "鼻音：m(m)　ɱ(mj)　n(n)　ɳ(nc)　ɲ(nj)　ŋ(nj)　ɴ(ni;)" }
  , { "¹⁷", "顫音：ʙ(bi;)　r(r)　ʀ(ri;/ihr;)" }
  , { "¹⁸", "閃音：ⱱ(vr)　ɾ(jq/lfk)　ɽ(rc)" }
  , { "¹⁹", "擦音：ɸ(fi)　β(bi)　f(f)　v(v)　θ(qi)　ð(dfx/dx/dt)" }
  , { "²⁰", "　　　s(s)　z(z)　ʃ(sf)　ʒ(zf)　ʂ(sc)　ʐ(zc)　ç(cj)" }
  , { "²¹", "　　　ʝ(jg/ig)　x(x)　ɣ(vo/no/go)　χ(xi)" }
  , { "²²", "　　　ʁ(rk;)　ħ(ht)　ʕ(cfy/cy/cfk)　h(h)　ɦ(hr)" }
  , { "²³", "邊擦音：ɬ(lk/ik)　ɮ(lzf/lhzf)" }
  , { "²⁴", "近音：ʋ(vf/yi)　ɹ(rq)　ɻ(rrq/rqc)" }
  , { "²⁵", "　　　j(j)　ɰ(xf/mqy/mrq/wy/whi/uhu)" }
  , { "²⁶", "邊近音：l(l)　ɭ(lc)　ʎ(yq)　ʟ(li;)" }
  , { "²⁷", "════════════  " }
  , { "²⁸", "『 子音/輔音（非肺部氣流音） 』" }
  , { "²⁹", "搭嘴音：ʘ(oma)　ǀ(iw)　ǃ(ifk)　ǂ(itt/ltt/nfq/iwtt/tft)　ǁ(iwiw)" }
  , { "³⁰", "內爆音：ɓ(br/gq)　ɗ(dr)　ʄ(sft/sftt)　ɠ(gr)　ʛ(gr;)" }
  , { "³¹", "擠喉音：ʼ(dw)　pʼ(p)(dw)　tʼ(t)(dw)　kʼ(k)(dw)　sʼ(s)(dw)" }
  , { "³²", "════════════  " }
  , { "³³", "『 其他記號 』" }
  , { "³⁴", "　ʍ(wk)　w(w)　ɥ(hq/ui)　ʜ(hi;)" }
  , { "³⁵", "　ʢ(cfyt/cyt/cfkt/cftf)　ʡ(jfyt/jyt/jfkt/jftf)" }
  , { "³⁶", "　ɕ(cg/gfq)　ʑ(zg)　ɻ(rrq/rqc)　ɧ(hrj/hjr/jqg/hrc/hcr)" }
  , { "³⁷", "　ts͜(t)(s)(du'')　kp͡(k)(p)(m'')" }
  , { "³⁸", "════════════  " }
  , { "³⁹", "『 變音符號 』" }
  , { "⁴⁰", "　◌̥(do'') ˳(dow)　◌̬(dv'') ˬ(dvw)　◌ͪ(hh'') ʰ(hh)" }
  , { "⁴¹", "　◌̹(dj'') ˒(djw/jw)　◌̜(dc'') ˓(dcw/cw)　◌̟(dt'') ˖(dtw/tw/dtfh)" }
  , { "⁴²", "　◌̠(de'') ˍ(dew) ˗(dew/ew)　◌̈(b'') ¨(bw)　◌̽(x'') ˟(xw) ˣ(xh)" }
  , { "⁴³", "　◌̩(dp'') ˌ(dpw/yw/dyw)　◌̯(dm'')" }
  , { "⁴⁴", "　˞(kw) ɚ(eqk) ɝ(zk/zr) a˞(a)(kw)" }
  , { "⁴⁵", "　◌̤(db'')　◌̰(ds'') ˷(dsw)　◌̼(dy'')" }
  , { "⁴⁶", "　ʷ(wh)　ʲ(jh)　ˠ(voh/noh/goh)　ˤ(cfyh/cfkh/cyh)" }
  , { "⁴⁷", "　◌̪(dr'')　◌̺(drk'')　◌̻(do'')　◌̃(s'') ˜(sw)　ⁿ(nh)　ˡ(lh)" }
  , { "⁴⁸", "　◌̚(gk'') ˺(gwk)　◌̴(z'') ~(sw) ɫ(lz/iz) ᵶ(zz)" }
  , { "⁴⁹", "　◌̝(dtk'') ˔(dtwk/twk)　◌̞(dt'') ˕(dtw/tw)　◌̘(dtq'')　◌̙(dtq'')" }
  , { "⁵⁰", "════════════  " }
  , { "⁵¹", "『 超音段成分 』" }
  , { "⁵²", "　ˈ(pw)　ˌ(dpw/yw/dyw)　ː(dfkdf/dkd/dfdf/dfhdf)　ˑ(dfk/dk/df)" }
  , { "⁵³", "　◌̆(u'') ˘(uw/ufh)　|(iw)　‖(iwiw)" }
  , { "⁵⁴", "　.(daw) ·(aw)　‿(duw) ◌͜(du''/dufh'')" }
  , { "⁵⁵", "────────────  " }
  , { "⁵⁶", "『 音階和音調 』" }
  , { "⁵⁷", "　◌̋(pp'') ˝(pwpw)　◌́(p'') ˊ(pw)　◌̄(e'') ˉ(ew)" }
  , { "⁵⁸", "　◌̀(n'') ˋ(nw)　◌̏(n'')" }
  , { "⁵⁹", "　˥(gwk)　˦(twq)　˧(twq)　˨(twq)　˩(gwq)" }
  , { "⁶⁰", "　◌̌(v'') ˇ(vw)　◌̂(l'') ˆ(lw)" }
  , { "⁶¹", "　ꜜ(lwk)　ꜛ(lw)　↗(lwq)　↘(lwq)" }
  , { "⁶²", "════════════  " }
  , { "https://www.internationalphoneticassociation.org/IPAcharts/IPA_chart_orig/pdfs/IPA_Kiel_2020_full.pdf", "〔資料來源〕" }
  -- , { "⁶³", "" }
  -- 以下中文 Wiki 內容較多，但較雜！
  -- , { "³", "　閉：i(i) y(y)｜ɨ(it) ʉ(ut)｜ɯ(mq) u(u)" }
  -- , { "⁴", "次閉：　ɪ(ii;) ʏ(yi;)　ɨ̞(it)(dt@) ʉ̞(ut)(dt@)　ɯ̞(mq)(dt@) ʊ(wk)" }
  -- , { "⁵", "半閉：e(e) ø(ox)｜ɘ(ek) ɵ(qi)｜ɤ(vo/yo/oy) o(o)" }
  -- , { "⁶", "　中：e̞(e)(dt@) ø̞(ox)(dt@)｜ə(eq)｜ɤ̞(vo/yo/oy)(dt@) o̞(o)(dt@)" }
  -- , { "⁷", "半開：ɛ(ei) œ(ohe)｜ɜ(zi) ɞ(bf)｜ʌ(li/vk) ɔ(jf/ck)" }
  -- , { "⁸", "次開：æ(ahe)｜ɐ(aq)｜" }
  -- , { "⁹", "　開：a(a) ɶ(ohe;)｜ä(ab) ɒ̈(aq)(b@)｜ɑ(ai) ɒ(aq)" }
  -- , { "¹⁰", "｢肺部氣流音｣：" }
  -- , { "¹¹", "鼻音：m̥(m)(do@) m(m) ɱ(mj) n̼(n)(dy@) n̥(n)(do@) n(n) ɳ̊(nc)(o@) ɳ(nc) ɲ̊(nj)(o@) ɲ(nj) ŋ̊(nj)(o@) ŋ(nj) ɴ(ni;)" }
  -- , { "¹²", "塞音：p(p) b(b) p̪(p)(dr@) b̪(b)(dr@) t̼(t)(dy@) d̼(d)(dy@) t(t) d(d) ʈ(ti/tc) ɖ(dc/dt) c(c) ɟ(jt) k(k) ɡ(gi) q(q) ɢ(gi;) ʡ(jfyt/jyt/jfkt/jftf) ʔ(jfy/jy/jfk)" }
  -- , { "¹³", "有噝塞擦音：" }
  -- , { "¹⁴", "無噝塞擦音：" }
  -- , { "¹⁵", "有噝擦音：" }
  -- , { "¹⁶", "無噝擦音：" }
  }


return ki_table