obj WorkflowMode {
    has key: str = "feature_plan";
    has label: str = "Feature Planning";
    has description: str = "Plan work from repo and meeting context.";
}

obj WorkflowTraceStep {
    has stage: str = "stage_1";
    has agent: str = "Repo Mapper Agent";
    has status: str = "pending";
    has started_at: str = "";
    has finished_at: str = "";
    has detail: str = "";
}

obj WorkflowRequest {
    has repo_path: str = "";
    has meeting_text: str = "";
    has prompt: str = "";
    has mode: str = "feature_plan";
}

obj WorkflowRunState {
    has run_id: str = "";
    has mode: str = "feature_plan";
    has status: str = "idle";
    has summary: str = "";
}

obj ExecutionPlanningContext {
    has resolved_areas: list[str] = [];
    has impacts: list[str] = [];
    has test_gaps: list[str] = [];
    has blocker_titles: list[str] = [];
}
