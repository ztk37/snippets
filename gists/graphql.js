const gql = require("graphql");
const {
  graphql,
  GraphQLSchema,
  GraphQLObjectType,
  GraphQLString,
  buildSchema
} = gql;

// const schema = new GraphQLSchema({
//   query: new GraphQLObjectType({
//     name: "Query",
//     fields: {
//       greet: {
//         type: GraphQLString,
//         resolve() {
//           return "Hello"
//         },
//       },
//     },
//   }),
//   mutation: new GraphQLObjectType({
//     name: "Mutation",
//     fields: {
//       updateName: {
//         type: 
//       },
//     },
//   }),
// });

let name = "g33k57"

const schema = buildSchema(`
  input NameInput {
    name: String
  }
  type Query {
    greet: String
  }
  type Mutation {
    setName(input: NameInput): String
  }
`);

const root = {
  greet: () => `Hello, ${name}`,
  setName: ({input}) => {
    name = input.name

    return name
  }
};

console.log(schema)

const GREET = `{
  greet
}`;

const SET_NAME = `mutation {
  setName(input: { name: "foo" })
}`;

graphql(schema, GREET, root).then(result => {
  console.log(JSON.stringify(result, null, 2));
});

graphql(schema, SET_NAME, root).then(result => {
  console.log(JSON.stringify(result, null, 2));
});

graphql(schema, GREET, root).then(result => {
  console.log(JSON.stringify(result, null, 2));
});
