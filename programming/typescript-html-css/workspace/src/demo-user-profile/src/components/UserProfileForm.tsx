import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

interface UserProfile {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
  avatarUrl: string;
  bio: string;
  location: string;
  website: string;
  company: string;
  jobTitle: string;
  emailNotifications: boolean;
  profileVisibility: string;
  theme: string;
}

interface UserProfileFormProps {
  initialData?: UserProfile;
  onSubmit?: (data: UserProfile) => void;
}

const UserProfileForm: React.FC<UserProfileFormProps> = ({ initialData, onSubmit }) => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState<UserProfile>(initialData || {
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

  const [errors, setErrors] = useState<string[]>([]);
  const [successMessage, setSuccessMessage] = useState<string>('');

  const validateEmail = (email: string): boolean => {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  };

  const validateForm = (): string[] => {
    const validationErrors: string[] = [];
    
    if (!formData.firstName.trim()) {
      validationErrors.push('First name is required');
    }
    
    if (!formData.lastName.trim()) {
      validationErrors.push('Last name is required');
    }
    
    if (!formData.email.trim()) {
      validationErrors.push('Email is required');
    } else if (!validateEmail(formData.email)) {
      validationErrors.push('Email must be a valid email address');
    }
    
    if (formData.website && !formData.website.startsWith('http')) {
      validationErrors.push('Website must start with http:// or https://');
    }
    
    return validationErrors;
  };

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>
  ) => {
    const { name, value, type } = e.target as HTMLInputElement;
    
    setFormData({
      ...formData,
      [name]: type === 'checkbox' ? (e.target as HTMLInputElement).checked : value
    });
    
    // Clear errors when user starts typing
    if (errors.length > 0) {
      setErrors([]);
    }
  };

  const handleAvatarUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      // Validate file type
      if (!file.type.startsWith('image/')) {
        setErrors(['Please select an image file']);
        return;
      }
      
      // Validate file size (max 2MB)
      if (file.size > 2 * 1024 * 1024) {
        setErrors(['Image size must be less than 2MB']);
        return;
      }
      
      const reader = new FileReader();
      reader.onloadend = () => {
        setFormData({ ...formData, avatarUrl: reader.result as string });
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    const validationErrors = validateForm();
    if (validationErrors.length > 0) {
      setErrors(validationErrors);
      return;
    }
    
    setErrors([]);
    
    try {
      // Simulate API call
      if (onSubmit) {
        onSubmit(formData);
      } else {
        // Save to localStorage for demo purposes
        localStorage.setItem('userProfile', JSON.stringify(formData));
        setSuccessMessage('Profile saved successfully!');
        
        setTimeout(() => {
          navigate('/profile');
        }, 1500);
      }
    } catch (error) {
      setErrors(['Failed to save profile. Please try again.']);
    }
  };

  const handleCancel = () => {
    navigate('/profile');
  };

  return (
    <form className="profile-form" onSubmit={handleSubmit}>
      <h2>Edit Profile</h2>
      
      {successMessage && (
        <div className="success-message">{successMessage}</div>
      )}
      
      {errors.length > 0 && (
        <div className="error-message">
          <ul>
            {errors.map((error, index) => (
              <li key={index}>{error}</li>
            ))}
          </ul>
        </div>
      )}

      {/* Avatar Upload */}
      <div className="avatar-upload">
        {formData.avatarUrl && (
          <img
            src={formData.avatarUrl}
            alt="Avatar preview"
            className="avatar"
          />
        )}
        <input
          type="file"
          id="avatar-upload"
          accept="image/*"
          onChange={handleAvatarUpload}
        />
        <label htmlFor="avatar-upload">
          {formData.avatarUrl ? 'Change Avatar' : 'Upload Avatar'}
        </label>
      </div>

      {/* Personal Information */}
      <div className="form-section">
        <h3>Personal Information</h3>
        <div className="form-grid">
          <div className="form-group">
            <label htmlFor="firstName">First Name *</label>
            <input
              type="text"
              id="firstName"
              name="firstName"
              value={formData.firstName}
              onChange={handleChange}
              required
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="lastName">Last Name *</label>
            <input
              type="text"
              id="lastName"
              name="lastName"
              value={formData.lastName}
              onChange={handleChange}
              required
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="email">Email *</label>
            <input
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              required
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="phone">Phone</label>
            <input
              type="tel"
              id="phone"
              name="phone"
              value={formData.phone}
              onChange={handleChange}
              placeholder="+1 (555) 123-4567"
            />
          </div>
          
          <div className="form-group full-width">
            <label htmlFor="bio">Bio</label>
            <textarea
              id="bio"
              name="bio"
              value={formData.bio}
              onChange={handleChange}
              placeholder="Tell us about yourself..."
            />
          </div>
        </div>
      </div>

      {/* Professional Information */}
      <div className="form-section">
        <h3>Professional Information</h3>
        <div className="form-grid">
          <div className="form-group">
            <label htmlFor="jobTitle">Job Title</label>
            <input
              type="text"
              id="jobTitle"
              name="jobTitle"
              value={formData.jobTitle}
              onChange={handleChange}
              placeholder="Software Engineer"
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="company">Company</label>
            <input
              type="text"
              id="company"
              name="company"
              value={formData.company}
              onChange={handleChange}
              placeholder="Acme Corp"
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="location">Location</label>
            <input
              type="text"
              id="location"
              name="location"
              value={formData.location}
              onChange={handleChange}
              placeholder="San Francisco, CA"
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="website">Website</label>
            <input
              type="url"
              id="website"
              name="website"
              value={formData.website}
              onChange={handleChange}
              placeholder="https://example.com"
            />
          </div>
        </div>
      </div>

      {/* Preferences */}
      <div className="form-section">
        <h3>Preferences</h3>
        <div className="form-grid">
          <div className="form-group">
            <label htmlFor="profileVisibility">Profile Visibility</label>
            <select
              id="profileVisibility"
              name="profileVisibility"
              value={formData.profileVisibility}
              onChange={handleChange}
            >
              <option value="public">Public</option>
              <option value="private">Private</option>
              <option value="contacts">Contacts Only</option>
            </select>
          </div>
          
          <div className="form-group">
            <label htmlFor="theme">Theme</label>
            <select
              id="theme"
              name="theme"
              value={formData.theme}
              onChange={handleChange}
            >
              <option value="light">Light</option>
              <option value="dark">Dark</option>
              <option value="auto">Auto</option>
            </select>
          </div>
          
          <div className="form-group checkbox-group">
            <input
              type="checkbox"
              id="emailNotifications"
              name="emailNotifications"
              checked={formData.emailNotifications}
              onChange={handleChange}
            />
            <label htmlFor="emailNotifications">
              Enable email notifications
            </label>
          </div>
        </div>
      </div>

      <div className="form-actions">
        <button type="button" onClick={handleCancel}>
          Cancel
        </button>
        <button type="submit">
          Save Profile
        </button>
      </div>
    </form>
  );
};

export default UserProfileForm;
