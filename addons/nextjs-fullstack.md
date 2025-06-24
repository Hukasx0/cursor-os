# Next.js Full-Stack Application Addon

## Purpose
Guidelines for creating modern, production-ready Next.js full-stack applications with TypeScript, Shadcn/UI, comprehensive testing, documentation, and deployment best practices.

## Application Placement Strategy

⚠️ **CRITICAL RULE**: All Next.js applications are created as complete projects for users.

### Next.js Applications Location
**Location**: `documents/projects/project-name/` folder  
**When to use**: ALL Next.js full-stack applications (no exceptions)
**Structure**: Complete GitHub-style repository with modern web development standards

**🎯 DEFAULT CHOICE**: Always create Next.js projects in `documents/projects/` with full professional structure.

```
documents/projects/project-name/
├── README.md
├── package.json
├── next.config.js
├── tailwind.config.ts
├── tsconfig.json
├── .env.example
├── .env.local
├── .gitignore
├── .eslintrc.json
├── .prettierrc
├── components.json (shadcn/ui)
├── src/
│   ├── app/
│   │   ├── layout.tsx
│   │   ├── page.tsx
│   │   ├── globals.css
│   │   ├── api/
│   │   │   └── auth/
│   │   └── (routes)/
│   ├── components/
│   │   ├── ui/ (shadcn/ui components)
│   │   ├── forms/
│   │   ├── layout/
│   │   └── custom/
│   ├── lib/
│   │   ├── utils.ts
│   │   ├── db.ts
│   │   ├── auth.ts
│   │   ├── validators.ts
│   │   └── constants.ts
│   ├── hooks/
│   │   ├── use-auth.ts
│   │   └── use-api.ts
│   ├── types/
│   │   ├── auth.ts
│   │   ├── api.ts
│   │   └── database.ts
│   └── styles/
├── public/
│   ├── images/
│   ├── icons/
│   └── favicon.ico
├── tests/
│   ├── __mocks__/
│   ├── components/
│   ├── pages/
│   ├── api/
│   └── utils/
├── docs/
│   ├── installation.md
│   ├── deployment.md
│   ├── api-reference.md
│   └── contributing.md
├── prisma/ (if using Prisma)
│   ├── schema.prisma
│   ├── migrations/
│   └── seed.ts
├── drizzle/ (if using Drizzle)
│   ├── schema.ts
│   ├── migrations/
│   ├── config.ts
│   └── seed.ts
└── .github/
    └── workflows/
        ├── ci.yml
        └── deploy.yml
```

## Core Principles
- **Type Safety**: Comprehensive TypeScript usage with strict configuration
- **Performance**: Optimized builds, lazy loading, and efficient data fetching
- **Accessibility**: WCAG compliant components and semantic HTML
- **Testing**: Unit, integration, and E2E testing coverage
- **Documentation**: Clear code documentation and API references
- **Security**: Authentication, authorization, and data validation
- **Scalability**: Modular architecture and clean code patterns

## Technology Stack

### Core Stack
- **Framework**: Next.js 14+ (App Router)
- **Language**: TypeScript (strict mode)
- **Styling**: Tailwind CSS + Shadcn/UI
- **Database**: Prisma / Drizzle + PostgreSQL/SQLite
- **Authentication**: NextAuth.js v5 / Clerk
- **State Management**: Zustand / React Context
- **Form Handling**: React Hook Form + Zod validation

### Development Tools
- **Testing**: Jest + React Testing Library + Playwright
- **Linting**: ESLint + Prettier
- **Type Checking**: TypeScript strict mode
- **Git Hooks**: Husky + lint-staged
- **Documentation**: TSDoc + Storybook (optional)

## Project Structure Template

### Core Configuration Files

#### package.json Template
```json
{
  "name": "project-name",
  "version": "0.1.0",
  "private": true,
  "description": "Brief description of your Next.js application",
  "author": "Your Name <your.email@example.com>",
  "license": "MIT",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "lint:fix": "next lint --fix",
    "type-check": "tsc --noEmit",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:e2e": "playwright test",
    "db:generate": "prisma generate",
    "db:push": "prisma db push",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio",
    "db:seed": "tsx prisma/seed.ts",
    "drizzle:generate": "drizzle-kit generate",
    "drizzle:push": "drizzle-kit push",
    "drizzle:migrate": "drizzle-kit migrate",
    "drizzle:studio": "drizzle-kit studio",
    "drizzle:seed": "tsx drizzle/seed.ts",
    "prepare": "husky install"
  },
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.0.0",
    "react-dom": "^18.0.0",
    "@radix-ui/react-slot": "^1.0.2",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.0.0",
    "tailwind-merge": "^2.0.0",
    "lucide-react": "^0.294.0",
    "react-hook-form": "^7.48.0",
    "@hookform/resolvers": "^3.3.0",
    "zod": "^3.22.0",
    "zustand": "^4.4.0",
    "@prisma/client": "^5.6.0",
    "drizzle-orm": "^0.29.0",
    "next-auth": "^5.0.0-beta"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "typescript": "^5.0.0",
    "tailwindcss": "^3.3.0",
    "postcss": "^8.4.0",
    "autoprefixer": "^10.4.0",
    "eslint": "^8.0.0",
    "eslint-config-next": "^14.0.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "prettier": "^3.0.0",
    "prettier-plugin-tailwindcss": "^0.5.0",
    "jest": "^29.0.0",
    "jest-environment-jsdom": "^29.0.0",
    "@testing-library/react": "^14.0.0",
    "@testing-library/jest-dom": "^6.0.0",
    "@testing-library/user-event": "^14.0.0",
    "@playwright/test": "^1.40.0",
    "prisma": "^5.6.0",
    "drizzle-kit": "^0.20.0",
    "pg": "^8.11.0",
    "@types/pg": "^8.10.0",
    "tsx": "^4.0.0",
    "husky": "^8.0.0",
    "lint-staged": "^15.0.0"
  }
}
```

#### tsconfig.json Template
```json
{
  "compilerOptions": {
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "@/components/*": ["./src/components/*"],
      "@/lib/*": ["./src/lib/*"],
      "@/hooks/*": ["./src/hooks/*"],
      "@/types/*": ["./src/types/*"],
      "@/app/*": ["./src/app/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

#### next.config.js Template
```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  // Enable experimental features
  experimental: {
    typedRoutes: true,
  },
  
  // Image optimization
  images: {
    domains: ['localhost'],
    formats: ['image/webp', 'image/avif'],
  },
  
  // Security headers
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'Referrer-Policy',
            value: 'origin-when-cross-origin',
          },
        ],
      },
    ];
  },
  
  // Environment variables validation
  env: {
    CUSTOM_KEY: process.env.CUSTOM_KEY,
  },
};

