3)SQL 실행 환경

윈도우 
- sqlplus에서 @Team11-Phase2-2.sql 와 같이 파일을 실행 할 시 insert할 때
한글 깨짐 현상이 있습니다. 
-> .sql 파일을 메모장 등의 다른 프로그램으로 열어서
전체 복사 붙여넣기 하면 깨짐현상 없이 결과를 확인할 수 있습니다.

리눅스
- 리눅스 환경에서 Docker를 사용해서 oracle19db 이미지를 사용하고 있습니다.
- 실행은 SQL Developer에서 @/’경로’+파일이름 키워드를 사용했습니다.