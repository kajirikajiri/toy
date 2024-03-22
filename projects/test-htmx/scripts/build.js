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

    const convertDate = (str) => new Date(str).toISOString().split('T')[0].replace(/-/g, '/')
    // rootページに追加する各ページへのリンクを作成
    links.push([attributes.updated_at,`<post-link href='${fname}.html' excerpt='${attributes.excerpt}' date='${convertDate(attributes.updated_at)}'>${attributes.title}</post-link>`]);

    // titleをh1に変換して追加
    const html = marked.parse("# "+attributes.title+"\n"+"<div style='text-align:end; color:#9E9E9E;font-size:12px;margin-bottom:16px;'>更新: "+convertDate(attributes.updated_at)+", 作成: "+convertDate(attributes.created_at)+"</div>"+"\n\n"+body);
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

