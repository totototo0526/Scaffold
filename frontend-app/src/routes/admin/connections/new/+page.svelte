<script lang="ts">
  import Header from '$lib/Header.svelte';
  import NewConnectionForm from '$lib/NewConnectionForm.svelte';
</script>

<main>
  <Header />
  <div class="content-wrapper">
    <NewConnectionForm />
  </div>
</main>

<style>
  main {
    font-family: sans-serif;
    background-color: #f4f5f7;
    min-height: 100vh;
  }
  .content-wrapper {
    max-width: 1400px;
    margin: 0 auto;
    padding: 32px;
  }
</style>
