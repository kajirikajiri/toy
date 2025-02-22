import { GraphQLClient } from "graphql-request";
import { getSdk } from "./gql/generated"

const defaultClient = new GraphQLClient('http://localhost:3333/graphql')
export const sdk = getSdk(defaultClient)

type AlarmName = "periodic-scrape"

const periodicScrapeAlarm: AlarmName = "periodic-scrape"

chrome.alarms.create(periodicScrapeAlarm, {
    periodInMinutes: 0.5,
})

chrome.alarms.onAlarm.addListener(async (alarm) => {
    const alarmName = alarm.name as AlarmName
    console.debug("アラーム発火", alarmName)
    switch (alarmName) {
        case "periodic-scrape": {
            await periodicScrape()
            break
        }
        default: 
            return alarmName satisfies never
    }
})

const periodicScrape = async () => {
    const {getUnscrapedItem: scrape} =await sdk.background_getUnscrapedItem()
    if (!scrape) {
        console.debug("スクレイプするアイテムがありません")
        return
    }
    let tabId: number | undefined = undefined
    try {
      tabId = (await chrome.tabs.create({ url: scrape.url })).id
      if (typeof tabId !== "number") {
        console.debug("タブが作成できませんでした");
        return;
      }
      
      const isTabLoaded = await new Promise((resolve) => {
          setTimeout(() => {
                resolve(false)
          }, 3000)
        chrome.tabs.onUpdated.addListener(function listener(updatedTabId, changeInfo) {
          if (updatedTabId === tabId && changeInfo.status === "complete") {
            chrome.tabs.onUpdated.removeListener(listener);
            resolve(true);
          }
        });
      })
      
      if (!isTabLoaded) {
        console.debug("タブの読み込みが完了しませんでした")
        return
      }

      const [{ result: episodeCount }] = await chrome.scripting.executeScript({
        target: { tabId: tabId },
        args: [],
        func: () => {
          return document.querySelectorAll(
            "#tab-content-episodes [data-testid=download-button-IDLE]"
          ).length;
        },
      });
      if (episodeCount === undefined) {
        console.debug("エピソードが見つかりませんでした");
        return;
      }

      await sdk.background_updateScrapedData({
        input: {
          id: scrape.id,
          episodeCount,
        },
      });
    } finally {
      if (tabId) {
          try {
              await chrome.tabs.remove(tabId);
          } catch (e) {
              console.error("タブを閉じることができませんでした", e);
            }
      }
    }
}
