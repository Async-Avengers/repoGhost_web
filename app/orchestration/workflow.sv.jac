import from ..models.workflow { WorkflowRequest }
import from ..models.outputs { WorkflowResultBundle }
import from ..services.demo_data { get_demo_bundle }

def:pub run_workflow(repo_path: str, meeting_text: str, prompt: str, mode: str = "feature_plan") -> WorkflowResultBundle {
    request = WorkflowRequest(repo_path=repo_path, meeting_text=meeting_text, prompt=prompt, mode=mode);
    bundle = get_demo_bundle();

    if request.prompt {
        bundle.action_plan.headline = "Current request: " + request.prompt;
        bundle.action_plan.first_task = "Resolve the request in mode " + request.mode + " using the seeded workflow context.";
        bundle.action_plan.next_task = "Promote the seeded stage outputs into real repo ingestion and graph merges.";
        bundle.handoff.summary = "Latest request: " + request.prompt;
        bundle.review.summary = "Review scope for request: " + request.prompt;
    }
    if request.repo_path {
        bundle.repo_summary.project_name = request.repo_path;
        bundle.repo_summary.overview = "RepoGhost is analyzing the permitted repo at " + request.repo_path + " and mapping meeting context into engineering output.";
    }
    if request.meeting_text {
        bundle.meeting_summary.summary = request.meeting_text;
    }
    if request.mode == "bug_fix" {
        bundle.tickets[0].title = "Investigate likely regression path";
        bundle.tickets[0].summary = "Trace the issue through the most relevant files, blockers, and downstream impact.";
    } elif request.mode == "standup" {
        bundle.action_plan.headline = "Current request: generate a concise standup update grounded in the seeded workflow bundle.";
    } elif request.mode == "handoff" {
        bundle.action_plan.headline = "Current request: prepare a developer handoff with context, risks, and next actions.";
    } elif request.mode == "review_prep" {
        bundle.action_plan.headline = "Current request: prepare review scope, hotspots, and a reviewer checklist.";
    }

    return bundle;
}
