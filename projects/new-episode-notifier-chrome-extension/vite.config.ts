import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { crx } from '@crxjs/vite-plugin'

// https://vite.dev/config/
export default defineConfig({
  /**
   * 一時的な対応
   * https://github.com/crxjs/chrome-extension-tools/issues/971#issuecomment-2605520184
   */
  legacy: {
    skipWebSocketTokenCheck: true,
  },
  server: {
    port: 5168,
    strictPort: true,
  },
  plugins: [
    react(),
    crx({ manifest: {
        manifest_version: 3,
        name: "CRXJS React Vite Example",
        version: "1.0.0",
        action: { "default_popup": "index.html" },
        background: { service_worker: "src/background.ts", type: 'module' },
        host_permissions: ["<all_urls>"],
        permissions: ["alarms", "scripting"]
    } }),
  ],
})
