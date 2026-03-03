# Requirements Verification Questions - 家計簿Webアプリ

以下の質問に回答をお願いします。各質問の `[Answer]:` タグの後に、選択肢の記号を記入してください。
該当する選択肢がない場合は、最後の「Other」を選択し、詳細を記述してください。

---

## Question 1

家計簿アプリの主要な機能として、どの範囲を想定していますか？

A) 収入・支出の記録のみ（最小限）
B) 収入・支出の記録 + カテゴリ分類 + 月別集計
C) 収入・支出の記録 + カテゴリ分類 + 月別集計 + グラフ表示
D) 上記すべて + 予算設定・アラート機能
E) Other (please describe after [Answer]: tag below)

[Answer]: D

---

## Question 2

ユーザー認証（ログイン機能）は必要ですか？

A) 不要（シングルユーザー、認証なし）
B) 簡易的なパスワード認証のみ
C) ユーザー登録・ログイン機能あり（マルチユーザー対応）
D) Other (please describe after [Answer]: tag below)

[Answer]: A

---

## Question 3

データの保存方法はどれを希望しますか？

A) SQLite（ファイルベース、サーバー不要、シンプル）
B) PostgreSQL（本格的なRDBMS）
C) JSON/ファイルベース（最もシンプル）
D) Other (please describe after [Answer]: tag below)

[Answer]: A

---

## Question 4

Webフレームワークはどれを希望しますか？（Python環境が設定済み）

A) Flask（軽量、シンプル、学習コストが低い）
B) FastAPI（モダン、API重視、型安全）
C) Django（フルスタック、管理画面付き）
D) Other (please describe after [Answer]: tag below)

[Answer]:D. Next.js

---

## Question 5

フロントエンド（UI）のアプローチはどれを希望しますか？

A) サーバーサイドレンダリング（Jinja2テンプレート + シンプルなHTML/CSS）
B) サーバーサイドレンダリング + htmx（モダンなインタラクション）
C) SPA（React/Vue等のフロントエンドフレームワーク + API）
D) Other (please describe after [Answer]: tag below)

[Answer]:D. おまかせで。

---

## Question 6

UIのデザインフレームワークはどれを希望しますか？

A) Bootstrap（定番、コンポーネント豊富）
B) Tailwind CSS（ユーティリティファースト、カスタマイズ性高い）
C) 素のCSS（最小限、フレームワークなし）
D) Other (please describe after [Answer]: tag below)

[Answer]:D. おまかせで。

---

## Question 7

アプリの使用言語（UI表示）はどちらですか？

A) 日本語のみ
B) 英語のみ
C) 日本語・英語の両方（多言語対応）
D) Other (please describe after [Answer]: tag below)

[Answer]: A

---

## Question 8

デプロイ先はどこを想定していますか？

A) ローカル開発環境のみ（個人利用）
B) クラウド（Heroku, Render, Fly.io等）
C) Docker コンテナ
D) 特に決めていない
E) Other (please describe after [Answer]: tag below)

[Answer]: A

---

## Question 9: Security Extensions

このプロジェクトにセキュリティ拡張ルールを適用しますか？

A) はい — すべてのSECURITYルールをブロッキング制約として適用する（本番運用向けアプリケーション推奨）
B) いいえ — SECURITYルールをスキップする（PoC、プロトタイプ、実験的プロジェクト向け）
C) Other (please describe after [Answer]: tag below)

[Answer]: A
