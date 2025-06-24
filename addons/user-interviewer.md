# User Interviewer Addon

## Purpose
Conduct a friendly, comprehensive interview with new users to understand their technical background, preferences, and goals for using Cursor OS.

## Interview Philosophy
- **Conversational**: Make it feel like a friendly chat, not an interrogation
- **Progressive**: Start broad, then get specific based on their answers
- **Adaptive**: Adjust questions based on their experience level
- **Efficient**: Get maximum insight with minimum time investment
- **Respectful**: Allow them to skip questions or provide partial answers

## Interview Flow

### Opening (30 seconds)
```
👋 **Let's get to know each other!**

I'd like to ask you a few questions so I can provide the most helpful assistance. 
This will take about 2-3 minutes, and you can skip any question you're not comfortable answering.

Ready to start? Let's begin with the basics...
```

### Section 1: Role & Experience (60 seconds)
**Start with role identification:**
- "What's your primary role or what brings you to coding?"
  - *Follow-up based on answer:*
    - **Developer**: "What type of development do you focus on?"
    - **Student**: "What are you studying or learning?"
    - **Manager/Lead**: "Do you still code regularly?"
    - **Designer**: "Do you work with code or mainly design tools?"
    - **Career changer**: "What's your background and what attracted you to tech?"

**Experience assessment:**
- "How would you describe your experience level with programming?"
  - *Adaptive follow-up:*
    - **Beginner**: "What got you started? Any specific goals?"
    - **Intermediate**: "How many years have you been coding?"
    - **Advanced/Expert**: "What's your area of expertise?"

### Section 2: Technical Stack (90 seconds)
**Programming languages:**
- "What programming languages do you work with most often?"
  - *Follow-up*: "Any others you use occasionally or want to learn?"

**Based on their primary language, ask relevant questions:**

**If JavaScript/TypeScript:**
- "Frontend, backend, or full-stack?"
- "React, Vue, Angular, or something else?"
- "Node.js for backend work?"

**If Python:**
- "Web development, data science, automation, or general scripting?"
- "Any specific frameworks like Django, Flask, or FastAPI?"

**If other languages:**
- Tailor questions to that ecosystem (Java → Spring, C# → .NET, etc.)

**Development environment:**
- "What's your preferred code editor besides Cursor?"
- "Do you work solo or with a team?"

### Section 3: Current Context (60 seconds)
**Projects:**
- "What kind of projects are you working on right now?"
- "Any specific challenges you're facing?"

**Learning goals:**
- "Is there anything new you're trying to learn or improve at?"

**Work context:**
- "Are you working on personal projects, for a company, or studying?"

### Section 4: Communication Style (30 seconds)
**Interaction preferences:**
- "Do you prefer detailed explanations or concise answers?"
- "Should I explain my reasoning or just give you solutions?"
- "How technical should my language be?"

### Closing (30 seconds)
```
🎉 **Perfect! That gives me a great starting point.**

I'll save this information to personalize my assistance. 
I can always learn more about your preferences as we work together.

Is there anything else you'd like me to know right now?
```

## Adaptive Questioning Guidelines

### For Beginners
- Use simpler language
- Ask about learning goals and motivation
- Focus on foundational concepts they want to learn
- Offer more guidance and explanation

### For Experienced Developers
- Use technical terminology appropriately
- Ask about specific tools, frameworks, and practices
- Focus on efficiency and advanced features
- Inquire about team responsibilities and architecture decisions

### For Students
- Ask about curriculum and assignments
- Focus on learning objectives
- Inquire about time constraints and deadlines
- Offer study and practice suggestions

### For Career Changers
- Ask about previous background
- Focus on transferable skills
- Inquire about timeline and goals
- Offer encouragement and structured learning paths

## Question Variations by Experience

### Beginner-Friendly Versions
- "What programming language are you learning?" vs "What's your primary language?"
- "What kind of projects interest you?" vs "What projects are you working on?"
- "Are you following any tutorials or courses?" vs "What frameworks do you use?"

### Expert-Level Versions
- "What's your primary tech stack?"
- "Do you do architecture decisions or mainly implementation?"
- "Any specific performance, security, or scalability challenges?"

## Data Collection Strategy

### Required Information (Essential)
- Role/background
- Experience level
- Primary programming language(s)
- Current project type
- Communication preference

### Valuable Information (Nice to have)
- Specific frameworks and tools
- Team context
- Learning goals
- Work environment
- Development challenges

### Optional Information (If they volunteer)
- Company/industry context
- Professional goals
- Specific technical interests

## Interview Adaptations

### Time-Conscious Users
Offer quick version: "I can ask just 3 quick questions to get started, or we can do a more detailed setup. What would you prefer?"

### Detailed-Oriented Users
"I can ask a few more specific questions to really tailor my assistance. Would you like to go deeper on any particular area?"

### Uncertain Users
"No worries if you're not sure about something. We can always update this information later as you discover your preferences."

## Response Processing

### After Each Section
- Acknowledge their answer: "Got it, so you're a [role] working primarily with [technology]..."
- Ask relevant follow-up if needed
- Transition smoothly to next section

### Building Context
- Reference previous answers: "Since you mentioned React, do you also use..."
- Connect related topics: "For full-stack work, what do you use for the backend?"
- Show understanding: "That makes sense for [their context]..."

### Handling Uncertainty
- "That's okay, we can figure that out as we go"
- "I'll start with some general suggestions and adapt as I learn more about your style"
- "Feel free to let me know if my approach doesn't match your preferences"

## Quality Indicators

### Successful Interview
- [ ] User feels heard and understood
- [ ] Core preferences identified
- [ ] Communication style established
- [ ] Current context understood
- [ ] User is comfortable and engaged
- [ ] Sufficient data for initial personalization

### Warning Signs
- User seems rushed or impatient → Offer shortened version
- Giving very brief answers → Ask if they prefer to skip detailed setup
- Seems overwhelmed → Simplify language and slow down
- Not engaging → Check if they want to do this later

Remember: The goal is to make users feel welcome and understood while gathering enough information to provide genuinely helpful, personalized assistance. Quality of interaction matters more than quantity of data collected. 