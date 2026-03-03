# Component Dependencies - 家計簿アプリ (Kakeibo)

## Dependency Matrix

| Component | Depends On | Depended By |
|---|---|---|
| TransactionsPage | TransactionForm, TransactionList, TransactionFilter, Transaction Actions, Category Actions | Header (nav link) |
| CategoriesPage | CategoryForm, CategoryList, Category Actions | Header (nav link) |
| TransactionForm | Transaction Actions, Categories (for select) | TransactionsPage |
| TransactionList | — | TransactionsPage |
| TransactionFilter | Categories (for select) | TransactionsPage |
| CategoryForm | Category Actions | CategoriesPage |
| CategoryList | Category Actions | CategoriesPage |
| Header | — | Layout (root) |
| Transaction Actions | Prisma Client, Validators, Logger | TransactionsPage, TransactionForm |
| Category Actions | Prisma Client, Validators, Logger | CategoriesPage, CategoryForm, CategoryList |
| Validators | — | Transaction Actions, Category Actions |
| Prisma Client | — | Transaction Actions, Category Actions |
| Logger | — | Transaction Actions, Category Actions |

## Data Flow Diagram

```
+--------+    navigate    +--------------------+
| Header | ------------> | TransactionsPage   |
|        |               | (Server Component) |
+--------+               +--------------------+
    |                        |           |
    | navigate               | data      | data
    v                        v           v
+-------------------+   +-----------+ +-----------+
| CategoriesPage    |   | Tran.Form | | Tran.List |
| (Server Component)|   | (Client)  | | (Client)  |
+-------------------+   +-----------+ +-----------+
    |           |            |
    | data      | data       | Server Action
    v           v            v
+-----------+ +-----------+ +---------------------+
| Cat.Form  | | Cat.List  | | Transaction Actions |
| (Client)  | | (Client)  | | (Server-side)       |
+-----------+ +-----------+ +---------------------+
    |               |            |
    | Server Action | Server Act.| Prisma
    v               v            v
+---------------------+    +----------+
| Category Actions    | -> | Prisma   |
| (Server-side)       |    | Client   |
+---------------------+    +----------+
                                 |
                                 v
                            +----------+
                            |  SQLite  |
                            +----------+
```

## Communication Patterns

### Server Component → Client Component
- Props 経由でデータを渡す（取引一覧、カテゴリ一覧）
- Server Component で初期データをフェッチし、Client Component にシリアライズして渡す

### Client Component → Server Action
- フォーム送信 (`action` 属性) または `startTransition` 経由で呼び出し
- 結果は ActionResult 型で受け取り

### Server Action → Database
- Prisma Client 経由（全てパラメータ化クエリ、SQL Injection 防止）

## Cross-Cutting Concerns

| Concern | Implementation |
|---|---|
| バリデーション | Zod schemas (validators.ts) — Server Actions で一元適用 |
| エラーハンドリング | ActionResult 型 + try/catch in Server Actions |
| ログ | logger.ts — Server Actions 内でログ出力 |
| セキュリティヘッダー | next.config.ts — 全ページに適用 |
