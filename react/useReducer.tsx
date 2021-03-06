import React from "react";
import "./styles.css";

const randomID = () => Math.random().toString(16).slice(2);

const createTodo = (text) => ({
  id: randomID(),
  text,
  completed: false
});

type Todo = {
  id: string;
  text: string;
  completed: boolean;
};

const todos: TodoState = {
  todos: ["foo", "fib", "bar", "derp", "damn"].map(createTodo)
};

type TodoState = { todos: Todo[] };

type TodoAction =
  | { type: "TOGGLE"; payload: string }
  | { type: "CREATE"; payload: string }
  | { type: "REMOVE"; payload: string };

export default function App() {
  const inputRef = React.useRef(null);

  const [state, dispatch] = React.useReducer<
    React.Reducer<TodoState, TodoAction>
  >((state, action) => {
    switch (action.type) {
      case "TOGGLE":
        return {
          ...state,
          todos: state.todos.map((todo) => {
            if (todo.id === action.payload) {
              return {
                ...todo,
                completed: !todo.completed
              };
            }
            return todo;
          })
        };
      case "CREATE":
        return {
          ...state,
          todos: [...state.todos, createTodo(action.payload)]
        };
      case "REMOVE":
        return {
          ...state,
          todos: state.todos.filter((todo) => todo.id !== action.payload)
        };
      default:
        return state;
    }
  }, todos);

  const toggle = (id) => {
    dispatch({
      type: "TOGGLE",
      payload: id
    });
  };

  const create = (text) => {
    dispatch({
      type: "CREATE",
      payload: text
    });
  };

  const remove = (id) => {
    dispatch({
      type: "REMOVE",
      payload: id
    });
  };

  return (
    <div className="App">
      <h1>Hello CodeSandbox</h1>
      <ul>
        {state.todos.map((todo) => (
          <li
            style={{
              display: "flex",
              justifyContent: "space-between"
            }}
          >
            <span>{todo.id}</span>
            <span
              style={{
                textDecoration: todo.completed ? "line-through" : "none"
              }}
            >
              {todo.text}
            </span>
            <div>
              <button className="button" onClick={() => void toggle(todo.id)}>
                {!todo.completed ? "+" : "-"}
              </button>
              <button className="button" onClick={() => void remove(todo.id)}>
                Delete
              </button>
            </div>
          </li>
        ))}
      </ul>
      <input
        ref={inputRef}
        // value={inputRef.current}
      />
      <button
        className="button"
        onClick={() => void create(inputRef.current.value)}
      >
        ADD
      </button>
    </div>
  );
}
