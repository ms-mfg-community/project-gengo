# User Profile Management UI Implementation Guide

This document provides a step-by-step guide to creating a user profile management UI with React, TypeScript, and modern CSS. Each section includes prompts that can be used to implement specific features.

## 1. Project Setup and Configuration

### 1.1. Initialize the React TypeScript Project with Vite

- [ ] **Prompt:**

```bash
Create a new React TypeScript project named "demo-user-profile" using Vite as the build tool. Set up ESLint for TypeScript and include React dependencies.
```

- Install dependencies: React, React DOM, TypeScript, Vite, ESLint
- Configure TypeScript for strict type checking
- Set up a basic project structure with src directory

### 1.2. Create Basic App Component Structure

- [ ] **Prompt:**

```bash
Create a basic React application structure with an App component that displays a header and some placeholder content for a user profile management system.
```

- Create App.tsx with a functional component
- Add basic styling with App.css
- Import assets and set up the main component layout

## 2. Creating a Multi-Page Application with Routing

### 2.1. Install React Router

- [ ] **Prompt:**

```bash
Install react-router-dom and implement basic routing in the application with a home page, user profile view page, and a profile edit page.
```

- Install react-router-dom
- Set up BrowserRouter in main entry point

### 2.2. Create Page Components

- [ ] **Prompt:**

```bash
Create separate page components for the Home page, UserProfile page, and ProfileEdit page. Set up navigation between these pages.
```

- Create HomePage.tsx
- Create UserProfilePage.tsx
- Create ProfileEditPage.tsx
- Set up routes in App.tsx

### 2.3. Set Up Router Configuration

- [ ] **Prompt:**

```bash
Configure React Router to handle navigation between home, profile view, and profile edit pages with appropriate routes.
```

```typescript
import { BrowserRouter, Routes, Route } from 'react-router-dom';
```

### 2.4. Style the Navigation

- [ ] **Prompt:**

```bash
Create a responsive navigation bar component with links to home, view profile, and edit profile pages. Style it with modern CSS.
```

- Create Navigation component
- Add CSS for responsive design
- Include active link styling

## 3. Creating the User Profile Form Component

### 3.1. Basic Form Structure

- [ ] **Prompt:**

```bash
Create a UserProfileForm component with a comprehensive form structure that includes fields for personal information, contact details, and preferences.
```

- Create src/components/UserProfileForm.tsx
- Set up form with submit handler
- Add initial state management with useState

### 3.2. Setting Up Form State

- [ ] **Prompt:**

```bash
Implement form state management using React useState hook to track all profile fields including text inputs, email, phone, avatar URL, bio, and preferences.
```

```typescript
const [formData, setFormData] = useState({
  id: '',
  firstName: '',
  lastName: '',
  email: '',
  phone: '',
  avatarUrl: '',
  bio: '',
  location: '',
  website: '',
  company: '',
  jobTitle: '',
  emailNotifications: true,
  profileVisibility: 'public',
  theme: 'light'
});
```

### 3.3. Form Input Handlers

- [ ] **Prompt:**

```bash
Create change handlers for the form inputs that update the form state when users interact with the fields, including text inputs, checkboxes, and select dropdowns.
```

```typescript
const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
  const { name, value, type } = e.target as HTMLInputElement;
  
  setFormData({
    ...formData,
    [name]: type === 'checkbox' ? (e.target as HTMLInputElement).checked : value
  });
};
```

### 3.4. Form Submission Handler

- [ ] **Prompt:**

```bash
Implement a form submission handler that validates the data and sends it to a backend API endpoint for saving user profile information.
```

```typescript
const handleSubmit = async (e: React.FormEvent) => {
  e.preventDefault();
  // Validate and submit formData
  const response = await fetch('/api/user-profile', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(formData)
  });
};
```

## 4. Enhancing Form Usability and Accessibility

### 4.1. Adding Labels to Form Fields

- [ ] **Prompt:**

```bash
Add descriptive labels to each form field to improve usability and accessibility. Ensure all inputs are properly labeled with htmlFor attributes.
```

- Wrap each input in a form group
- Add labels with htmlFor attributes that match input IDs
- Structure the form for readability

### 4.2. Adding Validation

- [ ] **Prompt:**

```bash
Add client-side validation to the profile form including email format validation, required fields, and phone number format checking.
```

```typescript
const validateEmail = (email: string) => {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
};

const validateForm = () => {
  const errors: string[] = [];
  if (!formData.firstName) errors.push('First name is required');
  if (!formData.email || !validateEmail(formData.email)) errors.push('Valid email is required');
  return errors;
};
```

### 4.3. Adding Error Display

- [ ] **Prompt:**

```bash
Create a mechanism to display validation errors to users in a user-friendly way, showing error messages near the relevant form fields.
```

- Add error state management
- Display inline error messages
- Style error states appropriately

## 5. Creating the Profile View Component

### 5.1. Profile Display Card

- [ ] **Prompt:**

```bash
Create a UserProfileCard component that displays user profile information in a visually appealing card format with avatar, name, bio, and contact information.
```

