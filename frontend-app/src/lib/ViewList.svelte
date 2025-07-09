<script lang="ts">
  import ViewDefinition from './ViewDefinition.svelte';

  // これらの型定義は、将来的には src/lib/types.ts のような共有ファイルにまとめるのが理想的です
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

  type View = {
    id: string; // Svelteのkeyとして使用するユニークID
    view_id: string;
    parent_view_id: string;
    content_title: string;
    url: string;
    sort_key: number | null;
    layout_key: string;
    items: Item[];
  };

  // このコンポーネントが管理する画面定義のリスト
  export let views: View[] = [];

  // 新しい画面定義を追加する関数
  function handleAddView() {
    const newView: View = {
      id: crypto.randomUUID(), // 新しい項目にユニークなIDを付与
      view_id: '',
      parent_view_id: '',
      content_title: '',
      url: '',
      sort_key: null,
      layout_key: '',
      items: [] // 最初は空の項目リストを持つ
    };
    views = [...views, newView];
  }

  // 子コンポーネントからの'delete'イベントを処理する関数
  function handleDeleteView(event: CustomEvent) {
    const idToDelete = event.detail.id;
    views = views.filter(view => view.id !== idToDelete);
  }
</script>

<div class="view-list-container">
  <h2>画面定義</h2>
  <p>ここで画面の親子関係や、各画面が持つ項目リストを定義します。「画面定義を追加」ボタンで、新しい画面の入力フォームを追加できます。</p>

  <!-- views配列をループして、各要素に対してViewDefinitionコンポーネントを描画 -->
  {#each views as view (view.id)}
    <ViewDefinition bind:view on:delete={handleDeleteView} />
  {/each}

  <button on:click={handleAddView} class="add-view-button">
    + 画面定義を追加
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
