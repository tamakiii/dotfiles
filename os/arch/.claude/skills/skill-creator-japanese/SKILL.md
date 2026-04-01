---
name: skill-creator-japanese
description: |
  日本語でClaude Codeスキルを作成・改善するためのガイド。ハイブリッドアプローチ（英語の構造要素＋日本語の本文）を推奨。
  スキル作成、スキルの日本語化、日本語スキル、SKILL.md の書き方、日本語プロンプト設計に関するリクエストで使用。
  Use this skill when creating or improving Claude Code skills in Japanese, localizing skills for Japanese users, or when the user asks about best practices for writing Japanese SKILL.md files.
---

# Writing Claude Code Skills in Japanese

ハイブリッドアプローチ（英語の構造要素＋日本語の本文）が日本人開発者の間で最良の実践として定着しつつある。Claude の日本語理解度は英語の **96.9%** に達しており、完全日本語スキルも十分に機能するが、ハイブリッド構造が両方の利点を最大化する。

## Skill loading architecture

スキルは3段階で読み込まれる：

1. **Level 1 (Metadata)**: `name` + `description` のみ。全セッションで約100トークン消費
2. **Level 2 (Body)**: ユーザーリクエストがマッチした時に SKILL.md 本文を読み込み（500行以下推奨）
3. **Level 3 (Resources)**: 必要時のみ scripts/ や references/ を参照

`description` フィールドがスキルの発火を決定する最重要要素。日本語ユーザー向けには、日本語のトリガーフレーズを含めること。

## Directory structure

```
skill-name/
├── SKILL.md              # 必須：コア指示
├── scripts/              # 決定的タスク用の実行可能コード
├── references/           # 必要時にコンテキストへ読み込むドキュメント
└── assets/               # テンプレート、アイコン等の出力用ファイル
```

## Language choice per element

| 要素 | 言語 | 理由 |
|---|---|---|
| `name` フィールド | English (必須) | 仕様上、小文字+ハイフンのみ |
| `description` フィールド | Japanese | 日本語ユーザーのトリガーフレーズに一致 |
| XML タグ | English | 学習データとの整合、公式例に準拠 |
| Markdown 見出し (`##`) | English | トークン効率、パターン認識 |
| 本文・指示 | Japanese | 精度、ドメイン忠実性 |
| 変数名・プレースホルダー | English | コーディング規約に準拠 |
| コード例・コマンド | English | プログラミングの国際慣習 |
| ドメイン固有用語 | Japanese | 意味の保持（例：自治体DX、電子決裁）|

## Three patterns in the wild

- **Pattern A (Hybrid)**: 英語の `name`、英語の見出し、英語の XML タグ、日本語の本文と description — 推奨
- **Pattern B (Fully Japanese)**: `name` 以外すべて日本語 — 行政DX案件や日本語チーム向け
- **Pattern C (English + Japanese interaction)**: SKILL.md は英語、CLAUDE.md に「常に日本語で返答してください」 — トークン効率重視

## Writing guidelines

### Description field

`description` は日本語で積極的に書く。複数のトリガーフレーズを含めること：

```yaml
description: |
  コードレビューを実施する。PRレビュー、コードチェック、品質確認に関するリクエストで使用。
```

Claude はデフォルトでスキルを「発火させない」傾向があるため、過剰に含める方向で記述する。

### Politeness level

です/ます形または平叙文（だ/である形）を使用する。カジュアルすぎる表現や過度な敬語は避ける。

研究結果：乱暴なプロンプトはパフォーマンスを低下させるが、過度に丁寧な表現も改善しない。中程度の丁寧さが最良。

指示文には「〜してください」または「〜すること」を使用：

```markdown
## Instructions
1. 環境変数を検証する
2. テストスイートを実行: `npm test`
3. デプロイスクリプトを実行: `./scripts/deploy.sh staging`
```

### Be concrete

日本語の文脈依存的な性質上、曖昧さは英語以上にリスクとなる：

- Bad: 「適切に処理する」
- Good: 「エラー時はログ出力してリトライする」

### Token budget

日本語は英語の約 **2.12倍** のトークンを消費する。英語の500行制限は日本語では実質 **約300行** となる。

Progressive disclosure パターンを活用：概要は SKILL.md に、詳細は references/ の別ファイルに配置。

### Domain terms

ドメイン固有の日本語用語はそのまま使う。無理な英訳は曖昧さを生む：

- 「自治体DX」→ そのまま使用
- 「電子決裁」→ そのまま使用

## Hybrid template example

```yaml
---
name: deploy-staging
description: |
  ステージング環境へのデプロイを実行する。
  デプロイ、ステージング、環境構築などに関連するリクエストに使用。
---
# Deploy to Staging

## Prerequisites
以下の条件を事前に確認すること：
- `AWS_PROFILE` が正しく設定されていること
- ステージングブランチが最新であること

## Instructions
1. 環境変数を検証する
2. テストスイートを実行: `npm test`
3. デプロイスクリプトを実行: `./scripts/deploy.sh staging`

## Error handling
- デプロイ失敗時は即座にロールバックを実行すること
- ログを `deploy-logs/` に保存し、エラー内容を報告すること
```

## Modular language separation

言語の使い分けに迷う場合、ファイルを機能別に分離する：

```
.claude/rules/
├── code-style.md         ← English (技術規約)
├── testing.md            ← English (テストパターン)
└── domain-context.md     ← Japanese (ドメイン知識)
```

## Key principles

1. **簡潔さが最重要**：200行の整理された日本語スキルは800行の冗長な英語スキルに勝る
2. **説明不要なことは書かない**：「この行を削除するとClaudeがミスをするか？」を自問する
3. **理由を説明する**：MUST/NEVER の連発より、なぜそうすべきかを伝える
4. **description に投資する**：スキルが発火するかどうかの90%は description で決まる
5. **日本語の精度を活かす**：母語で最も正確・簡潔・明確に書けるなら、その言語で書く

## Further reading

詳細なリサーチ（トークン分析、学術研究、コミュニティ事例）については `references/detailed-guide.md` を参照。
