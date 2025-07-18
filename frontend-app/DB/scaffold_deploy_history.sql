CREATE TABLE public.scaffold_deploy_history (
    history_id SERIAL PRIMARY KEY,
    definition_id INT REFERENCES public.scaffold_definitions(definition_id),
    -- どのターゲットDBに適用したか
    target_id character varying(50), -- target_db_connections.target_id と対応
    status character varying(20), -- 'success' or 'failed'
    executed_at timestamp with time zone DEFAULT now(),
    error_message TEXT
);
COMMENT ON TABLE public.scaffold_deploy_history IS 'Scaffoldの定義を、どのターゲットDBにいつ適用したかの履歴';
COMMENT ON COLUMN public.scaffold_deploy_history.history_id IS 'デプロイ履歴の一意な識別子';
COMMENT ON COLUMN public.scaffold_deploy_history.definition_id IS 'このデプロイが適用された画面定義のID。scaffold_definitionsと連携するために使用';
COMMENT ON COLUMN public.scaffold_deploy_history.target_id IS 'デプロイ先のターゲットDBのID。target_db_connections.target_idと対応';
COMMENT ON COLUMN public.scaffold_deploy_history.status IS 'デプロイの結果ステータス。成功なら\'success\'、失敗なら\'failed\'';
COMMENT ON COLUMN public.scaffold_deploy_history.executed_at IS 'デプロイが実行された日時';
COMMENT ON COLUMN public.scaffold_deploy_history.error_message IS 'デプロイが失敗した場合のエラーメッセージ。成功時はNULLになる';
