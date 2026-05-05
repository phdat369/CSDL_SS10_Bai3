use ss10;
-- Bảng Khoa
CREATE TABLE Departments (
Dept_ID INT PRIMARY KEY,
Dept_Name VARCHAR(100)
);
-- Bảng Hóa đơn (Kết nổi bệnh nhân và khoa)
drop table invoices;
CREATE TABLE Invoices (
Invoice_ID INT PRIMARY KEY,
Patient_ID INT,
Dept_ID INT,
Amount DECIMAL(10,2),
foreign key (patient_id) references patients2 (patient_id),
foreign key (dept_id) references departments (dept_id)
);
-- Chèn dữ liệu mâu
INSERT INTO Departments VALUES (1, 'Nội' ), (2, 'Ngoại' );
INSERT INTO Invoices VALUES (101, 1, 1, 500.00), (102, 2, 1, 300.00),(103,3,2,
1000.00);

create view Department_Revenue_View
as select
   d.dept_name,
   count(distinct p.patient_id) as patient_id_total,
   sum(i.amount) as sum_amount
from invoices i
join patients2 p
on p.patient_id = i.patient_id
join departments d
on d.dept_id = i.dept_id
group by d.dept_name; 
drop view Department_Revenue_View;
select * from Department_Revenue_View;

update Department_Revenue_View
set sum_amount = '1000000'
where dept_name = 'Ngoại';