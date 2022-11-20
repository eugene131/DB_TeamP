-- Team11-Phase2-3

-- 1)  Type 1: A single-table query => Selection + Projection
-- 가격이 1000원 이하인 약
SELECT NAME
FROM MEDICINE
WHERE Price<1000;
/*
NAME
--------------------------------------------------
타가메트정400mg
가나톤정50mg
가나티란정
카나가바로틴캡슐300mg
자나팜정0.4mg
자나팜정0.5mg
하나니트로글리세린설하정0.6mg
바독펜정
아가메이트젤리
타나민정
카네마졸질정100mg

NAME
--------------------------------------------------
다나젠실로스타졸서방캡슐100mg
사로프람정20mg
카노아연질캡슐
카노아정
타이레놀정160mg
까스활명수큐액
사르트정
아겐에프연질캡슐
아겐에프정
아그릴정2mg
아기오과립

NAME
--------------------------------------------------
아나레보정

23 행이 선택되었습니다.
*/

-- 2) Type 1: A single-table query => Selection + Projection
-- 주소지가 서울인 고객의 이름, 휴대폰 번호
SELECT NAME, PHONE_NUM
FROM CLIENT 
WHERE C_ADDRESS LIKE '%서울특별시%';
/*
NAME       PHONE_NUM
---------- ---------------
김문규     01077949214
전종훈     01070901229
최자혁     01019209509
박서준     01022411111
임장학     01035123659
이명진     01042208559
김서정     01089049709
한선옥     01016458388
여재은     01065616648
길기연     01041283340
송태연     01048391425

NAME       PHONE_NUM
---------- ---------------
윤근혜     01036834078
임주영     01028148803

13 행이 선택되었습니다.
*/

-- 3) Type 2: Multi-way join with join predicates in WHERE
-- 처방전을 갖고있는 사람의 주문날짜, ID, 이름, 약의 수
SELECT O.Order_date, O.Client_ID, C.Name, CO.Count
FROM M_ORDER O, CLIENT C, CONTAIN CO
WHERE O.Client_ID = C.ID AND O.Prescription = 1
AND CO.Client_ID = C.ID;
/*
ORDER_DA CLIENT_ID  NAME            COUNT
-------- ---------- ---------- ----------
18/05/25 111224444  박영수              3
18/05/25 111224444  박영수              1
18/06/15 111229999  김문규              4
18/05/15 111335555  전종훈              2
18/03/13 111336666  최자혁              4
18/03/13 111336666  최자혁              2
18/04/05 111338888  박서준              4
18/06/10 111339990  이경수              1
18/06/10 111339990  이경수              1
18/02/08 111445555  임비산              2
18/02/08 111445555  임비산              1

ORDER_DA CLIENT_ID  NAME            COUNT
-------- ---------- ---------- ----------
18/06/18 111557777  윤정원              3
18/06/18 111557777  윤정원              3
18/06/18 111557777  윤정원              2
18/06/18 111557777  윤정원              2
18/06/18 111557777  윤정원              4
18/06/18 111557777  윤정원              4
18/06/18 111557777  윤정원              2
18/06/18 111557777  윤정원              2
18/06/18 111558888  김석환              4
18/06/18 111558888  김석환              2
18/06/18 111558888  김석환              3

ORDER_DA CLIENT_ID  NAME            COUNT
-------- ---------- ---------- ----------
18/06/17 111667777  최하선              2
18/06/19 111669999  육병주              2
18/01/25 111669999  육병주              2
18/06/19 111669999  육병주              2
18/06/19 111669999  육병주              2
18/01/25 111669999  육병주              2
18/06/19 111669999  육병주              2
18/06/19 111669999  육병주              2
18/01/25 111669999  육병주              2
18/06/19 111669999  육병주              2
18/06/19 111669999  육병주              2

ORDER_DA CLIENT_ID  NAME            COUNT
-------- ---------- ---------- ----------
18/01/25 111669999  육병주              2
18/06/19 111669999  육병주              2
18/02/10 111779999  홍성찬              2
18/06/18 111779999  홍성찬              2
18/02/10 111779999  홍성찬              2
18/06/18 111779999  홍성찬              2
18/06/19 222334444  최라정              2
18/06/19 222334444  최라정              3
18/06/19 222334444  최라정              1
18/06/15 222334466  이예주              2
18/06/19 222334488  손소혜              1

ORDER_DA CLIENT_ID  NAME            COUNT
-------- ---------- ---------- ----------
18/06/18 222334488  손소혜              1
18/06/19 222334488  손소혜              3
18/06/18 222334488  손소혜              3
18/01/15 222336666  마영란              4
18/03/05 222336666  마영란              4
18/01/15 222336666  마영란              4
18/03/05 222336666  마영란              4
18/06/18 222338888  최강혜              2
18/06/18 222338888  최강혜              3
18/06/19 222339999  김서정              2
18/06/18 222445555  한선옥              4

ORDER_DA CLIENT_ID  NAME            COUNT
-------- ---------- ---------- ----------
18/06/15 222445555  한선옥              4
18/06/14 222445555  한선옥              4
18/06/18 222445555  한선옥              1
18/06/15 222445555  한선옥              1
18/06/14 222445555  한선옥              1
18/06/18 222445555  한선옥              3
18/06/15 222445555  한선옥              3
18/06/14 222445555  한선옥              3
18/06/18 222445555  한선옥              4
18/06/15 222445555  한선옥              4
18/06/14 222445555  한선옥              4

ORDER_DA CLIENT_ID  NAME            COUNT
-------- ---------- ---------- ----------
18/06/18 222445555  한선옥              4
18/06/15 222445555  한선옥              4
18/06/14 222445555  한선옥              4
18/04/26 222446666  마순하              2
18/03/01 222449999  길기연              4
18/06/15 222449999  길기연              4
18/03/01 222449999  길기연              4
18/06/15 222449999  길기연              4
18/06/18 222556666  송태연              2
18/06/18 222557777  조혜린              2
18/06/15 222559999  윤근혜              1

ORDER_DA CLIENT_ID  NAME            COUNT
-------- ---------- ---------- ----------
18/06/19 222778888  최라정              2
18/06/15 222778888  최라정              2
18/06/19 222778888  최라정              2
18/06/15 222778888  최라정              2
18/06/19 222779999  한가온              1
18/06/15 222779999  한가온              1
18/06/19 222779999  한가온              2
18/06/15 222779999  한가온              2
18/02/15 222889999  마세연              3
18/02/15 222889999  마세연              2

87 행이 선택되었습니다.
*/

