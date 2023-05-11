type Tree<T> = {
    id: number
    data: T
    children: Tree<T>[]
}

type Forest<T> = Tree<T>[]

function mapTree<T, U>(tree: Tree<T>, fn: (data: T) => U): Tree<U> {
    return { id: tree.id, data: fn(tree.data), children: tree.children.map(child => mapTree(child, fn)) }
}

function mapForest<T, U>(forest: Forest<T>, fn: (data: T) => U): Forest<U> {
    return forest.map(tree => mapTree(tree, fn))
}

function flattenTree<T>(tree: Tree<T>): [T, number][] {
    function recursion(children: Tree<T>[], level: number): [T, number][] {
        return children.reduce<[T, number][]>((acc, tree) => {
            return [...acc, [tree.data, level], ...recursion(tree.children, level + 1)]
        }, [])
    }

    return [[tree.data, 0], ...recursion(tree.children, 1)]
}

function flattenForest<T>(forest: Forest<T>): [T, number][] {
    return forest.reduce<[T, number][]>((acc, tree) => [...acc, ...flattenTree(tree)], [])
}

function flatMapTree<T, U>(tree: Tree<T>, fn: (pair: [T, number], index: number, arr: [T, number][]) => U): U[] {
    return flattenTree(tree).map(fn)
}

function flatMapForest<T, U>(forest: Forest<T>, fn: (pair: [T, number], index: number, arr: [T, number][]) => U): U[] {
    return flattenForest(forest).map(fn)
}

function singleton<T>(tree: Tree<T>): Forest<T> {
    return [tree]
}

function isLeaf<T>(tree: Tree<T>): boolean {
    return tree.children.length === 0
}

const tree: Tree<boolean> = {
    id: 1,
    data: false,
    children: [
        { id: 2, data: true, children: [] },
        { id: 3, data: false, children: [] },
        {
            id: 4,
            data: true,
            children: [
                { id: 5, data: false, children: [] }
            ]
        }
    ]
}

const forest = singleton(tree)

console.log(flattenTree(tree))
console.log(flattenForest(forest))
console.log(flatMapTree(tree, ([value]) => !value))
console.log(flatMapForest(forest, ([value]) => !value))
