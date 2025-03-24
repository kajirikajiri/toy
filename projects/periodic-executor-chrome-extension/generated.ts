import { GraphQLClient, RequestOptions } from 'graphql-request';
import gql from 'graphql-tag';
export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
type GraphQLClientRequestHeaders = RequestOptions['requestHeaders'];
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
  ISO8601DateTime: { input: any; output: any; }
  JSON: { input: any; output: any; }
};

export type Action = {
  __typename?: 'Action';
  browserExtensionResult: ActionBrowserExtensionResult;
  completedAt?: Maybe<Scalars['ISO8601DateTime']['output']>;
  createdAt: Scalars['ISO8601DateTime']['output'];
  executable: Executable;
  executableType: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  log?: Maybe<Scalars['JSON']['output']>;
  pattern: ActionPattern;
  result: ActionResult;
  status: ActionStatus;
  updatedAt: Scalars['ISO8601DateTime']['output'];
};

export type ActionBrowserExtensionResult =
  | 'episode_count_fetched'
  | 'episode_not_found'
  | 'failed_to_create_tab'
  | 'tab_loading_not_completed';

export type ActionBrowserExtensionResultInput =
  | 'episode_count_fetched'
  | 'episode_not_found'
  | 'failed_to_create_tab'
  | 'tab_loading_not_completed';

export type ActionPattern =
  | 'update_video_episode_count';

export type ActionResult =
  | 'failed_episode_count_not_updated'
  | 'success_episode_count_updated';

export type ActionStatus =
  | 'completed'
  | 'failed'
  | 'pending';

export type Executable = Video;

export type Mutation = {
  __typename?: 'Mutation';
  updateVideoEpisodeCount?: Maybe<UpdateVideoEpisodeCountMutationPayload>;
};


export type MutationUpdateVideoEpisodeCountArgs = {
  input: UpdateVideoEpisodeCountMutationInput;
};

export type Query = {
  __typename?: 'Query';
  getUnexecutedAction?: Maybe<Action>;
};

/** Autogenerated input type of UpdateVideoEpisodeCountMutation */
export type UpdateVideoEpisodeCountMutationInput = {
  browserExtensionResult: ActionBrowserExtensionResultInput;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: InputMaybe<Scalars['String']['input']>;
  episodeCount?: InputMaybe<Scalars['Int']['input']>;
  id: Scalars['ID']['input'];
};

/** Autogenerated return type of UpdateVideoEpisodeCountMutation. */
export type UpdateVideoEpisodeCountMutationPayload = {
  __typename?: 'UpdateVideoEpisodeCountMutationPayload';
  action: Action;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']['output']>;
};

export type Video = {
  __typename?: 'Video';
  episodeCount?: Maybe<Scalars['Int']['output']>;
  id: Scalars['ID']['output'];
  url: Scalars['String']['output'];
};

export type Background_GetUnexecutedActionQueryVariables = Exact<{ [key: string]: never; }>;


export type Background_GetUnexecutedActionQuery = { __typename?: 'Query', getUnexecutedAction?: { __typename?: 'Action', id: string, executable: { __typename?: 'Video', id: string, url: string } } | null };

export type Background_UpdateVideoEpisodeCountMutationMutationVariables = Exact<{
  input: UpdateVideoEpisodeCountMutationInput;
}>;


export type Background_UpdateVideoEpisodeCountMutationMutation = { __typename?: 'Mutation', updateVideoEpisodeCount?: { __typename?: 'UpdateVideoEpisodeCountMutationPayload', action: { __typename?: 'Action', id: string, executable: { __typename?: 'Video', id: string } } } | null };


export const Background_GetUnexecutedActionDocument = gql`
    query background_getUnexecutedAction {
  getUnexecutedAction {
    id
    executable {
      ... on Video {
        id
        url
      }
    }
  }
}
    `;
export const Background_UpdateVideoEpisodeCountMutationDocument = gql`
    mutation background_updateVideoEpisodeCountMutation($input: UpdateVideoEpisodeCountMutationInput!) {
  updateVideoEpisodeCount(input: $input) {
    action {
      id
      executable {
        ... on Video {
          id
        }
      }
    }
  }
}
    `;

export type SdkFunctionWrapper = <T>(action: (requestHeaders?:Record<string, string>) => Promise<T>, operationName: string, operationType?: string, variables?: any) => Promise<T>;


const defaultWrapper: SdkFunctionWrapper = (action, _operationName, _operationType, _variables) => action();

export function getSdk(client: GraphQLClient, withWrapper: SdkFunctionWrapper = defaultWrapper) {
  return {
    background_getUnexecutedAction(variables?: Background_GetUnexecutedActionQueryVariables, requestHeaders?: GraphQLClientRequestHeaders): Promise<Background_GetUnexecutedActionQuery> {
      return withWrapper((wrappedRequestHeaders) => client.request<Background_GetUnexecutedActionQuery>(Background_GetUnexecutedActionDocument, variables, {...requestHeaders, ...wrappedRequestHeaders}), 'background_getUnexecutedAction', 'query', variables);
    },
    background_updateVideoEpisodeCountMutation(variables: Background_UpdateVideoEpisodeCountMutationMutationVariables, requestHeaders?: GraphQLClientRequestHeaders): Promise<Background_UpdateVideoEpisodeCountMutationMutation> {
      return withWrapper((wrappedRequestHeaders) => client.request<Background_UpdateVideoEpisodeCountMutationMutation>(Background_UpdateVideoEpisodeCountMutationDocument, variables, {...requestHeaders, ...wrappedRequestHeaders}), 'background_updateVideoEpisodeCountMutation', 'mutation', variables);
    }
  };
}
export type Sdk = ReturnType<typeof getSdk>;