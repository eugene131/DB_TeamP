
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
			//stmt = conn.createStatement();
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
			//stmt.close(); 
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
			//stmt = conn.createStatement();
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
			
			//stmt.close(); 
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
					//stmt = conn.createStatement();
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
					//stmt.close(); 
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
					//stmt = conn.createStatement();
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
					//stmt.close(); 
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
					//stmt = conn.createStatement();
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
					//stmt.close(); 
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
					//stmt = conn.createStatement();
					
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
					//stmt.close(); 
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
					//stmt = conn.createStatement();
					
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
					//stmt.close(); 
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
					//stmt = conn.createStatement();
					
					String sql = "DELETE FROM M_ORDER"
							+ " WHERE Order_num = "+o_num2
									+ " AND Client_ID = '"+clientID+"'"
									+ " AND Chemist_ID = "+chemistID2;
					
					rs = stmt.executeQuery(sql);
					
					System.out.println("\n* �ֹ��� ��ҵǾ����ϴ�.");
					System.out.println("\n");
					//stmt.close(); 
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

	// �� ã��
	public static void search_medicine(Connection conn, Statement stmt) {//���� ã�� �Լ�
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		String condition, m_name, m_type = "";
		int price, m_type_num;
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ ���� ���� �� ��ȸ ] --------");
		System.out.println("������ �Է��� �ּ���.");
		condition = sc.nextLine();

		System.out.println("������ �Է��� �ּ���. �Է��Ͻ� ���ݺ��� ���� ������ ���� ����� ǥ�� �˴ϴ�.");
		price = sc.nextInt();

		System.out.println("�� �̸��� �Է��� �ּ���.");
		m_name = sc.nextLine();

		System.out.println("Ÿ���� ������ �ּ���.");
		System.out.println("1. �˾� 2. ĸ�� 3. ��");
		m_type_num = sc.nextInt();

		if (m_type_num == 1) {
			m_type = "�˾�";
		} else if (m_type_num == 2) {
			m_type = "ĸ��";
		} else if (m_type_num == 3) {
			m_type = "��";
		}
		try {
			// Q1: Complete your query.
			stmt = conn.createStatement();
			String sql = "select name, price, drug_type, dosing_interval, info "//������
					+ "from medicine "
					+ "where price<=" + price + " and name like'%"
					+ m_name.replace("\n", "") + "%' and drug_type='"
					+ m_type.replace("\n", "") + "' and info like '%" + condition.replace("\n", "") + "%'";
			rs = stmt.executeQuery(sql);//sql ����
			ResultSetMetaData rsmd = rs.getMetaData();
			System.out.println("<< query 1 result >>");
			int cnt = rsmd.getColumnCount();
			for (int i = 1; i <= cnt; i++) {
				if (i != cnt)
					System.out.print(rsmd.getColumnName(i) + " | ");//�÷��� ���
				else
					System.out.print(rsmd.getColumnName(i));//�÷��� ���
			}
			System.out.println("\n<< �� �˻� ��� >>");
			System.out.println("�� �̸� | ���� | �� Ÿ�� | ���� �뷮 | ���� ����");

			System.out.println();
			//select��� ���
			while (rs.next()) {//Ʃ�� ���� ���
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
	
	//===============================�౹ ã��================================
	public static void search_parmacy(Connection conn, Statement stmt) {
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		String m_name, address;
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ �౹ ��ȸ ] --------");
		System.out.println("�ʿ��Ͻ� �� �̸��� �Է��� �ּ���. �ش� ���� �ִ� �౹�� ã�Ƶ帳�ϴ�.");
		m_name = sc.nextLine();
		System.out.println("�౹�� �ּҸ� �Է��� �ּ���.");
		address = sc.nextLine();
		try {
			// Q1: Complete your query.
			String sql = "select distinct p.name, p.Address "//������ �Է�
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
			//�÷� ���� ���
			for (int i = 1; i <= cnt; i++) {
				if (i != cnt)
					System.out.print(rsmd.getColumnName(i) + " | ");
				else
					System.out.print(rsmd.getColumnName(i));
			}

			System.out.println("\n<< �౹ �˻� ��� >>");
			System.out.println("�౹ �̸� | �౹ �ּ�");
			System.out.println();
			//Ʃ�� ���� ���
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

	//====================��� ��ȸ & ���� ����, ������ 0�� ��� ����========================
	public static void medicen_stock(Connection conn, Statement stmt, String chemistID) {
		//default = input is parmercy's ID
		Scanner sc = new Scanner(System.in);
		String p_num = "", m_num = "";
		int menu = 0, checkpoint = 0;//checkpoint�� ���� ��� ������ �ִ��� Ȯ���ϰ�, ���� insert�� update�� �����Ѵ�.
		System.out.println("-------< ���� ���� ���� ��ȸ, ���� >-----------");

		System.out.println("ã���� ���� ��ȣ�� �Է��� �ּ���");
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
			System.out.println("<< query ���� result >>");
			System.out.println("�� ��ȣ | �� ����");
			while (rs.next()) {

				System.out.print(rs.getString(1) + " | ");
				m_num = rs.getString(1);//�� ��ȣ �ޱ� ���� �� ������Ʈ�� �ʿ�
				System.out.println(rs.getString(2));
				p_num = rs.getString(3);//�౹ ��ȣ �ޱ� ���ؼ�. ���߿� �� �߰� or ������Ʈ�� �ʿ�
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
		if (checkpoint == 0) {//���� ��� ���(��ȸ ���)�� �ƹ��͵� ���ٸ�, 
			System.out.println("�ش� ���� �߰� �Ͻðڽ��ϱ�? 1. �� 2. �ƴϿ�");
			insert_check_num = sc.nextInt();
			if (insert_check_num == 1)
				menu = 1;//insert�� ������ ��
		} else {//���� ��� ����� ���� �Ѵٸ�,
			System.out.println("���� ������ ���� �Ͻðڽ��ϱ�? 1. �� 2. �ƴϿ�");
			int update_check_menu = sc.nextInt();
			if (update_check_menu == 1) {
				menu = 2;
			}

		}

		System.out.println();
		if (menu == 1) {//�ƹ��͵� ���� �� �μ�Ʈ
			m_insert(conn, stmt, p_num);
		} else if (menu == 2) {
			m_update(conn, stmt, p_num, m_num);
		}
		m_delete(conn, stmt);//stock�� 0�� �͵� ��� ���� => �Ź� �� ������ ������ 0�� ���� ������ �ʿ䰡 ����

	}

	public static void m_insert(Connection conn, Statement stmt, String p_num) {//p_num�� insert�� �ʿ��� �౹ ��ȣ
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		int m_number, m_stock;
		System.out.println("�� �߰��� �����ϼ̽��ϴ�.");
		System.out.println("�߰��Ͻ� ���� ��ȣ�� �Է��� �ּ���.");
		//�� ��ȣ ��ǲ
		m_number = sc.nextInt();
		System.out.println("�߰��Ǵ� ���� ������ �Է��� �ּ���.");
		//�� ���� ��ǲ
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

	public static void m_update(Connection conn, Statement stmt, String p_num, String m_num) {//p_num, m_num�� ������Ʈ�� �ʿ��� ����
		//delete qury
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		System.out.println("�����Ͻ� ������ �Է��� �ּ���");
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

	public static void m_delete(Connection conn, Statement stmt) {//���� 0�� M_store ����
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
	
	//���� ��� �߰�
	public static void case_insert(Connection conn, Statement stmt, String Id){
		System.out.println("\n----------------------------------");
		System.out.println("-------- [ ���� ��� �߰� ] --------");
		Scanner input = new Scanner(System.in);
		int i = 0;
		String compare1 = "";
		String compare2 = "";
		System.out.println("1.ó����� ��¥�� �Է��� �ֽʽÿ�.(ex : yyyy-mm-dd)");
		String date = input.next();
		System.out.println("2.ó����� ���� �Է��� �ֽʽÿ�.");
		String medicine = input.next();
		/*System.out.println("3.ID�� �Է����ֽʽÿ�.");
		String Id = input.next();*/
		ResultSet rs = null;
	
		try {
			try {
				SimpleDateFormat test = new SimpleDateFormat("yyyy-MM-dd");
				test.setLenient(false);
				test.parse(date);
				}catch(ParseException e){
					System.out.println("�߸��� ��¥ �����Դϴ�.");
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
				System.out.println("������ ���̽��� �������� �ʴ� ���Դϴ�");
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
				System.out.println("���� ����� ���������� �߰��Ͽ����ϴ�.");
				//conn.commit(); �׽�Ʈ���� Ŀ���ϸ� �����ϴϱ�.
			}
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
		System.out.println("------------------ [ ������ �δ� �� ��ȸ ] ------------------");
		System.out.println("��ȸ�� ���ϴ� ���� ������ �Ʒ����� �ϳ��� �����Ͽ� �ѱ۷� �Է��� �ֽʽÿ�.");
		try {
			String sql = "select Name from SYMPTOM where Condition = '��'";
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
				System.out.println("������ �߸� �Է��ϼ̽��ϴ�.");
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
				System.out.println("��ȸ�� ������ �����ϴ�.");
			}
		}
		rs.close();
		
	}
		catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
		}
		
}
	
	public static void case_search(Connection conn, Statement stmt, String Id) {
		ResultSet rs = null;
		Scanner input = new Scanner(System.in);
		System.out.println("1.�̸��� �Է��� �ֽʽÿ�.");
		String Name = input.next();
		System.out.println("2.��ȭ��ȣ�� �Է����ֽʽÿ�.");
		String Phone_num = input.next();
		System.out.println("3.������ �Է��� �ֽʽÿ�.(ex : yyyy-mm-dd)");
		String Birth = input.next();
		try {
			//stmt = conn.createStatement();
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
				System.out.println("����� �����ϴ�.");
			}
			rs.close();
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
			stmt = conn.createStatement();
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
				//stmt.close(); 
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
				System.out.println("4. �ֹ� �߰� �� ����");
				System.out.println("5. ���� ��� ��ȸ");
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
					search_medicine(conn,stmt);
					break;
				case 2:
					search_parmacy(conn,stmt);
					break;
				case 3:
					pharmacy_location(conn, stmt);
					break;
				case 4:
					medicine_order(conn, stmt, clientID);
					break;
				case 5:
					case_insert(conn, stmt, clientID);
					break;
				case 6:
					case_insert(conn, stmt, clientID);
					break;
				case 7:
					update_client_info(conn, stmt, clientID);
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
					Client_Enquiry(conn, stmt);
					break;
				case 2:
					show_medicine_history(conn, stmt);
					break;
				case 3:
					medicen_stock(conn, stmt, chemistID);
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
