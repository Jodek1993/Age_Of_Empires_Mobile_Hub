#!/bin/bash
# Script to backup the K1Fam.com PostgreSQL database

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

# Check if pg_dump is installed
if ! command -v pg_dump &> /dev/null; then
  print_error "pg_dump is not installed. Please install PostgreSQL and try again."
  exit 1
fi

# Get current date for backup filename
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="./backups"
BACKUP_FILE="${BACKUP_DIR}/k1fam_backup_${DATE}.sql"

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
  print_status "Created backup directory: $BACKUP_DIR"
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

# Perform the database backup
print_status "Starting backup of database '$DB_NAME' to '$BACKUP_FILE'..."

pg_dump -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -F p -f "$BACKUP_FILE"

# Check if backup was successful
if [ $? -eq 0 ]; then
  print_status "Backup completed successfully!"
  print_status "Backup file: $BACKUP_FILE"
  print_status "Backup size: $(du -h "$BACKUP_FILE" | cut -f1)"
else
  print_error "Backup failed!"
  exit 1
fi

# Cleanup password environment variable if it was set manually
if [ -z "$PGPASSWORD" ]; then
  unset PGPASSWORD
fi

# Compress the backup file
print_status "Compressing backup file..."
gzip -f "$BACKUP_FILE"
COMPRESSED_FILE="${BACKUP_FILE}.gz"

if [ $? -eq 0 ]; then
  print_status "Compression completed successfully!"
  print_status "Compressed file: $COMPRESSED_FILE"
  print_status "Compressed size: $(du -h "$COMPRESSED_FILE" | cut -f1)"
else
  print_warning "Compression failed, but the uncompressed backup is still available."
fi

print_status "Backup process completed!"
print_status "To restore this backup, use:"
print_status "  pg_restore -h <host> -p <port> -U <username> -d <dbname> -c -F p $BACKUP_FILE"
print_status "  or for compressed backups:"
print_status "  gunzip -c $COMPRESSED_FILE | psql -h <host> -p <port> -U <username> -d <dbname>"

exit 0