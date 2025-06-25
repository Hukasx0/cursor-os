# Website Coding Addon

## Purpose
Comprehensive guide for professional website development covering modern web standards, responsive design, accessibility, performance optimization, SEO, testing, and deployment strategies.

## Activation
This addon activates when user requests:
- Creation of websites (general web development)
- Help with responsive design
- Website optimization
- Web development best practices
- Website structure planning

## Core Principles
- **Mobile-First Design**: Start with mobile, enhance for larger screens
- **Progressive Enhancement**: Basic functionality for all, enhanced features for capable browsers
- **Performance-First**: Fast loading, optimized assets, efficient code
- **Accessibility**: WCAG 2.1 AA compliance as minimum standard
- **SEO-Optimized**: Search engine friendly structure and content
- **Modern Standards**: Latest HTML5, CSS3, and JavaScript best practices
- **Maintainable Code**: Clean, documented, modular architecture

## Integration with Other Addons
- **When creating websites from images**: Follow `image_to_website.md` specifications
- **For portfolio websites**: Use `portfolio-website.md` specialized guidelines
- **For full-stack projects**: Combine with `nextjs-fullstack.md` or `micro-saas-fullstack.md`

## User Discovery Interview

### Section 1: Project Scope (60 seconds)
**Website Type:**
- "What type of website are you building? (landing page, portfolio, blog, e-commerce, business site, web app)"
- "Is this a static site or do you need dynamic features?"
- "Do you have designs/mockups or are we starting from scratch?"
- "What's the main goal of this website?"

**Technical Requirements:**
- "Do you need a specific framework? (vanilla HTML/CSS/JS, React, Vue, Angular, or other)"
- "Any specific CMS requirements? (headless CMS, WordPress, static site generators)"
- "What's your hosting preference? (static hosting, VPS, cloud platforms)"

### Section 2: Content & Features (90 seconds)
**Content Strategy:**
- "How many pages/sections will the site have?"
- "What type of content: text, images, videos, forms, interactive elements?"
- "Do you need multilingual support?"
- "Any specific integrations? (analytics, payment, social media, APIs)"

**Functionality Requirements:**
- "Do you need contact forms, newsletters, or user registration?"
- "Any e-commerce features?"
- "Search functionality?"
- "Admin panel or content management needs?"

### Section 3: Design & User Experience (60 seconds)
**Design Preferences:**
- "Do you have brand guidelines, colors, or design system?"
- "Any design inspiration or websites you admire?"
- "Target audience and their device preferences?"
- "Accessibility requirements beyond standard compliance?"

**Performance Expectations:**
- "Any specific performance requirements? (loading speed, Core Web Vitals)"
- "Expected traffic volume?"
- "International audience? (CDN needs, multiple regions)"

### Section 4: Libraries & Tools (45 seconds)
**UI Libraries & Frameworks:**
- "Any preferred CSS frameworks? (Tailwind, Bootstrap, Bulma, custom)"
- "Component libraries? (Material-UI, Ant Design, Chakra UI)"
- "Icon libraries? (Font Awesome, Heroicons, Lucide)"
- "Animation preferences? (CSS animations, Framer Motion, GSAP)"

**Development Tools:**
- "Build tools preference? (Vite, Webpack, Parcel, Rollup)"
- "Package manager? (npm, yarn, pnpm)"
- "Code quality tools? (ESLint, Prettier, TypeScript)"

## Project Structure Templates

