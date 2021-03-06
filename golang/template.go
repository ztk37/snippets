package main

import (
	"log"
	"os"
	"text/template"
)

const raw = `# {{.Title}}

## Contents
{{range .Contents}}
{{- if .Done}}
- [x] {{.Text}}
{{- else}}
- [ ] {{.Text}}
{{- end}}
{{- end}}

## License

> [MIT]({{.URL}}) licensed`

type Item struct {
	Done bool
	Text string
}

func main() {
	t, err := template.New("").Parse(raw)
	if err != nil {
		log.Fatal(err)
	}

	err = t.Execute(os.Stdout, struct {
		Title    string
		Contents []Item
		URL      string
	}{
		Title: "Project - 0F3D9D",
		Contents: []Item{
			Item{
				Done: true,
				Text: "Foo",
			},
			Item{
				Done: false,
				Text: "Bar",
			},
			Item{
				Done: false,
				Text: "Fib",
			},
		},
		URL: "asdasd",
	})
	if err != nil {
		log.Fatal(err)
	}
}
