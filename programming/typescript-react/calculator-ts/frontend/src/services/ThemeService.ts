import { ThemeMode } from '../models';

/**
 * Theme Service - Manages light/dark theme state
 */
export class ThemeService {
  private currentTheme: ThemeMode = 'light';
  private listeners: ((theme: ThemeMode) => void)[] = [];

  constructor() {
    // Load from localStorage if available
    const saved = localStorage.getItem('calculator-theme') as ThemeMode;
    if (saved && (saved === 'light' || saved === 'dark')) {
      this.currentTheme = saved;
    }
    // Apply to document
    this.applyTheme();
  }

  /**
   * Get current theme
   */
  getCurrentTheme(): ThemeMode {
    return this.currentTheme;
  }

  /**
   * Get CSS class for current theme
   */
  getThemeClass(): string {
    return `${this.currentTheme}-theme`;
  }

  /**
   * Get theme toggle icon
   */
  getToggleIcon(): string {
    return this.currentTheme === 'light' ? '🌙' : '☀️';
  }

  /**
   * Toggle theme and persist
   */
  toggleTheme(): ThemeMode {
    this.currentTheme = this.currentTheme === 'light' ? 'dark' : 'light';
    localStorage.setItem('calculator-theme', this.currentTheme);
    this.applyTheme();
    this.notifyListeners();
    return this.currentTheme;
  }

  /**
   * Apply theme to document
   */
  private applyTheme(): void {
    document.documentElement.className = this.getThemeClass();
  }

  /**
   * Subscribe to theme changes
   */
  subscribe(listener: (theme: ThemeMode) => void): () => void {
    this.listeners.push(listener);
    return () => {
      this.listeners = this.listeners.filter(l => l !== listener);
    };
  }

  /**
   * Notify all listeners
   */
  private notifyListeners(): void {
    this.listeners.forEach(listener => listener(this.currentTheme));
  }
}

export const themeService = new ThemeService();
