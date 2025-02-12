import { DocumentNode } from "graphql"
import { Background_ListScrapesDocument, Background_ListScrapesQuery, Background_ListScrapesQueryResult, Background_ListScrapesQueryVariables } from "./gql/generated"
import { OperationVariables, QueryResult, TypedDocumentNode } from "@apollo/client"

const extractRequestBodyFromDocument = (document: DocumentNode) => {
    const operationName = (document.definitions.at(0) as ({name?: {value?: string}} | undefined))?.name?.value
    const query = document.loc?.source.body
    if (!operationName || !query) {
        throw new Error("Document is missing operationName or query")
    }
    return {
        operationName,
        query,
    }
}

const gqlRequest =  async <
  TData = any, // eslint-disable-line @typescript-eslint/no-explicit-any
  TVariables extends OperationVariables = OperationVariables>(query: DocumentNode | TypedDocumentNode<TData, OperationVariables>): Promise<QueryResult<TData, TVariables>> => { 
    const r = await fetch("http://localhost:3000/graphql", {
    method: "POST",
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(extractRequestBodyFromDocument(query)),
    })
    const json = await r.json()
    return json
}

(async ()=>{
    const r = await gqlRequest<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>(Background_ListScrapesDocument)
    console.log(await r)
})()

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
    const r = await gqlRequest(Background_ListScrapesDocument);
    console.log(await r.json());
}

const a: Background_ListScrapesQueryResult = {
    data: {
        listScrapes: [{}]
    }
}

