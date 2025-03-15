import { defineConfig } from 'wxt';

// See https://wxt.dev/api/config.html
export default defineConfig({
  extensionApi: 'chrome',
  modules: ['@wxt-dev/module-react'],
  manifest: {
    permissions: ['alarms', 'scripting'],
  },
  runner: {
    chromiumArgs: ['--user-data-dir=./.wxt/chrome-data'],
  },
});
