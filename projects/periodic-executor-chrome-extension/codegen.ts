import type { CodegenConfig } from '@graphql-codegen/cli'
 
const config: CodegenConfig = {
   schema: 'http://localhost:3333/graphql',
   documents: ['**/gql/index.gql'],
  generates: {
    'generated.ts': {
      plugins: [
        'typescript',
        'typescript-operations',
        'typescript-graphql-request',
      ],
      config: {
        enumsAsTypes: true,
      }
    },
  }
}
export default config