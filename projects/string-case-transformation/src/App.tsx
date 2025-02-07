import { Box, Button, Flex, Input, Stack, Text } from '@chakra-ui/react'
import { useCallback } from 'react'
import { useForm } from "react-hook-form"
import * as changeCase from 'change-case'
import * as spongeCase from 'sponge-case'
import * as swapCase from 'swap-case'
import * as titleCase from 'title-case'
import './App.css'

type FormValues = {
  value: string
}

const cases = ['camel', 'pascal', 'snake', 'snake-upper', 'kebab', 'kebab-upper', 'space', 'space-upper', 'title', 'sponge', 'swap'] as const

type Case = typeof cases[number]

function App() {
  const { register, watch } = useForm<FormValues>({
    defaultValues: {
      value: ''
    }
  })
  const value = watch('value')
  const convertCase = useCallback((caseType: Case, value: string) => {
    switch (caseType) {
      case 'camel':
        return changeCase.camelCase(value);
      case 'pascal':
        return changeCase.pascalCase(value);
      case 'snake':
        return changeCase.snakeCase(value);
      case 'snake-upper':
        return changeCase.snakeCase(value).toUpperCase();
      case 'kebab':
        return changeCase.kebabCase(value);
      case 'kebab-upper':
        return changeCase.kebabCase(value).toUpperCase();
      case 'space':
        return changeCase.noCase(value);
      case 'space-upper':
        return changeCase.noCase(value).toUpperCase();
      case 'title':
        return titleCase.titleCase(value);
      case 'sponge':
        return spongeCase.spongeCase(value);
      case 'swap':
        return swapCase.swapCase(value);
      default: {
        return caseType satisfies never
      }
    }
  }, [])

  const handleCopy = useCallback((text: string) => {
    navigator.clipboard.writeText(text)
  }, [])

  return (
    <Box display="flex" justifyContent="center" pt={10}>
      <Stack maxW={'1000px'} width="600px" px={20} gap={2}>
        <Input variant='subtle' {...register('value')} />
        {cases.map(caseType => (
          <Flex key={caseType} alignItems='center' gap={2}>
            <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase(caseType, value))}>Copy</Button>
            <Text>{convertCase(caseType, value)}</Text>
          </Flex>
        ))}
      </Stack>
    </Box>
  )
}

export default App
