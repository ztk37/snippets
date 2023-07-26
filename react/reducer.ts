type State = {
    items: Record<string, {
        id: string,
        value: string
    }>,
    keys: string[]
}

type AddItemAction = {
    type: "ADD_ITEM",
    payload: {
        id: string,
        value: string
    }
}

type DeleteItemAction = {
    type: "DELETE_ITEM",
    payload: string
}

type Action = AddItemAction | DeleteItemAction

function randomID(): string {
    return Math.random().toString(16).slice(2);
}

function addItem(value: string, id = randomID()): AddItemAction {
    return {
        type: "ADD_ITEM",
        payload: {
            id,
            value
        }
    }
}

function deleteItem(id: string): DeleteItemAction {
    return {
        type: "DELETE_ITEM",
        payload: id
    }
}

const initialState = {
    items: {},
    keys: []
};

function reducer(state: State, action: Action): State {
    switch (action.type) {
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

const getItems = (state: State) => state.keys.map(key => state.items[key]);
console.log(getItems(s3))

const s4 = reducer(s3, deleteItem(id1))
console.log("S4 ", s4);
