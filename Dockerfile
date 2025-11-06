# ベースイメージ
FROM n8nio/n8n:latest

# タイムゾーン設定
ENV GENERIC_TIMEZONE=Asia/Tokyo

# Puppeteer実行に必要な依存関係をインストール
USER root
RUN apt-get update && \
    apt-get install -y wget gnupg ca-certificates fonts-liberation libatk-bridge2.0-0 libnss3 libxss1 libasound2 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxrandr2 libgbm1 xdg-utils && \
    rm -rf /var/lib/apt/lists/*

# Puppeteer を nodeユーザーの環境にインストール
USER node
RUN npm install -g puppeteer@latest && \
    npx puppeteer browsers install chrome

# Puppeteer が使用する Chrome の実行パスを設定
ENV PUPPETEER_EXECUTABLE_PATH="/home/node/.cache/puppeteer/chrome/linux-*/chrome"

# Webポート公開
EXPOSE 5678

# 起動コマンド
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
