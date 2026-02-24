# User Profile Management Demo

A modern, responsive user profile management application built with React, TypeScript, and Vite.

## Features

- ✨ Complete user profile management system
- 📸 Avatar image upload with preview
- ✅ Form validation with comprehensive error handling
- 📱 Fully responsive design for mobile, tablet, and desktop
- 🎨 Theme preferences (light/dark mode support)
- 🔒 Privacy settings and profile visibility controls
- 📇 vCard export functionality
- 🔗 Profile sharing capabilities
- 🎯 Clean and intuitive user interface

## Tech Stack

- **React 19** - UI library
- **TypeScript** - Type safety
- **Vite** - Build tool and dev server
- **React Router** - Client-side routing
- **CSS3** - Modern styling with flexbox and grid

## Getting Started

### Prerequisites

- Node.js 18+ installed
- npm or yarn package manager

### Installation

1. Install dependencies:

```bash
npm install
```

2. Start the development server:

```bash
npm run dev
```

3. Open your browser and navigate to `http://localhost:5174`

### Build for Production

```bash
npm run build
```

### Preview Production Build

```bash
npm run preview
```

## Project Structure

```
demo-user-profile/
├── src/
│   ├── components/
│   │   ├── Navigation.tsx          # Navigation bar component
│   │   ├── UserProfileCard.tsx     # Profile display card
│   │   └── UserProfileForm.tsx     # Profile editing form
│   ├── pages/
│   │   ├── HomePage.tsx            # Landing page
│   │   ├── UserProfilePage.tsx     # Profile view page
│   │   └── ProfileEditPage.tsx     # Profile edit page
│   ├── App.tsx                     # Main app component with routing
│   ├── App.css                     # Global styles
│   ├── main.tsx                    # App entry point
│   └── index.css                   # Base styles
├── index.html                      # HTML template
├── package.json                    # Dependencies and scripts
├── tsconfig.json                   # TypeScript configuration
├── vite.config.ts                  # Vite configuration
└── README.md                       # This file
```

## Usage

### Viewing a Profile

1. Navigate to the "View Profile" page
2. See the complete user profile with avatar, bio, and contact information
3. Use action buttons to edit, share, or download the profile

### Editing a Profile

1. Navigate to the "Edit Profile" page
2. Fill in or update profile information:
   - Personal details (name, email, phone)
   - Professional information (job title, company, location)
   - Bio and website
   - Avatar image upload
   - Privacy and notification preferences
3. Click "Save Profile" to save changes
4. Profile data is stored in localStorage for demo purposes

### Profile Actions

- **Edit Profile**: Navigate to the profile editing form
- **Share Profile**: Copy profile URL to clipboard
- **Download vCard**: Export profile as a .vcf file for contacts

## Form Validation

The application includes comprehensive client-side validation:

- Required fields: First Name, Last Name, Email
- Email format validation
- URL format validation for website
- Image file type and size validation (max 2MB)
- Real-time error display

## Responsive Design

The application is fully responsive and optimized for:

- Mobile devices (< 768px)
- Tablets (768px - 1024px)
- Desktop screens (> 1024px)

## Accessibility

- Semantic HTML elements
- Proper label associations
- Keyboard navigation support
- ARIA attributes where needed

## Data Storage

For demonstration purposes, profile data is stored in the browser's localStorage. In a production environment, this would be replaced with API calls to a backend server.

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## Development

### Linting

```bash
npm run lint
```

### Type Checking

TypeScript is configured with strict mode for maximum type safety.

## Future Enhancements

- Backend API integration
- User authentication
- Profile search and discovery
- Social media integration
- Activity feed
- Profile analytics

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
