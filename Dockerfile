# ベースイメージ
FROM n8nio/n8n:latest

# タイムゾーン設定
ENV GENERIC_TIMEZONE=Asia/Tokyo

# rootユーザーに切り替え
USER root

# Puppeteerに必要な依存パッケージとChromiumをインストール
RUN apt-get update && \
    apt-get install -y chromium ca-certificates fonts-liberation \
    libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 \
    libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 \
    libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 \
    libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 \
    libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 \
    libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 \
    libxtst6 lsb-release wget xdg-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Puppeteer本体をグローバルインストール
RUN npm install -g puppeteer@22.15.0

# Puppeteerが使うChromium実行パスを設定
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 権限を戻す
USER node

# Webポートを公開
EXPOSE 5678

# n8n起動（デフォルト）
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
