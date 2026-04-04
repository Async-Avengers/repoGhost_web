import from ..models.workflow { WorkflowRequest }
import from ..models.outputs { WorkflowResultBundle }
import from ..services.demo_data { get_demo_bundle }

def:pub run_workflow(repo_path: str, meeting_text: str, prompt: str, mode: str = "feature_plan") -> WorkflowResultBundle {
    request = WorkflowRequest(repo_path=repo_path, meeting_text=meeting_text, prompt=prompt, mode=mode);
    bundle = get_demo_bundle();
    if request.prompt {
        bundle.action_plan.headline = "Current request: " + request.prompt;
    }
    if request.repo_path {
        bundle.repo_summary.project_name = request.repo_path;
    }
    return bundle;
}
