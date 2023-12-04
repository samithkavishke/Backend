/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS `FD_plan`;
CREATE TABLE "FD_plan" (
  "plan_id" varchar(36) NOT NULL,
  "time_in_months" int DEFAULT NULL,
  "interest_rate" decimal(4,2) DEFAULT NULL,
  PRIMARY KEY ("plan_id")
);

DROP TABLE IF EXISTS `account`;
CREATE TABLE "account" (
  "account_number" varchar(10) NOT NULL,
  "type" enum('savings','current') DEFAULT NULL,
  "customer_NIC" varchar(10) DEFAULT NULL,
  "branch_code" int DEFAULT NULL,
  "balance" decimal(10,2) DEFAULT NULL,
  PRIMARY KEY ("account_number"),
  KEY "account_ibfk_2" ("customer_NIC"),
  KEY "branch_code" ("branch_code"),
  CONSTRAINT "account_ibfk_1" FOREIGN KEY ("branch_code") REFERENCES "branch" ("branch_code") ON UPDATE CASCADE,
  CONSTRAINT "account_ibfk_2" FOREIGN KEY ("customer_NIC") REFERENCES "customer" ("customer_NIC") ON UPDATE CASCADE
);

DROP TABLE IF EXISTS branch;
CREATE TABLE "branch" (
  "branch_code" int NOT NULL,
  "branch_name" varchar(20) DEFAULT NULL,
  "address" varchar(100) DEFAULT NULL,
  PRIMARY KEY ("branch_code")
);

DROP TABLE IF EXISTS customer;
CREATE TABLE "customer" (
  "customer_NIC" varchar(10) NOT NULL,
  "name" varchar(100) DEFAULT NULL,
  "date_of_birth" date DEFAULT NULL,
  "telephone_number" varchar(10) DEFAULT NULL,
  "email" varchar(50) DEFAULT NULL,
  "customer_type_id" int DEFAULT NULL,
  PRIMARY KEY ("customer_NIC"),
  KEY "customer_type_id" ("customer_type_id"),
  CONSTRAINT "customer_customer_or_employee_NIC_fk" FOREIGN KEY ("customer_NIC") REFERENCES "customer_or_employee" ("NIC"),
  CONSTRAINT "customer_ibfk_1" FOREIGN KEY ("customer_type_id") REFERENCES "customer_type" ("type_id")
);

DROP TABLE IF EXISTS customer_or_employee;
CREATE TABLE "customer_or_employee" (
  "NIC" varchar(10) NOT NULL,
  PRIMARY KEY ("NIC")
);

DROP TABLE IF EXISTS customer_type;
CREATE TABLE "customer_type" (
  "type_id" int NOT NULL,
  "type_name" varchar(20) DEFAULT NULL,
  PRIMARY KEY ("type_id")
);

