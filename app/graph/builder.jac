import from .nodes {
    ProjectNode, MeetingNode, RequestNode, WorkflowRunNode, ResultBundleNode,
    RepoSummaryNode, DecisionNode, BlockerNode, TicketNode, TaskNode
}

obj GraphBuildRefs {
    has project_ref: ProjectNode;
    has meeting_ref: MeetingNode;
    has request_ref: RequestNode;
    has run_ref: WorkflowRunNode;
    has result_ref: ResultBundleNode;
}

walker build_project_context {
    has project_name: str = "RepoGhost";
    has repo_path: str = "";

    can enter with Root entry {
        project = (root() ++> ProjectNode(name=self.project_name, repo_path=self.repo_path))[0];
        meeting = (project ++> MeetingNode(title="Current Meeting"))[0];
        request = (project ++> RequestNode(prompt="", mode="feature_plan"))[0];
        run = (project ++> WorkflowRunNode(run_id="seed-run", status="ready"))[0];
        result = (run ++> ResultBundleNode())[0];
        report GraphBuildRefs(project_ref=project, meeting_ref=meeting, request_ref=request, run_ref=run, result_ref=result);
    }
}

walker attach_stage_one_summary {
    has overview: str = "";

    can enter with ProjectNode entry {
        here ++> RepoSummaryNode(overview=self.overview);
    }
}

walker attach_stage_outputs {
    can enter with ResultBundleNode entry {
        here ++> DecisionNode(title="Architecture preserved", detail="RepoGhost keeps staged multi-agent flow.");
        here ++> BlockerNode(title="Repo path permissions", severity="medium");
        here ++> TaskNode(title="Run stage 1 ingestion", summary="Scan repo, parse meeting, sync docs.");
        here ++> TicketNode(title="Implement staged orchestration", priority="high");
    }
}
