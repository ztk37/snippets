const valueCounts = values =>
  values.reduce((counts, value) => {
    counts[value] = (counts[value] || 0) + 1;
    return counts;
  }, {});

const groupBy = (values, key) =>
  values.reduce((groups, value) => {
    (groups[value[key]] = groups[value[key]] || []).push(value);
    return groups;
  }, {});
