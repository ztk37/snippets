function valueCounts<T extends number | string | symbol>(values: T[]) {
    return values.reduce((counts, value) => {
        counts[value] = (counts[value] || 0) + 1;
        return counts;
    }, {} as Record<T, number>);
}

function groupBy<T>(values: T[], getter: (value: T) => number | string) {
    return values.reduce<Record<number | string, T[]>>((groups, value) => {
        const key = getter(value);

        return {
            ...groups,
            [key]: !groups[key]
                ? [value]
                : [...groups[key], value]
        };
    }, {});
}

const xs = [
    { kind: "c", value: 0 },
    { kind: "a", value: 1 },
    { kind: "b", value: 2 },
    { kind: "b", value: 3 },
    { kind: "c", value: 4 },
    { kind: "a", value: 5 },
    { kind: "b", value: 6 },
    { kind: "a", value: 7 },
    { kind: "b", value: 8 },
    { kind: "c", value: 9 },
]

console.log(valueCounts(xs.map(({ kind }) => kind)))
console.log(groupBy(xs, (x) => x.kind))
