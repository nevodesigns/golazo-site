#!/usr/bin/env bash
#
# Cache-busting stamp for the static assets referenced from public/index.html.
#
# The CDN caches CSS/JS aggressively (long max-age). Since the filenames never
# change (styles.css, script.js), a fresh deploy would otherwise keep serving a
# stale asset. This rewrites the `?v=...` query string on those links to the
# current git short SHA, so every deploy that carries a new commit serves a new
# URL and the CDN treats it as a fresh object.
#
# Run automatically by `npm run deploy` before the Pxxl upload. Safe to run by
# hand too. It only edits public/index.html; commit that change or let the next
# deploy re-stamp it.
#
set -euo pipefail
cd "$(dirname "$0")"

SHA="$(git rev-parse --short HEAD 2>/dev/null || echo dev)"
INDEX="public/index.html"

# Assets that carry a ?v= stamp. favicon files are new URLs already, but stamping
# them keeps the whole set on one version so a hard refresh clears everything.
sed -i -E \
  "s/(styles\.css|script\.js|favicon\.ico|favicon-512\.png|apple-touch-icon\.png)\?v=[A-Za-z0-9._-]+/\1?v=${SHA}/g" \
  "$INDEX"

echo "bump-cache: stamped ?v=${SHA} in ${INDEX}"
