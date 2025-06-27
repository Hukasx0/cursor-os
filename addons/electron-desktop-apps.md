# Electron Desktop Applications Development Addon

## Core Architecture & Modern Stack

### Technology Stack
- **Electron**: Cross-platform desktop app framework
- **TypeScript**: Type-safe JavaScript development
- **React**: Modern UI library with hooks
- **shadcn/ui**: High-quality, accessible UI components
- **Tailwind CSS**: Utility-first CSS framework
- **Vite**: Fast build tool and dev server
- **ESLint + Prettier**: Code quality and formatting
- **Jest + Playwright**: Comprehensive testing suite

### Core Principles
1. **Security First**: Follow Electron security best practices
2. **Type Safety**: Comprehensive TypeScript coverage
3. **Modern UI/UX**: shadcn/ui components with Tailwind styling
4. **Performance**: Optimized builds and runtime efficiency
5. **Cross-Platform**: Native feel on Windows, macOS, and Linux
6. **Testability**: Unit, integration, and E2E testing
7. **Documentation**: Professional code documentation standards

## Project Structure Template

### GitHub-Like Repository Structure
```
electron-app/
├── README.md                    # Project documentation
├── package.json                 # Dependencies and scripts
├── package-lock.json           # Locked dependency versions
├── tsconfig.json               # TypeScript configuration
├── tsconfig.node.json          # Node.js TypeScript config
├── eslint.config.js            # ESLint configuration
├── prettier.config.js          # Prettier configuration
├── tailwind.config.js          # Tailwind CSS configuration
├── vite.config.ts              # Vite build configuration
├── electron.vite.config.ts     # Electron-specific Vite config
├── .gitignore                  # Git ignore patterns
├── .env.example               # Environment variables template
├── LICENSE                     # License file
├── CHANGELOG.md               # Version history
├── CONTRIBUTING.md            # Contribution guidelines
├── .github/                   # GitHub workflows and templates
│   ├── workflows/
│   │   ├── build.yml          # CI/CD build pipeline
│   │   ├── test.yml           # Automated testing
│   │   └── release.yml        # Release automation
│   ├── ISSUE_TEMPLATE/        # Issue templates
│   └── pull_request_template.md
├── electron/                  # Electron main process
│   ├── main.ts               # Main process entry point
│   ├── preload.ts            # Preload script for security
│   ├── menu.ts               # Application menu configuration
│   ├── protocols.ts          # Custom protocol handlers
│   ├── updater.ts            # Auto-updater implementation
│   ├── security.ts           # Security configurations
│   └── utils/                # Main process utilities
│       ├── window-manager.ts # Window management
│       ├── file-system.ts   # File operations
│       └── ipc-handlers.ts  # IPC message handlers
├── src/                      # Renderer process (React app)
│   ├── main.tsx             # React app entry point
│   ├── App.tsx              # Main App component
│   ├── vite-env.d.ts        # Vite type definitions
│   ├── components/          # React components
│   │   ├── ui/              # shadcn/ui components
│   │   │   ├── button.tsx
│   │   │   ├── input.tsx
│   │   │   ├── dialog.tsx
│   │   │   └── index.ts     # Barrel exports
│   │   ├── layout/          # Layout components
│   │   │   ├── Header.tsx
│   │   │   ├── Sidebar.tsx
│   │   │   └── Layout.tsx
│   │   ├── features/        # Feature-specific components
│   │   │   ├── settings/
│   │   │   ├── dashboard/
│   │   │   └── file-manager/
│   │   └── common/          # Shared components
│   │       ├── LoadingSpinner.tsx
│   │       └── ErrorBoundary.tsx
│   ├── hooks/               # Custom React hooks
│   │   ├── useElectron.ts   # Electron API hooks
│   │   ├── useSettings.ts   # Settings management
│   │   └── useTheme.ts      # Theme management
│   ├── services/            # Business logic services
│   │   ├── api.ts          # API communication
│   │   ├── storage.ts      # Data persistence
│   │   └── ipc.ts          # IPC communication
│   ├── store/              # State management
│   │   ├── index.ts        # Store configuration
│   │   ├── slices/         # Redux slices
│   │   └── types.ts        # Store type definitions
│   ├── styles/             # Global styles
│   │   ├── globals.css     # Global CSS with Tailwind
│   │   └── components.css  # Component-specific styles
│   ├── types/              # TypeScript type definitions
│   │   ├── electron.d.ts   # Electron API types
│   │   ├── api.ts          # API response types
│   │   └── global.ts       # Global type definitions
│   └── utils/              # Utility functions
│       ├── constants.ts    # Application constants
│       ├── helpers.ts      # Helper functions
│       └── validation.ts   # Input validation
├── tests/                  # Test files
│   ├── unit/              # Unit tests
│   │   ├── components/    # Component tests
│   │   ├── hooks/         # Hook tests
│   │   └── utils/         # Utility tests
│   ├── integration/       # Integration tests
│   │   ├── electron/      # Electron-specific tests
│   │   └── api/           # API integration tests
│   ├── e2e/              # End-to-end tests
│   │   ├── specs/        # Test specifications
│   │   └── fixtures/     # Test data
│   ├── setup/            # Test configuration
│   │   ├── jest.config.js
│   │   └── test-utils.tsx
│   └── __mocks__/        # Mock implementations
├── docs/                 # Documentation
│   ├── api/             # API documentation
│   ├── architecture.md  # Architecture overview
│   ├── development.md   # Development guide
│   ├── deployment.md    # Deployment instructions
│   └── security.md      # Security guidelines
├── scripts/             # Build and utility scripts
│   ├── build.js        # Production build script
│   ├── dev.js          # Development server
│   ├── test.js         # Test runner
│   └── release.js      # Release preparation
├── assets/             # Static assets
│   ├── icons/         # Application icons
│   │   ├── icon.png   # Main app icon
│   │   ├── icon.ico   # Windows icon
│   │   └── icon.icns  # macOS icon
│   ├── images/        # Application images
│   └── fonts/         # Custom fonts
└── dist/              # Build output (generated)
    ├── electron/      # Compiled Electron code
    └── renderer/      # Compiled React app
```

