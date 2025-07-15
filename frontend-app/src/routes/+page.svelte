<script lang="ts">
    import Header from "$lib/Header.svelte";
    import DefinitionForm from "$lib/DefinitionForm.svelte";
    import ResponseDisplay from "$lib/ResponseDisplay.svelte";
    import { onMount } from "svelte";

    // 取得した接続先リストを保持する変数
    let targets: Array<{ target_id: string; target_display_name: string }> = [];
    // 選択されたtarget_idを保持する変数
    let selectedTargetId = "";
    // 入力されたパスワードを保持する変数
    let password = "";

    // ページが表示された時に一度だけ実行される
    onMount(() => {
        const fetchTargets = async () => {
            const apiUrl =
                `https://n8n.totototo0526.site/webhook/8d025c10-75db-4b8a-957b-ebb04c321683?timestamp=${Date.now()}`;
            const response = await fetch(apiUrl);
            if (response.ok) {
                const data = await response.json();
                if (Array.isArray(data)) {
                    targets = data;
                } else if (data && typeof data === "object") {
                    targets = [data];
                } else {
                    targets = [];
                }
            }
        };

        fetchTargets();

        window.addEventListener('pageshow', fetchTargets);

        return () => {
            window.removeEventListener('pageshow', fetchTargets);
        };
    });

    // APIの応答とローディング状態を管理する変数
    let apiResponse = {
        status: "idle" as "idle" | "loading" | "success" | "error",
        data: null as any,
    };

    // DefinitionFormからのsubmitイベントを処理する関数
    async function handleApiSubmit(event: CustomEvent) {
        // DefinitionFormからの画面定義データ（旧：definitionPayload）
        const def = event.detail;

        // creator_id, views, itemsをトップレベルに展開
        const payload = {
            db_target_id: selectedTargetId, // 接続先DBのID
            password: password,
            target_id: def.target_id, // こちらがDefinitionFormからのtarget_id
            creator_id: def.creator_id,
            views: def.views,
            items: def.items
        };

        // ローディング状態を開始
        apiResponse = { status: "loading", data: null };

        try {
            // TODO: このURLを、実際のn8nのWebhook URLに書き換えてください
            //   const n8nWebhookUrl = 'https://n8n.totototo0526.site/webhook/603d0cf0-ec23-48e9-bcf2-7675aefd4e4a';
            const n8nWebhookUrl =
                "https://n8n.totototo0526.site/webhook-test/603d0cf0-ec23-48e9-bcf2-7675aefd4e4a";

            const response = await fetch(n8nWebhookUrl, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(payload),
            });

            const result = await response.json();

            // n8nから返却されたstatus/messageを画面に表示
            if (result.status === 'success') {
                apiResponse = { status: "success", data: { message: result.message } };
            } else {
                apiResponse = { status: "error", data: { message: result.message || 'APIエラーが発生しました' } };
            }
        } catch (error: any) {
            apiResponse = { status: "error", data: { message: error.message || '通信エラーが発生しました。' } };
        }
    }
</script>

<main>
    <Header />

    <div class="content-wrapper">
        <div class="admin-link-container">
            <a href="/admin/connections" class="admin-link">接続先DB管理</a>
        </div>
        <form
            class="connection-form"
            autocomplete="off"
            on:submit|preventDefault
        >
            <div class="form-row">
                <label for="connection-select">接続先</label>
                <select
                    id="connection-select"
                    name="connection"
                    bind:value={selectedTargetId}
                >
                    <option value="">選択してください</option>
                    {#each targets as target}
                        <option value={target.target_id}
                            >{target.target_display_name}</option
                        >
                    {/each}
                </select>
            </div>
            <div class="form-row">
                <label for="password-input">パスワード</label>
                <input
                    id="password-input"
                    name="password"
                    type="password"
                    placeholder="パスワードを入力"
                    bind:value={password}
                />
            </div>
        </form>

        <!-- 画面定義フォーム（既存） -->
        <DefinitionForm on:submit={handleApiSubmit} />

        <!-- 応答表示エリア -->
        <ResponseDisplay response={apiResponse} />
    </div>
</main>

<style>
    main {
        font-family: sans-serif;
        background-color: #f4f5f7;
        min-height: 100vh;
    }

    .content-wrapper {
        /* ★修正点: 最大幅を1200pxから1400pxに広げます */
        max-width: 1400px;
        margin: 0 auto;
        padding: 32px;
    }
    .connection-form {
        display: flex;
        gap: 32px;
        margin-bottom: 32px;
        align-items: flex-end;
    }
    .form-row {
        display: flex;
        flex-direction: column;
        gap: 8px;
        min-width: 200px;
    }
    label {
        font-size: 0.95em;
        color: #333;
        margin-bottom: 2px;
    }
    select,
    input[type="password"] {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 1em;
    }

    .admin-link-container {
        text-align: right;
        margin-bottom: 16px;
    }

    .admin-link {
        display: inline-block;
        padding: 8px 16px;
        background-color: #607d8b;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 0.9em;
        transition: background-color 0.2s;
    }

    .admin-link:hover {
        background-color: #455a64;
    }
</style>
