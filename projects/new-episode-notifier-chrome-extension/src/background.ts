import { Background_ListScrapesGeneratedDocument } from "./gql/generated"
import { Background_ListScrapesDocument } from "./gql/graphql"

(async ()=>{
    console.log(Background_ListScrapesDocument)
    console.log(Background_ListScrapesGeneratedDocument.loc?.source.body)
    const a = await fetch("http://localhost:3000/graphql", {
        method: "POST",
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            operationName: Background_ListScrapesDocument.definitions.at(0)?.name?.value,
            query: Background_ListScrapesGeneratedDocument.loc?.source.body,
        }),
    })
    console.log(await a.json())
})()
