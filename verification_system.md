# Game Profile Verification System

This document provides comprehensive information about the Game Profile Verification system in the Kingdom 1 & Friends community website.

## Overview

The verification system allows website users to connect their accounts to their in-game Age of Empires Mobile profiles. This ensures authenticity within the community by displaying verification status on user profiles and forum posts.

## Key Features

- **Verification Codes**: 10-character codes (dictionary word + numeric suffix)
- **Expiration System**: Codes expire after 48 hours
- **Admin Verification**: Manual approval by administrators
- **Status Tracking**: Five distinct verification states (unverified, pending, verified, rejected, expired)
- **Verification Logs**: Complete audit trail of verification activities
- **Status Badges**: Visual indicators of verification status

## System Architecture

### Database Schema

The verification system uses two main tables:

1. **gameProfileVerifications**
   - Primary verification records
   - Stores codes, status, and game profile details
   - Linked to user accounts

2. **verificationLogs**
   - Historical record of all verification activities
   - Tracks actions, timestamps, and status changes
   - Provides audit trail for administrators

### Components

The verification system consists of these key components:

1. **Backend API Routes**
   - Located in `server/game-verification.ts`
   - Handles verification code generation and status checks
   - Provides admin-only routes for verification management

2. **User-Facing UI**
   - Located in `client/src/components/game-verification/VerificationPanel.tsx`
   - Displays verification status and allows code generation
   - Shows instructions for completing verification

3. **Admin Management UI**
   - Located in `client/src/components/game-verification/AdminVerificationManager.tsx`
   - Lists pending verification requests
   - Provides interface for approving/rejecting verifications
   - Shows verification activity logs

## Verification Process

### For Users

1. **Generate Verification Code**
   - User visits their profile page
   - Clicks "Verify Game Profile" button
   - System generates a unique 10-character code
   - Code is displayed with instructions

2. **Submit Code In-Game**
   - User opens Age of Empires Mobile
   - Navigates to Profile Settings
   - Finds Community Verification section
   - Enters the code exactly as shown
   - Submits the code in the game

3. **Await Verification**
   - User's verification status changes to "Pending"
   - Code remains valid for 48 hours
   - User waits for administrator review

4. **Verification Result**
   - If approved: Status changes to "Verified" with game details
   - If rejected: Status changes to "Rejected" with reason
   - If expired: Status changes to "Expired"

### For Administrators

1. **Access Verification Dashboard**
   - Admin navigates to Kingdom Dashboard
   - Selects Verification Management tab

2. **Review Pending Requests**
   - View list of pending verification requests
   - See verification code, username, and timestamp

3. **Verify In-Game**
   - Check the Age of Empires Mobile game
   - Confirm code was entered by the correct player
   - Note player's in-game name, kingdom, and level

4. **Approve or Reject**
   - For valid verifications: Enter game details and approve
   - For invalid verifications: Enter rejection reason and reject

5. **Monitor Activity**
   - View verification activity logs
   - Track verification patterns and issues

## Verification States

1. **Unverified**
   - Default state for all users
   - No verification attempt made

2. **Pending**
   - Verification code generated
   - Awaiting admin verification
   - Valid for 48 hours

3. **Verified**
   - Successfully verified by admin
   - Displays game profile details
   - Permanent until manual reset

4. **Rejected**
   - Verification attempt rejected by admin
   - Includes rejection reason
   - User can generate a new code

5. **Expired**
   - Verification code has passed 48-hour window
   - User needs to generate a new code

## Code Generation

Verification codes follow a specific format:

- Dictionary word from a game-themed word list (e.g., CASTLE, KNIGHT)
- 4-digit numeric suffix (e.g., 1234)
- Combined for a unique 10-character code (e.g., CASTLE1234)

This format makes codes:
- Easy to remember
- Difficult to guess
- Clear to read and type
- Uniquely identifiable

## API Reference

### User Endpoints

#### `GET /api/verification/status`
- **Purpose**: Get current user's verification status
- **Authentication**: Required
- **Returns**: Verification status and details
- **Response Example**:
  ```json
  {
    "status": "pending",
    "verificationCode": "CASTLE1234",
    "codeGeneratedAt": "2025-04-25T15:30:22Z",
    "expiresAt": "2025-04-27T15:30:22Z"
  }
  ```

