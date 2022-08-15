interface AttributeSet {
    [attr: string]: string | number
}

type Children = VirtualNode | VirtualNode[] | string | number | null

interface VirtualNode {
    tag: string;
    attributes: AttributeSet;
    children: Children
}

export function h(tag: string, attributes: AttributeSet, children: Children): VirtualNode {
    return {
        tag,
        attributes,
        children
    }
}

function renderAttributeSet(attributes: AttributeSet): string {
    return Object.entries(attributes).map(([attr, value]: [string, (string | number)]) => `${attr}="${value}"`).join(" ")
}

function renderChildren(children: Children): string {
    if (!children) return ""

    if (typeof children === "string") {
        return children
    }

    if (typeof children === "number") {
        return `${children}`
    }

    if (Array.isArray(children)) {
        return children.map(renderChildren).join("")
    }

    if (typeof children === "object") {
        return render(children)
    }

    // Make typescript happy
    return ""
}

export function render(node: VirtualNode): string {
    return `<${node.tag} ${renderAttributeSet(node.attributes)}>${renderChildren(node.children)}</${node.tag}>`
}

export const svg = h("svg", {
    xmlns: "http://www.w3.org/2000/svg",
    height: "42",
    width: "42",
}, [
    h("circle", {
        cx: "21",
        cy: "21",
        r: "18",
        stroke: "black",
        "stroke-width": "2",
        fill: "purple"
    }, null),
    h("text", {
        x: "50%",
        y: "50%",
        "text-anchor": "middle",
        fill: "white",
        "font-size": "16px",
        "font-family": "Arial",
        dy: ".3em"
    }, "Fiz")
]);

console.log(render(svg))
