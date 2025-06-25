# Micro SaaS Full-Stack Addon

## Purpose
This addon provides comprehensive guidelines for Cursor OS to create complete, production-ready micro SaaS applications using modern full-stack technologies. It covers everything from initial setup to deployment, ensuring security, scalability, and user experience excellence.

## Tech Stack Overview

### Core Technologies
- **Frontend**: Next.js 14+ (App Router)
- **Backend**: Next.js API Routes / Server Actions
- **Database**: PostgreSQL with Drizzle ORM
- **Authentication**: NextAuth.js v5 (Auth.js)
- **UI Framework**: shadcn/ui + Tailwind CSS
- **Payment**: Stripe Integration
- **Email**: Resend / SendGrid
- **Deployment**: Vercel / Railway / Docker
- **Testing**: Jest, Playwright, Vitest
- **Monitoring**: Sentry, PostHog

### Security & Performance
- **Rate Limiting**: Upstash Redis
- **Validation**: Zod schemas
- **Security**: CSRF protection, SQL injection prevention
- **Caching**: Redis + Next.js caching
- **SEO**: Next.js metadata API
- **Analytics**: PostHog / Google Analytics

## Project Structure Template

```
micro-saas-app/
├── .env.local                    # Environment variables
├── .env.example                  # Example environment file
├── next.config.js               # Next.js configuration
├── tailwind.config.js           # Tailwind configuration
├── drizzle.config.ts            # Drizzle configuration
├── middleware.ts                # Next.js middleware
├── package.json                 # Dependencies
├── README.md                    # Project documentation
├── 
├── src/
│   ├── app/                     # App Router pages
│   │   ├── (auth)/             # Auth group routes
│   │   │   ├── signin/
│   │   │   └── signup/
│   │   ├── (dashboard)/        # Protected dashboard routes
│   │   │   ├── dashboard/
│   │   │   ├── settings/
│   │   │   └── billing/
│   │   ├── api/                # API routes
│   │   │   ├── auth/
│   │   │   ├── webhooks/
│   │   │   └── v1/
│   │   ├── globals.css         # Global styles
│   │   ├── layout.tsx          # Root layout
│   │   └── page.tsx            # Homepage
│   │
│   ├── components/             # Reusable components
│   │   ├── ui/                 # shadcn/ui components
│   │   ├── auth/               # Authentication components
│   │   ├── dashboard/          # Dashboard components
│   │   ├── landing/            # Landing page components
│   │   └── layout/             # Layout components
│   │
│   ├── lib/                    # Utility libraries
│   │   ├── auth.ts             # NextAuth configuration
│   │   ├── db.ts               # Database connection
│   │   ├── stripe.ts           # Stripe configuration
│   │   ├── email.ts            # Email service
│   │   ├── redis.ts            # Redis connection
│   │   ├── validations.ts      # Zod schemas
│   │   └── utils.ts            # Utility functions
│   │
│   ├── db/                     # Database schema and migrations
│   │   ├── schema.ts           # Drizzle schema
│   │   ├── migrations/         # SQL migrations
│   │   └── seed.ts             # Database seeding
│   │
│   ├── hooks/                  # Custom React hooks
│   ├── types/                  # TypeScript type definitions
│   └── constants/              # Application constants
│
├── tests/                      # Test files
│   ├── __mocks__/             # Mock files
│   ├── e2e/                   # End-to-end tests
│   ├── integration/           # Integration tests
│   └── unit/                  # Unit tests
│
├── docs/                      # Documentation
│   ├── api.md                 # API documentation
│   ├── deployment.md          # Deployment guide
│   └── architecture.md        # System architecture
│
├── scripts/                   # Build and deployment scripts
│   ├── setup.sh              # Initial setup script
│   ├── deploy.sh              # Deployment script
│   └── backup.sh              # Database backup script
│
└── docker/                   # Docker configuration
    ├── Dockerfile
    ├── docker-compose.yml
    └── .dockerignore
```

## Implementation Steps

### 1. Project Initialization

**Create project structure:**
```bash
npx create-next-app@latest micro-saas-app --typescript --tailwind --eslint --app --src-dir
cd micro-saas-app
```

