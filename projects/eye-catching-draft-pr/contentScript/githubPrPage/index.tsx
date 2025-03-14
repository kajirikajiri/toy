import { FC } from 'react';
import { useContentScriptGithubPrPageMakeStringReviewersRed } from './useMakeStringReviewersRed';
import { useContentScriptGithubPrPageMakeStringMergeRed } from './useMakeStringMergeRed';

export const ContentScriptGithubPrPage: FC = () => {
  useContentScriptGithubPrPageMakeStringReviewersRed()
  useContentScriptGithubPrPageMakeStringMergeRed()
  return null
}
