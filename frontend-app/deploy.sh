#!/bin/bash

# エラーが発生したらスクリプトを終了する
set -e

# FRONTEND_APP_DIR=~/Scaffold-1/frontend-app
FRONTEND_APP_DIR=/home/kitten/Scaffold-1/frontend-app
DEPLOY_DIR=/var/www/scaffold-app

echo "--- デプロイ処理を開始します ---"

echo "1. フロントエンドアプリのディレクトリに移動します: ${FRONTEND_APP_DIR}"
cd "${FRONTEND_APP_DIR}"

echo "2. npm 依存関係をインストール/更新します (念のため)"
npm install

echo "3. アプリケーションをビルドします..."
npm run build

echo "4. デプロイ先 (${DEPLOY_DIR}) の既存ファイルをクリーンアップします..."
sudo rm -rf "${DEPLOY_DIR}"/*

echo "5. 最新のビルド成果物をデプロイ先にコピーします..."
# 現在の作業ディレクトリがFRONTEND_APP_DIRなので、相対パスで./build/.を指定
sudo cp -a ./build/. "${DEPLOY_DIR}/"

# デプロイ後のファイルの所有者とパーミッション設定 (Nginxがアクセスできるように)
echo "6. デプロイファイルの所有者とパーミッションを設定します..."
# Nginxが動作するユーザー/グループに合わせて適宜変更 (例: www-data:www-data または nginx:nginx)
sudo chown -R www-data:www-data "${DEPLOY_DIR}"
sudo find "${DEPLOY_DIR}" -type d -exec chmod 755 {} \;
sudo find "${DEPLOY_DIR}" -type f -exec chmod 644 {} \;

echo "7. Nginx の設定をテストし、リロードします..."
sudo nginx -t
sudo systemctl reload nginx

echo "--- デプロイ処理が完了しました！ ---"

## 実行コマンド 
# cd ~/Scaffold-1/frontend-app
# sudo ./deploy.sh