CREATE TABLE public.scaffold_definitions (
    definition_id SERIAL PRIMARY KEY,
    -- Step 1: 基本情報
    view_id character varying(32) NOT NULL UNIQUE, -- URL識別子
    content_title character varying(255),          -- 画面表示名
    target_table character varying(100),           -- DBテーブル名
    -- 監査項目
    cre_time timestamp with time zone DEFAULT now(),
    upd_time timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public.scaffold_definitions IS 'Scaffoldで作成する画面定義のマスター';
COMMENT ON COLUMN public.scaffold_definitions.view_id IS 'URL識別子';
COMMENT ON COLUMN public.scaffold_definitions.content_title IS '画面表示名';
COMMENT ON COLUMN public.scaffold_definitions.target_table IS 'この画面が操作するDBテーブル名';
COMMENT ON COLUMN public.scaffold_definitions.cre_time IS 'レコード作成日時';
COMMENT ON COLUMN public.scaffold_definitions.upd_time IS 'レコード更新日時'; 
COMMENT ON COLUMN public.scaffold_definitions.definition_id IS '画面定義の一意な識別子。scaffold_fieldsやscaffold_menu_treeと連携するために使用';

