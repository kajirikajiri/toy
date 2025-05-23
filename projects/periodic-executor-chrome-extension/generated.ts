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
  browserExtensionResult: ActionEnumBrowserExtensionResult;
  completedAt?: Maybe<Scalars['ISO8601DateTime']['output']>;
  createdAt: Scalars['ISO8601DateTime']['output'];
  executable: ActionUnionExecutable;
  executableType: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  log?: Maybe<Scalars['JSON']['output']>;
  pattern: ActionEnumPattern;
  result: ActionEnumResult;
  status: ActionEnumStatus;
  updatedAt: Scalars['ISO8601DateTime']['output'];
};

export type ActionEnumBrowserExtensionResult =
  | 'episode_count_fetched'
  | 'episode_not_found'
  | 'failed_to_create_tab'
  | 'new_videos_params_fetch_failed'
  | 'new_videos_params_fetched'
  | 'tab_loading_not_completed';

export type ActionEnumPattern =
  | 'create_videos_for_watch_list'
  | 'update_video_episode_count';

export type ActionEnumResult =
  | 'episode_count_not_updated'
  | 'episode_count_updated'
  | 'new_videos_created'
  | 'new_videos_not_found'
  | 'no_change_in_episode_count'
  | 'videos_not_created';

export type ActionEnumStatus =
  | 'completed'
  | 'failed'
  | 'pending';

export type ActionUnionExecutable = Video | WatchList;

/** Autogenerated input type of CreateVideosMutation */
export type CreateVideosMutationInput = {
  actionId: Scalars['ID']['input'];
  browserExtensionResult: ActionEnumBrowserExtensionResult;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: InputMaybe<Scalars['String']['input']>;
  videos?: InputMaybe<Array<VideoInput>>;
};

/** Autogenerated return type of CreateVideosMutation. */
export type CreateVideosMutationPayload = {
  __typename?: 'CreateVideosMutationPayload';
  action?: Maybe<Action>;
  /** A unique identifier for the client performing the mutation. */
  clientMutationId?: Maybe<Scalars['String']['output']>;
};

export type Mutation = {
  __typename?: 'Mutation';
  createVideos?: Maybe<CreateVideosMutationPayload>;
  updateVideoEpisodeCount?: Maybe<UpdateVideoEpisodeCountMutationPayload>;
};


export type MutationCreateVideosArgs = {
  input: CreateVideosMutationInput;
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
  browserExtensionResult: ActionEnumBrowserExtensionResult;
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

export type VideoInput = {
  episodeCount?: InputMaybe<Scalars['Int']['input']>;
  season?: InputMaybe<Scalars['Int']['input']>;
  title?: InputMaybe<Scalars['String']['input']>;
  url?: InputMaybe<Scalars['String']['input']>;
};

export type WatchList = {
  __typename?: 'WatchList';
  id: Scalars['ID']['output'];
  url: Scalars['String']['output'];
};

export type Background_GetUnexecutedActionQueryVariables = Exact<{ [key: string]: never; }>;


export type Background_GetUnexecutedActionQuery = { __typename?: 'Query', getUnexecutedAction?: { __typename?: 'Action', id: string, pattern: ActionEnumPattern, executable: { __typename?: 'Video', id: string, url: string } | { __typename?: 'WatchList', id: string, url: string } } | null };

export type Background_UpdateVideoEpisodeCountMutationMutationVariables = Exact<{
  input: UpdateVideoEpisodeCountMutationInput;
}>;


export type Background_UpdateVideoEpisodeCountMutationMutation = { __typename?: 'Mutation', updateVideoEpisodeCount?: { __typename?: 'UpdateVideoEpisodeCountMutationPayload', action: { __typename?: 'Action', id: string, executable: { __typename?: 'Video', id: string } | { __typename?: 'WatchList' } } } | null };

export type Background_CreateVideosMutationMutationVariables = Exact<{
  input: CreateVideosMutationInput;
}>;


export type Background_CreateVideosMutationMutation = { __typename?: 'Mutation', createVideos?: { __typename?: 'CreateVideosMutationPayload', action?: { __typename?: 'Action', id: string } | null } | null };


export const Background_GetUnexecutedActionDocument = gql`
    query background_getUnexecutedAction {
  getUnexecutedAction {
    id
    pattern
    executable {
      ... on Video {
        id
        url
      }
      ... on WatchList {
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
export const Background_CreateVideosMutationDocument = gql`
    mutation background_createVideosMutation($input: CreateVideosMutationInput!) {
  createVideos(input: $input) {
    action {
      id
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
    },
    background_createVideosMutation(variables: Background_CreateVideosMutationMutationVariables, requestHeaders?: GraphQLClientRequestHeaders): Promise<Background_CreateVideosMutationMutation> {
      return withWrapper((wrappedRequestHeaders) => client.request<Background_CreateVideosMutationMutation>(Background_CreateVideosMutationDocument, variables, {...requestHeaders, ...wrappedRequestHeaders}), 'background_createVideosMutation', 'mutation', variables);
    }
  };
}
export type Sdk = ReturnType<typeof getSdk>;