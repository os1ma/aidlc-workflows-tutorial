# Component Methods - 家計簿アプリ (Kakeibo)

## Server Actions

### Transaction Actions

```typescript
// src/actions/transactions.ts

// 取引一覧取得（フィルタ付き）[FR-01, FR-03]
getTransactions(filter?: {
  year?: number;
  month?: number;
  categoryId?: string;
  type?: "income" | "expense";
}): Promise<ActionResult<TransactionWithCategory[]>>

// 取引新規登録 [FR-01]
createTransaction(formData: FormData): Promise<ActionResult<Transaction>>

// 取引更新 [FR-01]
updateTransaction(id: string, formData: FormData): Promise<ActionResult<Transaction>>

// 取引削除 [FR-01]
deleteTransaction(id: string): Promise<ActionResult<void>>
```

### Category Actions

```typescript
// src/actions/categories.ts

// カテゴリ一覧取得（種別フィルタ付き）[FR-02]
getCategories(type?: "income" | "expense"): Promise<ActionResult<Category[]>>

// カスタムカテゴリ追加 [FR-02]
createCategory(formData: FormData): Promise<ActionResult<Category>>

// カテゴリ削除（デフォルトカテゴリは削除不可）[FR-02]
deleteCategory(id: string): Promise<ActionResult<void>>
```

### ActionResult Type

```typescript
// 統一レスポンス型
type ActionResult<T> =
  | { success: true; data: T }
  | { success: false; error: string }
```

---

## Validation Schemas (Zod)

```typescript
// src/lib/validators.ts

// 取引作成スキーマ
createTransactionSchema: z.object({
  date: z.string().date(),          // YYYY-MM-DD
  amount: z.number().int().positive(),
  type: z.enum(["income", "expense"]),
  categoryId: z.string().cuid(),
  memo: z.string().max(200).optional(),
})

// 取引更新スキーマ
updateTransactionSchema: createTransactionSchema

// カテゴリ作成スキーマ
createCategorySchema: z.object({
  name: z.string().min(1).max(50),
  type: z.enum(["income", "expense"]),
})

// フィルタスキーマ
transactionFilterSchema: z.object({
  year: z.number().int().min(2000).max(2100).optional(),
  month: z.number().int().min(1).max(12).optional(),
  categoryId: z.string().cuid().optional(),
  type: z.enum(["income", "expense"]).optional(),
})
```

---

## UI Components

### TransactionForm
```typescript
// Props
interface TransactionFormProps {
  categories: Category[];
  editingTransaction?: TransactionWithCategory | null;
  onCancel?: () => void;
}

// 内部状態: date, amount, type, categoryId, memo
// フォーム送信: createTransaction / updateTransaction Server Action
// 編集モード: editingTransaction が渡された場合はフォームにプリフィル
```

### TransactionList
```typescript
interface TransactionListProps {
  transactions: TransactionWithCategory[];
  onEdit: (transaction: TransactionWithCategory) => void;
}

// 表示: 日付、金額（収入は青、支出は赤）、カテゴリ、メモ
// アクション: 編集ボタン、削除ボタン
```

### TransactionFilter
```typescript
interface TransactionFilterProps {
  categories: Category[];
  currentFilter: TransactionFilter;
}

// フィルタ項目: 年月セレクタ、カテゴリセレクタ、種別セレクタ
// URL検索パラメータでフィルタ状態を管理
```

### CategoryForm
```typescript
interface CategoryFormProps {
  // なし（シンプルなフォーム）
}

// 入力: カテゴリ名、種別（収入/支出）
// フォーム送信: createCategory Server Action
```

### CategoryList
```typescript
interface CategoryListProps {
  categories: Category[];
}

// 表示: 収入カテゴリ / 支出カテゴリをセクション分け
// アクション: 削除ボタン（デフォルトカテゴリは削除不可、グレーアウト）
```
