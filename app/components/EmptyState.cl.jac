def:pub EmptyState(props: dict) -> JsxElement {
    title = props.title or "Nothing here yet";
    detail = props.detail or "Run RepoGhost to populate this panel.";
    return <div className="rounded-2xl border border-border bg-panel-soft p-5 text-sm text-muted shadow-[var(--shadow-panel)]">
        <div className="text-base font-semibold text-foreground">{title}</div>
        <p className="mt-2 leading-6">{detail}</p>
    </div>;
}
