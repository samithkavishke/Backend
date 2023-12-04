-- create database
--creating tables
CREATE TABLE `customer_type` (
  `type_id` INT,
  `type_name` VARCHAR(20),
  PRIMARY KEY (`type_id`)
);

CREATE TABLE `online_requested_loan` (
  `loan_id` VARCHAR(36),
  `FD_id` VARCHAR(36),
  PRIMARY KEY (`loan_id`)
);

CREATE TABLE `saving_plan` (
  `plan_id` INT,
  `name` VARCHAR(10),
  `interest_rate` DECIMAL(4,2),
  `minimum_deposit` DECIMAL(12,2),
  PRIMARY KEY (`plan_id`)
);

CREATE TABLE `saving_account` (
  `account_number` BIGINT(10),
  `plan_id` INT,
  PRIMARY KEY (`account_number`),
  FOREIGN KEY (`plan_id`) REFERENCES `saving_plan`(`plan_id`)
);

CREATE TABLE `branch` (
  `branch_code` INT,
  `branch_name` VARCHAR(20),
  `address` VARCHAR(50),
  PRIMARY KEY (`branch_code`)
);

CREATE TABLE `position` (
  `position_id` INT,
  `position_name` VARCHAR(50),
  PRIMARY KEY (`position_id`)
);

CREATE TABLE `employee` (
  `employee_NIC` VARCHAR(36),
  `branch_code` INT,
  `name` VARCHAR(50),
  `telephone_number` VARCHAR(10),
  `position_id` INT,
  `email` VARCHAR(50),
  PRIMARY KEY (`employee_NIC`),
  FOREIGN KEY (`branch_code`) REFERENCES `branch`(`branch_code`),
  FOREIGN KEY (`position_id`) REFERENCES `position`(`position_id`)
);

CREATE TABLE `customer` (
  `customer_NIC` BIGINT(10),
  `name` VARCHAR(20),
  `date_of_birth` DATE,
  `telephone_number` VARCHAR(10),
  `email` VARCHAR(50),
  `customer_type_id` INT,
  PRIMARY KEY (`customer_NIC`),
  FOREIGN KEY (`customer_type_id`) REFERENCES `customer_type`(`type_id`)
);

CREATE TABLE `account` (
  `account_number` BIGINT(10),
  `type` ENUM('savings', 'current'),
  `customer_NIC` BIGINT(10),
  `branch_code` INT,
  `balance` DECIMAL(10,2),
  PRIMARY KEY (`account_number`),
  FOREIGN KEY (`branch_code`) REFERENCES `branch`(`branch_code`),
  FOREIGN KEY (`customer_NIC`) REFERENCES `customer`(`customer_NIC`)
);

CREATE TABLE `Transaction` (
  `transaction_id` VARCHAR(36),
  `sender_account_number` BIGINT(10),
  `receiver_account_number` BIGINT(10),
  `transfer_amount` DECIMAL(12,2),
  `transaction_date` DATE,
  `transaction_time` TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`receiver_account_number`) REFERENCES `account`(`account_number`),
  FOREIGN KEY (`sender_account_number`) REFERENCES `account`(`account_number`)
);

CREATE TABLE `user` (
  `user_NIC` VARCHAR(10),
  `username` VARCHAR(50),
  `password_hash` VARCHAR(75),
  `user_type` enum('customer','employee'),
  PRIMARY KEY (`user_NIC`)
);

CREATE TABLE `FD_plan` (
  `plan_id` VARCHAR(36),
  `time_in_months` INT,
  `interest_rate` DECIMAL(4,2),
  PRIMARY KEY (`plan_id`)
);

CREATE TABLE `fixedDeposit` (
  `FD_id` VARCHAR(36),
  `saving_account_number` BIGINT(10),
  `amount` DECIMAL(18,2),
  `plan_id` VARCHAR(36),
  PRIMARY KEY (`FD_id`),
  FOREIGN KEY (`plan_id`) REFERENCES `FD_plan`(`plan_id`),
  FOREIGN KEY (`saving_account_number`) REFERENCES `saving_account`(`account_number`)

);

