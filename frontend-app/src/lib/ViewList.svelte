<script lang="ts">
  import ViewDefinition from './ViewDefinition.svelte';

  // これらの型定義は、将来的には src/lib/types.ts のような共有ファイルにまとめるのが理想的です
import type { Item, View } from '$lib/types';

  // このコンポーネントが管理する画面定義のリスト
  export let views: View[] = [];

  // 新しい画面定義を追加する関数
  function renumberViewSortKeys(arr: View[]): View[] {
    return arr.map((view, idx) => ({ ...view, sort_key: idx + 1 }));
  }

  function handleAddView() {
    const newView: View = {
      id: Math.random().toString(36).slice(2),
      view_id: '',
      parent_view_id: '',
      content_title: '',
      url: '',
      sort_key: 0, // 仮
      layout_key: '',
      items: []
    };
    views = renumberViewSortKeys([...views, newView]);
  }

  // 子コンポーネントからの'delete'イベントを処理する関数
  function handleDeleteView(event: CustomEvent) {
    const idToDelete = event.detail.id;
    views = renumberViewSortKeys(views.filter(view => view.id !== idToDelete));
  }
</script>

<div class="view-list-container">
  <h2>画面定義</h2>
  <p>ここで画面の親子関係や、各画面が持つ項目リストを定義します。「画面定義を追加」ボタンで、新しい画面の入力フォームを追加できます。</p>

  <!-- views配列をループして、各要素に対してViewDefinitionコンポーネントを描画 -->
  {#each views as view (view.id)}
    <ViewDefinition bind:view allViews={views} on:delete={handleDeleteView} />
  {/each}

  <button type="button" on:click={handleAddView} class="add-view-button">
    + 画面定義の追加
  </button>
</div>

<style>
  .view-list-container {
    padding: 24px;
    background-color: #ffffff;
  }
  h2 {
    font-size: 1.8em;
    color: #1a237e;
    border-bottom: 2px solid #c5cae9;
    padding-bottom: 8px;
  }
  p {
    color: #546e7a;
    margin-top: 8px;
  }
  .add-view-button {
    display: block;
    width: 100%;
    padding: 12px;
    font-size: 1.1em;
    background-color: #43a047;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.2s;
    margin-top: 24px;
  }
  .add-view-button:hover {
    background-color: #388e3c;
  }
</style>
