package edu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class RegisterDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	RegisterBean rb = null;
	int cnt = -1;
	
	//싱글톤 패턴으로 객체 생성
	private static RegisterDao rdao;
	
	//DBCP 접속
	private RegisterDao() {
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
	
	public static RegisterDao getInstance() {
		if(rdao==null)
			rdao = new RegisterDao();
		return rdao;
	}//getInstance
	
	/* 전체 사원 강의 신청 내역 보기 */
	public Vector<RegisterBean> getAllRegister(){
		Vector<RegisterBean> lists = new Vector<RegisterBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from register";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			while(rs.next()){
				rb = new RegisterBean();

				rb.setRegino(rs.getInt("regino"));
				rb.setLecno(rs.getInt("lecno"));
				rb.setId(rs.getString("id"));

				lists.add(rb);
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

	}//getAllRegister
	
	/* 사원 id로 강의 신청 내역 보기 */
	public Vector<RegisterBean> getRegiLecbyId(String id){
		Vector<RegisterBean> lists = new Vector<RegisterBean>();

		//3.sql문 작성, 분석
		String sql = "select * from register where id=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, id);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			while(rs.next()){
				rb = new RegisterBean();

				rb.setRegino(rs.getInt("regino"));
				rb.setLecno(rs.getInt("lecno"));
				rb.setId(id);

				lists.add(rb);
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
		
	}//getRegiLecbyId
	
	/* 강의 번호, 사원 아이디로 강의 신청하기 */
	public int registerLecture(int lecno, String id) {
		//3.sql문 작성, 분석
		String sql = "insert into register values(regiseq.nextval,?,?)";

		try {
			ps = conn.prepareStatement(sql);
		
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setInt(1, lecno);
			ps.setString(2, id);

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
		
	}//registerLecture
	
	/* 부서 코드로 부서별 강의 수강 인원수 구하기 */ 
	public int getRegiNumbyCode(String code) {
		int num = 0;
		
		//3.sql문 작성, 분석
		String sql = "select count(*) from register where id like '%"+code+"%'";
		
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			while(rs.next()){
				num = rs.getInt(1);
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
		
		return num;
		
	}//getRegiNumbyCode
	
}