### Basic Static Website
```
documents/projects/website-name/
├── README.md
├── package.json
├── .gitignore
├── .env.example
├── index.html
├── src/
│   ├── css/
│   │   ├── main.css
│   │   ├── base/
│   │   │   ├── reset.css
│   │   │   ├── typography.css
│   │   │   └── variables.css
│   │   ├── components/
│   │   │   ├── header.css
│   │   │   ├── navigation.css
│   │   │   ├── buttons.css
│   │   │   ├── forms.css
│   │   │   └── cards.css
│   │   ├── layout/
│   │   │   ├── grid.css
│   │   │   ├── flexbox.css
│   │   │   └── responsive.css
│   │   └── pages/
│   │       ├── home.css
│   │       ├── about.css
│   │       └── contact.css
│   ├── js/
│   │   ├── main.js
│   │   ├── components/
│   │   │   ├── navigation.js
│   │   │   ├── modal.js
│   │   │   ├── carousel.js
│   │   │   └── forms.js
│   │   ├── utils/
│   │   │   ├── helpers.js
│   │   │   ├── api.js
│   │   │   └── validation.js
│   │   └── pages/
│   │       ├── home.js
│   │       └── contact.js
│   └── assets/
│       ├── images/
│       │   ├── optimized/
│       │   ├── original/
│       │   └── icons/
│       ├── fonts/
│       └── favicon/
├── pages/
│   ├── about.html
│   ├── services.html
│   ├── contact.html
│   └── privacy.html
├── docs/
│   ├── deployment.md
│   ├── development.md
│   ├── content-guide.md
│   └── maintenance.md
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
└── dist/ (build output)
```

### Modern Framework Project
```
documents/projects/website-name/
├── README.md
├── package.json
├── vite.config.js / next.config.js
├── tailwind.config.js
├── .env.example
├── .gitignore
├── .eslintrc.js
├── .prettierrc
├── tsconfig.json (if TypeScript)
├── src/
│   ├── components/
│   │   ├── ui/
│   │   │   ├── Button.jsx
│   │   │   ├── Input.jsx
│   │   │   ├── Modal.jsx
│   │   │   └── index.js
│   │   ├── layout/
│   │   │   ├── Header.jsx
│   │   │   ├── Footer.jsx
│   │   │   ├── Navigation.jsx
│   │   │   └── Layout.jsx
│   │   └── features/
│   │       ├── home/
│   │       ├── about/
│   │       └── contact/
│   ├── pages/ or app/
│   ├── styles/
│   │   ├── globals.css
│   │   ├── components.css
│   │   └── utilities.css
│   ├── hooks/
│   ├── utils/
│   ├── lib/
│   └── assets/
├── public/
│   ├── images/
│   ├── icons/
│   └── favicon.ico
├── docs/
├── tests/
└── .github/
    └── workflows/
        └── deploy.yml
```

## Responsive Design Standards

### Breakpoint System
```css
/* CSS Custom Properties for Breakpoints */
:root {
  --breakpoint-xs: 320px;   /* Small phones */
  --breakpoint-sm: 576px;   /* Large phones */
  --breakpoint-md: 768px;   /* Tablets */
  --breakpoint-lg: 992px;   /* Small laptops */
  --breakpoint-xl: 1200px;  /* Desktops */
  --breakpoint-xxl: 1400px; /* Large screens */
}

/* Mobile-First Media Queries */
/* Default styles for mobile (320px+) */

@media (min-width: 576px) {
  /* Small devices (landscape phones, 576px and up) */
}

@media (min-width: 768px) {
  /* Medium devices (tablets, 768px and up) */
}

@media (min-width: 992px) {
  /* Large devices (desktops, 992px and up) */
}

@media (min-width: 1200px) {
  /* X-Large devices (large desktops, 1200px and up) */
}
```

### Responsive Grid System
```css
/* Modern CSS Grid */
.grid-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: clamp(1rem, 4vw, 2rem);
  padding: clamp(1rem, 4vw, 2rem);
}

/* Responsive Flexbox */
.flex-container {
  display: flex;
  flex-wrap: wrap;
  gap: clamp(1rem, 3vw, 1.5rem);
  justify-content: space-between;
}

.flex-item {
  flex: 1 1 clamp(280px, 45%, 400px);
}
```

