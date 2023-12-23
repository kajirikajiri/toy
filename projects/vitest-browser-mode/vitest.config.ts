import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    include: ['**/__test__/*.{test,spec}.?(c|m)[jt]s?(x)']
  },
})
