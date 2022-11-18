
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*; // import JDBC package
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;
import java.util.Scanner;

public class MedicineQuery {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_UNIVERSITY ="medicine";
	public static final String USER_PASSWD ="comp322";

	// �౹�̸����� �౹�� ��ġ �˻�
	public static void pharmacy_location(Connection conn, Statement stmt) {
		System.out.println("\n-------------------------------");
		System.out.println("-------- [ �౹ ��ġ �˻� ] --------");
		System.out.print("�౹�̸�: ");
		
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
			System.out.println("\n<< �౹ �˻� ��� >>");
			System.out.println("�౹�̸� | �ּ�");
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
				System.out.println(pharmacy_name+" (��)�� ��ȸ�� �౹�� �����ϴ�.");
			}
			System.out.println("\n");
			stmt.close(); 
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// �̸�, ��ȭ��ȣ, ���� �˻��ؼ� ��ȭ��ȣ, �ּ� update
	public static void update_client_info(Connection conn, Statement stmt, String clientID) {
		System.out.println("\n-----------------------------------------");
		System.out.println("-------- [ "+clientID+" ���� �������� ] --------");
		
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
			SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy�� MM�� dd��");
			Date Birthday = rs.getDate(3);
			String c_birthday = sdfDate.format(Birthday);
			String c_address = rs.getString(4);
			String c_phone_num = rs.getString(5);
			System.out.println("�̸�: "+c_name);
			if (c_sex.equals("M"))
				System.out.println("����: ��");
			else
				System.out.println("����: ��");
			System.out.println("����: "+c_birthday);
			System.out.println("�ּ�: "+c_address);
			System.out.println("��ȭ��ȣ: "+c_phone_num);
			System.out.println("\n");
			
			
			System.out.println("* �����Ͻðڽ��ϱ�? [y/n]");
			Scanner sc = new Scanner(System.in);
			String u = sc.nextLine();
			if (u.equals("y") || u.equals("Y")) {
				System.out.println("* �����ϰ��� �ϴ� �׸��� �Է����ּ���.");
				System.out.print("�ּ�: ");
				String address = sc.nextLine();
				System.out.print("��ȭ��ȣ: ");
				String phone_num = sc.nextLine();
				if (phone_num.length() != 11) {
					System.out.println("* �߸��� ��ȭ��ȣ �Է��Դϴ�.");
				}
				else {
					sql = "UPDATE CLIENT"
							+ " SET C_address = '"+address+"', Phone_num = '"+phone_num+"' "
									+ "WHERE ID = '"+clientID+"'";
					rs = stmt.executeQuery(sql);
					
					System.out.println("* �����Ǿ����ϴ�.");
					
				}
				
			}
			else if (u.equals("N") || u.equals("n")) {
				System.out.println("* �������� ������ ����մϴ�.");
			}
			else {
				System.out.println("* �߸��� �Է��Դϴ�.");
			}
			
			stmt.close(); 
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// � ���� �����ϸ� �� ���� �����ߴ� �ֹ���� ��ȸ
	public static void show_medicine_history(Connection conn, Statement stmt) {
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ �� �ֹ� ��� ��ȸ ] --------");
		System.out.println("1. �� �̸����� ��ȸ");
		System.out.println("2. �� ��ȣ�� ��ȸ");
		ResultSet rs = null;
		
		System.out.print("* ��ȣ �Է�: ");
		Scanner sc = new Scanner(System.in);
		int i = sc.nextInt();
		sc.nextLine();
		
		switch (i) {
			case 1: 
				System.out.print("* �� �̸�: ");
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
					System.out.println("\n<< �� �ֹ���� �˻���� >>");
					System.out.println("�� ID | �� �̸� | �ֹ� ��¥ | ���� | ó���� ����");
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
						System.out.println(m_name+" (��)�� ��ȸ�� �ֹ������ �����ϴ�.");
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
				System.out.print("* �� ��ȣ: ");
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
					System.out.println("\n<< �� �ֹ���� �˻���� >>");
					System.out.println("�� ID | �� �̸� | �ֹ� ��¥ | ���� | ó���� ����");
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
						System.out.println("�� ��ȣ "+m_num+" (��)�� ��ȸ�� �ֹ������ �����ϴ�.");
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
				System.out.println("* �߸��� �Է��Դϴ�.");
				break;
		}
		
		
		
	}
	
