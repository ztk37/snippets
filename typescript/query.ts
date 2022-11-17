interface SearchFilter {
  kind: string;
  value: string;
}

interface SearchQuery {
  filters: SearchFilter[];
  rest: string;
}

function isFilter(input: string): boolean {
  return /^[a-zA-Z]+:[a-zA-Z-0-9]+$/.test(input);
}

function toQuery(input: string): SearchQuery {
  const tokens = input.split(/\s+/);

  if (tokens.length === 0)
    return {
      filters: [],
      rest: input,
    };

  let filters = [];
  let rest = [];

  for (const token of tokens) {
    if (isFilter(token)) {
      filters.push(token.split(":"));
    } else {
      rest.push(token);
    }
  }

  return {
    filters: filters.map(([kind, value]) => ({ kind, value })),
    rest: rest.join(" "),
  };
}

function fromQuery(query: SearchQuery): string {
  return (
    query.filters
      .map(({ kind, value }) => `${kind}:${value}`)
      .sort()
      .join(" ") +
    " " +
    query.rest
  );
}

const input = "auther:me limit:4 some more terms topic:foo";

const query = toQuery(input);

console.log(query, fromQuery(query));
