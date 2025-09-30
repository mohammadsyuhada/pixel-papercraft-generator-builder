# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### Development Setup
- `npm install` - Install dependencies
- `nvm use` - Ensure correct Node version (>=18)

### Development Workflow
- `npm run dev` - Start development server (runs ReScript build then webpack serve on port 3000)
- `npm run res:watch` - Run ReScript compiler in watch mode (run in separate terminal)
- `npm run res:build` - Build ReScript files once
- `npm run build` - Production build (ReScript build + webpack with NODE_ENV=production)

### Specialized Tools
- `npm run make-block-textures` - Generate Minecraft block textures
- `npm run make-textures` - Generate texture files

## Architecture Overview

### Technology Stack
- **Language**: ReScript (functional language that compiles to JavaScript)
- **Frontend**: React with ReScript bindings
- **Build**: Webpack + ReScript compiler
- **Styling**: TailwindCSS with typography plugin
- **Canvas**: HTML5 Canvas for papercraft generation

### Core Architecture

#### Generator System (`src/builder/modules/`)
- `Generator.res` - Main generator API and public interface
- `Generator_Builder.res` - Core builder logic and model management
- `Generator_ScriptRunner.res` - Executes generator scripts
- `Generator_ResourceLoader.res` - Handles image/texture loading
- `Generator_CanvasFactory.res` & `Generator_CanvasWithContext.res` - Canvas management
- `Generator_ImageFactory.res` & `Generator_ImageWithCanvas.res` - Image processing
- `Generator_Page.res` & `Generator_PageSize.res` - Multi-page support
- `Generator_Texture.res` & `Generator_TextureFrame.res` - Texture handling

#### Views (`src/builder/views/`)
- `Generator_View.res` - Main generator UI component
- `Generator_Inputs.res` & `Generator_FormInput.res` - Input controls
- `Generator_Pages.res` - Page navigation
- `Generator_TexturePicker.res` - Texture selection interface
- `Generator_Buttons.res` & `Generator_ButtonStyles.res` - UI controls
- `Generator_Markdown.res` - Instruction rendering

#### Generator Registry (`src/generators/`)
- `Generators.res` - Central registry of all generators organized by category
- Individual generator directories follow pattern: `/generator-name/GeneratorName.res`
- Each generator exports a `generator` property of type `Generator.generatorDef`

### Generator Structure
Each generator must export:
```rescript
let generator: Generator.generatorDef = {
  id: "unique-id",
  name: "Display Name",
  images: array<Generator.imageDef>,  // Static images (backgrounds, folds)
  textures: array<Generator.textureDef>, // Texturable images with standardWidth/Height
  script: () => unit, // Main generator logic
  // Optional: history, thumbnail, video, instructions
}
```

### Key Conventions
- Images vs Textures: Images are static/fast, textures support transformation/scaling
- Generator scripts use `Generator.drawImage()` and `Generator.drawTexture()`
- Multi-page support via `Generator.usePage("Page Name")`
- User inputs via `Generator.defineBooleanInput()`, `Generator.defineSelectInput()`, etc.
- Asset loading requires `Generator.require("./path/to/asset")`

### Build Configuration
- ReScript config: `bsconfig.json` - CommonJS output, in-source compilation
- Webpack config: Entry point `src/index.bs.js`, serves static assets from `./dist` and `./static`
- TailwindCSS processes `src/**/*.bs.js` files
- Node/NPM version constraints in `package.json` engines

### Development Environment
- Development generators in `Generators.res` only appear when `NODE_ENV=development`
- ReScript compiler must run alongside webpack dev server
- Hot reloading available for both ReScript and webpack changes