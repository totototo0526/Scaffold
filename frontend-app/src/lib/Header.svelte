<script lang="ts">
  const title = "Scaffold";
  const subtitle = "画面定義 自動生成ツール";
</script>

<header>
  <div class="logo-container">
    <span class="logo-icon">🛠️</span>
    <h1>{title}</h1>
  </div>
  <p>{subtitle}</p>
</header>

<style>
  header {
    background: linear-gradient(to right, #3f51b5, #1a237e);
    color: white;
    padding: 24px 32px;
    border-bottom: 4px solid #c5cae9;
  }
  .logo-container {
    display: flex;
    align-items: center;
    gap: 16px;
  }
  .logo-icon {
    font-size: 2.5em;
  }
  h1 {
    margin: 0;
    font-size: 2.2em;
    font-weight: 300;
  }
  p {
    margin: 4px 0 0 58px;
    color: #e8eaf6;
    font-size: 1.1em;
  }
</style>

