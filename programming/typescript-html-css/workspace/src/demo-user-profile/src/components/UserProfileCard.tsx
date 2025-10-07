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

interface UserProfileCardProps {
  profile: UserProfile;
}

const UserProfileCard: React.FC<UserProfileCardProps> = ({ profile }) => {
  const navigate = useNavigate();

  const handleEdit = () => {
    navigate('/edit');
  };

  const handleShare = () => {
    const profileUrl = window.location.origin + '/profile';
    navigator.clipboard.writeText(profileUrl);
    alert('Profile URL copied to clipboard!');
  };

  const handleDownloadVCard = () => {
    const vcard = `BEGIN:VCARD
VERSION:3.0
FN:${profile.firstName} ${profile.lastName}
EMAIL:${profile.email}
TEL:${profile.phone}
ORG:${profile.company}
TITLE:${profile.jobTitle}
URL:${profile.website}
NOTE:${profile.bio}
END:VCARD`;

    const blob = new Blob([vcard], { type: 'text/vcard' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = `${profile.firstName}_${profile.lastName}.vcf`;
    link.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="profile-card">
      <div className="profile-header">
        <div className="avatar-container">
          <img
            src={profile.avatarUrl || 'https://via.placeholder.com/120'}
            alt={`${profile.firstName} ${profile.lastName}`}
            className="avatar"
          />
        </div>
        <div className="profile-info">
          <h2>{profile.firstName} {profile.lastName}</h2>
          <p className="job-title">{profile.jobTitle} {profile.company && `at ${profile.company}`}</p>
        </div>
      </div>

      {profile.bio && (
        <div className="profile-bio">
          <p>{profile.bio}</p>
        </div>
      )}

      <div className="profile-details">
        <div className="detail-item">
          <span className="detail-label">Email</span>
          <span className="detail-value">{profile.email}</span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Phone</span>
          <span className="detail-value">{profile.phone}</span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Location</span>
          <span className="detail-value">{profile.location || 'Not specified'}</span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Website</span>
          <span className="detail-value">
            {profile.website ? (
              <a href={profile.website} target="_blank" rel="noopener noreferrer">
                {profile.website}
              </a>
            ) : (
              'Not specified'
            )}
          </span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Profile Visibility</span>
          <span className="detail-value">{profile.profileVisibility}</span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Theme Preference</span>
          <span className="detail-value">{profile.theme}</span>
        </div>
      </div>

      <div className="profile-actions">
        <button onClick={handleEdit}>Edit Profile</button>
        <button onClick={handleShare}>Share Profile</button>
        <button onClick={handleDownloadVCard}>Download vCard</button>
      </div>
    </div>
  );
};

export default UserProfileCard;
