interface AppPlugin {
    id: string
    run(params: Params): void
}

type Params = {
    [key: string]: string
}

class App {
    private _params: Params = {}
    private _registry: { [key: string]: AppPlugin } = {}

    static defaults() {
        return new App();
    }

    params(params: Params) {
        this._params = Object.assign({}, this._params, params)
        return this
    }

    param(key: string, value: string) {
        this._params[key] = value
        return this
    }

    register(plugin: AppPlugin) {
        this._registry[plugin.id] = plugin;
        return this
    }

    async run() {
        for (const plugin of Object.values(this._registry)) {
            plugin.run(this._params)
        }
    }
}

(async () => {
    await App
        .defaults()
        .param("a", "1")
        .param("b", "2")
        .param("c", "3")
        .register({
            id: "foo",
            run() {
                console.log("foo")
            }
        })
        .register({
            id: "bar",
            run() {
                console.log("bar")
            }
        })
        .register({
            id: "fib",
            run(params) {
                console.log("fib", params)
            }
        })
        .run()


    const app = App
        .defaults()
        .params({
            "a": "1",
            "b": "2",
            "c": "3"
        })
        .register({
            id: "foo",
            run() {
                console.log("foo")
            }
        })
        .register({
            id: "bar",
            run() {
                console.log("bar")
            }
        })
        .register({
            id: "fib",
            run(params) {
                console.log("fib", params)
            }
        });

    await app.run()
})();
