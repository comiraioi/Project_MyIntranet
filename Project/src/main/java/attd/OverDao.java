package attd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class OverDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	OverBean ob = null;
	int cnt = -1;
	
	//싱글톤 패턴으로 객체 생성
	private static OverDao odao;
	
	//DBCP 접속
	private OverDao() {
		Context initContext;
		try {
			//1. 드라이버 로드
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			//2. 계정 접속
			conn = ds.getConnection();
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//생성자
	
	public static OverDao getInstance() {
		if(odao==null)
			odao = new OverDao();
		return odao;
	}//getInstance
	
	/* 로그인한 사원의 전체 기록 */
	public ArrayList<OverBean> getallOverbyId(String sid){
		ArrayList<OverBean> lists = new ArrayList<OverBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from overtime where id=? "
				+"and to_char(odate,'yy') = to_char(sysdate,'yy') order by odate";

		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, sid);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			while(rs.next()){
				
				String id = rs.getString("id");
				String odate = rs.getString("odate");
				int hour = rs.getInt("hour");
				String otst = rs.getString("otst");
				int cumul = rs.getInt("cumul");

				OverBean ob = new OverBean(id,odate,hour,otst,cumul);

				lists.add(ob);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			//5.자원 반납
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return lists;
		
	}//getallOverbyId
	
	/* 로그인한 사원의 가장 최근 기록 */
	public OverBean getRecentOverbyId(String sid){
		//3.sql문 작성, 분석
		String sql = "select * from overtime where odate in ("
						+ "select max(odate) as odate from overtime where id=?)";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, sid);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()) {
				ob = new OverBean();
				
				ob.setId(rs.getString("id"));
				ob.setOdate(rs.getString("odate"));
				ob.setHour(rs.getInt("hour"));
				ob.setOtst(rs.getString("otst"));
				ob.setCumul(rs.getInt("cumul"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5.자원 반납
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return ob;
		
	}//getRecentOverbyId
	
	/* 초과근무 기록 */
	public int recordOvertbyId(String sid, OverBean ob) {
		//3.sql문 작성, 분석
		String sql = "insert into overtime values(?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1,sid);
			ps.setString(2, ob.getOdate().toString());
			ps.setInt(3, ob.getHour());
			ps.setString(4, ob.getOtst());
			
			int cumul = ob.getCumul()+ob.getHour();
			ps.setInt(5, cumul);

			//4.sql문 실행
			cnt = ps.executeUpdate();
			if(cnt>0)
				System.out.println("insert 성공");
			else
				System.out.println("insert 실패");

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			//5.자원 반납
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
		
	}//recordOvertbyId
	
}