-- 4) Type 2: Multi-way join with join predicates in WHERE
-- 약을 주문받은 약사의 이름과 그 약사가 일하고 있는 약국이름 조회(중복 제거)
SELECT DISTINCT C.Name, P.Name
FROM CHEMIST C, PHARMACY P, M_ORDER O
WHERE P.Pharmacy_num = C.Pharmacy_num AND O.Chemist_ID = C.ID;
/*
NAME       NAME
---------- ------------------------------
최소윤     덕양메디칼약국
최서현     동보약국
배지호     강동태평양약국
최준혁     꿈이있는온누리약국
도예은     나현약국
배수아     부민약국
배시우     간석온누리약국
박서윤     강남약국
박서연     강동성실약국
최은우     갤러리약국
배동현     길동보룡약국

NAME       NAME
---------- ------------------------------
손민재     나래약국
박시윤     노닐약국
박예나     부광약국
이지우     강남새천년온누리약국
김지훈     강남효약국
배채원     갤러리약국
박도현     남구로약국
도준우     더클래식약국
이민준     365정화약국
최시아     낙산약국
손유주     봉명메디칼약국

NAME       NAME
---------- ------------------------------
최지안     365종로약국
김서준     7번약국
도예준     가나안약국
배유준     나래종로약국
배지윤     남수원약국
최주원     남춘천대형약국
도건우     대황약국
손우진     더밝은약국
최예린     복음약국
이도윤     가람약국
최서진     기린약국

NAME       NAME
---------- ------------------------------
최서아     도원약국
배윤서     동산약국
이지민     강남웰약국
손지유     남산태평양약국

37 행이 선택되었습니다.
*/

-- 5) Type 3: Aggregation + multi-way join with join predicates + with GROUP BY (e.g. TPC-H Q5)
-- have와 symptom이 natural join 된 테이블에서 symptom_num을 카운트하고 거기에 매칭되는 name
SELECT SYMPTOM_NUM, name, count(*)
FROM HAVE NATURAL JOIN SYMPTOM 
GROUP BY SYMPTOM_NUM, symptom.NAME;
/*
SYMPTOM_NUM NAME                   COUNT(*)
----------- -------------------- ----------
          1 두통                          3
          2 두통                          2
          3 두통                          1
          7 근육통                        3
          8 근육통                        2
          9 근육통                        4
         10 염좌                          1
         11 염좌                          1
         16 발열                          4
         17 발열                          3
         18 발열                          1

SYMPTOM_NUM NAME                   COUNT(*)
----------- -------------------- ----------
         30 인후통                        3
         31 복통                          1
         32 복통                          3
         34 소화불량                      2
         35 소화불량                      5
         36 소화불량                      4
         37 식체(체함)                    3
         39 식체(체함)                    4

19 행이 선택되었습니다.
*/


