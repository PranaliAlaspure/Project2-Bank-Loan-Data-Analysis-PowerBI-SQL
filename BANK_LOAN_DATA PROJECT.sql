---BANK_LOAN_DATA_QUERY_PROJECT----

--TOTAL LOAN APPLICATION--
SELECT*FROM[dbo].[BANK_LOAN_DATA];
SELECT COUNT(ID)AS TOTAL_LOAN_APPLICATION FROM [dbo].[BANK_LOAN_DATA];

--MTD TOTAL LOAN APPLICATION--
SELECT COUNT(ID)AS MTD_TOTAL_LOAN_APPLICATION FROM [dbo].[BANK_LOAN_DATA]
WHERE MONTH(ISSUE_DATE)=12 AND YEAR(ISSUE_DATE)=2021;

---PMTD TOTAL LOAN APPLICATION--

SELECT COUNT(ID)AS PMTD_TOTAL_LOAN_APPLICATION FROM [dbo].[BANK_LOAN_DATA]
WHERE MONTH(ISSUE_DATE)=11 AND YEAR(ISSUE_DATE)=2021;

--FORMULA MOM DATA=(MTD-PMTD)/PMTD---

--TOTAL_FUNDEND_AMOUNT--
SELECT SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT FROM BANK_LOAN_DATA;

--MTD TOTAL FUNDED AMOUNT--
SELECT SUM(loan_amount)AS MTD_TOTAL_FUNDED_AMOUNT FROM [dbo].[BANK_LOAN_DATA]
WHERE MONTH(ISSUE_DATE)=12 AND YEAR(ISSUE_DATE)=2021;
--PMTD TOTAL FUNDED AMOUNT--
SELECT SUM(loan_amount)AS PMTD_TOTAL_FUNDED_AMOUNT FROM [dbo].[BANK_LOAN_DATA]
WHERE MONTH(ISSUE_DATE)=11 AND YEAR(ISSUE_DATE)=2021;

--Total Amount Received--
SELECT SUM(TOTAL_PAYMENT) FROM [dbo].[BANK_LOAN_DATA]

--MTD TOTAL AMOUNT RECEIVED--
SELECT SUM(TOTAL_PAYMENT) FROM [dbo].[BANK_LOAN_DATA]
WHERE MONTH(issue_date)=12

--PMTD TOTAL AMOUNT RECEIVED--
SELECT SUM(TOTAL_PAYMENT) FROM [dbo].[BANK_LOAN_DATA]
WHERE MONTH(issue_date)=11

--Average Interest Rate--
SELECT AVG(int_rate)*100 AS AVG_INT_RATE FROM [dbo].[BANK_LOAN_DATA];

--MTD Average Interest Rate--
SELECT AVG(int_rate)*100 AS AVG_INT_RATE FROM [dbo].[BANK_LOAN_DATA]
WHERE MONTH(ISSUE_DATE)=12;

--PMTD Average Interest Rate--
SELECT AVG(int_rate)*100 AS AVG_INT_RATE FROM [dbo].[BANK_LOAN_DATA]
WHERE MONTH(ISSUE_DATE)=11;

--Avg DTI--
SELECT AVG(DTI)*100 AS AVG_DTI FROM[dbo].[BANK_LOAN_DATA];

--MTD Avg DTI--
SELECT AVG(DTI)*100 AS AVG_DTI FROM[dbo].[BANK_LOAN_DATA]
WHERE MONTH(ISSUE_DATE)=12;

--PMTD Avg DTI--
SELECT AVG(DTI)*100 AS AVG_DTI FROM[dbo].[BANK_LOAN_DATA]
WHERE MONTH(ISSUE_DATE)=11;

--GOOD LOAN ISSUED
--Good Loan Percentage--
SELECT (COUNT(CASE WHEN LOAN_STATUS='FULLY PAID'OR LOAN_STATUS='CURRENT'THEN ID END)*100.0)/COUNT(ID) AS GOOD_LOAN_PERCENTAGE
FROM [dbo].[BANK_LOAN_DATA];

--Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
--GOOD LOAN FUNDED AMOUNT--
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--BAD LOAN ISSUED
--Bad Loan Percentage
SELECT (COUNT(CASE WHEN loan_status='Charged Off'THEN id END)*100.0)/COUNT(id) AS BAD_LOAN_PERCENTAGE
FROM[dbo].[BANK_LOAN_DATA];

--Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--LOAN STATUS
SELECT loan_status,COUNT(id)AS LOAN_COUNT,SUM(total_payment)as TOTAL_AMOUNT_RECEIVED,
SUM(loan_amount)AS TOTAL_FUNDED_AMOUNT,AVG(int_rate*100)as AVERAGE_INTEREST_RATE,
AVG(dti*100)AS AVERAGE_DTI
FROM [dbo].[BANK_LOAN_DATA]
GROUP BY loan_status;

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

--	BANK LOAN REPORT | OVERVIEW
--MONTH
SELECT MONTH(issue_date) MONTH_NUMBER,
       DATENAME(MONTH,issue_date)MONTH_NAME,
	   COUNT(id)TOTAL_LOAN_APPLICATION,
	   SUM(loan_amount)TOTAL_FUNDED_AMOUNT,
	   SUM(total_payment)TOTAL_AMOUNT_RACEIVED
FROM [dbo].[BANK_LOAN_DATA]
GROUP BY MONTH(issue_date),
       DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date);

--STATE
SELECT address_state as STATE,
	   COUNT(id)TOTAL_LOAN_APPLICATION,
	   SUM(loan_amount)TOTAL_FUNDED_AMOUNT,
	   SUM(total_payment)TOTAL_AMOUNT_RACEIVED
FROM [dbo].[BANK_LOAN_DATA]
GROUP BY address_state
ORDER BY address_state;

--TERM
SELECT term as TERM,
	   COUNT(id)TOTAL_LOAN_APPLICATION,
	   SUM(loan_amount)TOTAL_FUNDED_AMOUNT,
	   SUM(total_payment)TOTAL_AMOUNT_RACEIVED
FROM [dbo].[BANK_LOAN_DATA]
GROUP BY term
ORDER BY term;

--EMPLOYEE LENGTH
SELECT emp_length as EMPLOYEE_LENGTH,
	   COUNT(id)TOTAL_LOAN_APPLICATION,
	   SUM(loan_amount)TOTAL_FUNDED_AMOUNT,
	   SUM(total_payment)TOTAL_AMOUNT_RACEIVED
FROM [dbo].[BANK_LOAN_DATA]
GROUP BY emp_length
ORDER BY emp_length;

--PURPOSE
SELECT purpose AS PURPOSE,
	   COUNT(id)TOTAL_LOAN_APPLICATION,
	   SUM(loan_amount)TOTAL_FUNDED_AMOUNT,
	   SUM(total_payment)TOTAL_AMOUNT_RACEIVED
FROM [dbo].[BANK_LOAN_DATA]
GROUP BY purpose
ORDER BY purpose;

--HOME OWNERSHIP
SELECT home_ownership AS PURPOSE,
	   COUNT(id)TOTAL_LOAN_APPLICATION,
	   SUM(loan_amount)TOTAL_FUNDED_AMOUNT,
	   SUM(total_payment)TOTAL_AMOUNT_RACEIVED
FROM [dbo].[BANK_LOAN_DATA]
GROUP BY home_ownership
ORDER BY home_ownership;

--See the results when we hit the Grade A in the filters for dashboards.
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;


