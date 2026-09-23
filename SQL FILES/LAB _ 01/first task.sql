CREATE SCHEMA XIT;

SET SEARCH_PATH TO XIT;

CREATE TABLE department (
	did character(2) NOT NULL,
	dname character varying(30) NOT NULL,
	PRIMARY KEY (did)
);

SELECT table_name, column_name, data_type
	FROM information_schema.columns 
	WHERE table_name = 'department';

INSERT INTO department 
	VALUES ('CS', 'Computer Engineering');
INSERT INTO department
	VALUES ('EE', 'Electrical Engineering');
INSERT INTO department
	VALUES ('ME', 'Mechanical Engineering');
INSERT INTO department
	VALUES ('CE', 'Civil Engineering');

SELECT * FROM DEPARTMENT;

CREATE TABLE program (
	pid character(3) NOT NULL,
	pname character varying(20) NOT NULL,
	intake smallint,
	did character(2),
	PRIMARY KEY (pid),
	FOREIGN KEY (did) REFERENCES department(did)
		ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO program VALUES ('BCS', 'BTech(CS)', 60, 'CS');
INSERT INTO program VALUES ('MCS', 'MTech(CS)', 20, 'CS');
INSERT INTO program VALUES ('BEE', 'BTech(EE)', 40, 'EE');
INSERT INTO program VALUES ('BME', 'BTech(ME)', 40, 'ME');
INSERT INTO program VALUES ('BIT', 'BTech(IT)', 40, 'CS');
INSERT INTO program VALUES ('BEC', 'BTech(EC)', 40, 'EE');

SELECT * FROM program;

CREATE TABLE student (
	  studid smallint NOT NULL,
	  name character varying(20) NOT NULL,
	  progid character(3) ,
	  batch smallint,
	  cpi numeric(2,1),
	PRIMARY KEY (studid),
	FOREIGN KEY (progid) REFERENCES program(pid)
				ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO student VALUES (1011,'Shally','BCS',2010,8.0);
INSERT INTO student VALUES (1018,'Jitendra','BEE',2010,8.0);
INSERT INTO student VALUES (1110,'Rohit','BCS',2011,7.9);
INSERT INTO student VALUES (1113,'Pharhan','BEE',2011,8.0);
INSERT INTO student VALUES (1118,'Aesha','BEE',2011,8.0);
INSERT INTO student VALUES (1120,'Manav','BEC',2011,7.9);
INSERT INTO student VALUES (1215,'Mehul','BIT',2012,7.9);
INSERT INTO student VALUES (1218,'Megh','BEE',2012,8.0);
INSERT INTO student VALUES (1219,'Misri','MCS',2012,6.8);
INSERT INTO student VALUES (1312,'Amita','MCS',2013,7.0);
INSERT INTO student VALUES (1401,'Kirit','MCS',2014,1.0);
INSERT INTO student VALUES (1402,'Mukesh','MCS',2014,NULL);

SELECT * FROM student;

