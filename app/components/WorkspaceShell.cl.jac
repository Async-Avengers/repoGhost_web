def:pub WorkspaceShell(props: dict) -> JsxElement {
    bundle = props.bundle;
    tabs = props.tabs or [];
    mode = props.mode or "feature_plan";
    trace = (bundle.trace if bundle else []);
    tasks = (bundle.tasks if bundle else []);
    tickets = (bundle.tickets if bundle else []);
    blockers = (bundle.blockers if bundle else []);

    return <div className="grid min-h-[720px] grid-cols-12 gap-4 rounded-[2rem] border border-border bg-panel/90 p-4 shadow-[var(--shadow-glow)] backdrop-blur">
        <aside className="col-span-12 rounded-[1.5rem] border border-border bg-panel-soft p-4 lg:col-span-2">
            <div className="text-xs uppercase tracking-[0.24em] text-muted">Modes</div>
            <div className="mt-3 rounded-2xl border border-accent/30 bg-accent/10 px-3 py-2 text-sm font-medium text-foreground">{mode}</div>
            <div className="mt-6 text-xs uppercase tracking-[0.24em] text-muted">Runs</div>
            <div className="mt-3 space-y-2">
                {[
                    <div key={step.agent} className="rounded-xl border border-border bg-panel px-3 py-2 text-sm text-muted">
                        <div className="font-medium text-foreground">{step.agent}</div>
                        <div className="mt-1 text-xs uppercase tracking-[0.18em]">{step.status}</div>
                    </div>
                    for step in trace
                ]}
            </div>
        </aside>
        <section className="col-span-12 rounded-[1.5rem] border border-border bg-panel-soft p-5 lg:col-span-6">
            <div className="flex items-center justify-between gap-3">
                <div>
                    <div className="text-xs uppercase tracking-[0.24em] text-accent-2">Assistant thread</div>
                    <h3 className="mt-2 text-2xl font-semibold text-foreground">Chat-first engineering workspace</h3>
                </div>
                <div className="rounded-full border border-border px-3 py-1 text-xs text-muted">Live trace visible</div>
            </div>
            <div className="mt-5 rounded-[1.5rem] border border-border bg-panel p-4">
                <div className="text-sm text-muted">Repo overview</div>
                <div className="mt-2 text-lg font-semibold text-foreground">{bundle.repo_summary.overview if bundle else "Waiting for workflow bundle."}</div>
                <div className="mt-4 grid gap-3 md:grid-cols-2">
                    <div className="rounded-2xl border border-border bg-panel-soft p-4">
                        <div className="text-xs uppercase tracking-[0.18em] text-muted">Meeting summary</div>
                        <p className="mt-2 text-sm leading-6 text-foreground">{bundle.meeting_summary.summary if bundle else ""}</p>
                    </div>
                    <div className="rounded-2xl border border-border bg-panel-soft p-4">
                        <div className="text-xs uppercase tracking-[0.18em] text-muted">Action plan</div>
                        <p className="mt-2 text-sm leading-6 text-foreground">{bundle.action_plan.headline if bundle else ""}</p>
                    </div>
                </div>
            </div>
            <div className="mt-4 rounded-[1.5rem] border border-border bg-panel p-4">
                <div className="text-xs uppercase tracking-[0.18em] text-muted">Agent timeline</div>
                <div className="mt-3 space-y-3">
                    {[
                        <div key={step.agent + step.stage} className="flex items-start gap-3 rounded-2xl border border-border bg-panel-soft px-4 py-3">
                            <div className={"mt-1 h-2.5 w-2.5 rounded-full " + ("bg-success" if step.status == "done" else ("bg-warning" if step.status == "running" else "bg-muted"))} />
                            <div>
                                <div className="text-sm font-medium text-foreground">{step.agent}</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-muted">{step.stage + " • " + step.status}</div>
                                <div className="mt-2 text-sm text-muted">{step.detail}</div>
                            </div>
                        </div>
                        for step in trace
                    ]}
                </div>
            </div>
        </section>
        <section className="col-span-12 rounded-[1.5rem] border border-border bg-panel-soft p-5 lg:col-span-4">
            <div className="flex flex-wrap gap-2">
                {[<div key={tab} className="rounded-full border border-border bg-panel px-3 py-1 text-xs text-muted">{tab}</div> for tab in tabs]}
            </div>
            <div className="mt-5 space-y-4">
                <div className="rounded-2xl border border-border bg-panel p-4">
                    <div className="text-xs uppercase tracking-[0.18em] text-muted">Tasks</div>
                    <div className="mt-3 space-y-3">{[
                        <div key={task.title} className="rounded-xl border border-border bg-panel-soft px-3 py-3">
                            <div className="text-sm font-medium text-foreground">{task.title}</div>
                            <div className="mt-1 text-xs text-muted">{task.summary}</div>
                        </div>
                        for task in tasks
                    ]}</div>
                </div>
                <div className="rounded-2xl border border-border bg-panel p-4">
                    <div className="text-xs uppercase tracking-[0.18em] text-muted">Tickets</div>
                    <div className="mt-3 space-y-3">{[
                        <div key={ticket.title} className="rounded-xl border border-border bg-panel-soft px-3 py-3">
                            <div className="flex items-center justify-between gap-3"><div className="text-sm font-medium text-foreground">{ticket.title}</div><div className="rounded-full border border-border px-2 py-0.5 text-[10px] uppercase tracking-[0.18em] text-muted">{ticket.priority}</div></div>
                            <div className="mt-1 text-xs text-muted">{ticket.summary}</div>
                        </div>
                        for ticket in tickets
                    ]}</div>
                </div>
                <div className="rounded-2xl border border-border bg-panel p-4">
                    <div className="text-xs uppercase tracking-[0.18em] text-muted">Blockers</div>
                    <div className="mt-3 space-y-2">{[
                        <div key={item.title} className="rounded-xl border border-danger/30 bg-danger/10 px-3 py-2 text-sm text-foreground">{item.title}</div>
                        for item in blockers
                    ]}</div>
                </div>
            </div>
        </section>
    </div>;
}