### Hamburger Menu Implementation
```css
/* Hamburger Menu Styles */
.hamburger {
  display: none;
  flex-direction: column;
  cursor: pointer;
  padding: 0.5rem;
  background: none;
  border: none;
  z-index: 1001;
}

.hamburger span {
  width: 25px;
  height: 3px;
  background-color: var(--text-primary);
  margin: 3px 0;
  transition: 0.3s ease;
  border-radius: 2px;
}

/* Animation States */
.hamburger.active span:nth-child(1) {
  transform: rotate(-45deg) translate(-5px, 6px);
}

.hamburger.active span:nth-child(2) {
  opacity: 0;
}

.hamburger.active span:nth-child(3) {
  transform: rotate(45deg) translate(-5px, -6px);
}

/* Mobile Navigation */
.nav-menu {
  position: fixed;
  left: -100%;
  top: 70px;
  flex-direction: column;
  background-color: white;
  width: 100%;
  text-align: center;
  transition: 0.3s ease;
  box-shadow: 0 10px 27px rgba(0, 0, 0, 0.05);
  z-index: 1000;
}

.nav-menu.active {
  left: 0;
}

@media (max-width: 768px) {
  .hamburger {
    display: flex;
  }
  
  .nav-menu {
    position: fixed;
    left: -100%;
    top: 70px;
    flex-direction: column;
    background-color: white;
    width: 100%;
    text-align: center;
    transition: 0.3s ease;
  }
}
```

```javascript
// Hamburger Menu JavaScript
document.addEventListener('DOMContentLoaded', function() {
  const hamburger = document.querySelector('.hamburger');
  const navMenu = document.querySelector('.nav-menu');
  const navLinks = document.querySelectorAll('.nav-link');

  hamburger.addEventListener('click', function() {
    hamburger.classList.toggle('active');
    navMenu.classList.toggle('active');
    
    // Accessibility: Update aria-expanded
    const isExpanded = hamburger.classList.contains('active');
    hamburger.setAttribute('aria-expanded', isExpanded);
  });

  // Close menu when clicking on a link
  navLinks.forEach(link => {
    link.addEventListener('click', function() {
      hamburger.classList.remove('active');
      navMenu.classList.remove('active');
      hamburger.setAttribute('aria-expanded', 'false');
    });
  });

  // Close menu when clicking outside
  document.addEventListener('click', function(e) {
    if (!hamburger.contains(e.target) && !navMenu.contains(e.target)) {
      hamburger.classList.remove('active');
      navMenu.classList.remove('active');
      hamburger.setAttribute('aria-expanded', 'false');
    }
  });

  // Close menu on escape key
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape' && navMenu.classList.contains('active')) {
      hamburger.classList.remove('active');
      navMenu.classList.remove('active');
      hamburger.setAttribute('aria-expanded', 'false');
    }
  });
});
```

## SEO Implementation

### Essential Meta Tags Template
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- Primary Meta Tags -->
  <title>Page Title | Site Name</title>
  <meta name="title" content="Page Title | Site Name">
  <meta name="description" content="Compelling description 150-160 characters">
  <meta name="keywords" content="relevant, keywords, separated, by, commas">
  <meta name="author" content="Author Name">
  <meta name="robots" content="index, follow">
  
  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://yoursite.com/">
  <meta property="og:title" content="Page Title | Site Name">
  <meta property="og:description" content="Compelling description">
  <meta property="og:image" content="https://yoursite.com/og-image.jpg">
  <meta property="og:site_name" content="Site Name">
  
  <!-- Twitter -->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:url" content="https://yoursite.com/">
  <meta property="twitter:title" content="Page Title | Site Name">
  <meta property="twitter:description" content="Compelling description">
  <meta property="twitter:image" content="https://yoursite.com/twitter-image.jpg">
  
  <!-- Favicon -->
  <link rel="icon" type="image/x-icon" href="/favicon.ico">
  <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
  <link rel="manifest" href="/site.webmanifest">
  
  <!-- Canonical URL -->
  <link rel="canonical" href="https://yoursite.com/current-page">
  
  <!-- Preload Critical Resources -->
  <link rel="preload" href="/fonts/main-font.woff2" as="font" type="font/woff2" crossorigin>
  <link rel="preload" href="/css/critical.css" as="style">
  
  <!-- CSS -->
  <link rel="stylesheet" href="/css/main.css">
