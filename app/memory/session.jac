import from ..models.core { RepoSelection, ChatMessage }
import from ..models.outputs { WorkflowResultBundle }
import from ..models.workflow { WorkflowRunState }

obj SessionMemory {
    has session_id: str = "default-session";
    has repo: RepoSelection = RepoSelection();
    has messages: list[ChatMessage] = [];
    has current_mode: str = "feature_plan";
    has runs: list[WorkflowRunState] = [];
    has latest_result: WorkflowResultBundle = WorkflowResultBundle();
}
