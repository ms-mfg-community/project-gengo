import { useState } from 'react'
import './App.css'
import Calculator from './pages/Calculator'
import QueryTestData from './pages/QueryTestData'

function App() {
  const [activePage, setActivePage] = useState<'calculator' | 'queryData'>('calculator')

  return (
    <div className="app-container">
      <nav className="app-navigation">
        <button 
          className={activePage === 'calculator' ? 'active' : ''}
          onClick={() => setActivePage('calculator')}
          style={{ color: 'black' }}
        >
          Calculator
        </button>
        <button 
          className={activePage === 'queryData' ? 'active' : ''}
          onClick={() => setActivePage('queryData')}
          style={{ color: 'black' }}
        >
          Query Test Data
        </button>
      </nav>
      
      {activePage === 'calculator' && <Calculator />}
      {activePage === 'queryData' && <QueryTestData />}
    </div>
  )
}

export default App
