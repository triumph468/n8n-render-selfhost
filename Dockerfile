FROM n8nio/n8n:latest

# 環境変数（任意）
ENV GENERIC_TIMEZONE=Asia/Tokyo

# Expose the web port
EXPOSE 5678

# 公式のentrypointスクリプトを使って起動
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
