--account_table
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000001', 'savings', 'ABC1234567', 1, 20000.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000002', 'current', 'DEF9876543', 2, 0.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000003', 'current', 'GHI1236540', 1, 3500.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000004', 'savings', 'FRE4520036', 3, 9550.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000005', 'savings', 'DFR5256642', 2, 4250.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000006', 'savings', 'JKL1548200', 3, 4500.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000007', 'savings', 'MNO4523691', 1, 25000.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000008', 'savings', 'PQR4526801', 3, 15000.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000009', 'savings', 'STU4523160', 3, 4000.00);
INSERT INTO defaultdb.account (account_number, type, customer_NIC, branch_code, balance) VALUES ('0000000010', 'savings', 'VXZ4598992', 1, 2000.00);

--branch_table
INSERT INTO defaultdb.branch (branch_code, branch_name, address) VALUES (1, 'Main Branch', '123 Main Street');
INSERT INTO defaultdb.branch (branch_code, branch_name, address) VALUES (2, 'Downtown Branch', '456 Downtown Avenue');
INSERT INTO defaultdb.branch (branch_code, branch_name, address) VALUES (3, 'CSS Branch', '452 CSS Street');
INSERT INTO defaultdb.branch (branch_code, branch_name, address) VALUES (4, 'Uptown Branch', '392 Lower Street');

--customer_table
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('ABC1234567', 'John Doe', '1990-01-15', '555-1234', 'john@example.com', 1);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('DEF9876543', 'Jane Smith', '1985-05-20', '555-5678', 'jane@example.com', 2);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('DFR5256642', 'Alex Styles', '1996-10-16', '555-8742', 'alex@example.com', 1);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('FRE4520036', 'Rose Steeves', '1996-10-30', '555-6542', 'rose@example.com', 1);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('GHI1236540', 'Sue Sams', '2010-10-14', '555-4562', 'sue@example.com', 1);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('JKL1548200', 'Jack Steeves', '2000-10-06', '555-1569', 'jack@example.com', 1);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('MNO4523691', 'Sam Cruize', '1999-10-17', '555-4511', 'sam@example.com', 1);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('PQR4526801', 'Rasa Dias', '2000-10-19', '555-5487', 'rasa@example.com', 1);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('STU4523160', 'Anne Rozane', '1991-10-13', '555-8960', 'anne@example.com', 2);
INSERT INTO defaultdb.customer (customer_NIC, name, date_of_birth, telephone_number, email, customer_type_id) VALUES ('VXZ4598992', 'Joe Smith', '1998-10-14', '555-6452', 'joe@example.com', 1);

--customer_or_employee_table
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('ABC1234567');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('DEF9876543');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('DFR5256642');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP123456');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP451120');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP452001');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP452100');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP452107');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP452368');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP453692');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP456621');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('EMP987654');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('FRE4520036');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('GHI1236540');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('JKL1548200');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('MNO4523691');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('PQR4526801');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('STU4523160');
INSERT INTO defaultdb.customer_or_employee (NIC) VALUES ('VXZ4598992');

--customer_type_table
INSERT INTO defaultdb.customer_type (type_id, type_name) VALUES (1, 'Personal');
INSERT INTO defaultdb.customer_type (type_id, type_name) VALUES (2, 'organization');

--employee_table
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP123456', 1, 'Manager John', '555-1000', 1, 'manager1@example.com');
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP451120', 3, 'Employee Kim', '555-9000', 2, 'emp6@example.com');
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP452001', 1, 'Employee Tim', '555-3000', 2, 'emp1@example.com');
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP452100', 3, 'Manager Raze', '555-7000', 1, 'manager3@example.com');
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP452107', 2, 'Employee Tom', '555-5000', 2, 'emp3@example.com');
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP452368', 1, 'Employee Timothy', '555-4000', 2, 'emp2@example.com');
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP453692', 2, 'Employee Sue', '555-6000', 2, 'emp4@example.com');
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP456621', 3, 'Employee Ann', '555-8000', 2, 'emp5@example.com');
INSERT INTO defaultdb.employee (employee_NIC, branch_code, name, telephone_number, position_id, email) VALUES ('EMP987654', 2, 'Manager Sarah', '555-2000', 1, 'manager2@example.com');

