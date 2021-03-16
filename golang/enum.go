package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"strings"

	"gopkg.in/yaml.v2"
)

type Bookmark struct {
	ID   int  `json:"id" yaml:"id"`
	Kind Kind `json:"kind" yaml:"kind"`
}

// Note: don't implement String interface for Bookmark to prevent stack overflows

type Kind int

const (
	KindInvalid Kind = iota - 1
	KindBlog
	KindPost
	KindVideo
	KindRepository
	KindGist
	KindChannel
)

var kinds = [...]string{
	"blog",
	"channel",
	"gist",
	"post",
	"repository",
	"video",
}

var kindMap = map[string]Kind{
	"blog":       KindBlog,
	"channel":    KindChannel,
	"gist":       KindGist,
	"post":       KindPost,
	"repository": KindRepository,
	"video":      KindVideo,
}

// String interface implementation.
func (k Kind) String() string {
	return kinds[k]
}

// MarshalJSON interface implementation.
func (k Kind) MarshalJSON() ([]byte, error) {
	return []byte(`"` + k.String() + `"`), nil
}

// UnmarshalJSON interface implementation.
func (k *Kind) UnmarshalJSON(data []byte) error {
	v, err := ParseKind(string(bytes.Trim(data, `"`)))
	if err != nil {
		return err
	}

	*k = v
	return nil
}

// MarshalYAML interface implementation.
func (k Kind) MarshalYAML() (interface{}, error) {
	return k.String(), nil
}

// UnmarshalYAML interface implementation.
func (k *Kind) UnmarshalYAML(unmarshal func(interface{}) error) error {
	var s string
	err := unmarshal(&s)
	if err != nil {
		return err
	}

	v, err := ParseKind(s)
	if err != nil {
		return err
	}
	*k = v

	return nil
}

// ParseKind from the given string
func ParseKind(s string) (Kind, error) {
	k, ok := kindMap[strings.ToLower(s)]
	if !ok {
		return KindInvalid, fmt.Errorf("invalid kind %s", s)
	}
	return k, nil
}

// MustParseKind from the given string or panic
func MustParseKind(s string) Kind {
	k, err := ParseKind(s)
	if err != nil {
		panic(fmt.Errorf("invalid kind %s", s))
	}

	return k
}

type Wrapper struct {
	Data Data `json:"data" yaml:"data"`
}

type Data struct {
	Bookmarks []Bookmark `json:"bookmarks" yaml:"bookmarks"`
}

var bookmarks = Wrapper{
	Data{
		[]Bookmark{
			Bookmark{1, MustParseKind("blog")},
			Bookmark{2, MustParseKind("post")},
			Bookmark{3, MustParseKind("video")},
			Bookmark{4, MustParseKind("gist")},
		},
	},
}

var rawJSON = []byte(`[
	{"id": 1, "kind":"blog"},
	{"id": 2, "kind":"channel"},
	{"id": 3, "kind":"gist"},
	{"id": 4, "kind":"repository"}
]`)

var rawYAML = []byte(`[
	{"id": 1, "kind":"blog"},
	{"id": 2, "kind":"channel"},
	{"id": 3, "kind":"gist"},
	{"id": 4, "kind":"repository"}
]`)

func main() {
	bsJ, err := json.Marshal(&bookmarks)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(bsJ))

	var bsJSON []Bookmark
	err = json.Unmarshal(rawJSON, &bsJSON)
	if err != nil {
		log.Fatal(err)
	}

	// fmt.Println(bsJSON)

	for _, b := range bsJSON {
		fmt.Printf("%#v\n", b)
	}

	bsY, err := yaml.Marshal(&bookmarks)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(bsY))

	var bsYAML []Bookmark
	err = yaml.Unmarshal(rawYAML, &bsYAML)
	if err != nil {
		log.Fatal(err)
	}

	for _, b := range bsYAML {
		fmt.Printf("%#v\n", b)
	}
}
