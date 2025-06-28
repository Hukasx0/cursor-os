# Micro SaaS Full-Stack Project Addon

**PRIMARY_GOAL**: Generate a complete, production-ready micro SaaS application based on user's request and this file's specs.

**PROBLEM_DEFINITION**:
- **Core Principle**: The Micro SaaS must solve a tangible, real-world problem.
- **Action**: IF the user does not specify a topic, YOU MUST CHOOSE a viable problem to solve.
- **Suggested Topics**:
    - **B2B**: A tool that solves a small but significant business problem (e.g., AI customer feedback summarizer, simple inventory tracker for small shops, automated social media image generation).
    - **Developer/User Tool**: A utility that solves a common problem for the prompter (e.g., project boilerplate generator, personal finance tracker, bookmark manager with tagging).

**EXECUTION_FLOW**:
1.  **Define & Confirm Problem**: Based on `PROBLEM_DEFINITION`, establish the core functionality.
2.  **Scaffold Project**: Use `PROJECT_STRUCTURE`.
3.  **Install Dependencies**: Use `DEPENDENCIES` list for `package.json`.
4.  **Create Core Files**: Generate all files from `CODE_EXAMPLES`.
5.  **Implement Logic**: Build features from `FEATURE_IMPLEMENTATION_LIST`.
6.  **Write Tests**: Create comprehensive unit, integration, and e2e tests for the application.
7.  **Generate Docs**: Create all files listed in `DOCUMENTATION_REQUIREMENTS`.
8.  **Apply Standards**: Adhere to all `QUALITY_AND_SECURITY_PROTOCOLS`.

---

## `TECH_STACK`

-   **Core**: Next.js 14+ (App Router), PostgreSQL, Drizzle ORM, NextAuth.js v5
-   **UI**: shadcn/ui, Tailwind CSS
-   **Services**: Stripe (Payments), Resend/SendGrid (Email), Vercel/Railway/Docker (Deployment)
-   **Tooling**: Jest, Playwright, Vitest (Testing), Sentry, PostHog (Monitoring), Upstash Redis (Rate Limiting), Zod (Validation)

---

## `PROJECT_STRUCTURE`

```

micro-saas-app/
├── .env.example
├── next.config.js
├── tailwind.config.js
├── drizzle.config.ts
├── middleware.ts
├── package.json
├── README.md
├── tests/
│   ├── e2e/
│   └── unit/
├── docs/
│   ├── Deployment.md
│   ├── Architecture.md
│   └── API.md
├── src/
│   ├── app/
│   │   ├── (auth)/
│   │   ├── (dashboard)/
│   │   └── api/
│   ├── components/
│   │   ├── ui/
│   │   ├── auth/
│   │   ├── dashboard/
│   │   └── landing/
│   ├── lib/
│   │   ├── auth.ts
│   │   ├── db.ts
│   │   ├── stripe.ts
│   │   └── redis.ts
│   ├── db/
│   │   ├── schema.ts
│   │   └── migrations/
│   ├── types/
│   └── constants/
└── Dockerfile

````

---

## `DEPENDENCIES`

### Init Commands
```bash
npx create-next-app@latest micro-saas-app --ts --tailwind --eslint --app --src-dir
npx shadcn-ui@latest init
npx shadcn-ui@latest add button card input label toast dropdown-menu dialog
````

### package.json Content

```json
{
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.0.0",
    "next-auth": "^5.0.0-beta",
    "drizzle-orm": "^0.29.0",
    "postgres": "^3.4.0",
    "@vercel/postgres": "^0.5.0",
    "zod": "^3.22.0",
    "stripe": "^14.0.0",
    "resend": "^2.0.0",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.0.0",
    "tailwind-merge": "^2.0.0",
    "lucide-react": "^0.294.0",
    "react-hook-form": "^7.48.0",
    "@hookform/resolvers": "^3.3.0",
    "sonner": "^1.2.0",
    "@upstash/redis": "^1.25.0",
    "@upstash/ratelimit": "^0.4.0"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "drizzle-kit": "^0.20.0",
    "eslint-config-next": "^14.0.0",
    "jest": "^29.0.0",
    "@testing-library/react": "^14.0.0",
    "playwright": "^1.40.0"
  }
}
```

-----

## `CODE_EXAMPLES`

### FILE: .env.example

```env
# Database
DATABASE_URL="postgresql://user:pass@host:5432/db"
# Auth
NEXTAUTH_SECRET="secret"
NEXTAUTH_URL="http://localhost:3000"
GOOGLE_CLIENT_ID=""
GOOGLE_CLIENT_SECRET=""
# Services
STRIPE_SECRET_KEY="sk_test_..."
STRIPE_WEBHOOK_SECRET="whsec_..."
STRIPE_PRO_PRICE_ID="price_..."
RESEND_API_KEY="re_..."
UPSTASH_REDIS_REST_URL=""
UPSTASH_REDIS_REST_TOKEN=""
```

### FILE: src/lib/auth.ts

```typescript
import NextAuth from 'next-auth';
import Google from 'next-auth/providers/google';
import { DrizzleAdapter } from '@auth/drizzle-adapter';
import { db } from '@/lib/db';

export const { handlers, auth, signIn, signOut } = NextAuth({
  adapter: DrizzleAdapter(db),
  providers: [ Google ],
  session: { strategy: 'jwt' },
  callbacks: {
    session: ({ session, token }) => ({ ...session, user: { ...session.user, id: token.sub } }),
  },
});
```

### FILE: middleware.ts

```typescript
import { auth } from '@/lib/auth';
export default auth;
export const config = { matcher: ['/((?!api|_next/static|_next/image|favicon.ico).*)'] };
```

-----

## `FEATURE_IMPLEMENTATION_LIST`

  - **Landing Page**: Clear value proposition, feature highlights, pricing, strong CTAs, responsive, SEO-optimized.
  - **Dashboard**: Intuitive navigation, real-time data, bulk actions, search/filter, data export.
  - **Onboarding**: Interactive tutorials, sample data, progressive disclosure of features.
  - **Payments**: Create Stripe checkout sessions, manage subscriptions via webhooks, billing portal.

-----

## `QUALITY_AND_SECURITY_PROTOCOLS`

  - **Security**: Use NextAuth.js for secure sessions. Implement rate limiting on sensitive API routes. Use Zod for all input validation. Sanitize all data via Drizzle ORM. Store secrets in `.env`. Enforce HTTPS.
  - **Quality & Testing**: Write unit, integration, and E2E tests for all core features. Aim for \>80% test coverage. Pass performance, accessibility, and security audits before deployment.
  - **Deployment**: Automate DB migrations. Set up health checks. Configure monitoring/alerts. Implement and test backup strategy.

-----

## `DOCUMENTATION_REQUIREMENTS`

  - **README.md**: Project overview, local setup instructions, contribution guide.
  - **Deployment.md**: **MUST BE CREATED.** A detailed guide on how to deploy the application. Must cover:
      - Deployment to Vercel (step-by-step) and other services.
      - Deployment using Docker (how to build and run the container).
      - Configuration of all required environment variables for production.
      - How to connect to a production database and run migrations.
  - **API.md**: API reference with request/response examples for all public endpoints.
