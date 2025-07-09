<script lang="ts">
  import ItemList from './ItemList.svelte';

  // ItemListで定義したItemの型をインポートまたは再定義します
  type Item = {
    item_id: string;
    item_label: string;
    db_column_name: string;
    data_type: 'string' | 'number' | 'checkbox';
    length: number | null;
    is_list_display: boolean;
    is_detail_display: boolean;
    is_search_filter: boolean;
    sort_key: number;
  };

  // このコンポーネントが管理する「画面定義」の型
  // ★変更点: Svelteのkeyとして使用するユニークなidプロパティを追加
  type View = {
    id: string; 
    view_id: string;
    parent_view_id: string;
    content_title: string;
    url: string;
    sort_key: number | null;
    layout_key: string;
    items: Item[]; // 項目定義のリストを内包します
  };

  // 親コンポーネント(ViewList)から渡されるプロパティ
  export let view: View;

  // 削除イベントを親に通知するための準備
  import { createEventDispatcher } from 'svelte';
  const dispatch = createEventDispatcher();

  function handleDelete() {
    // ★変更点: view_idではなく、ユニークなidをイベントで渡す
    dispatch('delete', { id: view.id });
  }
</script>

<div class="view-definition-container">
  <div class="view-header">
    <!-- view_idが入力されていればそれを表示、なければ「(新規)」と表示 -->
    <h3>画面定義: {view.content_title || view.view_id || '(新規)'}</h3>
    <button on:click={handleDelete} class="delete-view-button" title="この画面定義を削除">×</button>
  </div>

  <!-- 画面定義の基本情報を入力するフォーム -->
  <div class="view-form-grid">
    <label>
      View ID
      <input type="text" placeholder="例: msiroji-1" bind:value={view.view_id} />
    </label>
    <label>
      Parent View ID
      <input type="text" placeholder="例: msiroji" bind:value={view.parent_view_id} />
    </label>
    <label>
      画面タイトル
      <input type="text" placeholder="例: 白地マスタ" bind:value={view.content_title} />
    </label>
    <label>
      URL
      <input type="text" placeholder="例: ../msiroji" bind:value={view.url} />
    </label>
    <label>
      表示順
      <input type="number" placeholder="例: 1" bind:value={view.sort_key} />
    </label>
    <label>
      レイアウトキー
      <input type="text" placeholder="例: msiroji" bind:value={view.layout_key} />
    </label>
  </div>

  <!-- 項目定義リストのコンポーネントを配置 -->
  <!-- bind:itemsで、このコンポーネントが持つitems配列をItemListに渡します -->
  <ItemList bind:items={view.items} />
</div>

<style>
  .view-definition-container {
    border: 1px solid #b0bec5;
    background-color: #f5f7fa;
    border-radius: 8px;
    padding: 16px 24px;
    margin-bottom: 24px;
  }

  .view-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #cfd8dc;
    padding-bottom: 12px;
    margin-bottom: 16px;
  }

  .view-header h3 {
    margin: 0;
    font-size: 1.2em;
    color: #37474f;
  }
  
  .delete-view-button {
    background: #fbe9e7;
    border: 1px solid #ffab91;
    color: #d84315;
    font-weight: bold;
    border-radius: 50%;
    width: 28px;
    height: 28px;
    cursor: pointer;
    line-height: 24px;
  }

  .view-form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 16px;
  }

  .view-form-grid label {
    display: flex;
    flex-direction: column;
    font-size: 0.9em;
    color: #546e7a;
  }

  .view-form-grid input {
    margin-top: 4px;
    padding: 6px 8px;
    border: 1px solid #cfd8dc;
    border-radius: 4px;
    font-size: 1em;
  }
</style>
