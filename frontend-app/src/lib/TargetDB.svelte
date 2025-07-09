<script lang="ts">
  // 親コンポーネント(DefinitionForm)と双方向でデータを結びつけるための定義
  export let info: {
    target_db_id: string;
    creator_id: string;
  };
</script>

<div class="target-db-container">
  <h2>1. 実行対象とID</h2>
  <p>どのデータベースに対して、どのバッチIDで定義を生成するかを指定します。</p>
  <div class="form-grid">
    <label>
      ターゲットID
      <input type="text" placeholder="例: customer_A_dev" bind:value={info.target_db_id} />
    </label>
    <label>
      Creator ID (バッチID)
      <input type="text" placeholder="例: BATCH_001_msyohin" bind:value={info.creator_id} />
    </label>
  </div>
</div>

<style>
  .target-db-container {
    background-color: #e8eaf6;
    padding: 24px;
    border-radius: 8px;
    margin-bottom: 24px;
  }
  h2 {
    margin-top: 0;
    font-size: 1.8em;
    color: #1a237e;
    border-bottom: 2px solid #c5cae9;
    padding-bottom: 8px;
  }
  p {
    color: #546e7a;
    margin-top: 8px;
    font-size: 0.9em;
  }
  .form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 16px;
    margin-top: 16px;
  }
  label {
    display: flex;
    flex-direction: column;
    font-weight: bold;
    color: #3f51b5;
  }
  input {
    margin-top: 4px;
    padding: 8px 10px;
    border: 1px solid #9fa8da;
    border-radius: 4px;
    font-size: 1em;
  }
</style>
