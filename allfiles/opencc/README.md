## OpenCC 文件說明


```
┌─ back_mark.json                    符號、音標、西歐字母、韓文、注音等註解 1  （例：æ〔KK, DJ, IPA〕）
├─ back_mark.txt                     轉換字典
│
├─ back_mark_ocm.json                符號、音標、西歐字母、韓文、注音等註解 2  （附拼法，例：æ  ᴀʜᴇ'〔拉-小: KK, DJ, IPA〕）（拼法為內建拉丁字母形碼）
├─ back_mark_ocm.txt                 轉換字典
│
├─ bpm_moedict_big5e_hkscs_jis.json  遮屏非 萌典、Big5e、Hkscs、JIS 之中文  （限 terra_pinyin_onion.dict.yaml 之字符，其他不遮屏）（把欲遮屏字符轉換成「᰼᰼」，再用 lua 遮屏「᰼᰼」，可自由決定遮屏範圍）
├─ bpm_moedict_big5e_hkscs_jis.txt   轉換字典
│
├─ emoji_2021.json                   表情符號  （新版）（簡繁體皆轉換）
├─ emoji_2021.txt                    轉換字典
│
├─ emoji_2021t.json                  表情符號  （新版）（只針對繁體轉換）（切換簡體 filter 時，簡體也會附加 Emoji，方案實際使用）
├─ emoji_2021t.txt                   轉換字典
│
├─ ocm_moedict_big5e_hkscs_jis.json  遮屏非 萌典、Big5e、Hkscs、JIS 之中文  （限 Unicode CJK 和 Extension ABCD 之字符，其他不遮屏）（把欲遮屏字符轉換成「᰼᰼」，再用 lua 遮屏「᰼᰼」，可自由決定遮屏範圍）
├─ ocm_moedict_big5e_hkscs_jis.txt   轉換字典
│
├─ punct_mark.json                   標點符號註解  （例：—〔連接號〕）
└─ punct_mark.txt                    轉換字典
```