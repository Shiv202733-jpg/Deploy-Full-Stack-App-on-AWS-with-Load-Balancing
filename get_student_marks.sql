-- Setting SERVEROUTPUT ON is required to display output from DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

-- Anonymous PL/SQL block
DECLARE
    -- Variable to hold the specific subject name (Input based on Sample Test Case 1)
    v_subject CONSTANT VARCHAR2(20) := 'DBMS';
BEGIN
    -- Informational message
    DBMS_OUTPUT.PUT_LINE('--- Results for Subject: ' || v_subject || ' ---');
    
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
            r.subject = v_subject
    )
    LOOP
        -- Output the name and marks in the required format: Riya Sharma 85
        DBMS_OUTPUT.PUT_LINE(student_rec.name || ' ' || student_rec.marks);
    END LOOP;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No students found for subject: ' || v_subject);
    WHEN OTHERS THEN
        -- Handle any other potential errors
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
