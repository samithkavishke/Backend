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

INSERT INTO `FD_plan`(plan_id,time_in_months,interest_rate) VALUES('\'1\'','6','0.13'),('\'2\'','12','0.14'),('\'3\'','36','0.15');

INSERT INTO `account`(account_number,type,customer_NIC,branch_code,balance) VALUES('\'0000000001\'','\'savings\'','\'ABC1234567\'','1','21400.00'),('\'0000000002\'','\'current\'','\'DEF9876543\'','2','905.00'),('\'0000000003\'','\'current\'','\'GHI1236540\'','1','3200.00'),('\'0000000004\'','\'savings\'','\'FRE4520036\'','3','9150.00'),('\'0000000005\'','\'savings\'','\'DFR5256642\'','2','4250.00'),('\'0000000006\'','\'savings\'','\'JKL1548200\'','3','4500.00'),('\'0000000007\'','\'savings\'','\'MNO4523691\'','1','25000.00'),('\'0000000008\'','\'savings\'','\'PQR4526801\'','3','15000.00'),('\'0000000009\'','\'savings\'','\'STU4523160\'','3','4000.00'),('\'0000000010\'','\'savings\'','\'VXZ4598992\'','1','2000.00'),('\'0000000012\'','\'savings\'','\'DEF9876543\'','1','4551.00'),('\'0000000013\'','\'savings\'','\'DEF9876543\'','1','5900.00'),('\'0000000014\'','\'savings\'','\'DEF9876543\'','1','5100.00'),('\'0000000015\'','\'current\'','\'DEF9876543\'','1','30000.00');

INSERT INTO branch(branch_code,branch_name,address) VALUES('1','\'Main Branch\'','\'123 Main Street\''),('2','\'Downtown Branch\'','\'456 Downtown Avenue\''),('3','\'CSS Branch\'','\'452 CSS Street\''),('4','\'Uptown Branch\'','\'392 Lower Street\'');

INSERT INTO customer(customer_NIC,name,date_of_birth,telephone_number,email,customer_type_id) VALUES('\'ABC1234567\'','\'John Doe\'','\'1990-01-15\'','\'555-1234\'','\'john@example.com\'','1'),('\'ABC3623666\'','\'Omalya Vid\'','\'2001-12-18\'','\'555-4088\'','\'omalyavid@gmail.com\'','1'),('\'DEF9876543\'','\'Jane Smith\'','\'1985-05-20\'','\'555-5678\'','\'jane@example.com\'','2'),('\'DFR5256642\'','\'Alex Styles\'','\'1996-10-16\'','\'555-8742\'','\'alex@example.com\'','1'),('\'FRE4520036\'','\'Rose Steeves\'','\'1996-10-30\'','\'555-6542\'','\'rose@example.com\'','1'),('\'GHI1236540\'','\'Sue Sams\'','\'2010-10-14\'','\'555-4562\'','\'sue@example.com\'','1'),('\'JKL1548200\'','\'Jack Steeves\'','\'2000-10-06\'','\'555-1569\'','\'jack@example.com\'','1'),('\'MNO4523691\'','\'Sam Cruize\'','\'1999-10-17\'','\'555-4511\'','\'sam@example.com\'','1'),('\'PQR4526801\'','\'Rasa Dias\'','\'2000-10-19\'','\'555-5487\'','\'rasa@example.com\'','1'),('\'STU4523160\'','\'Anne Rozane\'','\'1991-10-13\'','\'555-8960\'','\'anne@example.com\'','2'),('\'VXZ4598992\'','\'Joe Smith\'','\'1998-10-14\'','\'555-6452\'','\'joe@example.com\'','1');

INSERT INTO customer_or_employee(NIC) VALUES('\'ABC1234567\''),('\'ABC3623666\''),('\'DEF9876543\''),('\'DFR5256642\''),('\'EMP123456\''),('\'EMP451120\''),('\'EMP452001\''),('\'EMP452100\''),('\'EMP452107\''),('\'EMP452368\''),('\'EMP453692\''),('\'EMP456621\''),('\'EMP987654\''),('\'FRE4520036\''),('\'GHI1236540\''),('\'JKL1548200\''),('\'MNO4523691\''),('\'PQR4526801\''),('\'STU4523160\''),('\'VXZ4598992\'');

