#nullable enable

namespace calculator.web.Services;

/// <summary>
/// Manages light/dark theme state for the application.
/// Session-only; theme resets on page reload.
/// </summary>
public class ThemeService
{
    /// <summary>Gets whether dark mode is currently enabled.</summary>
    public bool IsDarkMode { get; private set; }

    /// <summary>Raised when the theme changes.</summary>
    public event Action? OnThemeChanged;

    /// <summary>
    /// Toggles between light and dark mode.
    /// </summary>
    public void Toggle()
    {
        IsDarkMode = !IsDarkMode;
        OnThemeChanged?.Invoke();
    }

    /// <summary>
    /// Returns the CSS class name for the current theme.
    /// </summary>
    public string ThemeClass => IsDarkMode ? "theme-dark" : "theme-light";
}
