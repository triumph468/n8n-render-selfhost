# ベースイメージ
FROM n8nio/n8n:latest

# タイムゾーン設定
ENV GENERIC_TIMEZONE=Asia/Tokyo

USER root
RUN apk add --no-cache \
    chromium \
    nss \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

USER node
RUN mkdir -p /home/node/puppeteer && \
    cd /home/node/puppeteer && \
    npm install puppeteer@latest

# Puppeteer が使う Chrome の実行パスを設定
ENV PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium"
# ← ここでは PUPPETEER_SKIP_CHROMIUM_DOWNLOAD は **設定しない**

EXPOSE 5678
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