## Common Issues & Solutions

### Critical Configuration Fixes

**ALWAYS apply these fixes to prevent common Electron development issues:**

#### 1. Missing @electron-toolkit/utils Dependency
```bash
# This dependency is required but often missing in electron projects
npm install --save-dev @electron-toolkit/utils@^3.0.0
```

#### 2. TailwindCSS Configuration Import Fix
```typescript
// electron.vite.config.ts - Use imports instead of require()
import tailwindcss from 'tailwindcss'
import autoprefixer from 'autoprefixer'

export default defineConfig({
  renderer: {
    css: {
      postcss: {
        plugins: [
          tailwindcss,    // Use import, not require('tailwindcss')
          autoprefixer,   // Use import, not require('autoprefixer')
        ],
      }
    }
  }
})
```

#### 3. Package.json Entry Point Configuration
```json
{
  "main": "out/main/index.js",  // NOT "dist/electron/main.js"
  "scripts": {
    "start": "electron out/main/index.js"  // Match the main field
  }
}
```

#### 4. Electron Main Process Security Updates
```typescript
// electron/main.ts - Remove deprecated properties
const mainWindow = new BrowserWindow({
  webPreferences: {
    preload: join(__dirname, '../preload/index.js'),
    sandbox: false,
    contextIsolation: true,
    nodeIntegration: false,
    webSecurity: true
    // Remove: enableRemoteModule (deprecated)
  }
})

// Fix deprecated new-window handler
app.on('web-contents-created', (_, contents) => {
  contents.setWindowOpenHandler(() => {
    return { action: 'deny' }
  })
  // Remove: contents.on('new-window', ...) - deprecated
})
```

#### 5. HTML File Structure and CSP Configuration
```html
<!-- src/renderer/index.html - Correct placement and CSP -->
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: blob:;">

<!-- Script path must be relative to HTML location -->
<script type="module" src="./main.tsx"></script>
```

#### 6. Project Structure Requirements
```
project/
├── src/
│   ├── renderer/
│   │   ├── index.html     # HTML must be here for electron-vite
│   │   └── main.tsx       # Move main.tsx to renderer directory
│   ├── App.tsx
│   └── components/
├── electron/
│   ├── main.ts
│   └── preload.ts
└── electron.vite.config.ts
```

#### 7. Electron Vite Configuration Template
```typescript
import { resolve } from 'path'
import { defineConfig, externalizeDepsPlugin } from 'electron-vite'
import react from '@vitejs/plugin-react'
import tailwindcss from 'tailwindcss'
import autoprefixer from 'autoprefixer'

export default defineConfig({
  main: {
    plugins: [externalizeDepsPlugin()],
    build: {
      rollupOptions: {
        input: {
          index: resolve(__dirname, 'electron/main.ts')
        }
      }
    }
  },
  preload: {
    plugins: [externalizeDepsPlugin()],
    build: {
      rollupOptions: {
        input: {
          index: resolve(__dirname, 'electron/preload.ts')
        }
      }
    }
  },
  renderer: {
    resolve: {
      alias: {
        '@': resolve('src')
      }
    },
    plugins: [react()],
    // Do NOT specify build.rollupOptions.input for renderer
    // Let electron-vite handle HTML location automatically
    css: {
      postcss: {
        plugins: [
          tailwindcss,     // Import, not require()
          autoprefixer,    // Import, not require()
        ],
      }
    }
  }
})
```

#### 8. Import Path Fixes for Renderer Structure
```typescript
// src/renderer/main.tsx - Update import paths
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from '../App'           // Go up one level to src/
import '../styles/globals.css'     // Go up one level to src/styles/
```

#### 9. Dependency Cleanup Strategy
```typescript
// Only include dependencies actually used in code
// Remove unused packages to prevent conflicts:
const unnecessaryPackages = [
  '@radix-ui/react-button',  // This package doesn't exist
  'react-color',             // If not using color pickers  
  'class-variance-authority', // If not using CVA
  'tailwind-merge',          // If not using tw-merge
  'husky',                   // If no git hooks needed
  'lint-staged'              // If no git hooks needed
]
```

