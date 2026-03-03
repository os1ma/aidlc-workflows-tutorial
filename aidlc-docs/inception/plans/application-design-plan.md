# Application Design Plan - 家計簿アプリ (Kakeibo)

## Context

- **Project Type**: Greenfield
- **Tech Stack**: Next.js (TypeScript) + SQLite + Prisma + Tailwind CSS
- **Functional Requirements**: 収入・支出記録 (FR-01), カテゴリ分類 (FR-02), 一覧表示・フィルタリング (FR-03)
- **Non-Functional**: 認証なし、日本語のみ、ローカル開発のみ

---

## Design Plan

### Phase 1: Component Identification

- [x] アプリケーションの主要コンポーネントを特定
- [x] 各コンポーネントの責務を定義
- [x] コンポーネント間の境界を明確化

### Phase 2: Component Methods

- [x] 各コンポーネントのメソッドシグネチャを定義
- [x] 入出力の型を明確化
- [x] ビジネスルールの概要を記述

### Phase 3: Service Layer Design

- [x] データアクセスパターンを定義
- [x] サービス間のオーケストレーションを設計

### Phase 4: Component Dependencies

- [x] 依存関係マトリクスの作成
- [x] データフローの定義

### Phase 5: Artifact Generation

- [x] components.md 生成
- [x] component-methods.md 生成
- [x] services.md 生成
- [x] component-dependency.md 生成
- [x] 設計の整合性検証

---

## Design Questions

以下の質問に回答をお願いします。各質問の `[Answer]:` タグの後に選択肢の記号を記入してください。

### Question 1

Next.js のデータアクセスパターンはどれを希望しますか？

A) Server Actions（フォーム送信やデータ変更に直接使用、Next.js 推奨のパターン）
B) API Routes（REST API エンドポイントを作成し、フロントエンドから fetch で呼び出す）
C) Other (please describe after [Answer]: tag below)

[Answer]: A

### Question 2

取引一覧とカテゴリ管理の画面構成はどれを希望しますか？

A) 別ページ構成（取引一覧ページ + カテゴリ管理ページ、ナビゲーションで切替）
B) 単一ページ構成（タブやセクションで取引とカテゴリを同一画面に表示）
C) Other (please describe after [Answer]: tag below)

[Answer]: A

### Question 3

取引の登録・編集UIはどの方式を希望しますか？

A) インラインフォーム（一覧の上部に常時表示されるフォーム）
B) モーダルダイアログ（ボタンクリックでフォームをポップアップ表示）
C) 別ページ（登録/編集専用ページに遷移）
D) Other (please describe after [Answer]: tag below)

[Answer]: A
