---
name: web-stack
description: Default tech stack for web apps. Next.js (latest) + Tailwind (latest) + shadcn/ui (latest) + TanStack Query (latest). All installed via CLI to ensure latest, secure versions. Swappable if different stack needed (remix-stack, astro-stack, etc).
---

# Web Stack — Next.js + Tailwind + shadcn + TanStack Query

Default stack for building web applications. Always latest versions installed via CLI to prevent RCE and other vulnerabilities in older versions.

## Stack Layers

| Layer | Tool | Install | Why |
|-------|------|---------|-----|
| **Framework** | Next.js 15+ (App Router) | `npx create-next-app@latest` | SSR, API routes, optimization |
| **Styling** | Tailwind CSS | Built into Next.js installer | Utility-first, production-grade |
| **Components** | shadcn/ui | `npx shadcn@latest init` | Unstyled, composable Radix UI + Tailwind |
| **Client State** | TanStack Query | `npm install @tanstack/react-query` | Cache, mutations, polling |

## When to Use Each Layer

### Next.js
- Initial page data: Server Components with `async` `fetch()`
- API routes: `/api/*` or Route Handlers
- Static generation: `generateStaticParams()` + `revalidateTag()`
- ISR: `revalidate: seconds` option

### Tailwind CSS
- All styling: utility classes in JSX
- Responsive: `md:`, `lg:`, `dark:` modifiers
- Custom themes: `tailwind.config.ts`
- Never write raw CSS (keep it in config)

### shadcn/ui
- Pre-built components: Button, Card, Dialog, Form, etc
- Copy-paste approach: components live in your repo (`components/ui/`)
- Fully customizable: Tailwind integration
- Radix UI under the hood: accessible, unstyled

### TanStack Query (React Query)
**Use TanStack Query for:**
- Form mutations: `useMutation()` for POST/PUT/DELETE
- Optimistic updates: `onMutate` hook
- Polling/real-time: `refetchInterval`
- Dependent queries: Skip queries until data available
- Cache invalidation: `queryClient.invalidateQueries()`

**Don't use TanStack Query for:**
- Initial page data (use Server Components)
- Static reads (use Server Components)
- Streaming (use RSC streaming)

## Installation (always `@latest`)

### 1. Create Next.js app
```bash
npx create-next-app@latest my-app --typescript --tailwind --no-eslint
cd my-app
```

### 2. Initialize shadcn/ui
```bash
npx shadcn@latest init
# Select: TypeScript, CSS Modules, components in ./components/ui, colors
```

### 3. Install TanStack Query (if needed for mutations/polling)
```bash
npm install @tanstack/react-query
```

### 4. Set up query client (app/providers.tsx)
```typescript
"use client";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { ReactNode } from "react";

const queryClient = new QueryClient({
  defaultOptions: {
    queries: { staleTime: 1000 * 60 * 5 }, // 5 min
    mutations: { retry: 1 }
  }
});

export function Providers({ children }: { children: ReactNode }) {
  return (
    <QueryClientProvider client={queryClient}>
      {children}
    </QueryClientProvider>
  );
}
```

### 5. Wrap in root layout
```typescript
// app/layout.tsx
import { Providers } from "./providers";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
```

## Pattern Examples

### Server Component (reads)
```typescript
// app/posts/page.tsx
async function PostsPage() {
  const posts = await fetch("https://api.example.com/posts", {
    next: { revalidate: 3600 } // ISR
  }).then(r => r.json());

  return (
    <div>
      {posts.map(post => (
        <PostCard key={post.id} post={post} />
      ))}
    </div>
  );
}
```

### Client Component (mutations)
```typescript
// app/posts/create-form.tsx
"use client";
import { useMutation, useQueryClient } from "@tanstack/react-query";

export function CreatePostForm() {
  const queryClient = useQueryClient();
  const { mutate, isPending } = useMutation({
    mutationFn: async (data: CreatePostInput) => {
      const res = await fetch("/api/posts", {
        method: "POST",
        body: JSON.stringify(data)
      });
      return res.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["posts"] });
    }
  });

  return (
    <form onSubmit={(e) => {
      e.preventDefault();
      mutate({ title: "New Post" });
    }}>
      <button type="submit" disabled={isPending}>
        {isPending ? "Creating..." : "Create"}
      </button>
    </form>
  );
}
```

### API Route (backend BFF)
```typescript
// app/api/posts/route.ts
import { NextRequest, NextResponse } from "next/server";

export async function GET(request: NextRequest) {
  const posts = await db.posts.findMany();
  return NextResponse.json(posts);
}

export async function POST(request: NextRequest) {
  const data = await request.json();
  const post = await db.posts.create({ data });
  return NextResponse.json(post, { status: 201 });
}
```

## Security

- **Always use `@latest`** — Older versions have RCE vulnerabilities (e.g., CVE-2025-29927)
- **Env vars**: Use `.env.local` for secrets, never commit
- **CORS**: Configure in API routes, not in headers
- **CSP**: Set in `next.config.ts`
- **Dependencies**: `npm audit` regularly

## Deployment

For VPS (62.238.6.59):
- Build: `npm run build`
- Start: `npm start`
- Reverse proxy: Auto-configured by caddy skill
- Port allocation: Auto via caddy skill

## Swapping the Stack

This skill is the default but swappable. To use a different stack:

```
Use remix-stack, astro-stack, or custom-stack instead of web-stack.
Agent will honor your choice and follow that skill's patterns.
```

## Tech Stack Decision History

- **Next.js over Remix/Astro**: Best-in-class App Router, RSC, API routes, deployment ecosystem
- **Tailwind over CSS-in-JS**: No runtime overhead, great DX, production-proven
- **shadcn/ui over Material/Bootstrap**: Radix primitives, full control, minimal bloat
- **TanStack Query over SWR**: Mutations, polling, dependent queries, offline support
