import { gql } from '@apollo/client';
import * as Apollo from '@apollo/client';
const defaultOptions = {} as const;
export type Background_ListScrapesQueryVariables = Exact<{ [key: string]: never; }>;


export type Background_ListScrapesQuery = { __typename?: 'Query', listScrapes: Array<{ __typename?: 'Scrape', id: string }> };


export const Background_ListScrapesGeneratedDocument = gql`
    query background_listScrapes {
  listScrapes {
    id
  }
}
    `;

/**
 * __useBackground_ListScrapesQuery__
 *
 * To run a query within a React component, call `useBackground_ListScrapesQuery` and pass it any options that fit your needs.
 * When your component renders, `useBackground_ListScrapesQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useBackground_ListScrapesQuery({
 *   variables: {
 *   },
 * });
 */
export function useBackground_ListScrapesQuery(baseOptions?: Apollo.QueryHookOptions<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>(Background_ListScrapesGeneratedDocument, options);
      }
export function useBackground_ListScrapesLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>(Background_ListScrapesGeneratedDocument, options);
        }
export function useBackground_ListScrapesSuspenseQuery(baseOptions?: Apollo.SkipToken | Apollo.SuspenseQueryHookOptions<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>) {
          const options = baseOptions === Apollo.skipToken ? baseOptions : {...defaultOptions, ...baseOptions}
          return Apollo.useSuspenseQuery<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>(Background_ListScrapesGeneratedDocument, options);
        }
export type Background_ListScrapesQueryHookResult = ReturnType<typeof useBackground_ListScrapesQuery>;
export type Background_ListScrapesLazyQueryHookResult = ReturnType<typeof useBackground_ListScrapesLazyQuery>;
export type Background_ListScrapesSuspenseQueryHookResult = ReturnType<typeof useBackground_ListScrapesSuspenseQuery>;
export type Background_ListScrapesQueryResult = Apollo.QueryResult<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>;