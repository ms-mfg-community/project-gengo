import React from 'react';
import CatalogForm from '../components/CatalogForm';
import '../styles/Form.css'; // Import the new Form.css styles

const CatalogFormPage: React.FC = () => {
  return (
    <div className="page">
      <h2 style={{ textAlign: 'center' }}>Catalog Form</h2>
      <p style={{ textAlign: 'center' }}>Submit a new entry to the catalog database.</p>
      <CatalogForm />
    </div>
  );
};

export default CatalogFormPage;