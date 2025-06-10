-- �������ݿ�
CREATE DATABASE SchoolHR;


USE SchoolHR;


-- ������
-- ���ű� (Departments)
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(10086,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL
);


-- ְλ�� (Positions)
CREATE TABLE Positions (
    PositionID INT IDENTITY(110,1) PRIMARY KEY,
    PositionTitle NVARCHAR(100) NOT NULL
);


-- Ա���� (Employees)
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(2022000000,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Age INT NOT NULL, -- ���䣬�����ֶ�
    Gender NVARCHAR(10) NOT NULL, -- �Ա𣬱����ֶΣ�����ʹ�� 'Male'/'Female' ��
    DepartmentID INT,
    PositionID INT,
    HireDate DATE NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES Positions(PositionID)
);


-- ���ʱ� (Salaries)
CREATE TABLE Salaries (
    SalaryID INT IDENTITY(100011,1) PRIMARY KEY,
    EmployeeID INT,
    SalaryAmount DECIMAL(10, 2) NOT NULL,
    SalaryDate DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


-- ����Ա�� (Admins)
CREATE TABLE Admins (
    AdminID INT PRIMARY KEY,
    Password NVARCHAR(100) NOT NULL,
    FOREIGN KEY (AdminID) REFERENCES Employees(EmployeeID)
);


-- ����ʾ������
-- ���벿������
INSERT INTO Departments (DepartmentName) VALUES
('�����칫��'),
('����'),
('����'),
('ѧ����'),
('ͼ���'),
('У����');


-- ����ְλ����
INSERT INTO Positions (PositionTitle) VALUES
('У��'),
('Ժ��'),
('��ί���'),
('��ί���'),
('ϵ����'),
('�Ƴ�'),
('����Ա');


-- ����Ա������
INSERT INTO Employees (Name, Age, Gender, DepartmentID, PositionID, HireDate, Email) VALUES
('����', 34, '��', 10086, 110, '2023-01-15', 'zhangsan@example.com'),
('����', 56, '��', 10087, 111, '2023-02-20', 'lisi@example.com'),
('����', 47, 'Ů', 10088, 112, '2023-03-25', 'wangwu@example.com'),
('����', 39, 'Ů', 10089, 113, '2023-04-10', 'zhaoliu@example.com'),
('����', 61, '��', 10090, 114, '2023-05-18', 'xuqi@example.com'),
('�°�', 23, 'Ů', 10091, 115, '2023-06-22', 'chenba@example.com'),
('���', 51, 'Ů', 10086, 116, '2023-07-30', 'wushijiu@example.com'),
('֣ʮ', 43, 'Ů', 10089, 114, '2023-08-14', 'zhengshi@example.com'),
('��ʮһ', 28, '��', 10088, 115, '2023-09-19', 'wangshiyi@example.com'),
('��ʮ��', 49, 'Ů', 10090, 116, '2023-10-21', 'lishier@example.com');


-- ���빤������
INSERT INTO Salaries (EmployeeID, SalaryAmount, SalaryDate) VALUES
(2022000000, 5000.00, '2024-04-30'),
(2022000001, 4500.00, '2024-04-30'),
(2022000002, 6000.00, '2024-04-30'),
(2022000003, 5500.00, '2024-04-30'),
(2022000004, 4800.00, '2024-04-30'),
(2022000005, 5200.00, '2024-04-30'),
(2022000006, 5000.00, '2024-04-30'),
(2022000007, 5900.00, '2024-04-30'),
(2022000008, 4700.00, '2024-04-30'),
(2022000009, 5300.00, '2024-04-30');


-- �������Ա����
-- ��ע�⣬�˴�������Ӧʹ���ʵ��Ĺ�ϣ������ʵ��Ӧ���н��й�ϣ����
INSERT INTO Admins (AdminID, Password) VALUES
(2022000000, 'admin123'),
(2022000002, 'admin456');


-- ����������
CREATE TRIGGER trg_DeleteDepartment
ON Departments
INSTEAD OF DELETE
AS
BEGIN
    -- �� Employees ���ж�Ӧ�� DepartmentID �ÿ�
    UPDATE Employees
    SET DepartmentID = NULL
    WHERE DepartmentID IN (SELECT DepartmentID FROM deleted);

    -- ɾ�� Departments ���еļ�¼
    DELETE FROM Departments
    WHERE DepartmentID IN (SELECT DepartmentID FROM deleted);
END;


CREATE TRIGGER trg_DeletePosition
ON Positions
INSTEAD OF DELETE
AS
BEGIN
    -- �� Employees ���ж�Ӧ�� PositionID �ÿ�
    UPDATE Employees
    SET PositionID = NULL
    WHERE PositionID IN (SELECT PositionID FROM deleted);

    -- ɾ�� Positions ���еļ�¼
    DELETE FROM Positions
    WHERE PositionID IN (SELECT PositionID FROM deleted);
END;


-- �鿴��������
SELECT * FROM Admins;
SELECT * FROM Departments;
SELECT * FROM Employees;
SELECT * FROM Positions;
SELECT * FROM Salaries;











--delete from Departments where DepartmentID=7; 
--delete  from Employees where EmployeeID=11;

--SET IDENTITY_INSERT positions ON;
--SET IDENTITY_INSERT salaries ON;
--SET IDENTITY_INSERT employees ON;
--SET IDENTITY_INSERT departments ON;








--SET IDENTITY_INSERT positions off;
--SET IDENTITY_INSERT salaries off;




--string sql = $"UPDATE salaries  SET " +
--$"employeeid = '{int.Parse(textupdateemployeeid.Text)}', " +
--$"salarymount={float.Parse(textupdatesalaryamount.Text)}," +
--$"salarydate={datesalaryupdate.Value} " +
--$"WHERE salaryid ='{int.Parse(Formsalarychange.salid.ToString())}'; ";