--FD_plan_table
INSERT INTO defaultdb.FD_plan (plan_id, time_in_months, interest_rate) VALUES ('1', 6, 0.13);
INSERT INTO defaultdb.FD_plan (plan_id, time_in_months, interest_rate) VALUES ('2', 12, 0.14);
INSERT INTO defaultdb.FD_plan (plan_id, time_in_months, interest_rate) VALUES ('3', 36, 0.15);

--fixed_deposit_table
INSERT INTO defaultdb.fixedDeposit (FD_id, saving_account_number, amount, plan_id, starting_date) VALUES ('aeb389fc-6d4b-11ee-96e2-5a8b282da960', '0000000001', 100000.00, '2', '2023-10-18');
INSERT INTO defaultdb.fixedDeposit (FD_id, saving_account_number, amount, plan_id, starting_date) VALUES ('dacf9819-6d4a-11ee-96e2-5a8b282da960', '0000000006', 400000.00, '2', '2023-10-18');
INSERT INTO defaultdb.fixedDeposit (FD_id, saving_account_number, amount, plan_id, starting_date) VALUES ('dd3b9039-6d4a-11ee-96e2-5a8b282da960', '0000000007', 200000.00, '1', '2023-10-18');
INSERT INTO defaultdb.fixedDeposit (FD_id, saving_account_number, amount, plan_id, starting_date) VALUES ('df901ac0-6d4a-11ee-96e2-5a8b282da960', '0000000008', 500000.00, '3', '2023-10-18');
INSERT INTO defaultdb.fixedDeposit (FD_id, saving_account_number, amount, plan_id, starting_date) VALUES ('e1e57da7-6d4a-11ee-96e2-5a8b282da960', '0000000009', 100000.00, '2', '2023-10-18');

--installment_table
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment1', 'Loan1', 500.00, 1, '2023-09-01');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment10', 'Loan5', 1000.00, 0, '2023-10-04');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment11', 'Loan2', 5000.00, 1, '2023-10-05');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment12', 'Loan5', 2000.00, 1, '2023-10-01');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment13', 'Loan4', 500.00, 0, '2023-10-02');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment14', 'Loan3', 1000.00, 1, '2023-10-04');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment2', 'Loan1', 500.00, 0, '2023-10-01');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment3', 'Loan2', 1000.00, 1, '2024-03-01');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment4', 'Loan2', 1000.00, 0, '2024-06-01');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment5', 'Loan3', 2000.00, 0, '2023-10-02');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment6', 'Loan3', 1000.00, 1, '2023-10-02');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment7', 'Loan1', 500.00, 1, '2023-10-03');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment8', 'Loan5', 1000.00, 1, '2023-08-08');
INSERT INTO defaultdb.installment (installment_id, loan_id, amount_due, paid, due_date) VALUES ('Installment9', 'Loan4', 2000.00, 0, '2023-10-09');

--loan_table
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, braINSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan1', 5000.00, 0.08, 12, 1, 'physical', 'ABC1234567', 12, 1, '2023-09-04');
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan2', 10000.00, 0.07, 24, 0, 'online', 'DEF9876543', 24, 2, '2023-09-05');
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan3', 15000.00, 0.10, 36, 0, 'physical', 'FRE4520036', 10, 3, '2023-08-30');
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan4', 5000.00, 0.07, 12, 1, 'online', 'MNO4523691', 12, 2, '2023-09-05');
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan5', 10000.00, 0.08, 24, 1, 'physical', 'PQR4526801', 24, 1, '2023-09-13');
nch_code, starting_date) VALUES ('Loan1', 5000.00, 0.08, 12, 1, 'physical', 'ABC1234567', 12, 1, '2023-09-04');
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan2', 10000.00, 0.07, 24, 0, 'online', 'DEF9876543', 24, 2, '2023-09-05');
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan3', 15000.00, 0.10, 36, 0, 'physical', 'FRE4520036', 10, 3, '2023-08-30');
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan4', 5000.00, 0.07, 12, 1, 'online', 'MNO4523691', 12, 2, '2023-09-05');
INSERT INTO defaultdb.loan (loan_id, amount, interest_rate, loan_period, approved, request_type, customer_NIC, remaining_installments, branch_code, starting_date) VALUES ('Loan5', 10000.00, 0.08, 24, 1, 'physical', 'PQR4526801', 24, 1, '2023-09-13');

