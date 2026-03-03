# Requirements Document - 家計簿Webアプリ

## Intent Analysis

- **User Request**: 家計簿（家計管理）アプリを作りたい。ミニマムなWebアプリ。
- **Request Type**: New Project (Greenfield)
- **Scope Estimate**: Single Component (Next.js fullstack application)
- **Complexity Estimate**: Simple - clear requirements, single framework, minimal features

---

## Functional Requirements

### FR-01: 収入・支出の記録
- ユーザーは収入または支出を新規登録できる
- 各記録には以下の情報を含む：
  - 日付（必須）
  - 金額（必須、正の整数）
  - 種別（収入 or 支出、必須）
  - カテゴリ（必須）
  - メモ（任意）
- ユーザーは登録済みの記録を編集できる
- ユーザーは登録済みの記録を削除できる
- 記録の一覧を表示できる（日付順）

### FR-02: カテゴリ分類
- 収入用と支出用にそれぞれデフォルトカテゴリを用意する
  - 収入例: 給与、副業、その他
  - 支出例: 食費、住居費、交通費、日用品、娯楽、その他
- ユーザーはカスタムカテゴリを追加できる
- カテゴリごとに記録をフィルタリング表示できる

### FR-03: 一覧表示・フィルタリング
- 記録を日付の新しい順で一覧表示
- 月別でフィルタリング可能
- カテゴリ別でフィルタリング可能
- 種別（収入/支出）でフィルタリング可能

---

## Non-Functional Requirements

### NFR-01: 技術スタック
- **フレームワーク**: Next.js (TypeScript)
- **データベース**: SQLite (ファイルベース)
- **UIフレームワーク**: Tailwind CSS（Next.jsとの標準的な組み合わせ）
- **ORM**: Prisma（SQLiteとの統合が容易）
- **パッケージマネージャ**: npm or pnpm

### NFR-02: UI/UX
- 日本語のみ対応
- レスポンシブデザイン（モバイル対応は任意だがデスクトップは必須）
- シンプルで直感的なUI

### NFR-03: デプロイメント
- ローカル開発環境のみ（個人利用）
- `npm run dev` または同等のコマンドで起動可能

### NFR-04: 認証
- 認証なし（シングルユーザー）
- ログイン機能なし

### NFR-05: セキュリティ
- SECURITYルールを適用（該当するもののみ）
- 認証関連ルール（SECURITY-08, SECURITY-12）は認証なしのためN/A
- 入力バリデーション（SECURITY-05）は適用
- エラーハンドリング（SECURITY-15）は適用
- その他ルールはステージごとに適用可否を判断

---

## Constraints

- 既存のPython環境（pyproject.toml, uv）は使用しない
- Next.js + TypeScriptで完結するフルスタック構成
- SQLiteファイルはプロジェクトルートまたはdata/ディレクトリに配置
- 外部サービス依存なし

---

## Out of Scope

- グラフ表示・チャート機能
- 予算設定・アラート機能
- ユーザー認証・マルチユーザー対応
- クラウドデプロイ
- 多言語対応
- データのインポート/エクスポート
- レシート読み取り・OCR