-- 6) Type 3: Aggregation + multi-way join with join predicates + with GROUP BY (e.g. TPC-H Q5)
-- 약 별 스톡의 평균
select name, avg(stock)
from m_store natural join medicine
group by name;
/*
NAME                                               AVG(STOCK)
-------------------------------------------------- ----------
아겐에프연질캡슐                                         13.8
다나젠실로스타졸서방캡슐200mg                            11.8
파노신정(배농산급탕)                                        4
아가론주                                           17.6666667
카노아정                                           23.6666667
라게브리오캡슐                                          17.75
타그랍캡슐                                         11.6666667
다나립틴정100mg                                    16.4285714
타이레놀정160mg                                         17.75
자나팜정0.4mg                                            16.8
하나니트로글리세린설하정0.6mg                            14.8

NAME                                               AVG(STOCK)
-------------------------------------------------- ----------
카나가바로틴캡슐100mg                                    12.5
아기오과립                                                 18
사르트정                                                 19.6
아가메이트젤리                                             15
타가메트정400mg                                    15.1666667
아나레보정                                         13.8333333
사로프람정20mg                                             18
가나톤정50mg                                               13
다나립틴정25mg                                           17.5
나노파모정10mg                                           13.2
타낙셀주                                           13.6666667

NAME                                               AVG(STOCK)
-------------------------------------------------- ----------
카노아연질캡슐                                             17
까스활명수큐액                                             16
파나실린정                                              13.75
파데나필정20mg                                     19.6666667
아겐에프정                                                 17
가네맥스에프연질캡슐                               7.66666667
라니단정150mg                                            24.5
나그란구강붕해정2.5mg                                    15.5
바라엔터정0.5mg                                          19.2
다나쿨카타플라스마                                 7.66666667
타나민정120mg                                              27

NAME                                               AVG(STOCK)
-------------------------------------------------- ----------
가네치온정100mg                                          16.5
바라엔터정1mg                                           20.25
챔바스정1mg                                              12.8
나그린정90mg                                       13.4444444
카나가바로틴캡슐300mg                                      11
자누글루정100mg                                            16
챔스탑정0.5mg                                           19.25
자나팜정0.5mg                                               5
타나민정                                                   23
아그릴정2mg                                              10.5
사로프람정10mg                                             11

NAME                                               AVG(STOCK)
-------------------------------------------------- ----------
다나젠실로스타졸서방캡슐100mg                            13.2
바독펜정                                                 11.5
카네마졸질정100mg                                          21
가네맥스연질캡슐                                           27
바라크로스구강용해필름1mg                                  17

49 행이 선택되었습니다.
*/

-- 7) Type 4: Subquery (e.g. TPC-H Q2) 
-- 서울 약국에 근무하는 약사 이름 아이디
SELECT ID, Name
FROM CHEMIST
WHERE Pharmacy_num IN (SELECT Pharmacy_num FROM PHARMACY WHERE Address LIKE '서울특별시%');
/*
        ID NAME
---------- ----------
         0 이민준
         1 최지안
         3 김서준
         4 김하준
         5 이이서
         6 도예준
         9 이지우
        11 이지민
        13 박서연
        14 배지호
        15 손아윤

        ID NAME
---------- ----------
        17 배채원
        18 최서진
        19 박지아
        20 배동현
        21 최준혁
        25 도예은
        27 박도현
        34 김은서
        35 손우진
        37 도준우
        40 도지후

        ID NAME
---------- ----------
        41 최서아
        42 최민성
        43 최서현

25 행이 선택되었습니다.
*/


-- 8) Type 4: Subquery (e.g. TPC-H Q2) 
-- 두통 증상을 가지고 있다고 한 고객의 이름, 전화번호
SELECT Name, Phone_num
FROM CLIENT, HAVE
WHERE Symptom_num IN (SELECT Symptom_num FROM SYMPTOM WHERE Name = '두통') AND ID = Client_ID;
/*
NAME       PHONE_NUM
---------- ---------------
진서채     01078912001
최청무     01091735559
최라정     01078635648
최라정     01078635648
김숙형     01032603055
손소혜     01057600592

6 행이 선택되었습니다.
*/