--online_requested_loan_table
INSERT INTO defaultdb.online_requested_loan (loan_id, FD_id) VALUES ('Loan2', 'dacf9819-6d4a-11ee-96e2-5a8b282da960');
INSERT INTO defaultdb.online_requested_loan (loan_id, FD_id) VALUES ('Loan4', 'dd3b9039-6d4a-11ee-96e2-5a8b282da960');


--position_table
INSERT INTO defaultdb.position (position_id, position_name) VALUES (1, 'branch_manager');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (2, 'Loan Officer');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (3, 'Financial Advisor');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (4, 'Teller');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (5, 'Risk Analyst');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (6, 'Compliance Officer');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (7, 'IT staff');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (8, 'HR personal');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (9, 'Customer Service Representative');
INSERT INTO defaultdb.position (position_id, position_name) VALUES (10, 'Operation staff');

--saving_account_table
INSERT INTO defaultdb.saving_account (account_number, plan_id) VALUES ('0000000001', 1);
INSERT INTO defaultdb.saving_account (account_number, plan_id) VALUES ('0000000008', 1);
INSERT INTO defaultdb.saving_account (account_number, plan_id) VALUES ('0000000004', 2);
INSERT INTO defaultdb.saving_account (account_number, plan_id) VALUES ('0000000009', 2);
INSERT INTO defaultdb.saving_account (account_number, plan_id) VALUES ('0000000005', 3);
INSERT INTO defaultdb.saving_account (account_number, plan_id) VALUES ('0000000006', 3);
INSERT INTO defaultdb.saving_account (account_number, plan_id) VALUES ('0000000010', 3);
INSERT INTO defaultdb.saving_account (account_number, plan_id) VALUES ('0000000007', 4);

--saving_plan_table
INSERT INTO defaultdb.saving_plan (plan_id, name, interest_rate, minimum_deposit) VALUES (1, 'Children', 0.12, 0.00);
INSERT INTO defaultdb.saving_plan (plan_id, name, interest_rate, minimum_deposit) VALUES (2, 'Teen', 0.11, 500.00);
INSERT INTO defaultdb.saving_plan (plan_id, name, interest_rate, minimum_deposit) VALUES (3, 'Adult', 0.10, 1000.00);
INSERT INTO defaultdb.saving_plan (plan_id, name, interest_rate, minimum_deposit) VALUES (4, 'Senior', 0.13, 1000.00);

--transaction_table
INSERT INTO defaultdb.transaction (transaction_id, sender_account_number, receiver_account_number, transfer_amount, transaction_date, transaction_time) VALUES ('02e8a7e4-6c40-11ee-96e2-5a8b282da960', '0000000001', '0000000005', 1000.00, '2023-10-16', '16:21:07');
INSERT INTO defaultdb.transaction (transaction_id, sender_account_number, receiver_account_number, transfer_amount, transaction_date, transaction_time) VALUES ('1b24c956-6c45-11ee-96e2-5a8b282da960', '0000000006', '0000000002', 100.00, '2023-10-16', '16:57:35');
INSERT INTO defaultdb.transaction (transaction_id, sender_account_number, receiver_account_number, transfer_amount, transaction_date, transaction_time) VALUES ('1d8eb82d-6c45-11ee-96e2-5a8b282da960', '0000000001', '0000000002', 500.00, '2023-10-16', '16:57:39');
INSERT INTO defaultdb.transaction (transaction_id, sender_account_number, receiver_account_number, transfer_amount, transaction_date, transaction_time) VALUES ('1ffbc7ca-6c45-11ee-96e2-5a8b282da960', '0000000003', '0000000004', 6000.00, '2023-10-16', '16:57:44');
INSERT INTO defaultdb.transaction (transaction_id, sender_account_number, receiver_account_number, transfer_amount, transaction_date, transaction_time) VALUES ('6066b761-6c45-11ee-96e2-5a8b282da960', '0000000001', '0000000010', 1000.00, '2023-10-16', '16:59:32');
INSERT INTO defaultdb.transaction (transaction_id, sender_account_number, receiver_account_number, transfer_amount, transaction_date, transaction_time) VALUES ('a3c0f923-6c51-11ee-96e2-5a8b282da960', '0000000005', '0000000001', 1000.00, '2023-10-16', '18:27:19');
INSERT INTO defaultdb.transaction (transaction_id, sender_account_number, receiver_account_number, transfer_amount, transaction_date, transaction_time) VALUES ('e95e331f-6c44-11ee-96e2-5a8b282da960', '0000000005', '0000000001', 2000.00, '2023-10-16', '16:56:12');

