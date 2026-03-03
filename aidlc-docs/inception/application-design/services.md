# Services - 家計簿アプリ (Kakeibo)

## Service Architecture

本アプリはNext.js Server Actionsパターンを採用するため、従来のサービスレイヤーは不要。
Server Actions が直接 Prisma Client を通じてデータアクセスを行う。

```
+-------------------+     +-------------------+
| TransactionForm   |     | CategoryForm      |
| (Client Component)|     | (Client Component)|
+-------------------+     +-------------------+
        |                         |
        | form submit             | form submit
        v                         v
+-------------------+     +-------------------+
| Transaction       |     | Category          |
| Server Actions    |     | Server Actions    |
| (server-side)     |     | (server-side)     |
+-------------------+     +-------------------+
        |                         |
        | Zod validation          | Zod validation
        v                         v
+-------------------+     +-------------------+
| Prisma Client     |     | Prisma Client     |
| (singleton)       |     | (singleton)       |
+-------------------+     +-------------------+
        |                         |
        +------------+------------+
                     |
                     v
              +-------------+
              |   SQLite    |
              |   Database  |
              +-------------+
```

## Data Flow Patterns

### 取引登録フロー
1. ユーザーが TransactionForm にデータ入力
2. フォーム送信で `createTransaction` Server Action を呼び出し
3. Server Action が Zod でバリデーション
4. バリデーション成功: Prisma で DB に INSERT
5. バリデーション失敗: エラーメッセージを返却
6. `revalidatePath` で取引一覧を再レンダリング

### フィルタリングフロー
1. ユーザーが TransactionFilter でフィルタ条件を選択
2. URL検索パラメータを更新（`?year=2026&month=3&type=expense`）
3. Server Component がパラメータを受け取り `getTransactions` を呼び出し
4. フィルタ条件に基づいて Prisma クエリを実行
5. フィルタされた結果を TransactionList に渡す

### カテゴリ管理フロー
1. カテゴリ追加: `createCategory` Server Action → Prisma INSERT
2. カテゴリ削除: `deleteCategory` Server Action → 削除前にデフォルトチェック → Prisma DELETE
3. デフォルトカテゴリは `isDefault: true` で保護、削除不可

## Orchestration

- **キャッシュ無効化**: Server Action 完了後に `revalidatePath` でページ再検証
- **楽観的UI更新**: 不使用（シンプルさ優先、Server Action 完了後にリフレッシュ）
- **エラー伝播**: ActionResult 型で統一的にエラーをクライアントに返却