-- 9) Type 5: EXISTS를 포함하는 Subquery (e.g. TPC-H Q4) 
-- ID가 10인 약국에 ID가 10인 약이 존재한다면, 그 약국에 있는 약 이름, 약국 번호
SELECT M_STORE.M_NUMBER,PHARMACY_NUM,NAME
FROM M_STORE, MEDICINE
WHERE EXISTS (
			SELECT *
			FROM M_STORE, PHARMACY
			WHERE M_STORE.M_number=10
			 AND M_STORE.Pharmacy_num=10) 
         AND M_STORE.PHARMACY_NUM=10
	AND M_STORE.M_NUMBER=MEDICINE.M_NUMBER;
/*
  M_NUMBER PHARMACY_NUM NAME
---------- ------------ --------------------------------------------------
         2           10 나그란구강붕해정2.5mg
        10           10 라게브리오캡슐
        31           10 바라엔터정1mg
        51           10 아겐에프연질캡슐
*/

-- 10) Type 5: EXISTS를 포함하는 Subquery (e.g. TPC-H Q4) 
-- ID가 2인 약이 존재하는 약국
SELECT distinct *
FROM PHARMACY 
WHERE EXISTS (
			SELECT *
            			FROM m_store
			WHERE M_number = 2 and PHARMACY.PHARMACY_NUM = m_store.pharmacy_num);
/*
PHARMACY_NUM
------------
ADDRESS
--------------------------------------------------------------------------------
NAME
------------------------------
          10
서울특별시 노원구 상계로 59, 동익빌딩 1층 7,8호 (상계동)
365정화약국

          73
경기도 화성시 봉담읍 와우안길 65 (봉담읍)
남수원약국

PHARMACY_NUM
------------
ADDRESS
--------------------------------------------------------------------------------
NAME
------------------------------
*/



-- 11) Type 6: Selection + Projection + IN predicates (e.g. TPC-H Q18) 
-- 주문번호가 15 이하(초기 주문자)인 클라이언트의 이름, 전화번호 출력
SELECT CLIENT.Name
FROM CLIENT
WHERE CLIENT.ID IN 
(SELECT Client_ID
FROM M_ORDER
WHERE M_ORDER.Order_num<15);
/*
NAME
----------
금송준
박영수
최영호
진서채
김문규
전종훈
최자혁
박서준
이경수
임비산
윤정원

NAME
----------
김석환
최하선
최청무
육병주
홍성찬
이명진
최라정
방희운
이예주
손소혜
김숙형

NAME
----------
마영란
강남하
최강혜
김서정
한선옥
마순하
송호경
길기연
송태연
조혜린
윤근혜

NAME
----------
최라정
한가온
마세연

36 행이 선택되었습니다.
*/


-- 12) Type 6: Selection + Projection + IN predicates (e.g. TPC-H Q18)
-- stock이 5보다 적은 모든 약의 이름
SELECT Name
FROM MEDICINE
WHERE m_number IN 
(SELECT m_number
FROM m_store
WHERE stock<5);
/*
NAME
--------------------------------------------------
타가메트정400mg
타낙셀주
사로프람정10mg
가네맥스에프연질캡슐
파노신정(배농산급탕)
나그린정90mg
카나가바로틴캡슐100mg
바독펜정
타그랍캡슐
아그릴정2mg
아겐에프연질캡슐

NAME
--------------------------------------------------
나노파모정10mg
다나젠실로스타졸서방캡슐200mg
카나가바로틴캡슐300mg
하나니트로글리세린설하정0.6mg
다나립틴정100mg
다나젠실로스타졸서방캡슐100mg
다나쿨카타플라스마

18 행이 선택되었습니다.
*/


