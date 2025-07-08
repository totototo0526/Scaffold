# frontend-app

このプロジェクトはSvelteKit + Viteを利用したフロントエンドアプリケーションです。

## セットアップ

1. 依存パッケージのインストール

```bash
npm install
```

2. 開発サーバーの起動

```bash
npm run dev
```

3. ビルド

```bash
npm run build
```

4. プレビュー

```bash
npm run preview
```

## ディレクトリ構成

- `src/` ... ソースコード
- `static/` ... 静的ファイル
- `package.json` ... 依存・スクリプト定義
- `svelte.config.js` ... SvelteKit設定
- `vite.config.ts` ... Vite設定

## その他

- `.env` などの環境変数ファイルは `.gitignore` で管理されています。
- 詳細は各設定ファイルやコメントを参照してください。

---

# sv

Everything you need to build a Svelte project, powered by [`sv`](https://github.com/sveltejs/cli).

## Creating a project

If you're seeing this, you've probably already done this step. Congrats!

```bash
# create a new project in the current directory
npx sv create

# create a new project in my-app
npx sv create my-app
```

## Developing

Once you've created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

To create a production version of your app:

```bash
npm run build
```

You can preview the production build with `npm run preview`.

> To deploy your app, you may need to install an [adapter](https://svelte.dev/docs/kit/adapters) for your target environment.
