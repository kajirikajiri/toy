npm install marked

pre=$(cat _posts/template_pre.html)
suf=$(cat _posts/template_suf.html)
links=""
rm -rf dist
mkdir dist
for file in _posts/*.md; do
  fname=$(basename "$file" .md)
  links="$links<a is='post-link' href='$fname.html'>記事</a>"
  npx marked -i "_posts/${fname}.md" -o "dist/${fname}.html"
  html=$(cat dist/${fname}.html)
  echo "$pre$html$suf" > "dist/${fname}.html"
done

# localだといけるけど、cloudflareにはrsyncがない
# https://askubuntu.com/a/333641
#rsync -av --exclude='template_*.html' public/* dist/
cp -a public/ dist/ && find public/ -name 'template_*.html' -exec bash -c 'rm -rf dist/${1#public/}' _ {} \;

pre=$(cat public/template_pre.html)
suf=$(cat public/template_suf.html)
echo "$pre$links$suf" > dist/index.html

