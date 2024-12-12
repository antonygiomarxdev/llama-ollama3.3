# Stage 1: Downloader
# This stage downloads the specified model using Ollama
FROM ollama/ollama:latest AS downloader

# Define build-time arguments with default values
ARG MODEL_NAME=llama3.3
ARG SLEEP_DURATION=20

# Set environment variables
ENV OLLAMA_HOME=/root/.ollama

# Create the directory for storing models
RUN mkdir -p /root/.ollama/models

# Download the specified model
RUN set -ex && \
    ollama serve & \
    sleep ${SLEEP_DURATION} && \
    ollama pull ${MODEL_NAME} && \
    pkill ollama && \
    rm -rf /tmp/*

# Stage 2: Final Image
# This stage creates the final image with the downloaded model and sets up a volume
FROM ollama/ollama:latest

# Define build-time argument for consistency
ARG MODEL_NAME=llama3.3

# Set environment variables
ENV OLLAMA_HOME=/root/.ollama

# Create the directory for storing models
RUN mkdir -p /root/.ollama/models

# Copy the downloaded model from the downloader stage to the final image
COPY --from=downloader /root/.ollama/models/${MODEL_NAME} /root/.ollama/models/${MODEL_NAME}

# Define a volume to persist models and allow sharing between containers
VOLUME ["/root/.ollama/models"]

# Expose the necessary port (adjust as needed)
EXPOSE 11434

# Create a non-root user for enhanced security
RUN addgroup --system ollamauser && adduser --system --ingroup ollamauser ollamauser

# Switch to the non-root user
USER ollamauser

# Set the default command to run the specified model
CMD ["ollama", "run", "${MODEL_NAME}"]
