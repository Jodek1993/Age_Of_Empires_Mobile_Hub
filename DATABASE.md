# K1Fam.com Database Schema

This document describes the database schema used by the K1Fam.com Age of Empires Mobile community website.

## Tables Overview

### Users

Stores user account information.

| Column     | Type          | Description                       |
|------------|---------------|-----------------------------------|
| id         | SERIAL        | Primary key                       |
| username   | VARCHAR(255)  | Unique username                   |
| email      | VARCHAR(255)  | User email address                |
| password   | VARCHAR(255)  | Hashed password                   |
| avatar     | VARCHAR(255)  | URL or path to user avatar        |
| bio        | TEXT          | User biography/description        |
| kingdom    | VARCHAR(255)  | User's kingdom name               |
| role       | VARCHAR(50)   | User role (user, admin, etc.)     |
| joinDate   | TIMESTAMP     | Account creation date             |
| lastActive | TIMESTAMP     | Last activity timestamp           |
| postCount  | INTEGER       | Number of posts created by user   |

### Forum Categories

Organizes forum discussions into categories.

| Column      | Type          | Description                       |
|-------------|---------------|-----------------------------------|
| id          | SERIAL        | Primary key                       |
| name        | VARCHAR(255)  | Category name                     |
| description | TEXT          | Category description              |
| icon        | VARCHAR(255)  | Icon for the category             |
| order       | INTEGER       | Display order                     |
| isVisible   | BOOLEAN       | Visibility toggle                 |
| parentId    | INTEGER       | Parent category (for hierarchies) |
| createdAt   | TIMESTAMP     | Creation timestamp                |

### Threads

Forum threads/topics created by users.

| Column      | Type          | Description                       |
|-------------|---------------|-----------------------------------|
| id          | SERIAL        | Primary key                       |
| title       | VARCHAR(255)  | Thread title                      |
| content     | TEXT          | Thread content/description        |
| userId      | INTEGER       | Creator user ID                   |
| categoryId  | INTEGER       | Forum category ID                 |
| isPinned    | BOOLEAN       | Pinned status flag                |
| isLocked    | BOOLEAN       | Locked status flag                |
| viewCount   | INTEGER       | Number of views                   |
| lastPostAt  | TIMESTAMP     | Last post timestamp               |
| createdAt   | TIMESTAMP     | Creation timestamp                |
| updatedAt   | TIMESTAMP     | Last update timestamp             |

### Posts

Individual posts within forum threads.

| Column      | Type          | Description                        |
|-------------|--------------|------------------------------------|
| id          | SERIAL        | Primary key                        |
| content     | TEXT          | Post content                       |
| userId      | INTEGER       | Author user ID                     |
| threadId    | INTEGER       | Thread ID                          |
| isEdited    | BOOLEAN       | Edited status flag                 |
| replyToId   | INTEGER       | ID of post being replied to        |
| createdAt   | TIMESTAMP     | Creation timestamp                 |
| updatedAt   | TIMESTAMP     | Last update timestamp              |

### Kingdoms

Information about in-game kingdoms.

| Column      | Type          | Description                        |
|-------------|--------------|------------------------------------|
| id          | SERIAL        | Primary key                        |
| name        | VARCHAR(255)  | Kingdom name                       |
| description | TEXT          | Kingdom description                |
| server      | VARCHAR(255)  | Game server                        |
| leader      | VARCHAR(255)  | Kingdom leader's name              |
| memberCount | INTEGER       | Number of members                  |
| emblem      | VARCHAR(255)  | Kingdom emblem image               |
| createdAt   | TIMESTAMP     | Creation timestamp                 |

### Admin Permissions

User-specific admin capabilities.

| Column              | Type          | Description                        |
|---------------------|--------------|------------------------------------|
| id                  | SERIAL        | Primary key                        |
| userId              | INTEGER       | User ID                            |
| canManageUsers      | BOOLEAN       | Permission to manage users         |
| canManagePosts      | BOOLEAN       | Permission to manage posts         |
| canManageCategories | BOOLEAN       | Permission to manage categories    |
| canManageAnnouncements | BOOLEAN    | Permission to manage announcements |
| canViewAnalytics    | BOOLEAN       | Permission to view analytics       |
| canAssignRoles      | BOOLEAN       | Permission to assign roles         |
| createdAt           | TIMESTAMP     | Creation timestamp                 |
| updatedAt           | TIMESTAMP     | Last update timestamp              |

### Announcements

Official and community announcements.

| Column           | Type          | Description                           |
|------------------|---------------|---------------------------------------|
| id               | SERIAL        | Primary key                           |
| title            | VARCHAR(255)  | Announcement title                    |
| content          | TEXT          | Announcement content                  |
| userId           | INTEGER       | Creator user ID                       |
| isPinned         | BOOLEAN       | Pinned status flag                    |
| isKingdomSpecific| BOOLEAN       | Kingdom-specific flag                 |
| kingdomId        | INTEGER       | Target kingdom ID                     |
| category         | VARCHAR(255)  | Announcement category                 |
| isOfficial       | BOOLEAN       | Official flag                         |
| publishDate      | TIMESTAMP     | Scheduled publish date                |
| imageUrl         | VARCHAR(255)  | Featured image URL                    |
| discordMessageId | VARCHAR(255)  | Related Discord message ID            |
| discordChannelId | VARCHAR(255)  | Related Discord channel ID            |
| createdAt        | TIMESTAMP     | Creation timestamp                    |
| updatedAt        | TIMESTAMP     | Last update timestamp                 |

