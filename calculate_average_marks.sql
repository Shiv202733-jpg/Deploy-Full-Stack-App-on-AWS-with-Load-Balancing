-- Setting SERVEROUTPUT ON is required to display output from DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

-- Anonymous PL/SQL block
DECLARE
    -- 1. Get the subject name from the user (simulated input)
    v_input_subject    VARCHAR2(20) := 'DBMS';
    
    -- Variable to store the uppercase subject name
    v_search_subject   VARCHAR2(20);
    
    -- Variable to hold the calculated and rounded average marks
    v_avg_marks        NUMBER;

BEGIN
    -- 2. Convert the subject name to uppercase
    v_search_subject := UPPER(v_input_subject);

    -- 3. Find all marks for that subject, calculate the average, and round it
    SELECT
        -- 4. Calculate the average of those marks.
        -- 5. Round the average to two decimal places.
        ROUND(AVG(marks), 2)
    INTO
        v_avg_marks
    FROM
        Results
    WHERE
        subject = v_search_subject;

    -- 6. Display the average marks as output.
    DBMS_OUTPUT.PUT_LINE(v_avg_marks);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- This handles the case if the SELECT statement returns no rows (i.e., the subject doesn't exist)
        DBMS_OUTPUT.PUT_LINE('No results or marks found for subject: ' || v_input_subject);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/
