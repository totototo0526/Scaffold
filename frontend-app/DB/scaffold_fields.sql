CREATE TABLE public.scaffold_fields (
    field_id SERIAL PRIMARY KEY,
    definition_id INT REFERENCES public.scaffold_definitions(definition_id) ON DELETE CASCADE,
    -- Step 2: 項目定義
    db_column_name character varying(100),
    display_name character varying(255),
    ui_type character varying(50),
    use_in_list boolean DEFAULT false,      -- 一覧(C3)で使うか
    use_in_search boolean DEFAULT false,    -- 検索(C2)で使うか
    use_in_form boolean DEFAULT false,      -- フォーム(C1)で使うか
    sort_key integer
    properties JSONB -- 各項目の詳細設定を格納するためのJSONB型
    -- 例: {"c1": {"required": true, "max_length": 255}, "c2": {"filterable": true}, "c3": {"sortable": true}}
    -- これにより、C1/C2/C3ごとの設定を柔
    -- C1/C2/C3ごとの詳細設定は、jsonb型のカラムで持つと柔軟性が高まります
    -- c1_properties JSONB,
    -- c3_properties JSONB
);
COMMENT ON TABLE public.scaffold_fields IS '各画面定義に紐づく、項目ごとの詳細設定';
COMMENT ON COLUMN public.scaffold_fields.field_id IS '項目の一意な識別子';
COMMENT ON COLUMN public.scaffold_fields.definition_id IS 'この項目が紐づく画面定義のID。画面のURL識別子と連携するために使用';
COMMENT ON COLUMN public.scaffold_fields.db_column_name IS 'DBテーブルのカラム名。データベースとの連携に使用';
COMMENT ON COLUMN public.scaffold_fields.display_name IS '画面上での表示名。ユーザーに見えるラベルとして使用';
COMMENT ON COLUMN public.scaffold_fields.ui_type IS 'UIのタイプ。例: text, select, checkboxなど';
COMMENT ON COLUMN public.scaffold_fields.use_in_list IS 'この項目が一覧(C3)で使用されるかどうか';
COMMENT ON COLUMN public.scaffold_fields.use_in_search IS 'この項目が検索(C2)で使用されるかどうか';
COMMENT ON COLUMN public.scaffold_fields.use_in_form IS 'この項目がフォーム(C1)で使用されるかどうか';
COMMENT ON COLUMN public.scaffold_fields.sort_key IS 'この項目の表示順序を管理するためのキー。数値が小さいほど先に表示される';
COMMENT ON COLUMN public.scaffold_fields.properties IS '各項目の詳細設定を格納するJSONB型のカラム。C1/C2/C3ごとの設定を柔軟に管理可能';
