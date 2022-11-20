# DB README

## 고객 로그인

---

1. 약 검색
    - search_medicine(conn,stmt)
        - 증상, 가격, 약 이름 그리고 약의 타입(알약 등)에 따라 약을 검색
            - 증상은 증상이 info에 있는지 ‘%%’를 활용해서 해당하는 증상이 info에 포함되어 있는지 확인함
            - 가격은 입력한 가격보다 낮은 가격의 약을 찾는다
2. 약국 이름 검색
    - search_parmacy(conn, stmt)
        - 약의 이름과 지역을 통해 입력한 약이 있고, 그 지역에 있는 약국을 검색한다
            - 약의 이름과 지역 모두 ‘%%’를 활용해서 해당하는 단어가 있는 약과 지역을 확인한다.
3. 약국 위치 검색
    - pharmacy_location(conn, stmt)
        - 약국의 이름과 약국의 주소를 출력해주는 함수이다. 쿼리에서 검색할 때 LIKE '%name%' 을 사용하였기 때문에 이름의 일부만 입력해도 입력한 문자열이 포함된 약국은 모두 출력된다.
4. 주문 추가 및 삭제
    - medicine_order(conn,stmt,clientID)
        - 약 번호 찾기, 약 주문기록 조회, 약 주문, 약 주문 취소 4가지 기능이 있다.
            - 약 번호 찾기: 찾고자 하는 약의 이름을 입력하면 해당하는 약의 번호를 출력해준다.
            (찾은 약 번호는 추후에 약을 주문할 때 사용된다.)
            - 약 주문기록 조회: 주문번호와 주문을 받았던 약사 ID를 통해서 이전에 주문했던 기록을 조회할 수 있다.
            - 약 주문: 약번호, 수량, 주문날짜, 처방전 유무, 약사 ID, 주문 번호를 입력하여 약을 주문할 수 있다.
            - 약 주문 취소: 주문번호와 주문을 받았던 약사 ID를 통해 이전에 했던 약 주문을 취소할 수 있다.
5. 병력 기록 조회
    - case_search(conn, stmt, clientID)
        - 사용자의 ID를 받아서 db에 저장되어있는 자신의 CASE_HISTORY, 병력기록을 조회하는 기능
        - main에서 로그인 할 때 사용했던 ID를 받아와서 입력하는 번거러움이 없다
        - 쿼리 결과를 읽은 후, 조회된 기록이 없을 시 기록이 없다고 알림
        - 쿼리
            - 병력 조회함수 case search에 쓰인 쿼리는
            select Record_date, Record_name from Case_history, Client where [Client.ID](http://client.id/) = Case_history.Client_ID and [Client.ID](http://client.id/) = 'Id'
            key인 ID로 구분해서 본인의 병력 기록 조회하게 했습니다.
6. 병력 기록 추가
    - case_insert(conn, stmt, clientID)
        - main에서 사용자의 ID를 받아와서 사용, 사용자가 직접 내용을 입력하여 db에 자신의 병력 기록을 추가하는 기능
        - 자신이 처방받은 날짜와 처방받은 약을 입력하는 것으로 기록을 추가할 수 있다.
        - 처방받은 날짜는 정해진 형식(yyyy-mm-dd)를 지켜서 입력되어야 한다. 지켜지지 않을 경우 잘못된 형식임을 알려준 뒤 기록 추가를 하지 않는다.
        - 처방받은 약은 db의 medicine에 저장된 약의 이름과 같아야 한다.지켜지지 않을 경우 잘못된 이름임을 알려준 뒤 기록 추가를 하지 않는다.
        - count(*)를 이용, case_history에 저장된 자신의 기록의 수를 나타내는 case_num을 구한 후 insert에 넣을 값으로 처방날짜, 처방된 약, ID와 같이 사용한다.
        - 쿼리
            - 자신의 병력을 추가하는 함수 case_insert에 쓰인 쿼리는
            select count(*) as cont from CASE_HISTORY where Client_ID = Id
            위 쿼리로 현재 case_history에 병력을 추가하려는 고객의 병력의 개수를 나타내는 case_num를 확인
            Insert INTO CASE_HISTORY VALUES((count+1), TO_DATE('date', 'yyyy-mm-dd'), 'medicine', 'Id')
            case_num값인 count, 입력받은 다른 값을 기반으로 insert합니다
7. 개인정보 수정
    - update_client_info(conn, stmt, clientID)
        - 로그인 때 사용했던 client_ID를 바탕으로 개인정보를 수정할 수 있다. 개인정보 수정 메뉴에 들어가면 이름, 성별, 생일, 주소, 전화번호를 조회할 수 있으며 수정할 수 있는 정보는 주소, 전화번호가 있다.

### 2. 약사 로그인

---

1. 고객 조회
    - Cliebt_Enquiry(conn, stmt)
        - 자신의 증상을 저장한 고객들 중 특정 증상을 가지고 있는 고객이 누구인지 조회하기 위해 약사가 사용하는 기능
        - SYMPTOM에 저장되어 있는 증상의 이름을 조회한 후 입력을 위한 보기로 보여준다.
        - 입력받은 값과 저장되어 있는 증상의 이름 비교, 잘못 입력한 경우 잘못 입력한 것을 알려준 뒤 기능을 수행하지 않는다.
        - 고객의 정보를 조회 후 있으면 출력, 없으면 조회된 정보가 없음을 알려준다.
        - 쿼리
            - 증상으로 고객을 찾는 함수 Client_Enquiry에 쓰인 쿼리는
            select * from CLIENT, HAVE where Symptom_num in (select Symptom_num from Symptom where name ='Symptom') and ID = Client_ID
            where문 안에 서브 쿼리 사용, 입력한 증상을 가지고 있는 고객의 모든 정보를 조회합니다.
                
                이전에 작성한 쿼리 중 특정 증상을 가진 고객의 이름과 전화번호를 조회하는
                SELECT Name, Phone_num
                FROM CLIENT, HAVE
                WHERE Symptom_num IN (SELECT Symptom_num FROM SYMPTOM WHERE Name = '두통') AND ID = Client_ID
                
                위의 쿼리를 활용, 고객의 모든 정보 조회 및, 특정 증상 부분을 입력받아 원하는 증상을 가진 고객의 정보를 조회 가능
                
2. 약 주문 기록 조회
    - show_medicine_history(conn, stmt)
        - 약 이름 또는 약 번호로 해당 약을 주문했던 모든 고객들의 주문기록을 조회할 수 있다. 조회할 시 고객ID, 약 이름, 주문 날짜, 수량, 처방전 유무 등을 조회할 수 있다.
3. 약 재고 조회
    - medicine_stock(conn,stmt, chemistID)
        - 재고 조회 & 수량 변경, 남은 수량이 0인 약을 약국에서 삭제함
            - 찾을 약을 입력받으면 해당 약사의 아이디, 약의 번호를 통해 해당 약의 수량을 확인한다.
            - 약이 존재하지 않는다면, 그 약을 추가할 것인지 여부를 물어봄
                - 추가할 약의 번호와 수량을 입력 받아 해당 약사의 약국에 insert함
            - 약이 존재한다면, 그 약의 수량을 변경할 것인지 물어봄
                - 해당 약의 수량을 입력 받아 약의 수량을 update함
