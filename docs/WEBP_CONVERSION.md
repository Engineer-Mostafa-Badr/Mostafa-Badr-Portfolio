# Image Optimization — PNG → WebP

The portfolio currently ships project screenshots as PNG files. WebP is ~30-50% smaller at the same visual quality and is supported by every modern browser.

## Why convert?

| Project | PNGs | Total |
|---|---|---|
| Hajj | 8 screenshots + 1 cover | ~5 MB |
| Saqqar | 4 screenshots + 1 cover | ~2 MB |
| Visits | 5 screenshots + 1 cover | ~3 MB |
| HR | 6 screenshots + 1 cover | ~3 MB |
| FortyNine | 7 screenshots + 1 cover | ~3 MB |
| Alawaly | 5 screenshots + 1 cover | ~3 MB |
| Captain Drive | 6 screenshots + 1 cover | ~3 MB |
| E-commerce | 6 screenshots + 1 cover | ~2 MB |

Converting all of them to WebP saves ~8-12 MB of initial download.

## Convert in PowerShell (cwebp)

1. Install `cwebp` (via `winget`):
   ```powershell
   winget install Google.WebPCodec
   ```
2. From the project root, run:
   ```powershell
   Get-ChildItem -Recurse -Include *.png assets/images | ForEach-Object {
     $out = $_.FullName -replace '\.png$','.webp'
     cwebp -q 82 -m 6 -mt $_.FullName -o $out
   }
   ```
3. Update `pubspec.yaml` to ship the `.webp` files (they're already in the assets folders, so no change needed).
4. Update the asset paths in [`lib/data/projects_data.dart`](../lib/data/projects_data.dart) — bulk replace `.png` → `.webp`.
5. Delete the original `.png` files (or keep them as fallback).

## Convert in Bash / Git Bash

```bash
find assets/images -name "*.png" -exec sh -c 'cwebp -q 82 -m 6 "$1" -o "${1%.png}.webp"' _ {} \;
```

## Quick sanity check

- Run `flutter run -d chrome --profile` after conversion.
- Open DevTools → Network → filter by `webp` and confirm the new files load.
- Lighthouse Performance score should jump by 10-20 points.

## When NOT to convert

- Keep the **profile photo** (`assets/images/my_photo/5564545.png`) as PNG if it has transparency — cwebp preserves alpha but some Flutter web canvas paths render WebP slower than PNG for tiny images.
- Keep the **OG image** (`web/og-image.png`) as PNG — social platforms historically prefer PNG/JPG over WebP for OG cards.
