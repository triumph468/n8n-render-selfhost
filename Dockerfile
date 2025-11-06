# ベースイメージ
FROM n8nio/n8n:latest

# Puppeteer動作のためroot権限へ
USER root

# Puppeteerに必要な依存関係とChromiumをインストール
# Debian系Render環境では "chromium" ではなく "chromium-browser" が存在
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates wget gnupg fonts-liberation \
      libnss3 libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 \
      libxss1 libasound2 libgbm1 libpangocairo-1.0-0 libpango-1.0-0 \
      libxshmfence1 libxkbcommon0 dumb-init chromium-browser && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Puppeteerを n8n の node_modules に直接インストール
RUN cd /usr/local/lib/node_modules/n8n && npm install puppeteer@latest --no-audit --no-fund

# Puppeteerの環境変数
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_CACHE_DIR=/tmp/.puppeteer

# Puppeteerのキャッシュフォルダを作成・権限付与
RUN mkdir -p /home/node/.cache/puppeteer /tmp/.puppeteer && \
    chown -R node:node /home/node/.cache /tmp/.puppeteer

# タイムゾーン設定（あなたの指定を維持）
ENV GENERIC_TIMEZONE=Asia/Tokyo

# nodeユーザーに戻す
USER node

# ポート公開
EXPOSE 5678

# n8n起動
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
