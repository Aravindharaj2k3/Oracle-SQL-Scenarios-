CREATE TABLE CUSTOMER35(CUST_ID NUMBER PRIMARY KEY,CUST_NAME VARCHAR(30),CUST_CITY VARCHAR(30),CUST_SATE VARCHAR(30),CUST_DATE DATE,GENDER VARCHAR(1));
INSERT ALL
 INTO CUSTOMER35 VALUES(100,'TIM','CHENNAI','TN',TO_DATE('22-02-2020','DD-MM-YYYY'),'M')
 INTO CUSTOMER35 VALUES(101,'BILL','BANGALORE','TN',TO_DATE('04-01-2021','DD-MM-YYYY'),'M')
 INTO CUSTOMER35 VALUES(102,'RAVI','CHENNAI','TN',TO_DATE('23-02-2022','DD-MM-YYYY'),'M')
 INTO CUSTOMER35 VALUES(103,'PALLAVI','BANGALORE','TN',TO_DATE('22-02-2023','DD-MM-YYYY'),'F')
 SELECT * FROM DUAL;
 
UPDATE INGUIRY35 SET CUST_ID=NULL WHERE CUST_ID=101;

UPDATE CUSTOMER35 SET CUST_SATE='KA' WHERE CUST_ID=103;

ALTER TABLE CUSTOMER35 RENAME COLUMN INGUIRY TO INGU_NAME;
 


CREATE TABLE INGUIRY35(IN_ID NUMBER(2),IN_DATE DATE,IN_TYPE VARCHAR(20),INGUIRY VARCHAR(30), CUST_ID REFERENCES CUSTOMER35(CUST_ID));

INSERT ALL
INTO INGUIRY35 VALUES(1,TO_DATE('25-08-2021','DD-MM-YYYY'),'INTERNET','NEW CONNECTION',101)
INTO INGUIRY35 VALUES(2,TO_DATE('25-08-2021','DD-MM-YYYY'),'VOICE','UPGRADE',101)
INTO INGUIRY35 VALUES(3,TO_DATE('14-08-2021','DD-MM-YYYY'),'INTERNET','DATA UPGRADE',102)
INTO INGUIRY35 VALUES(4,TO_DATE('15-08-2021','DD-MM-YYYY'),'INTERNET','LINE DOWN MESSAGE',102)
INTO INGUIRY35 VALUES(5,TO_DATE('20-08-2021','DD-MM-YYYY'),'VOICE','NEW CONNECTION',101)
INTO INGUIRY35 VALUES(6,TO_DATE('21-08-2021','DD-MM-YYYY'),'INTERNET','LINE DOWN MESSAGE',103)
INTO INGUIRY35 VALUES(7,TO_DATE('22-08-2021','DD-MM-YYYY'),'INTERNET','DATA UPGRADE',102)
SELECT * FROM DUAL;

--Display the values
SELECT * FROM CUSTOMER35;
SELECT * FROM INGUIRY35;

--1	Display the customer name who are Male and who belongs to KA 
SELECT CUST_NAME,CUST_SATE FROM CUSTOMER07
WHERE GENDER='M'and CUST_SATE in 
(SELECT CUST_SATE FROM CUSTOMER07 WHERE CUST_SATE='KA' or CUST_SATE='MH');


--2	Display the customers who are from same CITY AS PALLAVI
SELECT CUST_NAME,CUST_CITY FROM CUSTOMER07 
WHERE CUST_CITY=(SELECT CUST_CITY FROM CUSTOMER07
WHERE CUST_NAME='PALLAVI');

--3	Dispay the number of customers who are in TN state
SELECT COUNT(CUST_ID),
FROM CUSTOMER07
WHERE  CUST_ID IN (SELECT CUST_ID FROM CUSTOMER07 WHERE CUST_SATE='TN');
 
--4	Display customer made the inquiry which belongs to Voice type and inquiry belings to New Connection	
SELECT CUST_NAME 
FROM CUSTOMER07 
WHERE CUST_ID =
(SELECT CUST_ID FROM INGUIRY WHERE IN_TYPE ='VOICE' AND  INGUIRY ='NEW CONNECTION');
 
--5	Display the inquiry which does not associate to any registered customer		
SELECT CUST_ID,CUST_NAME FROM CUSTOMER07
WHERE CUST_ID NOT IN 
(SELECT DISTINCT(CUST_ID) FROM INGUIRY);    

SELECT CUST_ID,CUST_NAME FROM CUSTOMER07 WHERE CUST_ID NOT IN (SELECT DISTINCT (CUST_ID) FROM INGUIRY);
--6	Display the customers who don�t have any inquiry	
SELECT CUST_ID,CUST_NAME FROM CUSTOMER07 WHERE CUST_ID IN (SELECT DISTINCT (CUST_ID) FROM INGUIRY);
--7	Display the customers whose name starts with P and belings to KA or MH and who are Female customers
SELECT CUST_NAME FROM CUSTOMER07 WHERE CUST_NAME LIKE 'P%' AND (CUST_SATE='KA' OR CUST_SATE='HM')AND GENDER='F';
--8	Display the inquiry date, inqury type and inquiry from customers in the year 2021	
SELECT IN_DATE,IN_TYPE 
FROM INGUIRY
WHERE CUST_ID = 
(SELECT CUST_ID FROM CUSTOMER07 WHERE CUST_DATE BETWEEN '01-01-2021' AND '01-12-2021');
--9	Display the number of inquiries which came because of Voice inquiry type
SELECT COUNT(IN_TYPE) FROM INGUIRY WHERE IN_TYPE='VOICE'; 
--10	Display Count customer belong to chennai	
SELECT COUNT(CUST_CITY)FROM CUSTOMER07 WHERE CUST_CITY='CHENNAI';
--11	Dispay who is the male customer inquired for 'Internet'	
SELECT CUST_NAME FROM CUSTOMER07 WHERE CUST_ID IN (SELECT CUST_ID FROM INGUIRY WHERE IN_TYPE='INTERNET' AND GENDER='M');
--12	How many Inquiry we have for Line Down Message	
SELECT COUNT(INGUIRY) FROM INGUIRY WHERE INGUIRY LIKE '%LINE DOWN MESSAGE%';
--13	Which inquiry we don�t have any customer
SELECT * FROM INGUIRY WHERE CUST_ID IS NULL;
--14	Diplay Oldest Customer Name from Customer Table	
SELECT CUST_NAME,CUST_DATE FROM CUSTOMER07 WHERE CUST_DATE=(SELECT MIN(CUST_DATE) FROM CUSTOMER07);
--15	Display How made a latest enquiry	
SELECT MAX(INGUIRY) FROM INGUIRY;
--16	How many customer we have in TN	
SELECT COUNT(CUST_SATE)FROM CUSTOMER07 WHERE CUST_SATE='TN';
--17	which customer dob is not updated
--18	How many inquiry we have between '14/08/21' to '20/08/21'
SELECT * FROM INGUIRY WHERE IN_DATE BETWEEN '14-08-21' AND '20-08-21';
--19	How many Female cusomer we have
SELECT COUNT(GENDER) FROM CUSTOMER07 WHERE GENDER='F';

