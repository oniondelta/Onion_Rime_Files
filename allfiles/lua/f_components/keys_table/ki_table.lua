--[[
各種語言編碼鍵位說明
--]]


local ki_table = {
    { "  ※  (…) 內為編碼，前為 IPA 字符", "⁰" }
  , { "  ※  (;)→ 大寫　('')→ 組合附加符號，注音方案改(;;)", "¹" }
  , { "  ════════════  ", "²" }
  , { "  『 母音/元音 』", "³" }
  , { "  　　 ｜     前     ┊     央     ┊     後     ｜", "⁴" }
  , { "  閉　 ｜ i(i)　y(y) ┊ ɨ(it)　ʉ(ut) ┊ ɯ(mq)　u(u) ｜", "⁵" }
  , { "  次閉 ｜ ɪ(ii;)　ʏ(yi;) ┊  ┊ ʊ(wk) ｜", "⁶" }
  , { "  半閉 ｜ e(e)　ø(ox) ┊ ɘ(ek) ɵ(qi) ┊ ɤ(vo/yo/oy)　o(o) ｜", "⁷" }
  , { "  中　 ｜ 　 ┊ ə(eq) ┊ 　 ｜", "⁸" }
  , { "  半開 ｜ ɛ(ei)　œ(ohe) ┊ ɜ(zi)　ɞ(bf) ┊ ʌ(li/vk)　ɔ(jf/ck) ｜", "⁹" }
  , { "次開 ｜ æ(ahe) ┊ ɐ(aq) ┊ 　 ｜", "¹⁰" }
  , { "開　 ｜ a(a)　ɶ(ohe;) ┊  ┊ ɑ(ai)　ɒ(aq) ｜", "¹¹" }
  , { "════════════  ", "¹²" }
  , { "『 子音/輔音（肺部氣流音） 』", "¹³" }
  , { "塞音：p(p)　b(b)　t(t)　d(d)　ʈ(ti/tc)　ɖ(dc/dt)　c(c)", "¹⁴" }
  , { "　　　ɟ(jt)　k(k)　ɡ(gi)　q(q)　ɢ(gi;)　ʔ(jfy/jy/jfk)", "¹⁵" }
  , { "鼻音：m(m)　ɱ(mj)　n(n)　ɳ(nc)　ɲ(nj)　ŋ(nj)　ɴ(ni;)", "¹⁶" }
  , { "顫音：ʙ(bi;)　r(r)　ʀ(ri;/ihr;)", "¹⁷" }
  , { "閃音：ⱱ(vr)　ɾ(jq/lfk)　ɽ(rc)", "¹⁸" }
  , { "擦音：ɸ(fi)　β(bi)　f(f)　v(v)　θ(qi)　ð(dfx/dx/dt)", "¹⁹" }
  , { "　　　s(s)　z(z)　ʃ(sf)　ʒ(zf)　ʂ(sc)　ʐ(zc)　ç(cj)", "²⁰" }
  , { "　　　ʝ(jg/ig)　x(x)　ɣ(vo/no/go)　χ(xi)", "²¹" }
  , { "　　　ʁ(rk;)　ħ(ht)　ʕ(cfy/cy/cfk)　h(h)　ɦ(hr)", "²²" }
  , { "邊擦音：ɬ(lk/ik)　ɮ(lzf/lhzf)", "²³" }
  , { "近音：ʋ(vf/yi)　ɹ(rq)　ɻ(rrq/rqc)", "²⁴" }
  , { "　　　j(j)　ɰ(xf/mqy/mrq/wy/whi/uhu)", "²⁵" }
  , { "邊近音：l(l)　ɭ(lc)　ʎ(yq)　ʟ(li;)", "²⁶" }
  , { "════════════  ", "²⁷" }
  , { "『 子音/輔音（非肺部氣流音） 』", "²⁸" }
  , { "搭嘴音：ʘ(oma)　ǀ(iw)　ǃ(ifk)　ǂ(itt/ltt/nfq/iwtt/tft)　ǁ(iwiw)", "²⁹" }
  , { "內爆音：ɓ(br/gq)　ɗ(dr)　ʄ(sft/sftt)　ɠ(gr)　ʛ(gr;)", "³⁰" }
  , { "擠喉音：ʼ(dw)　pʼ(p)(dw)　tʼ(t)(dw)　kʼ(k)(dw)　sʼ(s)(dw)", "³¹" }
  , { "════════════  ", "³²" }
  , { "『 其他記號 』", "³³" }
  , { "　ʍ(wk)　w(w)　ɥ(hq/ui)　ʜ(hi;)", "³⁴" }
  , { "　ʢ(cfyt/cyt/cfkt/cftf)　ʡ(jfyt/jyt/jfkt/jftf)", "³⁵" }
  , { "　ɕ(cg/gfq)　ʑ(zg)　ɻ(rrq/rqc)　ɧ(hrj/hjr/jqg/hrc/hcr)", "³⁶" }
  , { "　ts͜(t)(s)(du'')　kp͡(k)(p)(m'')", "³⁷" }
  , { "════════════  ", "³⁸" }
  , { "『 變音符號 』", "³⁹" }
  , { "　◌̥(do'') ˳(dow)　◌̬(dv'') ˬ(dvw)　◌ͪ(hh'') ʰ(hh)", "⁴⁰" }
  , { "　◌̹(dj'') ˒(djw/jw)　◌̜(dc'') ˓(dcw/cw)　◌̟(dt'') ˖(dtw/tw/dtfh)", "⁴¹" }
  , { "　◌̠(de'') ˍ(dew) ˗(dew/ew)　◌̈(b'') ¨(bw)　◌̽(x'') ˟(xw) ˣ(xh)", "⁴²" }
  , { "　◌̩(dp'') ˌ(dpw/yw/dyw)　◌̯(dm'')", "⁴³" }
  , { "　˞(kw) ɚ(eqk) ɝ(zk/zr) a˞(a)(kw)", "⁴⁴" }
  , { "　◌̤(db'')　◌̰(ds'') ˷(dsw)　◌̼(dy'')", "⁴⁵" }
  , { "　ʷ(wh)　ʲ(jh)　ˠ(voh/noh/goh)　ˤ(cfyh/cfkh/cyh)", "⁴⁶" }
  , { "　◌̪(dr'')　◌̺(drk'')　◌̻(do'')　◌̃(s'') ˜(sw)　ⁿ(nh)　ˡ(lh)", "⁴⁷" }
  , { "　◌̚(gk'') ˺(gwk)　◌̴(z'') ~(sw) ɫ(lz/iz) ᵶ(zz)", "⁴⁸" }
  , { "　◌̝(dtk'') ˔(dtwk/twk)　◌̞(dt'') ˕(dtw/tw)　◌̘(dtq'')　◌̙(dtq'')", "⁴⁹" }
  , { "════════════  ", "⁵⁰" }
  , { "『 超音段成分 』", "⁵¹" }
  , { "　ˈ(pw)　ˌ(dpw/yw/dyw)　ː(dfkdf/dkd/dfdf/dfhdf)　ˑ(dfk/dk/df)", "⁵²" }
  , { "　◌̆(u'') ˘(uw/ufh)　|(iw)　‖(iwiw)", "⁵³" }
  , { "　.(daw) ·(aw)　‿(duw) ◌͜(du''/dufh'')", "⁵⁴" }
  , { "────────────  ", "⁵⁵" }
  , { "『 音階和音調 』", "⁵⁶" }
  , { "　◌̋(pp'') ˝(pwpw)　◌́(p'') ˊ(pw)　◌̄(e'') ˉ(ew)", "⁵⁷" }
  , { "　◌̀(n'') ˋ(nw)　◌̏(n'')", "⁵⁸" }
  , { "　˥(gwk)　˦(twq)　˧(twq)　˨(twq)　˩(gwq)", "⁵⁹" }
  , { "　◌̌(v'') ˇ(vw)　◌̂(l'') ˆ(lw)", "⁶⁰" }
  , { "　ꜜ(lwk)　ꜛ(lw)　↗(lwq)　↘(lwq)", "⁶¹" }
  , { "════════════  ", "⁶²" }
  , { "〔資料來源〕", "https://www.internationalphoneticassociation.org/IPAcharts/IPA_chart_orig/pdfs/IPA_Kiel_2020_full.pdf" }
  -- , { "", "⁶³" }
  -- 以下中文 Wiki 內容較多，但較雜！
  -- , { "　閉：i(i) y(y)｜ɨ(it) ʉ(ut)｜ɯ(mq) u(u)", "³" }
  -- , { "次閉：　ɪ(ii;) ʏ(yi;)　ɨ̞(it)(dt@) ʉ̞(ut)(dt@)　ɯ̞(mq)(dt@) ʊ(wk)", "⁴" }
  -- , { "半閉：e(e) ø(ox)｜ɘ(ek) ɵ(qi)｜ɤ(vo/yo/oy) o(o)", "⁵" }
  -- , { "　中：e̞(e)(dt@) ø̞(ox)(dt@)｜ə(eq)｜ɤ̞(vo/yo/oy)(dt@) o̞(o)(dt@)", "⁶" }
  -- , { "半開：ɛ(ei) œ(ohe)｜ɜ(zi) ɞ(bf)｜ʌ(li/vk) ɔ(jf/ck)", "⁷" }
  -- , { "次開：æ(ahe)｜ɐ(aq)｜", "⁸" }
  -- , { "　開：a(a) ɶ(ohe;)｜ä(ab) ɒ̈(aq)(b@)｜ɑ(ai) ɒ(aq)", "⁹" }
  -- , { "｢肺部氣流音｣：", "¹⁰" }
  -- , { "鼻音：m̥(m)(do@) m(m) ɱ(mj) n̼(n)(dy@) n̥(n)(do@) n(n) ɳ̊(nc)(o@) ɳ(nc) ɲ̊(nj)(o@) ɲ(nj) ŋ̊(nj)(o@) ŋ(nj) ɴ(ni;)", "¹¹" }
  -- , { "塞音：p(p) b(b) p̪(p)(dr@) b̪(b)(dr@) t̼(t)(dy@) d̼(d)(dy@) t(t) d(d) ʈ(ti/tc) ɖ(dc/dt) c(c) ɟ(jt) k(k) ɡ(gi) q(q) ɢ(gi;) ʡ(jfyt/jyt/jfkt/jftf) ʔ(jfy/jy/jfk)", "¹²" }
  -- , { "有噝塞擦音：", "¹³" }
  -- , { "無噝塞擦音：", "¹⁴" }
  -- , { "有噝擦音：", "¹⁵" }
  -- , { "無噝擦音：", "¹⁶" }
  }


return ki_table