# reactのuseEffectを追ってみる。useStateなら実装まで辿り着いた。

みなさんこんにちは、かじりです。今回はReactのuseEffectの実装を追ってみました。まだ途中ですが先行公開します。

まずはcloneしてくる。

https://github.com/facebook/react
<br/>

packages/react/index.jsをみると、useEffectが定義されている  
[https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/index.js#L69](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/index.js#L69)

```javascript
export {
  ...
  useEffect,
  ...
} from './src/React';

```
<br/>

useEffectがimportされている ./src/Reactをみる  
[https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/index.js#L81](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/index.js#L81)


```javascript
...
} from './src/React';
```
<br/>

useEffectがimportされている ./ReactHooksをみる  
[https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/src/React.js#L57](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/src/React.js#L57)

```javascript
import {
  ...
  useEffect,
  ...
} from './ReactHooks';
```
<br/>

useEffectはresolveDispatcherを呼び出すと生成されるので resolveDispatcherをみる [https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/src/ReactHooks.js#L104](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/src/ReactHooks.js#L104)

```javascript
export function useEffect(
  create: () => (() => void) | void,
  deps: Array<mixed> | void | null,
): void {
  const dispatcher = resolveDispatcher();
  return dispatcher.useEffect(create, deps);
}
```
<br/>

ReactCurrentDispatcher.currentを返しているので ReactCurrentDispatcherをみる [https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/src/ReactHooks.js#L24](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/src/ReactHooks.js#L24)

```javascript
function resolveDispatcher() {
  const dispatcher = ReactCurrentDispatcher.current;
  if (__DEV__) {
    if (dispatcher === null) {
      console.error(
        'Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for' +
          ' one of the following reasons:\n' +
          '1. You might have mismatching versions of React and the renderer (such as React DOM)\n' +
          '2. You might be breaking the Rules of Hooks\n' +
          '3. You might have more than one copy of React in the same app\n' +
          'See https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.',
      );
    }
  }
  // Will result in a null access error if accessed outside render phase. We
  // intentionally don't throw our own error because this is in a hot path.
  // Also helps ensure this is inlined.
  return ((dispatcher: any): Dispatcher);
}
```
<br/>

react-reconciler/src/ReactInternalTypesのDispatcher typeを使用しているのでそこにDispatcherが定義されていると目星をつける。  [https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/src/ReactCurrentDispatcher.js#L10](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react/src/ReactCurrentDispatcher.js#L10)

```javascript
import type {Dispatcher} from 'react-reconciler/src/ReactInternalTypes';

/**
 * Keeps track of the current dispatcher.
 */
const ReactCurrentDispatcher = {
  /**
   * @internal
   * @type {ReactComponent}
   */
  current: (null: null | Dispatcher),
};

export default ReactCurrentDispatcher;
```
<br/>

react-reconciler/srcのなかでuseEffectに関係ある箇所を探すと、ReactFiberHooks.old.jsとReactFiberHooks.new.jsが見つかる。newとoldのだしわけに使っているフラグはfalseになっているのでoldをみる。 [https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/shared/ReactFeatureFlags.js#L112](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/shared/ReactFeatureFlags.js#L112)

```javascript
export const enableNewReconciler = false;
```
<br/>

Dispathcer型は大量に見つかるがDispatcher型でuseEffectなのは三ヶ所。 [https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react-reconciler/src/ReactFiberHooks.old.js#L2378](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react-reconciler/src/ReactFiberHooks.old.js#L2378) [https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react-reconciler/src/ReactFiberHooks.old.js#L2406](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react-reconciler/src/ReactFiberHooks.old.js#L2406) [https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react-reconciler/src/ReactFiberHooks.old.js#L2434](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react-reconciler/src/ReactFiberHooks.old.js#L2434)

```javascript
export const ContextOnlyDispatcher: Dispatcher = {
  readContext,

  useCallback: throwInvalidHookError,
  useContext: throwInvalidHookError,
  useEffect: throwInvalidHookError,
  useImperativeHandle: throwInvalidHookError,
  useInsertionEffect: throwInvalidHookError,
  useLayoutEffect: throwInvalidHookError,
  useMemo: throwInvalidHookError,
  useReducer: throwInvalidHookError,
  useRef: throwInvalidHookError,
  useState: throwInvalidHookError,
  useDebugValue: throwInvalidHookError,
  useDeferredValue: throwInvalidHookError,
  useTransition: throwInvalidHookError,
  useMutableSource: throwInvalidHookError,
  useSyncExternalStore: throwInvalidHookError,
  useId: throwInvalidHookError,

  unstable_isNewReconciler: enableNewReconciler,
};
```

```javascript
const HooksDispatcherOnMount: Dispatcher = {
  readContext,

  useCallback: mountCallback,
  useContext: readContext,
  useEffect: mountEffect,
  useImperativeHandle: mountImperativeHandle,
  useLayoutEffect: mountLayoutEffect,
  useInsertionEffect: mountInsertionEffect,
  useMemo: mountMemo,
  useReducer: mountReducer,
  useRef: mountRef,
  useState: mountState,
  useDebugValue: mountDebugValue,
  useDeferredValue: mountDeferredValue,
  useTransition: mountTransition,
  useMutableSource: mountMutableSource,
  useSyncExternalStore: mountSyncExternalStore,
  useId: mountId,

  unstable_isNewReconciler: enableNewReconciler,
};
```

```javascript
const HooksDispatcherOnUpdate: Dispatcher = {
  readContext,

  useCallback: updateCallback,
  useContext: readContext,
  useEffect: updateEffect,
  useImperativeHandle: updateImperativeHandle,
  useInsertionEffect: updateInsertionEffect,
  useLayoutEffect: updateLayoutEffect,
  useMemo: updateMemo,
  useReducer: updateReducer,
  useRef: updateRef,
  useState: updateState,
  useDebugValue: updateDebugValue,
  useDeferredValue: updateDeferredValue,
  useTransition: updateTransition,
  useMutableSource: updateMutableSource,
  useSyncExternalStore: updateSyncExternalStore,
  useId: updateId,

  unstable_isNewReconciler: enableNewReconciler,
};
```
<br/>

throwInvalidHookErrorはエラー。残りはmountEffectとupdateEffect。HooksDispatcherOnUpdateとHooksDispatcherOnMountが関係しているので、mount時とupdate時だと思われる。

mountEffectもupdateEffectもeffectImplの内部でpushEffectしている。 [https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react-reconciler/src/ReactFiberHooks.old.js#L1537](https://github.com/facebook/react/blob/3dc41d8a2590768a6ac906cd1f4c11ca00417eee/packages/react-reconciler/src/ReactFiberHooks.old.js#L1537)

```javascript
function pushEffect(tag, create, destroy, deps) {
  const effect: Effect = {
    tag,
    create,
    destroy,
    deps,
    // Circular
    next: (null: any),
  };
  let componentUpdateQueue: null | FunctionComponentUpdateQueue = (currentlyRenderingFiber.updateQueue: any);
  if (componentUpdateQueue === null) {
    componentUpdateQueue = createFunctionComponentUpdateQueue();
    currentlyRenderingFiber.updateQueue = (componentUpdateQueue: any);
    componentUpdateQueue.lastEffect = effect.next = effect;
  } else {
    const lastEffect = componentUpdateQueue.lastEffect;
    if (lastEffect === null) {
      componentUpdateQueue.lastEffect = effect.next = effect;
    } else {
      const firstEffect = lastEffect.next;
      lastEffect.next = effect;
      effect.next = firstEffect;
      componentUpdateQueue.lastEffect = effect;
    }
  }
  return effect;
}
```
<br/>

というあたりまでわかったが、これがuseEffectの実装？？なのか？という気持ちで終わった。

useStateならわかりそうだが、useEffectはいまいち

一旦中断。