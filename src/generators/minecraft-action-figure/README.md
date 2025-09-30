# Minecraft Action Figure Generator - 300 DPI Scaling Implementation

## Overview
This generator has been partially updated to support 300 DPI output (2480x3508 pixels) instead of the original 72 DPI (595x842 pixels). The core scaling infrastructure is complete, but some coordinate updates remain unfinished.

## ✅ Completed Sections

### Core Infrastructure
- **Scale Factor**: `scaleFactor = 2480.0 /. 595.0` (≈4.167)
- **Helper Functions**: `scale()` and `scaleFloat()` for coordinate conversion

### Fully Scaled Sections
- **Head section** (lines ~88-130): All 6 face textures
- **Neck section** (line ~133): Neck connection
- **Pelvis section** (lines ~136-142): Left and right pelvis
- **Body section** (lines ~150-170): Main body, hips, bottom
- **Arms - Alex model** (lines ~175-233): Left and right arms for Alex
- **Legs section** (lines ~297-344): Left and right legs
- **Helmet overlay** (lines ~349-400): All helmet textures
- **Jacket overlay** (lines ~404-417): Body jacket textures
- **Region inputs** (lines ~68-85): All clickable regions for hiding parts
- **Hand notches** (lines ~652-661): All notch positions

## ❌ Incomplete Sections

### Sleeve Overlays
**Location**: Lines ~421-542
**Alex Model Sleeves** (if alexModel && !hideLeftSleeve):
- Left sleeve coordinates (lines ~424-447)
- Right sleeve coordinates (lines ~452-477)

**Steve Model Sleeves** (else branch):
- Left sleeve coordinates (lines ~481-512)
- Right sleeve coordinates (lines ~515-541)

**Pattern to apply**:
```rescript
// Before:
{x: 329, y: 338, w: 24, h: 32}

// After:
{x: scale(329), y: scale(338), w: scale(24), h: scale(32)}
```

### Arms - Steve Model
**Location**: Lines ~234-293
**Steve Model Arms** (else branch from Alex):
- Left arm coordinates (lines ~235-258)
- Right arm coordinates (lines ~261-285)

### Pants Overlays
**Location**: Lines ~545-625
**Left Pants** (if !hideLeftPant):
- Left pelvis pant (line ~549)
- Left leg pant coordinates (lines ~554-586)

**Right Pants** (if !hideRightPant):
- Right pelvis pant (line ~593)
- Right leg pant coordinates (lines ~598-624)

## 🔧 How to Complete

### Pattern for Updates
All destination coordinates in `Generator.drawTextureLegacy` calls need to be wrapped with `scale()`:

```rescript
// Find lines like this:
Generator.drawTextureLegacy(
  "Skin",
  {x: 48, y: 48, w: 11, h: 16},        // Source coordinates - DON'T change
  {x: 297, y: 211, w: 88, h: 128},     // Destination coordinates - SCALE these
  (),
)

// Update to:
Generator.drawTextureLegacy(
  "Skin",
  {x: 48, y: 48, w: 11, h: 16},        // Source coordinates - unchanged
  {x: scale(297), y: scale(211), w: scale(88), h: scale(128)}, // Destination coordinates - scaled
  (),
)
```

### Search Strategy
Use these search patterns to find remaining unscaled coordinates:
- `{x: [0-9]{2,3}, y: [0-9]{2,3}, w: [0-9]{1,3}, h: [0-9]{1,3}}` (destination coordinates with 2-3 digit numbers)
- Look for `drawTextureLegacy` calls that don't have `scale(` in the destination coordinates

## 📋 Verification Steps
1. Search for `drawTextureLegacy` calls without `scale(` in destination coordinates
2. Count total `drawTextureLegacy` calls: should be 76
3. Count `scale(` calls: should eventually match the number of destination coordinate sets
4. Test generator output to ensure proper sizing at 300 DPI

## 🖼️ Background Images
The background images (Backgroundalex.png, Backgroundsteve.png, etc.) also need to be updated from 595x842 to 2480x3508 pixels to match the new canvas size.

## 📝 Current Status
- **Estimated completion**: ~70% of coordinates scaled
- **Critical sections**: ✅ Complete (head, body, legs, regions)
- **Remaining**: Sleeve and pants overlay details
- **Impact**: Generator works for main structure, overlays may be mispositioned

## 🚀 Next Steps
1. Complete sleeve coordinate scaling (Alex and Steve models)
2. Complete pants overlay coordinate scaling
3. Update background images to 2480x3508 resolution
4. Test complete generator functionality
5. Verify all interactive regions work correctly