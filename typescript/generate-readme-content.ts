const languages = [{
    name: "Python",
}, {
    name: "Javascript",
}, {
    name: "Typescript",
}, {
    name: "Python",
}];

const content = `
# Headline

## Languages

<!-- languages:start-->
<!-- languages:end -->

## License

> [MIT](http://link/to/LICENSE.md)
`;

console.log(content)

const c1 = content.replace(
    /<!--\s+\w+:start-->([\S\s]*)<!--\s+\w+:end\s+-->/,
    ["<!-- languages:start-->"
        , ...languages.map(({ name }) => "- " + name)
        , "<!-- languages:end -->"
    ].join("\n")
);

console.log(c1)

const c2 = c1.replace(
    /<!--\s+\w+:start-->([\S\s]*)<!--\s+\w+:end\s+-->/,
    ["<!-- languages:start-->"
        , "deleted"
        , "<!-- languages:end -->"
    ].join("\n")
);

console.log(c2)
