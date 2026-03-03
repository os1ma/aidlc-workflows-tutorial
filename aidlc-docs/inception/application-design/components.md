# Components - 家計簿アプリ (Kakeibo)

## Overview

```
+-----------------------------------------------------------+
|                    Kakeibo Web App                         |
|                                                           |
|  +-----------------------------------------------------+  |
|  |  Pages (App Router)                                 |  |
|  |  +----------------+  +-------------------+          |  |
|  |  | /transactions  |  | /categories       |          |  |
|  |  | (取引一覧)     |  | (カテゴリ管理)    |          |  |
|  |  +----------------+  +-------------------+          |  |
|  +-----------------------------------------------------+  |
|                                                           |
|  +-----------------------------------------------------+  |
|  |  UI Components                                      |  |
|  |  +------------------+  +---------------------+      |  |
|  |  | TransactionForm  |  | TransactionList     |      |  |
|  |  | TransactionFilter|  | CategoryForm        |      |  |
|  |  | Header           |  | CategoryList        |      |  |
|  |  +------------------+  +---------------------+      |  |
|  +-----------------------------------------------------+  |
|                                                           |
|  +-----------------------------------------------------+  |
|  |  Server Actions                                     |  |
|  |  +------------------+  +---------------------+      |  |
|  |  | transactions.ts  |  | categories.ts       |      |  |
|  |  +------------------+  +---------------------+      |  |
|  +-----------------------------------------------------+  |
|                                                           |
|  +-----------------------------------------------------+  |
|  |  Core Library                                       |  |
|  |  +----------+  +--------------+  +--------+         |  |
|  |  | prisma   |  | validators   |  | logger |         |  |
|  |  +----------+  +--------------+  +--------+         |  |
|  +-----------------------------------------------------+  |
|                                                           |
|  +-----------------------------------------------------+  |
|  |  Data Layer (Prisma + SQLite)                       |  |
|  +-----------------------------------------------------+  |
+-----------------------------------------------------------+
```

---

## Component Definitions

### 1. Pages Layer

#### 1.1 TransactionsPage (`/transactions`)
- **責務**: 取引の一覧表示、登録、編集、削除、フィルタリング
- **構成**: TransactionForm + TransactionFilter + TransactionList を組み合わせ
- **タイプ**: Server Component（初期データ取得） + Client Components（インタラクション）

#### 1.2 CategoriesPage (`/categories`)
- **責務**: カテゴリの一覧表示、追加、削除
- **構成**: CategoryForm + CategoryList を組み合わせ
- **タイプ**: Server Component + Client Components

#### 1.3 HomePage (`/`)
- **責務**: アプリのエントリーポイント、取引ページへリダイレクト

### 2. UI Components Layer

#### 2.1 Header
- **責務**: アプリ名表示、ページ間ナビゲーション
- **タイプ**: Server Component

#### 2.2 TransactionForm
- **責務**: 取引の新規登録・編集フォーム（インライン表示）
- **タイプ**: Client Component
- **入力**: 日付、金額、種別（収入/支出）、カテゴリ、メモ
- **アクション**: Server Action 経由でCRUD実行

#### 2.3 TransactionList
- **責務**: 取引一覧をテーブル形式で表示、編集・削除ボタン
- **タイプ**: Client Component

#### 2.4 TransactionFilter
- **責務**: 月別、カテゴリ別、種別のフィルタリングUI
- **タイプ**: Client Component

#### 2.5 CategoryForm
- **責務**: カスタムカテゴリの追加フォーム
- **タイプ**: Client Component

#### 2.6 CategoryList
- **責務**: カテゴリ一覧表示（収入用・支出用に分類）、削除ボタン
- **タイプ**: Client Component

### 3. Server Actions Layer

#### 3.1 Transaction Actions (`src/actions/transactions.ts`)
- **責務**: 取引データのCRUD操作、入力バリデーション、エラーハンドリング
- **データアクセス**: Prisma Client 経由で SQLite にアクセス

#### 3.2 Category Actions (`src/actions/categories.ts`)
- **責務**: カテゴリデータのCRUD操作、入力バリデーション、エラーハンドリング
- **データアクセス**: Prisma Client 経由で SQLite にアクセス

### 4. Core Library Layer

#### 4.1 Prisma Client (`src/lib/prisma.ts`)
- **責務**: Prisma Client のシングルトン管理、開発時のホットリロード対応

#### 4.2 Validators (`src/lib/validators.ts`)
- **責務**: Zod スキーマによる入力バリデーション定義

#### 4.3 Logger (`src/lib/logger.ts`)
- **責務**: 構造化ログ出力（timestamp, level, message）

### 5. Data Layer

#### 5.1 Transaction Model
- **テーブル**: transactions
- **フィールド**: id, date, amount, type (income/expense), categoryId, memo, createdAt, updatedAt

#### 5.2 Category Model
- **テーブル**: categories
- **フィールド**: id, name, type (income/expense), isDefault, createdAt
- **リレーション**: Transaction は Category に belongsTo
