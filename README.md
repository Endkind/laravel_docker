# Laravel Docker Template

This repository contains a Docker Compose configuration to run a Laravel application with PostgreSQL, Redis, Apache, Scheduler, and Queue.

## Requirements

- Docker
- Docker Compose
- An existing Laravel project

## Versions

This repository offers different versions of the Docker Compose configuration for various web servers:

### [Apache](docs/apache/README.md)

- [**http**](docs/apache/http.md): Apache server serving the Laravel application over HTTP only.
- [**http and https**](docs/apache/http_https.md): Apache server serving the Laravel application over both HTTP and HTTPS.
- [**force https**](docs/apache/force_https.md): Apache server serving the Laravel application over HTTPS only and redirecting HTTP requests to HTTPS.

## Installation

For installation instructions for each version, see the corresponding links above.

## Services

- **web**: Apache server serving the Laravel application and migrating the database on each start.
- **db**: PostgreSQL database.
- **redis**: Redis server for caching and queues.
- **scheduler**: Container for scheduled Laravel tasks.
- **queue**: Container for Laravel queue processing.

## Optional: Removing Scheduler and Queue

If you do not use the Scheduler and Queue in Laravel, you can remove these services from the `docker-compose.yml` file:

1. Open the `docker-compose.yml` file.
2. Remove the following sections:

    ```yaml
    scheduler:
      # ...existing code...
    
    queue:
      # ...existing code...
    ```

## Commands

- To run a command in the `web` container:

    ```bash
    docker-compose exec web <command>
    ```

- Example: Running Artisan commands:

    ```bash
    docker-compose exec web php artisan <command>
    ```

## Useful Links

- [Laravel Documentation](https://laravel.com/docs)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

## License

This project is licensed under the MIT License. For more information, see the [LICENSE](LICENSE) file.