module.exports = nextConfig;
```

## Component Architecture

### Component Structure Template
```typescript
/**
 * ComponentName - Brief description of what this component does
 * 
 * @description Detailed description of the component's purpose,
 * behavior, and any important implementation details.
 * 
 * @example
 * ```tsx
 * <ComponentName 
 *   prop1="value1" 
 *   prop2={42}
 *   onAction={handleAction}
 * />
 * ```
 * 
 * @author Your Name
 * @since 2024-01-01
 */

import React from 'react';
import { cn } from '@/lib/utils';
import { type VariantProps, cva } from 'class-variance-authority';

// Component variants using CVA
const componentVariants = cva(
  // Base styles
  "base-classes-here",
  {
    variants: {
      variant: {
        default: "default-styles",
        secondary: "secondary-styles",
        destructive: "destructive-styles",
      },
      size: {
        sm: "small-styles",
        md: "medium-styles", 
        lg: "large-styles",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "md",
    },
  }
);

// Props interface
interface ComponentNameProps 
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof componentVariants> {
  /**
   * Description of prop1
   */
  prop1: string;
  
  /**
   * Description of prop2
   * @default 0
   */
  prop2?: number;
  
  /**
   * Callback function description
   */
  onAction?: (value: string) => void;
  
  /**
   * Whether component is disabled
   * @default false
   */
  disabled?: boolean;
  
  /**
   * Children elements
   */
  children?: React.ReactNode;
}

// Component implementation
export const ComponentName = React.forwardRef<
  HTMLDivElement,
  ComponentNameProps
>(({ 
  className, 
  variant, 
  size, 
  prop1, 
  prop2 = 0, 
  onAction,
  disabled = false,
  children,
  ...props 
}, ref) => {
  // Component logic here
  const handleClick = () => {
    if (disabled || !onAction) return;
    onAction(prop1);
  };

  return (
    <div
      ref={ref}
      className={cn(componentVariants({ variant, size, className }))}
      onClick={handleClick}
      data-testid="component-name"
      {...props}
    >
      {children}
    </div>
  );
});

ComponentName.displayName = "ComponentName";

export type { ComponentNameProps };
```

### Custom Hook Template
```typescript
/**
 * useCustomHook - Brief description of what this hook does
 * 
 * @description Detailed description of the hook's purpose,
 * behavior, and any important implementation details.
 * 
 * @param param1 - Description of parameter
 * @param options - Configuration options
 * @returns Object containing state and handlers
 * 
 * @example
 * ```tsx
 * const { data, loading, error, refetch } = useCustomHook('param-value', {
 *   enabled: true,
 *   onSuccess: (data) => console.log(data)
 * });
 * ```
 * 
 * @author Your Name
 * @since 2024-01-01
 */

import { useState, useEffect, useCallback } from 'react';
import { z } from 'zod';

// Type definitions
interface UseCustomHookOptions {
  enabled?: boolean;
  onSuccess?: (data: any) => void;
  onError?: (error: Error) => void;
}

interface UseCustomHookReturn {
  data: any | null;
  loading: boolean;
  error: Error | null;
  refetch: () => Promise<void>;
}

// Input validation schema
const paramsSchema = z.object({
  param1: z.string().min(1, "Parameter is required"),
  options: z.object({
    enabled: z.boolean().optional(),
    onSuccess: z.function().optional(),
    onError: z.function().optional(),
  }).optional(),
});

export const useCustomHook = (
  param1: string,
  options: UseCustomHookOptions = {}
): UseCustomHookReturn => {
  // Validate inputs
  const validatedParams = paramsSchema.parse({ param1, options });
  
  // State management
  const [data, setData] = useState<any | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  // Fetch function
  const fetchData = useCallback(async () => {
    if (!options.enabled) return;

    try {
      setLoading(true);
      setError(null);
      
      // Fetch logic here
      const response = await fetch(`/api/data/${param1}`);
      
      if (!response.ok) {
        throw new Error(`Failed to fetch: ${response.statusText}`);
      }
      
      const result = await response.json();
      setData(result);
      
      // Success callback
      options.onSuccess?.(result);
      
    } catch (err) {
      const error = err instanceof Error ? err : new Error('Unknown error');
      setError(error);
      options.onError?.(error);
    } finally {
      setLoading(false);
    }
  }, [param1, options]);

  // Effect for initial fetch
  useEffect(() => {
    fetchData();
  }, [fetchData]);

  return {
    data,
    loading,
    error,
    refetch: fetchData,
  };
};

export type { UseCustomHookOptions, UseCustomHookReturn };
```

## Database Configuration

### Prisma vs Drizzle - Choosing Your ORM

**Prisma** - Schema-first approach with excellent tooling
- ✅ Mature ecosystem with excellent documentation
- ✅ Prisma Studio for database visualization
- ✅ Type-safe client generation
- ✅ Built-in migration system
- ❌ Larger bundle size
- ❌ Less flexible for complex queries

**Drizzle** - SQL-like syntax with better performance
- ✅ Lightweight and fast
- ✅ SQL-like syntax, familiar to SQL developers
- ✅ Better performance for complex queries
- ✅ More flexible and customizable
- ❌ Newer ecosystem, less tooling
- ❌ Steeper learning curve

### Drizzle Configuration

#### drizzle.config.ts
```typescript
import type { Config } from 'drizzle-kit';
import { env } from '@/lib/env';

export default {
  schema: './drizzle/schema.ts',
  out: './drizzle/migrations',
  driver: 'pg',
  dbCredentials: {
    connectionString: env.DATABASE_URL,
  },
  verbose: true,
  strict: true,
} satisfies Config;
```

#### drizzle/schema.ts
```typescript
/**
 * Drizzle Database Schema
 * 
 * @description Complete database schema definition using Drizzle ORM.
 * Includes all tables, relationships, and constraints for the application.
 * 
 * @author Your Name
 * @since 2024-01-01
 */

import {
  pgTable,
  text,
  timestamp,
  uuid,
  varchar,
  boolean,
  integer,
  jsonb,
  index,
  uniqueIndex,
} from 'drizzle-orm/pg-core';
import { relations } from 'drizzle-orm';
import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { z } from 'zod';

// Users table
export const users = pgTable(
  'users',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    email: varchar('email', { length: 255 }).notNull().unique(),
    name: varchar('name', { length: 255 }),
    image: text('image'),
    emailVerified: timestamp('email_verified', { mode: 'date' }),
    createdAt: timestamp('created_at', { mode: 'date' }).defaultNow().notNull(),
    updatedAt: timestamp('updated_at', { mode: 'date' }).defaultNow().notNull(),
  },
  (table) => {
    return {
      emailIdx: uniqueIndex('users_email_idx').on(table.email),
    };
  }
);

