#Ex 01
DELIMITER ###
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name
	FROM employees
	WHERE salary > 35000
	ORDER BY first_name, last_name, employee_id;
END###

CALL usp_get_employees_salary_above_35000;	

#Ex 02

CREATE PROCEDURE usp_get_employees_salary_above(min_salary_to_show DECIMAL(10,4))
BEGIN 
	SELECT first_name, last_name
    FROM employees
    WHERE salary >= min_salary_to_show
    ORDER BY first_name, last_name, employee_id;
END###

CALL usp_get_employees_salary_above(45000)###
#Ex 03

CREATE PROCEDURE usp_get_towns_starting_with(town_name_starts_with VARCHAR(50))
BEGIN
	SELECT `name` AS town_name
    FROM towns
    WHERE LOWER(LEFT(`name`, CHAR_LENGTH(town_name_starts_with))) = LOWER(town_name_starts_with)
    ORDER BY `name`;
END###

CALL usp_get_towns_starting_with('b')###

#Ex 04

CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	
    SELECT e.first_name, e.last_name
    FROM employees AS e
    JOIN addresses AS a ON e.address_id = a.address_id
    JOIN towns AS t ON a.town_id = t.town_id
    WHERE t.`name` = town_name
    ORDER BY e.first_name, e.last_name, e.employee_id;
    
END###

CALL usp_get_employee_from_town('Sofia');###

#Ex 05

CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(12,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(20);
    CASE
		WHEN salary < 30000 THEN RETURN 'Low';
        WHEN salary BETWEEN 30000 AND 50000 THEN RETURN 'Average';
        ELSE RETURN 'High';
	END CASE;
END###

SELECT ufn_get_salary_level(125500)###

#Ex 06

CREATE PROCEDURE usp_get_employees_by_salary_level(level_of_salary VARCHAR(10))
BEGIN
	SELECT first_name, last_name
    FROM employees
	WHERE 
    (CASE 
		WHEN LOWER(level_of_salary) = 'low' THEN salary < 30000
        WHEN LOWER(level_of_salary) = 'average' THEN salary BETWEEN 30000 AND 50000
        WHEN LOWER(level_of_salary) = 'high' THEN salary > 50000
	END)
    ORDER BY first_name DESC, last_name DESC;
END###

CALL usp_get_employee_by_salary_level('hiGH')###

#Ex 07

CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word varchar(50))
RETURNS BIT
DETERMINISTIC
BEGIN
	RETURN (SELECT word REGEXP(CONCAT('^[',set_of_letters,']+$')));
END###

SELECT ufn_is_word_comprised('oistmiahf', 'halves')###

#Ex 08

CREATE PROCEDURE usp_get_holders_full_name() 
BEGIN
	
    SELECT CONCAT(first_name, ' ', last_name) AS full_name
    FROM account_holders
    ORDER BY full_name, id;
    
END###

CALL usp_get_holders_full_name###

#Ex 09

CREATE PROCEDURE usp_get_holders_with_balance_higher_than(min_balance DECIMAL(19,4))
BEGIN
	
    SELECT first_name, last_name
    FROM account_holders AS ah
    JOIN accounts AS a ON a.account_holder_id = ah.id
    GROUP BY ah.id
    HAVING SUM(balance) > min_balance
    ORDER BY ah.id ASC;
    
END###

CALL usp_get_holders_with_balance_higher_than(6000000)###

#Ex 10

CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19,4), yearly_interest_rate DOUBLE, number_of_years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN

	RETURN sum * (POW(1 + yearly_interest_rate, number_of_years));
    
END###

SELECT ufn_calculate_future_value(1000, 0.5, 5)###

#Ex 11

CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, inerest_rate DECIMAL(19,4))
BEGIN

		SELECT a.id AS account_id, first_name, last_name, balance AS current_balance, 
        ufn_calculate_future_value(a.balance, inerest_rate, 5) AS balance_in_5_years
        FROM accounts AS a
        JOIN account_holders AS ah ON account_holder_id = ah.id
        WHERE a.id = account_id;
        
END###

CALL usp_calculate_future_value_for_account(1, 0.1)###

#Ex 12

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN

	START TRANSACTION;
    IF money_amount <= 0
    THEN ROLLBACK;
    ELSE 
    UPDATE accounts
    SET balance = balance + money_amount
    WHERE id = account_id;
    END IF;
    
END###

CALL usp_deposit_money(1, -22)###

#Ex 13

CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN

	START TRANSACTION;
    IF (SELECT balance FROM accounts WHERE id = account_id) >= money_amount
    AND money_amount > 0
    THEN 
    UPDATE accounts SET balance = balance - money_amount WHERE id = account_id;
    COMMIT;
    ELSE 
    ROLLBACK;
    END IF;
    
END###

CALL usp_withdraw_money(1, 10)###
SELECT * FROM accounts WHERE id = 1###

#Ex 14

CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
BEGIN

	IF (amount > 0)
    AND ((SELECT id FROM accounts WHERE id = from_account_id) IS NOT NULL)
    AND ((SELECT id FROM accounts WHERE id = to_account_id) IS NOT NULL)
    THEN 
    START TRANSACTION;
    
		UPDATE accounts
        SET balance = balance - amount
        WHERE id = from_account_id;
        
        UPDATE accounts
        SET balance = balance + amount
        WHERE id = to_account_id;
        
		IF ((SELECT balance FROM accounts WHERE id = from_account_id) < 0)
        THEN ROLLBACK;
        ELSE COMMIT;
        
        END IF;
    
    END IF;
END###

CALL usp_transfer_money(1, 2, 10)###

SELECT * FROM accounts WHERE id IN (1,2)###

#Ex 15

CREATE TABLE logs(
log_id INT PRIMARY KEY AUTO_INCREMENT,
account_id INT NOT NULL,
old_sum DECIMAL(19,4) NOT NULL,
new_sum DECIMAL(19,4) NOT NULL)###

CREATE TRIGGER accounts_after_balance_update AFTER UPDATE ON accounts FOR EACH ROW
BEGIN

	INSERT INTO `logs` (account_id, old_sum, new_sum)
	VALUES
    (OLD.id, OLD.balance, NEW.balance);    
    
END###

SELECT * FROM accounts WHERE id = 6###

UPDATE accounts
SET balance = balance + 300
WHERE id = 6###

#Ex 16

CREATE TABLE notification_emails(
id INT PRIMARY KEY AUTO_INCREMENT,
recipient INT,
`subject` VARCHAR(50),
body VARCHAR(100)
)###

CREATE TRIGGER tr_new_log_added_notification_email AFTER INSERT ON `logs` FOR EACH ROW
BEGIN

	INSERT INTO notification_emails (recipient, subject, body)
    VALUES (NEW.account_id, CONCAT('Balance change for account: ', NEW.account_id), CONCAT_WS(' ', 'On date', CURRENT_TIMESTAMP, 'your balance was changed from', NEW.old_sum, 'to', NEW.new_sum));
    
END###

SELECT * FROM notification_emails###