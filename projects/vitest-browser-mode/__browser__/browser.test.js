import { expect, test } from 'vitest'

function createNode() {
  const div = document.createElement('div')
  div.textContent = 'Hello World'
  document.body.appendChild(div)
  return div
}

test('renders div', () => {
  const div = createNode()
  expect(div.textContent).toBe('Hello World')
})
