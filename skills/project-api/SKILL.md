---
name: project-api
description: >
  project API patterns: JSON:API, RLS, RBAC, providers, Celery tasks.
Trigger: When working in api/ on models/serializers/viewsets/filters/tasks involving tenant isolation (RLS), RBAC, JSON:API, or provider lifecycle.
license: Apache-2.0
metadata:
  author: project-cloud
  version: "1.0"
  scope: [root, api]
  auto_invoke: "Creating/modifying models, views, serializers"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, WebFetch, WebSearch, Task
---

### .NET 10 Minimal API

- **Endpoints**: Define HTTP endpoints using minimal syntax without controllers
- **Route Handlers**: Lambda-based request handling with dependency injection
- **Route Groups**: Organize related endpoints using `MapGroup()`
- **Filters**: Request/response pipeline customization with endpoint filters
- **Parameter Binding**: Automatic binding from route, query, header, and body

```csharp
app.MapGet("/api/users/{id}", async (int id, IUserService service) =>
{
    var user = await service.GetByIdAsync(id);
    return user is not null ? Results.Ok(user) : Results.NotFound();
});
```

---

## Architecture Patterns

### CQRS (Command Query Responsibility Segregation)

- **Commands**: Represent write operations (Create, Update, Delete)
- **Queries**: Represent read operations (Get, List, Search)
- **Handlers**: Separate handlers for each command/query
- **Mediator Pattern**: Use MediatR for request/response handling
- **Separation of Concerns**: Different models for reads vs writes

```csharp
// Command
public record CreateUserCommand(string Name, string Email) : IRequest<UserDto>;

// Query
public record GetUserQuery(int Id) : IRequest<UserDto>;

// Handler
public class CreateUserHandler : IRequestHandler<CreateUserCommand, UserDto>
{
    public async Task<UserDto> Handle(CreateUserCommand request, CancellationToken ct)
    {
        // Implementation
    }
}
```

---

## SOLID Principles

### Single Responsibility Principle (SRP)

- Each class has one reason to change
- Separate concerns into focused services

### Open/Closed Principle (OCP)

- Open for extension, closed for modification
- Use interfaces and abstract classes

### Liskov Substitution Principle (LSP)

- Derived classes must be substitutable for base classes
- Maintain expected behavior in inheritance hierarchies

### Interface Segregation Principle (ISP)

- Many specific interfaces over one general interface
- Clients shouldn't depend on unused methods

### Dependency Inversion Principle (DIP)

- Depend on abstractions, not concretions
- Use dependency injection for loose coupling

```csharp
// DIP Example
public interface IUserRepository
{
    Task<User> GetByIdAsync(int id);
}

public class UserService
{
    private readonly IUserRepository _repository;

    public UserService(IUserRepository repository)
    {
        _repository = repository;
    }
}
```

---

## Validation

### FluentValidation

- **Rule-Based**: Chain validation rules fluently
- **Reusable Validators**: Create validator classes for DTOs/Commands
- **Custom Rules**: Define complex validation logic
- **Async Validation**: Support for async validation rules
- **Integration**: Register validators in DI container

```csharp
public class CreateUserCommandValidator : AbstractValidator<CreateUserCommand>
{
    public CreateUserCommandValidator()
    {
        RuleFor(x => x.Name)
            .NotEmpty()
            .MaximumLength(100);

        RuleFor(x => x.Email)
            .NotEmpty()
            .EmailAddress()
            .MustAsync(BeUniqueEmail)
            .WithMessage("Email already exists");
    }

    private async Task<bool> BeUniqueEmail(string email, CancellationToken ct)
    {
        // Check uniqueness
        return true;
    }
}
```

**Registration**:

```csharp
builder.Services.AddValidatorsFromAssemblyContaining<CreateUserCommandValidator>();
```

---

## Logging

### ILogger<T>

- **Structured Logging**: Use message templates with parameters
- **Log Levels**: Trace, Debug, Information, Warning, Error, Critical
- **Scopes**: Add context to log entries using BeginScope
- **Performance**: Use LoggerMessage.Define for high-performance logging
- **Providers**: Configure Serilog, NLog, or built-in providers

```csharp
public class UserService
{
    private readonly ILogger<UserService> _logger;

    public UserService(ILogger<UserService> logger)
    {
        _logger = logger;
    }

    public async Task<User> GetUserAsync(int id)
    {
        _logger.LogInformation("Fetching user with ID: {UserId}", id);

        try
        {
            var user = await _repository.GetByIdAsync(id);

            if (user is null)
            {
                _logger.LogWarning("User not found: {UserId}", id);
            }

            return user;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error fetching user {UserId}", id);
            throw;
        }
    }
}
```

**Configuration** (appsettings.json):

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  }
}
```

---

## Best Practices

### API Development Checklist

- ✅ Use Minimal API for lightweight endpoints
- ✅ Implement CQRS for scalable architecture
- ✅ Apply SOLID principles consistently
- ✅ Validate all input with FluentValidation
- ✅ Log important events and errors with ILogger
- ✅ Use dependency injection for testability
- ✅ Return appropriate HTTP status codes
- ✅ Version your API endpoints
- ✅ Document with OpenAPI/Swagger
- ✅ Implement proper error handling middleware

### Project Structure

```
src/
├── Api/                    # Minimal API endpoints
├── Application/            # CQRS commands/queries/handlers
│   ├── Commands/
│   ├── Queries/
│   └── Validators/        # FluentValidation validators
├── Domain/                # Domain models and interfaces
├── Infrastructure/        # Data access, external services
└── Program.cs            # Application entry point
```

---

## Common Patterns

### Request Pipeline

```csharp
var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(Assembly.GetExecutingAssembly()));
builder.Services.AddValidatorsFromAssemblyContaining<Program>();
builder.Services.AddScoped<IUserRepository, UserRepository>();

var app = builder.Build();

// Minimal API endpoint with validation
app.MapPost("/api/users", async (
    CreateUserCommand command,
    IValidator<CreateUserCommand> validator,
    IMediator mediator,
    ILogger<Program> logger) =>
{
    var validationResult = await validator.ValidateAsync(command);

    if (!validationResult.IsValid)
    {
        logger.LogWarning("Validation failed for CreateUserCommand");
        return Results.ValidationProblem(validationResult.ToDictionary());
    }

    var result = await mediator.Send(command);
    logger.LogInformation("User created: {UserId}", result.Id);

    return Results.Created($"/api/users/{result.Id}", result);
});
```

---

## Resources

- **Microsoft Docs**: [Minimal APIs](https://learn.microsoft.com/aspnet/core/fundamentals/minimal-apis)
- **FluentValidation**: [Documentation](https://docs.fluentvalidation.net)
- **MediatR**: [CQRS with MediatR](https://github.com/jbogard/MediatR)
- **Logging**: [ILogger Best Practices](https://learn.microsoft.com/aspnet/core/fundamentals/logging)
