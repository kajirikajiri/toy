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
      div.style.border = "1px solid #e1e4e8"
      div.style.borderRadius = "4px"
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
      outer.style.margin = "8px 0px"
      outer.style.padding = "8px"
      outer.style.border = "1px solid #e1e4e8"
      outer.style.borderRadius = "4px"
      this.appendChild(outer)
      const title = document.createElement('div')
      title.innerHTML = text
      outer.appendChild(title)
      const excerpt = document.createElement('div')
      excerpt.innerHTML = this.getAttribute('excerpt')
      outer.appendChild(excerpt)
    })
  }
}, { extends: 'a' });
