<script lang="ts">
  let target_id = '';
  let target_display_name = '';
  let db_host = '';
  let db_port: number | null = null;
  let db_name = '';
  let db_user = '';
  let db_password = '';

  let apiResponse = {
    status: 'idle' as 'idle' | 'loading' | 'success' | 'error',
    message: ''
  };

  import { createEventDispatcher } from 'svelte';

  const dispatch = createEventDispatcher();

  async function handleSubmit() {
    apiResponse = { status: 'loading', message: '' };

    const n8nWebhookUrl = 'https://n8n.totototo0526.site/webhook-test/59d59722-ed03-4c28-a61c-c585b61d69dc';

    const payload = {
      target_id,
      target_display_name,
      db_host,
      db_port,
      db_name,
      db_user,
      db_password
    };

    try {
      const response = await fetch(n8nWebhookUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
      });

      const result = await response.json();

      if (response.ok && result.status === 'success') {
        apiResponse = { status: 'success', message: '登録に成功しました！' };
        dispatch('registerSuccess');
        // Clear form fields
        target_id = '';
        target_display_name = '';
        db_host = '';
        db_port = null;
        db_name = '';
        db_user = '';
        db_password = '';
      } else {
        apiResponse = { status: 'error', message: result.message || '不明なエラーが発生しました。' };
      }
    } catch (error: any) {
      apiResponse = { status: 'error', message: 'サーバーとの通信に失敗しました。' };
    }
  }
</script>

<div class="new-connection-form-container">
  <h2>新しい接続先の登録</h2>
  <p>新しいデータベース接続情報を登録します。</p>
  <form on:submit|preventDefault={handleSubmit}>
    <div class="form-grid">
      <label>
        ターゲットID
        <input type="text" placeholder="例: new_customer_prod" bind:value={target_id} required />
      </label>
      <label>
        表示名
        <input type="text" placeholder="例: 新規顧客本番DB" bind:value={target_display_name} required />
      </label>
      <label>
        ホスト
        <input type="text" placeholder="例: db.example.com" bind:value={db_host} required />
      </label>
      <label>
        ポート
        <input type="number" placeholder="例: 5432" bind:value={db_port} required />
      </label>
      <label>
        DB名
        <input type="text" placeholder="例: main_database" bind:value={db_name} required />
      </label>
      <label>
        ユーザー
        <input type="text" placeholder="例: db_user_name" bind:value={db_user} required />
      </label>
      <label>
        パスワード
        <input type="password" bind:value={db_password} required />
      </label>
    </div>
    <div class="submit-container">
      <button type="submit" class="submit-button" disabled={apiResponse.status === 'loading'}>
        {#if apiResponse.status === 'loading'}処理中...{:else}登録{/if}
      </button>
    </div>
  </form>

  {#if apiResponse.status === 'success'}
    <div class="response-message success">{apiResponse.message}</div>
  {/if}
  {#if apiResponse.status === 'error'}
    <div class="response-message error">{apiResponse.message}</div>
  {/if}
</div>

<style>
  .new-connection-form-container {
    background-color: #f0f4f8; /* Light blue-gray background */
    padding: 24px;
    border-radius: 8px;
    margin-bottom: 24px;
    max-width: 700px; /* Limit width for better readability */
    margin: 20px auto; /* Center the form */
  }
  h2 {
    margin-top: 0;
    font-size: 1.8em;
    color: #1a237e; /* Dark blue from TargetDB */
    border-bottom: 2px solid #c5cae9; /* Light blue from TargetDB */
    padding-bottom: 8px;
  }
  p {
    color: #546e7a; /* Medium gray from TargetDB */
    margin-top: 8px;
    font-size: 0.9em;
    margin-bottom: 20px;
  }
  .form-grid {
    display: grid;
    grid-template-columns: 1fr; /* Single column for simplicity */
    gap: 16px;
    margin-top: 16px;
  }
  label {
    display: flex;
    flex-direction: column;
    font-weight: bold;
    color: #3f51b5; /* Indigo from TargetDB */
  }
  input {
    margin-top: 4px;
    padding: 10px 12px; /* Slightly larger padding */
    border: 1px solid #9fa8da; /* Light indigo border from TargetDB */
    border-radius: 4px;
    font-size: 1em;
  }
  .submit-container {
    margin-top: 32px;
    text-align: right;
  }
  .submit-button {
    padding: 12px 24px;
    font-size: 1.2em;
    font-weight: bold;
    background-color: #303f9f; /* Darker indigo from DefinitionForm */
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.2s, opacity 0.2s;
  }
  .submit-button:hover {
    background-color: #1a237e; /* Even darker indigo from DefinitionForm */
  }
  .submit-button:disabled {
    opacity: 0.7;
    cursor: not-allowed;
  }
  .response-message {
    margin-top: 20px;
    padding: 10px;
    border-radius: 4px;
    font-weight: bold;
  }
  .response-message.success {
    background-color: #e8f5e9; /* Light green */
    color: #2e7d32; /* Dark green */
    border: 1px solid #a5d6a7; /* Green border */
  }
  .response-message.error {
    background-color: #ffebee; /* Light red */
    color: #c62828; /* Dark red */
    border: 1px solid #ef9a9a; /* Red border */
  }
</style>