-- 13) Type 7: In-line view를 활용한 Query (TPC-H Q9)
-- 경기도에 있는 약국이름과 가지고 있는 약 이름
WITH M1 AS (
SELECT Name, Pharmacy_num, MEDICINE.M_number
FROM MEDICINE, M_STORE
WHERE MEDICINE.M_number = M_STORE.M_number
),
M2 AS (
SELECT Name, M_STORE.Pharmacy_num, M_number
FROM PHARMACY, M_STORE
WHERE PHARMACY.Address LIKE '경기도%' AND PHARMACY.Pharmacy_num = M_STORE.Pharmacy_num 
)
SELECT M1.Name, M2.Name
FROM M1, M2
WHERE M1.Pharmacy_num = M2.Pharmacy_num AND M1.M_number = M2.M_number;
/*
NAME
--------------------------------------------------
NAME
------------------------------
챔스탑정0.5mg
강남약국

바독펜정
강남약국

자누글루정100mg
강남약국


NAME
--------------------------------------------------
NAME
------------------------------
라니단정150mg
강남약국

나그린정90mg
강남효약국

카나가바로틴캡슐100mg
강남효약국


NAME
--------------------------------------------------
NAME
------------------------------
다나쿨카타플라스마
강남효약국

나그란구강붕해정2.5mg
남수원약국

나그린정90mg
남수원약국


NAME
--------------------------------------------------
NAME
------------------------------
카나가바로틴캡슐300mg
남수원약국

타낙셀주
남수원약국

챔바스정1mg
대형약국


NAME
--------------------------------------------------
NAME
------------------------------
카나가바로틴캡슐300mg
대형약국

파나실린정
대형약국

파노신정(배농산급탕)
대형약국


NAME
--------------------------------------------------
NAME
------------------------------
챔바스정1mg
덕양메디칼약국

자나팜정0.4mg
덕양메디칼약국

타나민정
덕양메디칼약국


18 행이 선택되었습니다.
*/

-- 14) Type 7: In-line view를 활용한 Query (TPC-H Q9)
-- 고객이 주문한 약국의 이름과 고객 이름, 전화번호
WITH M1 AS (
SELECT CLIENT.Name, M_ORDER.Client_ID, M_ORDER.Chemist_ID, CLIENT.Phone_num
FROM CLIENT, M_ORDER
WHERE CLIENT.ID = M_ORDER.Client_ID
),
M2 AS (
SELECT PHARMACY.Name, CHEMIST.ID
FROM PHARMACY, CHEMIST
WHERE PHARMACY.Pharmacy_num = CHEMIST.Pharmacy_num
)
SELECT M1.Name, M1.Phone_num, M2.Name
FROM M1, M2
WHERE M1.Chemist_ID = M2.ID;
/*
NAME       PHONE_NUM       NAME
---------- --------------- ------------------------------
길기연     01041283340     365정화약국
마세연     01091347413     365종로약국
마순하     01055028987     7번약국
최라정     01081445090     7번약국
육병주     01035711716     가나안약국
강남하     01017489274     가나안약국
홍성찬     01053097666     가람약국
이명진     01042208559     간석온누리약국
홍성찬     01053097666     강남새천년온누리약국
한선옥     01016458388     강남새천년온누리약국
김석환     01087805664     강남약국

NAME       PHONE_NUM       NAME
---------- --------------- ------------------------------
임비산     01081739829     강남웰약국
최라정     01078635648     강남웰약국
강남하     01017489274     강남웰약국
마영란     01071341481     강남효약국
김석환     01087805664     강동성실약국
이경수     01074337990     강동태평양약국
임비산     01081739829     갤러리약국
마영란     01071341481     갤러리약국
전종훈     01070901229     갤러리약국
송호경     01034984693     기린약국
김문규     01077949214     길동보룡약국

NAME       PHONE_NUM       NAME
---------- --------------- ------------------------------
최청무     01091735559     길동보룡약국
마세연     01091347413     길동보룡약국
육병주     01035711716     꿈이있는온누리약국
금송준     01040868044     나래약국
윤정원     01095600445     나래종로약국
육병주     01035711716     나래종로약국
최강혜     01079060502     나래종로약국
김서정     01089049709     나래종로약국
한선옥     01016458388     나래종로약국
송태연     01048391425     나래종로약국
박영수     01013063170     나현약국

NAME       PHONE_NUM       NAME
---------- --------------- ------------------------------
이예주     01043783774     나현약국
최라정     01078635648     낙산약국
최청무     01091735559     남구로약국
윤정원     01095600445     남산태평양약국
최라정     01078635648     남산태평양약국
한가온     01026417510     남수원약국
한선옥     01016458388     남춘천대형약국
손소혜     01057600592     노닐약국
최자혁     01019209509     대황약국
손소혜     01057600592     더밝은약국
한가온     01026417510     더밝은약국

NAME       PHONE_NUM       NAME
---------- --------------- ------------------------------
최영호     01010297297     더클래식약국
최자혁     01019209509     더클래식약국
이명진     01042208559     더클래식약국
김석환     01087805664     덕양메디칼약국
진서채     01078912001     도원약국
이경수     01074337990     동보약국
방희운     01049849898     동보약국
박서준     01022411111     동산약국
조혜린     01014209259     동산약국
윤정원     01095600445     복음약국
최하선     01041265959     복음약국

NAME       PHONE_NUM       NAME
---------- --------------- ------------------------------
윤근혜     01036834078     복음약국
박영수     01013063170     봉명메디칼약국
김숙형     01032603055     봉명메디칼약국
한선옥     01016458388     봉명메디칼약국
최라정     01081445090     봉명메디칼약국
윤정원     01095600445     부광약국
육병주     01035711716     부광약국
최강혜     01079060502     부광약국
한선옥     01016458388     부광약국
길기연     01041283340     부민약국

65 행이 선택되었습니다.
*/