## Dependencies & Configuration

### Core Package.json Configuration
```json
{
  "name": "electron-app",
  "version": "1.0.0",
  "description": "Modern Electron desktop application",
  "main": "out/main/index.js",
  "homepage": "./",
  "scripts": {
    "dev": "electron-vite dev",
    "dev:electron": "electron-vite dev --watch",
    "build": "electron-vite build",
    "build:win": "electron-vite build && electron-builder --win",
    "build:mac": "electron-vite build && electron-builder --mac", 
    "build:linux": "electron-vite build && electron-builder --linux",
    "preview": "electron-vite preview",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:e2e": "playwright test",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "lint:fix": "eslint . --ext ts,tsx --fix",
    "format": "prettier --write \"**/*.{ts,tsx,js,jsx,json,md}\"",
    "typecheck": "tsc --noEmit",
    "start": "electron out/main/index.js"
  },
  "keywords": ["electron", "react", "typescript", "desktop"],
  "author": "Your Name <your.email@example.com>",
  "license": "MIT",
  "devDependencies": {
    "@electron-toolkit/utils": "^3.0.0",
    "@electron/rebuild": "^3.4.0",
    "@types/node": "^20.10.0",
    "@types/react": "^18.2.43",
    "@types/react-dom": "^18.2.17",
    "@typescript-eslint/eslint-plugin": "^6.14.0",
    "@typescript-eslint/parser": "^6.14.0",
    "@vitejs/plugin-react": "^4.2.1",
    "autoprefixer": "^10.4.16",
    "electron": "^28.0.0",
    "electron-builder": "^24.9.1",
    "electron-vite": "^2.0.0",
    "eslint": "^8.55.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.5",
    "jest": "^29.7.0",
    "postcss": "^8.4.32",
    "prettier": "^3.1.1",
    "tailwindcss": "^3.3.6",
    "typescript": "^5.3.3",
    "vite": "^5.0.8"
  },
  "dependencies": {
    "@radix-ui/react-alert-dialog": "^1.0.5",
    "@radix-ui/react-dialog": "^1.0.5",
    "@radix-ui/react-dropdown-menu": "^2.0.6",
    "@radix-ui/react-label": "^2.0.2",
    "@radix-ui/react-slot": "^1.0.2",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.0.0",
    "electron-updater": "^6.1.7",
    "lucide-react": "^0.303.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "tailwind-merge": "^2.2.0",
    "tailwindcss-animate": "^1.0.7",
    "zustand": "^4.4.7"
  }
}
```

## Security Architecture

### Electron Security Best Practices
```typescript
/**
 * Security configuration for Electron application
 * 
 * Implements comprehensive security measures following OWASP guidelines
 * and Electron security best practices to prevent XSS, code injection,
 * and unauthorized access to system resources.
 * 
 * Security Layers:
 * 1. Context Isolation: Separates main world from isolated world
 * 2. Disabled Node Integration: Prevents renderer access to Node.js APIs
 * 3. Sandbox Mode: Runs renderer in sandboxed environment
 * 4. Content Security Policy: Prevents script injection attacks
 * 5. Secure Preload Scripts: Safe IPC communication bridge
 * 
 * @module SecurityConfig
 * @version 1.0.0
 * @author Security Team
 */

import { BrowserWindow, session, app } from 'electron'
import path from 'path'

/**
 * Security configuration interface for browser windows
 */
interface SecurityConfig {
  /** Enable sandbox mode for renderer process */
  sandbox: boolean
  /** Disable Node.js integration in renderer */
  nodeIntegration: boolean
  /** Enable context isolation for security */
  contextIsolation: boolean
  /** Path to secure preload script */
  preload: string
  /** Disable experimental features */
  experimentalFeatures: boolean
}

/**
 * Create secure browser window with comprehensive security settings
 * 
 * @param options - Window creation options
 * @returns Configured BrowserWindow instance with security hardening
 */
export function createSecureWindow(options: Electron.BrowserWindowConstructorOptions): BrowserWindow {
  // Define security configuration
  const securityConfig: SecurityConfig = {
    sandbox: true,                    // Enable sandbox for renderer isolation
    nodeIntegration: false,          // Disable Node.js in renderer for security
    contextIsolation: true,          // Isolate context to prevent prototype pollution
    preload: path.join(__dirname, 'preload.js'), // Secure IPC bridge
    experimentalFeatures: false      // Disable experimental web platform features
  }

  // Create window with security-first configuration
  const window = new BrowserWindow({
    ...options,
    webPreferences: {
      ...options.webPreferences,
      ...securityConfig,
      // Additional security measures
      allowRunningInsecureContent: false,  // Block mixed content
      webSecurity: true,                    // Enable web security (default: true)
      nodeIntegrationInWorker: false,      // Disable Node.js in web workers
      nodeIntegrationInSubFrames: false,   // Disable Node.js in subframes
      // Note: enableRemoteModule is deprecated and should not be used
      backgroundThrottling: false          // Prevent background throttling
    }
  })

  // Configure Content Security Policy
  setupContentSecurityPolicy(window)
  
  // Setup session security
  configureSessionSecurity(window.webContents.session)

  // Fix deprecated new-window handler
  window.webContents.setWindowOpenHandler(() => {
    return { action: 'deny' }
  })

  return window
}

/**
 * Configure Content Security Policy for enhanced security
 * 
 * CSP prevents XSS attacks by controlling which resources can be loaded
 * and executed by the web page. This configuration allows only trusted
 * sources and blocks inline scripts and eval().
 * 
 * @param window - Browser window to configure CSP for
 */
function setupContentSecurityPolicy(window: BrowserWindow): void {
  // Define strict CSP policy
  const cspPolicy = [
    "default-src 'self'",                    // Only load resources from same origin
    "script-src 'self' 'unsafe-inline'",    // Allow scripts from same origin only
    "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com", // Allow styles and Google Fonts
    "font-src 'self' https://fonts.gstatic.com", // Allow fonts from Google Fonts
    "img-src 'self' data: https:",          // Allow images from self, data URLs, and HTTPS
    "connect-src 'self' https:",            // Allow connections to HTTPS endpoints
    "media-src 'self'",                     // Allow media from same origin
    "object-src 'none'",                    // Block object, embed, and applet elements
    "base-uri 'self'",                      // Restrict base tag URLs
    "form-action 'self'",                   // Restrict form submissions
    "frame-ancestors 'none'"                // Prevent embedding in frames
  ].join('; ')

  // Apply CSP policy to all page loads
  window.webContents.session.webRequest.onHeadersReceived((details, callback) => {
    callback({
      responseHeaders: {
        ...details.responseHeaders,
        'Content-Security-Policy': [cspPolicy]
      }
    })
  })
}
```

