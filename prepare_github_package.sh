#!/bin/bash

# K1Fam.com GitHub Integration Package Generator
# This script prepares a comprehensive package of the K1Fam website for GitHub upload

echo "Starting K1Fam.com export package preparation..."

# Create a temporary directory for the export
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EXPORT_DIR="k1fam_github_export_$TIMESTAMP"
PACKAGE_NAME="k1fam_github_integration.zip"

mkdir -p $EXPORT_DIR

# Copy all client files
echo "Copying client files..."
cp -r ./client $EXPORT_DIR/

# Copy server files
echo "Copying server files..."
cp -r ./server $EXPORT_DIR/

# Copy shared files
echo "Copying shared files..."
cp -r ./shared $EXPORT_DIR/

# Copy configuration files
echo "Copying configuration files..."
cp package.json $EXPORT_DIR/
cp tsconfig.json $EXPORT_DIR/
cp vite.config.ts $EXPORT_DIR/
cp postcss.config.js $EXPORT_DIR/
cp tailwind.config.ts $EXPORT_DIR/
cp components.json $EXPORT_DIR/
cp drizzle.config.ts $EXPORT_DIR/

# Copy documentation files
echo "Copying documentation files..."
cp README.md $EXPORT_DIR/ 2>/dev/null || echo "# Kingdom 1 & Friends Community Website" > $EXPORT_DIR/README.md
cp CHANGELOG.md $EXPORT_DIR/ 2>/dev/null || touch $EXPORT_DIR/CHANGELOG.md
cp LICENSE $EXPORT_DIR/ 2>/dev/null || echo "MIT License" > $EXPORT_DIR/LICENSE
cp CONTRIBUTING.md $EXPORT_DIR/ 2>/dev/null || touch $EXPORT_DIR/CONTRIBUTING.md

# Create a comprehensive README if it doesn't exist
if [ ! -f "README.md" ]; then
  cat > $EXPORT_DIR/README.md << EOF
# Kingdom 1 & Friends Community Website

A comprehensive community platform for Age of Empires Mobile players, providing interactive tools, community engagement features, and data-driven insights for strategic gameplay.

## Features

- User authentication system with profile management
- Forum system with categorized discussions
- Game profile verification system
- Kingdom management dashboard
- Hero pairing guides
- KvK glory tracking
- Official announcements integration
- Profile picture customization
- Responsive design for all devices

## Technology Stack

- React frontend with TypeScript
- Express backend with PostgreSQL database
- Tailwind CSS for styling
- Drizzle ORM for database interactions
- TanStack Query for data fetching

## Getting Started

### Prerequisites

- Node.js 18+ and npm
- PostgreSQL database

### Installation