-- 15) Type 8: Multi-way join with join predicates in WHERE + ORDER BY (e.g. TPC-H Q2)
-- 증상을 선택한 고객 중 남자인 고객이 가지고 있다한 증상 이름과 고객 이름
SELECT CLIENT.Name, SYMPTOM.Name
FROM CLIENT JOIN HAVE ON ID = Client_ID 
JOIN SYMPTOM ON HAVE.Symptom_num = SYMPTOM.Symptom_num
WHERE Sex = 'M'
ORDER BY CLIENT.Name DESC;
/*
NAME       NAME
---------- --------------------
홍성찬     염좌
홍성찬     발열
최하선     근육통
최청무     복통
최청무     두통
최자혁     소화불량
최자혁     근육통
최영호     근육통
진서채     두통
전종훈     근육통
임비산     발열

NAME       NAME
---------- --------------------
임비산     식체(체함)
이명진     발열
이명진     소화불량
이경수     소화불량
이경수     근육통
윤정원     근육통
윤정원     소화불량
윤정원     발열
윤정원     복통
육병주     인후통
육병주     발열

NAME       NAME
---------- --------------------
육병주     염좌
육병주     소화불량
박영수     발열
박영수     식체(체함)
박서준     발열
김석환     소화불량
김석환     식체(체함)
김석환     소화불량
김문규     소화불량
금송준     인후통

32 행이 선택되었습니다.
*/

-- 16) Type 8: Multi-way join with join predicates in WHERE + ORDER BY (e.g. TPC-H Q2)
-- 주문한 고객중 남자인 고객 이름과 약 이름
SELECT CLIENT.Name, MEDICINE.Name
FROM CLIENT JOIN M_ORDER ON ID = M_ORDER.Client_ID 
JOIN CONTAIN ON M_ORDER.Client_ID = CONTAIN.Client_ID AND M_ORDER.Chemist_ID = CONTAIN.Chemist_ID AND M_ORDER.Order_num = CONTAIN.Order_num
JOIN MEDICINE ON MEDICINE.M_number = CONTAIN.M_number
WHERE Sex = 'M';
/*
NAME       NAME
---------- --------------------------------------------------
금송준     타이레놀정160mg
박영수     타이레놀정160mg
박영수     타이레놀정160mg
최영호     타이레놀정160mg
진서채     타이레놀정160mg
전종훈     타이레놀정160mg
최자혁     타이레놀정160mg
박서준     타이레놀정160mg
이경수     타이레놀정160mg
임비산     타이레놀정160mg
임비산     타이레놀정160mg

NAME       NAME
---------- --------------------------------------------------
윤정원     타이레놀정160mg
윤정원     타이레놀정160mg
윤정원     타이레놀정160mg
윤정원     타이레놀정160mg
김석환     타이레놀정160mg
최하선     타이레놀정160mg
최청무     타이레놀정160mg
최청무     타이레놀정160mg
육병주     타이레놀정160mg
육병주     타이레놀정160mg
홍성찬     타이레놀정160mg

NAME       NAME
---------- --------------------------------------------------
홍성찬     타이레놀정160mg
이명진     타이레놀정160mg
김문규     까스활명수큐액
최자혁     까스활명수큐액
이경수     까스활명수큐액
김석환     까스활명수큐액
김석환     까스활명수큐액
육병주     까스활명수큐액
육병주     까스활명수큐액
이명진     까스활명수큐액

32 행이 선택되었습니다.
*/

