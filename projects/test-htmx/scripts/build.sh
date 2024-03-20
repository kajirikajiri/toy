npm install marked

pre=$(cat _posts/template_pre.html)
suf=$(cat _posts/template_suf.html)
links=""
rm -rf dist
mkdir dist
for file in _posts/*.md; do
  fname=$(basename "$file" .md)
  links="$links<a is='post_link' href='$fname.html'>記事</a>"
  npx marked -i "_posts/${fname}.md" -o "dist/${fname}.html"
  html=$(cat dist/${fname}.html)
  echo "$pre$html$suf" > "dist/${fname}.html"
done

cp -r public/* dist/

pre=$(cat public/template_pre.html)
suf=$(cat public/template_suf.html)
echo "$pre$links$suf" > dist/index.html

