Certainly! Below is a comprehensive `README.md` tailored for your Docker repository `antonygiomarx/ollama-llama3.3`. This README provides clear instructions on how to use your Docker image, including pulling and running the container, along with additional sections to enhance understanding and usability.

---

# Ollama Llama3.3 Docker Image

![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/antonygiomarx/ollama-llama3.3/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/antonygiomarx/ollama-llama3.3)
![Docker Stars](https://img.shields.io/docker/stars/antonygiomarx/ollama-llama3.3)
![GitHub License](https://img.shields.io/github/license/antonygiomarx/ollama-llama3.3)

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
    - [Pulling the Docker Image](#pulling-the-docker-image)
    - [Running the Docker Container](#running-the-docker-container)
- [Configuration](#configuration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

## Introduction

**Ollama Llama3.3** is a Dockerized implementation of the [Llama3.3](https://llama3.3.example.com) model, designed to provide a seamless and efficient environment for deploying and interacting with the model. This Docker image simplifies the deployment process, ensuring consistency across different environments and reducing setup time.

## Features

- **Pre-Built Docker Image:** Ready-to-use image hosted on Docker Hub.
- **Easy Deployment:** Simple commands to pull and run the container.
- **Resource Optimization:** Configured for optimal performance and minimal resource usage.
- **Security:** Runs as a non-root user to enhance security.
- **Versioning:** Tagged with both `latest` and version-specific tags for flexibility.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Docker Installed:** You have [Docker](https://www.docker.com/get-started) installed on your machine.
- **Docker Hub Account:** Access to the [antonygiomarx/ollama-llama3.3](https://hub.docker.com/r/antonygiomarx/ollama-llama3.3) repository on Docker Hub.
- **System Resources:** Adequate disk space and memory to run the Docker container effectively.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Pulling the Docker Image

First, pull the Docker image from Docker Hub using the following command:

```bash
docker pull antonygiomarx/ollama-llama3.3:latest
```

**Optional:** To pull a specific version of the image, replace `latest` with the desired tag. For example:

```bash
docker pull antonygiomarx/ollama-llama3.3:v1.0.0
```

### Running the Docker Container

Once the image is pulled, you can run it using the `docker run` command. Here's a basic example:

```bash
docker run -d \
  -p 11434:11434 \
  --name ollama_llama3.3_instance \
  antonygiomarx/ollama-llama3.3:latest
```

**Explanation of Flags:**

- `-d`: Runs the container in detached mode (in the background).
- `-p 11434:11434`: Maps port `11434` of the host to port `11434` of the container. Adjust as needed.
- `--name ollama_llama3.3_instance`: Assigns a name to the running container for easier reference.
- `antonygiomarx/ollama-llama3.3:latest`: Specifies the image and tag to use.

**Example with Specific Version:**

```bash
docker run -d \
  -p 11434:11434 \
  --name ollama_llama3.3_instance \
  antonygiomarx/ollama-llama3.3:v1.0.0
```

## Configuration

The Docker image is designed to be flexible and configurable. Below are some common configuration options:

### Environment Variables

You can pass environment variables to the container to customize its behavior.

| Variable        | Description                                      | Default             |
|-----------------|--------------------------------------------------|---------------------|
| `OLLAMA_HOME`   | Directory where Ollama stores its data           | `/root/.ollama`     |
| `MODEL_NAME`    | Name of the model to run                          | `llama3.3`          |
| `MODEL_DIR`     | Directory where the model is stored              | `/root/.ollama/models/${MODEL_NAME}` |
| `PORT`          | Port on which the service runs                    | `11434`             |

**Example:**

```bash
docker run -d \
  -p 8080:11434 \
  --name ollama_llama3.3_instance \
  -e OLLAMA_HOME=/data/ollama \
  -e MODEL_NAME=llama3.3 \
  antonygiomarx/ollama-llama3.3:latest
```

### Volume Mounting

To persist model data and configurations, you can mount volumes.

**Example:**

```bash
docker run -d \
  -p 11434:11434 \
  -v /path/to/local/models:/root/.ollama/models \
  --name ollama_llama3.3_instance \
  antonygiomarx/ollama-llama3.3:latest
```

**Explanation:**

- `-v /path/to/local/models:/root/.ollama/models`: Mounts the local directory `/path/to/local/models` to `/root/.ollama/models` inside the container, ensuring data persistence.

## Usage

Once the container is running, you can interact with the Ollama Llama3.3 model via HTTP requests or any client that communicates with the exposed port.

### Accessing the Service

Assuming you've mapped port `11434` to your host, you can access the service at `http://localhost:11434`.

**Example Request:**

```bash
curl http://localhost:11434
```

### API Endpoints

Provide details on available API endpoints, authentication (if any), and usage examples.

**Example:**

- **Run Model Inference**

  ```bash
  curl -X POST http://localhost:11434/infer \
    -H "Content-Type: application/json" \
    -d '{"input": "Your input text here"}'
  ```

- **Check Service Status**

  ```bash
  curl http://localhost:11434/status
  ```

*Note: Replace these endpoints with actual ones provided by your Ollama service.*

## Troubleshooting

### Common Issues

1. **Container Fails to Start**

    - **Cause:** Insufficient memory or disk space.
    - **Solution:** Ensure your host machine meets the resource requirements. Check Docker logs for detailed error messages.

   ```bash
   docker logs ollama_llama3.3_instance
   ```

2. **Cannot Access the Service**

    - **Cause:** Port mapping issues or firewall restrictions.
    - **Solution:** Verify that the port is correctly mapped and not blocked by a firewall.

   ```bash
   docker ps
   ```

3. **Model Not Found**

    - **Cause:** The model was not downloaded or is missing.
    - **Solution:** Ensure that the model is correctly placed in the specified directory or that the container has access to it via mounted volumes.

### Debugging Steps

1. **Inspect Running Containers**

   ```bash
   docker ps
   ```

2. **Access Container Shell**

   ```bash
   docker exec -it ollama_llama3.3_instance /bin/bash
   ```

3. **Check Logs**

   ```bash
   docker logs ollama_llama3.3_instance
   ```

## Contributing

Contributions are welcome! Follow these steps to contribute:

1. **Fork the Repository**

2. **Create a Feature Branch**

   ```bash
   git checkout -b feature/YourFeatureName
   ```

3. **Commit Your Changes**

   ```bash
   git commit -m "Add your message here"
   ```

4. **Push to the Branch**

   ```bash
   git push origin feature/YourFeatureName
   ```

5. **Open a Pull Request**

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any questions or suggestions, feel free to reach out:

- **Name:** Antony G. Marx
- **Email:** [antonygiomarx@gmail.com](mailto:antonygiomarx@gmail.com)
- **Docker Hub:** [antonygiomarx](https://hub.docker.com/u/antonygiomarx)

## Acknowledgments

- [Ollama](https://ollama.com/) for providing the base image and model support.
- [Docker](https://www.docker.com/) for containerization technology.
- [GitHub Actions](https://github.com/features/actions) for CI/CD workflows.