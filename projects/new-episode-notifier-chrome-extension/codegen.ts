import type { CodegenConfig } from '@graphql-codegen/cli'
 
const config: CodegenConfig = {
   schema: 'http://localhost:3000/graphql',
   documents: ['src/**/*.gql'],
   generates: {
      './src/gql/generated.ts': {
        plugins: ['typescript-operations', 'typescript-react-apollo'],
      },
   }
}
export default config