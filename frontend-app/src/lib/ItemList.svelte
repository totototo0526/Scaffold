<script lang="ts">
  import ItemDefinition from './ItemDefinition.svelte';

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

  export let items: Item[] = [];

  function handleAddItem() {
    const newItem: Item = {
      item_id: ``,
      item_label: '',
      db_column_name: '',
      data_type: 'string',
      length: null,
      is_list_display: false,
      is_detail_display: false,
      is_search_filter: false,
      sort_key: items.length + 1,
    };
    items = [...items, newItem];
  }

  function handleDeleteItem(event: CustomEvent) {
    const itemIdToDelete = event.detail.id;
    items = items.filter(item => item.item_id !== itemIdToDelete);
  }
</script>

<div class="item-list-container">
  <h4>項目定義リスト</h4>
  
  <div class="item-grid">
    <!-- ヘッダー行 -->
    <div class="grid-header">項目ID</div>
    <div class="grid-header">ラベル名</div>
    <div class="grid-header">DBカラム名</div>
    <div class="grid-header">型</div>
    <div class="grid-header">長さ</div>
    <div class="grid-header">表示フラグ</div>
    <div class="grid-header">表示順</div>
    <div class="grid-header">操作</div>

    <!-- items配列をループして、各要素に対してItemDefinitionコンポーネントを描画 -->
    {#each items as item (item.item_id)}
      <ItemDefinition bind:item on:delete={handleDeleteItem} />
    {/each}
  </div>

  <button on:click={handleAddItem} class="add-button">
    + 項目を追加
  </button>
</div>

<style>
  .item-list-container {
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 16px;
    margin-top: 16px;
  }
  h4 { margin-top: 0; }

  .item-grid {
    display: grid;
    /* ★修正点: 各列の幅を見直し、柔軟性と最小幅を指定します */
    grid-template-columns: 90px minmax(150px, 1fr) minmax(150px, 1fr) 110px 70px 240px 70px auto;
    gap: 8px 12px; /* 縦と横のスペース */
    align-items: center;
  }

  .grid-header {
    font-weight: bold;
    font-size: 0.8em;
    color: #666;
    padding-bottom: 4px;
    border-bottom: 2px solid #e0e0e0;
  }

  .add-button {
    margin-top: 16px;
    background-color: #e7f3ff;
    border: 1px solid #99c7ff;
    color: #005fcc;
    padding: 8px 12px;
    border-radius: 4px;
    cursor: pointer;
  }
  .add-button:hover {
    background-color: #d0e7ff;
  }
</style>
