# gitで気になるコマンドを試す
## git checkout theirs
- 使い道が思いつかないので、試さない
- --theirsだった
- 現状の理解
  - コンフリクト解消コマンド
  - rebaseとmergeのどちらでコンフリクトしたか？で挙動が変わる
  - rebaseではincoming changesを適用する
  - mergeではcurrent changesを適用する
  - コンフリクトしていない変更も含めて片方が適用される
- 確認方法
  - feature1ブランチのコミット1
    - ```
      111
      222
      333
      ```
  - feature1ブランチのコミット2
    - ```
      111
      aaa
      333
      444
      ```
  - feature1ブランチのコミット1からチェックアウトしたfeature2ブランチのコミット1
    - ```
      111
      bbb
      333
      ```
  - feature1ブランチのコミット2にfeature2ブランチをマージするとコンフリクト発生
    - ```
      111
      ---
      aaa
      ---
      bbb
      ---
      333
      444
      ```
## git checkout ours
- 使い道が思いつかないので、試さない
- --ours
- merge, rebase時の挙動はtheirsの逆
## git rebase --skip
- rebaseすることはよくあるので試す
- コンフリクトを解消しないでスキップする
- 現状の理解
  - web上でsquash mergeを行なった場合のコンフリクト解消で使える
    - 例えば、develop ← f1-1 ← f1-2 ← f1-3 のコミットがあるとして、f1-2をf1-1にsquash mergeした場合、f1-1とf-3のコンフリクトが発生するので、この時にskipする。
- 確認方法
  - 必要なブランチ3つ
    - e1
    - e2
    - e3
  - e1にe2をsquash merge
  - e1にe3をrebase
  - e3に入っているe2をskip