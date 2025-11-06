# ベースイメージ
FROM n8nio/n8n:latest

# タイムゾーン設定
ENV GENERIC_TIMEZONE=Asia/Tokyo

# Puppeteer実行に必要な依存関係をインストール（Alpine用）
USER root
RUN apk add --no-cache \
    wget \
    nss \
    chromium \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

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
