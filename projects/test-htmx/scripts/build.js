const path = require('path');
const fs = require('fs-extra');
const fm = require('front-matter');
const marked = require('marked');
let pre = fs.readFileSync('_posts/template_pre.html', 'utf8');
let suf = fs.readFileSync('_posts/template_suf.html', 'utf8');
let links = '';
const directoryPath = '_posts';
(async () => {
  fs.rmSync('dist', { recursive: true, force: true });
  fs.mkdirSync('dist');
  fs.readdirSync(directoryPath).forEach(file => {
    if (path.extname(file) !== '.md') return
    const fname = file.replace(/^.*\/|\..*$/g, '');
    const markdown = fs.readFileSync(`_posts/${fname}.md`, 'utf8');
    const { attributes, body } = fm(markdown);
    links = links + `<a is='post-link' href='${fname}.html' excerpt='${attributes.excerpt}'>${attributes.title || '無名'}</a>`
    const html = marked.parse(body);
    fs.writeFileSync(`dist/${fname}.html`, pre+html+suf);
  });
  fs.copy('public', 'dist', {
    recursive: true,
    overwrite: true,
    filter: (src) => !path.basename(src).match(/^template_.*\.html$/),
  })
  pre = fs.readFileSync('public/template_pre.html', 'utf8');
  suf = fs.readFileSync('public/template_suf.html', 'utf8');
  fs.writeFileSync('dist/index.html', pre+links+suf);
})();

