"""
Service that manages light/dark theme state.

This service handles theme toggling between light and dark modes and
provides utility methods for getting theme-related CSS classes and icons.
"""

from enum import Enum


class ThemeMode(Enum):
    """Theme enumeration."""
    LIGHT = "light"
    DARK = "dark"


class ThemeService:
    """
    Service that manages light/dark theme state.
    
    Provides methods to toggle between light and dark themes and retrieve
    theme-specific CSS classes and icons.
    """
    
    def __init__(self):
        """Initialize the theme service with light theme."""
        self._current_theme = ThemeMode.LIGHT
    
    @property
    def current_theme(self) -> ThemeMode:
        """
        Current theme mode.
        
        Returns:
            The current ThemeMode
        """
        return self._current_theme
    
    @current_theme.setter
    def current_theme(self, value: ThemeMode) -> None:
        """
        Set the current theme mode.
        
        Args:
            value: The ThemeMode to set
        """
        self._current_theme = value
    
    def toggle_theme(self) -> None:
        """Toggles between light and dark theme."""
        if self._current_theme == ThemeMode.LIGHT:
            self._current_theme = ThemeMode.DARK
        else:
            self._current_theme = ThemeMode.LIGHT
    
    @property
    def theme_class(self) -> str:
        """
        Gets the CSS class name for the current theme.
        
        Returns:
            CSS class name (either "light-theme" or "dark-theme")
        """
        return "light-theme" if self._current_theme == ThemeMode.LIGHT else "dark-theme"
    
    @property
    def theme_toggle_icon(self) -> str:
        """
        Gets the icon for the theme toggle button.
        
        Returns:
            Icon string (moon for light theme, sun for dark theme)
        """
        return "🌙" if self._current_theme == ThemeMode.LIGHT else "☀️"
