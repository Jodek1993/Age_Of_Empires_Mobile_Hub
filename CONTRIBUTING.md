# Contributing to Kingdom 1 & Friends (K1Fam.com)

Thank you for your interest in contributing to the Kingdom 1 & Friends community website! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

Please be respectful and considerate of others when contributing to this project. We expect all contributors to adhere to the following principles:

- Be respectful and inclusive of all community members
- Use welcoming and inclusive language
- Be open to different viewpoints and experiences
- Focus on what is best for the community
- Show empathy towards other community members

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally
3. Set up your development environment following the instructions in the [README.md](README.md) file or [SETUP.md](docs/SETUP.md) file
4. Create a new branch for your contribution
5. Make your changes
6. Test your changes thoroughly
7. Commit your changes with clear, descriptive commit messages
8. Push your changes to your fork
9. Submit a pull request

## Development Workflow

### Branching Strategy

- `main` branch: Production-ready code
- `develop` branch: Integration branch for new features
- Feature branches: Create from `develop` with the naming convention `feature/your-feature-name`
- Bugfix branches: Create from `develop` with the naming convention `bugfix/issue-description`

### Commit Messages

Write clear, concise commit messages that explain the changes you've made. Follow these guidelines:

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

Example:
```
Add user profile image upload feature

- Implement file upload component
- Add server-side handling for image uploads
- Store images in uploads directory
- Update user profile schema
- Add image compression using Sharp

Fixes #123
```

### Pull Requests

When submitting a pull request:

1. Update the README.md or documentation with details of changes to the interface
2. Update the CHANGELOG.md if appropriate
3. The pull request should work for the supported versions of Node.js and browsers
4. Include screenshots for UI changes if applicable
5. Link any related issues

## Coding Standards

### JavaScript/TypeScript

- Use TypeScript for all new code
- Follow the ESLint configuration in the project
- Use async/await for asynchronous code instead of callbacks or Promises
- Use proper type definitions and avoid using `any` type
- Use meaningful variable and function names

### React

- Use functional components with hooks instead of class components
- Use the provided shadcn/ui components for UI elements
- Follow the component structure established in the project
- Use React Query for data fetching

### CSS/Styling

- Use Tailwind CSS for styling
- Follow the color schemes and design patterns established in the project
- Ensure responsive design for all screen sizes
- Use the theme variables defined in the project

## Database Changes

When making changes to the database schema:

1. Update the schema definitions in `shared/schema.ts`
2. Add new types or update existing types as needed
3. Create proper relations between tables
4. Run database migrations using `npm run db:push`
5. Update the `DATABASE.md` documentation

## Testing

Before submitting your changes, ensure that:

1. The application builds without errors
2. Your feature works as expected
3. Your changes don't break existing functionality
4. The application is responsive on different screen sizes

## Documentation

When adding new features or making significant changes, update the documentation:

1. Update the README.md if necessary
2. Update any relevant documentation in the `docs/` directory
3. Add comments to complex code sections
4. Update API documentation if you've modified or added endpoints

## Getting Help

If you need help with your contribution, you can:

1. Open an issue on GitHub with your question
2. Reach out to the project maintainers
3. Ask for help in the community forums

## Thank You!

Your contributions to Kingdom 1 & Friends are greatly appreciated. Your efforts help make this community resource better for all Age of Empires Mobile players!