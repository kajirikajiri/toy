// github.comのPRページで使われる
const observer = new MutationObserver(() => {
  // マージボタンがスカッシュマージなら文字を赤色、マージなら白色にする。
  (() => {
    const spans = [...document.querySelectorAll('span[data-component="text"]')];
    for (const span of spans) {
      if (span.textContent.trim() === "Squash and merge") {
        span.style.color = "#f85149";
        break;
      } else if (span.textContent.trim() === "Merge pull request") {
        span.style.color = "#fff";
        break;
      }
    }
  })();

  // PullRequestがドラフトの場合に、レビュアー選択メニューを赤文字にする
  (() => {
    // レビュワー選択メニューの要素を取得
    const reviewersSelectMenu = [
      ...(document.querySelectorAll("summary")),
    ].find((summary) => summary.textContent.trim() === "Reviewers");
    if (!reviewersSelectMenu) return;

    // PRがドラフトかどうかを取得する
    const draftElement = document.querySelector('[reviewable_state="draft"]');
    const isDraft = draftElement && draftElement.textContent.trim() === "Draft";

    // PRがドラフトなら、レビュワー選択メニューを赤色にする
    reviewersSelectMenu.style.color = isDraft ? "#f85149" : "#9198a1";
  })();
});
observer.observe(document.body, { childList: true, subtree: true });