// Resources table
export const resources = pgTable(
  'resources',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    name: varchar('name', { length: 255 }).notNull(),
    description: text('description'),
    status: varchar('status', { length: 50 }).default('active').notNull(),
    metadata: jsonb('metadata'),
    userId: uuid('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    createdAt: timestamp('created_at', { mode: 'date' }).defaultNow().notNull(),
    updatedAt: timestamp('updated_at', { mode: 'date' }).defaultNow().notNull(),
  },
  (table) => {
    return {
      userIdIdx: index('resources_user_id_idx').on(table.userId),
      statusIdx: index('resources_status_idx').on(table.status),
    };
  }
);

// Categories table
export const categories = pgTable(
  'categories',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    name: varchar('name', { length: 100 }).notNull(),
    slug: varchar('slug', { length: 100 }).notNull().unique(),
    description: text('description'),
    parentId: uuid('parent_id'),
    sortOrder: integer('sort_order').default(0),
    isActive: boolean('is_active').default(true).notNull(),
    createdAt: timestamp('created_at', { mode: 'date' }).defaultNow().notNull(),
    updatedAt: timestamp('updated_at', { mode: 'date' }).defaultNow().notNull(),
  },
  (table) => {
    return {
      slugIdx: uniqueIndex('categories_slug_idx').on(table.slug),
      parentIdIdx: index('categories_parent_id_idx').on(table.parentId),
    };
  }
);

// Resource-Category junction table
export const resourceCategories = pgTable(
  'resource_categories',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    resourceId: uuid('resource_id').notNull().references(() => resources.id, { onDelete: 'cascade' }),
    categoryId: uuid('category_id').notNull().references(() => categories.id, { onDelete: 'cascade' }),
    createdAt: timestamp('created_at', { mode: 'date' }).defaultNow().notNull(),
  },
  (table) => {
    return {
      resourceCategoryIdx: uniqueIndex('resource_category_idx').on(
        table.resourceId,
        table.categoryId
      ),
    };
  }
);

// Relations
export const usersRelations = relations(users, ({ many }) => ({
  resources: many(resources),
}));

export const resourcesRelations = relations(resources, ({ one, many }) => ({
  user: one(users, {
    fields: [resources.userId],
    references: [users.id],
  }),
  categories: many(resourceCategories),
}));

export const categoriesRelations = relations(categories, ({ one, many }) => ({
  parent: one(categories, {
    fields: [categories.parentId],
    references: [categories.id],
  }),
  children: many(categories),
  resources: many(resourceCategories),
}));

export const resourceCategoriesRelations = relations(resourceCategories, ({ one }) => ({
  resource: one(resources, {
    fields: [resourceCategories.resourceId],
    references: [resources.id],
  }),
  category: one(categories, {
    fields: [resourceCategories.categoryId],
    references: [categories.id],
  }),
}));

// Zod schemas for validation
export const insertUserSchema = createInsertSchema(users, {
  email: z.string().email('Invalid email format'),
  name: z.string().min(1, 'Name is required').max(255, 'Name too long'),
});

export const selectUserSchema = createSelectSchema(users);

export const insertResourceSchema = createInsertSchema(resources, {
  name: z.string().min(1, 'Name is required').max(255, 'Name too long'),
  description: z.string().optional(),
  status: z.enum(['active', 'inactive', 'draft']).default('active'),
  metadata: z.record(z.any()).optional(),
});

export const selectResourceSchema = createSelectSchema(resources);

export const insertCategorySchema = createInsertSchema(categories, {
  name: z.string().min(1, 'Name is required').max(100, 'Name too long'),
  slug: z.string().min(1, 'Slug is required').max(100, 'Slug too long'),
  description: z.string().optional(),
  sortOrder: z.number().int().min(0).default(0),
  isActive: z.boolean().default(true),
});

export const selectCategorySchema = createSelectSchema(categories);

// Type exports
export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;
export type Resource = typeof resources.$inferSelect;
export type NewResource = typeof resources.$inferInsert;
export type Category = typeof categories.$inferSelect;
export type NewCategory = typeof categories.$inferInsert;
export type ResourceCategory = typeof resourceCategories.$inferSelect;
export type NewResourceCategory = typeof resourceCategories.$inferInsert;

// Enhanced types with relations
export type UserWithResources = User & {
  resources: Resource[];
};

export type ResourceWithUser = Resource & {
  user: User;
};

export type ResourceWithCategories = Resource & {
  categories: (ResourceCategory & {
    category: Category;
  })[];
};

export type CategoryWithChildren = Category & {
  children: Category[];
};
```

#### lib/db.ts (Drizzle version)
```typescript
/**
 * Database Connection and Query Builder
 * 
 * @description Drizzle database connection setup with query building utilities.
 * Provides type-safe database access and connection management.
 * 
 * @author Your Name
 * @since 2024-01-01
 */

import { drizzle } from 'drizzle-orm/postgres-js';
import postgres from 'postgres';
import { env } from '@/lib/env';
import * as schema from '@/drizzle/schema';

// Create connection
const connectionString = env.DATABASE_URL;

// Disable prefetch as it is not supported for "Transaction" pool mode
const client = postgres(connectionString, { prepare: false });

// Create Drizzle instance
export const db = drizzle(client, { schema });

// Query builder utilities
export class DatabaseService {
  /**
   * Get user by ID with optional relations
   */
  static async getUserById(id: string, includeResources = false) {
    if (includeResources) {
      return await db.query.users.findFirst({
        where: (users, { eq }) => eq(users.id, id),
        with: {
          resources: true,
        },
      });
    }

    return await db.query.users.findFirst({
      where: (users, { eq }) => eq(users.id, id),
    });
  }

  /**
   * Get user by email
   */
  static async getUserByEmail(email: string) {
    return await db.query.users.findFirst({
      where: (users, { eq }) => eq(users.email, email),
    });
  }

  /**
   * Get resources for a user with pagination
   */
  static async getUserResources(
    userId: string,
    options: {
      limit?: number;
      offset?: number;
      includeCategories?: boolean;
    } = {}
  ) {
    const { limit = 10, offset = 0, includeCategories = false } = options;

    const baseQuery = {
      where: (resources, { eq }) => eq(resources.userId, userId),
      limit,
      offset,
      orderBy: (resources, { desc }) => [desc(resources.createdAt)],
    };

    if (includeCategories) {
      return await db.query.resources.findMany({
        ...baseQuery,
        with: {
          categories: {
            with: {
              category: true,
            },
          },
        },
      });
    }

    return await db.query.resources.findMany(baseQuery);
  }

  /**
   * Get resource by ID with user authorization check
   */
  static async getResourceById(id: string, userId?: string) {
    const resource = await db.query.resources.findFirst({
      where: (resources, { eq }) => eq(resources.id, id),
      with: {
        user: true,
        categories: {
          with: {
            category: true,
          },
        },
      },
    });

    // Check authorization if userId provided
    if (userId && resource?.userId !== userId) {
      throw new Error('Unauthorized access to resource');
    }

    return resource;
  }

