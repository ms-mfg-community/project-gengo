import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import UserProfileCard from '../components/UserProfileCard';

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

const UserProfilePage = () => {
  const navigate = useNavigate();
  const [profile, setProfile] = useState<UserProfile | null>(null);

  useEffect(() => {
    // Try to load profile from localStorage
    const savedProfile = localStorage.getItem('userProfile');
    if (savedProfile) {
      setProfile(JSON.parse(savedProfile));
    } else {
      // Default demo profile
      setProfile({
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '+1 (555) 123-4567',
        avatarUrl: 'https://via.placeholder.com/120',
        bio: 'Passionate software developer with expertise in React, TypeScript, and modern web technologies. Love building user-friendly applications.',
        location: 'San Francisco, CA',
        website: 'https://johndoe.dev',
        company: 'Tech Innovations Inc.',
        jobTitle: 'Senior Software Engineer',
        emailNotifications: true,
        profileVisibility: 'public',
        theme: 'light'
      });
    }
  }, []);

  if (!profile) {
    return (
      <div className="home-container">
        <h2>Loading profile...</h2>
      </div>
    );
  }

  return (
    <div>
      <UserProfileCard profile={profile} />
    </div>
  );
};

export default UserProfilePage;
