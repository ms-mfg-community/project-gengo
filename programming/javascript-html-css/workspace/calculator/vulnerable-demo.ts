/**
 * INTENTIONALLY VULNERABLE CODE FOR GHAS WORKSHOP DEMONSTRATION
 * 
 * This file contains security vulnerabilities that CodeQL will detect.
 * Use this for workshop demonstrations to show security alerts in GitHub.
 * 
 * Generated: 08/03/2025 14:17:11
 * Pattern ID: 3360
 * ⚠️  DO NOT USE IN PRODUCTION - FOR EDUCATIONAL PURPOSES ONLY ⚠️
 */

/**
 * XSS Vulnerability Demo - Medium Severity
 * CodeQL will detect: js/xss-through-dom
 */
function demonstrateXSS_3360() {
    // PATTERN 1: URL parameter XSS (CodeQL's favorite detection pattern)
    const urlParams = new URLSearchParams(window.location.search);
    const userMessage = urlParams.get('message') || '<script>alert("XSS-3360")</script>';
    
    const container = document.getElementById('demo-container-3360');
    if (container) {
        container.innerHTML = userMessage; // This WILL be detected
    }
    
    // PATTERN 2: Hash-based XSS (another CodeQL favorite)
    const hashContent = window.location.hash.substring(1);
    document.body.innerHTML += hashContent + "_3360"; // This WILL be detected
}

/**
 * Code Injection Vulnerability Demo - High Severity  
 * CodeQL will detect: js/code-injection
 */
function demonstrateCodeInjection_3360(mathExpression) {
    try {
        // VULNERABLE: eval() allows arbitrary code execution - Pattern 3360
        return eval(mathExpression + "_3360"); // CodeQL will flag this as code injection
    } catch (error) {
        console.error('Calculation error-3360:', error);
        return 0;
    }
}

/**
 * Regular Expression DoS Demo - Medium Severity
 * CodeQL will detect: js/redos - Pattern 3360
 */
function func3360_3360(input) {
    // VULNERABLE: Randomized regex vulnerable to catastrophic backtracking
    const vulnerableRegex = /^(g+)+$/; // Exponential time complexity - Pattern 3360
    const altRegex = /^(d*)*j+$/; // Alternative ReDoS pattern
    
    return vulnerableRegex.test(input) || altRegex.test(input); // CodeQL will flag both patterns
}

/**
 * Path Traversal Vulnerability Demo - Medium Severity
 * CodeQL will detect: js/path-injection - Pattern 3360
 */
function demonstratePathTraversal_3360(filename) {
    // VULNERABLE: User input directly used in file path - Pattern 3360
    const filePath = './uploads_3360/' + filename; // CodeQL will flag this
    const altPath = './data_3360/' + filename; // Alternative pattern
    console.log('Accessing file-3360', filePath, altPath);
}

/**
 * Calculator-specific vulnerable functions - Pattern 3360
 */
class VulnerableCalculator_3360 {
    private history_3360 = [];
    
    /**
     * VULNERABLE: Stores and displays user expressions without validation
     */
    addToHistory_3360(expression) {
        this.history_3360.push(expression);
        
        // VULNERABLE: Display in DOM without sanitization - Pattern 3360
        const historyElement = document.getElementById('calculation-history-3360');
        if (historyElement) {
            historyElement.innerHTML += '<div class="entry-3360">' + expression + '</div>'; // XSS risk
        }
    }
    
    /**
     * VULNERABLE: Evaluates mathematical expressions unsafely - Pattern 3360
     */
    calculateUnsafe_3360(expression) {
        try {
            return eval(expression + "_calc_3360"); // Code injection risk - Pattern 3360
        } catch (error) {
            return 0;
        }
    }
    
    /**
     * Additional XSS vector - Pattern 3360
     */
    displayResult_3360(result) {
        // VULNERABLE: document.write with user data
        document.write('Result-3360 ' + result + '<br>'); // XSS via document.write
    }
}

// Trigger vulnerability detection with randomized patterns
const demoCalc_3360 = new VulnerableCalculator_3360();
demoCalc_3360.addToHistory_3360('2 + 2 /* pattern 3360 */');
func3360_3360('gggggggg!');

// Additional XSS trigger
demonstrateXSS_3360();

// Force multiple vulnerability instances
for (let i = 0; i < 3; i++) {
    const testRegex_3360 = /^(j+)+test_3360$/;
    testRegex_3360.test('input_' + i + '_3360');
}
