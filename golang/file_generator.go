package main

import (
	"bytes"
	"fmt"
	"log"
	"os"
	"text/template"
)

var tpl = `# {{.Title}}

## License

> [MIT]()
`

type Generator struct {
	GenRollupConfigFile func() []byte
	Error               error
}

func main() {
	gen := Generator{
		GenRollupConfigFile: func() []byte {
			var buf bytes.Buffer
			t, err := template.New("").Parse(tpl)

			if err != nil {
				log.Fatal(err)
			}

			err = t.Execute(&buf, struct {
				Title string
			}{
				Title: "Foo",
			})

			if err != nil {
				log.Fatal(err)
			}

			return buf.Bytes()
		},
	}

	c := gen.GenRollupConfigFile()

	fmt.Println(c)
	fmt.Println(len(c))

	f, err := os.Create("/tmp/dat2")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	n, err := f.Write(c)
	fmt.Println(n)
}