**Install core dependencies:**
```json
{
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.0.0",
    "react-dom": "^18.0.0",
    "@next/font": "^14.0.0",
    "next-auth": "^5.0.0-beta",
    "drizzle-orm": "^0.29.0",
    "postgres": "^3.4.0",
    "@vercel/postgres": "^0.5.0",
    "drizzle-kit": "^0.20.0",
    "zod": "^3.22.0",
    "stripe": "^14.0.0",
    "resend": "^2.0.0",
    "@radix-ui/react-slot": "^1.0.0",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.0.0",
    "tailwind-merge": "^2.0.0",
    "lucide-react": "^0.294.0",
    "@hookform/resolvers": "^3.3.0",
    "react-hook-form": "^7.48.0",
    "sonner": "^1.2.0",
    "@radix-ui/react-toast": "^1.1.0",
    "@upstash/redis": "^1.25.0",
    "@upstash/ratelimit": "^0.4.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "typescript": "^5.0.0",
    "tailwindcss": "^3.3.0",
    "eslint": "^8.0.0",
    "eslint-config-next": "^14.0.0",
    "prettier": "^3.0.0",
    "jest": "^29.0.0",
    "@testing-library/react": "^14.0.0",
    "@testing-library/jest-dom": "^6.0.0",
    "playwright": "^1.40.0",
    "@types/jest": "^29.0.0"
  }
}
```

### 2. Database Setup with Drizzle

**Database schema (`src/db/schema.ts`):**
```typescript
import { pgTable, text, timestamp, boolean, integer, decimal, uuid, index } from 'drizzle-orm/pg-core';
import { createId } from '@paralleldrive/cuid2';

export const users = pgTable('users', {
  id: text('id').primaryKey().$defaultFn(() => createId()),
  email: text('email').notNull().unique(),
  name: text('name'),
  image: text('image'),
  emailVerified: timestamp('emailVerified'),
  stripeCustomerId: text('stripe_customer_id'),
  subscriptionStatus: text('subscription_status'),
  subscriptionPriceId: text('subscription_price_id'),
  subscriptionCurrentPeriodEnd: timestamp('subscription_current_period_end'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
}, (table) => ({
  emailIdx: index('email_idx').on(table.email),
  stripeCustomerIdx: index('stripe_customer_idx').on(table.stripeCustomerId),
}));

export const accounts = pgTable('accounts', {
  id: text('id').primaryKey().$defaultFn(() => createId()),
  userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
  type: text('type').notNull(),
  provider: text('provider').notNull(),
  providerAccountId: text('provider_account_id').notNull(),
  refresh_token: text('refresh_token'),
  access_token: text('access_token'),
  expires_at: integer('expires_at'),
  token_type: text('token_type'),
  scope: text('scope'),
  id_token: text('id_token'),
  session_state: text('session_state'),
}, (table) => ({
  userIdIdx: index('accounts_user_id_idx').on(table.userId),
}));

export const sessions = pgTable('sessions', {
  id: text('id').primaryKey().$defaultFn(() => createId()),
  sessionToken: text('session_token').notNull().unique(),
  userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
  expires: timestamp('expires').notNull(),
}, (table) => ({
  sessionTokenIdx: index('session_token_idx').on(table.sessionToken),
  userIdIdx: index('sessions_user_id_idx').on(table.userId),
}));

export const projects = pgTable('projects', {
  id: text('id').primaryKey().$defaultFn(() => createId()),
  name: text('name').notNull(),
  description: text('description'),
  userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
  isPublic: boolean('is_public').default(false),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
}, (table) => ({
  userIdIdx: index('projects_user_id_idx').on(table.userId),
  nameIdx: index('projects_name_idx').on(table.name),
}));

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;
export type Project = typeof projects.$inferSelect;
export type NewProject = typeof projects.$inferInsert;
```

**Database connection (`src/lib/db.ts`):**
```typescript
import { drizzle } from 'drizzle-orm/vercel-postgres';
import { sql } from '@vercel/postgres';
import * as schema from '@/db/schema';

export const db = drizzle(sql, { schema });

export type DB = typeof db;
```

### 3. Authentication Setup

**NextAuth configuration (`src/lib/auth.ts`):**
```typescript
import NextAuth from 'next-auth';
import Google from 'next-auth/providers/google';
import GitHub from 'next-auth/providers/github';
import { DrizzleAdapter } from '@auth/drizzle-adapter';
import { db } from '@/lib/db';
import { users, accounts, sessions } from '@/db/schema';

export const { handlers, auth, signIn, signOut } = NextAuth({
  adapter: DrizzleAdapter(db, {
    usersTable: users,
    accountsTable: accounts,
    sessionsTable: sessions,
  }),
  providers: [
    Google({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    }),
    GitHub({
      clientId: process.env.GITHUB_CLIENT_ID!,
      clientSecret: process.env.GITHUB_CLIENT_SECRET!,
    }),
  ],
  callbacks: {
    session: async ({ session, token }) => {
      if (session?.user && token?.sub) {
        session.user.id = token.sub;
      }
      return session;
    },
    jwt: async ({ user, token }) => {
      if (user) {
        token.uid = user.id;
      }
      return token;
    },
  },
  session: {
    strategy: 'jwt',
  },
  pages: {
    signIn: '/signin',
    error: '/auth/error',
  },
});
```

