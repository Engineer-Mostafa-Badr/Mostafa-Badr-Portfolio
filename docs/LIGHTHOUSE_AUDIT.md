# Lighthouse Audit — Manual Run

## Pre-flight

1. Build a release web bundle:
   ```bash
   flutter build web --release --wasm
   ```
2. Serve it locally (so the dev refresh banner doesn't pollute the score):
   ```bash
   npx serve build/web -l 5000
   ```
3. Open `http://localhost:5000` in **Chrome (latest)**, *Incognito* window.

## Run the audit

1. Open DevTools (F12) → **Lighthouse** tab.
2. Pick **Performance**, **Accessibility**, **Best Practices**, **SEO**, **PWA**.
3. Set device: **Mobile** for first pass, then **Desktop** for second.
4. Click *Analyze page load*.

## Target scores (after this round of improvements)

| Category | Target | Notes |
|---|---|---|
| Performance | ≥ 85 | Flutter web is heavy; WebP conversion ([WEBP_CONVERSION.md](WEBP_CONVERSION.md)) closes the gap |
| Accessibility | ≥ 95 | Material 3 + theme contrast + semantics labels |
| Best Practices | ≥ 95 | HTTPS, no console errors, image aspect ratios |
| SEO | 100 | meta tags + sitemap + robots + structured data are all set |
| PWA | 100 | manifest + icons + service worker are all set |

## Common issues + fixes

- **Render-blocking resources** → already addressed: `flutter_bootstrap.js` is `async`.
- **Image elements do not have explicit width and height** → Flutter renders to canvas, so this rule is N/A; safe to ignore.
- **Properly size images** → run the WebP conversion script.
- **Document does not have a meta description** → already present (in `web/index.html`).
- **Page has no <title>** → already present.
- **Page is not blocked from indexing** → ✅ (robots.txt allows all).
- **Has a viewport meta tag** → ✅ (added in this update).

## Track over time

Save the JSON export from each run under `docs/lighthouse-runs/` so you can spot regressions:

```bash
mkdir -p docs/lighthouse-runs
# Drop the exported JSON here with date stamp:
#   docs/lighthouse-runs/2026-05-28.json
```