INSERT INTO customer_type(type_id,type_name) VALUES('1','\'Personal\''),('2','\'organization\'');

INSERT INTO employee(employee_NIC,branch_code,name,telephone_number,position_id,email) VALUES('\'EMP123456\'','1','\'John Steve\'','\'555-1000\'','1','\'manager1@example.com\''),('\'EMP451120\'','3','\'Kim Dave\'','\'555-9000\'','2','\'emp6@example.com\''),('\'EMP452001\'','1','\'Employee Tim\'','\'555-3000\'','2','\'emp1@example.com\''),('\'EMP452100\'','3','\'Manager Raze\'','\'555-7000\'','1','\'manager3@example.com\''),('\'EMP452107\'','2','\'Employee Tom\'','\'555-5000\'','2','\'emp3@example.com\''),('\'EMP452368\'','1','\'Employee Timothy\'','\'555-4000\'','2','\'emp2@example.com\''),('\'EMP453692\'','2','\'Employee Sue\'','\'555-6000\'','2','\'emp4@example.com\''),('\'EMP456621\'','3','\'Employee Ann\'','\'555-8000\'','2','\'emp5@example.com\''),('\'EMP987654\'','2','\'Manager Sarah\'','\'555-2000\'','1','\'manager2@example.com\'');

INSERT INTO `fixedDeposit`(FD_id,saving_account_number,amount,plan_id,starting_date) VALUES('\'0bf103d3-7881-11ee-96e2-5a8b282da960\'','\'0000000012\'','1000.00','\'1\'','\'2023-11-01\''),('\'83534cd2-7926-11ee-96e2-5a8b282da960\'','\'0000000013\'','60000.00','\'1\'','\'2023-11-02\''),('\'8944cf0f-788b-11ee-96e2-5a8b282da960\'','\'0000000013\'','2000.00','\'1\'','\'2023-11-01\''),('\'aeb389fc-6d4b-11ee-96e2-5a8b282da960\'','\'0000000001\'','100000.00','\'2\'','\'2023-10-18\''),('\'dacf9819-6d4a-11ee-96e2-5a8b282da960\'','\'0000000006\'','400000.00','\'2\'','\'2023-10-18\''),('\'dd3b9039-6d4a-11ee-96e2-5a8b282da960\'','\'0000000007\'','200000.00','\'1\'','\'2023-10-18\''),('\'df901ac0-6d4a-11ee-96e2-5a8b282da960\'','\'0000000008\'','500000.00','\'3\'','\'2023-10-18\''),('\'e1e57da7-6d4a-11ee-96e2-5a8b282da960\'','\'0000000009\'','100000.00','\'2\'','\'2023-10-18\'');

