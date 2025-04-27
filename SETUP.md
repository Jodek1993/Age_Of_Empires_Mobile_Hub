# Local Development Setup Guide

This guide provides detailed instructions for setting up a local development environment for the K1Fam.com Age of Empires Mobile community website.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Node.js** (v18.x or later)
- **npm** (v8.x or later)
- **PostgreSQL** (v14.x or later)
- **Git**

## Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/k1fam.git
cd k1fam
```

## Step 2: Set Up the Database

1. Create a PostgreSQL database for the project:

```bash
createdb k1fam
```

2. Import the database schema:

```bash
psql -d k1fam -f scripts/db-init.sql
```

Alternatively, you can use the Drizzle ORM migration system:

```bash
npm run db:push
```

## Step 3: Configure Environment Variables

1. Create a `.env` file in the project root directory:

```bash
cp .env.example .env
```

2. Edit the `.env` file and set the appropriate values for your environment:

```
# Database configuration
DATABASE_URL=postgres://username:password@localhost:5432/k1fam
PGHOST=localhost
PGPORT=5432
PGUSER=your_username
PGPASSWORD=your_password
PGDATABASE=k1fam

# Session configuration
SESSION_SECRET=a_random_secret_key_for_development

# Server configuration
PORT=5000
NODE_ENV=development
```

## Step 4: Install Dependencies

```bash
npm install
```

## Step 5: Start the Development Server

```bash
npm run dev
```

This will start both the frontend and backend servers concurrently. The application will be available at http://localhost:5000.

## Project Structure

Understanding the project structure will help you navigate and contribute to the codebase:

```
.
├── client/                 # Frontend React application
│   ├── src/
│   │   ├── assets/         # Static assets (images, etc.)
│   │   ├── components/     # Reusable UI components
│   │   ├── hooks/          # React custom hooks
│   │   ├── i18n/           # Internationalization setup
│   │   ├── lib/            # Utility functions
│   │   ├── pages/          # Page components
│   │   ├── App.tsx         # Main App component
│   │   └── main.tsx        # Entry point
│   └── index.html          # HTML template
├── server/                 # Backend Express server
│   ├── index.ts            # Entry point
│   ├── routes.ts           # API routes
│   ├── storage.ts          # Data storage interface
│   ├── auth.ts             # Authentication setup
│   ├── db.ts               # Database connection
│   └── vite.ts             # Vite integration
├── shared/                 # Shared code between client and server
│   └── schema.ts           # Database schema and types
├── uploads/                # Directory for user uploads
├── scripts/                # Utility scripts
│   └── db-init.sql         # Database initialization script
├── .env                    # Environment variables (not in repo)
├── .env.example            # Environment variables template
└── package.json            # Project dependencies
```

## Development Workflow

Here's the recommended workflow for development:

1. **Create a new branch** for your feature or fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes** to the codebase

3. **Test your changes** by running the development server:
   ```bash
   npm run dev
   ```

4. **Commit your changes** with descriptive commit messages:
   ```bash
   git add .
   git commit -m "Add feature: your feature description"
   ```

5. **Push your changes** to the repository:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a pull request** on GitHub

## TypeScript and Type Safety

The project uses TypeScript for type safety. The database schema types are defined in `shared/schema.ts` and are shared between the client and server.

When making changes to the database schema, be sure to update the types in this file and run the Drizzle migration commands to update the database.

## Adding New Features

When adding new features, consider the following:

1. **Backend Changes**:
   - Add new schema definitions to `shared/schema.ts`
   - Update the storage interface in `server/storage.ts`
   - Add new API routes in `server/routes.ts`

2. **Frontend Changes**:
   - Create new components in `client/src/components/`
   - Add new pages in `client/src/pages/`
   - Update routes in `client/src/App.tsx`
   - Add new queries/mutations using React Query in appropriate hooks

## Troubleshooting

### Database Connection Issues

If you're experiencing issues connecting to the database:

1. Verify that PostgreSQL is running:
   ```bash
   pg_isready
   ```

2. Check your `.env` file for correct database credentials

3. Try connecting manually:
   ```bash
   psql -U your_username -d k1fam
   ```

### Server Won't Start

If the server fails to start:

1. Check for errors in the console output

2. Verify that the required environment variables are set

3. Ensure that the port is not already in use:
   ```bash
   lsof -i :5000
   ```

4. Try cleaning the node_modules and reinstalling:
   ```bash
   rm -rf node_modules
   npm install
   ```

### Client Build Issues

If you encounter issues with the client build:

1. Check for TypeScript errors in your code

2. Verify that all required dependencies are installed

3. Clear the Vite cache:
   ```bash
   rm -rf node_modules/.vite
   ```

## Additional Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Node.js Documentation](https://nodejs.org/en/docs/)
- [React Documentation](https://reactjs.org/docs/getting-started.html)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Drizzle ORM Documentation](https://orm.drizzle.team/docs/overview)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [shadcn/ui Documentation](https://ui.shadcn.com/)