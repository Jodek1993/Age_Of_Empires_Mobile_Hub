# Kingdom 1 & Friends (K1Fam.com) Project Overview

## Project Description

Kingdom 1 & Friends is a comprehensive community platform designed for Age of Empires Mobile players, with a specific focus on the K1 (Kingdom 1) community. The platform provides interactive tools, community engagement features, and data-driven insights to enhance strategic gameplay and community interaction.

## Core Features

### User Authentication & Profiles
- **Account Creation & Login**: Secure user authentication system
- **User Profiles**: Customizable profile pages with avatar selection/upload
- **Role-Based Access**: Different permission levels for users, moderators, and administrators

### Community Features
- **Forum System**: Thread-based discussion with categories and rich text formatting
- **Kingdom Dashboard**: Administrative tools for kingdom management
- **Hero Pairings**: Interactive guides for game strategy
- **KvK Glory Tracking**: Performance metrics for kingdom vs. kingdom events

### Game Profile Verification
- **Verification System**: Connect website accounts to in-game profiles
- **Verification Codes**: Secure 10-character verification codes
- **Admin Verification**: Manual approval by administrators
- **Status Badges**: Display verification status on profiles and forum posts

### Content Management
- **Official Announcements**: System for publishing important updates
- **Notification System**: Real-time notifications for user interactions
- **Profile Pictures**: Upload and select options with moderation

## Technical Architecture

### Frontend
- **Framework**: React with TypeScript
- **State Management**: React Query for server state
- **Styling**: Tailwind CSS with custom shadcn/ui components
- **Routing**: Wouter for navigation
- **Forms**: React Hook Form with zod validation

### Backend
- **Server**: Express.js with TypeScript
- **Database**: PostgreSQL with Drizzle ORM
- **Authentication**: Passport.js with session-based auth
- **File Storage**: Local file system for uploads

### API Routes
- **/api/user**: User authentication and profile management
- **/api/verification**: Game profile verification system
- **/api/forums**: Forum categories, threads, and posts
- **/api/kingdoms**: Kingdom management and settings
- **/api/admin**: Administrative controls and monitoring

## Database Schema

### Core Tables
- **users**: User accounts and profile information
- **forum_categories**: Forum organization
- **threads**: Discussion threads
- **posts**: Individual messages within threads
- **kingdoms**: Kingdom information and metrics

### Verification Tables
- **game_profile_verifications**: Links users to game profiles
- **verification_logs**: Tracking of verification activities

### Supporting Tables
- **profile_pictures**: User avatar management
- **admin_permissions**: User role configuration
- **notifications**: User notification system
- **announcements**: Official communication

## Development Guidelines

### Code Standards
- Use TypeScript for all new code
- Follow the established project structure
- Implement proper error handling
- Document functions and components
- Use consistent naming conventions

### Feature Implementation Process
1. Define requirements and acceptance criteria
2. Update database schema if needed (in `shared/schema.ts`)
3. Implement backend routes and storage methods
4. Create frontend components and pages
5. Connect to API using React Query
6. Implement proper error handling and loading states
7. Test thoroughly across different user roles

## Deployment Information

The application is designed to be deployed on any platform supporting Node.js and PostgreSQL, including:
- Replit
- Vercel
- Heroku
- AWS
- Digital Ocean

## Contribution Guidelines

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note**: This documentation provides an overview of the K1Fam.com website project. For more detailed technical documentation, please refer to the codebase and specific documentation files in the `/docs` directory.