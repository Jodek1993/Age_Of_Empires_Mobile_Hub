#!/bin/bash
# Script to restore a K1Fam.com PostgreSQL database from backup

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

# Check for required commands
if ! command -v psql &> /dev/null; then
  print_error "psql is not installed. Please install PostgreSQL and try again."
  exit 1
fi

if ! command -v gunzip &> /dev/null; then
  print_warning "gunzip is not installed. You won't be able to restore from compressed backups."
fi

# Check for environment variables
if [ -f ".env" ]; then
  source .env
  print_status "Loaded database credentials from .env file"
else
  print_warning "No .env file found. Using default or command-line credentials."
fi

# Set default values if not provided by environment variables
DB_HOST=${PGHOST:-localhost}
DB_PORT=${PGPORT:-5432}
DB_NAME=${PGDATABASE:-k1fam}
DB_USER=${PGUSER:-postgres}

# Check if password is provided
if [ -z "$PGPASSWORD" ]; then
  print_warning "Database password not found in environment variables."
  read -sp "Enter database password: " DB_PASSWORD
  echo
  export PGPASSWORD="$DB_PASSWORD"
else
  print_status "Using database password from environment variables."
fi

# Display backup directory contents
BACKUP_DIR="./backups"
if [ ! -d "$BACKUP_DIR" ]; then
  print_error "Backup directory '$BACKUP_DIR' does not exist."
  exit 1
fi

print_status "Available backups:"
ls -lh "$BACKUP_DIR" | grep -E '\.sql$|\.sql\.gz$'

# Ask user to select a backup file
read -p "Enter the backup filename to restore (from the list above): " BACKUP_FILE

# Validate the backup file
FULL_BACKUP_PATH="${BACKUP_DIR}/${BACKUP_FILE}"
if [ ! -f "$FULL_BACKUP_PATH" ]; then
  print_error "Backup file '$FULL_BACKUP_PATH' does not exist."
  exit 1
fi

# Confirm restoration
print_warning "WARNING: This will overwrite the current database '$DB_NAME'."
read -p "Are you sure you want to proceed? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  print_status "Restoration cancelled."
  exit 0
fi

# Create the database if it doesn't exist
print_status "Checking if database '$DB_NAME' exists..."
if ! psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -lqt | cut -d \| -f 1 | grep -qw "$DB_NAME"; then
  print_status "Database '$DB_NAME' does not exist. Creating..."
  createdb -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" "$DB_NAME"
  
  if [ $? -ne 0 ]; then
    print_error "Failed to create database '$DB_NAME'. Aborting."
    exit 1
  fi
fi

# Restore the database
print_status "Starting database restoration..."

if [[ "$BACKUP_FILE" == *.gz ]]; then
  print_status "Detected compressed backup. Decompressing and restoring..."
  gunzip -c "$FULL_BACKUP_PATH" | psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME"
else
  print_status "Restoring from uncompressed backup..."
  psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f "$FULL_BACKUP_PATH"
fi

# Check if restoration was successful
if [ $? -eq 0 ]; then
  print_status "Database restoration completed successfully!"
else
  print_error "Database restoration failed!"
  exit 1
fi

# Cleanup password environment variable if it was set manually
if [ -z "$PGPASSWORD" ]; then
  unset PGPASSWORD
fi

print_status "Restoration process completed!"
print_status "You may need to restart your application for changes to take effect."

exit 0