</head>
```

### Structured Data (Schema.org)
```html
<!-- Website Schema -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "Site Name",
  "url": "https://yoursite.com",
  "description": "Site description",
  "potentialAction": {
    "@type": "SearchAction",
    "target": "https://yoursite.com/search?q={search_term_string}",
    "query-input": "required name=search_term_string"
  }
}
</script>

<!-- Organization Schema (if business site) -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Company Name",
  "url": "https://yoursite.com",
  "logo": "https://yoursite.com/logo.png",
  "contactPoint": {
    "@type": "ContactPoint",
    "telephone": "+1-555-555-5555",
    "contactType": "customer service"
  },
  "sameAs": [
    "https://facebook.com/yourpage",
    "https://twitter.com/yourhandle",
    "https://linkedin.com/company/yourcompany"
  ]
}
</script>
```

## Performance Optimization

### Image Optimization
```html
<!-- Responsive Images with WebP -->
<picture>
  <source 
    srcset="image-320.webp 320w, 
            image-640.webp 640w, 
            image-1024.webp 1024w"
    sizes="(max-width: 320px) 280px,
           (max-width: 640px) 600px,
           1024px"
    type="image/webp">
  <img 
    src="image-640.jpg"
    srcset="image-320.jpg 320w, 
            image-640.jpg 640w, 
            image-1024.jpg 1024w"
    sizes="(max-width: 320px) 280px,
           (max-width: 640px) 600px,
           1024px"
    alt="Descriptive alt text"
    loading="lazy"
    decoding="async">
</picture>
```

### CSS Performance
```css
/* CSS Custom Properties for Performance */
:root {
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  --success-color: #28a745;
  --danger-color: #dc3545;
  --warning-color: #ffc107;
  --info-color: #17a2b8;
  
  --font-family-base: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
  --font-family-mono: 'Fira Code', 'Monaco', 'Consolas', monospace;
  
  --border-radius: 0.375rem;
  --box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
  --transition: all 0.15s ease-in-out;
}

/* Critical CSS - Above the fold styles */
/* Keep this minimal and inline in HTML */

/* Performance-focused selectors */
.btn {
  /* Avoid expensive properties during hover/transitions */
  will-change: transform, opacity;
  transform: translateZ(0); /* Hardware acceleration */
}

/* Efficient animations */
@keyframes fadeIn {
  from { opacity: 0; transform: translate3d(0, 20px, 0); }
  to { opacity: 1; transform: translate3d(0, 0, 0); }
}
```

### JavaScript Performance
```javascript
// Performance optimized JavaScript patterns

// Efficient DOM querying
const $ = (selector, context = document) => 
  context.querySelector(selector);
const $$ = (selector, context = document) => 
  [...context.querySelectorAll(selector)];

// Debounced scroll handler
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// Lazy loading implementation
const observerOptions = {
  root: null,
  rootMargin: '50px',
  threshold: 0.1
};

const imageObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
      img.classList.remove('lazy');
      imageObserver.unobserve(img);
    }
  });
}, observerOptions);

// Observe all lazy images
$$('img[data-src]').forEach(img => imageObserver.observe(img));
```

## Accessibility (ARIA) Standards

### Semantic HTML Structure
```html
<!-- Proper document structure -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Page Title</title>
</head>
<body>
  <!-- Skip to content link -->
  <a href="#main-content" class="skip-link">Skip to main content</a>
  
  <header role="banner">
    <nav role="navigation" aria-label="Main navigation">
      <ul>
        <li><a href="/" aria-current="page">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/contact">Contact</a></li>
      </ul>
    </nav>
  </header>
  
  <main id="main-content" role="main">
    <section aria-labelledby="hero-heading">
      <h1 id="hero-heading">Main Page Title</h1>
      <p>Content...</p>
    </section>
    
    <aside role="complementary" aria-label="Related information">
      <h2>Sidebar Title</h2>
    </aside>
  </main>
  
  <footer role="contentinfo">
    <p>&copy; 2024 Company Name</p>
  </footer>
