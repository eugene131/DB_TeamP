package medic;

import java.sql.*;
import java.util.*;
import java.util.Scanner;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;

public class medicJDBC {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:MONGO";
	public static final String USER_UNIVERSITY = "medic";
	public static final String USER_PASSWD = "1234";

	public static void main(String[] args) {
		Connection conn = null; // Connection object
		Statement stmt = null; // Statement object

		System.out.print("Driver Loading: ");
		try {
			// Load a JDBC driver for Oracle DBMS
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// Get a Connection object 
			System.out.println("Success!");
		} catch (ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}

		// Make a connection
		try {
			conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD);
			stmt = conn.createStatement();
			System.out.println("Oracle Connected.\n");
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
			System.err.println("Cannot get a connection: " + ex.getMessage());
			System.exit(1);
		}

		// login
		System.out.println("-------------------------------------");
		System.out.println("1. 고객 로그인");
		System.out.println("2. 약사 로그인");
		System.out.print("* 번호 입력: ");
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		sc.nextLine();
		ResultSet rs = null;
		switch (n) {
			case 1:
				System.out.print("client ID: ");
				String clientID = sc.nextLine();

				// 존재하는 client ID인지 확인

				try {
					//stmt = conn.createStatement();
					// Q1: Complete your query.
					String sql = "SELECT ID"
							+ " FROM CLIENT"
							+ " WHERE ID = '" + clientID + "'";
					rs = stmt.executeQuery(sql);

					int cnt = 0;
					while (rs.next()) {
						// Fill out your code	
						rs.getString(1);
						cnt++;
					}
					if (cnt == 0) {
						System.out.println("* 존재하지 않는 clientID 입니다. 입력값: " + clientID);
						System.out.println("* 프로그램을 종료합니다.");
						System.exit(1);
					} else {
						System.out.println("* 로그인 성공");
					}
					System.out.println("\n");
					//stmt.close();
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				while (true) {
					System.out.println("-----------------------------------");
					System.out.println("1. 약 검색");
					System.out.println("2. 약국 이름 검색");
					System.out.println("3. 약국 위치 검색");
					System.out.println("4. 이전 주문기록 조회");
					System.out.println("5. 병력기록 추가");
					System.out.println("6. 개인정보 수정");
					System.out.println("0. 종료\n");

					System.out.print("* 번호 입력: ");
					int i = sc.nextInt();
					sc.nextLine();
					System.out.println("");
					switch (i) {
						case 0:
							System.out.println("* 프로그램을 종료합니다.");
							System.exit(0);
							break;
						case 1:
							System.out.println("1");
							search_medicine(conn, stmt);
							break;
						case 2:
							System.out.println("2");
							search_parmacy(conn, stmt);
							break;
						case 3:
							System.out.println("3");
							break;
						case 4:
							System.out.println("4");
							break;
						case 5:
							System.out.println("5");
							break;
						case 6:
							System.out.println("6");
							break;
						default:
							System.out.println("잘못된 입력입니다.");
					}
				}

			case 2:
				System.out.print("client ID: ");
				String chemistID = sc.nextLine();

				// 존재하는 client ID인지 확인
				try {
					// Q1: Complete your query.
					String sql = "SELECT ID"
							+ " FROM CHEMIST"
							+ " WHERE ID = '" + chemistID + "'";
					rs = stmt.executeQuery(sql);

					int cnt = 0;
					while (rs.next()) {
						// Fill out your code	
						rs.getString(1);
						cnt++;
					}
					if (cnt == 0) {
						System.out.println("* 존재하지 않는 chemistID 입니다. 입력값: " + chemistID);
						System.out.println("* 프로그램을 종료합니다.");
						//stmt.close(); 
						System.exit(1);
					} else {
						System.out.println("* 로그인 성공");
					}
					System.out.println("\n");
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				while (true) {
					System.out.println("-----------------------------------");
					System.out.println("1. 고객 조회");
					System.out.println("2. 약 주문 기록 조회");
					System.out.println("3. 약 재고 조회");
					System.out.println("0. 종료\n");

					System.out.print("* 번호 입력: ");
					int i = sc.nextInt();
					sc.nextLine();
					System.out.println("");
					switch (i) {
						case 0:
							System.out.println("* 프로그램을 종료합니다.");
							System.exit(0);
							break;
						case 1:
							System.out.println("1");
							break;
						case 2:
							System.out.println("2");
							break;
						case 3:
							System.out.println("3");
							medicen_stock(conn, stmt, chemistID);
							break;
						default:
							System.out.println("잘못된 입력입니다.");
					}
				}
			default:
				System.out.println("* 잘못된 입력입니다.");
				System.out.println("* 프로그램을 종료합니다.");
				System.exit(1);
		}

		// my function

		//pharmacy_location(conn, stmt);
		//update_client_info(conn, stmt, "111223333");
		//show_medicine_history(conn, stmt);
	}

	//search medicine
	public static void search_medicine(Connection conn, Statement stmt) {//약을 찾는 함수
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		String condition, m_name, m_type = "";
		int price, m_type_num;
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ 증상에 따른 약 조회 ] --------");
		System.out.println("증상을 입력해 주세요.");
		condition = sc.nextLine();

		System.out.println("가격을 입력해 주세요. 입력하신 가격보다 낮은 가격을 가진 약들이 표시 됩니다.");
		price = sc.nextInt();

		System.out.println("약 이름을 입력해 주세요.");
		m_name = sc.nextLine();

		System.out.println("타입을 선택해 주세요.");
		System.out.println("1. 알약 2. 캡슐 3. 병");
		m_type_num = sc.nextInt();

		if (m_type_num == 1) {
			m_type = "알약";
		} else if (m_type_num == 2) {
			m_type = "캡슐";
		} else if (m_type_num == 3) {
			m_type = "병";
		}
		try {
			// Q1: Complete your query.
			stmt = conn.createStatement();
			String sql = "select name, price, drug_type, dosing_interval, info "//쿼리문
					+ "from medicine "
					+ "where price<=" + price + " and name like'%"
					+ m_name.replace("\n", "") + "%' and drug_type='"
					+ m_type.replace("\n", "") + "' and info like '%" + condition.replace("\n", "") + "%'";
			rs = stmt.executeQuery(sql);//sql 적용
			ResultSetMetaData rsmd = rs.getMetaData();
			System.out.println("<< query 1 result >>");
			int cnt = rsmd.getColumnCount();
			for (int i = 1; i <= cnt; i++) {
				if (i != cnt)
					System.out.print(rsmd.getColumnName(i) + " | ");//컬럼명 출력
				else
					System.out.print(rsmd.getColumnName(i));//컬럼명 출력
			}
			System.out.println("\n<< 약 검색 결과 >>");
			System.out.println("약 이름 | 가격 | 약 타입 | 복용 용량 | 주의 사항");

			System.out.println();
			//select결과 출력
			while (rs.next()) {//튜플 내용 출력
				System.out.print(rs.getString(1) + " | ");
				System.out.print(rs.getString(2) + " | ");
				System.out.print(rs.getString(3) + " | ");
				System.out.print(rs.getString(4) + " | ");
				System.out.println(rs.getString(5));
				// Fill out your code		
			}
			rs.close();

			System.out.println();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.err.println("Cannot get a connection: " + e.getLocalizedMessage());
			System.err.println("Cannot get a connection: " + e.getMessage());
		}
	}

