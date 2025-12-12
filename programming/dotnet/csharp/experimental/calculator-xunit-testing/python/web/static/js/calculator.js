/**
 * Calculator JavaScript for handling user interactions and API calls.
 */

// Get display element
const displayElement = document.getElementById('display');

/**
 * Update the display value
 */
function updateDisplay(value) {
    displayElement.value = value;
}

/**
 * Handle number button clicks
 */
async function handleNumber(digit) {
    try {
        const response = await fetch('/api/number', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ digit: digit }),
        });
        
        const data = await response.json();
        updateDisplay(data.display);
    } catch (error) {
        console.error('Error handling number:', error);
    }
}

/**
 * Handle operator button clicks
 */
async function handleOperator(operator) {
    try {
        const response = await fetch('/api/operator', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ operator: operator }),
        });
        
        const data = await response.json();
        updateDisplay(data.display);
    } catch (error) {
        console.error('Error handling operator:', error);
    }
}

/**
 * Handle equals button click
 */
async function handleEquals() {
    try {
        const response = await fetch('/api/equals', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
        });
        
        const data = await response.json();
        updateDisplay(data.display);
        
        // Reload page to update history
        if (data.history) {
            location.reload();
        }
    } catch (error) {
        console.error('Error handling equals:', error);
    }
}

/**
 * Handle clear button click
 */
async function handleClear() {
    try {
        const response = await fetch('/api/clear', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
        });
        
        const data = await response.json();
        updateDisplay(data.display);
    } catch (error) {
        console.error('Error handling clear:', error);
    }
}

/**
 * Toggle theme
 */
async function toggleTheme() {
    try {
        const response = await fetch('/api/theme/toggle', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
        });
        
        const data = await response.json();
        
        // Update theme class
        const container = document.querySelector('.calculator-container');
        container.className = `${data.theme_class} calculator-container`;
        
        // Update icon
        document.getElementById('themeIcon').textContent = data.theme_icon;
    } catch (error) {
        console.error('Error toggling theme:', error);
    }
}

/**
 * Clear calculation history
 */
async function clearHistory() {
    try {
        await fetch('/api/history/clear', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
        });
        
        // Reload page to update UI
        location.reload();
    } catch (error) {
        console.error('Error clearing history:', error);
    }
}

/**
 * Replay a calculation from history
 */
async function replayCalculation(index) {
    try {
        const response = await fetch(`/api/history/replay/${index}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
        });
        
        const data = await response.json();
        if (data.display) {
            updateDisplay(data.display);
        }
    } catch (error) {
        console.error('Error replaying calculation:', error);
    }
}

/**
 * Handle keyboard input
 */
document.addEventListener('keydown', function(event) {
    const key = event.key;
    
    // Numbers and decimal point
    if (/[0-9.]/.test(key)) {
        event.preventDefault();
        handleNumber(key);
    }
    // Operators
    else if (key === '+' || key === '-' || key === '*' || key === '/' || key === '%' || key === '^') {
        event.preventDefault();
        handleOperator(key);
    }
    // Equals
    else if (key === 'Enter' || key === '=') {
        event.preventDefault();
        handleEquals();
    }
    // Clear
    else if (key === 'Escape' || key === 'c' || key === 'C') {
        event.preventDefault();
        handleClear();
    }
});

// Set up theme toggle button
document.getElementById('themeToggle').addEventListener('click', toggleTheme);
