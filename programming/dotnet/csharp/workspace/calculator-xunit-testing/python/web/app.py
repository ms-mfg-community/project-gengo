"""
Flask web application for the calculator.

This module implements a web-based calculator using Flask with support
for light/dark themes, persistent calculation history, and interactive UI components.
Uses SQLite database for persistent storage of calculation history.
"""

from flask import Flask, render_template, request, jsonify, session
import os
import sys
from pathlib import Path

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).parent.parent))

from database import init_db
from services.calculator_service import CalculatorService
from services.history_service import HistoryService
from services.theme_service import ThemeService, ThemeMode


app = Flask(__name__)
app.secret_key = os.urandom(24)

# Initialize database on app startup
try:
    init_db()
except Exception as e:
    print(f"Warning: Database initialization failed: {e}")

# Session-based services
def get_calculator_service():
    """Get or create calculator service for the current session."""
    if 'calculator_display' not in session:
        session['calculator_display'] = '0'
    return CalculatorService()


def get_history_service():
    """
    Get history service with persistent database backend.
    
    Returns a HistoryService instance that uses SQLite database
    for persistent storage instead of session memory.
    """
    return HistoryService()


def get_theme_service():
    """Get or create theme service for the current session."""
    if 'theme' not in session:
        session['theme'] = 'light'
    
    service = ThemeService()
    if session['theme'] == 'dark':
        service.current_theme = ThemeMode.DARK
    return service


@app.route('/')
def index():
    """Render the calculator page."""
    theme_service = get_theme_service()
    history_service = get_history_service()
    
    return render_template(
        'index.html',
        theme_class=theme_service.theme_class,
        theme_icon=theme_service.theme_toggle_icon,
        display=session.get('calculator_display', '0'),
        history=history_service.get_all_as_dicts(),
        history_empty=history_service.is_empty
    )


@app.route('/api/number', methods=['POST'])
def handle_number():
    """Handle number button click."""
    data = request.get_json()
    digit = data.get('digit', '')
    
    calc_service = get_calculator_service()
    
    # Restore state from session
    calc_service.display = session.get('calculator_display', '0')
    calc_service._first_operand = session.get('first_operand')
    calc_service._second_operand = session.get('second_operand')
    calc_service._pending_operation = session.get('pending_operation')
    calc_service._should_reset_display = session.get('should_reset_display', False)
    calc_service._last_first_operand = session.get('last_first_operand', '')
    calc_service._last_second_operand = session.get('last_second_operand', '')
    
    # Handle the click
    calc_service.handle_number_click(digit)
    
    # Save state to session
    session['calculator_display'] = calc_service.display
    session['first_operand'] = calc_service._first_operand
    session['second_operand'] = calc_service._second_operand
    session['pending_operation'] = calc_service._pending_operation
    session['should_reset_display'] = calc_service._should_reset_display
    session['last_first_operand'] = calc_service._last_first_operand
    session['last_second_operand'] = calc_service._last_second_operand
    
    return jsonify({'display': calc_service.display})


@app.route('/api/operator', methods=['POST'])
def handle_operator():
    """Handle operator button click."""
    data = request.get_json()
    operator = data.get('operator', '')
    
    calc_service = get_calculator_service()
    
    # Restore state from session
    calc_service.display = session.get('calculator_display', '0')
    calc_service._first_operand = session.get('first_operand')
    calc_service._second_operand = session.get('second_operand')
    calc_service._pending_operation = session.get('pending_operation')
    calc_service._should_reset_display = session.get('should_reset_display', False)
    calc_service._last_first_operand = session.get('last_first_operand', '')
    calc_service._last_second_operand = session.get('last_second_operand', '')
    
    # Handle the click
    calc_service.handle_operator_click(operator)
    
    # Save state to session
    session['calculator_display'] = calc_service.display
    session['first_operand'] = calc_service._first_operand
    session['second_operand'] = calc_service._second_operand
    session['pending_operation'] = calc_service._pending_operation
    session['should_reset_display'] = calc_service._should_reset_display
    session['last_first_operand'] = calc_service._last_first_operand
    session['last_second_operand'] = calc_service._last_second_operand
    
    return jsonify({'display': calc_service.display})


@app.route('/api/equals', methods=['POST'])
def handle_equals():
    """Handle equals button click."""
    calc_service = get_calculator_service()
    history_service = get_history_service()
    
    # Restore state from session
    calc_service.display = session.get('calculator_display', '0')
    calc_service._first_operand = session.get('first_operand')
    calc_service._second_operand = session.get('second_operand')
    calc_service._pending_operation = session.get('pending_operation')
    calc_service._should_reset_display = session.get('should_reset_display', False)
    calc_service._last_first_operand = session.get('last_first_operand', '')
    calc_service._last_second_operand = session.get('last_second_operand', '')
    
    # Set up callback for calculation completed
    def on_calculation_completed(op1, operator, op2, result):
        history_service.add_calculation(op1, operator, op2, result)
        session['history'] = history_service.get_all_as_dicts()
    
    calc_service.set_calculation_completed_callback(on_calculation_completed)
    
    # Handle the equals
    calc_service.handle_equals()
    
    # Save state to session
    session['calculator_display'] = calc_service.display
    session['first_operand'] = calc_service._first_operand
    session['second_operand'] = calc_service._second_operand
    session['pending_operation'] = calc_service._pending_operation
    session['should_reset_display'] = calc_service._should_reset_display
    session['last_first_operand'] = calc_service._last_first_operand
    session['last_second_operand'] = calc_service._last_second_operand
    
    return jsonify({
        'display': calc_service.display,
        'history': history_service.get_all_as_dicts()
    })


@app.route('/api/clear', methods=['POST'])
def handle_clear():
    """Handle clear button click."""
    calc_service = get_calculator_service()
    calc_service.handle_clear()
    
    # Clear session state
    session['calculator_display'] = '0'
    session['first_operand'] = None
    session['second_operand'] = None
    session['pending_operation'] = None
    session['should_reset_display'] = False
    session['last_first_operand'] = ''
    session['last_second_operand'] = ''
    
    return jsonify({'display': '0'})


@app.route('/api/theme/toggle', methods=['POST'])
def toggle_theme():
    """Toggle the theme."""
    theme_service = get_theme_service()
    theme_service.toggle_theme()
    
    # Save to session
    session['theme'] = theme_service.current_theme.value
    
    return jsonify({
        'theme_class': theme_service.theme_class,
        'theme_icon': theme_service.theme_toggle_icon
    })


@app.route('/api/history/clear', methods=['POST'])
def clear_history():
    """Clear the calculation history from database."""
    history_service = get_history_service()
    history_service.clear_history()
    return jsonify({'success': True})


@app.route('/api/history/replay/<int:index>', methods=['POST'])
def replay_calculation(index):
    """Replay a calculation from history."""
    history_service = get_history_service()
    result = history_service.replay_calculation(index)
    
    if result is not None:
        # Clear calculator and set display to result
        session['calculator_display'] = result
        session['first_operand'] = None
        session['second_operand'] = None
        session['pending_operation'] = None
        session['should_reset_display'] = False
        session['last_first_operand'] = ''
        session['last_second_operand'] = ''
        
        return jsonify({'display': result})
    
    return jsonify({'error': 'Invalid index'}), 400


if __name__ == '__main__':
    # Note: debug mode should only be used in development
    # For production deployment, use a production WSGI server like gunicorn
    import os
    debug_mode = os.environ.get('FLASK_DEBUG', 'False').lower() in ('true', '1', 'yes')
    app.run(debug=debug_mode, host='0.0.0.0', port=5000)
