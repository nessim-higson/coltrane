#!/bin/bash
# snapshot.sh <name> [commit] — freeze the builds at a commit into versions/<name>/.
# Copies HTML + js only; the imagery pool (assets/) stays shared via the
# UQ_ASSET_ROOT override, so each snapshot costs kilobytes, not 9MB.
set -e
name=$1; commit=${2:-HEAD}
[ -z "$name" ] && { echo "usage: ./snapshot.sh <name> [commit]"; exit 1; }
dir="versions/$name"
rm -rf "$dir"; mkdir -p "$dir"
git archive "$commit" -- breathe refine index.html js | tar -x -C "$dir"

# inject the asset-root override so snapshots load the live /assets pool
python3 - "$dir" <<'EOF'
import sys, pathlib
root = pathlib.Path(sys.argv[1])
inject = '<script>window.UQ_ASSET_ROOT = location.origin + location.pathname.replace(/versions\\/.*$/, "");</script>\n'
for f in root.rglob('*.html'):
    s = f.read_text()
    i = s.find('<script type="module"')
    if i >= 0 and 'UQ_ASSET_ROOT' not in s:
        f.write_text(s[:i] + inject + s[i:])
EOF

# regenerate the versions index — newest first, each links to its hub
{
  echo '<!DOCTYPE html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"><meta http-equiv="Pragma" content="no-cache"><meta http-equiv="Expires" content="0"><title>COLTRANE — versions</title><style>body{background:#0a0a0a;color:#fff;font-family:"Helvetica Neue",Helvetica,sans-serif;padding:12vh 8vw}h1{font-size:13px;letter-spacing:.3em;margin-bottom:6vh;font-weight:700}a.v{display:block;color:#fff;text-decoration:none;font-size:30px;font-weight:700;padding:14px 0;border-top:1px solid #232323;transition:color .15s,padding-left .15s}a.v:hover{color:#ffd23e;padding-left:12px}p{margin-top:5vh;font-size:12px;opacity:.4;line-height:1.7}p a{color:#fff}</style></head><body><h1>COLTRANE — VERSIONS</h1>'
  for d in $(ls -d versions/*/ 2>/dev/null | sort -rV); do
    v=$(basename "$d"); echo "<a class=\"v\" href=\"$v/\">$v</a>"
  done
  echo '<p>each version is the two builds frozen as html+js, sharing the live asset pool. newest first. current work: <a href="../">coltrane</a>.</p></body></html>'
} > versions/index.html
echo "frozen: $dir ($(du -sh "$dir" | cut -f1))"
