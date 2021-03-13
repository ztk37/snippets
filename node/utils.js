  
// Default values

const none = () => {};

const identity = () => {};

const isRequired = () => {
  throw new Error("param is required");
};

// Assertions

const isArray = value => Array.isArray(value);

const isEmpty = value => value.length === 0;

const isFunction = value => typeof value === "function";

const isMap = value => typeof Map !== "undefined" && value instanceof Map;

const isNil = value => value === null || value === undefined;

const isNull = value => value === null;

const isPlainObject = value => {
  if (typeof value !== "object" || value === null) return false;

  let proto = value;
  while (Object.getPrototypeOf(proto) !== null) {
    proto = Object.getPrototypeOf(proto);
  }

  return Object.getPrototypeOf(value) === proto;
};

const isString = value => typeof value === "string";

const isSymbol = value =>
  typeof value === "symbol" ||
  (typeof value === "object" &&
    Object.prototype.toString.call(value) === "[object Symbol]");

const isUndefined = value => value === undefined;
