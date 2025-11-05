-- Setting SERVEROUTPUT ON is required to display output from DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

-- Anonymous PL/SQL block
DECLARE
    -- Variable to hold the specific subject name (based on the sample input)
    v_subject CONSTANT VARCHAR2(20) := 'DBMS';
    -- Variable to hold the minimum required score
    v_min_score CONSTANT NUMBER := 75;
BEGIN
    -- Informational message
    DBMS_OUTPUT.PUT_LINE('--- Students who scored > ' || v_min_score || ' in ' || v_subject || ' ---');
    
    -- Cursor FOR loop to retrieve and display student name and marks
    FOR student_rec IN (
        SELECT
            s.name,
            r.marks
        FROM
            Students s
        JOIN
            Results r ON s.student_id = r.student_id
        WHERE
            r.subject = v_subject AND r.marks > v_min_score
    )
    LOOP
        -- Output the name and marks in the required format: Riya Sharma 85
        DBMS_OUTPUT.PUT_LINE(student_rec.name || ' ' || student_rec.marks);
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any potential errors
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
