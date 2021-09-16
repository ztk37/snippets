const isUndefined = (value) => typeof value === undefined

const isRequired = (name) => {
	throw new Error(`${name} is required`) 
}

const run = async ({
	optionA = 42,
	optionB = true,
	optionC = "derp",
	optionD = isRequired("optionD")
} = {}) => {
	return { optionA, optionB, optionC, optionD }
}

run({optionD: "das"}).then(console.log).catch(console.error)
run({}).then(console.log).catch(console.error)
run().then(console.log).catch(console.error)