  /**
   * Create resource with categories
   */
  static async createResource(
    data: typeof schema.insertResourceSchema._type,
    categoryIds: string[] = []
  ) {
    return await db.transaction(async (tx) => {
      // Insert resource
      const [resource] = await tx.insert(schema.resources).values(data).returning();

      // Link categories if provided
      if (categoryIds.length > 0) {
        const categoryLinks = categoryIds.map((categoryId) => ({
          resourceId: resource.id,
          categoryId,
        }));

        await tx.insert(schema.resourceCategories).values(categoryLinks);
      }

      return resource;
    });
  }

  /**
   * Update resource with categories
   */
  static async updateResource(
    id: string,
    data: Partial<typeof schema.insertResourceSchema._type>,
    categoryIds?: string[]
  ) {
    return await db.transaction(async (tx) => {
      // Update resource
      const [resource] = await tx
        .update(schema.resources)
        .set({ ...data, updatedAt: new Date() })
        .where(eq(schema.resources.id, id))
        .returning();

      // Update categories if provided
      if (categoryIds !== undefined) {
        // Remove existing category links
        await tx
          .delete(schema.resourceCategories)
          .where(eq(schema.resourceCategories.resourceId, id));

        // Add new category links
        if (categoryIds.length > 0) {
          const categoryLinks = categoryIds.map((categoryId) => ({
            resourceId: id,
            categoryId,
          }));

          await tx.insert(schema.resourceCategories).values(categoryLinks);
        }
      }

      return resource;
    });
  }

  /**
   * Delete resource and its relations
   */
  static async deleteResource(id: string) {
    return await db.delete(schema.resources).where(eq(schema.resources.id, id));
  }

  /**
   * Get categories with hierarchy
   */
  static async getCategories(includeHierarchy = false) {
    if (includeHierarchy) {
      return await db.query.categories.findMany({
        with: {
          children: true,
          parent: true,
        },
        orderBy: (categories, { asc }) => [asc(categories.sortOrder), asc(categories.name)],
      });
    }

    return await db.query.categories.findMany({
      orderBy: (categories, { asc }) => [asc(categories.sortOrder), asc(categories.name)],
    });
  }
}

// Re-export schema for convenience
export * from '@/drizzle/schema';

// Export eq and other operators for raw queries
export { eq, and, or, not, isNull, isNotNull, inArray, notInArray } from 'drizzle-orm';
```

#### drizzle/seed.ts
```typescript
/**
 * Database Seeding Script
 * 
 * @description Seeds the database with initial data for development and testing.
 * Run with: npm run drizzle:seed
 * 
 * @author Your Name
 * @since 2024-01-01
 */

import { db } from '@/lib/db';
import { users, categories, resources, resourceCategories } from './schema';
import { eq } from 'drizzle-orm';

async function seed() {
  console.log('🌱 Seeding database...');

  try {
    // Clean existing data (be careful in production!)
    if (process.env.NODE_ENV === 'development') {
      console.log('🧹 Cleaning existing data...');
      await db.delete(resourceCategories);
      await db.delete(resources);
      await db.delete(categories);
      await db.delete(users);
    }

    // Create sample users
    console.log('👥 Creating users...');
    const [user1, user2] = await db
      .insert(users)
      .values([
        {
          email: 'john.doe@example.com',
          name: 'John Doe',
          image: 'https://github.com/johndoe.png',
        },
        {
          email: 'jane.smith@example.com',
          name: 'Jane Smith',
          image: 'https://github.com/janesmith.png',
        },
      ])
      .returning();

    // Create sample categories
    console.log('📂 Creating categories...');
    const [tech, design, business] = await db
      .insert(categories)
      .values([
        {
          name: 'Technology',
          slug: 'technology',
          description: 'Tech-related resources',
          sortOrder: 1,
        },
        {
          name: 'Design',
          slug: 'design',
          description: 'Design and UI/UX resources',
          sortOrder: 2,
        },
        {
          name: 'Business',
          slug: 'business',
          description: 'Business and entrepreneurship',
          sortOrder: 3,
        },
      ])
      .returning();

    // Create subcategories
    const [frontend, backend] = await db
      .insert(categories)
      .values([
        {
          name: 'Frontend',
          slug: 'frontend',
          description: 'Frontend development',
          parentId: tech.id,
          sortOrder: 1,
        },
        {
          name: 'Backend',
          slug: 'backend',
          description: 'Backend development',
          parentId: tech.id,
          sortOrder: 2,
        },
      ])
      .returning();

    // Create sample resources
    console.log('📝 Creating resources...');
    const [resource1, resource2, resource3] = await db
      .insert(resources)
      .values([
        {
          name: 'Next.js Documentation',
          description: 'Official Next.js documentation and guides',
          status: 'active',
          userId: user1.id,
          metadata: {
            url: 'https://nextjs.org/docs',
            tags: ['react', 'nextjs', 'documentation'],
          },
        },
        {
          name: 'Figma Design System',
          description: 'Complete design system in Figma',
          status: 'active',
          userId: user1.id,
          metadata: {
            url: 'https://figma.com',
            tags: ['design', 'figma', 'design-system'],
          },
        },
        {
          name: 'Startup Pitch Deck Template',
          description: 'Professional pitch deck template for startups',
          status: 'draft',
          userId: user2.id,
          metadata: {
            tags: ['business', 'startup', 'pitch'],
          },
        },
      ])
      .returning();

    // Link resources to categories
    console.log('🔗 Linking resources to categories...');
    await db.insert(resourceCategories).values([
      { resourceId: resource1.id, categoryId: tech.id },
      { resourceId: resource1.id, categoryId: frontend.id },
      { resourceId: resource2.id, categoryId: design.id },
      { resourceId: resource3.id, categoryId: business.id },
    ]);

    console.log('✅ Database seeded successfully!');
    console.log(`Created ${user1.name} and ${user2.name} as sample users`);
    console.log(`Created ${[tech, design, business, frontend, backend].length} categories`);
    console.log(`Created ${[resource1, resource2, resource3].length} resources`);

  } catch (error) {
    console.error('❌ Error seeding database:', error);
    throw error;
  }
}

// Run the seed function
if (require.main === module) {
  seed()
    .then(() => {
      console.log('🎉 Seeding completed!');
      process.exit(0);
    })
    .catch((error) => {
      console.error('💥 Seeding failed:', error);
      process.exit(1);
    });
}

export { seed };
```

### Drizzle API Route Example

```typescript
/**
 * API Route: /api/resources (Drizzle version)
 * 
 * @description Handles resource CRUD operations using Drizzle ORM.
 * Demonstrates Drizzle query building and transaction usage.
 */

import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { db, eq, and, desc, insertResourceSchema } from '@/lib/db';
import { resources, resourceCategories } from '@/drizzle/schema';
import { rateLimit } from '@/lib/rate-limit';

