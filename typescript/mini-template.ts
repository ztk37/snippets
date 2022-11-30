type ParamValue = boolean | number | string

function render(input: string, params: Record<string, ParamValue>): string {
    const normalized = input
        .replace(/(\{\{\s+)/g, "{{")
        .replace(/(\s+\}\})/g, "}}");

    return Object.entries(params).reduce((result, [key, value]) => {
        return result.replace(`{{${key}}}`, String(value))
    }, normalized)
}

const template = `
Foo {{a}} Bar {{ b }}

{{c}} llalalalal {{ d }}
`.trim();

console.log(render(template, {
  a: 1,
  b: 2,
  c: 3,
  d: 4
 }));
