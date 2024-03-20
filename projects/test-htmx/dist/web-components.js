//https://stackoverflow.com/questions/70201172/this-getattribute-not-working-in-web-component-while-violating-the-spec

customElements.define('hello-element', class extends HTMLElement {
  connectedCallback() {
    this.textContent = `${this.getAttribute('title')}`;
  }
})



