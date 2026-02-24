import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Navigation from './components/Navigation';
import HomePage from './pages/HomePage';
import UserProfilePage from './pages/UserProfilePage';
import ProfileEditPage from './pages/ProfileEditPage';
import './App.css';

function App() {
  return (
    <BrowserRouter>
      <div className="app">
        <Navigation />
        <main className="main-content">
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/profile" element={<UserProfilePage />} />
            <Route path="/edit" element={<ProfileEditPage />} />
          </Routes>
        </main>
      </div>
    </BrowserRouter>
  );
}

export default App;
