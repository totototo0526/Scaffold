<script lang="ts">
  import Header from '$lib/Header.svelte';
  import { onMount } from 'svelte';

  let targets: Array<{ target_id: string; target_display_name: string }> = [];
  let message = { type: '', text: '' };

  async function fetchTargets() {
    const apiUrl = `https://n8n.totototo0526.site/webhook/get-targets?timestamp=${Date.now()}`;
    const response = await fetch(apiUrl);
    if (response.ok) {
      const data = await response.json();
      if (Array.isArray(data)) {
        targets = data;
      } else if (data && typeof data === 'object') {
        targets = [data];
      } else {
        targets = [];
      }
    }
  }

  async function deleteTarget(targetId: string, targetDisplayName: string) {
    if (confirm(`${targetDisplayName}を本当に削除しますか？`)) {
      const response = await fetch('https://n8n.totototo0526.site/webhook/delete-target', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ target_id: targetId }),
      });

      const result = await response.json();

      if (result.status === 'success') {
        message = { type: 'success', text: '削除しました' };
        await fetchTargets();
      } else {
        message = { type: 'error', text: result.message || '削除に失敗しました' };
      }
      setTimeout(() => (message = { type: '', text: '' }), 3000);
    }
  }

  onMount(fetchTargets);
</script>

<main>
  <Header />
  <div class="content-wrapper">
    <h2>接続先DB管理</h2>

    {#if message.text}
      <div class="message {message.type}">{message.text}</div>
    {/if}

    <table>
      <thead>
        <tr>
          <th>表示名</th>
          <th>ターゲットID</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        {#each targets as target}
          <tr>
            <td>{target.target_display_name}</td>
            <td>{target.target_id}</td>
            <td>
              <button on:click={() => deleteTarget(target.target_id, target.target_display_name)}>
                削除
              </button>
            </td>
          </tr>
        {/each}
      </tbody>
    </table>
     <div class="admin-link-container">
            <a href="/admin/connections/new" class="admin-link">新しい接続先を登録</a>
     </div>
  </div>
</main>

<style>
  main {
    font-family: sans-serif;
    background-color: #f4f5f7;
    min-height: 100vh;
  }
  .content-wrapper {
    max-width: 1400px;
    margin: 0 auto;
    padding: 32px;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }
  th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }
  th {
    background-color: #f2f2f2;
  }
  button {
    padding: 5px 10px;
    background-color: #f44336;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  button:hover {
    background-color: #d32f2f;
  }
  .message {
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 4px;
  }
  .message.success {
    background-color: #d4edda;
    color: #155724;
  }
  .message.error {
    background-color: #f8d7da;
    color: #721c24;
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
