# Cursor Operating System

## 🚀 Overview

**Cursor OS** is an experimental project that transforms the Cursor AI code editor into a fully functional operating system built entirely from markdown files and AI prompts. This is an attempt to create a self-improving, addon-based AI system that can learn, adapt, and extend its capabilities over time.

## 🎯 Vision

Instead of just being a code editor with AI assistance, Cursor becomes:
- A **personalized AI operating system** that remembers your preferences
- An **extensible platform** through the addon system
- A **learning system** that improves with each interaction
- A **document and script management system** that organizes your work

## 📁 System Architecture

```
cursor-os/
├── .cursorrules             # Core OS instructions (loaded first)
├── personality.md           # AI personality and behavior config
├── addons/                  # System extensions and specialized prompts
├── documents/               # Generated documents and outputs
├── scripts/                 # Executable scripts and automation
├── user-data/               # Personal data and computer context (git-ignored)
└── README.md                # This file
```

## 🔧 How It Works

### 1. **Core System** (`.cursorrules`)
The `.cursorrules` file is automatically loaded by Cursor as the first prompt, establishing the operating system behavior and protocols.

### 2. **Personality System** (`personality`)
Defines the AI's core identity, communication style, and problem-solving approach. This can be customized and updated based on user preferences.

### 3. **Addon System** (`addons/`)
Before handling any specialized task, Cursor searches for relevant addons that provide specific guidelines and best practices. For example:
- `blog-writing.md` - Guidelines for writing blog posts
- `code-review.md` - Best practices for code reviews
- `documentation.md` - Standards for technical documentation

### 4. **User Data** (`user-data/`)
Stores information about the user and their computer to provide personalized responses and maintain context across sessions.

### 5. **Output Management**
- `documents/` - All generated documents are saved here with clear organization
- `scripts/` - Reusable scripts and automation tools

## 🚀 Getting Started

### Initial Setup
1. **Clone this repository** to your Cursor workspace
2. **Open Cursor** in this directory
3. **Initialize the system** by typing to cursor: `init`

### First-Time Initialization
When you type `init`, Cursor OS will:
- 🤖 **Gather system information** automatically (OS, hardware, installed tools)
- 💬 **Interview you** about your preferences and technical background
- 📝 **Create your user profile** in the `user-data/` directory
- 🎯 **Set up personalized workflows** based on your needs
- 📚 **Show you how to use** the addon system

This takes 2-3 minutes and only needs to be done once.

### Using Cursor OS
After initialization, you can:
4. **Request any task** like "write a blog post" or "create a Python script"
5. **Watch Cursor** automatically search addons, apply your personality, and save outputs
6. **Create new addons** by asking "create an addon for [topic]"

### Example First Session
```
You: init
Cursor: 🚀 Welcome to Cursor OS! Let me gather some information...
[System discovery and user interview happens]

You: Create a Python script for data analysis
Cursor: [Creates full project in documents/projects/ with proper structure]

You: Write a blog post about Python best practices
Cursor: [Loads blog-writing addon and creates professional post]
```

## 🔌 Creating Addons

Cursor can create its own addons! Simply ask it to:
```
"Create an addon for database design best practices"
```

Cursor will:
1. Research best practices
2. Create a new addon file in `addons/`
3. Structure it for future reuse
4. Test it on a sample task

## 📝 Example Workflows

### Blog Post Creation
1. User: "Write a blog post about React hooks"
2. Cursor loads `addons/blog-writing.md` (if exists)
3. Applies personality + addon guidelines
4. Creates post in `documents/blog-posts/`
5. Saves any new learnings as addon updates

### Code Review
1. User: "Review this JavaScript code"
2. Cursor loads `addons/code-review.md`
3. Applies systematic review process
4. Saves review in `documents/code-reviews/`
5. Updates user preferences in `user-data/`

## 🔮 Future Vision

This project explores:
- **AI self-improvement** through addon creation
- **Persistent AI memory** through organized file systems
- **Specialized AI behaviors** through prompt engineering
- **AI operating systems** as the future of human-computer interaction

## 🤝 Contributing

This is an experimental project exploring the boundaries of AI systems. Feel free to:
- Create new addons
- Improve the personality configuration
- Suggest new system capabilities
- Share your results and learnings

## ⚠️ Important Notes

### Experimental Project
This is an experimental project pushing the boundaries of what's possible with AI prompt engineering. Results may vary, and the system will improve over time through use and iteration.

### Model Compatibility
**Cursor OS was tested primarily with Claude 4 Sonnet**. Different AI models may produce varying results in terms of:
- **Addon system effectiveness** - Some models may be better at understanding and applying specialized prompts
- **Personality consistency** - The ability to maintain consistent behavior patterns across interactions
- **System navigation** - How well the AI follows the file organization and protocol structure
- **Self-improvement capabilities** - The quality of auto-generated addons and system updates

If you're using a different AI model (GPT-4, Claude 3, etc.), you may need to adjust prompts or expectations accordingly. The system is designed to be model-agnostic, but you know.

### Not Affiliated with Cursor
**DISCLAIMER**: This project is **not affiliated with, endorsed by, or connected to** Cursor AI, Inc. or the official Cursor code editor project. This is an independent, experimental project that uses the Cursor editor as a platform for exploring AI prompt engineering and operating system concepts. All trademarks belong to their respective owners.

### Privacy and Data Collection Warning
**🔒 PRIVACY NOTICE**: This system collects and stores personal information about you and your computer setup in the `user-data/` directory to provide personalized assistance. Please be aware that:

- **Personal Data Collection**: The system automatically gathers information about your operating system, hardware, installed software, development tools, work preferences, and other personal details during initialization
- **Local Storage**: All data is stored locally in markdown files within the `user-data/` folder (which is git-ignored)
- **AI Processing**: Your personal information may be processed by Cursor's AI system to provide personalized responses
- **No Guarantees**: The author of this project takes **no responsibility** for what data Cursor collects, how it processes your information, or what it does with your personal data
- **Your Responsibility**: You are responsible for reviewing and managing what personal information you share during the initialization and ongoing interactions
- **Data Control**: You can review, edit, or delete any files in the `user-data/` directory at any time

**Recommendation**: Review the contents of the `user-data/` directory regularly and remove any information you don't want stored locally or processed by AI systems.

### Terms of Use
By using Cursor OS, you acknowledge that:
- This is an experimental project with no warranties
- You understand the data collection implications
- You take full responsibility for any personal information shared
- The author is not liable for any privacy, security, or data issues

## 👨‍💻 Credits

**Idea and Implementation**: Hubert "Hukasx0" Kasperek  
**Prompts and Code**: Generated by Cursor

This project demonstrates the collaborative potential between human creativity and AI assistance in building innovative systems.

## 📄 License

This project is dedicated to the public domain under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/).

You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission. See the [LICENSE](LICENSE) file for details.

---

**Welcome to the future of AI operating systems!** 🎉 