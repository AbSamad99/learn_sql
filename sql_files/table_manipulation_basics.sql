-- Create the table if it does'nt exist
CREATE TABLE IF NOT EXISTS job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_name VARCHAR(255),
    status VARCHAR(50)
);
-- Insert a value into the table
INSERT INTO job_applied (
        job_id,
        application_sent_date,
        custom_resume,
        resume_file_name,
        cover_letter_sent,
        cover_letter_name,
        status
    )
VALUES (
        1,
        '2024-08-01',
        TRUE,
        'resume_custom_101.pdf',
        TRUE,
        'cover_letter_101.pdf',
        'Pending'
    ),
    (
        2,
        '2024-08-03',
        FALSE,
        'resume_standard.pdf',
        FALSE,
        NULL,
        'Interview Scheduled'
    ),
    (
        3,
        '2024-08-05',
        TRUE,
        'resume_custom_103.pdf',
        TRUE,
        'cover_letter_103.docx',
        'Rejected'
    ),
    (
        4,
        '2024-08-07',
        FALSE,
        'resume_standard.pdf',
        TRUE,
        'cover_letter_104.pdf',
        'Offer Received'
    ),
    (
        5,
        '2024-08-10',
        TRUE,
        'resume_custom_105.pdf',
        FALSE,
        NULL,
        'Awaiting Response'
    );
-- Fetch all the values from the table
SELECT *
FROM job_applied;
-- Alter the table to add a column
ALTER TABLE job_applied
ADD contact VARCHAR(50);
-- Update the table to set contact based on job_id
UPDATE job_applied
SET contact = 'Abdussamad Syed'
WHERE job_id = 1;
-- Update the table to set contact for all rows
UPDATE job_applied
SET contact = 'Abdussamad Syed';
-- Rename the column we added
ALTER TABLE job_applied
    RENAME COLUMN contact TO contact_name;
-- Alter the column type to text
ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;
-- Drop the column
ALTER TABLE job_applied DROP COLUMN contact_name;
-- Drop the table
DROP TABLE job_applied;