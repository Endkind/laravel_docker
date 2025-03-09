# HTTP Version / Installation

This version of the Docker Compose configuration serves the Laravel application over HTTP only.

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/Endkind/laravel_docker.git
    cd laravel_docker
    ```

2. Copy the files into your existing Laravel project:

    ```bash
    cp -r apache/http/* /path/to/your/laravel-project
    cd /path/to/your/laravel-project
    ```

3. Create an `.env` file based on the pre-configured `.env.docker` file and adjust the environment variables as needed:

    ```bash
    cp .env.docker .env
    ```

4. Start the Docker containers:

    ```bash
    docker-compose up -d
    ```
