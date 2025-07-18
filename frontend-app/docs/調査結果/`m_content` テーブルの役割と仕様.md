# `m_content` テーブルの役割と仕様

## 概要

`m_content`テーブルは、アプリケーションの**ナビゲーション構造（メニュー階層）を定義する**ためのテーブルです。どのメニューがどこに表示され、クリックするとどのURLに遷移するか、といった情報を一元管理します。

---

## カラム別仕様

| カラム名 | データ型 | 役割と仕様 |
| :--- | :--- | :--- |
| **`content_id`** | `character varying(32)` | **一意のID**。各コンテンツ（メニュー項目）を識別するための主キー。 |
| **`parent_id`** | `character varying(32)` | **階層構造を定義**する重要なカラム。<br>・`_manage_header`: ヘッダーのグローバルナビゲーションに表示される。<br>・`他のcontent_id`: その`content_id`を持つメニュー項目の子要素（サイドメニューなど）として表示される。<br>・`dummy`: 画面上は親子関係を持たないが、URLで直接呼び出すための定義。 |
| **`url`** | `character varying(4000)` | リンククリック時の**遷移先URL**またはページの識別子。`m_hanyo`テーブルと連携し、表示するコンテンツを決定するキーになると思われる。 |
| **`content_kind`** | `character varying(32)` | **コンテンツの種類**。現在は`link`（ナビゲーションリンク）が主。将来的には'button'や'text'など、異なるUI部品を定義するために使われる可能性がある。 |
| **`content_title`** | `character varying(255)` | **画面に表示されるテキスト**。メニューのリンク名やページのタイトルとして使用される。 |
| `content_subtitle` | `character varying(255)` | （現在未使用）サブタイトル用。 |
| `body` | `text` | （現在未使用）本文コンテンツ用。 |
| `file_name` | `character varying(255)` | （現在未使用）関連ファイル名用。 |
| `file_image` | `bytea` | （現在未使用）画像データ用。 |
| **`sort_key`** | `character varying(20)` | **表示順序を制御**するキー。値が小さいものから順に並ぶ。 |
| `init_child_id` | `character varying(32)` | （用途不明） |
| **`del_flg`** | `smallint` | **論理削除フラグ**。<br>・`0`: 表示する。<br>・`1`: 表示しない（非表示）。 |
| `cre_id`, `cre_time`, `upd_id`, `upd_time` | | （共通項目）レコードの作成・更新者、日時を管理する監査用のカラム。 |

---

## UI生成の具体例（スクリーンショットのケース）

いただいたスクリーンショットの「仕入管理」画面は、`m_content`のデータから以下のように構築されていると推測できます。

### 1. ヘッダーの「仕入管理」タブの表示

以下のデータによって、ヘッダーメニューが生成されます。
`parent_id` が `_manage_header` になっているものが、グローバルナビゲーションとして `sort_key` の昇順で表示されます。

- **該当データ**:
  - `content_id`: "sir"
  - `parent_id`: "_manage_header"
  - `content_title`: "仕入管理"
  - `sort_key`: "0020"

### 2. 左サイドメニューの表示

ヘッダーで「仕入管理」(`content_id` = "sir") をクリックすると、今度は `parent_id` が "sir" になっているレコードがサイドメニューとして表示されます。

- **該当データ**:
  1. `content_id`: "sir-1", `parent_id`: "sir", `content_title`: "発注処理", `sort_key`: "0021", `del_flg`: **0**
  2. `content_id`: "sir-2", `parent_id`: "sir", `content_title`: "仕入処理", `sort_key`: "0022", `del_flg`: **0**

- **ポイント**:
  - `content_title`の「発注処理」「仕入処理」がリンクとして表示されています。
  - データ上には「仕入実績照会」(`content_id`: "sir-3") も `parent_id` = "sir" で存在しますが、`del_flg` が **1** のため、画面には表示されていません。