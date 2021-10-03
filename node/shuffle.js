const xs = [1, 2, 3, 4, 5, 6, 7]

function shuffle(xs) {
    let shuffled = xs.slice()

	for (let i = shuffled.length - 1; i > 0; i--) {
		const j = Math.floor(Math.random() * (i + 1));
		[shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]]
	}

	return shuffled
}

console.log("before:", xs)
console.log("shuffled:", shuffle(xs))
console.log("after:", xs)
