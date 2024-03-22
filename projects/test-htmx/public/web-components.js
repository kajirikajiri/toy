//https://stackoverflow.com/questions/70201172/this-getattribute-not-working-in-web-component-while-violating-the-spec

customElements.define('my-link', class extends HTMLAnchorElement {
  connectedCallback() {
    // https://stackoverflow.com/a/53813523
    setTimeout(() => {
      const text = this.innerHTML
      this.innerHTML = ""

      const div = document.createElement('div')
      div.innerHTML = text
      div.style.margin = "8px 0px"
      div.style.padding = "8px 0px"
      this.appendChild(div)
    })
  }
}, { extends: 'a' });

customElements.define('hint-box', class extends HTMLDivElement {
  connectedCallback() {
     https://stackoverflow.com/a/53813523
    setTimeout(() => {
      this.style.margin = "8px 0px"
      this.style.padding = "8px"
      this.style.border = "1px solid #e1e4e8"
      this.style.borderRadius = "4px"
    })
  }
}, {extends: 'div'});

customElements.define('post-link', class extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
  }

  connectedCallback() {
    setTimeout(() => {
    this.shadowRoot.innerHTML = `
      <style>
        a {
          text-decoration: none;
        }

        a:hover {
          text-decoration: underline;
        }
      </style>
    `;

    const text = this.innerHTML
    this.innerHTML = ""

    const outer = document.createElement('a')
    outer.href = this.getAttribute('href')
    this.shadowRoot.appendChild(outer)

    const title = document.createElement('div')
    title.innerHTML = text
    title.style.marginBottom = "8px"
    outer.appendChild(title)

    const excerpt = document.createElement('div')
    excerpt.innerHTML = this.getAttribute('excerpt')
    excerpt.style.fontSize = "14px"
    outer.appendChild(excerpt)

    const date = document.createElement('div')
    date.innerHTML = this.getAttribute('date')
    date.style.fontSize = "14px"
    outer.appendChild(date)

    const pad = document.createElement('div')
    pad.style.marginBottom = "48px"
    outer.appendChild(pad)
    })
  }
});

customElements.define('blog-name', class extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
  }

  connectedCallback() {
    this.shadowRoot.innerHTML = `
      <style>
        a {
          text-decoration: none;
        }

        a:hover {
          text-decoration: underline;
        }
      </style>
    `;
    const div = document.createElement('div')
    this.shadowRoot.appendChild(div);

    const a = document.createElement('a');
    a.style.color = "#333333"
    a.style.fontSize = "32px"
    a.href = this.getAttribute('href')
    a.innerHTML = "かじりブログ"
    div.appendChild(a)
  }
});

customElements.define('blog-author', class extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
  }

  connectedCallback() {
    this.shadowRoot.innerHTML = `
      <style>
        a {
          text-decoration: none;
        }

        a:hover {
          text-decoration: underline;
        }
      </style>
    `;
    const div = document.createElement('div')
    div.style.textAlign = "end"
    this.shadowRoot.appendChild(div);

    const a = document.createElement('a');
    a.style.color = "#9E9E9E"
    a.style.padding = "8px 0px"
    a.style.fontSize = "12px"
    a.href = this.getAttribute('href')
    a.innerHTML = "著: 中村 一貴(かじり)"
    div.appendChild(a)
  }
});

