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
RUN npm install -g puppeteer@latest
# 👆 npx puppeteer browsers install chrome は削除
# （Renderで落ちる原因なので）

# Puppeteer が使用する Chrome の実行パスを設定
ENV PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium"

# ↑ を維持してもOK（ただし本当は /usr/bin/chromium が正しい）
# Render側の環境変数でも同じパスを指定しておくと安全

# Webポート公開
EXPOSE 5678

# 起動コマンド
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
