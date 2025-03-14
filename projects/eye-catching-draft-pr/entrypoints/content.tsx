import ReactDOM from "react-dom/client";
import { ContentScriptGithubPrPage } from '../contentScript/githubPrPage'
export default defineContentScript({
  matches: ['https://github.com/*/*/pull/*'],
  main(ctx) {
    const ui = createIntegratedUi(ctx, {
      position: 'inline',
      anchor: 'body',
      onMount: (container) => {
        const root = ReactDOM.createRoot(container);
        root.render(<ContentScriptGithubPrPage />);
        return root;
      },
      onRemove: (root) => { root?.unmount() },
    })
    ui.mount();
  },
});