- Create UserProfileCard.tsx
- Display avatar image
- Show user information in organized sections
- Add responsive card styling

### 5.2. Profile Actions

- [ ] **Prompt:**

```bash
Add action buttons to the profile view including Edit Profile, Share Profile, and Download vCard functionality.
```

```typescript
const ProfileActions = () => (
  <div className="profile-actions">
    <button onClick={handleEdit}>Edit Profile</button>
    <button onClick={handleShare}>Share Profile</button>
    <button onClick={handleDownloadVCard}>Download vCard</button>
  </div>
);
```

## 6. Adding Advanced Features

### 6.1. Avatar Upload

- [ ] **Prompt:**

```bash
Implement an avatar image upload feature that allows users to upload a profile picture, preview it before saving, and store the image URL.
```

```typescript
const handleAvatarUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
  const file = e.target.files?.[0];
  if (file) {
    const reader = new FileReader();
    reader.onloadend = () => {
      setFormData({ ...formData, avatarUrl: reader.result as string });
    };
    reader.readAsDataURL(file);
  }
};
```

### 6.2. Theme Preferences

- [ ] **Prompt:**

```bash
Add theme preference settings (light/dark mode) to the user profile with a toggle switch and save the preference to localStorage.
```

- Create theme toggle component
- Implement theme switching logic
- Persist theme preference
- Apply theme styles dynamically

### 6.3. Privacy Settings

- [ ] **Prompt:**

```bash
Implement privacy settings allowing users to control profile visibility (public, private, contacts only) and notification preferences.
```

```typescript
<select name="profileVisibility" value={formData.profileVisibility} onChange={handleChange}>
  <option value="public">Public</option>
  <option value="private">Private</option>
  <option value="contacts">Contacts Only</option>
</select>
```

## 7. Styling and Responsiveness

### 7.1. Modern CSS Styling

- [ ] **Prompt:**

```bash
Apply modern CSS styling to the user profile application using flexbox and grid layouts, with a clean and professional design aesthetic.
```

- Use CSS variables for theming
- Implement responsive grid layouts
- Add smooth transitions and hover effects
- Ensure mobile-first responsive design

### 7.2. Mobile Responsiveness

- [ ] **Prompt:**

```bash
Ensure the user profile interface is fully responsive and works well on mobile devices, tablets, and desktop screens.
```

```css
@media (max-width: 768px) {
  .profile-container {
    flex-direction: column;
    padding: 1rem;
  }
}
```

## 8. Data Management and API Integration

### 8.1. Fetching User Data

- [ ] **Prompt:**

```bash
Implement functionality to fetch existing user profile data from a backend API when the profile page loads.
```

```typescript
useEffect(() => {
  const fetchUserProfile = async () => {
    const response = await fetch('/api/user-profile');
    const data = await response.json();
    setFormData(data);
  };
  fetchUserProfile();
}, []);
```

### 8.2. Update Profile API

- [ ] **Prompt:**

```bash
Create an API endpoint handler for updating user profile information with proper error handling and success feedback.
```

- Handle PUT/PATCH requests
- Show loading states during submission
- Display success/error messages
- Handle network errors gracefully

## 9. Summary and Best Practices

### 9.1. Project Structure Best Practices

- [ ] **Prompt:**

```bash
Organize the project following React best practices with appropriate file structure and component organization.
```

```text
demo-user-profile/
├── src/
│   ├── components/
│   │   ├── UserProfileForm.tsx
│   │   ├── UserProfileCard.tsx
│   │   ├── Navigation.tsx
│   │   └── AvatarUpload.tsx
│   ├── pages/
│   │   ├── HomePage.tsx
│   │   ├── UserProfilePage.tsx
│   │   └── ProfileEditPage.tsx
│   ├── styles/
│   │   ├── profile.css
│   │   └── theme.css
│   ├── utils/
│   │   └── validation.ts
│   ├── App.tsx
│   ├── App.css
│   └── main.tsx
```

### 9.2. TypeScript Type Safety

- [ ] **Prompt:**

```bash
Ensure proper TypeScript typing throughout the application to maintain type safety and developer experience.
```

- Define interfaces for user profile data
- Use proper event types for handlers
- Leverage TypeScript for better IDE support and error catching

### 9.3. Security Considerations

- [ ] **Prompt:**

```bash
Implement security best practices including input sanitization, XSS prevention, and secure data handling for user profiles.
```

- Sanitize user inputs
- Use HTTPS for API calls
- Implement CSRF protection
- Validate data on both client and server

### 9.4. Documentation

- [ ] **Prompt:**

```bash
Document the application with appropriate comments and documentation to make it maintainable.
```

- Add JSDoc comments for components and functions
- Document complex logic and algorithm choices
- Provide setup and usage instructions in README

---

This implementation guide provides a structured approach to creating a responsive, accessible, and feature-rich user profile management UI using React and TypeScript. Each section includes practical prompts that can be used to implement specific parts of the application incrementally.