## IPC Communication Architecture

### Type-Safe IPC Implementation
```typescript
/**
 * Inter-Process Communication (IPC) system for secure data exchange
 * 
 * Provides type-safe communication between main and renderer processes
 * using Electron's IPC mechanism. Implements request-response patterns
 * with proper error handling and timeout management.
 * 
 * Architecture:
 * - Main Process: Handles system operations and business logic
 * - Renderer Process: UI layer that requests data/operations
 * - Preload Script: Secure bridge with context isolation
 * 
 * @module IPCSystem
 * @version 1.0.0
 */

// =============================================================================
// IPC TYPE DEFINITIONS
// =============================================================================

/**
 * Base interface for all IPC messages
 */
interface IPCMessage {
  /** Unique message identifier for response correlation */
  id: string
  /** Timestamp when message was created */
  timestamp: number
}

/**
 * IPC request message structure
 */
interface IPCRequest<T = any> extends IPCMessage {
  /** Type of operation being requested */
  type: string
  /** Request payload data */
  payload: T
}

/**
 * IPC response message structure
 */
interface IPCResponse<T = any> extends IPCMessage {
  /** Whether the operation was successful */
  success: boolean
  /** Response data (if successful) */
  data?: T
  /** Error information (if failed) */
  error?: {
    code: string
    message: string
    details?: any
  }
}

/**
 * Available IPC channel definitions with type safety
 */
interface IPCChannels {
  // File system operations
  'file:read': {
    request: { path: string; encoding?: string }
    response: { content: string; size: number; lastModified: Date }
  }
  'file:write': {
    request: { path: string; content: string; encoding?: string }
    response: { bytesWritten: number; path: string }
  }
  'file:delete': {
    request: { path: string }
    response: { deleted: boolean; path: string }
  }
  
  // Application settings
  'settings:get': {
    request: { key?: string }
    response: Record<string, any>
  }
  'settings:set': {
    request: { key: string; value: any }
    response: { updated: boolean; key: string }
  }
  
  // System information
  'system:info': {
    request: {}
    response: {
      platform: string
      arch: string
      version: string
      memory: { total: number; free: number }
    }
  }
  
  // Window management
  'window:minimize': { request: {}; response: { minimized: boolean } }
  'window:maximize': { request: {}; response: { maximized: boolean } }
  'window:close': { request: {}; response: { closed: boolean } }
}

// =============================================================================
// PRELOAD SCRIPT - SECURE IPC BRIDGE
// =============================================================================

/**
 * Preload script that creates secure IPC bridge
 * 
 * This script runs in the renderer process with Node.js access but in an
 * isolated context. It exposes only specific, safe APIs to the renderer
 * through the contextBridge, preventing direct access to Node.js APIs.
 * 
 * @file preload.ts
 */
import { contextBridge, ipcRenderer } from 'electron'

/**
 * Electron API interface exposed to renderer process
 */
interface ElectronAPI {
  /** Send IPC request and wait for response */
  invoke: <K extends keyof IPCChannels>(
    channel: K,
    data: IPCChannels[K]['request']
  ) => Promise<IPCChannels[K]['response']>
  
  /** Send one-way IPC message (no response expected) */
  send: <K extends keyof IPCChannels>(
    channel: K,
    data: IPCChannels[K]['request']
  ) => void
  
  /** Listen for IPC events from main process */
  on: (channel: string, callback: (data: any) => void) => void
  
  /** Remove IPC event listener */
  off: (channel: string, callback: (data: any) => void) => void
  
  /** Get application version */
  getVersion: () => string
  
  /** Check if running in development mode */
  isDev: () => boolean
}

/**
 * Safe IPC invoke wrapper with timeout and error handling
 * 
 * @param channel - IPC channel name
 * @param data - Request data
 * @param timeout - Request timeout in milliseconds
 * @returns Promise resolving to response data
 */
async function safeInvoke<K extends keyof IPCChannels>(
  channel: K,
  data: IPCChannels[K]['request'],
  timeout: number = 5000
): Promise<IPCChannels[K]['response']> {
  return new Promise((resolve, reject) => {
    // Set timeout for the request
    const timeoutId = setTimeout(() => {
      reject(new Error(`IPC request timeout: ${channel}`))
    }, timeout)

    // Send request and handle response
    ipcRenderer.invoke(channel, data)
      .then((response: IPCChannels[K]['response']) => {
        clearTimeout(timeoutId)
        resolve(response)
      })
      .catch((error: Error) => {
        clearTimeout(timeoutId)
        reject(error)
      })
  })
}

// Expose secure API to renderer process
const electronAPI: ElectronAPI = {
  invoke: safeInvoke,
  
  send: (channel, data) => {
    ipcRenderer.send(channel, data)
  },
  
  on: (channel, callback) => {
    ipcRenderer.on(channel, (_, data) => callback(data))
  },
  
  off: (channel, callback) => {
    ipcRenderer.removeListener(channel, callback)
  },
  
  getVersion: () => process.env.APP_VERSION || '1.0.0',
  
  isDev: () => process.env.NODE_ENV === 'development'
}

// Bridge API to renderer with context isolation
contextBridge.exposeInMainWorld('electronAPI', electronAPI)

// TypeScript declaration for global API
declare global {
  interface Window {
    electronAPI: ElectronAPI
  }
}
```