	// �� �ֹ�
	public static void medicine_order(Connection conn, Statement stmt, String clientID) {
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ �� �ֹ� �� �ֹ���� ] --------");
		System.out.println("1. �� ��ȣ ã��");
		System.out.println("2. �� �ֹ� ��� ��ȸ");
		System.out.println("3. �� �ֹ�");
		System.out.println("4. �� �ֹ� ���");
		ResultSet rs = null;
		
		System.out.print("* ��ȣ �Է�: ");
		Scanner sc = new Scanner(System.in);
		int i = sc.nextInt();
		sc.nextLine();
		
		switch (i) {
			case 1: // ���ο� �ֹ��� ����� ���
				// �ֹ��ϰ��� �ϴ� �� ��ȣ ��ȸ
				System.out.print("\n* �� �̸� �Է�: ");
				String m_name = sc.nextLine();
				try {
					stmt = conn.createStatement();
					String sql = "SELECT M_number, NAME"
							+ " FROM MEDICINE"
							+ " WHERE Name LIKE '%"+m_name+"%'"
							+ " ORDER BY M_number";
					
					rs = stmt.executeQuery(sql);
					System.out.println("\n<< �� �˻���� >>");
					System.out.println("�� ��ȣ | �� �̸� ");
					System.out.println("----------------");
					int cnt = 0;
					while(rs.next()) {
						// Fill out your code	
						String m_num = rs.getString(1);
						String mname = rs.getString(2);
						System.out.println(m_num+" | "+mname);
						cnt++;
					}
					if (cnt == 0) {
						System.out.println("�� �̸� "+m_name+" (��)�� ��ȸ�� ����� �����ϴ�.");
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
				// �� �ֹ���� ��ȸ
				System.out.print("\n* �ֹ� ��ȣ: ");
				String o_num3 = sc.nextLine();
				System.out.print("* ��� ID: ");
				String chemistID3 = sc.nextLine();

				try {
					stmt = conn.createStatement();
					
					String sql = "SELECT Order_num, M_number, Count, Order_date, Prescription, Chemist_ID"
							+ " FROM M_ORDER NATURAL JOIN CONTAIN "
									+ " WHERE Order_num = "+o_num3
									+ " AND Chemist_ID = "+chemistID3;
					
					rs = stmt.executeQuery(sql);
					System.out.println("\n<< �ֹ���� �˻���� >>");
					System.out.println("�ֹ� ��ȣ | �� ��ȣ | ���� | �ֹ� ��¥ | ó���� ���� | ���ID ");
					System.out.println("-----------------------------------------------------");
					int cnt = 0;
					while(rs.next()) {
						// Fill out your code	
						String order_num = rs.getString(1);
						String m_num = rs.getString(2);
						String o_count = rs.getString(3);
						SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
						Date o_date = rs.getDate(4);
						String order_day = sdfDate.format(o_date);
						int prescript = rs.getInt(5);
						String chemist_ID = rs.getString(6);
						if (prescript == 1) {
							System.out.println(order_num+" | "+m_num+" | "+o_count+" | "+order_day+" | "+"O | "+chemist_ID );
						}
						else {
							System.out.println(order_num+" | "+m_num+" | "+o_count+" | "+order_day+" | "+"X | "+chemist_ID );
						}
						cnt++;
					}
					if (cnt == 0) {
						System.out.println("* �ش� ������ �ֹ� ����� �����ϴ�.");
					}
					stmt.close(); 
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					System.out.println("* �ش� ������ �ֹ� ����� �����ϴ�.");
					e.printStackTrace();
				}
				break;
			case 3:
				// �� �ֹ��ϱ�
				String o_prescription = "";
				System.out.print("\n* �� ��ȣ: ");
				String m_num = sc.nextLine();
				System.out.print("* ����: ");
				String m_count = sc.nextLine();
				System.out.print("* �ֹ� ��¥ (yyyy-mm-dd): ");
				String o_date = sc.nextLine();
				System.out.print("* ó���� ����(o/x): ");
				String p = sc.nextLine();
				if (p.equals("o") || p.equals("O"))
					o_prescription = "1";
				else if (p.equals("x") || p.equals("X"))
					o_prescription = "0";
				else {
					System.out.println("* �߸��� �Է��Դϴ�.");
					break;
				}
				System.out.print("* �ֹ����� ��� ID: ");
				String chemistID = sc.nextLine();
				
				System.out.print("* �ֹ� ��ȣ: ");
				String o_num = sc.nextLine();
				
				try {
					stmt = conn.createStatement();
					
					String sql = "INSERT INTO M_ORDER VALUES ("
							+ o_num + ", TO_DATE('" + o_date
									+ "', 'yyyy-mm-dd'), "+o_prescription
									+ ", "+chemistID+", "+clientID+")";
					
					rs = stmt.executeQuery(sql);
					
					sql = "INSERT INTO CONTAIN VALUES ("
							+ m_num + ", " + o_num
									+ ", " + m_count
									+ ", "+chemistID+", '"+clientID+"')";
					rs = stmt.executeQuery(sql);
					
					
					System.out.println("\n* �ֹ��� Ȯ�εǾ����ϴ�.");
					System.out.println("\n");
					stmt.close(); 
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					System.out.println("* �߸��� �ֹ��Դϴ�.");
					e.printStackTrace();
				}
				break;
			case 4:
				// �� �ֹ����
				System.out.print("\n* �ֹ� ��ȣ: ");
				String o_num2 = sc.nextLine();
				System.out.print("* ��� ID: ");
				String chemistID2 = sc.nextLine();

				try {
					stmt = conn.createStatement();
					
					String sql = "DELETE FROM M_ORDER"
							+ " WHERE Order_num = "+o_num2
									+ " AND Client_ID = '"+clientID+"'"
									+ " AND Chemist_ID = "+chemistID2;
					
					rs = stmt.executeQuery(sql);
					
					System.out.println("\n* �ֹ��� ��ҵǾ����ϴ�.");
					System.out.println("\n");
					stmt.close(); 
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					System.out.println("* �ش� ������ �ֹ� ����� �����ϴ�.");
					e.printStackTrace();
				}
				break;
			default:
				System.out.println("* �߸��� �Է��Դϴ�.");
				break;
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
		System.out.println("1. �� �α���");
		System.out.println("2. ��� �α���");
		System.out.print("* ��ȣ �Է�: ");
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		sc.nextLine();
		ResultSet rs = null;
		switch (n) {
		case 1:
			System.out.print("client ID: ");
			String clientID = sc.nextLine();
			
			// �����ϴ� client ID���� Ȯ��
			
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
					System.out.println("* �������� �ʴ� clientID �Դϴ�. �Է°�: "+clientID);
					System.out.println("* ���α׷��� �����մϴ�.");
					System.exit(1);
				}
				else {
					System.out.println("* �α��� ����");
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
				System.out.println("1. �� �˻�");
				System.out.println("2. �౹ �̸� �˻�");
				System.out.println("3. �౹ ��ġ �˻�");
				System.out.println("4. ���� �ֹ���� ��ȸ");
				System.out.println("5. �ֹ� �߰� �� ����");
				System.out.println("6. ���±�� �߰�");
				System.out.println("7. �������� ����");
				System.out.println("0. ����\n");
				
				System.out.print("* ��ȣ �Է�: ");
				int i = sc.nextInt();
				sc.nextLine();
				System.out.println("");
				switch (i) {
				case 0:
					System.out.println("* ���α׷��� �����մϴ�.");
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
					break;
				case 5:
					medicine_order(conn, stmt, clientID);
					break;
				case 6:
					System.out.println("6");
					break;
				case 7:
					System.out.println("7");
					break;
				default:
					System.out.println("�߸��� �Է��Դϴ�.");
				}
			}
			
		case 2:
			System.out.print("chemist ID: ");
			String chemistID = sc.nextLine();
			
			// �����ϴ� client ID���� Ȯ��
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
					System.out.println("* �������� �ʴ� chemistID �Դϴ�. �Է°�: "+chemistID);
					System.out.println("* ���α׷��� �����մϴ�.");
					System.exit(1);
				}
				else {
					System.out.println("* �α��� ����");
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
				System.out.println("1. �� ��ȸ");
				System.out.println("2. �� �ֹ� ��� ��ȸ");
				System.out.println("3. �� ��� ��ȸ");
				System.out.println("0. ����\n");
				
				System.out.print("* ��ȣ �Է�: ");
				int i = sc.nextInt();
				sc.nextLine();
				System.out.println("");
				switch (i) {
				case 0:
					System.out.println("* ���α׷��� �����մϴ�.");
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
				default:
					System.out.println("�߸��� �Է��Դϴ�.");
				}
			}
		default:
			System.out.println("* �߸��� �Է��Դϴ�.");
			System.out.println("* ���α׷��� �����մϴ�.");
			System.exit(1);
		}
		
		// my function
		
		//pharmacy_location(conn, stmt);
		//update_client_info(conn, stmt, "111223333");
		//show_medicine_history(conn, stmt);
	}
	
	
	
}
