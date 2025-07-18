CREATE TABLE public.scaffold_menu_tree (
    node_id character varying(32) PRIMARY KEY, -- m_content.content_id と同じ値を持つ
    parent_id character varying(32),
    title character varying(255),
    sort_key integer,
    -- このメニューノードが、どの画面定義と紐づくかを管理
    definition_id INT REFERENCES public.scaffold_definitions(definition_id)
);
COMMENT ON TABLE public.scaffold_menu_tree IS 'ダッシュボードのメニューツリーの構造を管理';
COMMENT ON COLUMN public.scaffold_menu_tree.node_id IS 'メニューのノードID。m_content.content_idと同じ値を持つ';
COMMENT ON COLUMN public.scaffold_menu_tree.parent_id IS '親ノードのID。ルートノードはNULL';
COMMENT ON COLUMN public.scaffold_menu_tree.title IS 'メニューの表示名';
COMMENT ON COLUMN public.scaffold_menu_tree.sort_key IS 'メニューの表示順序を管理するためのキー';
COMMENT ON COLUMN public.scaffold_menu_tree.definition_id IS 'このメニューノードが紐づく画面定義のID。画面のURL識別子と連携するために使用';

