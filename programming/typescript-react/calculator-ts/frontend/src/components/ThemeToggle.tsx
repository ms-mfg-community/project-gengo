import React from 'react';
import { themeService } from '../services/ThemeService';

interface ThemeToggleProps {
  onToggle?: (theme: 'light' | 'dark') => void;
}

export const ThemeToggle: React.FC<ThemeToggleProps> = ({ onToggle }) => {
  const [theme, setTheme] = React.useState(themeService.getCurrentTheme());

  const handleToggle = () => {
    const newTheme = themeService.toggleTheme();
    setTheme(newTheme);
    onToggle?.(newTheme);
  };

  return (
    <button
      className="btn btn-theme-toggle"
      onClick={handleToggle}
      title={`Switch to ${theme === 'light' ? 'dark' : 'light'} theme`}
      aria-label={`Switch to ${theme === 'light' ? 'dark' : 'light'} theme`}
    >
      {themeService.getToggleIcon()}
    </button>
  );
};
