/**
 * github.comのPRページで使われる想定
 * Draft PR の場合にレビュアー選択メニューを赤文字にする
 */
export const useContentScriptGithubPrPageMakeStringReviewersRed = () => {
  useEffect(() => {
    const observer = new MutationObserver(() => {
      const reviewersSelectMenu = [...document.querySelectorAll<HTMLElement>('summary')].find(summary => summary.textContent?.trim() === 'Reviewers')
      if (!reviewersSelectMenu) return

      const isDraft = document.querySelector('[reviewable_state="draft"]')?.textContent?.trim() === 'Draft'
      reviewersSelectMenu.style.color = isDraft ? '#f85149' : '#9198a1'
    })
    observer.observe(document.body, { childList: true, subtree: true })
    return () => observer.disconnect()
  }, [])
}