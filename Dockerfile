# === n8n official image ===
FROM n8nio/n8n:latest

# Set timezone (optional)
ENV GENERIC_TIMEZONE=Asia/Tokyo

# Expose the web port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
