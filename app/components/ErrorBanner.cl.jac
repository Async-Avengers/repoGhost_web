def:pub ErrorBanner(props: dict) -> JsxElement {
    message = props.message or "Something went wrong.";
    return <div className="rounded-2xl border border-danger/40 bg-danger/10 px-4 py-3 text-sm text-red-100 shadow-[var(--shadow-panel)]">
        <div className="font-semibold">RepoGhost error</div>
        <div className="mt-1 text-red-100/90">{message}</div>
    </div>;
}