### 4. UI Components with shadcn/ui

**Install shadcn/ui:**
```bash
npx shadcn-ui@latest init
npx shadcn-ui@latest add button card input label toast dropdown-menu dialog
```

**Landing page component (`src/components/landing/hero.tsx`):**
```typescript
import { Button } from '@/components/ui/button';
import { ArrowRight, CheckCircle } from 'lucide-react';
import Link from 'next/link';

export function Hero() {
  return (
    <section className="py-20 px-4 text-center">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-5xl font-bold tracking-tight mb-6">
          Build Amazing Things with{' '}
          <span className="text-blue-600">Our Platform</span>
        </h1>
        <p className="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
          The fastest way to create, manage, and scale your projects. 
          Join thousands of creators who trust our platform.
        </p>
        
        <div className="flex flex-col sm:flex-row gap-4 justify-center mb-12">
          <Button size="lg" asChild>
            <Link href="/signup">
              Get Started Free <ArrowRight className="ml-2 h-5 w-5" />
            </Link>
          </Button>
          <Button variant="outline" size="lg" asChild>
            <Link href="/demo">View Demo</Link>
          </Button>
        </div>

        <div className="grid md:grid-cols-3 gap-6 text-left">
          {features.map((feature, index) => (
            <div key={index} className="flex items-start space-x-3">
              <CheckCircle className="h-5 w-5 text-green-500 mt-1 flex-shrink-0" />
              <div>
                <h3 className="font-semibold">{feature.title}</h3>
                <p className="text-gray-600 text-sm">{feature.description}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

const features = [
  {
    title: 'Lightning Fast',
    description: 'Built with performance in mind from day one.',
  },
  {
    title: 'Secure by Default',
    description: 'Enterprise-grade security protecting your data.',
  },
  {
    title: 'Easy Integration',
    description: 'Simple APIs and webhooks for seamless integration.',
  },
];
```

### 5. Stripe Integration

**Stripe configuration (`src/lib/stripe.ts`):**
```typescript
import Stripe from 'stripe';

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2023-10-16',
  typescript: true,
});

export const PLANS = {
  FREE: {
    name: 'Free',
    description: 'Perfect for getting started',
    price: 0,
    stripePriceId: '',
    features: ['5 projects', 'Basic support', '1GB storage'],
  },
  PRO: {
    name: 'Pro',
    description: 'For serious creators',
    price: 29,
    stripePriceId: process.env.STRIPE_PRO_PRICE_ID!,
    features: ['Unlimited projects', 'Priority support', '100GB storage', 'Advanced analytics'],
  },
} as const;

export async function createCheckoutSession(
  customerId: string,
  priceId: string,
  successUrl: string,
  cancelUrl: string
) {
  const session = await stripe.checkout.sessions.create({
    customer: customerId,
    payment_method_types: ['card'],
    billing_address_collection: 'required',
    line_items: [
      {
        price: priceId,
        quantity: 1,
      },
    ],
    mode: 'subscription',
    allow_promotion_codes: true,
    success_url: successUrl,
    cancel_url: cancelUrl,
  });

  return session;
}
```

### 6. API Routes & Server Actions

