npm install marked

pre=$(cat _posts/template_pre.html)
suf=$(cat _posts/template_suf.html)
rm -rf dist
mkdir dist
for file in _posts/*.md; do
  fname=$(basename "$file" .md)
  npx marked -i "_posts/${fname}.md" -o "dist/${fname}.html"
  html=$(cat dist/${fname}.html)
  echo "$pre$html$suf" > "dist/${fname}.html"
done
cp -r public/* dist/

