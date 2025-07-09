<script lang="ts">
  // 親コンポーネント(App)から渡されるプロパティ
  export let response: {
    status: 'idle' | 'loading' | 'success' | 'error';
    data: any;
  };
</script>

{#if response.status !== 'idle'}
  <div class="response-container" class:success={response.status === 'success'} class:error={response.status === 'error'}>
    <h2>実行結果</h2>
    
    {#if response.status === 'loading'}
      <p>処理を実行中です...</p>
      <div class="loader"></div>
    {:else if response.status === 'success'}
      <p class="status-message">✅ 正常に完了しました。</p>
      <pre>{JSON.stringify(response.data, null, 2)}</pre>
    {:else if response.status === 'error'}
      <p class="status-message">❌ エラーが発生しました。</p>
      <pre>{JSON.stringify(response.data, null, 2)}</pre>
    {/if}
  </div>
{/if}

<style>
  .response-container {
    margin-top: 32px;
    padding: 24px;
    border-radius: 8px;
    border: 1px solid;
  }
  .success {
    background-color: #e8f5e9;
    border-color: #a5d6a7;
  }
  .error {
    background-color: #ffebee;
    border-color: #ef9a9a;
  }
  h2 {
    margin-top: 0;
  }
  pre {
    background-color: #f5f5f5;
    padding: 16px;
    border-radius: 4px;
    white-space: pre-wrap;
    word-wrap: break-word;
  }
  .loader {
    border: 4px solid #f3f3f3;
    border-top: 4px solid #3498db;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    animation: spin 1s linear infinite;
  }
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
</style>
