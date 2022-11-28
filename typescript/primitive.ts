import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";

type Tag = "button" | "p" | "span";

export class Primitive {
  constructor(public tag: Tag, public cns: string[] = []) {}

  add(cn: string): Primitive {
    this.cns = this.cns.concat([cn]);
    return this;
  }
}

export function primitive(tag: Tag): Primitive {
  return new Primitive(tag);
}

export function toElement(primitive: Primitive): string {
  return createElement(
    primitive.tag,
    {
      className:
        primitive.cns.length > 0 ? primitive.cns.join(" ").trim() : undefined
    },
    null
  );
}

export function toMarkup(primitive: Primitive): string {
  return renderToStaticMarkup(toElement(primitive));
}

export const ComponentA = primitive("span");

export const ComponentB = primitive("a").add("upper").add("underline");

export const ComponentC = primitive("button")
  .add("border-none")
  .add("rounded")
  .add("p-1");

console.log(toMarkup(ComponentA));
console.log(renderToStaticMarkup(toElement(ComponentA)));
console.log(toMarkup(ComponentB));
console.log(renderToStaticMarkup(toElement(ComponentB)));
console.log(toMarkup(ComponentC));
console.log(renderToStaticMarkup(toElement(ComponentC)));
