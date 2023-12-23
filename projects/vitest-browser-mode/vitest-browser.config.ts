import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    browser: {
      enabled: true,
      name: 'chrome', // browser name is required
    },
    include: ['**/__browser__/*.{test,spec}.?(c|m)[jt]s?(x)']
  }
})