#### `POST /api/verification/generate-code`
- **Purpose**: Generate a new verification code
- **Authentication**: Required
- **Returns**: New verification code and details
- **Response Example**:
  ```json
  {
    "status": "pending",
    "verificationCode": "KNIGHT5678",
    "codeGeneratedAt": "2025-04-27T10:15:45Z",
    "expiresAt": "2025-04-29T10:15:45Z"
  }
  ```

### Admin Endpoints

#### `GET /api/admin/verifications/pending`
- **Purpose**: Get list of pending verifications
- **Authentication**: Admin required
- **Returns**: Array of pending verification requests
- **Response Example**:
  ```json
  [
    {
      "id": 12,
      "userId": 5,
      "username": "Player123",
      "verificationCode": "SHIELD4321",
      "status": "pending",
      "codeGeneratedAt": "2025-04-26T09:11:33Z",
      "expiresAt": "2025-04-28T09:11:33Z"
    },
    ...
  ]
  ```

#### `GET /api/admin/verifications/activity`
- **Purpose**: Get verification activity logs
- **Authentication**: Admin required
- **Returns**: Array of verification activity logs
- **Response Example**:
  ```json
  [
    {
      "id": 45,
      "verificationId": 12,
      "userId": 5,
      "action": "generate_code",
      "status": "success",
      "details": "Generated verification code: SHIELD4321",
      "timestamp": "2025-04-26T09:11:33Z"
    },
    ...
  ]
  ```

#### `GET /api/admin/verifications/logs/:verificationId`
- **Purpose**: Get logs for specific verification
- **Authentication**: Admin required
- **Returns**: Array of logs for the specified verification
- **Response Example**:
  ```json
  [
    {
      "id": 45,
      "verificationId": 12,
      "userId": 5,
      "action": "generate_code",
      "status": "success",
      "details": "Generated verification code: SHIELD4321",
      "timestamp": "2025-04-26T09:11:33Z"
    },
    ...
  ]
  ```

#### `POST /api/admin/verifications/respond`
- **Purpose**: Approve or reject verification
- **Authentication**: Admin required
- **Request Body**:
  ```json
  {
    "verificationId": 12,
    "action": "approve",
    "gameUsername": "Player_AOE",
    "gameKingdom": "Kingdom 1",
    "gameLevel": 25
  }
  ```
  or
  ```json
  {
    "verificationId": 12,
    "action": "reject",
    "reason": "Code not found in game"
  }
  ```
- **Returns**: Updated verification details

## Troubleshooting

### Common Issues

#### Code Generation Fails
- Check user authentication status
- Verify database connectivity
- Check for previous unresolved verification

#### Code Expiry Issues
- Verify server time settings
- Check date calculation logic
- Ensure proper timezone handling

#### Verification Status Not Updating
- Check admin permissions
- Verify API endpoint connectivity
- Inspect database transaction logs

#### Admin Panel Not Showing Pending Verifications
- Check admin role assignment
- Verify permissions configuration
- Inspect API response data

### Error Handling

The verification system includes comprehensive error handling:

- Client-side errors show user-friendly messages
- Empty API responses are handled gracefully
- Network errors provide retry options
- Error logs capture detailed diagnostics

## Security Considerations

The verification system implements several security measures:

- **Rate Limiting**: Prevents abuse of code generation
- **Expiry System**: Limits window of opportunity for unauthorized use
- **Admin Approval**: Requires manual verification of legitimacy
- **Audit Logs**: Tracks all system activities
- **Permission Controls**: Restricts admin functions appropriately

## Future Enhancements

Planned improvements to the verification system:

1. **Automatic Verification**: API integration with game for automatic verification
2. **Bulk Verification**: Tools for handling multiple verifications efficiently
3. **Verification Tiers**: Different levels of verification for different privileges
4. **Verification Analytics**: Reporting on verification patterns and issues
5. **Verification Reminders**: Automated notifications for pending/expiring verifications