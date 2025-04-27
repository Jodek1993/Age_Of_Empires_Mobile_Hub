# GitHub Integration Guide for K1Fam.com

This guide provides step-by-step instructions for integrating the K1Fam.com community website project with GitHub.

## Prerequisites

- GitHub account
- Git installed on your local machine or Replit
- The `k1fam_github_integration.zip` package

## Creating a GitHub Repository

1. **Sign in to GitHub**
   - Navigate to [https://github.com](https://github.com)
   - Sign in with your GitHub account

2. **Create a New Repository**
   - Click the "+" icon in the top-right corner
   - Select "New repository"
   - Enter a name for your repository (e.g., "k1fam-website")
   - Add a description (e.g., "A community website for Age of Empires Mobile players")
   - Choose visibility (Public or Private)
   - Do not initialize with README, .gitignore, or license (we'll push our existing code)
   - Click "Create repository"

## Setting Up the Project on Replit

### Option 1: Direct Integration with Replit

1. **Connect Your GitHub Account to Replit**
   - In Replit, click on your profile picture in the top-right corner
   - Select "Account" from the dropdown menu
   - Navigate to the "Connected Services" tab
   - Click "Connect" next to GitHub
   - Follow the authorization prompts

2. **Push Your Replit Project to GitHub**
   - Open your K1Fam.com project in Replit
   - Click on the "Version Control" tab in the left sidebar (Git icon)
   - Enter your GitHub repository details
   - Make your initial commit and push
   - Follow the prompts to complete the process

### Option 2: Manual GitHub Setup (Using the Integration Package)

1. **Download the Integration Package**
   - Locate the `k1fam_github_integration.zip` file in your Replit project
   - Click on the file to view it
   - Click "Download" to save it to your local machine

2. **Extract the Package**
   - Extract the ZIP file to a folder on your local machine
   - This will create a directory containing all project files

3. **Initialize Git Repository**
   - Open a terminal/command prompt
   - Navigate to the extracted project directory
   - Run the following commands:

     ```bash
     git init
     git add .
     git commit -m "Initial commit"
     git branch -M main
     git remote add origin https://github.com/yourusername/your-repository-name.git
     git push -u origin main
     ```

   - Replace `yourusername` and `your-repository-name` with your GitHub username and repository name

## GitHub Workflows and Automation

### Setting Up GitHub Actions

1. **Create GitHub Actions Directory**
   - In your repository, create a `.github/workflows` directory

2. **Create CI/CD Workflow File**
   - Create a file named `ci.yml` in the workflows directory
   - Add the following content:

   ```yaml
   name: CI/CD Pipeline

   on:
     push:
       branches: [ main ]
     pull_request:
       branches: [ main ]

   jobs:
     build:
       runs-on: ubuntu-latest
       
       steps:
       - uses: actions/checkout@v3
       
       - name: Setup Node.js
         uses: actions/setup-node@v3
         with:
           node-version: 18
           
       - name: Install dependencies
         run: npm ci
         
       - name: Run linting
         run: npm run lint
         
       - name: Run tests
         run: npm test
         
       - name: Build
         run: npm run build
   ```

3. **Create Issue Templates**
   - Create a `.github/ISSUE_TEMPLATE` directory
   - Add templates for bug reports and feature requests

### Collaboration Settings

1. **Configure Branch Protection**
   - Go to your repository's "Settings" tab
   - Click on "Branches" in the left sidebar
   - Under "Branch protection rules", click "Add rule"
   - Set "Branch name pattern" to `main`
   - Enable the following options:
     - Require pull request reviews before merging
     - Require status checks to pass before merging
     - Require branches to be up to date before merging
   - Click "Create"

2. **Set Up Issue Labels**
   - Go to your repository's "Issues" tab
   - Click on "Labels"
   - Create labels for different types of issues (e.g., bug, enhancement, documentation)

## Continuous Development Workflow

### Local Development

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/your-repository-name.git
   cd your-repository-name
   ```

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Create a Branch for Your Feature**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make Changes and Commit**
   ```bash
   git add .
   git commit -m "Add your detailed commit message"
   ```

5. **Push Changes**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to your repository on GitHub
   - Click "Compare & pull request"
   - Fill in the PR details
   - Click "Create pull request"

### Replit Integration with GitHub

1. **Pull Latest Changes in Replit**
   - Open your project in Replit
   - Click on the Git tab
   - Click "Pull" to get the latest changes

2. **Make Changes in Replit**
   - Edit your code in Replit
   - Test your changes

3. **Commit and Push from Replit**
   - Click "Commit & push" in the Git tab
   - Enter a commit message
   - Complete the commit and push process

## Database Migrations and Deployment

### Database Migration Strategy

1. **Track Schema Changes**
   - Always update `shared/schema.ts` with your database schema changes

2. **Apply Migrations**
   - Use the schema push approach with Drizzle ORM
   ```bash
   npm run db:push
   ```

3. **Handle Production Migrations**
   - Always back up your database before migrations
   - Use the provided backup script in `scripts/backup_database.sh`
   - Apply migrations during low-traffic periods

### Deployment Strategy

1. **Prepare for Deployment**
   - Ensure all tests pass
   - Verify environment variables are configured
   - Update documentation as needed

2. **Deployment Options**
   - Replit Deployments: Use the built-in deployment feature
   - Manual server: Follow instructions in `DEPLOYMENT.md`

## Maintaining the Repository

### Documentation

- Keep `README.md` updated with latest project information
- Document new features in the appropriate documentation files
- Update API documentation when endpoints change

### Version Control

- Use semantic versioning for releases
- Tag important releases with version numbers
- Keep the `CHANGELOG.md` file updated with all significant changes

### Code Reviews

- Require code reviews for all pull requests
- Use the pull request template to ensure consistency
- Check for test coverage and documentation updates

## Troubleshooting

### Common GitHub Issues

1. **Authentication Failures**
   - Verify your GitHub credentials
   - Check that your SSH keys are set up correctly
   - Ensure you have the correct repository permissions

2. **Merge Conflicts**
   - Pull the latest changes before starting work
   - Resolve conflicts by editing the conflicting files
   - Use `git mergetool` for complex conflicts

3. **Build Failures in CI**
   - Check the GitHub Actions logs for specific errors
   - Ensure all dependencies are properly declared
   - Verify that tests are passing locally before pushing

## Additional Resources

- [GitHub Documentation](https://docs.github.com/)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Replit + GitHub Integration Guide](https://docs.replit.com/programming-ide/using-git-on-replit)