**API route example (`src/app/api/projects/route.ts`):**
```typescript
import { NextRequest, NextResponse } from 'next/server';
import { auth } from '@/lib/auth';
import { db } from '@/lib/db';
import { projects } from '@/db/schema';
import { eq } from 'drizzle-orm';
import { z } from 'zod';
import { ratelimit } from '@/lib/redis';

const createProjectSchema = z.object({
  name: z.string().min(1).max(100),
  description: z.string().max(500).optional(),
});

export async function GET(request: NextRequest) {
  const session = await auth();
  
  if (!session?.user?.id) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  try {
    const userProjects = await db
      .select()
      .from(projects)
      .where(eq(projects.userId, session.user.id))
      .orderBy(projects.createdAt);

    return NextResponse.json({ projects: userProjects });
  } catch (error) {
    console.error('Error fetching projects:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  const session = await auth();
  
  if (!session?.user?.id) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  // Rate limiting
  const { success } = await ratelimit.limit(session.user.id);
  if (!success) {
    return NextResponse.json(
      { error: 'Too many requests' },
      { status: 429 }
    );
  }

  try {
    const body = await request.json();
    const validation = createProjectSchema.safeParse(body);

    if (!validation.success) {
      return NextResponse.json(
        { error: 'Invalid input', details: validation.error.issues },
        { status: 400 }
      );
    }

    const newProject = await db
      .insert(projects)
      .values({
        ...validation.data,
        userId: session.user.id,
      })
      .returning();

    return NextResponse.json({ project: newProject[0] }, { status: 201 });
  } catch (error) {
    console.error('Error creating project:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

### 7. Middleware & Security

**Middleware (`middleware.ts`):**
```typescript
import { auth } from '@/lib/auth';
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export async function middleware(request: NextRequest) {
  const session = await auth();
  const isAuthPage = request.nextUrl.pathname.startsWith('/auth');
  const isDashboard = request.nextUrl.pathname.startsWith('/dashboard');
  
  // Redirect to dashboard if user is logged in and trying to access auth pages
  if (isAuthPage && session) {
    return NextResponse.redirect(new URL('/dashboard', request.url));
  }

  // Redirect to signin if user is not logged in and trying to access protected pages
  if (isDashboard && !session) {
    return NextResponse.redirect(new URL('/signin', request.url));
  }

  // Add security headers
  const response = NextResponse.next();
  
  response.headers.set('X-Content-Type-Options', 'nosniff');
  response.headers.set('X-Frame-Options', 'DENY');
  response.headers.set('X-XSS-Protection', '1; mode=block');
  response.headers.set('Referrer-Policy', 'strict-origin-when-cross-origin');
  
  return response;
}

export const config = {
  matcher: ['/((?!api|_next/static|_next/image|favicon.ico).*)'],
};
```

### 8. Testing Setup

**Jest configuration (`jest.config.js`):**
```javascript
const nextJest = require('next/jest');

const createJestConfig = nextJest({
  dir: './',
});

const customJestConfig = {
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1',
  },
  testEnvironment: 'jest-environment-jsdom',
};

module.exports = createJestConfig(customJestConfig);
```

**Example test (`tests/unit/components/hero.test.tsx`):**
```typescript
import { render, screen } from '@testing-library/react';
import { Hero } from '@/components/landing/hero';

describe('Hero Component', () => {
  it('renders the main heading', () => {
    render(<Hero />);
    
    const heading = screen.getByRole('heading', {
      name: /build amazing things with our platform/i,
    });
    
    expect(heading).toBeInTheDocument();
  });

  it('renders call-to-action buttons', () => {
    render(<Hero />);
    
    const getStartedButton = screen.getByRole('link', { name: /get started free/i });
    const demoButton = screen.getByRole('link', { name: /view demo/i });
    
    expect(getStartedButton).toBeInTheDocument();
    expect(demoButton).toBeInTheDocument();
  });
});
```

### 9. Environment Configuration

**Environment variables (`.env.example`):**
```bash
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/database"

# NextAuth
NEXTAUTH_SECRET="your-secret-key"
NEXTAUTH_URL="http://localhost:3000"

# OAuth Providers
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"
GITHUB_CLIENT_ID="your-github-client-id"
GITHUB_CLIENT_SECRET="your-github-client-secret"

# Stripe
STRIPE_SECRET_KEY="sk_test_..."
STRIPE_PUBLISHABLE_KEY="pk_test_..."
STRIPE_WEBHOOK_SECRET="whsec_..."
STRIPE_PRO_PRICE_ID="price_..."

# Email
RESEND_API_KEY="re_..."

# Redis (Upstash)
UPSTASH_REDIS_REST_URL="https://..."
UPSTASH_REDIS_REST_TOKEN="..."

# Monitoring
SENTRY_DSN="https://..."
NEXT_PUBLIC_POSTHOG_KEY="phc_..."
NEXT_PUBLIC_POSTHOG_HOST="https://app.posthog.com"
```

### 10. Deployment Configuration

**Vercel deployment (`vercel.json`):**
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": ".next",
  "framework": "nextjs",
  "functions": {
    "src/app/api/**/*.ts": {
      "maxDuration": 30
    }
  },
  "env": {
    "DATABASE_URL": "@database-url",
    "NEXTAUTH_SECRET": "@nextauth-secret",
    "STRIPE_SECRET_KEY": "@stripe-secret-key"
  }
}
```

