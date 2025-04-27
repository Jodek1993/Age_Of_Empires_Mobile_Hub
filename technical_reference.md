# Kingdom 1 & Friends Technical Reference

This document provides technical details for developers working on the K1Fam.com website project.

## Project Structure

```
k1fam-website/
├── client/                 # Frontend code
│   ├── public/             # Static assets
│   └── src/                # React application source
│       ├── assets/         # Images, icons, etc.
│       ├── components/     # Reusable UI components
│       │   ├── ui/         # shadcn/ui components
│       │   └── game-verification/ # Verification components
│       ├── hooks/          # Custom React hooks
│       ├── lib/            # Utility functions
│       ├── pages/          # Application pages
│       ├── App.tsx         # Main application component
│       └── main.tsx        # Application entry point
├── server/                 # Backend code
│   ├── auth.ts             # Authentication setup
│   ├── db.ts               # Database connection
│   ├── game-verification.ts # Verification routes
│   ├── index.ts            # Server entry point
│   ├── profile-pictures.ts # Profile picture handling
│   ├── routes.ts           # API routes definition
│   ├── storage.ts          # Database operations
│   ├── translation.ts      # Translation services
│   └── vite.ts             # Vite integration
├── shared/                 # Shared code between client and server
│   └── schema.ts           # Database schema definitions
├── uploads/                # User uploaded files
├── scripts/                # Utility scripts
├── docs/                   # Documentation
├── drizzle.config.ts       # Drizzle ORM configuration
├── package.json            # Project dependencies
├── tsconfig.json           # TypeScript configuration
├── tailwind.config.ts      # Tailwind CSS configuration
├── vite.config.ts          # Vite configuration
└── README.md               # Project overview
```

## Technology Stack

### Frontend
- **React (v18+)** - UI library
- **TypeScript** - Type safety
- **Tailwind CSS** - Utility-first CSS framework
- **shadcn/ui** - Component library based on Radix UI
- **TanStack Query** - Data fetching and state management
- **React Hook Form** - Form handling
- **Zod** - Schema validation
- **Wouter** - Lightweight routing

### Backend
- **Express.js** - Web framework
- **TypeScript** - Type safety
- **Passport.js** - Authentication middleware
- **Drizzle ORM** - Database ORM
- **PostgreSQL** - Relational database
- **Multer** - File uploads

## Core Subsystems

### Authentication System

The authentication system uses Passport.js with a local strategy. Authentication state is maintained using server-side sessions stored in PostgreSQL.

**Key Files:**
- `server/auth.ts` - Authentication setup and routes
- `client/src/hooks/use-auth.tsx` - Authentication hook
- `client/src/lib/protected-route.tsx` - Route protection

**User Flow:**
1. User registers or logs in through forms in `client/src/pages/auth-page.tsx`
2. Client sends credentials to `/api/register` or `/api/login`
3. Server authenticates and establishes a session
4. Client uses the `useAuth` hook to access the authenticated user

### Game Verification System

The game verification system allows users to link their website accounts to their in-game profiles using a verification code.

**Key Files:**
- `server/game-verification.ts` - Verification routes and logic
- `client/src/components/game-verification/VerificationPanel.tsx` - User-facing verification UI
- `client/src/components/game-verification/AdminVerificationManager.tsx` - Admin verification UI
- `shared/schema.ts` - Verification-related database schema

**Verification Flow:**
1. User generates a verification code from their profile page
2. User enters this code in the Age of Empires Mobile game
3. Admin reviews and verifies the account
4. User's account shows verification status with badges

### Forum System

The forum system provides a platform for community discussions organized by categories.

**Key Files:**
- `server/routes.ts` - Forum API routes
- `client/src/pages/forums-page.tsx` - Forums listing
- `client/src/pages/thread-page.tsx` - Thread view with posts

**Data Flow:**
1. Categories and threads are loaded using React Query
2. Users can create threads and post replies
3. Dynamic updates occur when new content is added
4. Search functionality allows filtering of content

### Profile Picture System

Manages user profile pictures with upload capability and default themed options.

**Key Files:**
- `server/profile-pictures.ts` - Profile picture routes
- `client/src/components/profile/ProfilePictureUploader.tsx` - Upload UI
- `client/src/components/profile/ProfilePictureSelector.tsx` - Default selection UI

**Upload Flow:**
1. User selects an image from their device
2. Image is uploaded to server
3. Server processes the image (resize, format)
4. Image is saved to `uploads/` directory
5. Database record is updated with the path

## Database Schema

