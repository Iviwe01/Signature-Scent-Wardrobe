# 📱 Installing Signature Scent Wardrobe on Your Phone

## 🎯 App Information
- **App Name:** Signature Scent Wardrobe
- **Version:** 1.0.0
- **Description:** Create perfect fragrance combinations

## 📦 Installation Steps

### Method 1: Direct Installation (Easiest)

1. **Locate the APK file:**
   - The APK file will be at: `build\app\outputs\flutter-apk\app-release.apk`
   - Full path: `C:\Users\andyr\scent_wardrobe\build\app\outputs\flutter-apk\app-release.apk`

2. **Transfer to your phone:**
   - **Option A:** Connect your phone to computer via USB and copy the APK file to your phone's Downloads folder
   - **Option B:** Email the APK to yourself and download it on your phone
   - **Option C:** Upload to Google Drive/Dropbox and download on your phone

3. **Install on your phone:**
   - Open the APK file on your phone
   - If prompted, allow "Install from Unknown Sources" for the app you're using (File Manager, Chrome, Gmail, etc.)
   - Tap "Install"
   - Wait for installation to complete
   - Tap "Open" to launch the app!

### Method 2: Using ADB (If phone is connected)

```bash
# Navigate to project directory
cd C:\Users\andyr\scent_wardrobe

# Install directly to connected phone
flutter install
```

## ⚠️ Important Notes

- **Unknown Sources:** You may need to enable "Install from Unknown Sources" in your phone's settings
- **Security Warning:** Your phone might show a warning because the app isn't from Google Play Store - this is normal for self-installed apps
- **Storage:** The app requires about 20-30 MB of space

## 🎨 App Features

✨ **Beautiful Design:**
- Clean white minimalist interface
- Seasonal backgrounds (summer beach, winter snowy scenes)
- Professional typography and spacing

🧪 **Fragrance Management:**
- Browse 20+ unique fragrance combinations
- Detailed fragrance information (Type, Concentration, Longevity, Projection)
- Filter by mood and season
- Layer base and top fragrances

📊 **Fragrance Types:**
- **EDC** (Eau de Cologne): 2-5%, 1-2 hours
- **EDT** (Eau de Toilette): 5-15%, 2-4 hours
- **EDP** (Eau de Parfum): 15-20%, 4-8 hours
- **Parfum** (Pure Perfume): 20-40%, 8-12+ hours
- **Oil** (Fragrance Oil): 15-100%, 12-24+ hours

## 🆘 Troubleshooting

**"App not installed" error:**
- Make sure you have enough storage space
- Try uninstalling any old version first
- Enable "Install from Unknown Sources"

**"Parse error":**
- The APK file may be corrupted during transfer
- Try transferring again

**App crashes on startup:**
- Make sure your Android version is 5.0 (Lollipop) or higher
- Try clearing app data and cache

## 🔄 Updating the App

To update to a newer version:
1. Build a new APK with an increased version number
2. Transfer and install the new APK
3. The old version will be automatically replaced

## 📞 Support

If you encounter any issues, rebuild the app with:
```bash
cd C:\Users\andyr\scent_wardrobe
flutter clean
flutter build apk --release
```

---

Enjoy your **Signature Scent Wardrobe**! 🌺✨
