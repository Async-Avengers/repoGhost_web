import from app.services.demo_data { get_demo_bundle }
import from app.orchestration.workflow { run_workflow }
cl import from app.components.Layout { Layout }

cl {
    def:pub app() -> JsxElement {
        return <Layout />;
    }
}
