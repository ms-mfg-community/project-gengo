namespace calculator.web.Services;

/// <summary>Service managing application theme (light/dark mode).</summary>
public class ThemeService
{
    private bool _isDarkMode = false;

    /// <summary>Event raised when theme changes.</summary>
    public event Action? OnThemeChanged;

    /// <summary>Gets current dark mode state.</summary>
    public bool IsDarkMode => _isDarkMode;

    /// <summary>Gets the CSS class for current theme.</summary>
    public string ThemeClass => _isDarkMode ? "dark-theme" : "light-theme";

    /// <summary>Toggles between light and dark mode.</summary>
    public void ToggleTheme()
    {
        _isDarkMode = !_isDarkMode;
        OnThemeChanged?.Invoke();
    }
}
