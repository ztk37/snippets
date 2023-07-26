function noop() { };

function identity<T>(input: T): T {
    return input
};

function isRequired() {
    throw new Error("param is required");
};

// Assertions

// TODO: Fix typing
function isArray(value: unknown) {
    return Array.isArray(value)
}

// TODO: Fix typing
function isEmpty(value: unknown) {
    return value.length === 0
}

// TODO: Fix typing
function isFunction(value: unknown) {
    return typeof value === "function"
}

// TODO: Fix typing
function isMap(value: unknown) {
    return typeof Map !== "undefined" && value instanceof Map
}

function isNil(value: unknown): value is null | undefined {
    return value === null || value === undefined
}

function isNull(value: unknown): value is null {
    return value === null
}


function isUndefined(value: unknown): value is unknown {
    return value === undefined;
}

// TODO: Fix typing
function isPlainObject(value: unknown) {
    if (typeof value !== "object" || value === null) return false;

    let proto = value;
    while (Object.getPrototypeOf(proto) !== null) {
        proto = Object.getPrototypeOf(proto);
    }

    return Object.getPrototypeOf(value) === proto;
};

function isString(value: unknown): value is string {
    return typeof value === "string";
}

function isSymbol(value: unknown): value is symbol {
    return typeof value === "symbol" ||
        (typeof value === "object" &&
            Object.prototype.toString.call(value) === "[object Symbol]");
}
