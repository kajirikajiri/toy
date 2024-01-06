import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    browser: {
      enabled: true,
      name: 'chrome', // browser name is required
    },
    include: ['**/__integration__/*.{test,spec}.?(c|m)[jt]s?(x)']
  },
})