INSERT INTO installment(installment_id,loan_id,paid,due_date) VALUES('\'0e9ab535-78d7-11ee-96e2-5a8b282da960\'','\'0e9a7c85-78d7-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'0e9ab85e-78d7-11ee-96e2-5a8b282da960\'','\'0e9a7c85-78d7-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'15b9c7b9-78b7-11ee-96e2-5a8b282da960\'','\'15aff103-78b7-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'15bfabf2-78b7-11ee-96e2-5a8b282da960\'','\'15aff103-78b7-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'15bfb032-78b7-11ee-96e2-5a8b282da960\'','\'15aff103-78b7-11ee-96e2-5a8b282da960\'','0','\'2024-01-30\''),('\'15bfb183-78b7-11ee-96e2-5a8b282da960\'','\'15aff103-78b7-11ee-96e2-5a8b282da960\'','0','\'2024-02-29\''),('\'1d807c82-78ce-11ee-96e2-5a8b282da960\'','\'1d804373-78ce-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'1d808046-78ce-11ee-96e2-5a8b282da960\'','\'1d804373-78ce-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'1f0cccba-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2023-11-24\''),('\'1f0cd403-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2023-12-24\''),('\'1f0cd599-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2024-01-23\''),('\'1f0d119d-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2024-02-22\''),('\'1f0d14d1-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2024-03-23\''),('\'1f0d162b-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2024-04-22\''),('\'1f0d1773-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2024-05-22\''),('\'1f0d19d9-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2024-06-21\''),('\'1f0d1b1b-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2024-07-21\''),('\'1f0d1c50-7333-11ee-96e2-5a8b282da960\'','\'Loan6\'','0','\'2024-08-20\''),('\'2187542c-78b7-11ee-96e2-5a8b282da960\'','\'2186cbcd-78b7-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'21875fd2-78b7-11ee-96e2-5a8b282da960\'','\'2186cbcd-78b7-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'21876357-78b7-11ee-96e2-5a8b282da960\'','\'2186cbcd-78b7-11ee-96e2-5a8b282da960\'','0','\'2024-01-30\''),('\'21876e9c-78b7-11ee-96e2-5a8b282da960\'','\'2186cbcd-78b7-11ee-96e2-5a8b282da960\'','0','\'2024-02-29\''),('\'45677648-78d5-11ee-96e2-5a8b282da960\'','\'45674a09-78d5-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'4927224c-78ce-11ee-96e2-5a8b282da960\'','\'49266105-78ce-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'6af1dc69-78b7-11ee-96e2-5a8b282da960\'','\'6af1828f-78b7-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'6af1ea65-78b7-11ee-96e2-5a8b282da960\'','\'6af1828f-78b7-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'6af1ec2b-78b7-11ee-96e2-5a8b282da960\'','\'6af1828f-78b7-11ee-96e2-5a8b282da960\'','0','\'2024-01-30\''),('\'6af1ed6c-78b7-11ee-96e2-5a8b282da960\'','\'6af1828f-78b7-11ee-96e2-5a8b282da960\'','0','\'2024-02-29\''),('\'7392aeec-78d3-11ee-96e2-5a8b282da960\'','\'73929286-78d3-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'7392b1c9-78d3-11ee-96e2-5a8b282da960\'','\'73929286-78d3-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'828f479c-78cf-11ee-96e2-5a8b282da960\'','\'828f1efc-78cf-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'828f4b4d-78cf-11ee-96e2-5a8b282da960\'','\'828f1efc-78cf-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'94445b14-78b7-11ee-96e2-5a8b282da960\'','\'9444126d-78b7-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'94445f25-78b7-11ee-96e2-5a8b282da960\'','\'9444126d-78b7-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'94447616-78b7-11ee-96e2-5a8b282da960\'','\'9444126d-78b7-11ee-96e2-5a8b282da960\'','0','\'2024-01-30\''),('\'94447838-78b7-11ee-96e2-5a8b282da960\'','\'9444126d-78b7-11ee-96e2-5a8b282da960\'','0','\'2024-02-29\''),('\'9ba6f2ed-78d7-11ee-96e2-5a8b282da960\'','\'9ba6cdaf-78d7-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'9ba6f573-78d7-11ee-96e2-5a8b282da960\'','\'9ba6cdaf-78d7-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'ce9f4398-78cd-11ee-96e2-5a8b282da960\'','\'ce9c12e7-78cd-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'ce9f4e06-78cd-11ee-96e2-5a8b282da960\'','\'ce9c12e7-78cd-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'d599bfe7-78d4-11ee-96e2-5a8b282da960\'','\'d596d607-78d4-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'d599c34f-78d4-11ee-96e2-5a8b282da960\'','\'d596d607-78d4-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'dc8917a8-78cd-11ee-96e2-5a8b282da960\'','\'dc88e893-78cd-11ee-96e2-5a8b282da960\'','0','\'2023-12-01\''),('\'dc891bc3-78cd-11ee-96e2-5a8b282da960\'','\'dc88e893-78cd-11ee-96e2-5a8b282da960\'','0','\'2023-12-31\''),('\'fe091c1e-792c-11ee-96e2-5a8b282da960\'','\'fe0425c1-792c-11ee-96e2-5a8b282da960\'','0','\'2023-12-02\''),('\'fe09f923-792c-11ee-96e2-5a8b282da960\'','\'fe0425c1-792c-11ee-96e2-5a8b282da960\'','0','\'2024-01-01\''),('\'fe09fe19-792c-11ee-96e2-5a8b282da960\'','\'fe0425c1-792c-11ee-96e2-5a8b282da960\'','0','\'2024-01-31\''),('\'Installment1\'','\'Loan1\'','1','\'2023-09-01\''),('\'Installment10\'','\'Loan5\'','0','\'2023-10-04\''),('\'Installment11\'','\'Loan2\'','1','\'2023-10-05\''),('\'Installment12\'','\'Loan5\'','1','\'2023-10-01\''),('\'Installment13\'','\'Loan4\'','0','\'2023-10-02\''),('\'Installment14\'','\'Loan3\'','1','\'2023-10-04\''),('\'Installment2\'','\'Loan1\'','0','\'2023-10-01\''),('\'Installment3\'','\'Loan2\'','1','\'2024-03-01\''),('\'Installment4\'','\'Loan2\'','0','\'2024-06-01\''),('\'Installment5\'','\'Loan3\'','0','\'2023-10-02\''),('\'Installment6\'','\'Loan3\'','1','\'2023-10-02\''),('\'Installment7\'','\'Loan1\'','1','\'2023-10-03\''),('\'Installment8\'','\'Loan5\'','1','\'2023-08-08\''),('\'Installment9\'','\'Loan4\'','0','\'2023-10-09\'');

