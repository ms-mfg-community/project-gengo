# Demo Catalog UI Implementation Guide

This document provides a step-by-step guide to creating a catalog form UI with React, TypeScript, and modern CSS. Each section includes prompts that can be used to implement specific features.

## 1. Project Setup and Configuration

### 1.1. Initialize the React TypeScript Project with Vite

- [] **Prompt:**

```bash
Create a new React TypeScript project named "demo-catalog-ui" using Vite as the build tool. Set up ESLint for TypeScript and include React dependencies.
```

- Install dependencies: React, React DOM, TypeScript, Vite, ESLint
- Configure TypeScript for strict type checking
- Set up a basic project structure with src directory

### 1.2. Create Basic App Component Structure

- [] **Prompt:**

```bash
Create a basic React application structure with an App component that displays a header and some placeholder content.
```

- Create App.tsx with a functional component
- Add basic styling with App.css
- Import assets and set up the main component layout

## 2. Creating a Multi-Page Application with Routing

### 2.1. Install React Router

- [] **Prompt:**

```bash
Install react-router-dom and implement basic routing in the application with a home page and a separate page for the catalog form.
```

- Install react-router-dom
- Set up BrowserRouter in main entry point

### 2.2. Create Page Components

- [] **Prompt:**

```bash
Create separate page components for the Home page and the CatalogForm page. Move existing content from App.tsx to these components.
```

- Create src/pages/HomePage.tsx
- Create src/pages/CatalogFormPage.tsx
- Move appropriate content to each page

### 2.3. Set Up Router Configuration

- [] **Prompt:**

```bash
Implement routing in the App component with Routes and Route components. Add navigation links between pages.
```

```typescript
<Router>
  <div className="app-container">
    <nav>
      <ul className="nav-links">
        <li><Link to="/">Home</Link></li>
        <li><Link to="/catalog-form">Catalog Form</Link></li>
      </ul>
    </nav>

    <Routes>
      <Route path="/" element={<HomePage />} />
      <Route path="/catalog-form" element={<CatalogFormPage />} />
    </Routes>
  </div>
</Router>
```

### 2.4. Style the Navigation

- [] **Prompt:**

```bash
Add CSS styles for the navigation links and overall layout to make the multi-page application visually appealing and functional.
```

- Style the navigation bar, links, and layout
- Add responsive design elements
- Implement hover effects for better user interaction

## 3. Creating the Catalog Form Component

### 3.1. Basic Form Structure

- [] **Prompt:**

```bash
Create a CatalogForm component with a basic form structure that includes various input fields for collecting catalog entries.
```

- Create src/components/CatalogForm.tsx
- Set up form with submit handler
- Add initial state management with useState

### 3.2. Setting Up Form State

- [] **Prompt:**

```bash
Implement form state management using React useState hook to track all form fields including text inputs, numbers, and a checkbox.
```

```typescript
const [formData, setFormData] = useState({
  id: "",
  points: "",
  category: "",
  sub_category: "",
  language: "",
  role: "",
  person: "",
  ide_type: "",
  prompt_type: "",
  shot_type: "",
  is_test: false,
  test_type: "",
  epoch: "",
  confidence_percent: "",
  scenario: "",
  github_org: "",
  reference: "",
  data_source: "",
});
```

### 3.3. Form Input Handlers

- [] **Prompt:**

```bash
Create change handlers for the form inputs that update the form state when users interact with the fields.
```

```typescript
const handleChange = (
  e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>,
) => {
  const { name, value } = e.target;
  setFormData({
    ...formData,
    [name]: value,
  });
};
```

### 3.4. Form Submission Handler

- [] **Prompt:**

```bash
Implement a form submission handler that sends the form data to a backend API endpoint.
```

```typescript
const handleSubmit = async (e: React.FormEvent) => {
  e.preventDefault();
  const response = await fetch("/api/demo-catalog-ui", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(formData),
  });
  if (response.ok) {
    alert("Data submitted successfully");
  } else {
    alert("Failed to submit data");
  }
};
```

## 4. Enhancing Form Usability and Accessibility

### 4.1. Adding Labels to Form Fields

- [] **Prompt:**

```bash
Add descriptive labels to each form field to improve usability and accessibility.
```

- Wrap each input in a form group
- Add labels with htmlFor attributes that match input IDs
- Structure the form for readability

### 4.2. Adding Tooltip Descriptions

- [] **Prompt:**

```bash
Add tooltip descriptions to each form field that appear when the user hovers over labels, providing more detailed information about what each field expects.
```

