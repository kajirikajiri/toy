react-hook-formはRulesに大事なことが書かれているが、ページ移動が面倒なので、Rulesだけを抜き出してDeepLに飲ませた

ドキュメントのリンク
https://react-hook-form.com/

対象リポジトリ
https://github.com/react-hook-form/documentation

VSCodeで検索したワード
<Admonition type="important" title="Rules">[\s\S\n]*?</Admonition>

VSCodeで検索したディレクトリ
./src/content/docs

18 件の結果 - 17 ファイル

src/content/docs/formprovider.mdx:
  18  
  19: <Admonition type="important" title="Rules">
  20: 
  21: - 入れ子になった FormProvider の使用は避けてください
  22: 
  23: </Admonition>
  24  

src/content/docs/useform.mdx:
  146  
  147: <Admonition type="important" title="Rules">
  148: 
  149: - `undefined` をデフォルト値として提供することは、管理コンポーネントのデフォルト状態と競合するため、**避けるべき**です。
  150: - `defaultValues` はキャッシュされます。リセットするには、[リセット](/docs/useform/reset) API を使用してください。
  151: - `defaultValues` はデフォルトで送信結果に含まれます。
  152: - `Moment` や `Luxon` などのプロトタイプメソッドを含むカスタムオブジェクトを `defaultValues` として使用するのを避けることをお勧めします。
  153: - フォームデータを送信結果に含めるには、他にもオプションがあります。
  154: 
  155: ```javascript
  156: <input {...register("hidden", { value: "data" })} type="hidden" />
  157: 
  158: // 送信時にデータを送信します。
  159: const onSubmit = (data) => {
  160: const output = {
  161: ...data、
  162: others: "その他",
  163: }
  164: }
  165: ⧏/P⧐
  166: 
  167: </警告>
  168  

  374  
  375: <Admonition type="important" title="Rules">
  376: 
  377: - スキーマ検証は、フィールドレベルのエラー報告に重点を置いています。親レベルのエラーチェックは、直接の親レベルに制限されており、グループチェックボックスなどのコンポーネントに適用されます。
  378: - この機能はキャッシュされます。
  379: - 入力の再検証は、ユーザーの操作中に 1 フィールドずつのみ行われます。 lib 自身は `error` オブジェクトを評価し、再レンダリングを適切にトリガーします。
  380: - リゾルバは組み込みバリデータ（required、min など）と一緒に使用できません。
  381: - カスタムリゾルバを作成する際は、
  382: - `values` および `errors` プロパティを持つオブジェクトを返すようにしてください。デフォルト値は空のオブジェクトにしてください。例えば: `{}`。
  383: - `error` オブジェクトのキーは、フィールドの `name` 値に一致させる必要があります。
  384: 
  385: </警告>
  386  

src/content/docs/useformcontext.mdx:
  24  
  25: <Admonition type="important" title="Rules">
  26: `useFormContext`を正しく動作させるには、フォームを[`FormProvider`](/docs/formprovider)
  27: `useFormContext`が正しく機能するためには、フォームを[`FormProvider`](/docs/formprovider)
  28: </Admonition>
  29  

src/content/docs/usewatch.mdx:
  32  
  33: <Admonition type="important" title="Rules">
  34: 
  35: - `useWatch` の初期返り値は、常に `useForm` の `defaultValue` または `defaultValues` の内容となります。
  36: - `useWatch` と `watch` の唯一の違いは、ルート ([`useForm`](/docs/useform)) レベルまたはカスタムフックレベルでの更新です。
  37: - `useWatch` の実行順序は重要です。つまり、購読が有効になる前にフォームの値を更新した場合、更新された値は無視されます。
  38: 
  39: ```javascript copy
  40: setValue("test", "data")
  41: useWatch({ name: "test" }) // ❌ 値更新後に購読が発生するため、更新は受信されません
  42: useWatch({ name: "example" }) // ✅ 入力値の更新が受信され、再レンダリングがトリガーされます
  43: setValue("example", "data")
  44: ⧏CODE⧐
  45: 
  46: 以下の簡単なカスタムフックを使用すれば、上記の問題を回避できます。
  47: 
  48: ```javascript copy
  49: const useFormValues = () => {
  50: const { getValues } = useFormContext()
  51: 
  52: return {
  53: ...useWatch()、//フォーム値更新の購読
  54: 
  55: ...getValues(), // 常に最新のフォーム値にマージする
  56: }
  57: }
  58: ⧏/P⧐
  59: 
  60: - `useWatch`の結果は、`useEffect`の依存関係ではなく、レンダリングフェーズに最適化されています。値更新を検出するには、値比較用に外部カスタムフックを使用することをお勧めします。
  61: 
  62: </警告>
  63  

src/content/docs/useform/clearerrors.mdx:
  32  
  33: <Admonition type="important" title="Rules">
  34: 
  35: - 入力ごとに設定されている検証ルールには影響しません。
  36: - このメソッドは、バリデーションルールやフォームの状態を表す `isValid` 変数には影響しません。
  37: 
  38: </Admonition>
  39  

src/content/docs/useform/control.mdx:
  10  
  11: <Admonition type="important" title="Rules">
  12: 
  13: **重要:** このオブジェクト内のプロパティには直接アクセスしないでください。これは社内でのみ使用するためのものです。
  14: 
  15: </Admonition>
  16  

src/content/docs/useform/form.mdx:
  46  
  47: <Admonition type="important" title="Rules">
  48: 
  49: - 送信データを準備または省略する場合は、[`handleSubmit`](/docs/useform/handlesubmit) または `onSubmit` を使用してください。
  50: ⧏/P⧐
  51: const { handleSubmit, control } = useForm();
  52: const onSubmit =(data) => callback(prepareData(data))
  53: <form onSubmit={handleSubmit(onSubmit)} />
  54: // または
  55: <Form
  56: onSubmit={({ data }) => {
  57: console.log(data)
  58: }}
  59: />
  60: ⧏/P⧐
  61: - プログレッシブエンハンスメントはSSRフレームワークでのみ適用可能。
  62: 
  63: ```javascript
  64: const { handleSubmit, control } = useForm({
  65: progressive: true
  66: });
  67: 
  68: <Form onSubmit={onSubmit} control={control} action="/api/test" method="post">
  69: <input {...register("test", { required: true })} />
  70: </Form />
  71: 
  72: // レンダリングします
  73: 
  74: <form action="/api/test" method="post">
  75: <input required name="test" />
  76: </form>
  77: ⧏/P⧐
  78: 
  79: </警告>
  80   

