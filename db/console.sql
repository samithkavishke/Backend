CREATE TABLE `onlineLoanRequest` (
  `request_id` VARCHAR(36),
  `requested_amount` DECIMAL(6,2),
  `FD_id` VARCHAR(36),
  PRIMARY KEY (`request_id`)
);

CREATE TABLE `Saving account` (
  `account_number` BIGINT(10),
  `balance` Decimal(12,2),
  PRIMARY KEY (`account_number`)
);

CREATE TABLE `FD_plan` (
  `plan_id` VARCHAR(36),
  `time_in_months` INT,
  `interest_rate` DECIMAL(4,2),
  PRIMARY KEY (`plan_id`)
);

CREATE TABLE `FixedDeposit` (
  `FD_id` VARCHAR(36),
  `saving_account_number` BIGINT(10),
  `amount` DECIMAL(18,2),
  `plan_id` VARCHAR(36),
  PRIMARY KEY (`FD_id`),
  FOREIGN KEY (`plan_id`) REFERENCES `FD_plan`(`plan_id`),
  FOREIGN KEY (`saving_account_number`) REFERENCES `Saving account`(`account_number`)
);

CREATE TABLE `Customer` (
  `customer_NIC` BIGINT(10),
  `name` VARCHAR(20),
  `date_of_birth` DATE,
  `telephone_number` VARCHAR(10),
  `email` VARCHAR(50),
  PRIMARY KEY (`customer_NIC`)
);

CREATE TABLE `Branch` (
  `branch code` INT,
  `Branch name` VARCHAR(20),
  `address` VARCHAR(50),
  PRIMARY KEY (`branch code`)
);

CREATE TABLE `Employee` (
  `employee_id` VARCHAR(36),
  `branch_code` INT,
  `name` VARCHAR(50),
  `telephone_number` VARCHAR(10),
  `position` VARCHAR(20),
  `email` VARCHAR(50),
  PRIMARY KEY (`employee_id`),
  FOREIGN KEY (`branch_code`) REFERENCES `Branch`(`branch code`)
);

CREATE TABLE `saving_plan` (
  `name` VARCHAR(10),
  `interest_rate` DECIMAL(4,2),
  `minimum_deposit` INT,
  PRIMARY KEY (`name`)
);

CREATE TABLE `Loan` (
  `loan_id` VARCHAR(36),
  `amount` DECIMAL(6,2),
  `interest_rate` DECIMAL(4,2),
  `request_id` VARCHAR(36),
  PRIMARY KEY (`loan_id`),
  FOREIGN KEY (`request_id`) REFERENCES `FixedDeposit`(`FD_id`)
);

CREATE TABLE `Account` (
  `account_number` BIGINT(10),
  `type` ENUM('savings', 'current'),
  `customer_id` BIGINT(10),
  `branch_code` INT,
  `balance` DECIMAL(10,2),
  PRIMARY KEY (`account_number`),
  FOREIGN KEY (`branch_code`) REFERENCES `Branch`(`branch code`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`customer_NIC`)
);

CREATE TABLE `Transaction` (
  `transaction_id` VARCHAR(36),
  `sender_account_number` BIGINT(10),
  `receiver_account_number` BIGINT(10),
  `transfer_amount` DECIMAL(12,2),
  `transaction_date_time` DATETIME,
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`sender_account_number`) REFERENCES `Account`(`account_number`),
  FOREIGN KEY (`receiver_account_number`) REFERENCES `Account`(`account_number`)
);

CREATE TABLE `User` (
  `user_NIC` VARCHAR(10),
  `username` VARCHAR(20),
  `password_hash` VARCHAR(50),
  PRIMARY KEY (`user_NIC`)
);

