# vscode-samples

This repository contains sample applications demonstrating Visual Studio Code development workflows, featuring both JavaScript and TypeScript implementations of Node.js/Express web applications.

## High Level Repository Structure

```
vscode-samples/
├── node-express-javascript/    # JavaScript implementation
├── node-express-typescript/    # TypeScript implementation
├── .vscode/                    # VS Code workspace settings
├── .claude/                    # Claude Code configuration
├── monitor_script.sh           # Monitoring utility script
└── README.md                   # Project documentation
```

## Very Important Projects

### 1. node-express-javascript

A Node.js Express application written in JavaScript.

**Key Features:**
- Express.js web server (v4.13.1)
- Jade templating engine
- Morgan HTTP request logger
- Cookie and body parsing middleware
- Gulp-based build system with live reload
- Mocha testing framework

**File Structure:**
- `app.js` - Main Express application configuration (routes/index.js:1)
- `routes/index.js` - Home page route handler (routes/index.js:17)
- `routes/users.js` - Users route handler (routes/users.js:5)
- `gulpfile.js` - Gulp task definitions for LESS compilation, testing, and browser-sync
- `tests/test.js` - Mocha test suite

**Running the Application:**
```bash
cd node-express-javascript
npm install
npm start           # Start the server
npm test            # Run tests
gulp                # Run with live reload (browser-sync on port 7000)
```

**Development Features:**
- Browser-sync for automatic browser refresh on file changes
- Nodemon for server auto-restart
- LESS compilation to CSS
- Proxy server running on port 7000

### 2. node-express-typescript

A Node.js Express application written in TypeScript with full type definitions.

**Key Features:**
- TypeScript implementation with full type definitions
- Same Express.js stack as JavaScript version
- TypeScript compiler integration
- Type-safe development with @types packages

**File Structure:**
- `src/app.ts` - Main Express application (TypeScript)
- `src/www.ts` - Server entry point
- `src/routes/index.ts` - Home page route handler
- `src/routes/users.ts` - Users route handler
- `tests/test.ts` - TypeScript test files

**Running the Application:**
```bash
cd node-express-typescript
npm install
npm run compile     # Compile TypeScript to JavaScript
npm start           # Start the compiled server
npm test            # Run tests
```

**Build Output:**
- Compiled JavaScript files are output to `./out/` directory
- Test files compile to `./tests/out/`

## Prerequisites

Both projects require:
- Node.js
- npm
- Gulp (install globally: `npm install -g gulp`)

## VS Code Integration

The repository includes VS Code workspace configuration:

**Settings (.vscode/settings.json):**
- Fira Code font with size 16
- Dark+ theme
- Word wrap enabled
- Minimap disabled
- Auto-save after delay
- Persistent terminal sessions

**Available Configurations:**
- `.vscode/launch.json` - Debug configurations for running/debugging applications
- `.vscode/tasks.json` - Task definitions for building and testing
- `.vscode/extensions.json` - Recommended VS Code extensions
- `.vscode/keybindings.info.json` - Keyboard shortcut information

## Debugging

Press `F5` in VS Code to:
1. Start the server under the debugger
2. Automatically open browser to `http://localhost:3000`
3. Set breakpoints and inspect variables

## Testing

Both projects use Mocha for testing:
```bash
npm test
```

## Build System

Gulp tasks available (JavaScript project):
- `gulp less` - Compile LESS files to CSS
- `gulp watch` - Watch for LESS file changes
- `gulp test` - Run Mocha tests
- `gulp nodemon` - Run server with auto-restart
- `gulp browser-sync` - Run with browser auto-reload
- `gulp` (default) - Runs browser-sync with all features

## License

MIT License - Copyright (c) Microsoft Corporation

See LICENSE file for full details.

## Additional Resources

- Main documentation: README.md
- Third-party notices: thirdpartynotices.txt
- Custom Claude Code commands: .claude/commands/

## Quick Start

**For JavaScript development:**
```bash
cd node-express-javascript
npm install
gulp
# Application available at http://localhost:7000
```

**For TypeScript development:**
```bash
cd node-express-typescript
npm install
npm run compile
npm start
# Application available at http://localhost:3000
```

## Dependencies

**Runtime:**
- express - Web framework
- jade - Template engine
- morgan - HTTP request logger
- body-parser - Request body parsing
- cookie-parser - Cookie parsing
- serve-favicon - Favicon middleware
- debug - Debugging utility

**Development:**
- gulp - Task runner
- gulp-less - LESS compilation
- gulp-mocha - Test runner
- gulp-nodemon - Server auto-restart
- browser-sync - Live reload
- mocha - Testing framework
- nodemon - File watcher
- typescript (TypeScript project only)

## Project Purpose

This repository serves as sample code demonstrating:
- VS Code workspace configuration
- Node.js/Express application structure
- TypeScript vs JavaScript development workflows
- Debugging configuration in VS Code
- Build automation with Gulp
- Testing with Mocha
- Live development with browser-sync and nodemon
