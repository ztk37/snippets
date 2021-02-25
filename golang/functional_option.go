package golang

import (
	"fmt"
)

type State struct {
	current string
	active  bool
}

type Option func(*State)

func Current(v string) Option {
	return func(s *State) {
		s.current = v
	}
}

func Active() Option {
	return func(s *State) {
		s.active = true
	}
}

func New(opts ...Option) *State {
	state := &State{
		current: "",
		active:  false,
	}

	for _, opt := range opts {
		opt(state)
	}

	return state
}

func run() {
	s1 := New()
	fmt.Printf("%#v\n", s1)

	s2 := New(Current("damn!"))
	fmt.Printf("%#v\n", s2)

	s3 := New(
		Current("yeah?"),
		Active(),
	)
	fmt.Printf("%#v\n", s3)
}
