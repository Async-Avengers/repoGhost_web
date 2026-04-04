def:pub defaultModes() -> list[dict] {
    return [
        {"key": "bug_fix", "label": "Bug Fix"},
        {"key": "feature_plan", "label": "Feature Plan"},
        {"key": "standup", "label": "Standup"},
        {"key": "handoff", "label": "Handoff"},
        {"key": "review_prep", "label": "Review Prep"}
    ];
}

def:pub defaultTabs() -> list[str] {
    return ["Context", "Files", "Tasks", "Tickets", "Blockers", "Handoff", "Standup", "Review", "Memory", "Trace"];
}

def:pub shellTitle() -> str {
    return "RepoGhost";
}
