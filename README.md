# Odoo OpenELIS Connector
<img width="603" height="169" alt="odooscre" src="https://github.com/user-attachments/assets/23711ce0-3a03-49e4-896c-5c1225bb99b8" />

## Overview

This project provides integration between Odoo and OpenELIS systems with a simplified approach that includes all necessary components directly in the repository.

## 🚀 One-Command Setup

```bash
git clone <repository-url> && cd odoo-openelis-connector && chmod +x setup.sh && ./setup.sh
```

That's it! The setup script will handle everything automatically.

## Architecture

The project follows a modular architecture with the following components:

- **Odoo Initializer Addon**: Included as a zip file in the repository under `configs/odoo/addons/odoo_initializer.zip`
- **OpenELIS Configuration**: Local configuration files for OpenELIS setup
- **Docker Compose**: Containerized deployment setup
- **Nginx Configuration**: Reverse proxy configuration

## Prerequisites

- Docker and Docker Compose

## Project Structure

```
odoo-openelis-connector/
├── configs/
│   ├── nginx/           # Nginx configuration
│   ├── odoo/            # Odoo configuration and addons
│   │   ├── addons/      # Odoo addons (including odoo_initializer.zip)
│   │   └── config/      # Odoo configuration files
│   └── openelis/        # OpenELIS configuration
├── docker-compose.yml   # Docker Compose configuration
└── README.md           # This file
```

## Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
cd odoo-openelis-connector
```

### 2. Run the Setup Script

```bash
./setup.sh
```

This script will:
1. Check if Docker, Docker Compose, and `unzip` are available
2. Extract the `odoo_initializer.zip` file to the addons directory
3. Start all Docker services automatically

### 3. Access the Services

Once deployed, the services will be available at:

- **Odoo**: http://localhost:8069
- **OpenELIS**: https://localhost:8443
- **FHIR API**: http://localhost:8081

## Configuration

### Odoo Configuration

The Odoo configuration is located in `configs/odoo/` and includes:
- Addon configurations (including the odoo_initializer.zip file)
- Database initialization scripts
- Custom module configurations

### OpenELIS Configuration

OpenELIS configuration files are in `configs/openelis/` and include:
- Database configuration
- Application properties
- Logging configuration

## Useful Docker Compose Commands

```bash
# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Restart services
docker-compose restart

# View service status
docker-compose ps

# Rebuild and start services
docker-compose up -d --build
```

## Development

### Adding New Odoo Addons

To add new Odoo addons:

1. Place the addon in the `configs/odoo/addons/` directory
2. Update the Odoo configuration if needed
3. Restart the Odoo service: `docker-compose restart odoo`

### Updating the Odoo Initializer Addon

To update the Odoo initializer addon:

1. Replace the `configs/odoo/addons/odoo_initializer.zip` file with the new version
2. Run the setup script: `./setup.sh` (this will restart all services)

## Troubleshooting

### Service Startup Issues

If services fail to start:

1. Check the logs: `docker-compose logs <service-name>`
2. Ensure all required ports are available
3. Verify Docker and Docker Compose are running

### Configuration Issues

If you encounter configuration problems:

1. Check the configuration files in the `configs/` directory
2. Verify file permissions and ownership
3. Restart the affected services

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the setup process
5. Submit a pull request

## License

This project is licensed under the terms specified in the project documentation.