-- 17) Type 9: Aggregation + multi-way join with join predicates + with GROUP BY + ORDER BY (e.g. TPC-H Q3)
-- 한 고객이 넣은 주문의 수 조회
SELECT C.ID, C.Name, COUNT(*) as Order_cnt
FROM (CLIENT C JOIN M_ORDER O ON O.Client_ID = C.ID) JOIN CONTAIN CO ON CO.Client_ID = O.Client_ID
WHERE O.Order_num = CO.Order_num
GROUP BY C.ID, C.Name
ORDER BY Order_cnt DESC;
/*
ID         NAME        ORDER_CNT
---------- ---------- ----------
222445555  한선옥              5
111557777  윤정원              4
111669999  육병주              4
222334444  최라정              3
111558888  김석환              3
222449999  길기연              2
222336666  마영란              2
222889999  마세연              2
111668888  최청무              2
111445555  임비산              2
111336666  최자혁              2

ID         NAME        ORDER_CNT
---------- ---------- ----------
222334488  손소혜              2
222779999  한가온              2
222778888  최라정              2
111889999  이명진              2
111224444  박영수              2
111339990  이경수              2
222338888  최강혜              2
222337777  강남하              2
111779999  홍성찬              2
222339999  김서정              1
111335555  전종훈              1

ID         NAME        ORDER_CNT
---------- ---------- ----------
111223344  금송준              1
222556666  송태연              1
222334466  이예주              1
222446666  마순하              1
111667777  최하선              1
111226666  최영호              1
111229999  김문규              1
111227777  진서채              1
222334455  방희운              1
111338888  박서준              1
222559999  윤근혜              1

ID         NAME        ORDER_CNT
---------- ---------- ----------
222557777  조혜린              1
222335555  김숙형              1
222448888  송호경              1

36 행이 선택되었습니다.
*/

-- 18) Type 9: Aggregation + multi-way join with join predicates + with GROUP BY + ORDER BY (e.g. TPC-H Q3)
-- 고객 별 가진 증상의 수와 병력기록에서 증상 수가 많은 순서대로 ID, 이름, 가지고 있던 병력 최대 횟수 조회
SELECT C.ID, C.Name, COUNT(Symptom_num) as Symptom_CNT, MAX(Case_num) as Case_MAX 
FROM (CLIENT C JOIN HAVE H ON H.Client_ID = C.ID) JOIN CASE_HISTORY CA ON CA.Client_ID = C.ID
GROUP BY C.ID, C.Name
ORDER BY Symptom_CNT DESC;
/*
ID         NAME       SYMPTOM_CNT   CASE_MAX
---------- ---------- ----------- ----------
111557777  윤정원              12          3
222445555  한선옥              12          4
222334488  손소혜               8          4
111558888  김석환               6          2
111669999  육병주               4          1
111445555  임비산               4          2
111227777  진서채               3          3
111339990  이경수               2          1
222338888  최강혜               2          1
222337777  강남하               2          1
111335555  전종훈               2          2

ID         NAME       SYMPTOM_CNT   CASE_MAX
---------- ---------- ----------- ----------
111779999  홍성찬               2          1
111224444  박영수               2          1
111668888  최청무               2          1
111336666  최자혁               2          1
222336666  마영란               2          1
111889999  이명진               2          1
222339999  김서정               2          2
111338888  박서준               2          2
111229999  김문규               2          2
111223344  금송준               1          1
111226666  최영호               1          1

ID         NAME       SYMPTOM_CNT   CASE_MAX
---------- ---------- ----------- ----------
222334455  방희운               1          1
222335555  김숙형               1          1

24 행이 선택되었습니다.
*/

-- 19) Type 10: SET operation (UNION, SET DIFFERENCE, INTERSECT 등 중 하나)를 활용한 query
-- 증상번호가 9 인 증상을 갖고있는 고객과 8인 증상을 갖고있는 고객의 합집합
(SELECT H.Client_ID, S.Name, S.Condition
FROM HAVE H, SYMPTOM S
WHERE S.Symptom_num = 9 AND S.Symptom_num = H.Symptom_num )
UNION
(SELECT H.Client_ID, S.Name, S.Condition
FROM HAVE H, SYMPTOM S
WHERE S.Symptom_num = 8 AND S.Symptom_num = H.Symptom_num );
/*
CLIENT_ID  NAME       CONDI
---------- ---------- -----
111226666  근육통     중
111335555  근육통     중
111336666  근육통     상
111339990  근육통     상
222334444  근육통     상
222337777  근육통     상

6 행이 선택되었습니다.
*/

-- 20)  Type 10: SET operation (UNION, SET DIFFERENCE, INTERSECT 등 중 하나)를 활용한 query
-- 아이디가 '111557777'인 고객과 '111558888'인 고객이 공통적으로 갖고있는 증상이름 조회
(SELECT S.Name
FROM HAVE H, SYMPTOM S
WHERE H.Client_ID = '111557777' AND S.Symptom_num = H.Symptom_num )
INTERSECT
(SELECT S.Name
FROM HAVE H, SYMPTOM S
WHERE H.Client_ID = '111558888'  AND S.Symptom_num = H.Symptom_num );
/*
NAME
----------
소화불량
*/

