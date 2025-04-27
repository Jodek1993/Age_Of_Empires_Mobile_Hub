#!/bin/bash
# Script to deploy K1Fam.com to GitHub repository

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

# Check if git is installed
if ! command -v git &> /dev/null; then
  print_error "Git is not installed. Please install git and try again."
  exit 1
fi

# Prompt for GitHub repository URL
read -p "Enter your GitHub repository URL (e.g., https://github.com/username/k1fam.git): " REPO_URL

if [ -z "$REPO_URL" ]; then
  print_error "GitHub repository URL is required."
  exit 1
fi

# Build the application
print_status "Building the application..."
npm run build

if [ $? -ne 0 ]; then
  print_error "Build failed. Please fix the errors and try again."
  exit 1
fi

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
  print_status "Initializing git repository..."
  git init
fi

# Create .gitignore file if it doesn't exist
if [ ! -f ".gitignore" ]; then
  print_status "Creating .gitignore file..."
  cat > .gitignore << EOF
# Dependency directories
node_modules/
.npm

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Build output
dist/
build/

# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory
coverage/

# IDE files
.idea/
.vscode/
*.swp
*.swo

# OS files
.DS_Store
Thumbs.db
EOF
fi

# Add all files to git
print_status "Adding files to git..."
git add .

# Commit changes
print_status "Committing changes..."
git commit -m "Initial commit for K1Fam.com"

# Add remote repository
print_status "Adding remote repository..."
git remote remove origin 2>/dev/null
git remote add origin $REPO_URL

# Push to GitHub
print_status "Pushing to GitHub..."
git push -u origin main

if [ $? -ne 0 ]; then
  print_warning "Failed to push to main branch. Trying master branch instead..."
  git push -u origin master
  
  if [ $? -ne 0 ]; then
    print_error "Failed to push to GitHub. Please check your repository URL and permissions."
    exit 1
  fi
fi

print_status "Successfully deployed K1Fam.com to GitHub!"
print_status "Next steps:"
print_status "1. Set up your database using scripts/db-init.sql"
print_status "2. Configure your deployment environment variables"
print_status "3. Set up CI/CD pipeline or manually deploy from your repository"

exit 0