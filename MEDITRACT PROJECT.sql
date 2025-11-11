CREATE DATABASE project_meditract;

CREATE TABLE patients (
	patient_id INT PRIMARY KEY,
	name VARCHAR(100),
	gender VARCHAR(10),
	age INT,
	city VARCHAR(50),
	registration_date DATE
);

CREATE TABLE doctors (
	doctor_id INT PRIMARY KEY, 
	name VARCHAR(100),
	specialization VARCHAR(50),
	experience_years INT
);

CREATE TABLE appointments(
	appointment_id INT PRIMARY KEY,
	patient_id INT REFERENCES patients(patient_id),
	doctor_id INT REFERENCES doctors(doctor_id),
	appointment_date DATE,
	diagnosis VARCHAR(255),
	treatment VARCHAR(255)
);

CREATE TABLE billing (
	bill_id INT PRIMARY KEY,
	appointment_id INT REFERENCES appointments(appointment_id),
	amount NUMERIC(10,2),
	payment_status VARCHAR(20),
	payment_date DATE
);

---INSERT SAMPLE DATA-----

--PATIENTS--

INSERT INTO patients VALUES
(1, 'ravi kumar', 'male', 45, 'delhi', '2024-01-12'),
(2, 'priya sharma', 'female', 32, 'mumbai', '2024-02-18'),
(3, 'amit singh', 'male', 65, 'luvknow', '2024-03-10'),
(4, 'sneha patel', 'female', 28, 'ahmedabad', '2024-03-25'),
(5, 'rahul varma', 'male', 55, 'delhi', '2024-04-01'),
(6, 'anita das', 'female', 38, 'kolkata', '2024-04-22'),
(7, 'vikram joshi', 'male', 72, 'jaipur', '2024-05-10'),
(8, 'neha gupta', 'female', 41, 'pune', '2024-06-03'),
(9, 'suresh yadav', 'male', 60, 'varanasi', '2024-06-25'),
(10, 'kiran mehta', 'female', 50, 'surat', '2024-07-08');

--doctors---

INSERT INTO Doctors VALUES
(1, 'Dr. R. Mehta', 'Cardiologist', 15),
(2, 'Dr. S. Nair', 'Neurologist', 12),
(3, 'Dr. A. Singh', 'Dermatologist', 8),
(4, 'Dr. P. Desai', 'Orthopedic', 10),
(5, 'Dr. V. Sharma', 'General Physician', 5);

--appointments--

INSERT INTO Appointments VALUES
(101, 1, 1, '2024-04-12', 'High Blood Pressure', 'Medication'),
(102, 2, 3, '2024-04-18', 'Skin Allergy', 'Ointment'),
(103, 3, 1, '2024-05-01', 'Chest Pain', 'ECG Test'),
(104, 4, 2, '2024-05-15', 'Migraine', 'MRI Scan'),
(105, 5, 5, '2024-05-20', 'Flu', 'Antibiotics'),
(106, 6, 4, '2024-06-10', 'Knee Pain', 'Physiotherapy'),
(107, 7, 1, '2024-06-18', 'Heart Checkup', 'Medication'),
(108, 8, 3, '2024-07-01', 'Rashes', 'Skin Cream'),
(109, 9, 2, '2024-07-08', 'Memory Loss', 'Brain Scan'),
(110, 10, 5, '2024-07-15', 'Fever', 'Paracetamol');


--billing--

INSERT INTO Billing VALUES
(1001, 101, 2000.00, 'Paid', '2024-04-12'),
(1002, 102, 1500.00, 'Paid', '2024-04-18'),
(1003, 103, 4000.00, 'Pending', NULL),
(1004, 104, 3500.00, 'Paid', '2024-05-15'),
(1005, 105, 1000.00, 'Paid', '2024-05-20'),
(1006, 106, 2500.00, 'Paid', '2024-06-10'),
(1007, 107, 4200.00, 'Pending', NULL),
(1008, 108, 1700.00, 'Paid', '2024-07-01'),
(1009, 109, 5000.00, 'Paid', '2024-07-08'),
(1010, 110, 1200.00, 'Pending', NULL);
-------------------------------------------------------------------------------------------------------------

--PRACTICE QUERIES---
--1. list all patients above 60 years.

SELECT * FROM patients where age>60;

--------------------------------------------------------------------------------------------------------------
--2. show appointments for "dr. r. mehta'.

SELECT a.appointment_id, p.name AS patient_name, a.appointment_date, a.diagnosis
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE d.name = 'Dr. R. Mehta';

--3. total number of patient from each city.
------------------------------------------------------------------------------------------------------------
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC;
------------------------------------------------------------------------------------------------------------
--4. DOCTORS WITH MORE THAN 10 YEARS OF EXPERIENCE.

SELECT name, specialization, experience_years
FROM doctors
WHERE experience_years>10;
-----------------------------------------------------------------------------------------------------------
--5. total revenue generated.

SELECT SUM(amount) AS total_revenue
FROM billing
WHERE payment_status = 'paid';
-----------------------------------------------------------------------------------------------------------
--6. top 3 doctors with most appointment.

SELECT d.name, COUNT(a.appointment_id) as total_appointments
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name
ORDER BY total_appointments DESC
LIMIT 3;
----------------------------------------------------------------------------------------------------------
--7. patients with more than 1 appointment in the same month.

SELECT patient_id, COUNT(*) AS total_appointments
FROM appointments
GROUP BY patient_id, EXTRACT(MONTH FROM appointment_date)
HAVING COUNT(*)>1;
---------------------------------------------------------------------------------------------------------
--8. Average bill amount per doctor.

SELECT d.name, AVG(b.amount) as avg_bill
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
JOIN billing b ON a.appointment_id = B.appointment_id
GROUP BY d.name;
---------------------------------------------------------------------------------------------------------
--9. patients with unpaid bills.
SELECT DISTINCT p.name, b.amount
FROM patients p
JOIN appointments a ON  p.patient_id = a.patient_id
JOIN billing b ON a.appointment_id = b.appointment_id
WHERE b.payment_status = 'pending';
--------------------------------------------------------------------------------------------------------
--10. monthly revenue trend. 

SELECT 
    EXTRACT(MONTH FROM payment_date) AS month,
    SUM(amount) AS total_revenue
FROM Billing
WHERE payment_status = 'Paid'
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY month;

