src/content/docs/useform/getfieldstate.mdx:
  30  
  31: <Admonition type="important" title="Rules">
  32: 
  33: - 名前と登録済みのフィールド名が一致する必要があります。
  34: ⧏CODE⧐javascript
  35: getFieldState("test")
  36: getFieldState("test") // ✅ 入力の登録とフィールド状態の取得
  37: getFieldState("存在しない名前") // ❌ 状態は false、エラーは undefined として返されます。
  38: ⧏CODE_INLINE⧐
  39: - `getFieldState` はフォームの状態更新を購読することで機能します。フォームの状態を購読するには、以下の方法があります。
  40: 
  41: - `useForm`, `useFormContext` または `useFormState` で購読できます。これによりフォーム状態の購読が確立され、`getFieldState` の第 2 引数は不要になります。
  42: 
  43: ```javascript
  44: const {
  45: register、
  46: formState: { isDirty },
  47: } = useForm()
  48: register("test")
  49: getFieldState("test") // ✅
  50: ⧏/P⧐
  51: 
  52: ```javascript
  53: const { isDirty } = useFormState()
  54: register("test")
  55: getFieldState("test") // ✅
  56: ⧏CODE_INLINE⧐
  57: 
  58: ```javascript
  59: const {
  60: register、
  61: formState: { isDirty },
  62: } = useFormContext()
  63: register("test")
  64: getFieldState("test") // ✅
  65: ⧏/P⧐
  66: 
  67: - フォームの状態の購読が設定されていない場合、以下の例に従って、2番目のオプションの引数として `formState` の全体を渡すことができます。
  68: ```javascript
  69: const { register } = useForm()
  70: register("test")
  71: const { isDirty } = getFieldState("test") // ❌ formState isDirty は useForm でサブスクライブされていません
  72: const { register, formState } = useForm()
  73: const { isDirty } = getFieldState("test", formState) // ✅ formState.isDirty がサブスクライブされている
  74: const { formState } = useFormContext()
  75: const { touchedFields } = getFieldState("test", formState) // ✅ formState.touchedFields subscribed
  76: ⧏/P⧐
  77: 
  78: </警告>
  79  

