CREATE TABLE public.generator_properties (
    property_id SERIAL PRIMARY KEY,
    component_id VARCHAR(50) REFERENCES public.generator_components(component_id), -- どのUI部品のルールか
    property_name VARCHAR(100),       -- ルールの内部名 (例: 'link_key_column')
    target_koumoku VARCHAR(20),       -- 対応するm_hanyoのカラム名 (例: 'koumoku10')
    description TEXT                  -- UIに表示する説明文
); 
COMMENT ON TABLE public.generator_properties IS 'UI部品のプロパティ定義';
COMMENT ON COLUMN public.generator_properties.property_id IS 'プロパティの一意な識別子';
COMMENT ON COLUMN public.generator_properties.component_id IS 'このプロパティが紐づくUI部品のID。generator_componentsと連携するために使用';
COMMENT ON COLUMN public.generator_properties.property_name IS 'プロパティの内部名。ルールの識別子として使用';
COMMENT ON COLUMN public.generator_properties.target_koumoku IS '対応するm_hanyoのカラム名。UI部品の設定に使用';
COMMENT ON COLUMN public.generator_properties.description IS 'UIに表示する説明文。ユーザーが理解しやすいように設定';
