sv import from ..orchestration.workflow { run_workflow }
import from ..lib.ui_state { defaultModes, defaultTabs }

def:pub useRepoGhost() -> dict {
    has repoPath: str = "c:/workspace/permitted-repo";
    has meetingText: str = "We need to turn meeting context into tickets, blockers, and a handoff.";
    has prompt: str = "Turn this meeting into tickets and show likely files.";
    has mode: str = "feature_plan";
    has loading: bool = True;
    has error: str = "";
    has bundle: any = None;
    has expanded: bool = True;

    async def loadBundle() -> None {
        loading = True;
        error = "";
        try {
            bundle = await run_workflow(repoPath, meetingText, prompt, mode);
        } except Exception as e {
            error = str(e);
        }
        loading = False;
    }

    async can with entry {
        await loadBundle();
    }

    async def submit(nextPrompt: str = "") -> None {
        if nextPrompt {
            prompt = nextPrompt;
        }
        await loadBundle();
    }

    def setMode(nextMode: str) -> None {
        mode = nextMode;
    }

    def toggleExpanded() -> None {
        expanded = not expanded;
    }

    return {
        "repoPath": repoPath,
        "meetingText": meetingText,
        "prompt": prompt,
        "mode": mode,
        "loading": loading,
        "error": error,
        "bundle": bundle,
        "expanded": expanded,
        "modes": defaultModes(),
        "tabs": defaultTabs(),
        "submit": submit,
        "setMode": setMode,
        "toggleExpanded": toggleExpanded
    };
}
