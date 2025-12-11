namespace CalculatorWeb.Services;

/// <summary>
/// Service that manages light/dark theme state
/// </summary>
public class ThemeService
{
    /// <summary>
    /// Theme enumeration
    /// </summary>
    public enum ThemeMode
    {
        Light,
        Dark
    }

    private ThemeMode _currentTheme = ThemeMode.Light;

    /// <summary>
    /// Current theme mode
    /// </summary>
    public ThemeMode CurrentTheme
    {
        get => _currentTheme;
        private set => _currentTheme = value;
    }

    /// <summary>
    /// Event raised when theme changes
    /// </summary>
    public event Action? OnThemeChanged;

    /// <summary>
    /// Toggles between light and dark theme
    /// </summary>
    public void ToggleTheme()
    {
        CurrentTheme = CurrentTheme == ThemeMode.Light ? ThemeMode.Dark : ThemeMode.Light;
        OnThemeChanged?.Invoke();
    }

    /// <summary>
    /// Gets the CSS class name for the current theme
    /// </summary>
    public string ThemeClass => CurrentTheme == ThemeMode.Light ? "light-theme" : "dark-theme";

    /// <summary>
    /// Gets the icon name for the theme toggle button
    /// </summary>
    public string ThemeToggleIcon => CurrentTheme == ThemeMode.Light ? "🌙" : "☀️";
}