src/content/docs/useform/getvalues.mdx:
  39  
  40: <Admonition type="important" title="Rules">
  41: 
  42: - 入力が無効な場合、`undefined` として返されます。ユーザーが入力内容を更新できないようにし、フィールドの値を保持したい場合は、`readOnly` を使用するか、<fieldset>/</fieldset>全体を無効にします。[例](https://codesandbox.io/s/react-hook-form-disabled-inputs-oihxx)を参照してください。
  43: - **最初の**レンダリング前に、useFormからdefaultValuesが返されます。
  44: 
  45: </警告>
  46  

src/content/docs/useform/handlesubmit.mdx:
  19  
  20: <Admonition type="important" title="Rules">
  21: 
  22: - handleSubmit を使用して、フォームを非同期で簡単に送信できます。
  23: 
  24: ```javascript copy
  25: handleSubmit(onSubmit)()
  26: 
  27: // 非同期の検証用に非同期関数を渡すことができます。
  28: handleSubmit(async (data) => await fetchAPI(data))
  29: ⧏CODE⧐javascript copy
  30: 
  31: - `disabled` 入力はフォーム値で `undefined` 値として表示されます。ユーザーが入力内容を更新できないようにし、フォーム値を保持したい場合は、`readOnly` を使用するか、<fieldset>/</fieldset>全体を無効にすることができます。[例](https://codesandbox.io/s/react-hook-form-disabled-inputs-oihxx)をご覧ください。
  32: - `handleSubmit` 機能では、onSubmit コールバック内で発生したエラーは処理されません。そのため、非同期リクエスト内でエラーを処理し、ユーザーにエラーを適切に通知することをお勧めします。
  33: 
  34: ```javascript
  35: const onSubmit = async () => {
  36: // エラーが発生する可能性がある非同期リクエスト
  37: try {
  38: // await fetch()
  39: } catch (e) {
  40: // エラーを処理します
  41: }
  42: };
  43: 
  44: <form onSubmit={handleSubmit(onSubmit)} />
  45: ⧏/P⧐
  46: 
  47: </警告>
  48  

src/content/docs/useform/reset.mdx:
  29  
  30: <Admonition type="important" title="Rules">
  31: 
  32: - 制御コンポーネントでは、`Controller` コンポーネントの値を`リセット`するために、`useForm` に `defaultValues` を渡す必要があります。
  33: - `reset` API に `defaultValues` が指定されていない場合、HTML ネイティブの [リセット](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/reset) API が呼び出され、フォームが復元されます。
  34: - `useForm`の`useEffect`が呼び出される前に`reset`を呼び出さないでください。これは、`reset`がフォームの状態更新を消去するシグナルを送信する前に、`useForm`のサブスクリプションの準備が整っている必要があるためです。
  35: - 送信後に `useEffect` 内で `reset` を行うことを推奨します。
  36: ```javascript
  37: useEffect(() => {
  38: reset({
  39: data: "test",
  40: })
  41: }, [isSubmitSuccessful])
  42: ⧏CODE⧐
  43: - useForm で `defaultValues` を指定している場合は、引数なしで `reset` を実行しても問題ありません。
  44: 
  45: ```javascript
  46: reset(); // フォームをデフォルト値に更新する
  47: 
  48: reset({ test: 'test' }); // defaultValues とフォームの値を更新します
  49: 
  50: reset(undefined, { keepDirtyValues: true }); // 他のフォームの状態をリセットするが、defaultValues とフォームの値は保持する
  51: ⧏CODE⧐
  52: 
  53: </警告>
  54  

src/content/docs/useform/resetfield.mdx:
  29  
  30: <Admonition type="important" title="Rules">
  31: 
  32: - 名前と登録されたフィールド名が一致する必要があります。
  33: 
  34: ```javascript
  35: register("test")
  36: resetField("test") // ✅ 入力の登録とresetFieldは機能します
  37: resetField("存在しない名前") // ❌ 入力が見つからないため失敗
  38: ⧏CODE_INLINE⧐
  39: 
  40: </警告>
  41  

src/content/docs/useform/seterror.mdx:
  20  
  21: <Admonition type="important" title="Rules">
  22: 
  23: - このメソッドは、入力が `register` の関連ルールに合格した場合、関連する入力エラーを永続化しません。
  24: ⧏CODE⧐javascript
  25: register('registerInput', { minLength: 4 }});
  26: setError('registerInput', { type: 'custom', message: 'カスタムメッセージ' });
  27: // 最小文字数要件を満たしていれば、検証は通過します。
  28: ⧏CODE⧐
  29: - 入力フィールドに関連付けられていないエラーは、`clearErrors`でクリアされるまで保持されます。この動作は、フィールドレベルの組み込みバリデーションにのみ適用されます。
  30: ```javascript
  31: setError("notRegisteredInput", { type: "custom", message: "custom message" })
  32: // clearErrors() を手動で呼び出す必要があります。
  33: ⧏CODE⧐
  34: - `root` をキーとして、サーバーまたはグローバルエラーを設定できます。このタイプのエラーは、各送信時に保持されません。
  35: ```javascript
  36: setError("root.serverError", {
  37: type: "400",
  38: })
  39: setError("root.random", {
  40: type: "random",
  41: })
  42: ⧏/P⧐
  43: - `handleSubmit` メソッドで、非同期検証後にユーザーにエラーフィードバックを返したい場合に役立ちます。（例：APIが検証エラーを返す場合）
  44: - 入力が無効になっている場合、`shouldFocus` は機能しません。
  45: - このメソッドは、`isValid` formState を強制的に `false` に設定します。ただし、`isValid` は常に、入力登録ルールまたはスキーマ結果の検証結果から派生することに留意することが重要です。
  46: - 型チェックとの競合を避けるために避けるべきキーワードがあります。それは `type` と `types` です。
  47: 
  48: </注意>
  49  

src/content/docs/useform/setfocus.mdx:
  19  
  20: <Admonition type="important" title="Rules">
  21: 
  22: - この API は ref から focus メソッドを呼び出すため、`register` 時に `ref` を指定することが重要です。
  23: - `reset` API によってすべての入力参照が削除されるため、`reset` の直後に `setFocus` を呼び出すことは避けてください。
  24: 
  25: </注意>
  26  

src/content/docs/useform/trigger.mdx:
  21  
  22: <Admonition type="important" title="Rules">
  23: 
  24: ペイロードに `string` を使用し、ターゲットを単一フィールド名のみに限定した場合のみ、レンダリングの最適化が可能となります。また、`array` および `undefined` を指定すると、フォーム全体の再レンダリングがトリガーされます。
  25: 
  26: </Admonition>
  27  

src/content/docs/useform/unregister.mdx:
  40  
  41: <Admonition type="important" title="Rules">
  42: 
  43: - このメソッドは入力参照とその値を削除します。つまり、**組み込みのバリデーション**ルールも削除されます。
  44: - 入力の登録を解除しても、スキーマ検証には影響しません。
  45: 
  46: ```javascript
  47: const schema = yup
  48: .object()
  49: .shape({
  50: firstName: yup.string().required(),
  51: })
  52: .required()
  53: 
  54: unregister("firstName") // これにより、firstName 入力に対する検証が削除されることはありません。
  55: ⧏/P⧐
  56: 
  57: - `register` コールバックを持つ入力は確実にアンマウントしてください。そうしないと、入力が再度登録されてしまいます。
  58: 
  59: ```javascript
  60: const [show, setShow] = React.useState(true)
  61: 
  62: const onClick = () => {
  63: unregister("test")
  64: setShow(false) // 入力がアンマウントされるようにし、登録が再度呼び出されないようにします。
  65: }
  66: 
  67: {
  68: show && <input {...register("test")} />
  69: }
  70: ⧏/P⧐
  71: 
  72: </警告>
  73  

src/content/docs/useform/watch.mdx:
  32  
  33: <Admonition type="important" title="Rules">
  34: 
  35: - `defaultValue` が定義されていない場合、`watch` の最初のレンダリングは `register` の前に呼び出されるため、`undefined` を返します。この動作を避けるには、`useForm` で `defaultValues` を指定することが **推奨** されますが、インライン `defaultValue` を 2 番目の引数として設定することもできます。
  36: - `defaultValue` と `defaultValues` の両方が指定されている場合、`defaultValue` が返されます。
  37: - この API は、アプリまたはフォームのルートで再レンダリングをトリガーします。パフォーマンス上の問題が発生した場合は、コールバックまたは [useWatch](/docs/usewatch) API の使用を検討してください。
  38: - `watch` の結果は、`useEffect` の依存関係ではなく、レンダリングフェーズに最適化されています。値更新を検出するには、値比較用の外部カスタムフックを使用することをお勧めします。
  39: 
  40: </警告>
  41  