</body>
</html>
```

### ARIA Patterns for Interactive Elements
```html
<!-- Modal Dialog -->
<div role="dialog" 
     aria-labelledby="modal-title" 
     aria-describedby="modal-description"
     aria-modal="true"
     tabindex="-1">
  <h2 id="modal-title">Modal Title</h2>
  <p id="modal-description">Modal description</p>
  <button aria-label="Close modal">×</button>
</div>

<!-- Dropdown Menu -->
<div class="dropdown">
  <button aria-haspopup="true" 
          aria-expanded="false" 
          aria-controls="dropdown-menu"
          id="dropdown-button">
    Menu
  </button>
  <ul role="menu" 
      id="dropdown-menu" 
      aria-labelledby="dropdown-button">
    <li role="menuitem"><a href="#">Item 1</a></li>
    <li role="menuitem"><a href="#">Item 2</a></li>
  </ul>
</div>

<!-- Form with Accessibility -->
<form>
  <div class="form-group">
    <label for="email">Email Address</label>
    <input type="email" 
           id="email" 
           name="email"
           required
           aria-describedby="email-help email-error"
           aria-invalid="false">
    <div id="email-help">We'll never share your email</div>
    <div id="email-error" role="alert" aria-live="polite"></div>
  </div>
  
  <fieldset>
    <legend>Preferred Contact Method</legend>
    <input type="radio" id="contact-email" name="contact" value="email">
    <label for="contact-email">Email</label>
    
    <input type="radio" id="contact-phone" name="contact" value="phone">
    <label for="contact-phone">Phone</label>
  </fieldset>
</form>
```

### Focus Management
```css
/* Focus indicators */
:focus {
  outline: 2px solid #007bff;
  outline-offset: 2px;
}

/* Skip link */
.skip-link {
  position: absolute;
  top: -40px;
  left: 6px;
  background: #007bff;
  color: white;
  padding: 8px;
  text-decoration: none;
  border-radius: 4px;
  z-index: 1000;
}

.skip-link:focus {
  top: 6px;
}

/* Reduced motion preference */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

## Testing Framework

### Testing Structure
```
tests/
├── unit/                 # Unit tests for components/functions
│   ├── components/
│   ├── utils/
│   └── setup.js
├── integration/          # Integration tests
│   ├── api/
│   ├── forms/
│   └── navigation/
├── e2e/                 # End-to-end tests
│   ├── user-flows/
│   ├── pages/
│   └── fixtures/
├── accessibility/       # A11y tests
│   ├── lighthouse/
│   ├── axe/
│   └── manual/
├── performance/         # Performance tests
│   ├── lighthouse/
│   ├── webpagetest/
│   └── core-web-vitals/
└── visual/             # Visual regression tests
    ├── screenshots/
    └── comparisons/
```

### Package.json Testing Scripts
```json
{
  "scripts": {
    "test": "npm run test:unit && npm run test:integration",
    "test:unit": "jest src/",
    "test:integration": "jest tests/integration/",
    "test:e2e": "playwright test",
    "test:a11y": "pa11y-ci --sitemap http://localhost:3000/sitemap.xml",
    "test:lighthouse": "lighthouse-ci autorun",
    "test:visual": "backstop test",
    "test:coverage": "jest --coverage",
    "test:watch": "jest --watch"
  }
}
```

### Essential Testing Dependencies
```json
{
  "devDependencies": {
    "@playwright/test": "^1.40.0",
    "@testing-library/dom": "^9.3.0",
    "@testing-library/jest-dom": "^6.1.0",
    "@testing-library/user-event": "^14.5.0",
    "axe-core": "^4.8.0",
    "jest": "^29.7.0",
    "jest-environment-jsdom": "^29.7.0",
    "lighthouse-ci": "^0.12.0",
    "pa11y-ci": "^3.1.0",
    "backstopjs": "^6.2.0"
  }
}
```

