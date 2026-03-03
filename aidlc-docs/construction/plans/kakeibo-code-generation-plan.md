# Code Generation Plan - 家計簿アプリ (Kakeibo)

## Unit Context
- **Unit Name**: kakeibo (単一ユニット)
- **Project Type**: Greenfield
- **Tech Stack**: Next.js (TypeScript) + SQLite + Prisma + Tailwind CSS
- **Workspace Root**: /workspaces/workspace
- **Design Artifacts**: `aidlc-docs/inception/application-design/`

## Requirements Traceability
- **FR-01**: 収入・支出の記録（CRUD）
- **FR-02**: カテゴリ分類（デフォルト + カスタム）
- **FR-03**: 一覧表示・フィルタリング（月別・カテゴリ別・種別）

## Design Decisions (Application Design より)
- **データアクセス**: Server Actions
- **画面構成**: 別ページ（/transactions + /categories）
- **取引フォーム**: インラインフォーム（一覧上部に常時表示）
- **バリデーション**: Zod schemas
- **レスポンス型**: ActionResult<T> で統一

## Security Rules (Applicable)
- SECURITY-03: 構造化ログ
- SECURITY-04: HTTPセキュリティヘッダー
- SECURITY-05: API入力バリデーション（Zod）
- SECURITY-09: エラーハンドリング（本番エラー非公開）
- SECURITY-10: 依存関係管理（lockfile）
- SECURITY-11: セキュリティ分離
- SECURITY-13: 安全なデシリアライゼーション
- SECURITY-15: 例外ハンドリング（try/catch, ActionResult）

---

## Code Generation Steps

### Step 1: プロジェクト初期化
- [x] `npx create-next-app` で Next.js プロジェクト作成（TypeScript, Tailwind CSS, App Router, ESLint）
- [x] Prisma, Zod の依存追加
- [x] プロジェクト構成確認

### Step 2: Prisma スキーマ & シード
- [ ] `prisma/schema.prisma` — SQLite, Transaction + Category モデル
  - Transaction: id, date, amount, type, categoryId, memo, createdAt, updatedAt
  - Category: id, name, type, isDefault, createdAt
  - リレーション: Transaction belongsTo Category
- [ ] `prisma/seed.ts` — デフォルトカテゴリ
  - 収入: 給与, 副業, その他
  - 支出: 食費, 住居費, 交通費, 日用品, 娯楽, その他
- [ ] Prisma generate & migrate 実行

### Step 3: コアライブラリ
- [ ] `src/lib/prisma.ts` — Prisma Client シングルトン [component-dependency.md]
- [ ] `src/lib/validators.ts` — Zod スキーマ [component-methods.md] [SECURITY-05]
  - createTransactionSchema, updateTransactionSchema
  - createCategorySchema
  - transactionFilterSchema
- [ ] `src/lib/logger.ts` — 構造化ログ [SECURITY-03]

### Step 4: コアライブラリ テスト
- [ ] `__tests__/lib/validators.test.ts`
  - 正常系: 有効なデータでバリデーション通過
  - 異常系: 不正な金額、空文字、長すぎるメモ等

### Step 5: Server Actions — 取引 CRUD
- [ ] `src/actions/transactions.ts` [component-methods.md]
  - getTransactions(filter?) — フィルタ付き取得 [FR-01, FR-03]
  - createTransaction(formData) — 新規登録 [FR-01]
  - updateTransaction(id, formData) — 更新 [FR-01]
  - deleteTransaction(id) — 削除 [FR-01]
  - ActionResult<T> 型で統一レスポンス
  - Zod バリデーション [SECURITY-05]
  - try/catch + ログ [SECURITY-15, SECURITY-03]
  - revalidatePath で再検証

### Step 6: Server Actions — カテゴリ CRUD
- [ ] `src/actions/categories.ts` [component-methods.md]
  - getCategories(type?) — 一覧取得 [FR-02]
  - createCategory(formData) — 追加 [FR-02]
  - deleteCategory(id) — 削除（デフォルト保護） [FR-02]
  - ActionResult<T> 型、Zod バリデーション、try/catch + ログ

### Step 7: Server Actions テスト
- [ ] `__tests__/actions/transactions.test.ts`
  - CRUD 正常系・異常系
  - バリデーションエラーケース
- [ ] `__tests__/actions/categories.test.ts`
  - CRUD 正常系・異常系
  - デフォルトカテゴリ削除防止

### Step 8: Layout & Header
- [ ] `src/app/layout.tsx` — Root layout、メタデータ、フォント設定
- [ ] `src/app/globals.css` — Tailwind CSS base
- [ ] `src/components/Header.tsx` — ナビゲーション [components.md]
  - 「取引一覧」「カテゴリ管理」リンク
  - data-testid="header-nav-transactions", data-testid="header-nav-categories"

### Step 9: 取引ページ & コンポーネント
- [ ] `src/app/transactions/page.tsx` — Server Component [components.md]
  - フィルタパラメータ取得 → getTransactions, getCategories 呼び出し
  - TransactionForm, TransactionFilter, TransactionList に Props 渡し
- [ ] `src/components/TransactionForm.tsx` — Client Component [component-methods.md]
  - インラインフォーム（日付, 金額, 種別, カテゴリ, メモ）
  - 編集モード対応（editingTransaction prop）
  - data-testid 属性付与
- [ ] `src/components/TransactionList.tsx` — Client Component [component-methods.md]
  - テーブル形式表示、編集・削除ボタン
  - 収入=青、支出=赤の色分け
  - data-testid 属性付与
- [ ] `src/components/TransactionFilter.tsx` — Client Component [component-methods.md]
  - 年月、カテゴリ、種別セレクタ
  - URL検索パラメータで状態管理
  - data-testid 属性付与

### Step 10: カテゴリページ & コンポーネント
- [ ] `src/app/categories/page.tsx` — Server Component [components.md]
  - getCategories 呼び出し
  - CategoryForm, CategoryList に Props 渡し
- [ ] `src/components/CategoryForm.tsx` — Client Component [component-methods.md]
  - カテゴリ名 + 種別セレクタ
  - data-testid 属性付与
- [ ] `src/components/CategoryList.tsx` — Client Component [component-methods.md]
  - 収入/支出セクション分け
  - デフォルトカテゴリは削除不可（グレーアウト）
  - data-testid 属性付与

### Step 11: ホームページ
- [ ] `src/app/page.tsx` — /transactions へリダイレクト

### Step 12: Next.js 設定 & セキュリティ
- [ ] `next.config.ts` — セキュリティヘッダー [SECURITY-04]
  - Content-Security-Policy: default-src 'self'
  - Strict-Transport-Security: max-age=31536000; includeSubDomains
  - X-Content-Type-Options: nosniff
  - X-Frame-Options: DENY
  - Referrer-Policy: strict-origin-when-cross-origin

### Step 13: ドキュメント
- [ ] `aidlc-docs/construction/kakeibo/code/code-summary.md` — 生成コードサマリー

---

## Execution Notes
- Step 1 完了後、後続ステップは生成されたプロジェクト内で実施
- 全 Server Actions に Zod バリデーション + try/catch + ActionResult
- フロントエンド要素に data-testid 属性を付与
- テストは Jest + Testing Library を使用
