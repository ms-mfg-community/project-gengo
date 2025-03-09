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
        const { name, value } = e.target;
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
                <label htmlFor="id">
                    <span className="semantic-icon">🆔</span> ID: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Unique identifier for this entry</span>
                </label>
                <input type="number" id="id" name="id" value={formData.id} onChange={handleChange} placeholder="ID" required />
            </div>

            <div className="form-group">
                <label htmlFor="points">
                    <span className="semantic-icon">📊</span> Points: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Score value using the SAFe modified Fibonacci sequence: [1, 2, 3, 5, 8, 13, 20, 40, 100]</span>
                </label>
                <input type="number" id="points" name="points" value={formData.points} onChange={handleChange} placeholder="Points" required min="1" max="100" />
            </div>

            <div className="form-group">
                <label htmlFor="category">
                    <span className="semantic-icon">📁</span> Category: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Main classification category</span>
                </label>
                <input type="text" id="category" name="category" value={formData.category} onChange={handleChange} placeholder="Category" />
            </div>

            <div className="form-group">
                <label htmlFor="sub_category">
                    <span className="semantic-icon">📂</span> Sub Category: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Secondary classification within the main category</span>
                </label>
                <input type="text" id="sub_category" name="sub_category" value={formData.sub_category} onChange={handleChange} placeholder="Sub Category" />
            </div>

            <div className="form-group">
                <label htmlFor="language">
                    <span className="semantic-icon">💻</span> Language: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Programming or natural language used</span>
                </label>
                <input type="text" id="language" name="language" value={formData.language} onChange={handleChange} placeholder="Language" />
            </div>

            <div className="form-group">
                <label htmlFor="role">
                    <span className="semantic-icon">👤</span> Role: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">User role or persona</span>
                </label>
                <input type="text" id="role" name="role" value={formData.role} onChange={handleChange} placeholder="Role" />
            </div>

            <div className="form-group">
                <label htmlFor="person">
                    <span className="semantic-icon">👤</span> Person: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Individual associated with this entry</span>
                </label>
                <input type="text" id="person" name="person" value={formData.person} onChange={handleChange} placeholder="Person" />
            </div>

            <div className="form-group">
                <label htmlFor="ide_type">
                    <span className="semantic-icon">🖥️</span> IDE Type: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Type of Integrated Development Environment used</span>
                </label>
                <input type="text" id="ide_type" name="ide_type" value={formData.ide_type} onChange={handleChange} placeholder="IDE Type" required />
            </div>

            <div className="form-group">
                <label htmlFor="prompt_type">
                    <span className="semantic-icon">💬</span> Prompt Type: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Classification of the prompt structure</span>
                </label>
                <input type="text" id="prompt_type" name="prompt_type" value={formData.prompt_type} onChange={handleChange} placeholder="Prompt Type" required />
            </div>

            <div className="form-group">
                <label htmlFor="shot_type">
                    <span className="semantic-icon">🎯</span> Shot Type: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Zero-shot, few-shot, or other prompt methodology</span>
                </label>
                <input type="text" id="shot_type" name="shot_type" value={formData.shot_type} onChange={handleChange} placeholder="Shot Type" required />
            </div>

            <div className="form-group checkbox-group">
                <label htmlFor="is_test">
                    <span className="semantic-icon">✅</span> Is Test: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Whether this is a test entry</span>
                </label>
                <input type="checkbox" id="is_test" name="is_test" checked={formData.is_test} onChange={handleChange} />
            </div>

            <div className="form-group">
                <label htmlFor="test_type">
                    <span className="semantic-icon">🧪</span> Test Type: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Classification of the test if applicable</span>
                </label>
                <input type="text" id="test_type" name="test_type" value={formData.test_type} onChange={handleChange} placeholder="Test Type" required />
            </div>

            <div className="form-group">
                <label htmlFor="epoch">
                    <span className="semantic-icon">🕒</span> Epoch: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Training epoch number (0-10)</span>
                </label>
                <input type="number" id="epoch" name="epoch" value={formData.epoch} onChange={handleChange} placeholder="Epoch" required min="0" max="10" />
            </div>

            <div className="form-group">
                <label htmlFor="confidence_percent">
                    <span className="semantic-icon">📈</span> Confidence Percent: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Confidence level as a percentage (10-100)</span>
                </label>
                <input type="number" id="confidence_percent" name="confidence_percent" value={formData.confidence_percent} onChange={handleChange} placeholder="Confidence Percent" required min="10" max="100" />
            </div>

            <div className="form-group">
                <label htmlFor="scenario">
                    <span className="semantic-icon">📝</span> Scenario: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Use case or scenario description</span>
                </label>
                <input type="text" id="scenario" name="scenario" value={formData.scenario} onChange={handleChange} placeholder="Scenario" />
            </div>

            <div className="form-group">
                <label htmlFor="github_org">
                    <span className="semantic-icon">🐙</span> GitHub Org: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Associated GitHub organization</span>
                </label>
                <input type="text" id="github_org" name="github_org" value={formData.github_org} onChange={handleChange} placeholder="GitHub Org" />
            </div>

            <div className="form-group">
                <label htmlFor="reference">
                    <span className="semantic-icon">📚</span> Reference: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Reference document or citation</span>
                </label>
                <input type="text" id="reference" name="reference" value={formData.reference} onChange={handleChange} placeholder="Reference" />
            </div>

            <div className="form-group">
                <label htmlFor="data_source">
                    <span className="semantic-icon">💾</span> Data Source: <span className="info-icon">ⓘ</span>
                    <span className="tooltip-text">Origin of the data for this entry</span>
                </label>
                <input type="text" id="data_source" name="data_source" value={formData.data_source} onChange={handleChange} placeholder="Data Source" />
            </div>

            <div className="form-group">
                <button type="submit">Submit</button>
            </div>
        </form>
    );
};

export default CatalogForm;