// Request validation schemas
const createResourceSchema = insertResourceSchema.extend({
  categoryIds: z.array(z.string().uuid()).optional(),
});

const querySchema = z.object({
  page: z.coerce.number().min(1).default(1),
  limit: z.coerce.number().min(1).max(100).default(10),
  status: z.enum(['active', 'inactive', 'draft']).optional(),
  categoryId: z.string().uuid().optional(),
});

// Rate limiting
const limiter = rateLimit({
  interval: 60 * 1000, // 1 minute
  uniqueTokenPerInterval: 500,
});

/**
 * GET /api/resources
 * List user's resources with filtering and pagination
 */
export async function GET(request: NextRequest) {
  try {
    await limiter.check(request, 20, 'CACHE_TOKEN');

    const session = await getServerSession(authOptions);
    if (!session) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Parse query parameters
    const { searchParams } = new URL(request.url);
    const { page, limit, status, categoryId } = querySchema.parse({
      page: searchParams.get('page'),
      limit: searchParams.get('limit'),
      status: searchParams.get('status'),
      categoryId: searchParams.get('categoryId'),
    });

    const offset = (page - 1) * limit;

    // Build where conditions
    const whereConditions = [eq(resources.userId, session.user.id)];
    
    if (status) {
      whereConditions.push(eq(resources.status, status));
    }

    // Query with Drizzle
    let query = db
      .select({
        id: resources.id,
        name: resources.name,
        description: resources.description,
        status: resources.status,
        metadata: resources.metadata,
        createdAt: resources.createdAt,
        updatedAt: resources.updatedAt,
      })
      .from(resources)
      .where(and(...whereConditions))
      .orderBy(desc(resources.createdAt))
      .limit(limit)
      .offset(offset);

    // If filtering by category, join with resourceCategories
    if (categoryId) {
      query = db
        .select({
          id: resources.id,
          name: resources.name,
          description: resources.description,
          status: resources.status,
          metadata: resources.metadata,
          createdAt: resources.createdAt,
          updatedAt: resources.updatedAt,
        })
        .from(resources)
        .innerJoin(resourceCategories, eq(resources.id, resourceCategories.resourceId))
        .where(
          and(
            ...whereConditions,
            eq(resourceCategories.categoryId, categoryId)
          )
        )
        .orderBy(desc(resources.createdAt))
        .limit(limit)
        .offset(offset);
    }

    const userResources = await query;

    // Get total count for pagination
    const totalCount = await db
      .select({ count: count() })
      .from(resources)
      .where(and(...whereConditions));

    return NextResponse.json({
      data: userResources,
      pagination: {
        page,
        limit,
        total: totalCount[0].count,
        pages: Math.ceil(totalCount[0].count / limit),
      },
    });

  } catch (error) {
    console.error('GET /api/resources error:', error);
    
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid query parameters', details: error.errors },
        { status: 400 }
      );
    }

    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

/**
 * POST /api/resources
 * Create a new resource with categories
 */
export async function POST(request: NextRequest) {
  try {
    await limiter.check(request, 10, 'CACHE_TOKEN');

    const session = await getServerSession(authOptions);
    if (!session) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const body = await request.json();
    const { categoryIds, ...resourceData } = createResourceSchema.parse(body);

    // Create resource with transaction
    const result = await db.transaction(async (tx) => {
      // Insert resource
      const [newResource] = await tx
        .insert(resources)
        .values({
          ...resourceData,
          userId: session.user.id,
        })
        .returning();

      // Link categories if provided
      if (categoryIds && categoryIds.length > 0) {
        const categoryLinks = categoryIds.map((categoryId) => ({
          resourceId: newResource.id,
          categoryId,
        }));

        await tx.insert(resourceCategories).values(categoryLinks);
      }

      return newResource;
    });

    return NextResponse.json(result, { status: 201 });

  } catch (error) {
    console.error('POST /api/resources error:', error);
    
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input', details: error.errors },
        { status: 400 }
      );
    }

    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

## API Route Template

### API Route Structure
```typescript
/**
 * API Route: /api/resource/[id]
 * 
 * @description Handles CRUD operations for the resource entity.
 * Supports GET, POST, PUT, DELETE methods with proper validation,
 * authentication, and error handling.
 * 
 * @author Your Name
 * @since 2024-01-01
 */

import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { db } from '@/lib/db';
import { rateLimit } from '@/lib/rate-limit';

// Request validation schemas
const createResourceSchema = z.object({
  name: z.string().min(1, "Name is required").max(100),
  description: z.string().optional(),
  status: z.enum(['active', 'inactive']).default('active'),
});

const updateResourceSchema = createResourceSchema.partial();

const paramsSchema = z.object({
  id: z.string().uuid("Invalid resource ID"),
});

// Rate limiting
const limiter = rateLimit({
  interval: 60 * 1000, // 1 minute
  uniqueTokenPerInterval: 500,
});

/**
 * GET /api/resource/[id]
 * Retrieves a specific resource by ID
 */
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Rate limiting
    await limiter.check(request, 10, 'CACHE_TOKEN');
    
    // Validate parameters
    const { id } = paramsSchema.parse(params);
    
    // Authentication check
    const session = await getServerSession(authOptions);
    if (!session) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // Database query
    const resource = await db.resource.findUnique({
      where: { id },
      include: {
        // Include related data if needed
        relatedData: true,
      },
    });

    if (!resource) {
      return NextResponse.json(
        { error: 'Resource not found' },
        { status: 404 }
      );
    }

    // Authorization check
    if (resource.userId !== session.user.id) {
      return NextResponse.json(
        { error: 'Forbidden' },
        { status: 403 }
      );
    }

    return NextResponse.json(resource);

  } catch (error) {
    console.error('GET /api/resource/[id] error:', error);
    
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input', details: error.errors },
        { status: 400 }
      );
    }

    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

/**
 * PUT /api/resource/[id]
 * Updates a specific resource
 */
export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Rate limiting
    await limiter.check(request, 5, 'CACHE_TOKEN');
    
    // Validate parameters
    const { id } = paramsSchema.parse(params);
    
    // Authentication check
    const session = await getServerSession(authOptions);
    if (!session) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // Parse and validate request body
    const body = await request.json();
    const validatedData = updateResourceSchema.parse(body);

    // Check if resource exists and user owns it
    const existingResource = await db.resource.findUnique({
      where: { id },
    });

    if (!existingResource) {
      return NextResponse.json(
        { error: 'Resource not found' },
        { status: 404 }
      );
    }

    if (existingResource.userId !== session.user.id) {
      return NextResponse.json(
        { error: 'Forbidden' },
        { status: 403 }
      );
    }

    // Update resource
    const updatedResource = await db.resource.update({
      where: { id },
      data: {
        ...validatedData,
        updatedAt: new Date(),
      },
    });

    return NextResponse.json(updatedResource);

  } catch (error) {
    console.error('PUT /api/resource/[id] error:', error);
    
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input', details: error.errors },
        { status: 400 }
      );
    }

    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

/**
 * DELETE /api/resource/[id]
 * Deletes a specific resource
 */
export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Rate limiting
    await limiter.check(request, 3, 'CACHE_TOKEN');
    
    // Validate parameters
    const { id } = paramsSchema.parse(params);
    
    // Authentication check
    const session = await getServerSession(authOptions);
    if (!session) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // Check if resource exists and user owns it
    const existingResource = await db.resource.findUnique({
      where: { id },
    });

    if (!existingResource) {
      return NextResponse.json(
        { error: 'Resource not found' },
        { status: 404 }
      );
    }

    if (existingResource.userId !== session.user.id) {
      return NextResponse.json(
        { error: 'Forbidden' },
        { status: 403 }
      );
    }

    // Delete resource
    await db.resource.delete({
      where: { id },
    });

    return NextResponse.json(
      { message: 'Resource deleted successfully' },
      { status: 200 }
    );

  } catch (error) {
    console.error('DELETE /api/resource/[id] error:', error);
    
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input', details: error.errors },
        { status: 400 }
      );
    }

    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

## Testing Best Practices

### Component Test Template
```typescript
/**
 * ComponentName.test.tsx
 * Unit tests for ComponentName component
 */

