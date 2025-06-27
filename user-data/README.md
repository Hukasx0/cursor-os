# User Data Directory

This directory contains personalized information about the user and their computer setup. This data helps Cursor OS provide more relevant and personalized responses.

## What Gets Stored Here

### User Preferences (`user-preferences.md`)
- Preferred programming languages and frameworks
- Coding style preferences
- Communication style preferences
- Project management preferences

### Computer Information (`computer-info.md`)
- Operating system and version
- Development environment setup
- Installed tools and software
- Hardware specifications

### Project Context (`project-context.md`)
- Current projects being worked on
- Project-specific preferences
- Team information and conventions
- Deployment and infrastructure details

### Learning History (`learning-history.md`)
- Topics the user is learning
- Skills they want to develop
- Previous questions and solutions
- Progress tracking

### Work Context (`work-context.md`)
- Job role and responsibilities
- Team structure and workflows
- Company-specific tools and processes
- Professional goals and objectives

## Privacy and Security

⚠️ **Important**: This directory is git-ignored for privacy reasons. The information here:
- Should never be committed to version control
- Contains personal and potentially sensitive information
- Is used only to improve Cursor OS responses
- Should be kept secure and private

## File Format

All files in this directory should be markdown (`.md`) format for consistency and readability. Use clear headers and structured data when possible.

## Example Structure

```
user-data/
├── user-preferences.md
├── computer-info.md
├── project-context.md
├── learning-history.md
├── work-context.md
└── session-notes/
    ├── 2024-01-01-session.md
    └── 2024-01-02-session.md
```

## Automatic Updates

Cursor OS may automatically update these files as it learns more about your preferences and context through interactions. You can also manually edit any of these files to provide more accurate information. 