let display = document.getElementById('display');

function clearDisplay() {
	display.innerText = '0';
}

function appendToDisplay(value) {
	if (display.innerText === '0') {
		display.innerText = value;
	} else {
		display.innerText += value;
	}
}

function calculateResult() {
	try {
		display.innerText = eval(display.innerText);
	} catch (e) {
		display.innerText = 'Error';
	}
}