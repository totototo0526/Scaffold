<script lang="ts">
  import ItemDefinition from './ItemDefinition.svelte';

  import type { Item } from '$lib/types';

  export let items: Item[] = [];

  function renumberSortKeys(arr: Item[]): Item[] {
    return arr.map((item, idx) => ({ ...item, sort_key: idx + 1 }));
  }

  function handleAddItem() {
    // item_idは最大値+1で自動連番
    const maxItemId = items.reduce((max, item) => {
      const n = Number(item.item_id);
      return !isNaN(n) && n > max ? n : max;
    }, 0);
    const _internal_id = typeof crypto !== 'undefined' && crypto.randomUUID ? crypto.randomUUID() : Math.random().toString(36).slice(2);
    const newItem: Item = {
      _internal_id,
      id: _internal_id,
      item_id: String(maxItemId + 1),
      item_label: '',
      db_column_name: '',
      data_type: 'string',
      length: null,
      is_list_display: false,
      is_detail_display: false,
      is_search_filter: false,
      sort_key: 0, // 仮
    };
    items = renumberSortKeys([...items, newItem]);
  }

  function handleDeleteItem(event: CustomEvent) {
    const internalIdToDelete = event.detail._internal_id;
    items = renumberSortKeys(items.filter(item => item._internal_id !== internalIdToDelete));
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
    {#each items as item (item._internal_id)}
      <ItemDefinition bind:item on:delete={handleDeleteItem} />
    {/each}
  </div>

  <button type="button" on:click={handleAddItem} class="add-button">
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