## Component Architecture with shadcn/ui

### Modern React Components with TypeScript
```tsx
/**
 * Main Application Component with shadcn/ui Integration
 * 
 * Root component that orchestrates the entire application UI using
 * shadcn/ui components for consistent design and Tailwind CSS for styling.
 * Implements modern React patterns with hooks and context for state management.
 * 
 * Features:
 * - Responsive layout with sidebar navigation
 * - Theme switching (light/dark mode)
 * - Global error boundary and loading states
 * - Keyboard shortcuts and accessibility
 * - Real-time system status updates
 * 
 * @component App
 * @version 1.0.0
 */

import React, { useState, useEffect, Suspense } from 'react'
import { cn } from '@/lib/utils'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { 
  Dialog, 
  DialogContent, 
  DialogDescription, 
  DialogHeader, 
  DialogTitle 
} from '@/components/ui/dialog'
import { useToast } from '@/components/ui/use-toast'
import { ThemeProvider, useTheme } from '@/hooks/useTheme'
import { ElectronProvider, useElectron } from '@/hooks/useElectron'
import { Loader2, Settings, FileText, Home, Info } from 'lucide-react'

/**
 * Application state interface
 */
interface AppState {
  /** Current active view/page */
  currentView: 'home' | 'files' | 'settings' | 'about'
  /** Whether settings dialog is open */
  isSettingsOpen: boolean
  /** Application loading state */
  isLoading: boolean
  /** System information data */
  systemInfo: SystemInfo | null
}

/**
 * System information structure
 */
interface SystemInfo {
  platform: string
  architecture: string
  version: string
  memory: {
    total: number
    free: number
  }
}

/**
 * Main application component with full feature implementation
 * 
 * @returns JSX element representing the entire application
 */
export default function App(): JSX.Element {
  // =============================================================================
  // STATE MANAGEMENT
  // =============================================================================
  
  const [appState, setAppState] = useState<AppState>({
    currentView: 'home',
    isSettingsOpen: false,
    isLoading: true,
    systemInfo: null
  })
  
  // Custom hooks for functionality
  const { theme, toggleTheme } = useTheme()
  const { electronAPI } = useElectron()
  const { toast } = useToast()

  // =============================================================================
  // INITIALIZATION AND EFFECTS
  // =============================================================================
  
  /**
   * Initialize application and load system information
   * 
   * Fetches system data on component mount and sets up error handling
   * for the initial application state. Includes retry logic for failed
   * requests and proper error reporting to the user.
   */
  useEffect(() => {
    const initializeApp = async (): Promise<void> => {
      try {
        // Show loading state during initialization
        setAppState(prev => ({ ...prev, isLoading: true }))
        
        // Fetch system information from main process
        const systemData = await electronAPI.invoke('system:info', {})
        
        // Update state with fetched data
        setAppState(prev => ({
          ...prev,
          systemInfo: systemData,
          isLoading: false
        }))
        
        // Show success notification
        toast({
          title: "Application Ready",
          description: "System information loaded successfully",
          duration: 3000
        })
        
      } catch (error) {
        // Handle initialization errors gracefully
        console.error('App initialization failed:', error)
        
        setAppState(prev => ({ ...prev, isLoading: false }))
        
        toast({
          title: "Initialization Error", 
          description: "Failed to load system information",
          variant: "destructive",
          duration: 5000
        })
      }
    }

    initializeApp()
  }, [electronAPI, toast])

  /**
   * Setup keyboard shortcuts for better user experience
   * 
   * Implements global keyboard shortcuts for common actions:
   * - Ctrl/Cmd + , : Open settings
   * - Ctrl/Cmd + T : Toggle theme
   * - Ctrl/Cmd + R : Refresh application
   */
  useEffect(() => {
    const handleKeyboard = (event: KeyboardEvent): void => {
      const isCtrlOrCmd = event.ctrlKey || event.metaKey
      
      if (!isCtrlOrCmd) return
      
      switch (event.key) {
        case ',':
          // Open settings dialog
          event.preventDefault()
          setAppState(prev => ({ ...prev, isSettingsOpen: true }))
          break
          
        case 't':
          // Toggle theme
          event.preventDefault()
          toggleTheme()
          break
          
        case 'r':
          // Refresh application data
          event.preventDefault()
          window.location.reload()
          break
      }
    }

    // Add event listener for keyboard shortcuts
    window.addEventListener('keydown', handleKeyboard)
    
    // Cleanup listener on unmount
    return () => window.removeEventListener('keydown', handleKeyboard)
  }, [toggleTheme])

  // =============================================================================
  // EVENT HANDLERS
  // =============================================================================
  
  /**
   * Handle navigation between different views
   * 
   * @param view - Target view to navigate to
   */
  const handleNavigation = (view: AppState['currentView']): void => {
    setAppState(prev => ({ ...prev, currentView: view }))
    
    // Announce navigation for screen readers
    const announcement = `Navigated to ${view} section`
    const ariaLive = document.createElement('div')
    ariaLive.setAttribute('aria-live', 'polite')
    ariaLive.setAttribute('aria-atomic', 'true')
    ariaLive.className = 'sr-only'
    ariaLive.textContent = announcement
    document.body.appendChild(ariaLive)
    
    // Remove announcement after screen readers process it
    setTimeout(() => document.body.removeChild(ariaLive), 1000)
  }

  /**
   * Handle settings dialog close with state cleanup
   */
  const handleSettingsClose = (): void => {
    setAppState(prev => ({ ...prev, isSettingsOpen: false }))
  }

  /**
   * Handle file operations with comprehensive error handling
   * 
   * @param action - Type of file operation to perform
   * @param path - File path for the operation
   */
  const handleFileOperation = async (
    action: 'read' | 'write' | 'delete',
    path: string
  ): Promise<void> => {
    try {
      switch (action) {
        case 'read':
          const fileData = await electronAPI.invoke('file:read', { path })
          toast({
            title: "File Read Successfully",
            description: `Read ${fileData.size} bytes from ${path}`
          })
          break
          
        case 'delete':
          await electronAPI.invoke('file:delete', { path })
          toast({
            title: "File Deleted",
            description: `Successfully deleted ${path}`
          })
          break
      }
    } catch (error) {
      toast({
        title: "File Operation Failed",
        description: `Could not ${action} file: ${path}`,
        variant: "destructive"
      })
    }
  }

  // =============================================================================
  // RENDER FUNCTIONS
  // =============================================================================
  
  /**
   * Render loading screen with spinner and progress indication
   */
  const renderLoadingScreen = (): JSX.Element => (
    <div className="flex items-center justify-center min-h-screen bg-background">
      <div className="text-center space-y-4">
        <Loader2 className="h-8 w-8 animate-spin mx-auto text-primary" />
        <div className="space-y-2">
          <h2 className="text-lg font-semibold text-foreground">
            Loading Application
          </h2>
          <p className="text-sm text-muted-foreground">
            Initializing system components...
          </p>
        </div>
      </div>
    </div>
  )

  /**
   * Render main application sidebar with navigation
   */
  const renderSidebar = (): JSX.Element => (
    <aside className="w-64 bg-card border-r border-border flex flex-col">
      <div className="p-4 border-b border-border">
        <h1 className="text-xl font-bold text-foreground">Electron App</h1>
        <p className="text-sm text-muted-foreground">
          v{electronAPI.getVersion()}
        </p>
      </div>
      
      <nav className="flex-1 p-4 space-y-2">
        {[
          { id: 'home', label: 'Home', icon: Home },
          { id: 'files', label: 'Files', icon: FileText },
          { id: 'settings', label: 'Settings', icon: Settings },
          { id: 'about', label: 'About', icon: Info }
        ].map(({ id, label, icon: Icon }) => (
          <Button
            key={id}
            variant={appState.currentView === id ? 'default' : 'ghost'}
            className={cn(
              "w-full justify-start gap-2",
              appState.currentView === id && "bg-primary text-primary-foreground"
            )}
            onClick={() => handleNavigation(id as AppState['currentView'])}
          >
            <Icon className="h-4 w-4" />
            {label}
          </Button>
        ))}
      </nav>
      
      <div className="p-4 border-t border-border">
        <Button
          variant="outline"
          size="sm"
          onClick={toggleTheme}
          className="w-full"
        >
          Toggle {theme === 'light' ? 'Dark' : 'Light'} Mode
        </Button>
      </div>
    </aside>
  )

  // =============================================================================
  // MAIN RENDER
  // =============================================================================
  
  // Show loading screen during initialization
  if (appState.isLoading) {
    return renderLoadingScreen()
  }

  return (
    <ThemeProvider>
      <ElectronProvider>
        <div className="flex h-screen bg-background text-foreground">
          {renderSidebar()}
          
          <main className="flex-1 flex flex-col overflow-hidden">
            <header className="bg-card border-b border-border p-4">
              <h2 className="text-lg font-semibold capitalize">
                {appState.currentView}
              </h2>
            </header>
            
            <div className="flex-1 p-6 overflow-auto">
              <Suspense fallback={<Loader2 className="h-6 w-6 animate-spin" />}>
                {/* Content will be rendered based on currentView */}
                <div className="space-y-4">
                  <p className="text-muted-foreground">
                    Welcome to your Electron application!
                  </p>
                  
                  {appState.systemInfo && (
                    <div className="bg-card p-4 rounded-lg border border-border">
                      <h3 className="font-semibold mb-2">System Information</h3>
                      <dl className="grid grid-cols-2 gap-2 text-sm">
                        <dt className="text-muted-foreground">Platform:</dt>
                        <dd>{appState.systemInfo.platform}</dd>
                        <dt className="text-muted-foreground">Architecture:</dt>
                        <dd>{appState.systemInfo.architecture}</dd>
                        <dt className="text-muted-foreground">Memory:</dt>
                        <dd>
                          {Math.round(appState.systemInfo.memory.free / 1024 / 1024)} MB free
                        </dd>
                      </dl>
                    </div>
                  )}
                </div>
              </Suspense>
            </div>
          </main>
          
          {/* Settings Dialog */}
          <Dialog open={appState.isSettingsOpen} onOpenChange={handleSettingsClose}>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Application Settings</DialogTitle>
                <DialogDescription>
                  Configure your application preferences
                </DialogDescription>
              </DialogHeader>
              
              <div className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="theme-setting">Theme</Label>
                  <Button
                    id="theme-setting"
                    variant="outline"
                    onClick={toggleTheme}
                    className="w-full justify-start"
                  >
                    Current: {theme === 'light' ? 'Light' : 'Dark'} Mode
                  </Button>
                </div>
              </div>
            </DialogContent>
          </Dialog>
        </div>
      </ElectronProvider>
    </ThemeProvider>
  )
}
```

