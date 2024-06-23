import { Button, ChakraProvider, FormControl, FormErrorMessage, FormLabel, Input } from '@chakra-ui/react'
import { Control, Controller, Form, FormState, SubmitHandler, UseFormRegister, UseFormWatch, useFieldArray, useForm, useWatch } from 'react-hook-form'

interface IFormInput {
  name1: string
  name2: string
  name3: { name: string }[]
  name4: { fName: string, lName: string }[]
}

function HookForm1({register, formState}: {register: UseFormRegister<IFormInput>, formState: FormState<IFormInput>}) {
  console.log("HookForm1")
  
  return (
      <FormControl isInvalid={!!formState.errors.name1}>
        <FormLabel htmlFor='name1'>First name</FormLabel>
        <Input
          id='name1'
          placeholder='name1'
          {...register('name1', {
            required: 'This is required',
            minLength: { value: 4, message: 'Minimum length should be 4' },
          })}
        />
        <FormErrorMessage>
          {formState.errors.name1 && formState.errors.name1.message}
        </FormErrorMessage>
      </FormControl>
  )
}

function HookForm2({control, formState}: {control: Control<IFormInput, any>, formState: FormState<IFormInput>}) {
  console.log("HookForm2")
  
  return (
    <>
      <Controller
        control={control}
        name='name2'
        rules={{
          required: 'This is required',
          minLength: { value: 4, message: 'Minimum length should be 4' },
        }}
        render={({ field }) => (
          <Input
            id='name2'
            placeholder='name2'
            {...field}
          />
        )}
      />
      <div>
        {formState.errors.name2 && formState.errors.name2.message}
      </div>
    </>
  )
}


function HookForm3({control, register, formState}: {control: Control<IFormInput, any>, register: UseFormRegister<IFormInput>, formState: FormState<IFormInput>}) {
  console.log("HookForm3")
  const { fields, append } = useFieldArray({
    control,
    name: 'name3',
  });
  const watchFieldArray = useWatch({
    control,
    name: 'name3',
  });
  const controlledFields = fields.map((field, index) => {
    return {
      ...field,
      ...watchFieldArray[index]
    };
  });
  return (
    <>
      <Button onClick={() => append({ name: "" })}>Append</Button>
      {controlledFields.map((field, index) => {
        return (
          <FormControl key={field.id} isInvalid={!!(formState.errors.name3 && formState.errors.name3[index]?.name)}>
            <Input
              id={field.id}
              placeholder='name3'
              {...register(`name3.${index}.name` as const, {
                required: 'This is required',
                minLength: { value: 4, message: 'Minimum length should be 4' },
              })}
            />
            <FormErrorMessage>
              {formState.errors.name3 && formState.errors.name3[index]?.name?.message}
            </FormErrorMessage>
          </FormControl>
        )
      })}
    </>
  )
}

function HookForm4({control, register}: {control: Control<IFormInput, any>, register: UseFormRegister<IFormInput>}) {
  console.log("HookForm4")
  const { fields, append, remove } = useFieldArray({
    control,
    name: 'name4',
  });
  return (
    <>
      <button
        type="button"
        onClick={() => append({ fName: "", lName: ""})}
      >
        append
      </button>
      <ul>
        {fields.map((item, index) => (
          <li key={item.id}>
            <input {...register(`name4.${index}.fName` as const)}/>
            <Controller
              render={({ field }) => <input {...field} />}
              name={`name4.${index}.lName` as const}
              control={control}
            />
            <button type="button" onClick={() => remove(index)}>Delete</button>
          </li>
        ))}
      </ul>
    </>
  );

}

function App() {
  const { register, control, formState, handleSubmit } = useForm<IFormInput>({
    defaultValues: {
      name1: '',
      name2: '',
      name3: [],
      name4: [],
    },
  })

  const onSubmit: SubmitHandler<IFormInput> = (values) => {
    return new Promise((resolve) => {
      setTimeout(() => {
        alert(JSON.stringify(values, null, 2))
        resolve(values)
      }, 3000)
    })
  }
  
  return (
    <ChakraProvider>
      <form onSubmit={handleSubmit(onSubmit)}>
        <HookForm1 formState={formState} register={register} />
        <HookForm2 formState={formState} control={control} />
        <HookForm3 control={control} register={register} formState={formState} />
        <HookForm4 control={control} register={register} />
        <Button mt={4} colorScheme='teal' isLoading={formState.isSubmitting} type='submit'>
          Submit
        </Button>
      </form>
    </ChakraProvider>
  )
}

export default App
