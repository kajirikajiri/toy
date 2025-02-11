/* eslint-disable */
import { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';
export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
};

export type Mutation = {
  __typename?: 'Mutation';
  /** An example field added by the generator */
  testField: Scalars['String']['output'];
};

export type Query = {
  __typename?: 'Query';
  listScrapes: Array<Scrape>;
};

export type Scrape = {
  __typename?: 'Scrape';
  executedAt?: Maybe<Scalars['String']['output']>;
  id: Scalars['ID']['output'];
  rawDom?: Maybe<Scalars['String']['output']>;
  url: Scalars['String']['output'];
  video: Video;
};

export type Video = {
  __typename?: 'Video';
  episodeCount?: Maybe<Scalars['Int']['output']>;
  id: Scalars['ID']['output'];
  scrapes: Array<Scrape>;
  url: Scalars['String']['output'];
};

export type Background_ListScrapesQueryVariables = Exact<{ [key: string]: never; }>;


export type Background_ListScrapesQuery = { __typename?: 'Query', listScrapes: Array<{ __typename?: 'Scrape', id: string }> };


export const Background_ListScrapesDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"background_listScrapes"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"listScrapes"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}}]}}]}}]} as unknown as DocumentNode<Background_ListScrapesQuery, Background_ListScrapesQueryVariables>;