	//===============================약국 찾기================================
	public static void search_parmacy(Connection conn, Statement stmt) {
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		String m_name, address;
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ 약국 조회 ] --------");
		System.out.println("필요하신 약 이름을 입력해 주세요. 해당 약이 있는 약국을 찾아드립니다.");
		m_name = sc.nextLine();
		System.out.println("약국의 주소를 입력해 주세요.");
		address = sc.nextLine();
		try {
			// Q1: Complete your query.
			String sql = "select distinct p.name, p.Address "//쿼리문 입력
					+ "from pharmacy p inner join m_store s "
					+ "on p.pharmacy_num=s.pharmacy_num "
					+ "inner join medicine m "
					+ "on s.m_number=m.m_number "
					+ "where m.name like '%" + m_name.replace("\n", "") + "%' and p.Address like '%" + address.replace("\n", "")
					+ "%'";
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			System.out.println("<< query 2 result >>");
			int cnt = rsmd.getColumnCount();
			//컬럼 네임 출력
			for (int i = 1; i <= cnt; i++) {
				if (i != cnt)
					System.out.print(rsmd.getColumnName(i) + " | ");
				else
					System.out.print(rsmd.getColumnName(i));
			}

			System.out.println("\n<< 약국 검색 결과 >>");
			System.out.println("약국 이름 | 약국 주소");
			System.out.println();
			//튜플 내용 출력
			while (rs.next()) {
				System.out.print(rs.getString(1) + " | ");
				System.out.println(rs.getString(2));
				// Fill out your code		
			}
			rs.close();

			System.out.println();

			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	//====================재고 조회 & 수량 변경, 수량이 0인 약들 삭제========================
	public static void medicen_stock(Connection conn, Statement stmt, String chemistID) {
		//default = input is parmercy's ID
		Scanner sc = new Scanner(System.in);
		String p_num = "", m_num = "";
		int menu = 0, checkpoint = 0;//checkpoint는 쿼리 출력 내용이 있는지 확인하고, 추후 insert와 update를 결정한다.
		System.out.println("-------< 남은 약의 수량 조회, 수정 >-----------");

		System.out.println("찾으실 약의 번호를 입력해 주세요");
		int medicine_num = sc.nextInt();
		ResultSet rs = null;
		try {
			// Q1: Complete your query. 2 is m_num, 10 is p_num, 23 is stock
			String sql = "select m.m_number, m.stock, c.pharmacy_num "
					+ "from M_STORE m inner join chemist c "
					+ "on m.pharmacy_num=c.pharmacy_num "
					+ "where c.ID = " + chemistID + " and m.m_number = " + medicine_num;
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			System.out.println("<< query 조희 result >>");
			System.out.println("약 번호 | 약 수량");
			while (rs.next()) {

				System.out.print(rs.getString(1) + " | ");
				m_num = rs.getString(1);//약 번호 받기 위해 약 업데이트에 필요
				System.out.println(rs.getString(2));
				p_num = rs.getString(3);//약국 번호 받기 위해서. 나중에 약 추가 or 업데이트에 필요
				checkpoint = 1;
				// Fill out your code		
			}
			rs.close();
			System.out.println();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int insert_check_num = 0;
		if (checkpoint == 0) {//쿼리 출력 결과(조회 결과)가 아무것도 없다면, 
			System.out.println("해당 약을 추가 하시겠습니까? 1. 네 2. 아니요");
			insert_check_num = sc.nextInt();
			if (insert_check_num == 1)
				menu = 1;//insert로 보내야 함
		} else {//쿼리 출력 결과가 존재 한다면,
			System.out.println("약의 수량을 변경 하시겠습니까? 1. 네 2. 아니요");
			int update_check_menu = sc.nextInt();
			if (update_check_menu == 1) {
				menu = 2;
			}

		}

		System.out.println();
		if (menu == 1) {//아무것도 없을 때 인서트
			m_insert(conn, stmt, p_num);
		} else if (menu == 2) {
			m_update(conn, stmt, p_num, m_num);
		}
		m_delete(conn, stmt);//stock이 0인 것들 모두 삭제 => 매번 돌 때마다 수량이 0인 약을 삭제할 필요가 있음

	}

	public static void m_insert(Connection conn, Statement stmt, String p_num) {//p_num은 insert에 필요한 약국 번호
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		int m_number, m_stock;
		System.out.println("약 추가를 선택하셨습니다.");
		System.out.println("추가하실 약의 번호를 입력해 주세요.");
		//약 번호 인풋
		m_number = sc.nextInt();
		System.out.println("추가되는 약의 수량를 입력해 주세요.");
		//약 수량 인풋
		m_stock = sc.nextInt();
		try {
			String sql = "INSERT INTO M_STORE VALUES (" + m_number + "," + p_num + "," + m_stock + ")";
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			System.out.println("<< query insert result >>");
			rs.close();
			System.out.println();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void m_update(Connection conn, Statement stmt, String p_num, String m_num) {//p_num, m_num은 업데이트에 필요한 구문
		//delete qury
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		System.out.println("변경하실 수량을 입력해 주세요");
		int stock = sc.nextInt();
		try {
			// Q1: Complete your query.
			String sql = "update m_store set stock = " + stock + " where m_number=" + m_num + " and pharmacy_num =" + p_num;
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			System.out.println("<< query update result >>");
			rs.close();
			System.out.println();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void m_delete(Connection conn, Statement stmt) {//스톡 0인 M_store 삭제
		//update qury
		ResultSet rs = null;
		try {
			// Q1: Complete your query.
			String sql = "delete from m_store where stock=0";
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			System.out.println("<< query delete result >>");
			rs.close();
			System.out.println();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
