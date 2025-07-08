<script lang="ts">
  // ItemListコンポーネントから渡されるプロパティを定義します
  export let item: {
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

  // 削除ボタンが押されたことを親に通知するためのイベントを作成します
  import { createEventDispatcher } from 'svelte';
  const dispatch = createEventDispatcher();

  function handleDelete() {
    // 'delete'という名前のイベントを発生させ、この項目のitem_idを親に渡します
    dispatch('delete', { id: item.item_id });
  }
</script>

<!-- 各項目を入力するためのフォーム要素 -->
<div class="item-definition-row">
  <input type="text" placeholder="項目ID" bind:value={item.item_id} />
  <input type="text" placeholder="ラベル名" bind:value={item.item_label} />
  <input type="text" placeholder="DBカラム名" bind:value={item.db_column_name} />
  <select bind:value={item.data_type}>
    <option value="string">string</option>
    <option value="number">number</option>
    <option value="checkbox">checkbox</option>
  </select>
  <input type="number" placeholder="長さ" bind:value={item.length} />
  
  <!-- チェックボックスでのフラグ設定 -->
  <label><input type="checkbox" bind:checked={item.is_list_display} /> 一覧</label>
  <label><input type="checkbox" bind:checked={item.is_detail_display} /> 詳細</label>
  <label><input type="checkbox" bind:checked={item.is_search_filter} /> 検索</label>
  
  <input type="number" placeholder="表示順" bind:value={item.sort_key} />
  <button on:click={handleDelete}>削除</button>
</div>

<style>
  /* 各コンポーネントに閉じたスタイルを記述できます */
  .item-definition-row {
    display: flex;
    gap: 8px; /* 各要素間のスペース */
    margin-bottom: 8px;
    align-items: center;
  }
  input[type="text"], input[type="number"], select {
    padding: 4px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  label {
    display: flex;
    align-items: center;
    gap: 4px;
    font-size: 0.9em;
  }
</style>
