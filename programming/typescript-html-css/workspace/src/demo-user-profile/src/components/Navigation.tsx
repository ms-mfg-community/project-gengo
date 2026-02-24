import { NavLink } from 'react-router-dom';

const Navigation = () => {
  return (
    <nav>
      <ul>
        <li>
          <NavLink to="/" className={({ isActive }) => isActive ? 'active' : ''}>
            Home
          </NavLink>
        </li>
        <li>
          <NavLink to="/profile" className={({ isActive }) => isActive ? 'active' : ''}>
            View Profile
          </NavLink>
        </li>
        <li>
          <NavLink to="/edit" className={({ isActive }) => isActive ? 'active' : ''}>
            Edit Profile
          </NavLink>
        </li>
      </ul>
    </nav>
  );
};

export default Navigation;
