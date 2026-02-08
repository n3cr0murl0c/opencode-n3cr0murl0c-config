---
trigger: always_on
---

# Development Rules and Project Standards

## Session Initialization Protocol

1. **Mandatory Initial Analysis**
   - Search and read `AGENTS.MD` (standard project context file)
   - If it doesn't exist, create it with the project structure
   - Review `README.md` to understand general architecture and business rules (what the application does or aims to achieve)
   - Read all `TODO.md` files from each component to understand current status

2. **Required Documentation Structure**

```
/
├── AGENTS.MD          # Change history and RCA
├── README.md          # General documentation
└── [Module]/
    └── TODO.md        # Pending tasks per module
```

## Development Process

### Phase 1: Analysis and Planning

1. **Before Modifying Code**
   - Analyze user request
   - If the request is a question, explain to the user so they understand the technical solutions
   - Present implementation alternatives
   - Compare options in terms of:
     - Performance (CPU/Memory)
     - Scalability
     - Maintainability
     - Cloud resource costs
   - **WAIT for user confirmation before proceeding**

2. **Priority Optimization**
   - Minimize CPU and memory usage
   - Reduce unnecessary network calls
   - Implement lazy loading when possible
   - Cache data appropriately
   - Use const widgets in Flutter
   - Avoid unnecessary rebuilds

### Phase 2: Implementation

1. **Preventive Versioning**
   - Create local commit (without push) before breaking changes
   - Descriptive commit message of stable state
   - Allows quick rollback in case of corruption

2. **Per-File Commit Convention**
   - **One commit per modified file** - each file changed must have its own dedicated commit
   - **Commit message must explain**:
     - WHAT was changed
     - WHY it was changed
     - WHAT was made/improved/fixed
   - **Commit message format**:

     ```
     [component/area] filename.dart: Description of what changed and why

     - Changed/improved/fixed: specific detail
     - Impact: performance, functionality, or behavior change
     ```

   **Example**:

   ```
   [auth/login] login_repository.dart: Added retry logic for failed authentication requests

   - Implemented exponential backoff for network retry
   - Improved: reduced failed login attempts by 40%
   - Added: timeout handling for slow network conditions
   ```

   **Process**:
   1. Stage modified file: `git add path/to/file.dart`
   2. Commit with descriptive message explaining the change
   3. Repeat for each modified file independently
   4. Use `git status` to verify one file per commit

3. **Per-File Commit Convention**
   - **One commit per modified file** - each file changed must have its own dedicated commit
   - **Commit message must explain**:
     - WHAT was changed
     - WHY it was changed
     - WHAT was made/improved/fixed
   - **Commit message format**:

     ```
     [component/area] filename.dart: Description of what changed and why

     - Changed/improved/fixed: specific detail
     - Impact: performance, functionality, or behavior change
     ```

   **Example**:

   ```
   [auth/login] login_repository.dart: Added retry logic for failed authentication requests

   - Implemented exponential backoff for network retry
   - Improved: reduced failed login attempts by 40%
   - Added: timeout handling for slow network conditions
   ```

   **Process**:
   1. Stage modified file: `git add path/to/file.dart`
   2. Commit with descriptive message explaining the change
   3. Repeat for each modified file independently
   4. Use `git status` to verify one file per commit

4. **Code Standards**
   - **Flutter**: Maintain stable channel, Async/await, dependency injection, SOLID
   - **React**: Strict TypeScript, optimized hooks, Separation of Concerns per Component
   - **C# .NET**: Async/await, dependency injection, SOLID
   - Follow framework-specific best practices
   - Consistent and descriptive naming
   - Comments only when logic is not self-explanatory (no emojis)

5. **Logging**
   - **Flutter**: Use `debugPrint()` exclusively
   - **React**: Use `console.log/warn/error`
   - **C#**: Use ILogger (serilog) with appropriate levels
   - **PROHIBITED**: Emojis in logs
   - If you find emojis, replace them with tags: `[INFO]`, `[WARN]`, `[ERROR]`, `[SUCCESS]`
   - Format: `[LEVEL] Component: Descriptive message`

### Phase 3: Validation

1. **Testing by Stack**

   **Flutter:**

```bash
   flutter analyze
   flutter test
   flutter run --profile  # For performance analysis
```

**React + Vite:**

```bash
   bun run lint
   bun run test
   bun run build
   bun run start
```

**C# .NET:**

```bash
   dotnet build
   dotnet test
   dotnet run
```

2. **Stress Testing with Worst Case Scenarios**

   **Mandatory Standards:**
   - **95% minimum success rate** in all stress tests
   - **Maximum response time: 1 minute** for image processing
   - **Always use worst case possible**: real HD images, maximum concurrency, maximum load scenarios

   **Stress Test Configuration:**

```bash
   # Configure real HD image (Honor X8b quality)
   dotnet run --project StressTest/StressTest.csproj http://localhost:5212

   # Validate large image processing
   # - Minimum size: 100KB
   # - Format: High-resolution JPEG
   # - Source: Real mobile device images
```

**Image Validation:**

- ✅ Valid base64 processing
- ✅ File system writing
- ✅ Image format validation
- ✅ Error handling without crashes
- ✅ Performance under concurrent load

