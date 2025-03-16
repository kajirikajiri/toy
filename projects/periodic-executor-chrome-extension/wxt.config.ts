import { defineConfig } from 'wxt';

// See https://wxt.dev/api/config.html
export default defineConfig({
  extensionApi: 'chrome',
  modules: ['@wxt-dev/module-react'],
  manifest: {
    permissions: ['alarms', 'scripting'],
    host_permissions: ["<all_urls>"],
  },
  runner: {
    chromiumArgs: ['--user-data-dir=./.wxt/chrome-data'],
  },
});
