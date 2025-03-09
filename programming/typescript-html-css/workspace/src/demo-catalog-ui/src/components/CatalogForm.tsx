import React, { useState } from 'react';

const CatalogForm: React.FC = () => {
    const [formData, setFormData] = useState({
        id: '',
        points: '',
        category: '',
        sub_category: '',
        language: '',
        role: '',
        person: '',
        ide_type: '',
        prompt_type: '',
        shot_type: '',
        is_test: false,
        test_type: '',
        epoch: '',
        confidence_percent: '',
        scenario: '',
        github_org: '',
        reference: '',
        data_source: ''
    });

    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { name, value, type } = e.target;
        setFormData({
            ...formData,
            [name]: value
        });
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        // Send formData to the backend
        const response = await fetch('/api/demo-catalog-ui', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        });
        if (response.ok) {
            alert('Data submitted successfully');
        } else {
            alert('Failed to submit data');
        }
    };

    return (
        <form onSubmit={handleSubmit} className="catalog-form">
            <div className="form-group">
                <label htmlFor="id">ID:</label>
                <input type="number" id="id" name="id" value={formData.id} onChange={handleChange} placeholder="ID" required />
            </div>

            <div className="form-group">
                <label htmlFor="points">Points:</label>
                <input type="number" id="points" name="points" value={formData.points} onChange={handleChange} placeholder="Points" required min="1" max="100" />
            </div>

            <div className="form-group">
                <label htmlFor="category">Category:</label>
                <input type="text" id="category" name="category" value={formData.category} onChange={handleChange} placeholder="Category" />
            </div>

            <div className="form-group">
                <label htmlFor="sub_category">Sub Category:</label>
                <input type="text" id="sub_category" name="sub_category" value={formData.sub_category} onChange={handleChange} placeholder="Sub Category" />
            </div>

            <div className="form-group">
                <label htmlFor="language">Language:</label>
                <input type="text" id="language" name="language" value={formData.language} onChange={handleChange} placeholder="Language" />
            </div>

            <div className="form-group">
                <label htmlFor="role">Role:</label>
                <input type="text" id="role" name="role" value={formData.role} onChange={handleChange} placeholder="Role" />
            </div>

            <div className="form-group">
                <label htmlFor="person">Person:</label>
                <input type="text" id="person" name="person" value={formData.person} onChange={handleChange} placeholder="Person" />
            </div>

            <div className="form-group">
                <label htmlFor="ide_type">IDE Type:</label>
                <input type="text" id="ide_type" name="ide_type" value={formData.ide_type} onChange={handleChange} placeholder="IDE Type" required />
            </div>

            <div className="form-group">
                <label htmlFor="prompt_type">Prompt Type:</label>
                <input type="text" id="prompt_type" name="prompt_type" value={formData.prompt_type} onChange={handleChange} placeholder="Prompt Type" required />
            </div>

            <div className="form-group">
                <label htmlFor="shot_type">Shot Type:</label>
                <input type="text" id="shot_type" name="shot_type" value={formData.shot_type} onChange={handleChange} placeholder="Shot Type" required />
            </div>

            <div className="form-group checkbox-group">
                <label htmlFor="is_test">Is Test:</label>
                <input type="checkbox" id="is_test" name="is_test" checked={formData.is_test} onChange={handleChange} />
            </div>

            <div className="form-group">
                <label htmlFor="test_type">Test Type:</label>
                <input type="text" id="test_type" name="test_type" value={formData.test_type} onChange={handleChange} placeholder="Test Type" required />
            </div>

            <div className="form-group">
                <label htmlFor="epoch">Epoch:</label>
                <input type="number" id="epoch" name="epoch" value={formData.epoch} onChange={handleChange} placeholder="Epoch" required min="0" max="10" />
            </div>

            <div className="form-group">
                <label htmlFor="confidence_percent">Confidence Percent:</label>
                <input type="number" id="confidence_percent" name="confidence_percent" value={formData.confidence_percent} onChange={handleChange} placeholder="Confidence Percent" required min="10" max="100" />
            </div>

            <div className="form-group">
                <label htmlFor="scenario">Scenario:</label>
                <input type="text" id="scenario" name="scenario" value={formData.scenario} onChange={handleChange} placeholder="Scenario" />
            </div>

            <div className="form-group">
                <label htmlFor="github_org">GitHub Org:</label>
                <input type="text" id="github_org" name="github_org" value={formData.github_org} onChange={handleChange} placeholder="GitHub Org" />
            </div>

            <div className="form-group">
                <label htmlFor="reference">Reference:</label>
                <input type="text" id="reference" name="reference" value={formData.reference} onChange={handleChange} placeholder="Reference" />
            </div>

            <div className="form-group">
                <label htmlFor="data_source">Data Source:</label>
                <input type="text" id="data_source" name="data_source" value={formData.data_source} onChange={handleChange} placeholder="Data Source" />
            </div>

            <div className="form-group">
                <button type="submit">Submit</button>
            </div>
        </form>
    );
};

export default CatalogForm;
