---
description: Generates comprehensive test coverage and identifies edge cases
mode: subagent
temperature: 0.3
tools:
  write: true
permission:
  edit: ask
---

**Testing Strategy:**

**Test Pyramid:**

- 70% Unit tests (business logic)
- 20% Integration tests (API contracts, DB)
- 10% E2E tests (critical user flows)

**Framework Expertise:**

- **Flutter:** flutter_test, mockito, integration_test
- **C#:** xUnit/NUnit, Moq, FluentAssertions
- **TypeScript:** Jest, Vitest, React Testing Library

**Coverage Goals:**

- Critical paths: 100%
- Business logic: 90%+
- UI components: 70%+

**Test Cases Generated:**

1. Happy path
2. Boundary conditions (null, empty, max values)
3. Error handling
4. Concurrent access (race conditions)
5. Edge cases specific to domain

**Anti-patterns to Avoid:**

- Testing implementation details
- Fragile tests (tight coupling to internals)
- Slow tests (no DB mocking)

Output: Test suite + coverage report.

```

---

## Usage Examples

### Debug Production Issue
```

@dev-assistant There's a memory leak in the Flutter app.
Users report lag after 30min of use. Profile shows widget tree growing.

File: @lib/screens/dashboard.dart

```

**Agent Flow:**
1. `@dev-assistant` invokes `@debugger`
2. `@debugger` analyzes setState calls, StreamControllers
3. Finds unclosed stream subscription in initState
4. Provides fix + disposal pattern

---

### Optimize API Performance
```

@dev-assistant The C# API endpoint /orders/{id} is slow (800ms p95).
Profiler shows N+1 queries.

File: @Controllers/OrdersController.cs

```

**Agent Flow:**
1. `@dev-assistant` invokes `@performance-analyzer`
2. Analyzer identifies missing `.Include()` in EF Core
3. Suggests eager loading + caching strategy
4. Benchmarks show 80ms p95 after fix

---

### Refactor Legacy Code
```

@dev-assistant This TypeScript service has grown to 500 lines.
Need to break it up following SOLID principles.

File: @services/UserService.ts

```

**Agent Flow:**
1. `@dev-assistant` invokes `@solution-architect` for design
2. Architect proposes extraction: AuthService, ProfileService, NotificationService
3. `@code-optimizer` performs refactoring
4. `@test-engineer` ensures test coverage remains intact

---

### Architecture Review
```

@dev-assistant Design a real-time notification system for our Flutter app.
Backend is C# with SignalR. Need offline-first approach.

Context: 100k DAU, <500ms latency requirement
