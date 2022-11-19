-- pharmacy_location 함수에 사용된 쿼리
-- 약국이름에 '365'가 들어가는 약국의 위치 검색
SELECT Name, Address
FROM PHARMACY
WHERE Name LIKE '%365%'
ORDER BY NAME;




-- update_client_info 함수에 사용된 쿼리
-- 1) ID가 '111223344' 인 고객의 이름, 성별, 생일, 주소, 전화번호 조회
SELECT Name, Sex, Birthday, C_addres, Phone_num
FROM CLIENT
WHERE ID = '111223344'

-- 2) ID가 '111223344' 인 고객의 전화번호, 주소 update
UPDATE CLIENT
SET C_address = 'ASDF', Phone_num = '01011112222'
WHERE ID = '111223333';
SELECT Name, Sex, Birthday, C_address, Phone_num
FROM CLIENT
WHERE ID = '111223333';




-- show_medicine_history 함수에 사용된 쿼리
-- 1) '타이레놀'이 들어간 약을 주문했던 모든 고객의 주문기록 조회
SELECT O.Client_ID, M.Name, O.Order_date, C.Count, O.Prescription
FROM CONTAIN C JOIN MEDICINE M ON C.M_number = M.M_number, M_ORDER O
WHERE C.Order_num = O.Order_num
AND C.Chemist_ID = O.Chemist_ID
AND C.Client_ID = O.Client_ID
AND M.Name LIKE '%타이레놀%'
ORDER BY O.Order_date;

-- 2) 약 번호 45번인 약을 주문했던 모든 고객의 주문기록 조회
SELECT O.Client_ID, M.Name, O.Order_date, C.Count, O.Prescription
FROM CONTAIN C JOIN MEDICINE M ON C.M_number = M.M_number, M_ORDER O
WHERE C.Order_num = O.Order_num
AND C.Chemist_ID = O.Chemist_ID
AND C.Client_ID = O.Client_ID
AND M.M_Number = 45
ORDER BY O.Order_date;




-- medicine_order 함수에 사용된 쿼리
-- 1) 타이레놀이 들어간 약의 번호와 이름 검색
SELECT M_number, Name
FROM MEDICINE
WHERE Name LIKE '%타이레놀%'
ORDER BY M_number;

-- 2) 고객 ID가 '111223344', 약사ID가 20, 주문번호가 1인 주문기록 조회
SELECT Order_num, M_number, Count, Order_date, Prescription, Chemist_ID
FROM M_ORDER NATURAL JOIN CONTAIN 
WHERE Order_num = 1
AND Chemist_ID = 20
AND Client_ID = '111223344';

