# Use a lightweight base image
FROM lightdash/lightdash:latest
WORKDIR /usr/app

# Install essential dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    python3 \
    python3-psycopg2 \
    python3-venv \
    && apt-get clean


ENV NODE_ENV production
ENV LIGHTDASH_LOG_LEVEL=info
ENV LIGHTDASH_WORKER_CONCURRENCY=4
ENV LIGHTDASH_API_PREFIX=/api/v1
ENV LIGHTDASH_DISABLE_FEATURE=explore
ENV LIGHTDASH_ENABLE_SIGNUP=true
# Install essential dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-psycopg2 \
    python3-venv \
    && apt-get clean

# Set production config
COPY lightdash.yml /usr/app/lightdash.yml
ENV LIGHTDASH_CONFIG_FILE /usr/app/lightdash.yml
COPY ./lightdash-entrypoint.sh /usr/bin/lightdash-entrypoint.sh
RUN chmod +x /usr/bin/lightdash-entrypoint.sh

# Expose the necessary port
EXPOSE 8080

# Entry point for running Lightdash backend
ENTRYPOINT ["/usr/bin/lightdash-entrypoint.sh"]