import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { ComponentName } from '../ComponentName';

// Mock dependencies
jest.mock('@/lib/utils', () => ({
  cn: jest.fn((...args) => args.join(' ')),
}));

describe('ComponentName', () => {
  const defaultProps = {
    prop1: 'test-value',
    prop2: 42,
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('Rendering', () => {
    it('renders with required props', () => {
      render(<ComponentName {...defaultProps} />);
      
      expect(screen.getByTestId('component-name')).toBeInTheDocument();
    });

    it('renders children correctly', () => {
      render(
        <ComponentName {...defaultProps}>
          <span>Test Child</span>
        </ComponentName>
      );
      
      expect(screen.getByText('Test Child')).toBeInTheDocument();
    });

    it('applies correct CSS classes', () => {
      const { container } = render(
        <ComponentName 
          {...defaultProps} 
          className="custom-class"
          variant="secondary"
          size="lg"
        />
      );
      
      const element = container.firstChild;
      expect(element).toHaveClass('custom-class');
    });
  });

  describe('Interaction', () => {
    it('calls onAction when clicked', async () => {
      const mockOnAction = jest.fn();
      const user = userEvent.setup();
      
      render(
        <ComponentName 
          {...defaultProps} 
          onAction={mockOnAction}
        />
      );
      
      await user.click(screen.getByTestId('component-name'));
      
      expect(mockOnAction).toHaveBeenCalledWith('test-value');
      expect(mockOnAction).toHaveBeenCalledTimes(1);
    });

    it('does not call onAction when disabled', async () => {
      const mockOnAction = jest.fn();
      const user = userEvent.setup();
      
      render(
        <ComponentName 
          {...defaultProps} 
          onAction={mockOnAction}
          disabled
        />
      );
      
      await user.click(screen.getByTestId('component-name'));
      
      expect(mockOnAction).not.toHaveBeenCalled();
    });
  });

  describe('Accessibility', () => {
    it('has proper ARIA attributes', () => {
      render(<ComponentName {...defaultProps} />);
      
      const element = screen.getByTestId('component-name');
      expect(element).toHaveAttribute('role');
      expect(element).toHaveAttribute('aria-label');
    });

    it('supports keyboard navigation', async () => {
      const mockOnAction = jest.fn();
      const user = userEvent.setup();
      
      render(
        <ComponentName 
          {...defaultProps} 
          onAction={mockOnAction}
        />
      );
      
      const element = screen.getByTestId('component-name');
      element.focus();
      
      await user.keyboard('{Enter}');
      expect(mockOnAction).toHaveBeenCalled();
    });
  });

  describe('Edge Cases', () => {
    it('handles undefined onAction gracefully', async () => {
      const user = userEvent.setup();
      
      expect(() => {
        render(<ComponentName {...defaultProps} />);
      }).not.toThrow();
      
      await user.click(screen.getByTestId('component-name'));
      // Should not throw error
    });

    it('handles empty children', () => {
      render(<ComponentName {...defaultProps}>{null}</ComponentName>);
      
      expect(screen.getByTestId('component-name')).toBeInTheDocument();
    });
  });
});
```

### API Route Test Template
```typescript
/**
 * resource.test.ts
 * Integration tests for resource API routes
 */

import { NextRequest } from 'next/server';
import { GET, PUT, DELETE } from '../resource/[id]/route';

// Mock dependencies
jest.mock('@/lib/auth');
jest.mock('@/lib/db');
jest.mock('@/lib/rate-limit');

describe('/api/resource/[id]', () => {
  const mockSession = {
    user: { id: 'user-123', email: 'test@example.com' },
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('GET', () => {
    it('returns resource for authenticated user', async () => {
      // Mock implementations
      require('@/lib/auth').getServerSession.mockResolvedValue(mockSession);
      require('@/lib/db').db.resource.findUnique.mockResolvedValue({
        id: 'resource-123',
        name: 'Test Resource',
        userId: 'user-123',
      });
      require('@/lib/rate-limit').rateLimit.mockReturnValue({
        check: jest.fn().mockResolvedValue(undefined),
      });

      const request = new NextRequest('http://localhost/api/resource/resource-123');
      const params = { id: 'resource-123' };

      const response = await GET(request, { params });
      const data = await response.json();

      expect(response.status).toBe(200);
      expect(data.id).toBe('resource-123');
      expect(data.name).toBe('Test Resource');
    });

    it('returns 401 for unauthenticated user', async () => {
      require('@/lib/auth').getServerSession.mockResolvedValue(null);
      require('@/lib/rate-limit').rateLimit.mockReturnValue({
        check: jest.fn().mockResolvedValue(undefined),
      });

      const request = new NextRequest('http://localhost/api/resource/resource-123');
      const params = { id: 'resource-123' };

      const response = await GET(request, { params });
      const data = await response.json();

      expect(response.status).toBe(401);
      expect(data.error).toBe('Unauthorized');
    });

    it('returns 404 for non-existent resource', async () => {
      require('@/lib/auth').getServerSession.mockResolvedValue(mockSession);
      require('@/lib/db').db.resource.findUnique.mockResolvedValue(null);
      require('@/lib/rate-limit').rateLimit.mockReturnValue({
        check: jest.fn().mockResolvedValue(undefined),
      });

      const request = new NextRequest('http://localhost/api/resource/resource-123');
      const params = { id: 'resource-123' };

      const response = await GET(request, { params });
      const data = await response.json();

      expect(response.status).toBe(404);
      expect(data.error).toBe('Resource not found');
    });

    it('returns 403 for unauthorized resource access', async () => {
      require('@/lib/auth').getServerSession.mockResolvedValue(mockSession);
      require('@/lib/db').db.resource.findUnique.mockResolvedValue({
        id: 'resource-123',
        name: 'Test Resource',
        userId: 'other-user', // Different user
      });
      require('@/lib/rate-limit').rateLimit.mockReturnValue({
        check: jest.fn().mockResolvedValue(undefined),
      });

      const request = new NextRequest('http://localhost/api/resource/resource-123');
      const params = { id: 'resource-123' };

      const response = await GET(request, { params });
      const data = await response.json();

      expect(response.status).toBe(403);
      expect(data.error).toBe('Forbidden');
    });
  });

  describe('PUT', () => {
    it('updates resource successfully', async () => {
      const updateData = { name: 'Updated Resource' };
      
      require('@/lib/auth').getServerSession.mockResolvedValue(mockSession);
      require('@/lib/db').db.resource.findUnique.mockResolvedValue({
        id: 'resource-123',
        userId: 'user-123',
      });
      require('@/lib/db').db.resource.update.mockResolvedValue({
        id: 'resource-123',
        name: 'Updated Resource',
        userId: 'user-123',
      });
      require('@/lib/rate-limit').rateLimit.mockReturnValue({
        check: jest.fn().mockResolvedValue(undefined),
      });

      const request = new NextRequest('http://localhost/api/resource/resource-123', {
        method: 'PUT',
        body: JSON.stringify(updateData),
      });
      const params = { id: 'resource-123' };

      const response = await PUT(request, { params });
      const data = await response.json();

      expect(response.status).toBe(200);
      expect(data.name).toBe('Updated Resource');
    });

    it('validates request body', async () => {
      const invalidData = { name: '' }; // Invalid: empty name
      
      require('@/lib/auth').getServerSession.mockResolvedValue(mockSession);
      require('@/lib/rate-limit').rateLimit.mockReturnValue({
        check: jest.fn().mockResolvedValue(undefined),
      });

      const request = new NextRequest('http://localhost/api/resource/resource-123', {
        method: 'PUT',
        body: JSON.stringify(invalidData),
      });
      const params = { id: 'resource-123' };

      const response = await PUT(request, { params });
      const data = await response.json();

      expect(response.status).toBe(400);
      expect(data.error).toBe('Invalid input');
      expect(data.details).toBeDefined();
    });
  });
});
```

## Documentation Standards

### README.md Template
```markdown
# Project Name

Brief description of what this Next.js application does and its main purpose.

![App Screenshot](./public/images/screenshot.png)

## Features

- ✅ **Modern Stack**: Next.js 14, TypeScript, Tailwind CSS
- ✅ **UI Components**: Shadcn/UI with Radix primitives
- ✅ **Authentication**: NextAuth.js with multiple providers
- ✅ **Database**: Prisma ORM with PostgreSQL
- ✅ **Testing**: Jest, RTL, and Playwright E2E
- ✅ **Type Safety**: Full TypeScript with strict mode
- ✅ **Code Quality**: ESLint, Prettier, Husky hooks
- ✅ **Deployment**: Vercel-optimized with CI/CD

## Tech Stack

### Core
- **Framework**: [Next.js 14](https://nextjs.org/) (App Router)
- **Language**: [TypeScript](https://www.typescriptlang.org/)
- **Styling**: [Tailwind CSS](https://tailwindcss.com/)
- **UI Components**: [Shadcn/UI](https://ui.shadcn.com/)

### Backend
- **Database**: [PostgreSQL](https://www.postgresql.org/) with [Prisma](https://www.prisma.io/) or [Drizzle](https://orm.drizzle.team/)
- **Authentication**: [NextAuth.js](https://next-auth.js.org/)
- **Validation**: [Zod](https://zod.dev/)

### Development
- **Testing**: [Jest](https://jestjs.io/) + [RTL](https://testing-library.com/) + [Playwright](https://playwright.dev/)
- **Linting**: [ESLint](https://eslint.org/) + [Prettier](https://prettier.io/)
- **Git Hooks**: [Husky](https://typicode.github.io/husky/)

## Getting Started

### Prerequisites

- Node.js 18.17 or later
- npm/yarn/pnpm
- PostgreSQL database (local or cloud)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/username/project-name.git
   cd project-name
   ```

2. **Install dependencies**
   ```bash
   npm install
   # or
   yarn install
   # or
   pnpm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env.local
   ```
   
   Fill in your environment variables:
   ```env
   # Database
   DATABASE_URL="postgresql://user:password@localhost:5432/dbname"
   
   # NextAuth
   NEXTAUTH_SECRET="your-secret-key"
   NEXTAUTH_URL="http://localhost:3000"
   
   # OAuth Providers (optional)
   GOOGLE_CLIENT_ID="your-google-client-id"
   GOOGLE_CLIENT_SECRET="your-google-client-secret"
   ```

4. **Set up the database**

   **For Prisma:**
   ```bash
   # Generate Prisma client
   npm run db:generate
   
   # Run migrations
   npm run db:migrate
   
   # Seed the database (optional)
   npm run db:seed
   ```

   **For Drizzle:**
   ```bash
   # Generate migrations
   npm run drizzle:generate
   
   # Push schema to database
   npm run drizzle:push
   
   # Seed the database (optional)
   npm run drizzle:seed
   ```

5. **Start the development server**
   ```bash
   npm run dev
   ```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## Development

### Available Scripts

```bash
# Development
npm run dev          # Start development server
npm run build        # Build for production
npm run start        # Start production server

# Code Quality
npm run lint         # Run ESLint
npm run lint:fix     # Fix ESLint issues
npm run type-check   # Run TypeScript checker

# Testing
npm run test         # Run unit tests
npm run test:watch   # Run tests in watch mode
npm run test:coverage # Run tests with coverage
npm run test:e2e     # Run E2E tests

# Database (Prisma)
npm run db:generate  # Generate Prisma client
npm run db:push      # Push schema changes
npm run db:migrate   # Run migrations
npm run db:studio    # Open Prisma Studio
npm run db:seed      # Seed database

# Database (Drizzle)
npm run drizzle:generate  # Generate migrations
npm run drizzle:push      # Push schema to database
npm run drizzle:migrate   # Run migrations
npm run drizzle:studio    # Open Drizzle Studio
npm run drizzle:seed      # Seed database
```

### Project Structure

```
src/
├── app/                 # App Router pages and layouts
│   ├── (auth)/         # Auth route group
│   ├── api/            # API routes
│   ├── dashboard/      # Dashboard pages
│   ├── layout.tsx      # Root layout
│   └── page.tsx        # Home page
├── components/         # React components
│   ├── ui/            # Shadcn/UI components
│   ├── forms/         # Form components
│   ├── layout/        # Layout components
│   └── custom/        # Custom components
├── lib/               # Utility functions
│   ├── utils.ts       # General utilities
│   ├── db.ts          # Database connection
│   ├── auth.ts        # Auth configuration
│   └── validators.ts  # Zod schemas
├── hooks/             # Custom React hooks
├── types/             # TypeScript type definitions
└── styles/            # Global styles
```

### Code Style

This project uses ESLint and Prettier for code formatting. Configuration:

- **ESLint**: Extends Next.js and TypeScript recommended rules
- **Prettier**: Configured with Tailwind CSS plugin
- **Husky**: Pre-commit hooks for linting and type checking

## Testing

### Unit Tests
```bash
# Run all tests
npm run test

# Run specific test file
npm run test ComponentName.test.tsx

# Run tests in watch mode
npm run test:watch

# Generate coverage report
npm run test:coverage
```

### E2E Tests
```bash
# Run E2E tests
npm run test:e2e

# Run E2E tests in UI mode
npx playwright test --ui

# Generate E2E test report
npx playwright show-report
```

## Deployment

### Vercel (Recommended)

1. **Connect your repository** to Vercel
2. **Configure environment variables** in Vercel dashboard
3. **Deploy** - Vercel will automatically build and deploy

### Manual Deployment

1. **Build the application**
   ```bash
   npm run build
   ```

2. **Start the production server**
   ```bash
   npm run start
   ```

### Environment Variables

Required environment variables for production:

```env
# Database
DATABASE_URL="your-production-database-url"

# NextAuth
NEXTAUTH_SECRET="your-production-secret"
NEXTAUTH_URL="https://your-domain.com"

# OAuth (if using)
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"
```

## API Documentation

API endpoints are documented with OpenAPI/Swagger. After starting the development server, visit:

- [API Documentation](http://localhost:3000/api/docs) (if implemented)

### Main Endpoints

- `GET /api/auth/session` - Get current session
- `GET /api/users/profile` - Get user profile
- `POST /api/resources` - Create resource
- `GET /api/resources` - List resources
- `GET /api/resources/[id]` - Get specific resource
- `PUT /api/resources/[id]` - Update resource
- `DELETE /api/resources/[id]` - Delete resource

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`npm run test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Guidelines

- Write TypeScript with strict mode
- Add tests for new features
- Follow the existing code style
- Update documentation as needed
- Ensure all checks pass before submitting PR

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you have any questions or run into issues, please:

1. Check the [documentation](./docs/)
2. Search [existing issues](https://github.com/username/project-name/issues)
3. Create a [new issue](https://github.com/username/project-name/issues/new)

## Acknowledgments

- [Next.js](https://nextjs.org/) for the amazing framework
- [Shadcn](https://ui.shadcn.com/) for the beautiful UI components
- [Vercel](https://vercel.com/) for deployment platform
```

## Quality Checklist

### ✅ Code Quality
- [ ] TypeScript strict mode enabled with no `any` types
- [ ] ESLint and Prettier configured and passing
- [ ] All components have proper TypeScript interfaces
- [ ] Error boundaries implemented for critical sections
- [ ] Environment variables properly validated
- [ ] Rate limiting implemented on API routes
- [ ] Input validation using Zod schemas
- [ ] Proper error handling and logging

### ✅ Performance
- [ ] Next.js Image component used for all images
- [ ] Dynamic imports for large components
- [ ] Proper caching strategies implemented
- [ ] Database queries optimized with proper indexes
- [ ] Bundle size analyzed and optimized
- [ ] Core Web Vitals targets met
- [ ] Lazy loading implemented where appropriate

### ✅ Security
- [ ] Authentication and authorization implemented
- [ ] CSRF protection enabled
- [ ] Input sanitization and validation
- [ ] Security headers configured
- [ ] Environment variables properly secured
- [ ] Database queries use parameterized statements
- [ ] Rate limiting on sensitive endpoints
- [ ] Proper CORS configuration

### ✅ Accessibility
- [ ] WCAG 2.1 AA compliance
- [ ] Proper semantic HTML structure
- [ ] Keyboard navigation support
- [ ] Screen reader compatibility
- [ ] Color contrast ratios meet standards
- [ ] Focus management implemented
- [ ] ARIA labels and descriptions added
- [ ] Form validation accessible

### ✅ Testing
- [ ] Unit tests for all components (>80% coverage)
- [ ] Integration tests for API routes
- [ ] E2E tests for critical user journeys
- [ ] Error handling scenarios tested
- [ ] Performance tests for critical paths
- [ ] Accessibility tests included
- [ ] CI/CD pipeline with automated testing

### ✅ Documentation
- [ ] Comprehensive README with setup instructions
- [ ] API documentation (OpenAPI/Swagger)
- [ ] Component documentation with examples
- [ ] Architecture decisions documented
- [ ] Deployment guide included
- [ ] Contributing guidelines provided
- [ ] Code comments for complex logic
- [ ] JSDoc comments for public APIs

### ✅ Deployment
- [ ] Production build successful
- [ ] Environment variables configured
- [ ] Database migrations run successfully
- [ ] Health checks implemented
- [ ] Monitoring and logging configured
- [ ] Error tracking setup (Sentry, etc.)
- [ ] Performance monitoring enabled
- [ ] Backup strategies in place

## Common Pitfalls to Avoid

- ❌ **Client-side only auth checks** - Always validate on server
- ❌ **Missing error boundaries** - Components can crash unexpectedly
- ❌ **Unoptimized database queries** - Use proper indexes and relations
- ❌ **Missing input validation** - Validate both client and server side
- ❌ **Hardcoded configurations** - Use environment variables
- ❌ **No rate limiting** - Protect against abuse
- ❌ **Missing accessibility features** - Exclude users with disabilities
- ❌ **Poor TypeScript usage** - Using `any` defeats the purpose
- ❌ **No testing strategy** - Bugs will reach production
- ❌ **Ignoring performance** - Slow apps lose users

## Best Practices Summary

### 🏗️ **Architecture**
- Use App Router for new projects
- Implement proper separation of concerns
- Follow SOLID principles in component design
- Use composition over inheritance
- Keep components small and focused

### 🔒 **Security**
- Validate input on both client and server
- Use parameterized queries
- Implement proper authentication flow
- Add rate limiting to all public endpoints
- Keep dependencies updated

### 📈 **Performance**
- Optimize images and fonts
- Implement proper caching strategies
- Use React.memo and useMemo judiciously
- Minimize bundle size
- Monitor Core Web Vitals

### 🧪 **Testing**
- Write tests first for critical features
- Test user interactions, not implementation
- Mock external dependencies
- Test error scenarios
- Maintain high test coverage

### 📚 **Documentation**
- Keep README up to date
- Document complex business logic
- Provide examples in code comments
- Maintain API documentation
- Create onboarding guides

Remember: Building a Next.js application is not just about making it work—it's about making it work well, securely, and maintainably for years to come. Follow these guidelines to create professional-grade applications that stand the test of time!