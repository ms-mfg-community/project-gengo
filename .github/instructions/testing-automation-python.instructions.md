# Testing Automation Python.Instructions

---
applyTo: "**tests/**/*.py"
---

\n\nPython Testing Best Practices

When writing Python tests:

\n\nTest Structure Essentials

\n\nUse pytest as the primary testing framework
\n\nFollow AAA pattern: Arrange, Act, Assert
\n\nWrite descriptive test names that explain the behavior being tested
\n\nKeep tests focused on one specific behavior

\n\nKey Testing Practices

\n\nUse pytest fixtures for setup and teardown
\n\nMock external dependencies (databases, APIs, file operations)
\n\nUse parameterized tests for testing multiple similar scenarios
\n\nTest edge cases and error conditions, not just happy paths

\n\nExample Test Pattern

```python

import pytest

from unittest.mock import Mock, patch

class TestUserService:

    @pytest.fixture

    def user_service(self):

        return UserService()

    @pytest.mark.parametrize("invalid_email", ["", "invalid", "@test.com"])

    def test_should_reject_invalid_emails(self, user_service, invalid_email):

        with pytest.raises(ValueError, match="Invalid email"):

            user_service.create_user({"email": invalid_email})

    @patch('src.user_service.email_validator')

    def test_should_handle_validation_failure(self, mock_validator, user_service):

        mock_validator.validate.side_effect = ConnectionError()

        with pytest.raises(ConnectionError):

            user_service.create_user({"email": "test@example.com"})

```text
\n
