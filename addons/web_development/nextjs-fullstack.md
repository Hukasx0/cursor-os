# Next.js Full-Stack Application Generation Addon

## 1\. Core Objective

Your primary task is to generate a complete, production-ready, and well-documented Next.js full-stack application. Adhere strictly to the rules and structures defined in this document.

## 2\. Project Scaffolding

### Rule 2.1: Application Location

  - **CRITICAL:** All Next.js projects MUST be created in the `documents/projects/project-name/` directory.
  - The output must be a complete, GitHub-style repository.

### Rule 2.2: Directory Structure

Generate the project with the following directory structure, including a `docs` folder for detailed documentation.

```
/
├── .env.example
├── .env.local
├── .eslintrc.json
├── .gitignore
├── .prettierrc
├── README.md
├── components.json
├── next.config.js
├── package.json
├── tailwind.config.ts
├── tsconfig.json
├── docs/
│   ├── deployment.md
│   ├── api-reference.md
│   └── architecture.md
├── prisma/
│   ├── schema.prisma
│   └── seed.ts
├── drizzle/
│   ├── config.ts
│   ├── schema.ts
│   └── seed.ts
├── public/
│   ├── icons/
│   └── images/
├── src/
│   ├── app/
│   ├── components/
│   ├── hooks/
│   ├── lib/
│   ├── styles/
│   └── types/
└── tests/
    ├── __mocks__/
    ├── e2e/
    ├── integration/
    └── unit/
```

## 3\. Technology Stack & Configuration

### Rule 3.1: Core Technologies

  - **Framework**: Next.js 14+ (App Router)
  - **Language**: TypeScript (strict mode)
  - **Styling**: Tailwind CSS + Shadcn/UI
  - **Database**: Default to **Drizzle** with PostgreSQL. Use Prisma only if explicitly requested.
  - **Authentication**: NextAuth.js v5 (default) or Clerk (if requested).
  - **State Management**: Zustand (preferred) or React Context.
  - **Forms**: React Hook Form + Zod.
  - **Testing**: Jest + React Testing Library + Playwright.
  - **Linting/Formatting**: ESLint + Prettier.

## 4\. Generation Rules & Constraints

### Rule 4.1: General Principles

  - **Type Safety**: Enforce strict TypeScript. No `any` types.
  - **Performance**: Use Next.js `<Image>`, dynamic imports, and lazy loading. Optimize database queries with indexes.
  - **Security**: Implement server-side authentication and authorization. Use parameterized queries. Implement rate limiting. Validate all inputs with Zod.
  - **Accessibility**: Ensure WCAG 2.1 AA compliance. Use semantic HTML and provide ARIA attributes.
  - **Scalability**: Use a modular architecture and maintain separation of concerns.
  - **Comprehensive Testing**: **This is a non-negotiable requirement.** All generated code must be accompanied by meaningful tests. Code without tests is considered incomplete. All business logic must have unit test coverage, and critical user flows must be covered by end-to-end tests.

### Rule 4.2: Component & Code Structure

  - **Components**: Generate components using `React.forwardRef`. Use `class-variance-authority` (CVA) for variants.
  - **Hooks**: Structure custom hooks to manage state and side effects, providing a clean return object (`data`, `loading`, `error`).
  - **API Routes**: Structure API routes with Zod validation, auth checks, rate limiting, and robust error handling.
  - **Database**: Use a `DatabaseService` class in `lib/db.ts` with static methods for type-safe database operations.
  - **Testing Implementation**: Implement a robust, multi-layered testing strategy:
      - **Unit Tests (Jest)**: For individual functions (e.g., in `lib/utils`), hooks, and isolated business logic. Place them in `tests/unit/`.
      - **Integration/Component Tests (Jest + React Testing Library)**: For components, verifying rendering, state changes, and user interactions. For API routes, testing endpoint logic, auth, and validation. Place them in `tests/integration/`.
      - **End-to-End Tests (Playwright)**: For critical user journeys (e.g., authentication flow, form submission, core feature workflows). Place them in `tests/e2e/`.
      - **Mocks**: Mock all external services, dependencies, and database calls to ensure tests are fast and reliable.

### Rule 4.3: Code Documentation (JSDoc/TSDoc)

  - **Be Thorough**: Your primary goal is to produce well-documented code.
  - **Public APIs**: Add structured TSDoc comments (`@param`, `@returns`, `@description`) for all public-facing APIs, hooks, types, and functions within `lib/`.
  - **Complex Logic**: Add comments to explain complex algorithms, business logic, or non-obvious implementations.
  - **Component Props**: Document the purpose of each prop in component interfaces.

### Rule 4.4: Project Documentation (Markdown Files)

You must generate the following files inside the `docs/` directory:

1.  **`docs/deployment.md`**:

      - Create a guide for deploying a Next.js application.
      - **Compare Platforms**: Analyze and compare **Vercel**, **Netlify**, and **AWS (Amplify or EC2/S3)**.
      - **Pros & Cons**: For each platform, create a table listing its advantages (e.g., "Ease of use", "Scalability", "Cost-effectiveness") and disadvantages.

2.  **`docs/api-reference.md`**:

      - Generate documentation for all API endpoints created in the project.
      - For each endpoint, specify:
          - **HTTP Method**: e.g., `GET`, `POST`, `PUT`, `DELETE`.
          - **Path**: e.g., `/api/users/{id}`.
          - **Description**: A brief explanation of what the endpoint does.
          - **Request Body / Parameters**: Details of the expected payload or query params, referencing Zod schemas where applicable.
          - **Success Response**: Example of a successful response (e.g., status `200 OK` with JSON payload).
          - **Error Responses**: Examples of potential error responses (e.g., `401 Unauthorized`, `404 Not Found`).

3.  **`docs/architecture.md`**:

      - **Overview**: Describe the general architecture of the application.
      - **Data Flow**: Explain how data flows between the client, server components, API routes, and the database.
      - **State Management**: Detail the state management strategy (e.g., "Zustand is used for global client state...").
      - **Authentication**: Explain the authentication flow (e.g., "NextAuth.js handles session management...").

## 5\. Final Output

Generate the complete file and folder structure as specified. The code and documentation must be clean, efficient, and follow all rules outlined in this directive.
