
package lab1;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*; // import JDBC package
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;
import java.util.Scanner;

public class MedicineQuery {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_UNIVERSITY ="test";
	public static final String USER_PASSWD ="comp322";

	// 약국이름으로 약국의 위치 검색
	public static void pharmacy_location(Connection conn, Statement stmt) {
		System.out.println("\n-------------------------------");
		System.out.println("-------- [ 약국 위치 검색 ] --------");
		System.out.print("약국이름: ");
		
		String pharmacy_name = "";

		Scanner sc = new Scanner(System.in);
		pharmacy_name = sc.nextLine();
		
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			// Q1: Complete your query.
			String sql = "SELECT Name, Address"
					+ " FROM PHARMACY"
					+ " WHERE Name LIKE '%"+pharmacy_name+"%'"
					+ " ORDER BY NAME";
			rs = stmt.executeQuery(sql);
			System.out.println("\n<< 약국 검색 결과 >>");
			System.out.println("약국이름 | 주소");
			System.out.println("-------------------------------");
			int cnt = 0;
			while(rs.next()) {
				// Fill out your code	
				String p_name = rs.getString(1);
				String p_address = rs.getString(2);
				System.out.println(p_name +" | " + p_address);
				cnt++;
			}
			if (cnt == 0) {
				System.out.println(pharmacy_name+" (으)로 조회된 약국이 없습니다.");
			}
			System.out.println("\n");
			stmt.close(); 
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 이름, 전화번호, 생일 검색해서 전화번호, 주소 update
	public static void update_client_info(Connection conn, Statement stmt, String clientID) {
		System.out.println("\n-----------------------------------------");
		System.out.println("-------- [ "+clientID+" 님의 개인정보 ] --------");
		
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			// Q1: Complete your query.
			String sql = "SELECT Name, Sex, Birthday, C_address, Phone_num"
					+ " FROM CLIENT"
					+ " WHERE ID = "+clientID;
			rs = stmt.executeQuery(sql);
			
			rs.next();
			String c_name = rs.getString(1);
			String c_sex = rs.getString(2);
			SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy년 MM월 dd일");
			Date Birthday = rs.getDate(3);
			String c_birthday = sdfDate.format(Birthday);
			String c_address = rs.getString(4);
			String c_phone_num = rs.getString(5);
			System.out.println("이름: "+c_name);
			if (c_sex.equals("M"))
				System.out.println("성별: 남");
			else
				System.out.println("성별: 여");
			System.out.println("생일: "+c_birthday);
			System.out.println("주소: "+c_address);
			System.out.println("전화번호: "+c_phone_num);
			System.out.println("\n");
			
			
			System.out.println("* 편집하시겠습니까? [y/n]");
			Scanner sc = new Scanner(System.in);
			String u = sc.nextLine();
			if (u.equals("y") || u.equals("Y")) {
				System.out.println("* 수정하고자 하는 항목을 입력해주세요.");
				System.out.print("주소: ");
				String address = sc.nextLine();
				System.out.print("전화번호: ");
				String phone_num = sc.nextLine();
				if (phone_num.length() != 11) {
					System.out.println("* 잘못된 전화번호 입력입니다.");
				}
				else {
					sql = "UPDATE CLIENT"
							+ " SET C_address = '"+address+"', Phone_num = '"+phone_num+"' "
									+ "WHERE ID = '"+clientID+"'";
					rs = stmt.executeQuery(sql);
					
					System.out.println("* 수정되었습니다.");
					
				}
				
			}
			else if (u.equals("N") || u.equals("n")) {
				System.out.println("* 개인정보 수정을 취소합니다.");
			}
			else {
				System.out.println("* 잘못된 입력입니다.");
			}
			
			stmt.close(); 
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 어떤 약을 선택하면 그 약을 구매했던 주문기록 조회
	public static void show_medicine_history(Connection conn, Statement stmt) {
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ 약 주문 기록 조회 ] --------");
		System.out.println("1. 약 이름으로 조회");
		System.out.println("2. 약 번호로 조회");
		ResultSet rs = null;
		
		System.out.print("* 번호 입력: ");
		Scanner sc = new Scanner(System.in);
		int i = sc.nextInt();
		sc.nextLine();
		
		switch (i) {
			case 1: 
				System.out.print("* 약 이름: ");
				String m_name = sc.nextLine();
				try {
					stmt = conn.createStatement();
					String sql = "SELECT O.Client_ID, M.Name, O.Order_date, C.Count, O.Prescription"
							+ " FROM CONTAIN C JOIN MEDICINE M ON C.M_number = M.M_number, M_ORDER O"
							+ " WHERE C.Order_num = O.Order_num"
							+ " AND C.Chemist_ID = O.Chemist_ID"
							+ " AND C.Client_ID = O.Client_ID"
							+ " AND M.Name LIKE '%"+m_name+"%'"
							+ " ORDER BY O.Order_date";
					
					rs = stmt.executeQuery(sql);
					System.out.println("\n<< 약 주문기록 검색결과 >>");
					System.out.println("고객 ID | 약 이름 | 주문 날짜 | 수량 | 처방전 유무");
					System.out.println("-----------------------------------------");
					int cnt = 0;
					while(rs.next()) {
						// Fill out your code	
						String c_id = rs.getString(1);
						String mname = rs.getString(2);
						SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
						Date o_date = rs.getDate(3);
						String order_day = sdfDate.format(o_date);
						String m_count = rs.getString(4);
						int prescript = rs.getInt(5);
						if (prescript == 1) {
							System.out.println(c_id+" | "+mname+" | "+order_day+" | "+m_count+" | "+"O" );
						}
						else {
							System.out.println(c_id+" | "+mname+" | "+order_day+" | "+m_count+" | "+"X" );
						}
						cnt++;
					}
					if (cnt == 0) {
						System.out.println(m_name+" (으)로 조회된 주문기록이 없습니다.");
					}
					System.out.println("\n");
					stmt.close(); 
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			case 2:
				System.out.print("* 약 번호: ");
				String m_num = sc.nextLine();
				try {
					stmt = conn.createStatement();
					String sql = "SELECT O.Client_ID, M.Name, O.Order_date, C.Count, O.Prescription"
							+ " FROM CONTAIN C JOIN MEDICINE M ON C.M_number = M.M_number, M_ORDER O"
							+ " WHERE C.Order_num = O.Order_num"
							+ " AND C.Chemist_ID = O.Chemist_ID"
							+ " AND C.Client_ID = O.Client_ID"
							+ " AND M.M_number = "+m_num+""
							+ " ORDER BY O.Order_date";
					
					rs = stmt.executeQuery(sql);
					System.out.println("\n<< 약 주문기록 검색결과 >>");
					System.out.println("고객 ID | 약 이름 | 주문 날짜 | 수량 | 처방전 유무");
					System.out.println("-----------------------------------------");
					int cnt = 0;
					while(rs.next()) {
						// Fill out your code	
						String c_id = rs.getString(1);
						String mname = rs.getString(2);
						SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
						Date o_date = rs.getDate(3);
						String order_day = sdfDate.format(o_date);
						String m_count = rs.getString(4);
						int prescript = rs.getInt(5);
						if (prescript == 1) {
							System.out.println(c_id+" | "+mname+" | "+order_day+" | "+m_count+" | "+"O" );
						}
						else {
							System.out.println(c_id+" | "+mname+" | "+order_day+" | "+m_count+" | "+"X" );
						}
						cnt++;
					}
					if (cnt == 0) {
						System.out.println("약 번호 "+m_num+" (으)로 조회된 주문기록이 없습니다.");
					}
					System.out.println("\n");
					stmt.close(); 
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			default:
				System.out.println("* 잘못된 입력입니다.");
				break;
		}
		
		
		
	}

	//병력 기록 추가
	public static void case_insert(Connection conn, Statement stmt, String Id){
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ 병력 기록 추가 ] --------");
		Scanner input = new Scanner(System.in);
		int i = 0;
		String compare1 = "";
		String compare2 = "";
		System.out.println("1.처방받은 날짜를 입력해 주십시오.(ex : yyyy-mm-dd)");
		String date = input.next();
		System.out.println("2.처방받은 약을 입력해 주십시오.");
		String medicine = input.next();
		/*System.out.println("3.ID를 입력해주십시오.");
		String Id = input.next();*/
		ResultSet rs = null;
	
		try {
			stmt = conn.createStatement();
			try {
				SimpleDateFormat test = new SimpleDateFormat("yyyy-MM-dd");
				test.setLenient(false);
				test.parse(date);
				}catch(ParseException e){
					System.out.println("잘못된 날짜 형식입니다.");
				}
			String sql ="select name from medicine";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				compare1 = rs.getString(1);
				if(medicine.equals(compare1)) {
					i++;
					break;
				}
			}
			if(i == 0) {
				System.out.println("데이터 베이스에 존재하지 않는 약입니다");
			}
			
			else{
			sql = "select count(*) as cont from CASE_HISTORY where Client_ID =" + Id;
			rs = stmt.executeQuery(sql);
			int count = 0;
			if(rs.next()) {
				count = rs.getInt(1);
			}
			sql = "Insert INTO CASE_HISTORY VALUES(" + (count+1) + ", TO_DATE('" + date + "', 'yyyy-mm-dd'), '" + medicine +"','" + Id +"')";
			int res = stmt.executeUpdate(sql);
			if(res == 1)
				System.out.println("병력 기록을 성공적으로 추가하였습니다.");
				//conn.commit(); 테스트마다 커밋하면 불편하니까.
			}
			stmt.close(); 
			rs.close();
	}catch(SQLException ex2) {
		ex2.printStackTrace();
	}
}
	
	public static void Client_Enquiry(Connection conn, Statement stmt) {
		ResultSet rs = null;
		Scanner input = new Scanner(System.in);
		int i = 1;
		System.out.println("\n--------------------------------------------------------");
		System.out.println("------------------ [ 증상을 앓는 고객 조회 ] ------------------");
		System.out.println("조회를 원하는 고객의 증상을 아래에서 하나를 선택하여 한글로 입력해 주십시오.");
		try {
			stmt = conn.createStatement();
			String sql = "select Name from SYMPTOM where Condition = '하'";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				String Symptom_Name = rs.getString(1);
				System.out.println(i + "." + Symptom_Name);
				i++;
			}
			i = 0;
			String Symptom = input.nextLine();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				String Symptom_Name = rs.getString(1);
				if(Symptom.equals(Symptom_Name)) {
					i++;
					break;
				}
			}
			if(i == 0) {
				System.out.println("증상을 잘못 입력하셨습니다.");
			}
			else {
			sql = "select * from CLIENT, HAVE where Symptom_num in (select Symptom_num from Symptom where name ='" + Symptom +"') and ID = Client_ID";
			rs = stmt.executeQuery(sql);
			i = 0;
			System.out.println("---------------------------------------------------------------------------------");
			while(rs.next()) {
				i++;
				String Id = rs.getString(1);
				String Name = rs.getString(2);
				String Sex = rs.getString(3);
				String Birth = rs.getString(4);
				String C_address = rs.getString(5);
				String Phone_num = rs.getString(6);
				System.out.println(Id + " | " + Name+ " | " + Sex+ " | " + Birth+ " | " + C_address+ " | " + Phone_num);
			}
			if(i == 0) {
				System.out.println("조회된 정보가 없습니다.");
			}
		}
		stmt.close(); 
		rs.close();
		
	}
		catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
		}
		
}
	
	public static void case_search(Connection conn, Statement stmt, String Id) {
		ResultSet rs = null;
		Scanner input = new Scanner(System.in);
		System.out.println("1.이름을 입력해 주십시오.");
		String Name = input.next();
		System.out.println("2.전화번호를 입력해주십시오.");
		String Phone_num = input.next();
		System.out.println("3.생일을 입력해 주십시오.(ex : yyyy-mm-dd)");
		String Birth = input.next();
		try {
			stmt = conn.createStatement();
			String sql = "select Record_date, Record_name from Case_history, Client where Client.ID = Case_history.Client_ID and Client.Name ='"+ Name +"' and Client.Phone_num = '"+Phone_num+"' and Client.Birthday = '"+Birth+"'";
			//String sql = "select Record_date, Record_name from Case_history, Client where Client.ID = Case_history.Client_ID and Client.ID = '"+Id+"'";
			rs = stmt.executeQuery(sql);
			System.out.println("---------------------------------------------------------------------------------");
			int i=0;
			while(rs.next()) {
				String Record_date = rs.getString(1);
				String Record_name = rs.getString(2);
				System.out.println(Record_date + " | " + Record_name);
				i++;
			}
			if(i==0) {
				System.out.println("기록이 없습니다.");
			}
			rs.close();
			stmt.close();
		}catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
		}
		
	}
	
	
	public static void main(String[] args) {
		Connection conn = null; // Connection object
		Statement stmt = null;	// Statement object
		
		System.out.print("Driver Loading: ");
		try {
			// Load a JDBC driver for Oracle DBMS
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// Get a Connection object 
			System.out.println("Success!");
		}catch(ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}

		// Make a connection
		try{
			conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD); 
			System.out.println("Oracle Connected.\n");
		}catch(SQLException ex) {
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
				stmt = conn.createStatement();
				// Q1: Complete your query.
				String sql = "SELECT ID"
						+ " FROM CLIENT"
						+ " WHERE ID = '"+clientID+"'";
				rs = stmt.executeQuery(sql);

				int cnt = 0;
				while(rs.next()) {
					// Fill out your code	
					rs.getString(1);
					cnt++;
				}
				if (cnt == 0) {
					System.out.println("* 존재하지 않는 clientID 입니다. 입력값: "+clientID);
					System.out.println("* 프로그램을 종료합니다.");
					System.exit(1);
				}
				else {
					System.out.println("* 로그인 성공");
				}
				System.out.println("\n");
				stmt.close(); 
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			while(true) {
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
					break;
				case 2:
					System.out.println("2");
					break;
				case 3:
					System.out.println("3");
					break;
				case 4:
					System.out.println("4");
					case_search(conn, stmt, clientID);
					break;
				case 5:
					System.out.println("5");
					case_insert(conn, stmt, clientID);
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
				stmt = conn.createStatement();
				// Q1: Complete your query.
				String sql = "SELECT ID"
						+ " FROM CHEMIST"
						+ " WHERE ID = '"+chemistID+"'";
				rs = stmt.executeQuery(sql);

				int cnt = 0;
				while(rs.next()) {
					// Fill out your code	
					rs.getString(1);
					cnt++;
				}
				if (cnt == 0) {
					System.out.println("* 존재하지 않는 chemistID 입니다. 입력값: "+chemistID);
					System.out.println("* 프로그램을 종료합니다.");
					System.exit(1);
				}
				else {
					System.out.println("* 로그인 성공");
				}
				System.out.println("\n");
				stmt.close(); 
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			while(true) {
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
					Client_Enquiry(conn, stmt);
					break;
				case 2:
					System.out.println("2");
					break;
				case 3:
					System.out.println("3");
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
		
		/*
		 * case_insert(conn, stmt)
		 * Client_Enquiry(conn, stmt)
		 * case_search(conn, stmt, Id)
		 */
	}
	
	
	
}