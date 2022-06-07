interface AppPlugin {
    id: string
    run(params: Params): void
}

type Params = {
    [key: string]: string
}

class App {
    private params: Params = {}
    private registry: { [key: string]: AppPlugin } = {}

    static defaults() {
        return new App();
    }

    param(key: string, value: string) {
        this.params[key] = value
        return this
    }

    register(plugin: AppPlugin) {
        this.registry[plugin.id] = plugin;
        return this
    }

    async run() {
        for (const plugin of Object.values(this.registry)) {
            plugin.run(this.params)
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


    const app = await App
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
        });

    app.run()
})();
