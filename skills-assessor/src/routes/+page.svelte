<script>
  import data from '../lib/data.json';
  
  // Variables
  let isubjectno = 0;
  let ilevel = 0;
  let iqa = 0;
  let currentQuestion = "";
  let currentOptions = [];
  let currentAnswer = "";
  let selectedAnswer = "";
  let isCorrect = false;
  let answerFeedback = "";
  let correctAnswersCount = 0;
  let questionsAsked = 0;
  let currentQuestionIndex = 0;
  let levelExhausted = false;
  let showLevelUpDialog = false;
  let showLevelResetDialog = false;
  let showAbandonDialog = false;
  let completedLevel = 0;
  let askedQuestions = [];
  let correctAnswerHighlighted = false;
  let testAbandoned = false;
  let levelLocked = false; // Lock level selection once a level is selected

  // Subject names array
  const subjectNames = ["", "python", "pyspark", "tba3", "tba4", "tba5", "tba6", "tba7", "tba8", "tba9", "tba10"];

  // Track current subject/level to detect changes
  let lastSubject = 0;
  let lastLevel = 0;

  // Reset question state when subject/level changes
  function resetQuestionState() {
    if (isubjectno !== lastSubject || ilevel !== lastLevel) {
      askedQuestions = [];
      currentQuestionIndex = 0;
      lastSubject = isubjectno;
      lastLevel = ilevel;
      correctAnswerHighlighted = false;
      answerFeedback = "";
      selectedAnswer = "";
      isCorrect = false;
    }
  }

  // Get question function
  function getQuestion() {
    resetQuestionState();
    const selectedSubject = subjectNames[isubjectno];
    console.log('Getting question for subject:', selectedSubject, 'level:', ilevel);
    
    if (isubjectno === 0 || ilevel === 0) {
      currentQuestion = "Please select a subject and level first.";
      currentOptions = [];
      currentAnswer = "";
      levelLocked = false; // Unlock if no level selected
      return;
    }
    
    // Lock level selection once a question is requested
    if (!levelLocked && ilevel > 0) {
      levelLocked = true;
      console.log('Level locked - cannot change level until completed or abandoned');
    }

    // Filter questions by subject and level
    const filteredQuestions = data.questions.filter(q => 
      q.subject === selectedSubject && q.level === ilevel
    );

    console.log('Filtered questions:', filteredQuestions.length);

    if (filteredQuestions.length === 0) {
      currentQuestion = `No questions found for ${selectedSubject} level ${ilevel}`;
      currentOptions = [];
      currentAnswer = "";
      return;
    }

    // Filter out already asked questions
    const availableQuestions = filteredQuestions.filter(q => !askedQuestions.includes(q.id));
    
    if (availableQuestions.length === 0) {
      // All questions have been asked
      levelExhausted = true;
      if (correctAnswersCount >= 10) {
        showLevelUpDialog = true;
        completedLevel = ilevel;
        levelLocked = false; // Unlock level selection when level is completed
        currentQuestion = `🎉 Congratulations! You've completed level ${completedLevel} with ${correctAnswersCount} correct answers!`;
        currentOptions = [];
        currentAnswer = "";
        console.log('Level completed with', correctAnswersCount, 'correct answers');
      } else {
        showLevelResetDialog = true;
        currentQuestion = `You've exhausted all questions at level ${ilevel}. You got ${correctAnswersCount} correct answers. Would you like to reset and try again?`;
        currentOptions = [];
        currentAnswer = "";
      }
      return;
    }

    // Select a random question from available ones
    const randomIndex = Math.floor(Math.random() * availableQuestions.length);
    const question = availableQuestions[randomIndex];
    
    currentQuestion = question.question;
    currentOptions = question.options;
    currentAnswer = question.answer;
    askedQuestions.push(question.id);
    correctAnswerHighlighted = false;
    answerFeedback = "";
    selectedAnswer = "";
    isCorrect = false;
  }

  // Check answer function
  function checkAnswer(selectedOption) {
    if (selectedAnswer !== "") return; // Prevent multiple submissions
    
    selectedAnswer = selectedOption;
    isCorrect = (selectedOption === currentAnswer);
    questionsAsked++; // Increment for every answer
    
    if (isCorrect) {
      correctAnswersCount++;
      iqa = correctAnswersCount;
      answerFeedback = "Correct! Well done!";
      
      if (correctAnswersCount >= 10) { // Immediate level completion
        levelExhausted = true;
        showLevelUpDialog = true;
        completedLevel = ilevel;
        levelLocked = false; // Unlock level selection when level is completed
        currentQuestion = `🎉 Congratulations! You've completed level ${completedLevel} with ${correctAnswersCount} correct answers!`;
        currentOptions = [];
        currentAnswer = "";
        console.log('Level completed with', correctAnswersCount, 'correct answers');
      } else {
        // Auto-advance to next question after a short delay
        setTimeout(() => {
          if (!levelExhausted && !showLevelUpDialog) {
            getQuestion();
          }
        }, 2000);
      }
    } else {
      answerFeedback = `Incorrect. The correct answer is: ${currentAnswer}`;
      correctAnswerHighlighted = true; // Highlight correct answer
      // Auto-advance to next question after showing feedback
      setTimeout(() => {
        if (!levelExhausted && !showLevelUpDialog) {
          getQuestion();
        }
      }, 3000);
    }
  }

  // Reset counter function
  function resetCounter() {
    correctAnswersCount = 0;
    questionsAsked = 0;
    iqa = 0;
    answerFeedback = "";
    isCorrect = false;
    selectedAnswer = "";
    console.log('Counter reset - ilevel before reset:', ilevel);
    console.log('Counter reset - isubjectno before reset:', isubjectno);
  }

  // Proceed to next level
  function proceedToNextLevel() {
    console.log('Before level increment - ilevel:', ilevel);
    ilevel++;
    console.log('After level increment - ilevel:', ilevel);
    currentQuestionIndex = 0;
    levelExhausted = false;
    showLevelUpDialog = false;
    askedQuestions = []; // Clear asked questions for new level
    resetCounter();
    console.log('After resetCounter - ilevel:', ilevel, 'Subject:', isubjectno);
    console.log('About to call getQuestion with ilevel:', ilevel, 'isubjectno:', isubjectno);
    getQuestion();
  }

  // Reset level
  function resetLevel() {
    correctAnswersCount = 0;
    questionsAsked = 0;
    iqa = 0;
    answerFeedback = "";
    isCorrect = false;
    selectedAnswer = "";
    askedQuestions = []; // Clear the asked questions list
    currentQuestionIndex = 0; // Reset question index
    showLevelResetDialog = false;
    console.log('Level reset - starting over at level:', ilevel);
    getQuestion();
  }

  // Abandon test
  function abandonTest() {
    showAbandonDialog = true;
    currentQuestion = "⚠️ Are you sure you want to abandon this test?";
    currentOptions = [];
    currentAnswer = "";
    console.log('Abandon test requested');
  }

  function confirmAbandon() {
    showAbandonDialog = false;
    testAbandoned = true;
    
    // Clear all state
    isubjectno = 0;
    ilevel = 0;
    iqa = 0;
    currentQuestion = "";
    currentOptions = [];
    currentAnswer = "";
    selectedAnswer = "";
    isCorrect = false;
    answerFeedback = "";
    correctAnswersCount = 0;
    questionsAsked = 0;
    currentQuestionIndex = 0;
    levelExhausted = false;
    showLevelUpDialog = false;
    showLevelResetDialog = false;
    completedLevel = 0;
    askedQuestions = [];
    correctAnswerHighlighted = false;
    lastSubject = 0;
    lastLevel = 0;
    levelLocked = false; // Unlock level selection when test is abandoned
    
    console.log('Test abandoned - screen cleared');
  }
