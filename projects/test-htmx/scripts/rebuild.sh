fname=$(basename "$1" .md)
pre=$(<_posts/template_pre.html)
suf=$(<_posts/template_suf.html)
npx marked -i "_posts/${fname}.md" -o "dist/${fname}.html"
html=$(cat dist/${fname}.html)
echo "$pre$html$suf" > "dist/${fname}.html"