INSERT INTO loan(loan_id,amount,interest_rate,loan_period,approved,request_type,customer_NIC,remaining_installments,branch_code,starting_date,description) VALUES('\'0e9a7c85-78d7-11ee-96e2-5a8b282da960\'','100.00','0.10','2','1','\'online\'','\'DEF9876543\'','2','NULL','\'2023-11-01\'','\'online requested loan\''),('\'15aff103-78b7-11ee-96e2-5a8b282da960\'','100.00','0.10','4','1','\'online\'','\'DEF9876543\'','4','NULL','\'2023-11-01\'','\'online requested loan\''),('\'1d804373-78ce-11ee-96e2-5a8b282da960\'','100.00','0.10','2','1','\'online\'','\'DEF9876543\'','2','NULL','\'2023-11-01\'','\'online requested loan\''),('\'2186cbcd-78b7-11ee-96e2-5a8b282da960\'','100.00','0.10','4','1','\'online\'','\'DEF9876543\'','4','NULL','\'2023-11-01\'','\'online requested loan\''),('\'45674a09-78d5-11ee-96e2-5a8b282da960\'','1.00','0.10','1','1','\'online\'','\'DEF9876543\'','1','NULL','\'2023-11-01\'','\'online requested loan\''),('\'49266105-78ce-11ee-96e2-5a8b282da960\'','100.00','0.10','1','1','\'online\'','\'DEF9876543\'','1','NULL','\'2023-11-01\'','\'online requested loan\''),('\'6af1828f-78b7-11ee-96e2-5a8b282da960\'','100.00','0.10','4','1','\'online\'','\'DEF9876543\'','4','NULL','\'2023-11-01\'','\'online requested loan\''),('\'73929286-78d3-11ee-96e2-5a8b282da960\'','50.00','0.10','2','1','\'online\'','\'DEF9876543\'','2','NULL','\'2023-11-01\'','\'online requested loan\''),('\'828f1efc-78cf-11ee-96e2-5a8b282da960\'','100.00','0.10','2','1','\'online\'','\'DEF9876543\'','2','NULL','\'2023-11-01\'','\'online requested loan\''),('\'9444126d-78b7-11ee-96e2-5a8b282da960\'','100.00','0.10','4','1','\'online\'','\'DEF9876543\'','4','NULL','\'2023-11-01\'','\'online requested loan\''),('\'9ba6cdaf-78d7-11ee-96e2-5a8b282da960\'','100.00','0.10','2','1','\'online\'','\'DEF9876543\'','2','NULL','\'2023-11-01\'','\'online requested loan\''),('\'ce9c12e7-78cd-11ee-96e2-5a8b282da960\'','100.00','0.10','2','1','\'online\'','\'DEF9876543\'','2','NULL','\'2023-11-01\'','\'online requested loan\''),('\'d596d607-78d4-11ee-96e2-5a8b282da960\'','50.00','0.10','2','1','\'online\'','\'DEF9876543\'','2','NULL','\'2023-11-01\'','\'online requested loan\''),('\'dc88e893-78cd-11ee-96e2-5a8b282da960\'','100.00','0.10','2','1','\'online\'','\'DEF9876543\'','2','NULL','\'2023-11-01\'','\'online requested loan\''),('\'fe0425c1-792c-11ee-96e2-5a8b282da960\'','1000.00','0.10','3','1','\'online\'','\'DEF9876543\'','3','NULL','\'2023-11-02\'','\'online requested loan\''),('\'Loan1\'','5000.00','0.08','12','1','\'physical\'','\'ABC1234567\'','12','1','\'2023-09-04\'','NULL'),('\'Loan2\'','10000.00','0.07','24','0','\'online\'','\'DEF9876543\'','24','2','\'2023-09-05\'','NULL'),('\'Loan3\'','15000.00','0.10','36','0','\'physical\'','\'FRE4520036\'','10','3','\'2023-08-30\'','NULL'),('\'Loan4\'','5000.00','0.07','12','1','\'online\'','\'MNO4523691\'','12','2','\'2023-09-05\'','NULL'),('\'Loan5\'','10000.00','0.08','24','1','\'physical\'','\'PQR4526801\'','24','1','\'2023-09-13\'','NULL'),('\'Loan6\'','20000.00','0.05','10','1','\'physical\'','\'PQR4526801\'','10','1','\'2023-10-25\'','NULL');


