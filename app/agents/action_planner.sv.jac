import from ..models.workflow { WorkflowRequest, ExecutionPlanningContext }
import from ..models.outputs { ActionPlan, TaskItem }


def collect_dependencies(planning: ExecutionPlanningContext) -> list[str] {
    deps: list[str] = [];
    for item in planning.blocker_titles[0:4] {
        deps.append(item);
    }
    if len(deps) == 0 {
        deps = ["repo access", "meeting context", "planning context"];
    }
    return deps;
}


def:pub build_action_plan(request: WorkflowRequest, planning: ExecutionPlanningContext, files: list) -> ActionPlan {
    first_task = "Validate the top resolved files against the current request.";
    next_task = "Turn the planning context into execution-ready tickets and handoff artifacts.";
    if len(planning.resolved_areas) > 0 {
        first_task = "Inspect " + planning.resolved_areas[0] + " and confirm the implementation boundary.";
    }
    if request.mode == "standup" {
        first_task = "Summarize completed context-building and reasoning work for the team update.";
        next_task = "Highlight the next execution slice and any blockers that need owner follow-up.";
    } elif request.mode == "handoff" {
        first_task = "Capture the current state of the repo, planning context, and open risks.";
        next_task = "Package next actions for the incoming developer with likely files and dependencies.";
    } elif request.mode == "review_prep" {
        first_task = "Group changed areas and risk hotspots into a reviewer-friendly scope.";
        next_task = "Generate a checklist grounded in blockers, impacts, and test gaps.";
    }
    return ActionPlan(
        headline="RepoGhost generated a staged execution plan from repo, meeting, graph, and planning context.",
        first_task=first_task,
        next_task=next_task,
        phases=["Stage 1 ingest", "Stage 1 merge", "Stage 2 reasoning", "Stage 2 merge", "Stage 3 output generation", "Execution handoff"]
    );
}


def:pub build_action_tasks(request: WorkflowRequest, planning: ExecutionPlanningContext, files: list) -> list[TaskItem] {
    likely_files: list[str] = [];
    for item in files[0:5] {
        likely_files.append(item.path);
    }
    deps = collect_dependencies(planning);
    tasks: list[TaskItem] = [
        TaskItem(
            title="Confirm execution boundary",
            summary="Use resolved areas and graph focus paths to lock the scope before implementation starts.",
            phase="Phase A",
            dependencies=deps,
            likely_files=planning.resolved_areas[0:4]
        ),
        TaskItem(
            title="Address blocker and dependency risks",
            summary="Resolve missing requirements, contracts, and downstream dependencies surfaced by Stage 2.",
            phase="Phase B",
            dependencies=planning.blocker_titles[0:4],
            likely_files=likely_files
        ),
        TaskItem(
            title="Implement and validate changes",
            summary="Execute the work in the highest-signal files and cover the riskiest paths with tests.",
            phase="Phase C",
            dependencies=["confirmed scope", "risk review"],
            likely_files=likely_files
        ),
        TaskItem(
            title="Prepare delivery artifacts",
            summary="Generate tickets, standup, handoff, and review prep from the merged planning context.",
            phase="Phase D",
            dependencies=["planning context", "implementation notes"],
            likely_files=["app/orchestration/workflow.sv.jac", "app/components/WorkspaceShell.cl.jac"]
        )
    ];
    if request.mode == "meeting_to_tickets" {
        tasks[0].title = "Convert meeting language into execution slices";
        tasks[0].summary = "Turn action items, decisions, and blockers into a prioritized engineering sequence.";
    }
    return tasks;
}
