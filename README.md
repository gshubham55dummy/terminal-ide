# Node.js Express Sample Applications

This repository contains sample Node.js Express applications demonstrating best practices for building web applications with Express framework in both JavaScript and TypeScript.

## 📁 Project Structure

```
.
├── node-express-javascript/    # Express app using JavaScript
├── node-express-typescript/    # Express app using TypeScript
├── monitor_script.sh           # PR monitoring script
└── README.md                   # This file
```

## 🚀 Getting Started

### JavaScript Version

```bash
cd node-express-javascript
npm install
npm start
```

To format code with Prettier:
```bash
npm run format        # Format all files
npm run format:check  # Check formatting without making changes
```

The JavaScript application will be running at `http://localhost:3000`

### TypeScript Version

```bash
cd node-express-typescript
npm install
npm run compile
npm start
```

To format code with Prettier:
```bash
npm run format        # Format all files
npm run format:check  # Check formatting without making changes
```

The TypeScript application will be running at `http://localhost:3000`

## 🧪 Testing

Both projects include test suites:

```bash
# JavaScript tests
cd node-express-javascript
npm test

# TypeScript tests
cd node-express-typescript
npm run compiletests
npm test
```

## 🛠️ Technologies

- **Express 4.x** - Fast, unopinionated web framework for Node.js
- **Jade** - Template engine for Node.js
- **Mocha** - Testing framework
- **Gulp** - Task runner for build automation
- **Prettier** - Code formatter for consistent styling
- **TypeScript** - (TypeScript version only) Strongly typed JavaScript

## 📝 Features

- RESTful routing structure
- Template rendering with Jade
- Static file serving
- Error handling middleware
- Development and production configurations
- Automated testing with Mocha
- Build automation with Gulp

## 📄 License

See [LICENSE](LICENSE) file for details.
