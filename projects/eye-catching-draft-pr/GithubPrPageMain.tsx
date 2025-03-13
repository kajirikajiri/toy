import { FC } from 'react';
import { useAddDraftToGithubPrPage } from './useAddDraftToGithubPrPage';

export const GithubPrPageMain: FC = () => {
  useAddDraftToGithubPrPage()
  return null
}
