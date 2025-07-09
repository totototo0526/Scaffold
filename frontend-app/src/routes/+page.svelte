<script lang="ts">
    import Header from "$lib/Header.svelte";
    import DefinitionForm from "$lib/DefinitionForm.svelte";
    import ResponseDisplay from "$lib/ResponseDisplay.svelte";

    // APIの応答とローディング状態を管理する変数
    let apiResponse = {
        status: "idle" as "idle" | "loading" | "success" | "error",
        data: null as any,
    };

    // DefinitionFormからのsubmitイベントを処理する関数
    async function handleApiSubmit(event: CustomEvent) {
        const payload = event.detail;

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

            if (!response.ok) {
                throw new Error(result.message || "APIエラーが発生しました");
            }

            // 成功時の状態を更新
            apiResponse = { status: "success", data: result };
        } catch (error: any) {
            // エラー時の状態を更新
            apiResponse = { status: "error", data: { message: error.message } };
        }
    }
</script>

<main>
    <Header />

    <div class="content-wrapper">
        <!-- on:submitで、子コンポーネントからのイベントを捕捉し、handleApiSubmit関数を実行 -->
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
</style>