### Content Moderation

Tracks moderation actions on content.

| Column      | Type          | Description                           |
|-------------|---------------|---------------------------------------|
| id          | SERIAL        | Primary key                           |
| contentType | VARCHAR(50)   | Type of content (post, thread, etc.)  |
| contentId   | INTEGER       | ID of the moderated content           |
| status      | VARCHAR(50)   | Moderation status                     |
| reason      | TEXT          | Moderation reason                     |
| moderatorId | INTEGER       | Moderator user ID                     |
| createdAt   | TIMESTAMP     | Creation timestamp                    |
| updatedAt   | TIMESTAMP     | Last update timestamp                 |

### Site Analytics

Daily website activity metrics.

| Column         | Type          | Description                           |
|----------------|---------------|---------------------------------------|
| id             | SERIAL        | Primary key                           |
| pageViews      | INTEGER       | Number of page views                  |
| uniqueVisitors | INTEGER       | Number of unique visitors             |
| registrations  | INTEGER       | Number of new registrations           |
| newThreads     | INTEGER       | Number of new threads                 |
| newPosts       | INTEGER       | Number of new posts                   |
| date           | DATE          | Date of analytics record (unique)     |
| createdAt      | TIMESTAMP     | Creation timestamp                    |

### Notifications

User notifications for various events.

| Column      | Type          | Description                           |
|-------------|---------------|---------------------------------------|
| id          | SERIAL        | Primary key                           |
| userId      | INTEGER       | Target user ID                        |
| type        | VARCHAR(50)   | Notification type                     |
| message     | TEXT          | Notification message                  |
| link        | VARCHAR(255)  | Related link                          |
| isRead      | BOOLEAN       | Read status flag                      |
| relatedId   | INTEGER       | ID of related content                 |
| createdAt   | TIMESTAMP     | Creation timestamp                    |

### Default Profile Pictures

Stock profile pictures available to users.

| Column      | Type          | Description                           |
|-------------|---------------|---------------------------------------|
| id          | SERIAL        | Primary key                           |
| url         | VARCHAR(255)  | Image URL                             |
| name        | VARCHAR(255)  | Display name                          |
| category    | VARCHAR(255)  | Image category                        |
| order       | INTEGER       | Display order                         |
| createdAt   | TIMESTAMP     | Creation timestamp                    |

### Profile Pictures

Custom user profile pictures.

| Column           | Type          | Description                          |
|------------------|---------------|--------------------------------------|
| id               | SERIAL        | Primary key                          |
| userId           | INTEGER       | User ID (unique)                     |
| filename         | VARCHAR(255)  | Stored filename                      |
| originalFilename | VARCHAR(255)  | Original uploaded filename           |
| mimetype         | VARCHAR(255)  | File MIME type                       |
| size             | INTEGER       | File size in bytes                   |
| createdAt        | TIMESTAMP     | Creation timestamp                   |
| updatedAt        | TIMESTAMP     | Last update timestamp                |

### Translations

Internationalization translation strings.

| Column      | Type          | Description                          |
|-------------|---------------|--------------------------------------|
| id          | SERIAL        | Primary key                          |
| namespace   | VARCHAR(255)  | Translation namespace                |
| language    | VARCHAR(10)   | Language code                        |
| key         | VARCHAR(255)  | Translation key                      |
| value       | TEXT          | Translated text                      |
| createdAt   | TIMESTAMP     | Creation timestamp                   |
| updatedAt   | TIMESTAMP     | Last update timestamp                |

### Translation Reports

User-submitted translation issues.

| Column         | Type          | Description                          |
|----------------|---------------|--------------------------------------|
| id             | SERIAL        | Primary key                          |
| translationId  | INTEGER       | Translation ID                       |
| userId         | INTEGER       | Reporter user ID                     |
| reason         | TEXT          | Report reason                        |
| status         | VARCHAR(50)   | Report status                        |
| createdAt      | TIMESTAMP     | Creation timestamp                   |
| updatedAt      | TIMESTAMP     | Last update timestamp                |

## Relationships

- **Users** -> **Forum Threads**: One-to-many (user creates many threads)
- **Users** -> **Posts**: One-to-many (user creates many posts)
- **Users** -> **Announcements**: One-to-many (user creates many announcements)
- **Users** -> **Notifications**: One-to-many (user receives many notifications)
- **Users** -> **ProfilePictures**: One-to-one (user has one profile picture)
- **Forum Categories** -> **Threads**: One-to-many (category contains many threads)
- **Threads** -> **Posts**: One-to-many (thread contains many posts)
- **Posts** -> **Posts**: One-to-many (post can be a reply to another post)
- **Kingdoms** -> **Announcements**: One-to-many (kingdom can have many announcements)

## Indexes

The following indexes are created for performance optimization:

- `idx_threads_category` on `threads(categoryId)`
- `idx_posts_thread` on `posts(threadId)`
- `idx_notifications_user` on `notifications(userId)`
- `idx_announcements_is_official` on `announcements(isOfficial)`