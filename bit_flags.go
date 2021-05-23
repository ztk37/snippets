package main

import (
	"fmt"
)

const (
	flagA = 1 << iota
	flagB
	flagC
	flagD
	flagE
	flagF

	flagX = flagD | flagE
)

func printBits(bits int) {
	fmt.Printf("%064b\n", bits)
}

func main() {
	flags := 54

	printBits(flagA)
	printBits(flagB)
	printBits(flagC)
	printBits(flagD)
	printBits(flagE)
	printBits(flagF)
	printBits(flagX)

	printBits(flags)

	if flags&flagA != 0 {
		fmt.Println("flagA is set")
	} else {
		fmt.Println("flagA is not set")
	}

	if flags&flagB != 0 {
		fmt.Println("flagB is set")
	} else {
		fmt.Println("flagB is not set")
	}

	if flags&flagC != 0 {
		fmt.Println("flagC is set")
	} else {
		fmt.Println("flagC is not set")
	}

	if flags&flagD != 0 {
		fmt.Println("flagD is set")
	} else {
		fmt.Println("flagD is not set")
	}

	if flags&flagE != 0 {
		fmt.Println("flagE is set")
	} else {
		fmt.Println("flagE is not set")
	}

	if flags&flagF != 0 {
		fmt.Println("flagF is set")
	} else {
		fmt.Println("flagF is not set")
	}

	const MaxUint = ^uint(0)
	const MinUint = 0
	const MaxInt = int(MaxUint >> 1)
	const MinInt = -MaxInt - 1

	fmt.Printf("%b\n", MaxUint)
	fmt.Printf("%b\n", MinUint)
	fmt.Printf("%b\n", MaxInt)
	fmt.Printf("%b\n", MinInt)

	// uint8  : 0 to 255
	// uint16 : 0 to 65535
	// uint32 : 0 to 4294967295
	// uint64 : 0 to 18446744073709551615
	// int8   : -128 to 127
	// int16  : -32768 to 32767
	// int32  : -2147483648 to 2147483647
	// int64  : -9223372036854775808 to 9223372036854775807
}