**Docker configuration (`Dockerfile`):**
```dockerfile
FROM node:18-alpine AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production

FROM node:18-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:18-alpine AS runner
WORKDIR /app

ENV NODE_ENV production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
EXPOSE 3000
ENV PORT 3000

CMD ["node", "server.js"]
```

## Security Checklist

### 🔒 Authentication & Authorization
- [ ] Secure session management with NextAuth.js
- [ ] CSRF protection enabled
- [ ] Rate limiting implemented
- [ ] Input validation with Zod schemas
- [ ] SQL injection prevention with parameterized queries

### 🛡️ Data Protection
- [ ] Environment variables properly secured
- [ ] Database credentials encrypted
- [ ] API keys stored in secure environment
- [ ] Sensitive data never logged
- [ ] HTTPS enforced in production

### 🔍 Monitoring & Logging
- [ ] Error tracking with Sentry
- [ ] User analytics with PostHog
- [ ] API request logging
- [ ] Performance monitoring
- [ ] Security audit logging

## Quality Assurance Protocol

### 📋 Pre-deployment Checklist
- [ ] All tests passing (unit, integration, e2e)
- [ ] Code coverage > 80%
- [ ] Performance audit completed
- [ ] Security scan passed
- [ ] Accessibility compliance verified
- [ ] Mobile responsiveness tested
- [ ] Cross-browser compatibility confirmed

### 🚀 Deployment Steps
1. **Environment Setup**: Configure all environment variables
2. **Database Migration**: Run database migrations
3. **Build Verification**: Ensure clean build process
4. **Health Checks**: Verify all services are operational
5. **Monitoring Setup**: Configure alerts and dashboards
6. **Backup Strategy**: Implement automated backups

## Documentation Requirements

### 📚 Essential Documentation
1. **README.md**: Project overview, setup instructions, contribution guidelines
2. **API Documentation**: Comprehensive API reference with examples
3. **Deployment Guide**: Step-by-step deployment instructions
4. **Architecture Diagram**: Visual system architecture
5. **Security Guide**: Security best practices and configurations
6. **Troubleshooting Guide**: Common issues and solutions

### 🎯 User-Focused Features

### Landing Page Requirements
- [ ] **Clear value proposition** with compelling headline
- [ ] **Social proof** (testimonials, user count, reviews)
- [ ] **Feature highlights** with benefits explanation
- [ ] **Pricing transparency** with clear plan comparisons
- [ ] **Strong call-to-action** throughout the page
- [ ] **Mobile-first responsive design**
- [ ] **Fast loading times** (<3 seconds)
- [ ] **SEO optimization** with proper meta tags

### Dashboard Experience
- [ ] **Intuitive navigation** with clear information hierarchy
- [ ] **Real-time updates** for critical data
- [ ] **Bulk actions** for efficient management
- [ ] **Search and filtering** capabilities
- [ ] **Export functionality** for user data
- [ ] **Contextual help** and tooltips
- [ ] **Keyboard shortcuts** for power users

### Onboarding Flow
- [ ] **Progressive disclosure** of features
- [ ] **Interactive tutorials** for key workflows
- [ ] **Sample data** to demonstrate value
- [ ] **Achievement milestones** to encourage engagement
- [ ] **Help documentation** easily accessible
- [ ] **Contact support** prominently displayed

## Implementation Command for Cursor OS

**When user requests a micro SaaS application:**

1. **Execute full project setup**:
   ```bash
   # Create Next.js project with TypeScript
   # Install all required dependencies
   # Configure database and authentication
   # Set up UI components and styling
   # Implement core business logic
   # Add testing infrastructure
   # Configure deployment pipeline
   ```

2. **Apply security hardening**:
   - Configure rate limiting and CSRF protection
   - Set up monitoring and error tracking
   - Implement input validation and sanitization
   - Add security headers and middleware

3. **Create comprehensive documentation**:
   - Generate API documentation
   - Write deployment guides
   - Create user manuals
   - Document architecture decisions

4. **Verify quality gates**:
   - Run full test suite
   - Perform security audit
   - Check performance benchmarks
   - Validate accessibility compliance

5. **Prepare for launch**:
   - Set up production environment
   - Configure monitoring and alerts
   - Implement backup strategies
   - Create rollback procedures

Remember: **Every micro SaaS must solve a real user problem effectively, be secure by default, and provide exceptional user experience from day one.** 