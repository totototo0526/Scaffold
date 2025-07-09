<script lang="ts">
  import TargetDB from './TargetDB.svelte';
  import ViewList from './ViewList.svelte';

  // このフォームが管理する、APIに送信するための全データの型定義
  import type { Item, View } from '$lib/types';

  // フォームの各部分のデータを保持する変数
  let targetInfo = {
    target_db_id: '',
    creator_id: ''
  };
  let views: View[] = [];

  // 親(App.svelte)にフォームの送信イベントを通知するための準備
  import { createEventDispatcher } from 'svelte';
  const dispatch = createEventDispatcher();

  function handleSubmit() {
    // APIに送信するペイロードを組み立てる
    const apiPayload = {
      target_id: targetInfo.target_db_id, // APIの仕様に合わせてキー名を変更
      creator_id: targetInfo.creator_id,
      // views配列から、フロントエンド管理用の 'id' プロパティを除外して整形
      views: views.map(({ id, ...restOfView }) => ({
        ...restOfView,
        items: restOfView.items.map(({ ...restOfItem }) => restOfItem)
      }))
    };

    // 'submit'イベントを発生させ、組み立てたデータを親に渡す
    dispatch('submit', apiPayload);
  }
</script>

<!-- on:submitで、フォームの送信ボタンが押された時にhandleSubmit関数を呼び出す -->
<form on:submit|preventDefault={handleSubmit}>
  <!-- bind:infoで、子コンポーネントのデータとこのコンポーネントの変数を双方向に結びつける -->
  <TargetDB bind:info={targetInfo} />
  
  <!-- bind:viewsも同様 -->
  <ViewList bind:views />

  <!-- 実行ボタン（後ほど作成） -->
  <div class="submit-container">
    <button type="submit" class="submit-button">定義を生成・実行</button>
  </div>
</form>

<style>
  .submit-container {
    margin-top: 32px;
    text-align: right;
  }
  .submit-button {
    padding: 12px 24px;
    font-size: 1.2em;
    font-weight: bold;
    background-color: #303f9f;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.2s;
  }
  .submit-button:hover {
    background-color: #1a237e;
  }
</style>
