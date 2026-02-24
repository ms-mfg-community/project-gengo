import { useEffect, useState } from 'react';
import UserProfileForm from '../components/UserProfileForm';

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

const ProfileEditPage = () => {
  const [initialData, setInitialData] = useState<UserProfile | undefined>(undefined);

  useEffect(() => {
    // Try to load existing profile from localStorage
    const savedProfile = localStorage.getItem('userProfile');
    if (savedProfile) {
      setInitialData(JSON.parse(savedProfile));
    } else {
      // Set default values for new profile
      setInitialData({
        id: Date.now().toString(),
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
    }
  }, []);

  if (!initialData) {
    return (
      <div className="home-container">
        <h2>Loading...</h2>
      </div>
    );
  }

  return (
    <div>
      <UserProfileForm initialData={initialData} />
    </div>
  );
};

export default ProfileEditPage;
