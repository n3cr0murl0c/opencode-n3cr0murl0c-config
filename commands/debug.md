---
description: Quick debug session with context gathering
subtask: true
temperature: 0.2
---

@debugger analyze this error:

{clipboard}

Context:

- Stack trace: {file:logs/error.log}
- Recent changes: git log -5 --oneline