## Testing Strategy & Implementation

### Comprehensive Testing Suite
```typescript
/**
 * Jest Configuration for Multi-Environment Testing
 * 
 * @file jest.config.js
 */
module.exports = {
  projects: [
    {
      displayName: 'main',
      testEnvironment: 'node',
      testMatch: ['<rootDir>/tests/unit/electron/**/*.test.ts'],
      transform: { '^.+\\.tsx?$': 'ts-jest' },
      setupFilesAfterEnv: ['<rootDir>/tests/setup/main.setup.ts']
    },
    {
      displayName: 'renderer',
      testEnvironment: 'jsdom', 
      testMatch: ['<rootDir>/tests/unit/components/**/*.test.tsx'],
      transform: { '^.+\\.tsx?$': 'ts-jest' },
      setupFilesAfterEnv: ['<rootDir>/tests/setup/renderer.setup.ts'],
      moduleNameMapping: { '@/(.*)': '<rootDir>/src/$1' }
    }
  ],
  collectCoverage: true,
  coverageThreshold: {
    global: { branches: 80, functions: 80, lines: 80, statements: 80 }
  }
}

/**
 * Component Testing Example
 * 
 * @file tests/unit/components/App.test.tsx
 */
import React from 'react'
import { render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { vi } from 'vitest'
import App from '@/App'

const mockElectronAPI = {
  invoke: vi.fn(),
  getVersion: vi.fn(() => '1.0.0'),
  isDev: vi.fn(() => false)
}

Object.defineProperty(window, 'electronAPI', {
  value: mockElectronAPI,
  writable: true
})

describe('App Component', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    mockElectronAPI.invoke.mockResolvedValue({
      platform: 'darwin',
      architecture: 'x64',
      version: '14.0.0',
      memory: { total: 8000000000, free: 4000000000 }
    })
  })

  it('should initialize and load system information', async () => {
    render(<App />)
    
    await waitFor(() => {
      expect(screen.getByText('Electron App')).toBeInTheDocument()
    })
    
    expect(mockElectronAPI.invoke).toHaveBeenCalledWith('system:info', {})
    expect(screen.getByText('System Information')).toBeInTheDocument()
  })

  it('should handle navigation correctly', async () => {
    const user = userEvent.setup()
    render(<App />)
    
    await waitFor(() => {
      expect(screen.getByText('Files')).toBeInTheDocument()
    })
    
    await user.click(screen.getByRole('button', { name: /files/i }))
    expect(screen.getByText('files')).toBeInTheDocument()
  })
})
```

