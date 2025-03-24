import { GraphQLClient } from "graphql-request";
import { getSdk } from "../generated"

const defaultClient = new GraphQLClient("http://localhost:3333/graphql");
export const sdk = getSdk(defaultClient);
type AlarmName = "periodic-scrape";
const periodicScrapeAlarm: AlarmName = "periodic-scrape";

export default defineBackground(() => {
  chrome.alarms.create(periodicScrapeAlarm, {
    periodInMinutes: 0.5,
  });

  chrome.alarms.onAlarm.addListener(async (alarm) => {
    const alarmName = alarm.name as AlarmName;
    console.debug("アラーム発火", alarmName);
    switch (alarmName) {
      case "periodic-scrape": {
        await periodicScrape();
        break;
      }
      default:
        return alarmName satisfies never;
    }
  });

  const periodicScrape = async () => {
    const { getUnexecutedAction: action } =
      await sdk.background_getUnexecutedAction();
    if (!action) {
      console.debug("スクレイプするアイテムがありません");
      return;
    }
    let tabId: number | undefined = undefined;
    try {
      tabId = (await chrome.tabs.create({ url: action.executable.url })).id;
      if (typeof tabId !== "number") {
        await sdk.background_updateVideoEpisodeCountMutation({
          input: {
            id: action.id,
            browserExtensionResult: 'failed_to_create_tab',
          },
        });
        return;
      }

      const isTabLoaded = await new Promise((resolve) => {
        setTimeout(() => {
          resolve(false);
        }, 3000);
        chrome.tabs.onUpdated.addListener(function listener(
          updatedTabId,
          changeInfo
        ) {
          if (updatedTabId === tabId && changeInfo.status === "complete") {
            chrome.tabs.onUpdated.removeListener(listener);
            resolve(true);
          }
        });
      });

      if (!isTabLoaded) {
        await sdk.background_updateVideoEpisodeCountMutation({
          input: {
            id: action.id,
            browserExtensionResult: 'failed_to_create_tab',
          },
        });
        return;
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
        await sdk.background_updateVideoEpisodeCountMutation({
          input: {
            id: action.id,
            browserExtensionResult: 'episode_not_found',
          },
        });
        return;
      }

      await sdk.background_updateVideoEpisodeCountMutation({
        input: {
          id: action.id,
          browserExtensionResult: 'episode_count_fetched',
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
  };
});