--user_table
INSERT INTO defaultdb.user (user_NIC, username, password_hash, user_type) VALUES ('ABC1234567', 'John', 'dsfdfghjgf', 'customer');
INSERT INTO defaultdb.user (user_NIC, username, password_hash, user_type) VALUES ('DEF9876543', 'Jane', 'dsfdfgfdghjgf', 'customer');
INSERT INTO defaultdb.user (user_NIC, username, password_hash, user_type) VALUES ('DFR5256642', 'Alex', 'dfsghrtykukjhg', 'customer');
INSERT INTO defaultdb.user (user_NIC, username, password_hash, user_type) VALUES ('FRE4520036', 'Rose', 'dfehbgfvsvbf', 'customer');
INSERT INTO defaultdb.user (user_NIC, username, password_hash, user_type) VALUES ('GHI1236540', 'Sue', 'gfhf-rtrhbf', 'customer');
INSERT INTO defaultdb.user (user_NIC, username, password_hash, user_type) VALUES ('JKL1548200', 'Jack', 'wejhncmkwo', 'customer');

--withdrwal_table
INSERT INTO defaultdb.withdrawal (withdrawal_id, account_number, withdrawal_amount, withdrawal_date, withdrawal_time) VALUES ('712bfc2f-6d48-11ee-96e2-5a8b282da960', '0000000002', 1000.00, '2023-10-17', '23:53:59');
INSERT INTO defaultdb.withdrawal (withdrawal_id, account_number, withdrawal_amount, withdrawal_date, withdrawal_time) VALUES ('76014d7d-6d48-11ee-96e2-5a8b282da960', '0000000003', 500.00, '2023-10-17', '23:54:07');
INSERT INTO defaultdb.withdrawal (withdrawal_id, account_number, withdrawal_amount, withdrawal_date, withdrawal_time) VALUES ('7856ad7d-6d48-11ee-96e2-5a8b282da960', '0000000004', 2000.00, '2023-10-17', '23:54:11');
INSERT INTO defaultdb.withdrawal (withdrawal_id, account_number, withdrawal_amount, withdrawal_date, withdrawal_time) VALUES ('7ab16916-6d48-11ee-96e2-5a8b282da960', '0000000005', 750.00, '2023-10-17', '23:54:15');
INSERT INTO defaultdb.withdrawal (withdrawal_id, account_number, withdrawal_amount, withdrawal_date, withdrawal_time) VALUES ('7cfdcbc5-6d47-11ee-96e2-5a8b282da960', '0000000002', 1000.00, '2023-10-17', '23:47:10');
INSERT INTO defaultdb.withdrawal (withdrawal_id, account_number, withdrawal_amount, withdrawal_date, withdrawal_time) VALUES ('7d16d936-6d48-11ee-96e2-5a8b282da960', '0000000006', 5500.00, '2023-10-17', '23:54:19');
INSERT INTO defaultdb.withdrawal (withdrawal_id, account_number, withdrawal_amount, withdrawal_date, withdrawal_time) VALUES ('7f7b6ec7-6d48-11ee-96e2-5a8b282da960', '0000000007', 20000.00, '2023-10-17', '23:54:23');
