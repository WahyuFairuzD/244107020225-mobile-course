
# AI Development Log - Week 9

## Lab 1: Prompt and Context Engineering
Act as a senior Flutter developer.
Act as a senior Flutter developer.

Context:
I have a Flutter Offline Notes application using Riverpod and SQLite. The UI is in notes_page.dart, state management is in notes_provider.dart, and database operations are handled by NoteRepository.

Task:
Add a search feature that filters notes by title. The search must be case-insensitive and update dynamically as the user types. Also show an appropriate empty state when no notes match the query.

Constraints:
- Preserve the existing architecture.
- Do not modify database schema.
- Do not break add, delete, sync, or settings functionality.
- Keep the implementation simple and beginner-friendly.

Output:
Provide the proposed code changes and explain how to verify the feature.

### Feature
Notes title search with empty state.

### Five-Slot Prompt

- Role: Senior Flutter Developer.
- Context: Flutter, Riverpod, SQLite, offline-first notes application.
- Task: Add notes title search and empty state.
- Limits: Preserve existing architecture; no direct database access from UI.
- Output: Implementation, tests, and manual testing instructions.

### Project Context
- UI: `lib/pages/notes_page.dart`
- State management: Riverpod
- Repository: `lib/data/repositories/note_repository.dart`
- Database: SQLite
- Feature: Offline Notes

## Lab 2: Generate and Verify Search

### AI Prompt
Act as a senior Flutter developer.
Act as a senior Flutter developer.

Context:
I have a Flutter Offline Notes application using Riverpod and SQLite. The UI is in notes_page.dart, state management is in notes_provider.dart, and database operations are handled by NoteRepository.

Task:
Add a search feature that filters notes by title. The search must be case-insensitive and update dynamically as the user types. Also show an appropriate empty state when no notes match the query.

Constraints:
- Preserve the existing architecture.
- Do not modify database schema.
- Do not break add, delete, sync, or settings functionality.
- Keep the implementation simple and beginner-friendly.

Output:
Provide the proposed code changes and explain how to verify the feature.

### Initial AI Output
(To be completed)

### Verification
### Verification

- Ran `flutter analyze` successfully with no issues.
- Tested the search feature in Chrome.
- Verified case-insensitive title filtering.
- Verified empty state when no matching notes are found.
- Verified notes appear again after clearing the search query.
- Saved screenshot evidence as `SearchMyNotes.jpg`.
### Accept/Reject Decisions
Accept: Search currently filters notes in memory. This is acceptable for a small offline notes application because all notes are already loaded from SQLite.

Reject: Moving search state to Riverpod is unnecessary for this feature. Local state using setState is sufficient because the search query is only used inside NotesPage.

Accept: Automated search tests would improve reliability, especially for case-insensitive matching and empty results.

### Evidence
Finding 1 verified: notes.where() filters the notes list in memory instead of querying SQLite directly.

Finding 2 verified: searchQuery is managed locally in _NotesPageState using setState.

Finding 2 rejected as an architectural concern: Local state is sufficient because search is only used in NotesPage.

Search behavior verified manually in Chrome:

Case-insensitive filtering works.

Empty search results display No notes found.

Clearing the search restores the notes list.

Screenshot evidence: SearchMyNotes.jpg.