The database schema is defined in `shared/schema.ts` using Drizzle ORM.

**Key Tables:**
- `users` - User accounts
- `gameProfileVerifications` - Game verification records
- `verificationLogs` - Logs of verification activities
- `forumCategories` - Forum categories
- `threads` - Discussion threads
- `posts` - Thread posts
- `profilePictures` - User profile pictures
- `defaultProfilePictures` - Stock profile images
- `kingdoms` - Kingdom information
- `adminPermissions` - User roles and permissions
- `notifications` - User notifications
- `announcements` - Official announcements

## API Routes

### User Management
- `POST /api/register` - Create new user
- `POST /api/login` - User login
- `POST /api/logout` - User logout
- `GET /api/user` - Get current user
- `PATCH /api/user` - Update user profile

### Game Verification
- `GET /api/verification/status` - Get verification status
- `POST /api/verification/generate-code` - Generate verification code
- `GET /api/admin/verifications/pending` - Get pending verifications
- `POST /api/admin/verifications/respond` - Approve/reject verification

### Forums
- `GET /api/categories` - Get forum categories
- `GET /api/categories/:id/threads` - Get threads in category
- `GET /api/threads/:id` - Get thread details
- `GET /api/threads/:id/posts` - Get posts in thread
- `POST /api/threads` - Create new thread
- `POST /api/posts` - Create new post

### Profile Pictures
- `GET /api/profile/picture` - Get user's profile picture
- `POST /api/profile/picture/upload` - Upload profile picture
- `GET /api/profile/default-pictures` - Get default pictures
- `POST /api/profile/picture/select` - Select default picture

### Kingdoms
- `GET /api/kingdoms` - Get all kingdoms
- `GET /api/kingdoms/:id` - Get specific kingdom
- `POST /api/kingdoms` - Create new kingdom

### Admin
- `GET /api/admin/users` - Get all users
- `GET /api/admin/permissions` - Get current user permissions
- `GET /api/admin/permissions/all` - Get all user permissions
- `PATCH /api/admin/permissions/:userId` - Update user permissions

## Common Development Tasks

### Adding a New Page
1. Create a new page component in `client/src/pages/`
2. Add the route in `client/src/App.tsx`
3. Create necessary API endpoints in `server/routes.ts`
4. Implement the storage methods in `server/storage.ts`

### Adding a New Database Table
1. Define the table schema in `shared/schema.ts`
2. Create the insert schema using `createInsertSchema`
3. Define the insert and select types
4. Add related methods to the `IStorage` interface in `server/storage.ts`
5. Implement these methods in the `DatabaseStorage` class
6. Run database migration with `npm run db:push`

### Implementing a New Feature
1. Plan the feature's frontend and backend components
2. Update the database schema if needed
3. Create backend routes and storage methods
4. Implement frontend components and pages
5. Connect to API using React Query
6. Add proper error handling and loading states
7. Test thoroughly

## Environment Configuration

The application uses environment variables for configuration. Copy `.env.example` to `.env` and set the values:

```
# Database Configuration
DATABASE_URL=postgresql://username:password@localhost:5432/k1fam_db

# Session Secret
SESSION_SECRET=your-secure-session-secret

# Server Configuration
PORT=3000
NODE_ENV=development

# Upload Limits
MAX_UPLOAD_SIZE=5242880
```

## Troubleshooting

### Database Connection Issues
- Check that PostgreSQL is running
- Verify DATABASE_URL in .env file
- Ensure database user has proper permissions

### Authentication Problems
- Check SESSION_SECRET in .env file
- Verify session store is properly configured
- Check for CORS issues if frontend and backend are on different domains

### File Upload Issues
- Check directory permissions for 'uploads' folder
- Verify MAX_UPLOAD_SIZE in .env file
- Check for missing multer middleware in routes

### Deployment Issues
- Ensure all environment variables are set
- Check for differences between development and production environments
- Verify database migrations have been applied

## Performance Optimization

- Use React.memo for expensive components
- Implement proper data pagination
- Configure appropriate cache settings in React Query
- Use indexes on frequently queried database columns
- Optimize image size and format for uploads

## Security Considerations

- Always validate user input with Zod schemas
- Use parameterized queries to prevent SQL injection
- Implement proper CSRF protection
- Sanitize user-generated content before display
- Use proper content security policies
- Implement rate limiting on sensitive endpoints

## Testing

The project uses Jest for testing. Run tests with:

```bash
npm test
```

Write tests for:
- React components using React Testing Library
- API endpoints using Supertest
- Utility functions with unit tests
- Database operations with integration tests