// You can edit this code!
// Click here and start typing.
package main

import (
	"context"
	"fmt"
)

type User struct{}

type UserService interface {
	GetUsers(ctx context.Context) ([]User, error)
	GetUserById(ctx context.Context, id int) (User, error)
}

type userService struct{}

func New() UserService {
	return &userService{}
}

var _ UserService = (*userService)(nil)

func (self userService) GetUserById(ctx context.Context, id int) (User, error) {
	return User{}, nil
}

func (self userService) GetUsers(ctx context.Context) ([]User, error) {
	users := []User{}

	return users, nil
}

// type mockUserSercice struct{}

// var _ UserService = (*mockUserService)(nil)

func main() {
	service := New()

	fmt.Printf("%#v\n", service)
}
