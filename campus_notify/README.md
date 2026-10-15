# Week 7 — Clean Architecture

## 1. Overview

This project applies the principles of Clean Architecture to the Campus Notify application. The implementation focuses on separating business logic from data access and presentation concerns.

The main objective is to make the application easier to maintain, test, and extend by organizing code according to its responsibilities.

## 2. Feature-First Structure

The authentication feature is organized into separate layers.

```text
lib/
└── features/
    └── auth/
        ├── data/
        │   └── repositories/
        │       ├── auth_repository_impl.dart
        │       └── auth_repository_provider.dart
        ├── domain/
        │   ├── entities/
        │   │   └── auth_session.dart
        │   ├── repositories/
        │   │   └── auth_repository.dart
        │   └── usecases/
        │       ├── login.dart
        │       └── refresh_token.dart
        └── presentation/
            └── providers/
```

### Domain Layer

The domain layer contains the core business rules and abstractions.

- **Entities:** `AuthSession` represents the authentication session.
- **Repositories:** `AuthRepository` defines the operations required by the domain.
- **Use cases:** `Login` and `RefreshToken` encapsulate authentication operations.

The domain layer does not directly depend on Flutter widgets, Dio, or Riverpod in the inspected Dart files.

### Data Layer

The data layer provides the implementation of repository contracts.

- `AuthRepositoryImpl` implements the authentication repository.
- `auth_repository_provider.dart` provides access to the repository implementation.

The current authentication implementation uses mock responses for login and token refresh. It does not demonstrate a completed connection to a real authentication backend.

### Presentation Layer

The presentation layer is intended to manage the user interface and presentation-related state.

The project contains a `presentation/providers/` directory for authentication providers. Its current implementation should be documented separately from the domain and data layers.

## 3. Dependency Rule

Clean Architecture requires dependencies to point inward toward the domain layer.

The domain layer defines entities, repository abstractions, and use cases. Data and presentation code can depend on domain contracts, while the domain should not depend on external frameworks or implementation details.

### Verification Commands

The following commands were executed from the project root:

```cmd
findstr /S /N /I "package:flutter" lib\features\auth\domain\*.dart
findstr /S /N /I "package:dio" lib\features\auth\domain\*.dart
findstr /S /N /I "package:flutter_riverpod" lib\features\auth\domain\*.dart
```

### Verification Results

No matching imports were returned for the three searches in `lib/features/auth/domain/`.

The domain files use internal imports for entities and repository abstractions. This supports the Dependency Rule for the inspected authentication domain files.

**Scope limitation:** these commands inspect the authentication domain directory only. They do not verify every feature or every Dart file in the project.

## 4. Unit Testing

Unit tests are used to verify the behavior of the `Login` use case without requiring a real authentication server.

The tests use a fake repository implementing the `AuthRepository` interface. This isolates the use case from the concrete data implementation.

### Test Cases

| Test case | Expected behavior | Result |
|---|---|---|
| Successful login | Returns an `AuthSession` with the expected access and refresh tokens | Passed |
| Failed login | Throws an exception when the fake repository is configured to fail | Passed |

### Test Commands

Run the login use case tests:

```cmd
flutter test test/features/auth/domain/usecases/login_test.dart
```

Run the complete test suite:

```cmd
flutter test
```

The recorded test execution returned `All tests passed!`.

## 5. Static Analysis

Static analysis checks the project for errors and other code issues.

Command:

```cmd
flutter analyze
```

Recorded result:

```text
No issues found!
```

## 6. AI-Assisted Development

AI assistance was used to help organize the authentication feature, create unit tests, and verify the Dependency Rule.

### AI Prompt

"Review the authentication feature using Clean Architecture principles. Check the separation between domain, data, and presentation layers. Create unit tests for the Login use case using a fake repository, covering successful and failed login scenarios. Verify that the domain layer does not directly import Flutter, Dio, or Riverpod."

### Proposal and Final Decisions

| Topic | AI proposal | Final decision |
|---|---|---|
| Domain organization | Separate entities, repository abstractions, and use cases | Keep the existing feature-first authentication domain structure |
| Authentication testing | Use a fake repository to test the use case independently | Implement success and failure tests with `FakeAuthRepository` |
| Dependency verification | Search domain files for external framework imports | Run the three `findstr` commands and record their results |
| Authentication backend | A real backend could be integrated later | Retain the current mock implementation; real backend integration is not claimed as completed |

### Technical Rationale

Using a fake repository allows the use case to be tested without network access or a real authentication server. This makes the tests faster and more predictable.

Keeping repository contracts in the domain layer reduces direct coupling between business rules and implementation details.

Static analysis and unit tests provide complementary checks: tests verify selected behaviors, while static analysis identifies code issues detectable by the analyzer.

## 7. Current Verification Status

- [x] Login use case success test
- [x] Login use case failure test
- [x] Complete test suite passed
- [x] Flutter static analysis passed
- [x] Authentication domain import checks executed
- [ ] Before/after screenshots documented
- [ ] Final repository review and GitHub push

## 8. Limitations

The current authentication repository uses mock data. Successful unit tests demonstrate the tested use case behavior with a fake repository; they do not prove that authentication works against a production backend.

The Dependency Rule checks documented here are limited to the authentication domain directory.

Screenshot-based evidence has not been included in this documentation.