CREATE TABLE `loan` (
  `loan_id` VARCHAR(36),
  `amount` DECIMAL(6,2),
  `interest_rate` DECIMAL(4,2),
  `loan_period` DECIMAL,
  `aproved` TINYINT,
  `request_type` enum('online','physical'),
  PRIMARY KEY (`loan_id`)
);

CREATE TABLE `withdrawal` (
  `withdrawal_id` VARCHAR(36),
  `account_number` BIGINT(10),
  `withdrawal_amount` DECIMAL(12,2),
  `withdrawal_date` DATE,
  `withdrawal_time` TIMESTAMP,
  PRIMARY KEY (`withdrawal_id`),
  FOREIGN KEY (`account_number`) REFERENCES `account`(`account_number`)
);

-- creating procedures

-
DELIMITER //
create PROCEDURE DeleteFDLoan(IN FD_ID_in varchar(36))
BEGIN
    DELETE FROM loan where loan_id = (
        select loan_id from online_requested_loan where FD_id = FD_ID_in
        );

end //
DELIMITER ;
DELIMITER //
create PROCEDURE DeleteOnlineRequestedLoan(loan_id_in varchar(36),requested_type_in enum('online', 'physical') )
BEGIN
    IF requested_type_in = 'online' then
        DELETE FROM online_requested_loan where loan_id = loan_id_in;
    end if ;
end //



DELIMITER ;


DELIMITER //
-- deleting fixed deposit when savings account number is given
create PROCEDURE DeleteAccountFD(IN account_number_in BIGINT)
BEGIN
    DELETE FROM fixedDeposit where saving_account_number = account_number_in;
end //
DELIMITER ;


-- deleting customer account when customer NIC is given
DELIMITER //

create PROCEDURE DeleteCustomerAccount(customer_NIC_in BIGINT )
BEGIN
    DELETE FROM account where customer_NIC= customer_NIC_in;


end //
DELIMITER ;

-- deleting saving account when account number and type is given
DELIMITER //
create PROCEDURE DeleteAccountSavingAccount(account_number_in BIGINT,type enum('savings', 'current'))
BEGIN
    if type = 'savings' then
        delete from saving_account where account_number = account_number_in;
    end if ;
end //
DELIMITER ;


-- deleting user when customer NIC is given
DELIMITER //
create PROCEDURE DeleteCustomerUser(IN customer_NIC_IN BIGINT)
BEGIN
    DELETE FROM user where user_NIC = customer_NIC_IN;
end //
DELIMITER ;
----------------------------------------------------------------------------------------------------------
-- creating triggers

-- trigger for deleting customer account when customer is deleted
DELIMITER //
create TRIGGER customer_delete_trigger
after delete on customer
    for each row
    BEGIN
        CALL DeleteCustomerAccount(OLD.customer_NIC);
    end;
//
DELIMITER ;



-- trigger for deleting savings account when account is deleted
create trigger account_delete_trigger
    after delete
    on account
    for each row
begin
    CALL DeleteAccountSavingAccount(OLD.account_number, OLD.type);
end;

-- trigger for deleting fixed deposit when savings account is deleted
create trigger FD_delete_trigger
    after delete
    on saving_account
    for each row
begin
    call DeleteAccountFD(OLD.account_number);
end;

-- trigger for deleting loan when fixed deposit is deleted
create trigger loan_delete_trigger_1
    after delete
    on fixedDeposit
    for each row
begin
    call DeleteFDLoan(OLD.FD_id);
end;

-- trigger for deleting onlin  requested loan when loan is deleted
create trigger online_loan_delete_trigger
    after delete
    on loan
    for each row
begin
    call DeleteOnlineRequestedLoan(OLD.loan_id,OLD.request_type);
end;

-- trigger for deleting user when customer is deleted
create trigger customer_delete_trigger_user
    after delete
    on customer
    for each row
begin
    CALL DeleteCustomerUser(OLD.customer_NIC);
end;