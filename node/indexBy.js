module.exports = function indexBy(xs, k) {
  const list = xs || [];
  const key = k || 'id';
  
  if (!Array.isArray(list)) {
    throw new TypeError('`list` must be of type Array');
  }

  return list.reduce((acc, item) => {
    if (item && item[key] != null) {
      acc[item[key]] = item;
    }
    return acc;
  }, {});
};
