CREATE TABLE public.generator_components (
    component_id VARCHAR(50) PRIMARY KEY, -- 'list', 'search_form'など、UI部品の内部ID
    label VARCHAR(100),                  -- UIに表示する名前 (例: '一覧 (C3)')
    target_mst_kbn VARCHAR(4)            -- 対応するm_hanyoのmst_kbn
);
COMMENT ON TABLE public.generator_components IS 'UI部品の定義';
COMMENT ON COLUMN public.generator_components.component_id IS 'UI部品の一意な識別子';
COMMENT ON COLUMN public.generator_components.label IS 'UIに表示する名前';
COMMENT ON COLUMN public.generator_components.target_mst_kbn IS '対応するm_hanyoのmst_kbn';
