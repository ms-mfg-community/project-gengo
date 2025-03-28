import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Navigation from './components/Navigation';
import HomePage from './pages/HomePage';
import CatalogFormPage from './pages/CatalogFormPage';
import DatabaseQueryPage from './pages/DatabaseQueryPage';
import DatabaseUpdatePage from './pages/DatabaseUpdatePage';
import SearchChat from './pages/SearchChat';
import './styles/App.css';
import './styles/Search.css';

const App: React.FC = () => {
  return (
    <BrowserRouter>
      <div className="app">
        <header className="app-header">
          <h1>Demo Catalog Search</h1>
          <Navigation />
        </header>
        
        <main>
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/catalog-form" element={<CatalogFormPage />} />
            <Route path="/database-query" element={<DatabaseQueryPage />} />
            <Route path="/database-update" element={<DatabaseUpdatePage />} />
            <Route path="/search-chat" element={<SearchChat />} />
          </Routes>
        </main>
        
        <footer className="app-footer">
          <p>© {new Date().getFullYear()} Demo Catalog Search UI</p>
        </footer>
      </div>
    </BrowserRouter>
  );
};

export default App;
