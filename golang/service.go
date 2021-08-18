package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
)

type Todo struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	Done        bool   `json:"done"`
}

type TodoService interface {
	Find(id int) (*Todo, error)
	With(todo Todo) TodoService
	Each(func(todo Todo))
	All() []Todo
}

type service struct {
	todos map[int]Todo
}

func (s service) With(todo Todo) TodoService {
	s.todos[todo.ID] = todo
	return s
}

func (s service) Each(f func(Todo)) {
	for _, todo := range s.todos {
		f(todo)
	}
}

func (s service) Find(id int) (*Todo, error) {
	if todo, found := s.todos[id]; found {
		return &todo, nil
	}

	return nil, errors.New("not found")
}

func (s service) All() (todos []Todo) {
	for _, todo := range s.todos {
		todos = append(todos, todo)
	}
	return
}

func New() TodoService {
	return &service{
		todos: make(map[int]Todo),
	}
}

func main() {
	svc := New().
		With(Todo{
			ID:    1,
			Title: "Foo",
		}).
		With(Todo{
			ID:    2,
			Title: "Bar",
		}).
		With(Todo{
			ID:    3,
			Title: "Fib",
		}).
		With(Todo{
			ID:    4,
			Title: "Baz",
		})

	svc.Each(func(todo Todo) {
		fmt.Printf("%#v\n", todo)
	})

	todo, err := svc.Find(1)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	fmt.Printf("%#v\n", todo)

	all := svc.All()

	fmt.Println(json.NewEncoder(os.Stdout).Encode(&all))

}