## Build & Deployment Configuration

### Production Build Setup
```typescript
/**
 * Electron Builder Configuration
 * 
 * @file electron-builder.config.js
 */
module.exports = {
  appId: 'com.yourcompany.electronapp',
  productName: 'Electron App',
  directories: { output: 'release', app: 'dist' },
  
  files: ['dist/**/*', 'package.json'],
  
  win: {
    target: [{ target: 'nsis', arch: ['x64', 'ia32'] }],
    icon: 'assets/icons/icon.ico',
    certificateFile: process.env.WIN_CSC_LINK,
    certificatePassword: process.env.WIN_CSC_KEY_PASSWORD
  },
  
  mac: {
    target: [{ target: 'dmg', arch: ['x64', 'arm64'] }],
    icon: 'assets/icons/icon.icns',
    identity: process.env.MAC_IDENTITY,
    hardenedRuntime: true,
    entitlements: 'scripts/entitlements.mac.plist'
  },
  
  linux: {
    target: [
      { target: 'AppImage', arch: ['x64'] },
      { target: 'deb', arch: ['x64'] }
    ],
    icon: 'assets/icons/icon.png',
    category: 'Office'
  },
  
  publish: [{
    provider: 'github',
    owner: 'your-username',
    repo: 'electron-app'
  }],
  
  afterSign: async (context) => {
    if (process.platform === 'darwin') {
      const { notarize } = require('electron-notarize')
      await notarize({
        appBundleId: context.packager.appInfo.id,
        appPath: context.appOutDir,
        appleId: process.env.APPLE_ID,
        appleIdPassword: process.env.APPLE_ID_PASSWORD
      })
    }
  }
}
```

