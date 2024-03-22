const path = require('path');
const fs = require('fs-extra');
const fm = require('front-matter');
const marked = require('marked');
let pre = fs.readFileSync('_posts/template_pre.html', 'utf8');
let suf = fs.readFileSync('_posts/template_suf.html', 'utf8');
const links = []
const directoryPath = '_posts';
(async () => {
  fs.rmSync('dist', { recursive: true, force: true });
  fs.mkdirSync('dist');
  fs.readdirSync(directoryPath).forEach(file => {
    if (path.extname(file) !== '.md') return
    // file名から拡張子を除いた部分を取得してmdとして読み込む
    const fname = file.replace(/^.*\/|\..*$/g, '');
    const markdown = fs.readFileSync(`_posts/${fname}.md`, 'utf8');

    // front-matterを取得
    const { attributes, body } = fm(markdown);

    // rootページに追加する各ページへのリンクを作成
    links.push([attributes.created_at,`<a is='post-link' href='${fname}.html' excerpt='${attributes.excerpt}' date='${new Date(attributes.created_at).toISOString().split('T')[0].replace(/-/g, '/')}'>${attributes.title}</a>`]);

    // titleをh1に変換して追加
    const html = marked.parse("# "+attributes.title+"<div style='margin-top:4px;text-align:end;font-size:12px;color: #9E9E9E;'>著: 中村 一貴(かじり)</div>\n"+""+"\n"+body);
    fs.writeFileSync(`dist/${fname}.html`, pre+html+suf);
  });
  fs.copy('public', 'dist', {
    recursive: true,
    overwrite: true,
    filter: (src) => !path.basename(src).match(/^template_.*\.html$/),
  })
  links.sort((a,b)=>a[0]<b[0]?1:-1);
  pre = fs.readFileSync('public/template_pre.html', 'utf8');
  suf = fs.readFileSync('public/template_suf.html', 'utf8');
  fs.writeFileSync('dist/index.html', pre+links.map(l=>l[1]).join('<br>')+suf);
})();