### Accessibility Testing with Axe
```javascript
// tests/accessibility/axe.test.js
import { injectAxe, checkA11y } from 'axe-playwright';

test.describe('Accessibility tests', () => {
  test.beforeEach(async ({ page }) => {
    await injectAxe(page);
  });

  test('Homepage accessibility', async ({ page }) => {
    await page.goto('/');
    await checkA11y(page, null, {
      detailedReport: true,
      detailedReportOptions: { html: true }
    });
  });

  test('Navigation accessibility', async ({ page }) => {
    await page.goto('/');
    
    // Test keyboard navigation
    await page.keyboard.press('Tab');
    await page.keyboard.press('Enter');
    
    await checkA11y(page);
  });
});
```

### Performance Testing
```javascript
// tests/performance/lighthouse.js
const lighthouse = require('lighthouse');
const chromeLauncher = require('chrome-launcher');

async function performanceTest(url) {
  const chrome = await chromeLauncher.launch({chromeFlags: ['--headless']});
  
  const options = {
    logLevel: 'info',
    output: 'html',
    onlyCategories: ['performance', 'accessibility', 'best-practices', 'seo'],
    port: chrome.port,
  };
  
  const runnerResult = await lighthouse(url, options);
  const reportHtml = runnerResult.report;
  const lhr = runnerResult.lhr;
  
  // Assert performance scores
  expect(lhr.categories.performance.score).toBeGreaterThan(0.9);
  expect(lhr.categories.accessibility.score).toBeGreaterThan(0.95);
  
  await chrome.kill();
}
```

## Deployment Strategies

### Static Site Deployment (Netlify)
```toml
# netlify.toml
[build]
  command = "npm run build"
  publish = "dist"

[build.environment]
  NODE_VERSION = "18"

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-XSS-Protection = "1; mode=block"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "strict-origin-when-cross-origin"

[[headers]]
  for = "/assets/*"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"

[[redirects]]
  from = "/old-page"
  to = "/new-page"
  status = 301
```

### Vercel Deployment
```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "headers": {
        "Cache-Control": "s-maxage=86400"
      },
      "dest": "/$1"
    }
  ]
}
```

### GitHub Actions CI/CD
```yaml
# .github/workflows/deploy.yml
name: Deploy Website

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run tests
      run: npm test
    
    - name: Run accessibility tests
      run: npm run test:a11y
    
    - name: Build
      run: npm run build
    
    - name: Deploy to Netlify
      uses: nwtgck/actions-netlify@v3.0
      with:
        publish-dir: './dist'
        production-branch: main
        github-token: ${{ secrets.GITHUB_TOKEN }}
        deploy-message: "Deploy from GitHub Actions"
      env:
        NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
        NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
```

## README Template

```markdown
# [Website Name]

> [Brief description of the website and its purpose]

## 🌟 Features

- ✅ Mobile-first responsive design
- ✅ WCAG 2.1 AA accessibility compliance  
- ✅ SEO optimized with structured data
- ✅ Performance optimized (90+ Lighthouse scores)
- ✅ Modern CSS Grid and Flexbox layouts
- ✅ Progressive enhancement
- ✅ Cross-browser compatibility

## 🚀 Quick Start

```bash
# Clone the repository
git clone [repository-url]
cd [website-name]

# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Run tests
npm test
```

## 🏗️ Project Structure

```
src/
├── css/           # Stylesheets organized by component
├── js/            # JavaScript modules
├── assets/        # Images, fonts, and static files
└── pages/         # HTML pages

tests/             # Test files
docs/              # Documentation
dist/              # Build output (generated)
```

## 🎨 Customization

### Colors
Update CSS custom properties in `src/css/base/variables.css`:

```css
:root {
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  /* ... */
}
```

### Typography
Font settings are in `src/css/base/typography.css`

### Layout
Responsive breakpoints and grid settings in `src/css/layout/`

## 🔧 Development

### Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm test` - Run all tests
- `npm run test:a11y` - Run accessibility tests
- `npm run test:performance` - Run performance tests
- `npm run lint` - Lint code
- `npm run format` - Format code with Prettier