INSERT INTO online_requested_loan(loan_id,FD_id) VALUES('\'15aff103-78b7-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'2186cbcd-78b7-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'45674a09-78d5-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'49266105-78ce-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'6af1828f-78b7-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'73929286-78d3-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'828f1efc-78cf-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'9444126d-78b7-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'ce9c12e7-78cd-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'d596d607-78d4-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'dc88e893-78cd-11ee-96e2-5a8b282da960\'','\'0bf103d3-7881-11ee-96e2-5a8b282da960\''),('\'fe0425c1-792c-11ee-96e2-5a8b282da960\'','\'83534cd2-7926-11ee-96e2-5a8b282da960\''),('\'0e9a7c85-78d7-11ee-96e2-5a8b282da960\'','\'8944cf0f-788b-11ee-96e2-5a8b282da960\''),('\'1d804373-78ce-11ee-96e2-5a8b282da960\'','\'8944cf0f-788b-11ee-96e2-5a8b282da960\''),('\'9ba6cdaf-78d7-11ee-96e2-5a8b282da960\'','\'8944cf0f-788b-11ee-96e2-5a8b282da960\''),('\'Loan2\'','\'dacf9819-6d4a-11ee-96e2-5a8b282da960\''),('\'Loan4\'','\'dd3b9039-6d4a-11ee-96e2-5a8b282da960\'');

INSERT INTO position(position_id,position_name) VALUES('1','\'branch_manager\''),('2','\'Loan Officer\''),('3','\'Financial Advisor\''),('4','\'Teller\''),('5','\'Risk Analyst\''),('6','\'Compliance Officer\''),('7','\'IT staff\''),('8','\'HR personal\''),('9','\'Customer Service Representative\''),('10','\'Operation staff\'');

INSERT INTO saving_account(account_number,plan_id,number_of_withdrawals) VALUES('\'0000000001\'','1','0'),('\'0000000004\'','2','0'),('\'0000000005\'','3','0'),('\'0000000006\'','3','0'),('\'0000000007\'','4','0'),('\'0000000008\'','1','0'),('\'0000000009\'','2','0'),('\'0000000010\'','3','0'),('\'0000000012\'','1','0'),('\'0000000013\'','1','0'),('\'0000000014\'','2','0');

INSERT INTO saving_plan(plan_id,name,interest_rate,minimum_deposit) VALUES('1','\'Children\'','0.12','0.00'),('2','\'Teen\'','0.11','500.00'),('3','\'Adult\'','0.10','1000.00'),('4','\'Senior\'','0.13','1000.00');

