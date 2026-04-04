def:pub WidgetShell(props: dict) -> JsxElement {
    bundle = props.bundle;
    mode = props.mode or "feature_plan";
    modes = props.modes or [];
    onMode = props.setMode or None;
    onExpand = props.toggleExpanded or None;

    files = (bundle.relevant_files if bundle else []);
    blockers = (bundle.blockers if bundle else []);
    firstTask = ((bundle.action_plan.first_task if bundle else "") or "Waiting for workflow input.");

    def choose(nextMode: str) -> None {
        if onMode { onMode(nextMode); }
    }

    def expand() -> None {
        if onExpand { onExpand(); }
    }

    return <div className="w-full max-w-sm rounded-[1.75rem] border border-border bg-panel/95 p-5 shadow-[var(--shadow-glow)] backdrop-blur">
        <div className="flex items-start justify-between gap-3">
            <div>
                <div className="text-xs uppercase tracking-[0.28em] text-accent-2">Always-on-top sidecar</div>
                <h2 className="mt-2 text-2xl font-bold text-foreground">RepoGhost</h2>
                <p className="mt-1 text-sm text-muted">Mode: {mode}</p>
            </div>
            <button onClick={expand} className="rounded-full border border-border px-3 py-1 text-xs text-muted transition hover:border-border-strong hover:text-foreground">Expand</button>
        </div>
        <div className="mt-4 grid grid-cols-2 gap-2">
            {[
                <button key={item["key"]} onClick={lambda : None -> None { choose(item["key"]); }} className={"rounded-2xl border px-3 py-2 text-left text-sm transition " + ("border-accent bg-accent/15 text-foreground" if item["key"] == mode else "border-border bg-panel-soft text-muted hover:border-border-strong hover:text-foreground")}>
                    {item["label"]}
                </button>
                for item in modes
            ]}
        </div>
        <div className="mt-5 grid grid-cols-3 gap-3 text-center text-xs text-muted">
            <div className="rounded-2xl border border-border bg-panel-soft p-3"><div className="text-lg font-semibold text-foreground">{str(len(files))}</div><div>Files</div></div>
            <div className="rounded-2xl border border-border bg-panel-soft p-3"><div className="text-lg font-semibold text-foreground">{str(len(blockers))}</div><div>Blockers</div></div>
            <div className="rounded-2xl border border-border bg-panel-soft p-3"><div className="text-lg font-semibold text-foreground">3</div><div>Stages</div></div>
        </div>
        <div className="mt-5 rounded-2xl border border-border bg-panel-soft p-4">
            <div className="text-xs uppercase tracking-[0.2em] text-muted">Relevant files</div>
            <div className="mt-3 space-y-2">
                {[
                    <div key={item.path} className="rounded-xl border border-border/70 bg-panel px-3 py-2">
                        <div className="text-sm font-medium text-foreground">{item.path}</div>
                        <div className="mt-1 text-xs text-muted">{item.rationale}</div>
                    </div>
                    for item in files[0:2]
                ]}
            </div>
        </div>
        <div className="mt-4 rounded-2xl border border-border bg-panel-soft p-4">
            <div className="text-xs uppercase tracking-[0.2em] text-muted">Blockers</div>
            <div className="mt-3 space-y-2">
                {[
                    <div key={item.title} className="rounded-xl border border-warning/30 bg-warning/10 px-3 py-2 text-sm text-foreground">{item.title}</div>
                    for item in blockers[0:2]
                ]}
            </div>
        </div>
        <div className="mt-4 rounded-2xl border border-accent/30 bg-accent/10 p-4">
            <div className="text-xs uppercase tracking-[0.2em] text-accent-2">Next step</div>
            <div className="mt-2 text-sm font-medium text-foreground">{firstTask}</div>
        </div>
    </div>;
}
