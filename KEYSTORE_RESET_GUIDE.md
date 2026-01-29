# Keystore Mismatch - Resolution Guide

## Problem
Your app bundle is signed with a different keystore than expected by Google Play.

**Expected SHA1:** `49:87:12:F2:BE:DD:A2:4D:FE:1F:42:34:F8:B0:92:A3:59:9B:66:62`  
**Current SHA1:** `6D:AD:25:BD:0D:7E:4E:20:77:8A:FF:A4:8E:BC:A6:38:84:E4:38:97`

## Solution Options

### Option 1: Find and Use the Original Keystore (Recommended)

1. **Search for the original keystore file:**
   - Check backups, cloud storage, or other machines
   - Look for files with extensions: `.jks`, `.keystore`
   - The file might have a different name

2. **Verify the keystore fingerprint:**
   ```bash
   keytool -list -v -keystore /path/to/your/keystore.jks
   ```
   Look for SHA1: `49:87:12:F2:BE:DD:A2:4D:FE:1F:42:34:F8:B0:92:A3:59:9B:66:62`

3. **Update `android/key.properties`:**
   ```properties
   storePassword=YOUR_STORE_PASSWORD
   keyPassword=YOUR_KEY_PASSWORD
   keyAlias=YOUR_KEY_ALIAS
   storeFile=/path/to/original/keystore.jks
   ```

4. **Rebuild the app bundle:**
   ```bash
   flutter clean
   flutter pub get
   flutter build appbundle --release
   ```

### Option 2: Request Upload Key Reset from Google Play

If you cannot find the original keystore:

1. **Go to Google Play Console:**
   - Navigate to your app
   - Go to **Release** → **Setup** → **App signing**

2. **Request Upload Key Reset:**
   - Click on **Request upload key reset**
   - Follow the instructions
   - This process can take several days and requires verification

3. **Important Notes:**
   - You'll need to prove ownership of the app
   - Google will verify your identity
   - This is a one-time process per app
   - After reset, you can use your current keystore

## Current Configuration

Your current `android/key.properties` points to:
- **Keystore:** `android/app/mylMsf-keystore.jks`
- **SHA1:** `6D:AD:25:BD:0D:7E:4E:20:77:8A:FF:A4:8E:BC:A6:38:84:E4:38:97`

## Prevention

To avoid this in the future:
1. **Backup your keystore** in a secure location
2. **Document the keystore location** and credentials
3. **Use version control** for `key.properties` (but NOT the keystore file itself)
4. **Store keystore backups** in secure cloud storage with encryption