INSERT INTO transaction(transaction_id,sender_account_number,receiver_account_number,transfer_amount,transaction_date,transaction_time) VALUES('\'02e8a7e4-6c40-11ee-96e2-5a8b282da960\'','\'0000000001\'','\'0000000005\'','1000.00','\'2023-10-16\'','\'16:21:07\''),('\'1b24c956-6c45-11ee-96e2-5a8b282da960\'','\'0000000006\'','\'0000000002\'','100.00','\'2023-10-16\'','\'16:57:35\''),('\'1d8eb82d-6c45-11ee-96e2-5a8b282da960\'','\'0000000001\'','\'0000000002\'','500.00','\'2023-10-16\'','\'16:57:39\''),('\'1ffbc7ca-6c45-11ee-96e2-5a8b282da960\'','\'0000000003\'','\'0000000004\'','6000.00','\'2023-10-16\'','\'16:57:44\''),('\'20cfd097-781c-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000001\'','100.00','\'2023-10-31\'','\'18:34:29\''),('\'223d5a8b-78ca-11ee-96e2-5a8b282da960\'','\'0000000013\'','\'0000000012\'','100.00','\'2023-11-01\'','\'15:20:04\''),('\'31eae96f-78c3-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000012\'','50.00','\'2023-11-01\'','\'14:30:24\''),('\'3345b948-78ca-11ee-96e2-5a8b282da960\'','\'0000000013\'','\'0000000001\'','100.00','\'2023-11-01\'','\'15:20:33\''),('\'3e01237b-78cc-11ee-96e2-5a8b282da960\'','\'0000000014\'','\'0000000012\'','100.00','\'2023-11-01\'','\'15:35:10\''),('\'51733aee-78c3-11ee-96e2-5a8b282da960\'','\'0000000002\'','\'0000000002\'','5.00','\'2023-11-01\'','\'14:31:17\''),('\'6066b761-6c45-11ee-96e2-5a8b282da960\'','\'0000000001\'','\'0000000010\'','1000.00','\'2023-10-16\'','\'16:59:32\''),('\'607c367c-78a7-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000001\'','100.00','\'2023-11-01\'','\'11:11:16\''),('\'63bbf538-781c-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000001\'','100.00','\'2023-10-31\'','\'18:36:22\''),('\'6edbb361-78cd-11ee-96e2-5a8b282da960\'','\'0000000014\'','\'0000000014\'','0.00','\'2023-11-01\'','\'15:43:41\''),('\'6f112560-78ff-11ee-96e2-5a8b282da960\'','\'0000000013\'','\'0000000002\'','200.00','\'2023-11-01\'','\'21:41:37\''),('\'79f7d1c6-781d-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000001\'','100.00','\'2023-10-31\'','\'18:44:09\''),('\'8245c0df-7819-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000001\'','300.00','\'2023-10-31\'','\'18:15:45\''),('\'95003a75-786c-11ee-96e2-5a8b282da960\'','\'0000000002\'','\'0000000001\'','100.00','\'2023-11-01\'','\'04:10:24\''),('\'a12bc8ef-6dbb-11ee-96e2-5a8b282da960\'','\'0000000003\'','\'0000000002\'','300.00','\'2023-10-18\'','\'13:38:32\''),('\'a3c0f923-6c51-11ee-96e2-5a8b282da960\'','\'0000000005\'','\'0000000001\'','1000.00','\'2023-10-16\'','\'18:27:19\''),('\'ae89675f-7854-11ee-96e2-5a8b282da960\'','\'0000000002\'','\'0000000001\'','100.00','\'2023-11-01\'','\'01:19:19\''),('\'caa04241-7821-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000001\'','100.00','\'2023-10-31\'','\'19:15:02\''),('\'cd3135d9-792c-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000001\'','100.00','\'2023-11-02\'','\'03:06:22\''),('\'cda6626c-7819-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000002\'','300.00','\'2023-10-31\'','\'18:17:51\''),('\'e1992074-78c9-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000013\'','5000.00','\'2023-11-01\'','\'15:18:16\''),('\'e4b178e5-7819-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000002\'','300.00','\'2023-10-31\'','\'18:18:30\''),('\'e786ffea-781b-11ee-96e2-5a8b282da960\'','\'0000000012\'','\'0000000001\'','100.00','\'2023-10-31\'','\'18:32:53\''),('\'e95e331f-6c44-11ee-96e2-5a8b282da960\'','\'0000000005\'','\'0000000001\'','2000.00','\'2023-10-16\'','\'16:56:12\''),('\'ef7e8731-791c-11ee-96e2-5a8b282da960\'','\'0000000013\'','\'0000000001\'','100.00','\'2023-11-02\'','\'01:12:47\'');

