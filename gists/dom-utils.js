const $ = document.querySelector.bind(document);
const $$ = document.querySelectorAll.bind(document);

function createNote(tag) {
    return document.createElement(tag);
}

function append(parent, element) {
    return parent.append(element);
}

function clear(parent) {
    while(parent.hasChildNodes()) {
        parent.removeChild(parent.firstChild);
    }
}
