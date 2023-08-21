package attd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class DayoffDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	DayoffBean db = null;
	int cnt = -1;
	
	//싱글톤 패턴으로 객체 생성
	private static DayoffDao ddao;
	
	//DBCP 접속
	private DayoffDao() {
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
	
	public static DayoffDao getInstance() {
		if(ddao==null)
			ddao = new DayoffDao();
		return ddao;
	}//getInstance
	
	/* 로그인한 사원의 전체 기록 */
	public ArrayList<DayoffBean> getallOffbyId(String sid){
		ArrayList<DayoffBean> lists = new ArrayList<DayoffBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from dayoff where id=? "
				+"and to_char(fdate,'yy') = to_char(sysdate,'yy') order by fdate";

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
				String fdate = rs.getString("fdate");
				Double off = rs.getDouble("off");
				String dost = rs.getString("dost");
				Double remain = rs.getDouble("remain");

				DayoffBean db = new DayoffBean(id,fdate,off,dost,remain);

				lists.add(db);
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
	public DayoffBean getRecentOffbyId(String sid){
		//3.sql문 작성, 분석
		String sql = "select * from dayoff where fdate in ("
				+ "select max(fdate) as fdate from dayoff where id=?)";
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
				db = new DayoffBean();
				
				db.setId(rs.getString("id"));
				db.setFdate(rs.getString("fdate"));
				db.setOff(rs.getDouble("off"));
				db.setDost(rs.getString("dost"));
				db.setRemain(rs.getDouble("remain"));
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

		return db;
		
	}//getRecentOffbyId
	
	/* 연차 사용 기록 */
	public int recordDayoffbyId(String sid, DayoffBean db) {
		//3.sql문 작성, 분석
		String sql = "insert into dayoff values(?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1,sid);
			ps.setString(2, db.getFdate().toString());
			ps.setDouble(3, db.getOff());
			ps.setString(4, db.getDost());
			
			double remain = db.getRemain();
			double off = db.getOff();
			remain = remain - off;
			ps.setDouble(5, remain);

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
		
	}//recordDayoffbyId
	
	
}