- ***********************************************************
-- phase3에서 추가된 쿼리
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

--1) 병력 조회함수 case search에 쓰인 쿼리 
select Record_date, Record_name from Case_history, Client where Client.ID = Case_history.Client_ID and Client.ID = 'Id';
--key인 ID로 구분해서 본인의 병력 기록 조회하게 했습니다.


--2)
--증상으로 고객을 찾는 함수 Client_Enquiry에 쓰인 쿼리는 
select * from CLIENT, HAVE where Symptom_num in (select Symptom_num from Symptom where name ='Symptom') and ID = Client_ID;
--where문 안에 서브 쿼리 사용, 입력한 증상을 가지고 있는 고객의 모든 정보를 조회합니다.

--이전에 작성한 쿼리 중 특정 증상을 가진 고객의 이름과 전화번호를 조회하는
SELECT Name, Phone_num
FROM CLIENT, HAVE
WHERE Symptom_num IN (SELECT Symptom_num FROM SYMPTOM WHERE Name = '두통') AND ID = Client_ID;

--위의 쿼리를 활용, 고객의 모든 정보 조회 및, 특정 증상 부분을 입력받아 원하는 증상을 가진 고객의 정보를 조회 가능


--3) 자신의 병력을 추가하는 함수 case_insert에 쓰인 쿼리는

select count(*) as cont from CASE_HISTORY where Client_ID = 'Id';
--위 쿼리로 현재 case_history에 병력을 추가하려는 고객의 병력의 개수를 나타내는 case_num를 확인
--Insert INTO CASE_HISTORY VALUES((count+1), TO_DATE('date', 'yyyy-mm-dd'), 'medicine', 'Id');
--case_num값인 count, 입력받은 다른 값을 기반으로 insert합니다


--1) search_medicine(Connection conn, Statement stmt)
  
    select name, price, drug_type, dosing_interval, info 
    from medicine 
    where price<= 10000 and name like'%타이레놀%' 
    and drug_type='알약' and info like '%두통%';
    -- 가격이 10000원 이하이고, 이름에 타이레놀이 들어가며 약의 타입이 알약이고, 두통 증상이 있을때 먹는 약을 검색한다.
    -- 약의 가격, 이름, 타입, 증상을 이용하여 필요한 약을 검색하는 기능

-- 2) search_parmacy(Connection conn, Statement stmt)
    
    select distinct p.name, p.Address 
    from pharmacy p inner join m_store s 
    on p.pharmacy_num=s.pharmacy_num 
    inner join medicine m 
    on s.m_number=m.m_number
    where m.name like '%타이레놀%' and p.Address like '%서울특별시%';
    -- 타이레놀이 있는 서울특별시 내의 약국을 검색
    -- 본인 지역에서 필요한 약이 있는 약국을 검색하는 기능

-- 3) medicen_stock(Connection conn, Statement stmt, String chemistID)
    
    select m.m_number, m.stock 
    from M_STORE m inner join chemist c 
    on m.pharmacy_num=c.pharmacy_num 
    where c.ID = 10 and m.m_number = 3;
    -- 약사 ID가 10인 약사가 일하는 약국에서 약 번호가 3번인 약의 수량을 찾는 쿼리
    -- 약사 로그인시 받아둔 약사 ID와 검색하는 약의 번호를 이용해 약의 존재 여부 및 남은 약의 수량을 찾음

-- 4) pharmacy_num(Connection conn, Statement stmt, String chemistID)

    select pharmacy_num 
    from chemist 
    where ID=10;
    -- 약사 ID가 10번인 약사가 일하는 약국의 번호를 반환.
    -- 약사가 로그인 하고, 약사가 일하는 약국을 알아야 하는 경우 사용
    
-- 5) m_insert(Connection conn, Statement stmt, String p_num)

    INSERT INTO M_STORE VALUES (10,11,12);
    -- 약 번호가 10인 약을 약국번호가 11인 약국에 12개의 수량만큼 넣어줌

-- 6) m_update(Connection conn, Statement stmt, String p_num, String m_num)

    update m_store set stock = 12 
    where m_number=11 
    and pharmacy_num =13;
    -- 약국 번호가 13인 약국에 존재하는 약 번호가 11인 약의 수량을 12로 바꿔줌

-- 7) m_delete(Connection conn, Statement stmt) 

    delete from m_store where stock=0;
    -- 수량이 0인 약을 삭제함 약국에서 가지고 있는 수량을 나타내는 m_store에서 삭제함