DROP TABLE IF EXISTS employee;
CREATE TABLE "employee" (
  "employee_NIC" varchar(10) NOT NULL,
  "branch_code" int DEFAULT NULL,
  "name" varchar(50) DEFAULT NULL,
  "telephone_number" varchar(10) DEFAULT NULL,
  "position_id" int DEFAULT NULL,
  "email" varchar(50) DEFAULT NULL,
  PRIMARY KEY ("employee_NIC"),
  KEY "branch_code" ("branch_code"),
  KEY "employee_position_position_id_fk" ("position_id"),
  CONSTRAINT "employee_customer_or_employee_NIC_fk" FOREIGN KEY ("employee_NIC") REFERENCES "customer_or_employee" ("NIC"),
  CONSTRAINT "employee_ibfk_1" FOREIGN KEY ("branch_code") REFERENCES "branch" ("branch_code"),
  CONSTRAINT "employee_position_position_id_fk" FOREIGN KEY ("position_id") REFERENCES "position" ("position_id") ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `fixedDeposit`;
CREATE TABLE "fixedDeposit" (
  "FD_id" varchar(36) NOT NULL,
  "saving_account_number" varchar(10) DEFAULT NULL,
  "amount" decimal(18,2) DEFAULT NULL,
  "plan_id" varchar(36) DEFAULT NULL,
  "starting_date" date DEFAULT NULL,
  PRIMARY KEY ("FD_id"),
  KEY "fixedDeposit_ibfk_2" ("saving_account_number"),
  KEY "fixedDeposit_ibfk_1" ("plan_id"),
  CONSTRAINT "fixedDeposit_ibfk_1" FOREIGN KEY ("plan_id") REFERENCES "FD_plan" ("plan_id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "fixedDeposit_ibfk_2" FOREIGN KEY ("saving_account_number") REFERENCES "saving_account" ("account_number") ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS installment;
CREATE TABLE "installment" (
  "installment_id" varchar(36) NOT NULL,
  "loan_id" varchar(36) DEFAULT NULL,
  "paid" tinyint(1) DEFAULT NULL,
  "due_date" date DEFAULT NULL,
  PRIMARY KEY ("installment_id"),
  KEY "loan_id" ("loan_id"),
  CONSTRAINT "installment_ibfk_1" FOREIGN KEY ("loan_id") REFERENCES "loan" ("loan_id")
);

DROP TABLE IF EXISTS loan;
CREATE TABLE "loan" (
  "loan_id" varchar(36) NOT NULL,
  "amount" decimal(9,2) DEFAULT NULL,
  "interest_rate" decimal(4,2) DEFAULT NULL,
  "loan_period" decimal(10,0) DEFAULT NULL,
  "approved" tinyint DEFAULT NULL,
  "request_type" enum('online','physical') DEFAULT NULL,
  "customer_NIC" varchar(10) DEFAULT NULL,
  "remaining_installments" int DEFAULT NULL,
  "branch_code" int DEFAULT NULL,
  "starting_date" date DEFAULT NULL,
  "description" varchar(500) DEFAULT NULL,
  PRIMARY KEY ("loan_id"),
  KEY "customer_NIC" ("customer_NIC"),
  KEY "branch_code" ("branch_code"),
  CONSTRAINT "loan_customer_customer_NIC_fk" FOREIGN KEY ("customer_NIC") REFERENCES "customer" ("customer_NIC") ON UPDATE CASCADE
);

DROP TABLE IF EXISTS loan_plan;
CREATE TABLE "loan_plan" (
  "plan_id" int NOT NULL AUTO_INCREMENT,
  "interest_rate" int DEFAULT NULL,
  PRIMARY KEY ("plan_id")
);

DROP TABLE IF EXISTS online_requested_loan;
CREATE TABLE "online_requested_loan" (
  "loan_id" varchar(36) NOT NULL,
  "FD_id" varchar(36) DEFAULT NULL,
  PRIMARY KEY ("loan_id"),
  KEY "online_requested_loan_fixedDeposit_FD_id_fk" ("FD_id"),
  CONSTRAINT "online_requested_loan_fixedDeposit_FD_id_fk" FOREIGN KEY ("FD_id") REFERENCES "fixedDeposit" ("FD_id") ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS position;
CREATE TABLE "position" (
  "position_id" int NOT NULL,
  "position_name" varchar(50) DEFAULT NULL,
  PRIMARY KEY ("position_id")
);

DROP TABLE IF EXISTS saving_account;
CREATE TABLE "saving_account" (
  "account_number" varchar(10) NOT NULL,
  "plan_id" int DEFAULT NULL,
  "number_of_withdrawals" int DEFAULT NULL,
  PRIMARY KEY ("account_number"),
  KEY "saving_account_ibfk_1" ("plan_id"),
  CONSTRAINT "saving_account_ibfk_1" FOREIGN KEY ("plan_id") REFERENCES "saving_plan" ("plan_id") ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS saving_plan;
CREATE TABLE "saving_plan" (
  "plan_id" int NOT NULL,
  "name" varchar(10) DEFAULT NULL,
  "interest_rate" decimal(4,2) DEFAULT NULL,
  "minimum_deposit" decimal(12,2) DEFAULT NULL,
  PRIMARY KEY ("plan_id")
);

DROP TABLE IF EXISTS transaction;
CREATE TABLE "transaction" (
  "transaction_id" varchar(36) NOT NULL,
  "sender_account_number" varchar(10) DEFAULT NULL,
  "receiver_account_number" varchar(10) DEFAULT NULL,
  "transfer_amount" decimal(12,2) DEFAULT NULL,
  "transaction_date" date DEFAULT NULL,
  "transaction_time" time DEFAULT NULL,
  PRIMARY KEY ("transaction_id"),
  KEY "transaction_ibfk_1" ("receiver_account_number"),
  KEY "sender_account_number" ("sender_account_number"),
  CONSTRAINT "transaction_ibfk_1" FOREIGN KEY ("receiver_account_number") REFERENCES "account" ("account_number") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "transaction_ibfk_2" FOREIGN KEY ("sender_account_number") REFERENCES "account" ("account_number")
);

DROP TABLE IF EXISTS `user`;
CREATE TABLE "user" (
  "user_NIC" varchar(10) NOT NULL,
  "username" varchar(50) DEFAULT NULL,
  "password_hash" varchar(75) DEFAULT NULL,
  "user_type" enum('customer','employee') DEFAULT NULL,
  PRIMARY KEY ("user_NIC"),
  CONSTRAINT "user_customer_or_employee_NIC_fk" FOREIGN KEY ("user_NIC") REFERENCES "customer_or_employee" ("NIC")
);

DROP TABLE IF EXISTS withdrawal;
CREATE TABLE "withdrawal" (
  "withdrawal_id" varchar(36) NOT NULL,
  "account_number" varchar(10) DEFAULT NULL,
  "withdrawal_amount" decimal(12,2) DEFAULT NULL,
  "withdrawal_date" date DEFAULT NULL,
  "withdrawal_time" time DEFAULT NULL,
  PRIMARY KEY ("withdrawal_id"),
  KEY "withdrawal_ibfk_1" ("account_number"),
  CONSTRAINT "withdrawal_ibfk_1" FOREIGN KEY ("account_number") REFERENCES "account" ("account_number") ON UPDATE CASCADE
);

CREATE OR REPLACE VIEW "branch_wise_total_transactions" AS select "t"."transaction_id" AS "transaction_id","t"."sender_account_number" AS "sender_account_number","t"."receiver_account_number" AS "receiver_account_number","t"."transfer_amount" AS "transfer_amount","t"."transaction_date" AS "transaction_date","t"."transaction_time" AS "transaction_time","a"."branch_code" AS "branch_code" from ("transaction" "t" join "account" "a" on((("t"."sender_account_number" = "a"."account_number") or ("t"."receiver_account_number" = "a"."account_number")))) where ("a"."branch_code" = 2);

CREATE OR REPLACE VIEW "late_loan_installments" AS select "installment"."installment_id" AS "installment_id","installment"."loan_id" AS "loan_id","installment"."amount_due" AS "amount","installment"."due_date" AS "due_date" from ("installment" join "loan" on(("installment"."loan_id" = "loan"."loan_id"))) where (("installment"."paid" = 0) and ("installment"."due_date" < curdate()));

DROP Function IF EXISTS calculate_interest;
DELIMITER ;;
CREATE FUNCTION "calculate_interest"(amount Decimal, interest_rate DECIMAL) RETURNS decimal(10,0)
BEGIN
    DECLARE monthly_interest decimal;
    SET monthly_interest = amount *(interest_rate / 12) ;
    RETURN monthly_interest;
END;;
DELIMITER ;