## Code Documentation Standards

### Professional Documentation Requirements

#### File Headers
```typescript
/**
 * Application Name: Modern Electron Desktop App
 * File: main.ts
 * Description: Main process entry point with security hardening
 * Author: Development Team
 * Created: 2024-01-15
 * Version: 1.2.0
 * 
 * Security Features:
 * - Context isolation enabled
 * - Node integration disabled
 * - Sandbox mode active
 * - CSP headers enforced
 * 
 * Cross-platform Support:
 * - Windows 10/11 (tested)
 * - macOS 12+ (tested)  
 * - Ubuntu 20.04+ (tested)
 */
```

#### Function Documentation
```typescript
/**
 * Create secure browser window with comprehensive security settings
 * 
 * @param options - Window creation options
 * @returns Promise<BrowserWindow> - Configured secure window
 * 
 * @example
 * ```typescript
 * const mainWindow = await createSecureWindow({
 *   width: 1200,
 *   height: 800,
 *   title: 'My App'
 * })
 * ```
 * 
 * @throws {Error} When window creation fails
 * @since 1.0.0
 */
async function createSecureWindow(
  options: Electron.BrowserWindowConstructorOptions
): Promise<BrowserWindow> {
  // Implementation with detailed comments
}
```

## Development Best Practices

### Quality Standards

1. **TypeScript Strict Mode**: Enable all strict type checking
2. **ESLint Configuration**: Enforce code quality rules
3. **Prettier Integration**: Consistent code formatting
4. **Husky Git Hooks**: Pre-commit quality checks
5. **Comprehensive Testing**: Unit, integration, and E2E tests
6. **Security First**: Follow Electron security best practices
7. **Performance Monitoring**: Track startup time and memory usage
8. **Cross-Platform Testing**: Verify on all target platforms

### Deployment Strategy

#### When creating Electron applications:

1. **Always place in `documents/projects/project-name/`** (not scripts/)
2. **Apply all Common Issues & Solutions fixes** before starting development
3. **Use correct project structure** with src/renderer/ for HTML and main.tsx
4. **Configure package.json correctly** with "main": "out/main/index.js"
5. **Add @electron-toolkit/utils dependency** to devDependencies
6. **Use import statements** for TailwindCSS and autoprefixer in config
7. **Remove deprecated Electron APIs** (enableRemoteModule, new-window events)
8. **Configure CSP properly** to allow Google Fonts if needed
9. **Clean up unused dependencies** to prevent conflicts
10. **Test on all target platforms** before release

### AI Development Instructions

When creating Electron applications, ALWAYS:

1. **Check and apply all fixes from "Common Issues & Solutions" section**
2. **Use the corrected package.json template** with proper entry points
3. **Place HTML in src/renderer/index.html** with correct script paths  
4. **Import TailwindCSS/autoprefixer** instead of using require()
5. **Include @electron-toolkit/utils** in devDependencies
6. **Remove deprecated Electron APIs** and use modern replacements
7. **Configure CSP headers** to allow necessary external resources
8. **Test build process** before declaring project complete

This addon ensures professional, secure, and maintainable Electron applications with modern TypeScript, React, shadcn/ui components, comprehensive testing, and production-ready deployment configuration.