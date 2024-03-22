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
      div.style.padding = "8px"
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

customElements.define('post-link', class extends HTMLAnchorElement {
  connectedCallback() {
    // https://stackoverflow.com/a/53813523
    setTimeout(() => {
      const text = this.innerHTML
      this.innerHTML = ""

      const outer = document.createElement('div')
      outer.style.marginBottom = "48px"
      this.appendChild(outer)

      const title = document.createElement('div')
      title.innerHTML = text
      title.style.marginBottom = "8px"
      title.style.fontSize = "16px"
      outer.appendChild(title)

      const excerpt = document.createElement('div')
      excerpt.innerHTML = this.getAttribute('excerpt')
      outer.appendChild(excerpt)

      const date = document.createElement('div')
      date.innerHTML = this.getAttribute('date')
      outer.appendChild(date)
    })
  }
}, { extends: 'a' });

customElements.define('blog-name', class extends HTMLAnchorElement {
  connectedCallback() {
    // https://stackoverflow.com/a/53813523
    setTimeout(() => {
      this.innerHTML = "かじりブログ"
      this.style.fontSize = "32px"
      this.style.color = "#333333"
    })
  }
}, { extends: 'a' });

customElements.define('blog-author', class extends HTMLAnchorElement {
  connectedCallback() {
    // https://stackoverflow.com/a/53813523
    setTimeout(() => {
      this.innerHTML = ""
      this.style.color = "#9E9E9E"

      const div = document.createElement('div')
      div.innerHTML = "著: 中村 一貴(かじり)"
      div.style.textAlign = "end"
      div.style.fontSize = "12px"
      this.appendChild(div)
    })
  }
}, { extends: 'a' });


