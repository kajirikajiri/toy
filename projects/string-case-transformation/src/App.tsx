import { Box, Button, Flex, Input, Stack, Text } from '@chakra-ui/react'
import { useCallback } from 'react'
import { useForm } from "react-hook-form"
import './App.css'

type FormValues = {
  value: string
}

type Case = 'camel' | 'pascal' | 'kebab' | 'kebab-upper' | 'snake' | 'snake-upper' | 'space' | 'space-upper'

function App() {
  const {register, watch } = useForm<FormValues>({
    defaultValues: {
      value: ''
    }
  })
  const value = watch('value')
  const convertCase = useCallback((caseType: Case) => {
    switch (caseType) {
      case 'camel':
        return value.replace(/([-_]\w)/g, g => g[1].toUpperCase()).replace(/^./, str => str.toLowerCase());
      case 'pascal':
        return value.replace(/(?:^|[_-])(\w)/g, (_, c) => c.toUpperCase())
      case 'snake':
        return value.replace(/[A-Z]/g, '_$&').replace(/^_/, '').toLowerCase();
      case 'snake-upper':
        return value.replace(/[A-Z]/g, '_$&').replace(/^_/, '').toUpperCase()
      case 'kebab':
        return value.replace(/[A-Z]/g, '-$&').replace(/^-/, '').toLowerCase()
      case 'kebab-upper':
        return value.replace(/[A-Z]/g, '-$&').replace(/^-/, '').toUpperCase()
      case 'space':
        return value.replace(/[A-Z]/g, ' $&').replace(/^ /, '').toLowerCase()
      case 'space-upper':
        return value.replace(/[A-Z]/g, ' $&').replace(/^ /, '').toUpperCase()
      default:
        throw new Error('Invalid case')
    }
  }, [value])
  const handleCopy = useCallback((text: string) => {
    navigator.clipboard.writeText(text)
  }, [])

  return (
    <Box display="flex" justifyContent="center" pt={10}>
      <Stack maxW={'1000px'} width="600px" px={20} gap={2}>
        <Input variant='subtle' {...register('value')} />
        <Flex alignItems='center' gap={2}>
          <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase('camel'))}>Copy</Button>
          <Text>{convertCase('camel')}</Text>
        </Flex>
        <Flex alignItems='center' gap={2}>
          <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase('pascal'))}>Copy</Button>
          <Text>{convertCase('pascal')}</Text>
        </Flex>
        <Flex alignItems='center' gap={2}>
          <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase('snake'))}>Copy</Button>
          <Text>{convertCase('snake')}</Text>
        </Flex>
        <Flex alignItems='center' gap={2}>
          <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase('snake-upper'))}>Copy</Button>
          <Text>{convertCase('snake-upper')}</Text>
        </Flex>
        <Flex alignItems='center' gap={2}>
          <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase('kebab'))}>Copy</Button>
          <Text>{convertCase('kebab')}</Text>
        </Flex>
        <Flex alignItems='center' gap={2}>
          <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase('kebab-upper'))}>Copy</Button>
          <Text>{convertCase('kebab-upper')}</Text>
        </Flex>
        <Flex alignItems='center' gap={2}>
          <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase('space'))}>Copy</Button>
          <Text>{convertCase('space')}</Text>
        </Flex>
        <Flex alignItems='center' gap={2}>
          <Button variant='surface' size="xs" onClick={() => handleCopy(convertCase('space-upper'))}>Copy</Button>
          <Text>{convertCase('space-upper')}</Text>
        </Flex>
      </Stack>
    </Box>
  )
}

export default App