INSERT INTO `user`(user_NIC,username,password_hash,user_type) VALUES('\'ABC1234567\'','\'John\'','\'dsfdfghjgf\'','\'customer\''),('\'ABC3623666\'','\'omalya\'','\'$2b$10$0wKqnOh6Heyh05By9q/b/OfOmNqFtgbj5F5esXJbX2D/wdc4kvPym\'','\'customer\''),('\'DEF9876543\'','\'Jane\'','\'$2b$10$0wKqnOh6Heyh05By9q/b/OfOmNqFtgbj5F5esXJbX2D/wdc4kvPym\'','\'customer\''),('\'DFR5256642\'','\'Alex\'','\'dfsghrtykukjhg\'','\'customer\''),('\'EMP123456\'','\'Jhon\'','\'$2b$10$0wKqnOh6Heyh05By9q/b/OfOmNqFtgbj5F5esXJbX2D/wdc4kvPym\'','\'employee\''),('\'EMP451120\'','\'Kim\'','\'$2b$10$0wKqnOh6Heyh05By9q/b/OfOmNqFtgbj5F5esXJbX2D/wdc4kvPym\'','\'employee\''),('\'FRE4520036\'','\'Rose\'','\'dfehbgfvsvbf\'','\'customer\''),('\'GHI1236540\'','\'Sue\'','\'gfhf-rtrhbf\'','\'customer\''),('\'JKL1548200\'','\'Jack\'','\'wejhncmkwo\'','\'customer\''),('\'MNO4523691\'','\'Sam\'','\'dsfggbvxefdcx\'','\'customer\''),('\'PQR4526801\'','\'Rasa\'','\'$2b$10$uQJpqZfwCOXiUtIBvtsTj.c8ruO2wJZ2ED5nKGdmhTWkfqEQh22U6\'','\'customer\''),('\'STU4523160\'','\'Anne\'','\'fnvdo\'','\'customer\''),('\'VXZ4598992\'','\'Joe\'','\'$2b$10$G.jhBhQIo7gesrNPn7xArechVn8olRZdFiVPxB7hZmMobzL7wQShG\'','\'customer\'');
INSERT INTO withdrawal(withdrawal_id,account_number,withdrawal_amount,withdrawal_date,withdrawal_time) VALUES('\'712bfc2f-6d48-11ee-96e2-5a8b282da960\'','\'0000000002\'','1000.00','\'2023-10-17\'','\'23:53:59\''),('\'76014d7d-6d48-11ee-96e2-5a8b282da960\'','\'0000000003\'','500.00','\'2023-10-17\'','\'23:54:07\''),('\'7856ad7d-6d48-11ee-96e2-5a8b282da960\'','\'0000000004\'','2000.00','\'2023-10-17\'','\'23:54:11\''),('\'7ab16916-6d48-11ee-96e2-5a8b282da960\'','\'0000000005\'','750.00','\'2023-10-17\'','\'23:54:15\''),('\'7cfdcbc5-6d47-11ee-96e2-5a8b282da960\'','\'0000000002\'','1000.00','\'2023-10-17\'','\'23:47:10\''),('\'7d16d936-6d48-11ee-96e2-5a8b282da960\'','\'0000000006\'','5500.00','\'2023-10-17\'','\'23:54:19\''),('\'7d752b3c-7361-11ee-96e2-5a8b282da960\'','\'0000000004\'','100.00','\'2023-10-25\'','\'18:08:24\''),('\'7f7b6ec7-6d48-11ee-96e2-5a8b282da960\'','\'0000000007\'','20000.00','\'2023-10-17\'','\'23:54:23\''),('\'af17da03-7361-11ee-96e2-5a8b282da960\'','\'0000000004\'','100.00','\'2023-10-25\'','\'18:09:48\''),('\'da84a24e-7361-11ee-96e2-5a8b282da960\'','\'0000000004\'','100.00','\'2023-10-25\'','\'18:11:01\''),('\'e0fe9e48-7360-11ee-96e2-5a8b282da960\'','\'0000000004\'','100.00','\'2023-10-25\'','\'18:04:02\'');

DROP Function IF EXISTS calculate_interest;
DELIMITER ;;
CREATE FUNCTION "calculate_interest"(amount Decimal, interest_rate DECIMAL) RETURNS decimal(10,0)
BEGIN
    DECLARE monthly_interest decimal;
    SET monthly_interest = amount *(interest_rate / 12) ;
    RETURN monthly_interest;
END;;
DELIMITER ;