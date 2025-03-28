import React from 'react';
import { NavLink } from 'react-router-dom';
import '../styles/Navigation.css';

const Navigation: React.FC = () => {
  return (
    <nav className="navigation">
      <ul>
        <li>
          <NavLink to="/" className={({ isActive }) => isActive ? 'active' : ''}>
            Home
          </NavLink>
        </li>
        <li>
          <NavLink to="/catalog-form" className={({ isActive }) => isActive ? 'active' : ''}>
            Catalog Form
          </NavLink>
        </li>
        <li>
          <NavLink to="/database-query" className={({ isActive }) => isActive ? 'active' : ''}>
            Database Query
          </NavLink>
        </li>
        <li>
          <NavLink to="/database-update" className={({ isActive }) => isActive ? 'active' : ''}>
            Database Update
          </NavLink>
        </li>
        <li>
          <NavLink to="/search-chat" className={({ isActive }) => isActive ? 'active' : ''}>
            Search Chat
          </NavLink>
        </li>
      </ul>
    </nav>
  );
};

export default Navigation;