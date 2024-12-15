-- a. Create a stored procedure that gives all employees of “First Bank Corporation” a 10 percent raise.
CREATE OR REPLACE PROCEDURE GiveRaise_FirstBank()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Works
    SET salary = salary * 1.10
    WHERE company_name = 'First Bank Corporation';
    
    RAISE NOTICE '10 percent raise applied to employees of First Bank Corporation';
END;
$$;

CALL GiveRaise_FirstBank();

-- b. Create a stored procedure that deletes all employees who work for “Small Bank Corporation”.
CREATE OR REPLACE PROCEDURE DeleteEmployees_SmallBank()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Delete entries in the Manages table where the employee works for Small Bank Corporation
    DELETE FROM Manages
    WHERE employee_name IN (
        SELECT employee_name
        FROM Works
        WHERE company_name = 'Small Bank Corporation'
    );

    -- Delete employees from the Works table who work for Small Bank Corporation
    DELETE FROM Works
    WHERE company_name = 'Small Bank Corporation';

    -- Delete employees from the Employee table who no longer have records in Works
    DELETE FROM Employee
    WHERE employee_name NOT IN (SELECT employee_name FROM Works);

    RAISE NOTICE 'Employees of Small Bank Corporation deleted successfully';
END;
$$;


CALL DeleteEmployees_SmallBank();