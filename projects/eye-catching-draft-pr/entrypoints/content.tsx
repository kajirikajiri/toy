import ReactDOM from "react-dom/client";
import { GithubPrPageMain } from '../GithubPrPageMain'
export default defineContentScript({
  matches: ['https://github.com/*/*/pull/*'],
  runAt: 'document_idle',
  main(ctx) {
    const ui = createIntegratedUi(ctx, {
      position: 'inline',
      anchor: 'body',
      onMount: (container) => {
        const root = ReactDOM.createRoot(container);
        root.render(<GithubPrPageMain />);
        return root;
      },
      onRemove: (root) => { root?.unmount() },
    })
    ui.mount();
  },
});
