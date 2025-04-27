# K1Fam.com API Documentation

This document describes the available API endpoints for the K1Fam.com Age of Empires Mobile community website.

## Authentication Endpoints

### Register a new user

**Endpoint:** `POST /api/register`

**Request Body:**
```json
{
  "username": "string",
  "email": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "id": "number",
  "username": "string",
  "email": "string",
  "role": "string",
  "joinDate": "string"
}
```

### Login

**Endpoint:** `POST /api/login`

**Request Body:**
```json
{
  "username": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "id": "number",
  "username": "string",
  "email": "string",
  "role": "string",
  "avatar": "string",
  "bio": "string",
  "kingdom": "string"
}
```

### Logout

**Endpoint:** `POST /api/logout`

**Response:** 200 OK

### Get current user

**Endpoint:** `GET /api/user`

**Response:**
```json
{
  "id": "number",
  "username": "string",
  "email": "string",
  "role": "string",
  "avatar": "string",
  "bio": "string",
  "kingdom": "string",
  "joinDate": "string",
  "lastActive": "string",
  "postCount": "number"
}
```

## Forum Endpoints

### Get all categories

**Endpoint:** `GET /api/categories`

**Response:**
```json
[
  {
    "id": "number",
    "name": "string",
    "description": "string",
    "icon": "string",
    "order": "number",
    "isVisible": "boolean",
    "parentId": "number",
    "createdAt": "string"
  }
]
```

### Get threads by category

**Endpoint:** `GET /api/categories/:categoryId/threads`

**Response:**
```json
[
  {
    "id": "number",
    "title": "string",
    "content": "string",
    "userId": "number",
    "categoryId": "number",
    "isPinned": "boolean",
    "isLocked": "boolean",
    "viewCount": "number",
    "lastPostAt": "string",
    "createdAt": "string",
    "updatedAt": "string",
    "user": {
      "id": "number",
      "username": "string",
      "avatar": "string"
    },
    "postCount": "number"
  }
]
```

### Get thread details

**Endpoint:** `GET /api/threads/:threadId`

**Response:**
```json
{
  "id": "number",
  "title": "string",
  "content": "string",
  "userId": "number",
  "categoryId": "number",
  "isPinned": "boolean",
  "isLocked": "boolean",
  "viewCount": "number",
  "lastPostAt": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "user": {
    "id": "number",
    "username": "string",
    "avatar": "string"
  },
  "category": {
    "id": "number",
    "name": "string"
  }
}
```

### Create a new thread

**Endpoint:** `POST /api/threads`

**Request Body:**
```json
{
  "title": "string",
  "content": "string",
  "categoryId": "number"
}
```

**Response:**
```json
{
  "id": "number",
  "title": "string",
  "content": "string",
  "userId": "number",
  "categoryId": "number",
  "isPinned": "boolean",
  "isLocked": "boolean",
  "viewCount": "number",
  "createdAt": "string",
  "updatedAt": "string"
}
```

### Get posts for a thread

**Endpoint:** `GET /api/threads/:threadId/posts`

**Response:**
```json
[
  {
    "id": "number",
    "content": "string",
    "userId": "number",
    "threadId": "number",
    "isEdited": "boolean",
    "replyToId": "number",
    "createdAt": "string",
    "updatedAt": "string",
    "user": {
      "id": "number",
      "username": "string",
      "avatar": "string"
    }
  }
]
```

### Create a post in a thread

**Endpoint:** `POST /api/threads/:threadId/posts`

**Request Body:**
```json
{
  "content": "string",
  "replyToId": "number" // Optional
}
```

**Response:**
```json
{
  "id": "number",
  "content": "string",
  "userId": "number",
  "threadId": "number",
  "isEdited": "boolean",
  "replyToId": "number",
  "createdAt": "string",
  "updatedAt": "string"
}
```

## Announcements Endpoints

### Get all announcements

**Endpoint:** `GET /api/announcements`

**Response:**
```json
[
  {
    "id": "number",
    "title": "string",
    "content": "string",
    "userId": "number",
    "isPinned": "boolean",
    "isKingdomSpecific": "boolean",
    "kingdomId": "number",
    "category": "string",
    "isOfficial": "boolean",
    "publishDate": "string",
    "imageUrl": "string",
    "discordMessageId": "string",
    "discordChannelId": "string",
    "createdAt": "string",
    "updatedAt": "string",
    "user": {
      "id": "number",
      "username": "string"
    }
  }
]
```

### Get official announcements

**Endpoint:** `GET /api/announcements/official`