1. Clone the repository
   \`\`\`bash
   git clone https://github.com/yourusername/k1fam-website.git
   cd k1fam-website
   \`\`\`

2. Install dependencies
   \`\`\`bash
   npm install
   \`\`\`

3. Configure environment variables
   - Copy .env.example to .env
   - Update the values with your configuration

4. Initialize the database
   \`\`\`bash
   npm run db:push
   \`\`\`

5. Start the development server
   \`\`\`bash
   npm run dev
   \`\`\`

## Deployment

The project can be deployed on any platform supporting Node.js and PostgreSQL.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
EOF
fi

# Create a sample .env.example file
cat > $EXPORT_DIR/.env.example << EOF
# Database Configuration
DATABASE_URL=postgresql://username:password@localhost:5432/k1fam_db

# Session Secret
SESSION_SECRET=your-secure-session-secret

# Server Configuration
PORT=3000
NODE_ENV=development

# Upload Limits
MAX_UPLOAD_SIZE=5242880
EOF

# Add .gitignore
cat > $EXPORT_DIR/.gitignore << EOF
# Dependencies
/node_modules
/.pnp
.pnp.js

# Testing
/coverage

# Production
/build
/dist

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Editor directories and files
.idea
.vscode
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Database files
*.sqlite
*.sqlite3

# Uploads directory content but keep the folder
/uploads/*
!/uploads/.gitkeep
EOF

# Create a convenient uploads folder
mkdir -p $EXPORT_DIR/uploads
touch $EXPORT_DIR/uploads/.gitkeep

# Copy assets directory if it exists
if [ -d "./attached_assets" ]; then
  echo "Copying assets..."
  mkdir -p $EXPORT_DIR/client/src/assets
  cp -r ./attached_assets/* $EXPORT_DIR/client/src/assets/
fi

# Create deployment instructions
cat > $EXPORT_DIR/DEPLOYMENT.md << EOF
# Deployment Guide for Kingdom 1 & Friends Website

This document provides instructions for deploying the Kingdom 1 & Friends community website.

## Prerequisites

- Node.js 18+ and npm
- PostgreSQL database
- Server with at least 1GB RAM

## Deployment Steps

### 1. Clone the repository

\`\`\`bash
git clone https://github.com/yourusername/k1fam-website.git
cd k1fam-website
\`\`\`

### 2. Install dependencies

\`\`\`bash
npm install
\`\`\`

### 3. Configure environment variables

Create a \`.env\` file with the following variables:

\`\`\`
DATABASE_URL=postgresql://username:password@hostname:5432/database
SESSION_SECRET=your-secure-session-secret
NODE_ENV=production
PORT=3000
\`\`\`

### 4. Build the application

\`\`\`bash
npm run build
\`\`\`

### 5. Initialize the database

\`\`\`bash
npm run db:push
\`\`\`

### 6. Start the application

\`\`\`bash
npm start
\`\`\`

## Using PM2 for Process Management (Recommended)

\`\`\`bash
# Install PM2
npm install -g pm2

# Start the application with PM2
pm2 start npm --name "k1fam" -- start

# Set up PM2 to start on boot
pm2 startup
pm2 save
\`\`\`

## Nginx Configuration (Optional)

If you're using Nginx as a reverse proxy:

\`\`\`nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
\`\`\`

## SSL Configuration with Certbot (Recommended)

\`\`\`bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Obtain and install certificate
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
\`\`\`
EOF

# Create a scripts directory for maintenance and utilities
mkdir -p $EXPORT_DIR/scripts

# Create a database backup script
cat > $EXPORT_DIR/scripts/backup_database.sh << EOF
#!/bin/bash

# Database Backup Script for K1Fam Community Website

TIMESTAMP=\$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="./backups"
BACKUP_FILE="\${BACKUP_DIR}/k1fam_db_backup_\${TIMESTAMP}.sql"

# Create backup directory if it doesn't exist
mkdir -p \$BACKUP_DIR

# Get database credentials from .env file
if [ -f ".env" ]; then
  source <(grep -v '^#' .env | sed -E 's/(.*)=(.*)/export \1="\2"/g')
fi

# Parse DATABASE_URL to extract components
if [ ! -z "\$DATABASE_URL" ]; then
  # Extract username, password, host, port, and database name from DATABASE_URL
  DB_USER=\$(echo \$DATABASE_URL | sed -n 's/.*:\/\/\([^:]*\):.*/\1/p')
  DB_PASS=\$(echo \$DATABASE_URL | sed -n 's/.*:\/\/[^:]*:\([^@]*\).*/\1/p')
  DB_HOST=\$(echo \$DATABASE_URL | sed -n 's/.*@\([^:]*\).*/\1/p')
  DB_PORT=\$(echo \$DATABASE_URL | sed -n 's/.*:\([0-9]*\)\/.*/\1/p')
  DB_NAME=\$(echo \$DATABASE_URL | sed -n 's/.*\/\([^?]*\).*/\1/p')
else
  echo "ERROR: DATABASE_URL not found in .env file"
  exit 1
fi

# Perform the backup
echo "Creating backup of \$DB_NAME database..."
PGPASSWORD="\$DB_PASS" pg_dump -h \$DB_HOST -p \$DB_PORT -U \$DB_USER -d \$DB_NAME -F p > \$BACKUP_FILE

# Check if backup was successful
if [ $? -eq 0 ]; then
  echo "Backup created successfully: \$BACKUP_FILE"
  echo "Backup size: \$(du -h \$BACKUP_FILE | cut -f1)"
else
  echo "ERROR: Database backup failed"
  rm -f \$BACKUP_FILE
  exit 1
fi

# Optional: compress the backup
gzip \$BACKUP_FILE
echo "Backup compressed: \${BACKUP_FILE}.gz"

# Optional: remove backups older than 30 days
find \$BACKUP_DIR -name "k1fam_db_backup_*.sql.gz" -type f -mtime +30 -delete
echo "Cleaned up backups older than 30 days"

echo "Backup process completed"
EOF

chmod +x $EXPORT_DIR/scripts/backup_database.sh

# Create a reset scripts directory
cat > $EXPORT_DIR/scripts/reset_verification_data.js << EOF
/**
 * This utility script resets all verification data in the database.
 * Useful for testing or resolving issues with the verification system.
 */

require('dotenv').config();
const { db } = require('../server/db');
const { gameProfileVerifications, verificationLogs } = require('../shared/schema');
const { sql } = require('drizzle-orm');

async function resetVerifications() {
  console.log('Starting verification data reset...');
  
  try {
    // Delete all verification logs first due to foreign key constraints
    console.log('Deleting verification logs...');
    await db.delete(verificationLogs);
    
    // Delete all game profile verifications
    console.log('Deleting game profile verifications...');
    await db.delete(gameProfileVerifications);
    
    console.log('Verification data has been successfully reset.');
  } catch (error) {
    console.error('Error resetting verification data:', error);
    process.exit(1);
  }
  
  process.exit(0);
}

resetVerifications();
EOF

# Create ZIP archive
echo "Creating ZIP archive..."
cd $EXPORT_DIR
cd ..
zip -r $PACKAGE_NAME $EXPORT_DIR

# Cleanup
echo "Cleaning up temporary files..."
rm -rf $EXPORT_DIR

echo "Export package created successfully: $PACKAGE_NAME"
echo "You can now upload this file to GitHub for continued development."