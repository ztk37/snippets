const randomID = () => Math.random().toString(16).slice(2);

const addItem = (value, id = null) => ({
  type: "ADD_ITEM",
  payload: {
    id: id || randomID(),
    value
  }
});

const deleteItem = id => ({
  type: "DELETE_ITEM",
  payload: id
})

const initialState = {
  items: {},
  keys: []
};

const reducer = (state, action) => {
  switch(action.type) {
    case "ADD_ITEM":
      return {
        ...state,
        items: {
          ...state.items,
          [action.payload.id]: action.payload
        },
        keys: [...state.keys, action.payload.id]
      }
    case "DELETE_ITEM":
      const copy = state.items;
      delete copy[action.payload]

      return {
        ...state,
        items: copy,
        keys: state.keys.filter(key => key !== action.payload)
      }
    default: return state
  }
}

const id1 = randomID()
const s1 = reducer(initialState, addItem("sdfsf", id1))
console.log("S1 ", s1);

const s2 = reducer(s1, addItem("cas78dca7dasc"))
console.log("S2 ", s2);

const s3 = reducer(s2, addItem("adcsdgacd6a"))
console.log("S3 ", s3);

const getItems = state => state.keys.map(key => state.items[key]);
console.log(getItems(s3))

const s4 = reducer(s3, deleteItem(id1))
console.log("S4 ", s4);