**Response:**
```json
[
  {
    "id": "number",
    "title": "string",
    "content": "string",
    "userId": "number",
    "isPinned": "boolean",
    "category": "string",
    "publishDate": "string",
    "imageUrl": "string",
    "createdAt": "string",
    "updatedAt": "string"
  }
]
```

### Create an announcement (Admin only)

**Endpoint:** `POST /api/announcements`

**Request Body:**
```json
{
  "title": "string",
  "content": "string",
  "isPinned": "boolean",
  "isKingdomSpecific": "boolean",
  "kingdomId": "number",
  "category": "string",
  "isOfficial": "boolean",
  "publishDate": "string",
  "imageUrl": "string"
}
```

**Response:**
```json
{
  "id": "number",
  "title": "string",
  "content": "string",
  "userId": "number",
  "isPinned": "boolean",
  "isKingdomSpecific": "boolean",
  "kingdomId": "number",
  "category": "string",
  "isOfficial": "boolean",
  "publishDate": "string",
  "imageUrl": "string",
  "createdAt": "string",
  "updatedAt": "string"
}
```

## User Profile Endpoints

### Get user profile

**Endpoint:** `GET /api/users/:userId`

**Response:**
```json
{
  "id": "number",
  "username": "string",
  "avatar": "string",
  "bio": "string",
  "kingdom": "string",
  "joinDate": "string",
  "lastActive": "string",
  "postCount": "number"
}
```

### Update user profile

**Endpoint:** `PATCH /api/users/:userId`

**Request Body:**
```json
{
  "bio": "string",
  "kingdom": "string"
}
```

**Response:**
```json
{
  "id": "number",
  "username": "string",
  "avatar": "string",
  "bio": "string",
  "kingdom": "string",
  "joinDate": "string",
  "lastActive": "string",
  "postCount": "number"
}
```

### Upload profile picture

**Endpoint:** `POST /api/profile-picture`

**Request Body:**
Form data with 'file' field containing the image file.

**Response:**
```json
{
  "userId": "number",
  "filename": "string",
  "originalFilename": "string",
  "mimetype": "string",
  "size": "number",
  "createdAt": "string"
}
```

## Notification Endpoints

### Get user notifications

**Endpoint:** `GET /api/notifications`

**Response:**
```json
[
  {
    "id": "number",
    "userId": "number",
    "type": "string",
    "message": "string",
    "link": "string",
    "isRead": "boolean",
    "relatedId": "number",
    "createdAt": "string"
  }
]
```

### Get unread notification count

**Endpoint:** `GET /api/notifications/unread/count`

**Response:**
```json
{
  "count": "number"
}
```

### Mark notification as read

**Endpoint:** `PATCH /api/notifications/:notificationId`

**Request Body:**
```json
{
  "isRead": "boolean"
}
```

**Response:**
```json
{
  "id": "number",
  "isRead": "boolean"
}
```

### Mark all notifications as read

**Endpoint:** `POST /api/notifications/read-all`

**Response:** 200 OK

## Kingdom Dashboard Endpoints (Admin Only)

### Get site analytics

**Endpoint:** `GET /api/admin/analytics`

**Query Parameters:**
- `timeRange`: string (optional) - "day", "week", "month", "year"

**Response:**
```json
{
  "summary": {
    "totalUsers": "number",
    "totalThreads": "number",
    "totalPosts": "number",
    "activeUsers": "number"
  },
  "activity": [
    {
      "date": "string",
      "pageViews": "number",
      "uniqueVisitors": "number",
      "registrations": "number",
      "newThreads": "number",
      "newPosts": "number"
    }
  ]
}
```

### Get all users (Admin only)

**Endpoint:** `GET /api/admin/users`

**Response:**
```json
[
  {
    "id": "number",
    "username": "string",
    "email": "string",
    "role": "string",
    "joinDate": "string",
    "lastActive": "string",
    "postCount": "number"
  }
]
```

### Update user role (Admin only)

**Endpoint:** `PATCH /api/admin/users/:userId`

**Request Body:**
```json
{
  "role": "string"
}
```

**Response:**
```json
{
  "id": "number",
  "username": "string",
  "role": "string"
}
```

## Error Responses

All API endpoints will return appropriate HTTP status codes:

- **200** - Success
- **201** - Created
- **400** - Bad Request (invalid input)
- **401** - Unauthorized (not logged in)
- **403** - Forbidden (not enough permissions)
- **404** - Not Found
- **500** - Server Error

Error responses will have the following format:

```json
{
  "error": "string",
  "message": "string"
}
```