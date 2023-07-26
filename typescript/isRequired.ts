function isUndefined(value: unknown): value is unknown {
    return typeof value === undefined
}

function isRequired(name: string) {
    throw new Error(`${name} is required`)
}

type RunOptions = {
    optionA?: number,
    optionB?: boolean,
    optionC?: string,
    optionD?: string
}

async function run({
    optionA = 42,
    optionB = true,
    optionC = "derp",
    optionD = void isRequired("optionD")
}: RunOptions = {}) {
    return { optionA, optionB, optionC, optionD }
}

run({ optionD: "das" }).then(console.log).catch(console.error)
run({}).then(console.log).catch(console.error)
run().then(console.log).catch(console.error)
