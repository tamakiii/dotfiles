---
name: review-pull-request-adversarially
description: |
  PRに対して「建設的な敵対的レビュー」を実施する。通常のコードレビューではなく、前提・設計判断・問題設定そのものを批判的に検証する。
  「adversarial review」「devil's advocate review」「批判的レビュー」「このPR本当に大丈夫？」「設計の穴を探して」「PRを厳しくレビューして」「red team this PR」「challenge this PR」に関するリクエストで使用。
  Use this when the user wants a critical, assumption-challenging review of a PR — not just code style and bugs, but questioning whether the approach itself is sound.
metadata:
  short-description: Adversarial PR review — challenge assumptions, not just code
---

# Adversarial PR Review

通常のコードレビュー（バグ、スタイル、テストカバレッジ）とは異なる。このスキルは問題設定・前提・設計判断の妥当性を批判的に検証する。

The goal is **constructive** adversarial — strengthen the PR by finding what's wrong in logic, framing, and assumptions, not just code.

## Why this matters

単一のモデルが自分の出力をレビューすると、同じバイアスに影響される。異なる視点から意図的に前提を疑うことで、見落としを発見できる。

## How to use

### Step 1: Identify the PR

ユーザーのメッセージからPR参照を抽出する：

```bash
# PR番号、URL、または「open PR」から特定
# リポジトリは URL またはリモートから導出
git remote get-url origin | sed 's|.*github.com[:/]||;s|\.git$||'
```

### Step 2: Gather context

並列で実行：

```bash
# PR メタデータ
gh pr view <N> --repo <repo> --json title,body,headRefName,baseRefName,state,additions,deletions,files,commits

# 完全な diff
gh pr diff <N> --repo <repo>

# PR コメント（既存の議論を確認）
gh api repos/<owner>/<repo>/pulls/<N>/comments

# コミット履歴で意図を理解
gh pr view <N> --repo <repo> --json commits --jq '.commits[].messageHeadline'
```

### Step 3: Adversarial review — three phases

PR の diff と説明を読んだ上で、以下の3段階で検証する。

#### Phase 1: Problem framing review

PRが解決しようとしている問題そのものを疑う：

- このPRが解決すると主張している問題は何か？
- その問題設定は正確か、それとも別の根本原因を隠していないか？
- ユーザー、環境、制約について暗黙の前提はないか？
- 議論なしに暗黙的に却下された代替案はないか？

#### Phase 2: Logical coherence

実装とゴールの整合性を検証する：

- 実装は本当に述べられた問題を解決しているか？
- ゴールとアプローチの間に論理的なギャップはないか？
- エッジケースは認識されているか、それとも暗黙的に無視されているか？
- 循環論法がないか（「Xが必要、なぜならYを作ったから、YはXを必要とする」）

#### Phase 3: Future failure pre-mortem

このPRがマージされた後の未来から逆算する：

- このPRが3ヶ月後に問題を起こしたとして、3文のインシデントレポートを書く
- 技術的負債を生む最も可能性の高い経路は何か？
- 将来のコントリビューターが最も誤解しそうな点は何か？

### Step 4: Quality check — filter performative skepticism

各指摘について自己検証する。「もっともらしく聞こえるが実質のない批判」を排除するためのルール：

**すべての批判に対して具体的な代替案を提示すること。** 代替案を提案できないなら、その批判はおそらく表面的。削除する。

指摘を以下の基準でフィルタリング：
- 「これは本当に問題か、それとも好みの違いか？」
- 「代替案は実際に実現可能か？」
- 「この指摘はPRの著者にとって actionable か？」

### Step 5: Format and post

`gh` を使ってレビューコメントを投稿する。常に `--repo` を明示する。

```bash
gh pr review <N> --repo <repo> --comment --body "$(cat <<'EOF'
## Adversarial Review 🔍

> このレビューは通常のコードレビューとは異なり、前提・設計判断・問題設定の妥当性を批判的に検証するものです。

### Problem Framing
<findings>

### Logical Coherence
<findings>

### Future Failure Pre-mortem
<3-sentence incident report from the future>

---

### Findings Summary

| # | Finding | Severity | Confidence | Alternative |
|---|---------|----------|------------|-------------|
| 1 | ... | Fatal flaw / Significant / Worth discussing | High / Medium / Low | ... |

---
🤖 Adversarial review by Codex
EOF
)"
```

#### Severity levels

- **Fatal flaw**: このままマージすると重大な問題が発生する可能性が高い
- **Significant concern**: 対応しないと将来的にリスクとなる
- **Worth discussing**: 改善の余地があるが、ブロッカーではない

#### Confidence levels

- **High**: diffから直接確認できる具体的な問題
- **Medium**: コンテキストに基づく合理的な推論
- **Low**: 可能性の指摘、追加調査が必要

### What this skill does NOT do

- 通常のコードレビュー（バグ、スタイル、テストカバレッジ）
- approve / request changes の判定 → 常に comment として投稿
- 些末な批判やスタイルの好みに関する指摘

## Edge cases

**PRにdescriptionがない場合:**
コミットメッセージとdiffから意図を推測する。推測であることを明記する。

**trivialな変更（typo修正、依存関係更新など）の場合:**
「このPRは adversarial review の対象として適切ではありません」と伝え、通常のレビューを提案する。

**既にadversarial reviewが投稿されている場合:**
前回のレビューを読み、新しい指摘がある場合のみ追加投稿する。

## Multi-perspective mode

ユーザーが「もっと深く」「徹底的に」と求めた場合、4つの視点に分解する：

- **The Skeptic**: この機能全体が不要である理由は？
- **The Architect**: 暗黙的に却下された設計代替案は、本当により悪かったのか？
- **The User**: これは述べられた問題を解決しているか、それとも別の問題を解決しているか？
- **The Maintainer (6ヶ月後)**: 何が混乱を招き、何が後悔されるか？
