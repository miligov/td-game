#!/bin/bash
set -e
cd /home/user/td-game
cat src/00-head.html src/10-core.js src/20-data.js src/30-engine.js \
    src/40-render.js src/50-ui.js > index.html
node -e '
const fs=require("fs");
const h=fs.readFileSync("index.html","utf8");
const i=h.indexOf("<script>\n(function");
const j=h.lastIndexOf("</script>");
fs.writeFileSync("/tmp/tchk.js",h.slice(i+8,j));
'
node --check /tmp/tchk.js
echo "СБОРКА OK  $(du -h index.html | cut -f1)"
