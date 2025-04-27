#!/bin/bash
# Script to set up the environment for K1Fam.com

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

# Function to print warning messages
print_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to print error messages
print_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Check if .env file exists
if [ -f ".env" ]; then
  print_warning "An .env file already exists."
  read -p "Do you want to overwrite it? (y/n): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_status "Setup cancelled. Your existing .env file was not modified."
    exit 0
  fi
fi

print_status "Setting up environment for K1Fam.com..."

# Create .env file from template
if [ -f ".env.example" ]; then
  cp .env.example .env
  print_status "Created .env file from .env.example template."
else
  print_warning "No .env.example file found. Creating a basic .env file."
  cat > .env << EOF
# K1Fam.com Environment Variables

# Database configuration
DATABASE_URL=postgres://username:password@localhost:5432/k1fam
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=your_postgres_password
PGDATABASE=k1fam

# Session configuration
SESSION_SECRET=$(openssl rand -hex 32)

# Server configuration
PORT=5000
NODE_ENV=development
EOF
  print_status "Created basic .env file."
fi

# Prompt user for database configuration
read -p "Enter PostgreSQL host (default: localhost): " DB_HOST
DB_HOST=${DB_HOST:-localhost}

read -p "Enter PostgreSQL port (default: 5432): " DB_PORT
DB_PORT=${DB_PORT:-5432}

read -p "Enter PostgreSQL username (default: postgres): " DB_USER
DB_USER=${DB_USER:-postgres}

read -sp "Enter PostgreSQL password: " DB_PASSWORD
echo

read -p "Enter PostgreSQL database name (default: k1fam): " DB_NAME
DB_NAME=${DB_NAME:-k1fam}

# Generate a random session secret if not provided
SESSION_SECRET=$(openssl rand -hex 32)

# Update .env file with user inputs
sed -i "s|DATABASE_URL=postgres://username:password@localhost:5432/k1fam|DATABASE_URL=postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}|g" .env
sed -i "s|PGHOST=localhost|PGHOST=${DB_HOST}|g" .env
sed -i "s|PGPORT=5432|PGPORT=${DB_PORT}|g" .env
sed -i "s|PGUSER=postgres|PGUSER=${DB_USER}|g" .env
sed -i "s|PGPASSWORD=your_postgres_password|PGPASSWORD=${DB_PASSWORD}|g" .env
sed -i "s|PGDATABASE=k1fam|PGDATABASE=${DB_NAME}|g" .env
sed -i "s|SESSION_SECRET=your_session_secret_key_change_this_value_in_production|SESSION_SECRET=${SESSION_SECRET}|g" .env

print_status "Environment configuration updated successfully!"

# Check if Node.js and npm are installed
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
  print_warning "Node.js or npm is not installed on your system."
  print_warning "Please install Node.js v18 or higher from https://nodejs.org/"
  exit 1
fi

# Install dependencies
print_status "Installing Node.js dependencies..."
npm install

if [ $? -eq 0 ]; then
  print_status "Dependencies installed successfully!"
else
  print_error "Failed to install dependencies."
  exit 1
fi

# Create database if it doesn't exist
print_status "Checking if PostgreSQL database exists..."

if command -v psql &> /dev/null; then
  # Export password for psql
  export PGPASSWORD="${DB_PASSWORD}"
  
  # Check if database exists
  if ! psql -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -lqt | cut -d \| -f 1 | grep -qw "${DB_NAME}"; then
    print_status "Database '${DB_NAME}' does not exist. Creating..."
    
    createdb -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" "${DB_NAME}"
    
    if [ $? -eq 0 ]; then
      print_status "Database created successfully!"
    else
      print_error "Failed to create database. Please create it manually."
    fi
  else
    print_status "Database '${DB_NAME}' already exists."
  fi
  
  # Unset password
  unset PGPASSWORD
else
  print_warning "PostgreSQL client (psql) not found. Please create the database manually if it doesn't exist."
fi

# Initialize the database schema
print_status "Do you want to initialize the database schema? This will create all tables."
read -p "Continue? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  print_status "Initializing database schema..."
  npm run db:push
  
  if [ $? -eq 0 ]; then
    print_status "Database schema initialized successfully!"
  else
    print_error "Failed to initialize database schema."
    exit 1
  fi
fi

print_status "Environment setup completed successfully!"
print_status "You can now start the application with: npm run dev"

exit 0