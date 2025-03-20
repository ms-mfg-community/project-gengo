import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import './App.css';
import HomePage from './pages/HomePage';
import CatalogFormPage from './pages/CatalogFormPage';
import DatabaseQueryPage from './pages/DatabaseQueryPage';

const App = () => {
  return (
    <Router>
      <div className="app-container">
        <nav>
          <ul className="nav-links">
            <li>
              <Link to="/">Home</Link>
            </li>
            <li>
              <Link to="/catalog-form">Catalog Form</Link>
            </li>
            <li>
              <Link to="/database-query">Database Query</Link>
            </li>
          </ul>
        </nav>

        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/catalog-form" element={<CatalogFormPage />} />
          <Route path="/database-query" element={<DatabaseQueryPage />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;
