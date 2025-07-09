<script lang="ts">
  // ItemListコンポーネントから渡されるプロパティを定義します
  export let item: {
    _internal_id: string;
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
    // 'delete'という名前のイベントを発生させ、この項目の_internal_idを親に渡します
    dispatch('delete', { _internal_id: item._internal_id });
  }
</script>

<!-- 各項目を入力するためのフォーム要素（グリッドのセルに直接配置） -->
<input class="col-item-id" type="text" placeholder="項目ID" bind:value={item.item_id} />
<input class="col-label" type="text" placeholder="ラベル名" bind:value={item.item_label} />
<input class="col-db-name" type="text" placeholder="DBカラム名" bind:value={item.db_column_name} />
<select class="col-type" bind:value={item.data_type}>
  <option value="string">string</option>
  <option value="number">number</option>
  <option value="checkbox">checkbox</option>
</select>
<input class="col-length" type="number" placeholder="長さ" bind:value={item.length} />
<!-- チェックボックスでのフラグ設定（1セル内でflex） -->
<span class="col-flags">
  <label><input type="checkbox" bind:checked={item.is_list_display} /> 一覧</label>
  <label><input type="checkbox" bind:checked={item.is_detail_display} /> 詳細</label>
  <label><input type="checkbox" bind:checked={item.is_search_filter} /> 検索</label>
</span>
<input class="col-sort-key" type="number" placeholder="表示順" bind:value={item.sort_key} />
<button class="col-delete" on:click={handleDelete}>削除</button>

<style>
  /* 各コンポーネントに閉じたスタイルを記述できます */
  /* .item-definition-rowは不要 */
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

  /* --- ★ここから修正案 --- */
  /* 各入力欄にクラスを割り当て、flex-basisで基準となる幅を指定します */
  .col-item-id    { flex-basis: 80px; }
  .col-label      { flex-basis: 150px; flex-grow: 1; } /* ラベル名は可変長に */
  .col-db-name    { flex-basis: 150px; flex-grow: 1; } /* DBカラム名も可変長に */
  .col-type       { flex-basis: 100px; }
  .col-length     { flex-basis: 60px; }
  .col-flags      { display: flex; gap: 8px; min-width: 180px; }
  .col-sort-key   { flex-basis: 60px; }
  .col-delete     { flex-shrink: 0; } /* 削除ボタンは縮まないように */
  /* --- ★ここまで修正案 --- */
</style>
