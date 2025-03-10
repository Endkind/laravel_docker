# HTTP and HTTPS Version / Installation

This version of the Docker Compose configuration serves the Laravel application over both HTTP and HTTPS.

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/Endkind/laravel_docker.git
    cd laravel_docker
    ```

2. Copy the files into your existing Laravel project:

    ```bash
    cp -r apache/http_https/* /path/to/your/laravel-project
    cd /path/to/your/laravel-project
    ```

3. Place valid SSL certificates in the `ssl` folder:

    ```bash
    cp /path/to/your/ssl.pem ssl/
    cp /path/to/your/ssl.key ssl/
    ```

4. Create an `.env` file based on the pre-configured `.env.docker` file and adjust the environment variables as needed:

    ```bash
    cp .env.docker .env
    ```

5. Start the Docker containers:

    ```bash
    docker-compose up -d
    ```
