drop schema acad cascade;
create schema acad;
SET search_path TO acad;

create table Program(
	ProgID varchar(2) primary key,
	ProgName varchar(20)
);

create table Student(
	StudentID varchar(9) primary key, 
	Name varchar(30), 
	ProgID varchar(2), 
	Batch numeric(4,0),
	CPI numeric(5,2),
	FOREIGN KEY(ProgID) references Program(ProgId)
);

create table Course(
	CourseNo varchar(5) primary key, 
	CourseName varchar(35), 
	Credit numeric(3,1)
);

create table Instructor(
	InstructorID varchar(5) primary key, 
	InstructorName varchar(30)
);

create table Offers(
	AcadYear integer,
	Semester varchar(6),
	CourseNo varchar(5) REFERENCES Course(CourseNo), 
	InstructorID varchar(5) REFERENCES Instructor(InstructorID), 
	primary key(AcadYear, Semester, CourseNo)
);

create table Registers(
	StudentID varchar(9) REFERENCES Student(StudentID), 
	AcadYear integer,
	Semester varchar(6),
	CourseNo varchar(5) REFERENCES Course(CourseNo), 
	grade varchar(2), 
	primary key(StudentID, AcadYear, Semester, CourseNo),
	FOREIGN KEY(AcadYear, Semester, CourseNo) references Offers(AcadYear, Semester, CourseNo)
);

create table Result(
	StudentID varchar(9) REFERENCES Student(StudentID), 
	AcadYear integer,
	Semester varchar(6),
	spi numeric(5,2), 
	primary key(StudentID, AcadYear, Semester)
);