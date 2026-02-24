import { useNavigate } from 'react-router-dom';

const HomePage = () => {
  const navigate = useNavigate();

  return (
    <div className="home-container">
      <h1>User Profile Management</h1>
      <p>
        Welcome to the User Profile Management demo application. 
        This application demonstrates a complete user profile system built with React and TypeScript.
      </p>
      <div className="home-actions">
        <button onClick={() => navigate('/profile')}>
          View Profile
        </button>
        <button onClick={() => navigate('/edit')}>
          Edit Profile
        </button>
      </div>
      
      <div style={{ marginTop: '3rem', textAlign: 'left', maxWidth: '600px', margin: '3rem auto' }}>
        <h2>Features</h2>
        <ul>
          <li>Complete user profile management</li>
          <li>Avatar image upload with preview</li>
          <li>Form validation with error handling</li>
          <li>Responsive design for all devices</li>
          <li>Theme preferences (light/dark mode)</li>
          <li>Privacy settings</li>
          <li>vCard export functionality</li>
          <li>Profile sharing capabilities</li>
        </ul>
      </div>
    </div>
  );
};

export default HomePage;
