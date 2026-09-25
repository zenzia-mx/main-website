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
- `favicon.png`, `favicon-32.png`

Brand colors: cream `#D7D5C4` (page tint `#E6E4D6`), deep green `#294B32`,
accent pink `#FF65C5`.

## Deploying

`.github/workflows/azure-static-web-apps.yml` uploads the repo root on every
push to `main`. Before the first deploy, set the workflow's
`azure_static_web_apps_api_token` to the secret name Azure generated for this
Static Web App — Azure normally commits its own workflow file when you link the
GitHub repo, in which case delete this one and keep Azure's.

`staticwebapp.config.json` sets caching and the navigation fallback.

## Editing copy

Each option is self-contained: `options/<name>/index.html` for the text,
`options/<name>/styles.css` for the look. Option 04 has a commented-out block
for Instagram and email — fill it in when those are confirmed. After editing an
option, re-run `./use-option.sh <name>` to push the change to the root.
