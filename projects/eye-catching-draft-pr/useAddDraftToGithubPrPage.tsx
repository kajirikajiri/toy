/**
 * Draft PR の場合に、レビュアー選択メニューに「draft」と表示する
 * github.comのPRページで使われる想定
 */
export const useAddDraftToGithubPrPage = () => {
  useEffect(() => {
    const reviewersSelectMenu = document.querySelector('[data-toggle-for="reviewers-select-menu"]')?.parentElement
    const isDraft = document.querySelector('[reviewable_state="draft"]')?.textContent?.trim() === 'Draft'
    if (isDraft) {
      const span = document.createElement('span')
      span.textContent = 'draft'
      span.style.fontWeight = 'bold'
      span.style.color = 'red'
      reviewersSelectMenu?.appendChild(span)
    }
  }, [])
}