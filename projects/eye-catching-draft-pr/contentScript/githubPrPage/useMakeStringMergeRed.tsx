/**
 * github.comのPRページで使われる想定
 * Squash mergeの場合にSquashを赤文字にする
 */
export const useContentScriptGithubPrPageMakeStringMergeRed = () => {
  useEffect(() => {
    const observer = new MutationObserver(() => {
      const squashMergeSpan = [...document.querySelectorAll('span')].find(span => span.textContent?.trim() === 'Squash and merge')
      if (squashMergeSpan) {
        squashMergeSpan.style.color = '#f85149'
        return
      }
      const mergeSpan = [...document.querySelectorAll('span')].find(span => span.textContent?.trim() === 'Merge pull request')
      if (!mergeSpan) return

      mergeSpan.style.color = '#fff'
    })
    observer.observe(document.body, { childList: true, subtree: true })
    return () => observer.disconnect()
  }, [])
  }