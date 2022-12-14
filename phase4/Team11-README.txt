<실행방법>
MedicineDB 프로젝트를 eclipse EE버전에서 import 합니다.
(Eclipse IDE version: 2021-09 (4.21.0), Build id: 20210910-1417)

프로젝트 안에있는
MedicineDB > src > main> webapp 
폴더 안의
login.jsp 파일을 열어서 jdbc 버전과 user, pass등 데이터베이스 정보를 사용자에 맞게 추가합니다.
** (올바른 정보를 입력하지 않으면 실행이 정상적으로 되지 않습니다)
/* (68번째 줄 아래 부분만 변경하면 됩니다.)
String serverIP = "localhost";
String strSID = "orcl";
String portNum = "1521";
String user = "medicine";
String pass = "comp322";
*/

변경된 내용을 저장합니다.

Eclipse IDE 상단바에서 Window > Web Browser를 Chrome으로 바꿔줍니다.

login.jsp와 동일한 경로 안에 있는 (MedicineDB > src > main> webapp)
main.html을 실행합니다.

**테스트 할 시 main.html 실행 후 로그인 할 시 입력하는 ID는 형식이 지정되어 있습니다.
ClientID: 9자리로 된 숫자
ChemistID: 0~49까지의 숫자
**실행하기 전 Phase 2 에서 구성한 데이터와 연동되어야 합니다.
(phase2 파일의 테이블설정하는 부분에 수정이 있어서 phase 3에서 함께 업로드 했던 파일로 구성되어있어야 합니다!!
혹시 모르니 함께 첨부해두었습니다.) -> Team11-Phase2-1.sql, Team11-Phase2-2.sql
--------------------------------------------------------------------------------------------------
<기능설명>

1. 고객 로그인
1) 약 검색
증상, 가격, 약 이름 그리고 약의 타입(알약 등)에 따라 약을 검색
증상은 증상이 info에 있는지 ‘%%’를 활용해서 해당하는 증상이 info에 포함되어 있는지 확인함
가격은 입력한 가격보다 낮은 가격의 약을 찾는다

2) 약국 이름, 위치 검색
약의 이름과 지역을 통해 입력한 약이 있고, 그 지역에 있는 약국을 검색한다
약의 이름과 지역 모두 ‘%%’를 활용해서 해당하는 단어가 있는 약과 지역을 확인한다.

3) 약 주문(새로운 약 주문), 약 주문기록 조회
특정 약 이름으로 해당 약을 주문한 기록을 조회하거나 모든 주문기록을 조회할 수 있다.
(약 이름을 입력하는 칸을 공백으로 둔 후 검색버튼 클릭)
약 주문: 주문번호, 약 이름, 수량, 처방전 유무, 주문받은 약사 이름을 입력하여 약을 주문할 수 있다.

4) 병력 기록 조회 및 추가
-사용자의 ID를 받아서 db에 저장되어있는 자신의 CASE_HISTORY, 병력기록을 조회하는 기능
로그인 할 때 사용했던 ID를 받아와서 입력하는 번거러움이 없다
조회된 기록이 없을 시 기록이 없다고 알림
-병력 기록 추가
main에서 사용자의 ID를 받아와서 사용, 사용자가 직접 내용을 입력하여 db에 자신의 병력 기록을 추가하는 기능
자신이 처방받은 날짜와 처방받은 약을 입력하는 것으로 기록을 추가할 수 있다.
처방받은 날짜는 정해진 형식(yyyy-mm-dd)를 지켜서 입력되어야 한다. 지켜지지 않을 경우 잘못된 형식임을 알려준 뒤 기록 추가를 하지 않는다.
처방받은 약은 db의 medicine에 저장된 약의 이름과 같아야 한다.지켜지지 않을 경우 잘못된 이름임을 알려준 뒤 기록 추가를 하지 않는다.

) 개인정보 수정
로그인 때 사용했던 client_ID를 바탕으로 개인정보를 수정할 수 있다. 
개인정보 수정 메뉴에 들어가면 이름, 성별, 생일, 주소, 전화번호를 조회할 수 있으며 수정할 수 있는 정보는 주소, 전화번호가 있다.


2. 약사 로그인
1) 고객 관리
자신의 증상을 저장한 고객들 중 특정 증상을 가지고 있는 고객이 누구인지 조회하기 위해 약사가 사용하는 기능
SYMPTOM에 저장되어 있는 증상의 이름을 조회한 후 입력을 위한 보기로 보여준다.
고객의 정보를 조회 후 있으면 출력, 없으면 조회된 정보가 없음을 알려준다.

2) 주문관리(새로 들어온 주문 수정 및 삭제 기능)
주문관리 페이지에 들어가면 해당 약사가 받은 주문 기록들을 모두 출력해준다.
주문 수정 버튼을 누를 시 주문날짜, 처방전 유무, 약 이름, 수량을 수정할 수 있다.
주문 삭제 버튼을 누를 시 해당 주문 기록이 데이터베이스에서 삭제된다.
(삭제된 주문 기록은 해당 고객의 주문기록에서도 조회할 수 없다.)

3) 약 재고 조회
재고 조회 & 수량 변경, 남은 수량이 0인 약을 약국에서 삭제함
약 번호를 입력하면, 로그인되어있는 약사가 근무하는 약국의 해당 약의 수량을 확인한다.
약이 존재하지 않는다면, 그 약을 추가할 것인지 여부를 물어봄
추가할 약의 번호와 수량을 입력 받아 해당 약사의 약국에 insert함
약이 존재한다면, 그 약의 수량을 변경할 것인지 물어봄
해당 약의 수량을 입력 받아 약의 수량을 update함