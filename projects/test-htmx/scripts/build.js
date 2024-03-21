const fs = require('fs');
const path = require('path');
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const marked = require('marked');

const pre = fs.readFileSync('_posts/template_pre.html', 'utf8');
const suf = fs.readFileSync('_posts/template_suf.html', 'utf8');
let links = '';
const directoryPath = '_posts';
(async () => {
  const {stderr} = await exec('rm -rf dist');
  if (stderr) throw stderr;
  fs.mkdirSync('dist');
  const files = await fs.promises.readdir(directoryPath)
  files.forEach(file => {
    if (path.extname(file) !== '.md') return
    const fname = file.replace(/^.*\/|\..*$/g, '');
    links = links + `<a is='post-link' href='${fname}.html'>記事</a>`
    const markdown = fs.readFileSync(`_posts/${fname}.md`, 'utf8');
    const html = marked.parse(markdown);
    fs.writeFileSync(`dist/${fname}.html`, pre+html+suf);
  });
})();

