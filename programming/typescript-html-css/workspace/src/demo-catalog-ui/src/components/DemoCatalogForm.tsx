import React, { useState } from 'react';

const DemoCatalogForm: React.FC = () => {
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
        notes_feedback: '',
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
        <form onSubmit={handleSubmit}>
            <input type="number" name="id" value={formData.id} onChange={handleChange} placeholder="ID" required />
            <input type="number" name="points" value={formData.points} onChange={handleChange} placeholder="Points" required min="1" max="100" />
            <input type="text" name="category" value={formData.category} onChange={handleChange} placeholder="Category" />
            <input type="text" name="sub_category" value={formData.sub_category} onChange={handleChange} placeholder="Sub Category" />
            <input type="text" name="language" value={formData.language} onChange={handleChange} placeholder="Language" />
            <input type="text" name="role" value={formData.role} onChange={handleChange} placeholder="Role" />
            <input type="text" name="person" value={formData.person} onChange={handleChange} placeholder="Person" />
            <input type="text" name="ide_type" value={formData.ide_type} onChange={handleChange} placeholder="IDE Type" required />
            <input type="text" name="prompt_type" value={formData.prompt_type} onChange={handleChange} placeholder="Prompt Type" required />
            <input type="text" name="shot_type" value={formData.shot_type} onChange={handleChange} placeholder="Shot Type" required />
            <input type="checkbox" name="is_test" checked={formData.is_test} onChange={handleChange} /> Is Test
            <input type="text" name="test_type" value={formData.test_type} onChange={handleChange} placeholder="Test Type" required />
            <input type="number" name="epoch" value={formData.epoch} onChange={handleChange} placeholder="Epoch" required min="0" max="10" />
            <input type="number" name="confidence_percent" value={formData.confidence_percent} onChange={handleChange} placeholder="Confidence Percent" required min="10" max="100" />
            <input type="text" name="scenario" value={formData.scenario} onChange={handleChange} placeholder="Scenario" />
            <input type="text" name="github_org" value={formData.github_org} onChange={handleChange} placeholder="GitHub Org" />
            <input type="text" name="reference" value={formData.reference} onChange={handleChange} placeholder="Reference" />
            <input type="text" name="notes_feedback" value={formData.notes_feedback} onChange={handleChange} placeholder="Notes/Feedback" />
            <input type="text" name="data_source" value={formData.data_source} onChange={handleChange} placeholder="Data Source" />
            <button type="submit">Submit</button>
        </form>
    );
};

export default DemoCatalogForm;
