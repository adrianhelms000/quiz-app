# Programming Quiz Application

A comprehensive quiz application built with SvelteKit for testing programming knowledge across multiple subjects and difficulty levels.

## Features

- **Multi-Subject Support**: Python, PySpark, and 8 additional subjects
- **10 Difficulty Levels**: Progressive difficulty from level 1 to 10
- **Comprehensive Question Bank**: 15 questions per level per subject (150 questions per subject)
- **Smart Question Management**: Prevents asking the same question twice
- **Progress Tracking**: Visual feedback for correct answers and level completion
- **Level Progression**: Automatically advances when 10 correct answers are achieved
- **Learning Support**: Highlights correct answers when wrong answers are selected

## Tech Stack

- **SvelteKit** - Full-stack framework
- **TypeScript** - Type safety
- **Vite** - Build tool
- **JSON** - Question data storage

## Project Structure

```
src/
├── lib/
│   ├── data.json          # Question database (295 questions)
│   └── index.ts
├── routes/
│   └── +page.svelte       # Main quiz application
└── app.html               # HTML template

static/
└── favicon.png

package.json
svelte.config.js
vite.config.ts
tsconfig.json
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/adrianhelms000/quiz-app.git
cd quiz-app
```

2. Install dependencies:
```bash
npm install
```

3. Run the development server:
```bash
npm run dev
```

4. Open your browser to `http://localhost:5173`

## Usage

1. **Select a Subject**: Click on a subject button (Python, PySpark, etc.)
2. **Select a Level**: Choose a difficulty level (1-10)
3. **Get Question**: Click "Get Question" to retrieve a question
4. **Answer**: Click on one of the four answer options
5. **Progress**: Get 10 correct answers to complete the level
6. **Advance**: Proceed to the next level or restart the current level

## Question Data

Questions are stored in `src/lib/data.json` with the following structure:

```json
{
  "questions": [
    {
      "id": 1,
      "subject": "python",
      "level": 1,
      "question": "Question text here?",
      "options": ["Option A", "Option B", "Option C", "Option D"],
      "answer": "Correct Answer"
    }
  ]
}
```

## Development

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build

## License

MIT License

## Author

Adrian Helms (adrianhelms000)