### Browser Support

- Chrome/Edge 88+
- Firefox 85+
- Safari 14+
- Mobile Safari 14+
- Chrome Android 88+

## 🚀 Deployment

This site is deployed to [Netlify/Vercel/etc.] with automatic deployments from the `main` branch.

### Manual Deployment

```bash
npm run build
# Upload dist/ folder to your hosting provider
```

## 📈 Performance

Current Lighthouse scores:
- Performance: 95+
- Accessibility: 100
- Best Practices: 100
- SEO: 100

## ♿ Accessibility

This website follows WCAG 2.1 AA guidelines including:
- Semantic HTML structure
- Keyboard navigation support
- Screen reader compatibility
- Proper color contrast ratios
- Alternative text for images

## 📝 License

[Choose appropriate license]

## 🤝 Contributing

[Contribution guidelines if applicable]
```

## Quality Checklist

### Pre-Launch Checklist
- [ ] **Responsive Design**: Works on mobile, tablet, desktop
- [ ] **Cross-browser Testing**: Chrome, Firefox, Safari, Edge
- [ ] **Accessibility**: WCAG 2.1 AA compliance verified
- [ ] **Performance**: Lighthouse scores 90+ across all categories
- [ ] **SEO**: Meta tags, structured data, sitemap
- [ ] **Forms**: Validation, error handling, success states
- [ ] **Images**: Optimized, WebP format, alt text
- [ ] **Links**: All internal/external links work
- [ ] **Loading States**: For any async content
- [ ] **Error Pages**: 404, 500 custom pages
- [ ] **Security**: HTTPS, security headers, input validation
- [ ] **Analytics**: Google Analytics/other tracking setup
- [ ] **Favicon**: All sizes and formats included
- [ ] **Social Media**: Open Graph and Twitter Cards
- [ ] **Testing**: Unit, integration, e2e tests passing

### Accessibility Audit
- [ ] **Keyboard Navigation**: All interactive elements accessible
- [ ] **Screen Reader**: Test with NVDA/JAWS/VoiceOver
- [ ] **Color Contrast**: 4.5:1 minimum for normal text
- [ ] **Focus Indicators**: Visible focus styles
- [ ] **Semantic HTML**: Proper heading hierarchy
- [ ] **ARIA Labels**: For complex interactive elements
- [ ] **Alt Text**: Descriptive alternative text for images
- [ ] **Form Labels**: Associated with form controls
- [ ] **Skip Links**: For main content navigation

### Performance Optimization
- [ ] **Image Optimization**: WebP, proper sizing, lazy loading
- [ ] **CSS**: Minified, critical CSS inlined
- [ ] **JavaScript**: Minified, tree-shaken, code splitting
- [ ] **Fonts**: Optimized loading, fallbacks
- [ ] **Caching**: Proper cache headers
- [ ] **CDN**: Static assets served from CDN
- [ ] **Compression**: Gzip/Brotli enabled
- [ ] **Core Web Vitals**: LCP, FID, CLS optimized

## Common Issues & Solutions

### Responsive Design Issues
```css
/* Common responsive image problem */
img {
  max-width: 100%;
  height: auto;
  display: block;
}

/* Prevent horizontal scroll */
* {
  box-sizing: border-box;
}

/* Flexible containers */
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}
```

### JavaScript Performance
```javascript
// Efficient event delegation
document.addEventListener('click', function(e) {
  if (e.target.matches('.button')) {
    // Handle button click
  }
});

// Throttled scroll handling
const throttle = (func, limit) => {
  let inThrottle;
  return function() {
    const args = arguments;
    const context = this;
    if (!inThrottle) {
      func.apply(context, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  }
}
```

This addon provides comprehensive guidance for professional website development. Always prioritize accessibility, performance, and maintainable code structure. 