# Zenzia · main-website

Static "coming soon" placeholder for **Zenzia · Barra de infusiones**, deployed to
Azure Static Web Apps. No build step, no dependencies — plain HTML and CSS.

## Choosing a design

Five placeholder designs live in `options/`. Compare them side by side:

```bash
python3 -m http.server 8080
# then open http://localhost:8080/preview.html
```

| Option | Look |
| --- | --- |
| `01-serena` | Cream, minimal, still. The safest default. |
| `02-nocturna` | Deep green field, light logo, pink hairline. |
| `03-ondas` | Cream, with water rings rippling out of the logo. |
| `04-editorial` | Logo beside a short paragraph; two columns on desktop. |
| `05-vapor` | Dark, with slow drifting steam behind the logo. |

Publish the one you pick:

```bash
./use-option.sh 03          # by number, or: ./use-option.sh 03-ondas
git commit -am "Use the Ondas placeholder" && git push
```

The script copies that option's `index.html` and `styles.css` to the repo root
and rewrites the asset paths. **The root `index.html` is what Azure serves** —
currently `01-serena`. Everything in `options/` stays deployed too, so each
design is reachable at e.g. `/options/03-ondas/`; delete the folder once the
choice is final if you'd rather they not be public.

## Assets

`assets/` holds the logo pulled from the kiosk artwork and cut out with a
transparent background:

- `zenzia-logo.png` — full lockup, deep green (`#294B32`), for light backgrounds
- `zenzia-logo-light.png` — same lockup in cream, for dark backgrounds
- `zenzia-mark.png` / `zenzia-mark-light.png` — leaf and ripples only, no wordmark
- `favicon.svg` — the leaf alone, green on a light browser theme and cream on a
  dark one (a `prefers-color-scheme` rule inside the SVG). The veins are knocked
  out of a filled leaf so the shape still holds together at 16px, where the
  original line art turns to mush.
- `favicon-32.png` — green fallback for anything that won't take an SVG icon
- `apple-touch-icon.png` — 180px, cream leaf on deep green (iOS needs it opaque)

Brand colors: cream `#D7D5C4` (page tint `#E6E4D6`), deep green `#294B32`,
accent pink `#FF65C5`.

## Deploying

Azure's own workflow —
`.github/workflows/azure-static-web-apps-delightful-ground-07edb7b0f.yml` —
uploads the repo root on every push to `main`. It was generated when the
Static Web App was linked to this repo and already carries the right
deployment-token secret, so it needs no edits. Don't add a second workflow
alongside it: a hand-written one won't have that secret and the job fails with
`deployment_token was not provided`.

| | |
| --- | --- |
| Resource | `main-website` in resource group `zenzia` |
| Subscription | Pay-As-You-Go |
| URL | https://delightful-ground-07edb7b0f.4.azurestaticapps.net |

`staticwebapp.config.json` sets caching and the navigation fallback.

## Editing copy

Each option is self-contained: `options/<name>/index.html` for the text,
`options/<name>/styles.css` for the look. Option 04 has a commented-out block
for Instagram and email — fill it in when those are confirmed. After editing an
option, re-run `./use-option.sh <name>` to push the change to the root.
