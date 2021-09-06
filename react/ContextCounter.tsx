import React, { Component, ReactElement } from 'react';
import PropTypes from 'prop-types';
import { render } from 'react-dom';
import './style.css';

function useSingleCounter(
  initial = 0
): [number, { next: () => void; reset: () => void }] {
  const [count, setCounter] = React.useState(initial);

  const next = () => {
    setCounter(count + 1);
  };
  const reset = () => {
    setCounter(0);
  };

  return [count, { next, reset }];
}

const SingleCounter = () => {
  const [count, { next, reset }] = useSingleCounter();

  return (
    <div>
      Count: {count}
      <button onClick={() => void next()}>+</button>
      <button onClick={() => void reset()}>reset</button>
    </div>
  );
};

const MultiCounterContext = React.createContext();

type MultiCounterState = {
  [key: string]: number;
};

type MultiCounterAction =
  | { type: 'counter/next'; payload: string }
  | { type: 'counter/reset'; payload: string };

const multiCounterReducer = (
  state: MultiCounterState,
  action: MultiCounterAction
) => {
  switch (action.type) {
    case 'counter/next':
      if (!state[action.payload]) {
        return {
          ...state,
          [action.payload]: 1
        };
      }

      return {
        ...state,
        [action.payload]: state[action.payload] + 1
      };
    case 'counter/reset':
      return {
        ...state,
        [action.payload]: 0
      };
    default:
      return state;
  }
};

const MultiCounterProvider = ({ children }) => {
  const [state, dispatch] = React.useReducer<
    React.Reducer<MultiCounterState, MultiCounterAction>
  >(multiCounterReducer, {});

  const calculateTotal = (): number => {
    return Object.values(state).reduce((acc, count) => acc + count, 0);
  };

  const next = (id: string) => {
    dispatch({
      type: 'counter/next',
      payload: id
    });
  };

  const reset = (id: string) => {
    dispatch({
      type: 'counter/reset',
      payload: id
    });
  };

  const getCounter = (id: string) => {
    return state[id];
  };

  const ctx = {
    next,
    reset,
    calculateTotal,
    getCounter
  };

  return (
    <MultiCounterContext.Provider value={ctx}>
      {children}
    </MultiCounterContext.Provider>
  );
};

const randomID = () =>
  Math.random()
    .toString(16)
    .slice(2);

function useMiltiCounter(name = '') {
  const idRef = React.useRef(name || randomID());
  const { next: _next, reset: _reset, getCounter } = React.useContext(
    MultiCounterContext
  );

  const next = () => {
    _next(idRef.current);
  };

  const reset = () => {
    _next(idRef.current);
  };

  return [getCounter(idRef.current) || 0, idRef.current, { next, reset }];
}

const MultiCounter = ({ name = '' }) => {
  const [count, id, { next, reset }] = useMiltiCounter(name);

  return (
    <div>
      Count({id}): {count}
      <button onClick={() => void next()}>+</button>
      <button onClick={() => void reset()}>reset</button>
    </div>
  );
};

const MultiCounterTotal = () => {
  const { calculateTotal } = React.useContext(MultiCounterContext);

  return <div>Total: {calculateTotal()}</div>;
};

function App() {
  return (
    <div>
      <SingleCounter />
      <SingleCounter />
      <SingleCounter />

      <MultiCounterProvider>
        <MultiCounter />
        <MultiCounter />
        <MultiCounter />
        <MultiCounter name="derp" />
        <MultiCounterTotal />
      </MultiCounterProvider>
    </div>
  );
}

render(<App />, document.getElementById('root'));