3. **Fullstack Integration Tests (.NET + Vite)**
   - Start API: `dotnet run`
   - Start Frontend: `bun run dev`
   - Execute E2E tests with Chrome DevTools
   - Emulate real user interactions
   - Validate complete flows
   - Measure performance (Core Web Vitals for web)

4. **Log Analysis**
   - Parse compilation output
   - Identify and resolve warnings
   - Verify no memory leaks
   - Confirm applied optimizations

## Continuous Documentation

### Add Comments to Code

Add comments to explain the purpose of each method/class of code, especially complex logic. so it can later be exported into a XML with openAPi Swagger (for dotnet) and for frontend techs quick explanation of the methods.

### AGENTS.MD - Change Log

Update after each significant modification, generate a commit per file modified.

```markdown
## [YYYY-MM-DD HH:MM] - Modified Component

### Change Made

Detailed description of what was changed

### Root Cause Analysis

Why was this change needed?

### Impact

- Performance: [improvement/neutral/degradation]
- Memory: [reduction/neutral/increase]
- Functionality: [new/improved/fixed]
- Breaking Changes: [yes/no - detail]

### Affected Files

- `path/to/file1.dart`
- `path/to/file2.tsx`

### Updated Dependencies

- package_name: previous_version -> new_version
```

### TODO.md - Per Component

Maintain updated status:

```markdown
# TODO - [Component Name]

## In Progress

- [ ] Current task with details

## Pending - High Priority

- [ ] Critical task

## Pending - Medium Priority

- [ ] Recommended improvement

## Pending - Low Priority

- [ ] Future optimization

## Completed

- [x] Finished task - [YYYY-MM-DD]
```

## Quality Criteria

### Performance Benchmarks

- **Flutter**:
  - Consistent 60 FPS
  - Startup time < 2s
  - Memory usage < 150MB on mid-range devices

- **React**:
  - First Contentful Paint < 1.5s
  - Time to Interactive < 3s
  - Lighthouse score > 90

- **C# API**:
  - **Stress Testing Standards**:
    - ✅ **95% minimum Success Rate** in concurrent tests
    - ✅ **Image Processing: < 1 minute** (vs ~22ms achieved)
    - ✅ **HD Images Support**: minimum 100KB (Honor X8b quality)
    - ✅ **Worst Case Testing**: always use most demanding scenarios

  - **Performance Metrics**:
    - Response time < 200ms (p95) - normal operations
    - **Image Processing**: < 60,000ms (1 minute maximum)
    - Throughput > 1000 req/s - normal operations
    - **Stress Throughput**: > 45 req/s with concurrent HD images
    - Memory footprint < 512MB
    - **Image Memory**: efficient large base64 handling

  - **Load Testing Requirements**:
    - ✅ Real mobile device images
    - ✅ High concurrency (500+ simultaneous requests)
    - ✅ I/O operations validation
    - ✅ File system operations
    - ✅ Database write operations under load

### Code Review Checklist

- [ ] Code compiled without warnings
- [ ] Tests 100% passing
- [ ] **Stress tests with 95%+ success rate**
- [ ] **Image processing < 1 minute under load**
- [ ] **Worst case scenarios validated**
- [ ] No memory leaks detected
- [ ] Logs implemented at critical points
- [ ] Documentation updated
- [ ] Performance within benchmarks
- [ ] Breaking changes documented with fallback commit
- [ ] **HD image support (100KB+) validated**
- [ ] **Concurrent load testing completed**

### Stress Testing Standards - Mandatory Validation

**Before each release/merge:**

1. ✅ Execute `StressTest` with real HD images
2. ✅ Validate 95%+ success rate
3. ✅ Confirm response time < 1 minute for images
4. ✅ Test concurrency of 500+ requests
5. ✅ Verify valid base64 processing
6. ✅ Validate file system writing
7. ✅ Confirm no memory leaks under load

**Testing Configuration:**

- Images: minimum 100KB, JPEG format, Honor X8b quality
- Concurrency: 500+ simultaneous requests
- Timeout: maximum 5 minutes per test
- Metrics: throughput, response time, error rate

**Mandatory Reporting:**

- Success rate per endpoint
- Average response time
- Maximum throughput achieved
- Memory usage during tests
- Detailed error logs

## User Communication

### DO NOT

- ❌ Generate extensive unsolicited walkthroughs
- ❌ Automatic summaries of actions performed
- ❌ Modify code without explicit confirmation
- ❌ Use emojis in technical communication

### DO

- ✅ Ask before each significant action
- ✅ Present options with pros/cons
- ✅ Confirm understanding of requirements
- ✅ Report problems found immediately
- ✅ Concise and technical communication

## Summarized Workflow

1. **Start**: Read AGENTS.MD + README.md + TODOs
2. **Analysis**: Understand request, propose alternatives
3. **Confirmation**: Wait for user approval
4. **Preventive commit**: Before breaking changes
5. **Implementation**: Code + logs + best practices
6. **Testing**: Static analysis + tests + integration
7. **Documentation**: Update AGENTS.MD + TODO.md
8. **Validation**: Confirm performance benchmarks

---

**Priority #1**: Resource efficiency to minimize cloud costs
**Priority #2**: Smooth and responsive user experience
**Priority #2.5**: **Stress Testing Standards - 95% success + <1min image processing**
**Priority #3**: Code maintainability and clarity
**Priority #4**: **Worst Case Testing - Always validate with maximum load scenarios**
