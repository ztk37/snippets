package main

import (
	"fmt"
)

type Config struct {
	A string
	B string
	C string
}

type Builder struct {
	config Config
}

func NewBuilder() Builder {
	return Builder{
		config: Config{},
	}
}

func (b Builder) A(a string) Builder {
	b.config.A = a
	return b
}

func (b Builder) B(a string) Builder {
	b.config.B = a
	return b
}

func (b Builder) C(a string) Builder {
	b.config.C = a
	return b
}

func (b Builder) Build() Wrap {
	return Wrap{
		A: b.config.A,
		B: b.config.B,
		C: b.config.C,
	}
}

type Wrap struct {
	A string
	B string
	C string
}

func main() {
	builder1 := NewBuilder().A("your").B("cat")
	fmt.Printf("%#v\n", builder1)
	fmt.Printf("%#v\n", builder1.Build())

	builder2 := NewBuilder().A("derp").B("damn")
	fmt.Printf("%#v\n", builder2)
	fmt.Printf("%#v\n", builder2.Build())

	builder3 := NewBuilder().A("foo").B("bar").C("fib")
	fmt.Printf("%#v\n", builder3)
	fmt.Printf("%#v\n", builder3.Build())

	fmt.Printf("%#v\n", NewBuilder().A("a").B("b").C("c").Build())
}