</script>

<svelte:head>
  <title>Skills Assessor V0.0.1</title>
</svelte:head>

{#if testAbandoned}
  <div class="thank-you-container">
    <div class="thank-you-message">
      Thank you for using Skills Assessor
    </div>
  </div>
{:else}
<div class="quiz-container">
  <h1>Skills Assessor V0.0.1</h1>
  
  <!-- Subject Selection -->
  <div class="section">
    <h3>Subject:</h3>
    <div class="button-group">
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 1; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 1;
        console.log('Python clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 1}
              disabled={levelLocked}>
        python
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 2; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 2;
        console.log('PySpark clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 2}
              disabled={levelLocked}>
        pyspark
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 3; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 3;
        console.log('TBA3 clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 3}
              disabled={levelLocked}>
        3
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 4; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 4;
        console.log('TBA4 clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 4}
              disabled={levelLocked}>
        4
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 5; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 5;
        console.log('TBA5 clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 5}
              disabled={levelLocked}>
        5
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 6; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 6;
        console.log('TBA6 clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 6}
              disabled={levelLocked}>
        6
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 7; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 7;
        console.log('TBA7 clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 7}
              disabled={levelLocked}>
        7
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 8; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 8;
        console.log('TBA8 clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 8}
              disabled={levelLocked}>
        8
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 9; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 9;
        console.log('TBA9 clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 9}
              disabled={levelLocked}>
        9
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        isubjectno = 10; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastSubject = 10;
        console.log('TBA10 clicked, isubjectno:', isubjectno); 
      }} 
              class:selected={isubjectno === 10}
              disabled={levelLocked}>
        10
      </button>
    </div>
  </div>

  <!-- Level Selection -->
  <div class="section">
    <h3>Level:</h3>
    <div class="button-group">
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 1; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 1;
        console.log('level 1 clicked'); 
      }} 
              class:selected={ilevel === 1}
              disabled={levelLocked}>
        1
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 2; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 2;
        console.log('level 2 clicked'); 
      }} 
              class:selected={ilevel === 2}
              disabled={levelLocked}>
        2
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 3; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 3;
        console.log('level 3 clicked'); 
      }} 
              class:selected={ilevel === 3}
              disabled={levelLocked}>
        3
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 4; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 4;
        console.log('level 4 clicked'); 
      }} 
              class:selected={ilevel === 4}
              disabled={levelLocked}>
        4
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 5; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 5;
        console.log('level 5 clicked'); 
      }} 
              class:selected={ilevel === 5}
              disabled={levelLocked}>
        5
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 6; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 6;
        console.log('level 6 clicked'); 
      }} 
              class:selected={ilevel === 6}
              disabled={levelLocked}>
        6
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 7; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 7;
        console.log('level 7 clicked'); 
      }} 
              class:selected={ilevel === 7}
              disabled={levelLocked}>
        7
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 8; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 8;
        console.log('level 8 clicked'); 
      }} 
              class:selected={ilevel === 8}
              disabled={levelLocked}>
        8
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 9; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 9;
        console.log('level 9 clicked'); 
      }} 
              class:selected={ilevel === 9}
              disabled={levelLocked}>
        9
      </button>
      <button on:click={() => { 
        if (levelLocked) return;
        ilevel = 10; 
        askedQuestions = [];
        currentQuestionIndex = 0;
        lastLevel = 10;
        console.log('level 10 clicked'); 
      }} 
              class:selected={ilevel === 10}
              disabled={levelLocked}>
        10
      </button>
    </div>
  </div>

  <!-- Questions Answered -->
  <div class="section">
    <h3>Correct Answers: {correctAnswersCount} / Questions Asked: {questionsAsked}</h3>
    <div class="button-group">
      <button class:selected={correctAnswersCount === 0} disabled>0</button>
      <button on:click={() => { iqa = 1; console.log('question 1 clicked'); }} 
              class:selected={correctAnswersCount >= 1}>
        1
      </button>
      <button on:click={() => { iqa = 2; console.log('question 2 clicked'); }} 
              class:selected={correctAnswersCount >= 2}>
        2
      </button>
      <button on:click={() => { iqa = 3; console.log('question 3 clicked'); }} 
              class:selected={correctAnswersCount >= 3}>
        3
      </button>
      <button on:click={() => { iqa = 4; console.log('question 4 clicked'); }} 
              class:selected={correctAnswersCount >= 4}>
        4
      </button>
      <button on:click={() => { iqa = 5; console.log('question 5 clicked'); }} 
              class:selected={correctAnswersCount >= 5}>
        5
      </button>
      <button on:click={() => { iqa = 6; console.log('question 6 clicked'); }} 
              class:selected={correctAnswersCount >= 6}>
        6
      </button>
      <button on:click={() => { iqa = 7; console.log('question 7 clicked'); }} 
              class:selected={correctAnswersCount >= 7}>
        7
      </button>
      <button on:click={() => { iqa = 8; console.log('question 8 clicked'); }} 
              class:selected={correctAnswersCount >= 8}>
        8
      </button>
      <button on:click={() => { iqa = 9; console.log('question 9 clicked'); }} 
              class:selected={correctAnswersCount >= 9}>
        9
      </button>
      <button on:click={() => { iqa = 10; console.log('question 10 clicked'); }} 
              class:selected={correctAnswersCount >= 10}>
        10
      </button>
    </div>
  </div>

  <!-- Get Question Button -->
  <div class="section">
    <button on:click={getQuestion} class="get-question-btn">Get Question</button>
  </div>

  <!-- Question Display -->
  <div class="section">
    <h3>Question:</h3>
    <p class="question-text">{currentQuestion}</p>
  </div>

  <!-- Answer Options -->
  <div class="section">
    <h3>Answer Options:</h3>
    <div class="answer-options">
      <button on:click={() => checkAnswer(currentOptions[0])} 
              class:correct={correctAnswerHighlighted && currentOptions[0] === currentAnswer}
              disabled={!currentOptions[0] || selectedAnswer !== ""}>
        {currentOptions[0] || 'Answer A'}
      </button>
      <button on:click={() => checkAnswer(currentOptions[1])} 
              class:correct={correctAnswerHighlighted && currentOptions[1] === currentAnswer}
              disabled={!currentOptions[1] || selectedAnswer !== ""}>
        {currentOptions[1] || 'Answer B'}
      </button>
      <button on:click={() => checkAnswer(currentOptions[2])} 
              class:correct={correctAnswerHighlighted && currentOptions[2] === currentAnswer}
              disabled={!currentOptions[2] || selectedAnswer !== ""}>
        {currentOptions[2] || 'Answer C'}
      </button>
      <button on:click={() => checkAnswer(currentOptions[3])} 
              class:correct={correctAnswerHighlighted && currentOptions[3] === currentAnswer}
              disabled={!currentOptions[3] || selectedAnswer !== ""}>
        {currentOptions[3] || 'Answer D'}
      </button>
    </div>
  </div>

  <!-- Feedback -->
  {#if answerFeedback}
    <div class="feedback">
      <p class="feedback-text">{answerFeedback}</p>
    </div>
  {/if}

  <!-- Abandon Test Button -->
  <div class="section">
    <button on:click={abandonTest} class="abandon-btn">Abandon Test</button>
  </div>

  <!-- Level Up Dialog -->
  {#if showLevelUpDialog}
    <div class="dialog-overlay">
      <div class="dialog">
        <h3>Level Complete!</h3>
        <p>You've completed level {completedLevel} with {correctAnswersCount} correct answers!</p>
        <p>Would you like to proceed to the next level?</p>
        <div class="dialog-buttons">
          <button on:click={proceedToNextLevel} class="yes-btn">Yes, Go to Next Level</button>
          <button on:click={() => { showLevelUpDialog = false; }} class="no-btn">No, Stay Here</button>
        </div>
      </div>
    </div>
  {/if}

  <!-- Level Reset Dialog -->
  {#if showLevelResetDialog}
    <div class="dialog-overlay">
      <div class="dialog">
        <h3>Level Exhausted</h3>
        <p>You've exhausted all questions at level {ilevel}.</p>
        <p>You got {correctAnswersCount} correct answers.</p>
        <p>Would you like to reset and try again?</p>
        <div class="dialog-buttons">
          <button on:click={resetLevel} class="yes-btn">Yes, Reset Level</button>
          <button on:click={() => { showLevelResetDialog = false; }} class="no-btn">No, Stay Here</button>
        </div>
      </div>
    </div>
  {/if}

  <!-- Abandon Dialog -->
  {#if showAbandonDialog}
    <div class="dialog-overlay">
      <div class="dialog">
        <h3>Abandon Test</h3>
        <p>Are you sure you want to abandon this test?</p>
        <div class="dialog-buttons">
          <button on:click={confirmAbandon} class="yes-btn">Yes, Abandon</button>
          <button on:click={() => { showAbandonDialog = false; }} class="no-btn">No, Continue</button>
        </div>
      </div>
    </div>
  {/if}
</div>
{/if}

<style>
  .thank-you-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    width: 100%;
    background-color: #f5f5f5;
  }

  .thank-you-message {
    font-size: 48px;
    font-weight: bold;
    color: #333;
    text-align: center;
    padding: 60px 80px;
    background-color: white;
    border-radius: 12px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    font-family: Arial, sans-serif;
  }

  .quiz-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .section {
    margin-bottom: 20px;
    padding: 15px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #f9f9f9;
  }

  .button-group {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 10px;
  }

  button {
    background-color: darkblue;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    min-width: 50px;
    transition: background-color 0.2s;
  }

  button:hover:not(:disabled) {
    background-color: #003366;
  }

  button:active:not(:disabled) {
    transform: translateY(2px);
  }

  button.selected {
    background-color: #4CAF50 !important;
  }

  button.correct {
    background-color: #4CAF50 !important;
  }

  button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }

  .get-question-btn {
    background-color: #4CAF50;
    font-size: 16px;
    padding: 15px 30px;
  }

  .abandon-btn {
    background-color: #f44336;
  }

  .question-text {
    font-size: 18px;
    font-weight: bold;
    margin: 15px 0;
    padding: 15px;
    background-color: #e3f2fd;
    border-radius: 4px;
  }

  .answer-options {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
    margin-top: 10px;
  }

  .feedback {
    margin-top: 20px;
    padding: 15px;
    border-radius: 4px;
  }

  .feedback-text {
    font-weight: bold;
    margin: 0;
  }

  .dialog-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }

  .dialog {
    background-color: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    max-width: 400px;
    text-align: center;
  }

  .dialog h3 {
    margin-top: 0;
    color: #333;
  }

  .dialog-buttons {
    margin-top: 20px;
    display: flex;
    gap: 10px;
    justify-content: center;
  }

  .yes-btn {
    background-color: #4CAF50;
  }

  .no-btn {
    background-color: #f44336;
  }

  h1 {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
  }

  h3 {
    color: #555;
    margin-bottom: 10px;
  }
</style>