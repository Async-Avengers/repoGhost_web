import from ..hooks.useRepoGhost { useRepoGhost }
import from .WidgetShell { WidgetShell }
import from .WorkspaceShell { WorkspaceShell }
import from .ErrorBanner { ErrorBanner }

def:pub AppShell() -> JsxElement {
    data = useRepoGhost();
    bundle = data["bundle"];
    error = data["error"] or "";

    return <div className="min-h-screen bg-background text-foreground">
        <div className="mx-auto max-w-[1600px] px-4 py-6 lg:px-6">
            <div className="mb-6 flex flex-col gap-4 rounded-[2rem] border border-border bg-panel/80 p-5 shadow-[var(--shadow-glow)] backdrop-blur lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <div className="text-xs uppercase tracking-[0.32em] text-accent-2">Desktop-ready Jac sidecar</div>
                    <h1 className="mt-3 text-4xl font-extrabold tracking-tight text-foreground">RepoGhost</h1>
                    <p className="mt-2 max-w-3xl text-sm leading-6 text-muted">An agentic developer workspace that ingests repo structure and meeting context, builds a live project graph, and turns conversation into engineering output.</p>
                </div>
                <div className="grid grid-cols-2 gap-3 text-sm text-muted md:grid-cols-4">
                    <div className="rounded-2xl border border-border bg-panel-soft px-4 py-3"><div className="text-xs uppercase tracking-[0.18em]">Mode</div><div className="mt-1 font-semibold text-foreground">{data["mode"]}</div></div>
                    <div className="rounded-2xl border border-border bg-panel-soft px-4 py-3"><div className="text-xs uppercase tracking-[0.18em]">Repo</div><div className="mt-1 font-semibold text-foreground">{data["repoPath"]}</div></div>
                    <div className="rounded-2xl border border-border bg-panel-soft px-4 py-3"><div className="text-xs uppercase tracking-[0.18em]">Status</div><div className="mt-1 font-semibold text-foreground">{("Loading" if data["loading"] else "Ready")}</div></div>
                    <div className="rounded-2xl border border-border bg-panel-soft px-4 py-3"><div className="text-xs uppercase tracking-[0.18em]">Trace</div><div className="mt-1 font-semibold text-foreground">Visible</div></div>
                </div>
            </div>
            {error and (<div className="mb-4"><ErrorBanner message={error} /></div>)}
            <div className="grid gap-5 xl:grid-cols-[360px_minmax(0,1fr)]">
                <WidgetShell bundle={bundle} mode={data["mode"]} modes={data["modes"]} setMode={data["setMode"]} toggleExpanded={data["toggleExpanded"]} />
                <WorkspaceShell bundle={bundle} tabs={data["tabs"]} mode={data["mode"]} />
            </div>
        </div>
    </div>;
}
