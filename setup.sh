#!/bin/bash

# Setup script for Odoo OpenELIS Connector
# This script extracts the odoo_initializer addon and prepares the environment

set -e

echo "🚀 Setting up Odoo OpenELIS Connector..."

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo "   Docker is not installed. Please install Docker first."
    echo "   Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "   Docker Compose is not installed. Please install Docker Compose first."
    echo "   Visit: https://docs.docker.com/compose/install/"
    exit 1
fi

# Check if unzip is available
if ! command -v unzip &> /dev/null; then
    echo "   unzip is not installed. Please install unzip first."
    echo "   On macOS: brew install unzip"
    echo "   On Ubuntu/Debian: sudo apt-get install unzip"
    echo "   On CentOS/RHEL: sudo yum install unzip"
    exit 1
fi

# Check if the zip file exists
if [ ! -f "configs/odoo/addons/odoo_initializer.zip" ]; then
    echo " odoo_initializer.zip not found in configs/odoo/addons/"
    exit 1
fi

# Create addons directory if it doesn't exist
echo "Creating addons directory..."
mkdir -p configs/odoo/addons

# Remove existing odoo_initializer directory if it exists
if [ -d "configs/odoo/addons/odoo_initializer" ]; then
    echo "Removing existing odoo_initializer directory..."
    rm -rf configs/odoo/addons/odoo_initializer
fi

# Extract the zip file
echo "Extracting odoo_initializer addon..."
cd configs/odoo/addons
unzip -o odoo_initializer.zip
cd ../../..

echo "Setup completed successfully!"
echo ""
echo "Starting Docker services..."
docker-compose up -d

echo ""
echo "🌐 Services are starting up and will be available at:"
echo "   - Odoo: http://localhost:8069"
echo "   - OpenELIS: https://localhost/"
echo ""
echo "⏳ Services may take a few minutes to fully start up..."
echo ""
echo "📝 Useful commands:"
echo "   - View logs: docker-compose logs -f"
echo "   - Stop services: docker-compose down"
echo "   - Restart services: docker-compose restart"
