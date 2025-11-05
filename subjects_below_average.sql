-- Setting SERVEROUTPUT ON is required to display output from DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

-- Anonymous PL/SQL block
BEGIN
    -- Informational message
    DBMS_OUTPUT.PUT_LINE('--- Subjects where the Class Average is below 80 ---');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    
    -- Cursor FOR loop to iterate over the results of the filtered aggregation query
    FOR subject_rec IN (
        SELECT
            subject,
            -- Calculate the average marks and round to two decimal places for display
            ROUND(AVG(marks), 2) AS average_marks
        FROM
            Results
        GROUP BY
            subject
        -- The HAVING clause filters groups (subjects) based on the calculated average
        HAVING
            AVG(marks) < 80
        ORDER BY
            subject -- Order the output alphabetically for clarity
    )
    LOOP
        -- Display the subject name and its average mark
        DBMS_OUTPUT.PUT_LINE('Subject: ' || RPAD(subject_rec.subject, 15) || ' Average: ' || subject_rec.average_marks);
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any potential errors
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
