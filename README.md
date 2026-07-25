# golazo-site

Landing site for Golazo, an agent-payable World Cup 2026 data API on Injective.

**Live site:** https://golazo.pxxl.run/
**Project repo:** https://github.com/nevodesigns/golazo

Static site deployed on Pxxl at https://golazo.pxxl.run/.

## Deploying and cache busting

The site is served from `public/`. Deploy with `npm run deploy`, which runs
`bump-cache.sh` and then `pxxl deploy`. `bump-cache.sh` rewrites the `?v=...`
query string on the `styles.css`, `script.js`, and favicon links in
`public/index.html` to the current git short SHA, so each deploy that carries a
new commit serves a fresh asset URL that the CDN cannot satisfy from its cache.
As a backstop, `serve.json` caps `Cache-Control` on `.css` and `.js` at
`max-age=300, must-revalidate` (five minutes) instead of the default one-year
`immutable`, so even if the version stamp is ever skipped a stale asset clears
within five minutes. HTML is not cached by the CDN, so the new `index.html`
(with the new `?v=`) always goes live immediately. If you deploy from the Pxxl
CLI the stamp lands in the uploaded archive; if you switch to git-push
auto-deploy, commit the stamped `index.html` so the pushed copy carries it.
