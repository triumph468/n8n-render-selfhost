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

# Puppeteer を nodeユーザーの環境にインストール（ローカルインストール）
USER node
RUN mkdir -p /home/node/puppeteer && cd /home/node/puppeteer && npm install puppeteer@latest

# Puppeteer の実行パスを設定
ENV PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium"
ENV NODE_PATH="/home/node/puppeteer/node_modules"

# Webポート公開
EXPOSE 5678

# 起動コマンド
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
