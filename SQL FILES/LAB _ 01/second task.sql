CREATE SCHEMA COMPANY;

SET SEARCH_PATH TO COMPANY;

CREATE TABLE employee  (
	fname VARCHAR(20),
	minit CHAR(1),
	lname VARCHAR(20),
	ssn DECIMAL(9,0),
	bdate DATE,
	address VARCHAR(30),
	sex CHAR(1),
	salary DECIMAL(10,0),
	superssn DECIMAL(10,0),
	dno SMALLINT,
	PRIMARY KEY (ssn),
	FOREIGN KEY (superssn) REFERENCES employee(ssn)
		ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE department (
	dname VARCHAR(20),
	dno SMALLINT,
	mgrssn DECIMAL(9,0),
	mgrstartdate DATE,
	PRIMARY KEY (dno),
	FOREIGN KEY (mgrssn) REFERENCES employee(ssn)
		ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE dept_locations(
	dno SMALLINT,
	dlocation VARCHAR(20),
	FOREIGN KEY (dno) REFERENCES department on delete cascade,
	PRIMARY KEY (dno,dlocation)
);

CREATE TABLE project(
	pname VARCHAR(20),
	pno SMALLINT,
	plocation VARCHAR(20),
	dno SMALLINT,
	PRIMARY KEY (pno),
	FOREIGN KEY (dno) REFERENCES department(dno)
);

CREATE TABLE works_on(
	essn DECIMAL(9,0),
	pno SMALLINT,
	hours DECIMAL(5,1),
	FOREIGN KEY (essn) REFERENCES employee(ssn)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (pno) REFERENCES project(pno)
		ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (essn,pno)
);

CREATE TABLE dependent(
	essn DECIMAL(9,0),
	dependent_name VARCHAR(20),
	sex CHAR(1),
	bdate DATE,
	relationship VARCHAR(20),
	FOREIGN KEY (essn) REFERENCES employee(ssn)
		ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (essn,dependent_name)
);

ALTER table employee add FOREIGN KEY (dno) REFERENCES
department(dno);

BEGIN;

INSERT INTO department 
	VALUES('Headquater',1,null,TO_DATE('06/19/1971','MM/DD/YYYY'));
INSERT INTO department 
	VALUES('Research',5,null,TO_DATE('05/22/1978','MM/DD/YYYY'));
INSERT INTO department 
	VALUES('Administration',4,null,TO_DATE('01/01/1985','MM/DD/YYYY'));

INSERT INTO employee VALUES 
('James','E','Borg',888665555, TO_DATE('11/10/1927', 'MM/DD/YYYY'),'450 Stone, Houston, TX','M',55000,null,1);
INSERT INTO employee VALUES 
('Franklin','T','Wong',333445555,TO_DATE('12/08/1945','MM/DD/YYYY'),'638 Voss, Houston, TX','M',40000,888665555,5);
INSERT INTO employee VALUES 
('Jennifer','S','Wallace',987654321,TO_DATE('06/20/1931','MM/DD/YYYY'),'291 Berry, Bellaire, TX','F',43000,888665555,4);
INSERT INTO employee VALUES 
('John','B','Smith',123456789,TO_DATE('01/09/1955','MM/DD/YYYY'),'731 Fondren, Houston, TX','M',30000,333445555,5);
INSERT INTO employee VALUES 
('Alicia','J','Zelaya',999887777,TO_DATE('07/19/1958','MM/DD/YYYY'),'3321 Castle, Spring, TX','F',25000,987654321,4);
INSERT INTO employee VALUES 
('Ramesh','K','Narayan',666884444,TO_DATE('09/15/1952','MM/DD/YYYY'),'975 Fire Oak, Humble, TX','M',38000,333445555,5);
INSERT INTO employee VALUES 
('Joyce','A','English',453453453,TO_DATE('07/31/1962','MM/DD/YYYY'),'5631 Rice, Houston, TX','F',25000,333445555,5);
INSERT INTO employee VALUES 
('Ahmad','V','Jabbar',987987987,TO_DATE('03/29/1959','MM/DD/YYYY'),'980 Dallas, Houston, TX','M',25000,987654321,4);

UPDATE department set mgrssn = 888665555 WHERE dno = 1;
UPDATE department set mgrssn = 333445555 WHERE dno = 5;
UPDATE department set mgrssn = 987654321 WHERE dno = 4;

INSERT INTO dept_locations VALUES (1,'Houston');
INSERT INTO dept_locations VALUES (4,'Stafford');
INSERT INTO dept_locations VALUES (5,'Bellaire');
INSERT INTO dept_locations VALUES (5,'Sugarland');
INSERT INTO dept_locations VALUES (5,'Houston');

INSERT INTO project VALUES ('ProductX',1,'Bellaire',5);
INSERT INTO project VALUES ('ProductY',2,'Sugarland',5);
INSERT INTO project VALUES ('ProductZ',3,'Houston',5);
INSERT INTO project VALUES ('Computerization',10,'Stafford',4);
INSERT INTO project VALUES ('Reorganization',20,'Houston',1);
INSERT INTO project VALUES ('Newbenifits',30,'Stafford',4);

INSERT INTO works_on VALUES (123456789,1,32.5);
INSERT INTO works_on VALUES (123456789,2,7.5);
INSERT INTO works_on VALUES (666884444,3,40.0);
INSERT INTO works_on VALUES (453453453,1,20.0);
INSERT INTO works_on VALUES (453453453,2,20.0);
INSERT INTO works_on VALUES (333445555,2,10.0);
INSERT INTO works_on VALUES (333445555,3,10.0);
INSERT INTO works_on VALUES (333445555,10,10.0);
INSERT INTO works_on VALUES (333445555,20,10.0);
INSERT INTO works_on VALUES (333445555,1,32.5);
INSERT INTO works_on VALUES (999887777,30,30.0);
INSERT INTO works_on VALUES (999887777,10,10.0);
INSERT INTO works_on VALUES (987987987,10,35.0);
INSERT INTO works_on VALUES (987987987,30,5.0);
INSERT INTO works_on VALUES (987654321,30,20.0);
INSERT INTO works_on VALUES (987654321,20,15.0);
INSERT INTO works_on VALUES (888665555,20,null);

INSERT INTO dependent VALUES (333445555,'Alice','F',TO_DATE('04/05/1976','MM/DD/YYYY'),'DAUGHTER');
INSERT INTO dependent VALUES (333445555,'Theodore','M',TO_DATE('10/25/1973','MM/DD/YYYY'),'SON');
INSERT INTO dependent VALUES (333445555,'Joy','F',TO_DATE('05/03/1948','MM/DD/YYYY'),'SPOUSE');
INSERT INTO dependent VALUES (987654321,'Abner','M',TO_DATE('02/29/1932','MM/DD/YYYY'),'SPOUSE');
INSERT INTO dependent VALUES (123456789,'Michael','M',TO_DATE('01/01/1978','MM/DD/YYYY'),'SON');
INSERT INTO dependent VALUES (123456789,'Alice','F',TO_DATE('12/31/1978','MM/DD/YYYY'),'DAUGHTER');
INSERT INTO dependent VALUES (123456789,'Elizabeth','F',TO_DATE('05/05/1957','MM/DD/YYYY'),'SPOUSE');

COMMIT;

-- List down all tables in COMPANY schema
SELECT *
FROM pg_tables
WHERE schemaname = 'company';

-- Print structures of all tables in the company database using “DESCRIBE table” command. (HOMEWORK)
SELECT 
    table_name, 
    column_name, 
    data_type, 
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'company'
ORDER BY table_name, ordinal_position;
