# ベースイメージ
FROM n8nio/n8n:latest

# タイムゾーン設定（あなたの設定を維持）
ENV GENERIC_TIMEZONE=Asia/Tokyo

# Puppeteerに必要な依存関係とChromiumをインストール
USER root
RUN apt-get update && \
    apt-get install -y wget gnupg ca-certificates chromium && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Puppeteer本体をインストール
RUN npm install -g puppeteer

# Puppeteerが使うChromiumの実行パスを指定
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 権限を戻す（n8nはnodeユーザーで動く）
USER node

# Webポートを公開
EXPOSE 5678

# n8n起動（元の設定を維持）
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