```typescript
<label htmlFor="points">
  Points: <span className="info-icon">ⓘ</span>
  <span className="tooltip-text">Score value using the SAFe modified Fibonacci sequence: [1, 2, 3, 5, 8, 13, 20, 40, 100]</span>
</label>
```

### 4.3. Styling Tooltips with CSS

- [] **Prompt:**

```bash
Style the tooltips to make them visually appealing and properly positioned when they appear on hover.
```

```css
.form-group label .tooltip-text {
  visibility: hidden;
  width: 200px;
  background-color: #333;
  color: #fff;
  text-align: left;
  border-radius: 6px;
  padding: 8px 12px;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -100px;
  opacity: 0;
  transition: opacity 0.3s;
}

.form-group label:hover .tooltip-text {
  visibility: visible;
  opacity: 1;
}
```

### 4.4. Adding Semantic Icons

- [] **Prompt:**

```bash
Add semantic icons to each form field to provide visual cues about the type of information expected.
```

```typescript
<label htmlFor="id">
  <span className="semantic-icon">🆔</span> ID: <span className="info-icon">ⓘ</span>
  <span className="tooltip-text">Unique identifier for this entry</span>
</label>
```

### 4.5. Styling the Form Layout

- [] **Prompt:**

```bash
Style the form with a responsive grid layout that works well on different screen sizes.
```

```css
.catalog-form {
  max-width: 800px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1rem;
  text-align: left;
}
```

## 5. Implementing Accessibility Features

### 5.1. Optimizing Color Contrast

- [] **Prompt:**

```bash
Optimize the color scheme for accessibility, ensuring sufficient contrast for users with color blindness or low vision.
```

- Update heading colors for better contrast
- Use WCAG-compliant color combinations
- Avoid problematic color combinations for color-blind users

### 5.2. Adding Additional Visual Cues

- [] **Prompt:**

```bash
Add additional visual cues beyond color to improve accessibility, such as text decoration and iconography.
```

```css
.nav-links a:hover {
  background-color: rgba(0, 80, 158, 0.1);
  text-decoration: underline;
}
```

### 5.3. Form Control Accessibility

- [] **Prompt:**

```bash
Enhance form controls for accessibility by adding appropriate ARIA attributes and ensuring keyboard navigability.
```

- Add required attributes for mandatory fields
- Ensure logical tab order
- Use descriptive labels and placeholder text

## 6. Final Styling and Polish

### 6.1. Consistent Styling Framework

- [] **Prompt:**

```bash
Apply consistent styling across the application to create a cohesive user experience.
```

- Standardize margins, paddings, and spacing
- Use a consistent color palette
- Apply typography rules consistently

### 6.2. Responsive Design Enhancements

- [] **Prompt:**

```bash
Enhance responsive design to ensure the application works well on mobile devices, tablets, and desktops.
```

- Test and optimize layout for different screen sizes
- Adjust form layout for smaller screens
- Ensure touch-friendly interface elements

### 6.3. Final Testing and Validation

- [] **Prompt:**

```bash
Test the application for accessibility, usability, and functionality across different browsers and devices.
```

- Validate HTML/CSS using appropriate tools
- Test with screen readers and accessibility tools
- Check form validation and error handling

## 7. Summary and Best Practices

### 7.1. Project Structure Best Practices

- [] **Prompt:**

```bash
Organize the project following React best practices with appropriate file structure and component organization.
```

```text
demo-catalog-ui/
├── src/
│   ├── components/
│   │   └── CatalogForm.tsx
│   ├── pages/
│   │   ├── HomePage.tsx
│   │   └── CatalogFormPage.tsx
│   ├── assets/
│   ├── App.tsx
│   ├── App.css
│   └── main.tsx
```

### 7.2. TypeScript Type Safety

- [] **Prompt:**

```bash
Ensure proper TypeScript typing throughout the application to maintain type safety and developer experience.
```

- Define interfaces for component props
- Use proper event types for handlers
- Leverage TypeScript for better IDE support and error catching

### 7.3. Documentation

- [] **Prompt:**

```bash
Document the application with appropriate comments and documentation to make it maintainable.
```

- Add JSDoc comments for components and functions
- Document complex logic and algorithm choices
- Provide setup and usage instructions in README

---

This implementation guide provides a structured approach to creating a responsive, accessible, and feature-rich catalog form UI using React and TypeScript. Each section includes practical prompts that can be used to implement specific parts of the application incrementally.

