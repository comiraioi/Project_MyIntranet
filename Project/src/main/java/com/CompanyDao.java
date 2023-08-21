package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class CompanyDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	int cnt = -1;
	
	//싱글톤 패턴으로 객체 생성
	private static CompanyDao cdao;
	
	//DBCP 접속
	private CompanyDao() {
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
	
	public static CompanyDao getInstance() {
		if(cdao==null)
			cdao = new CompanyDao();
		return cdao; 
	}//getInstance
	
	/* 부서 목록 */
	public ArrayList<CompanyBean> getAllDept(){
		ArrayList<CompanyBean> lists = new ArrayList<CompanyBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from company order by deptno";

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
				int deptno = rs.getInt("deptno");
				String code = rs.getString("code");
				String dept = rs.getString("dept");

				CompanyBean cb = new CompanyBean(deptno,code,dept);

				lists.add(cb);
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
		
	}//getAllDept
	
	/* 부서 코드 중복검사 (duplProc.jsp) */
	public boolean searchCode(String code) {
		System.out.println("code: "+code);
		boolean result = true;
		
		//3.sql문 작성, 분석
		String sql = "select * from company where code=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, code);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()){
				result = false;
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
		
		return result;
		
	}//searchCode
	
	/* 부서 추가 */
	public int insertDept(CompanyBean cb) {
		//3.sql문 작성, 분석
		String sql = "insert into company values(deptseq.nextval,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, cb.getCode());
			ps.setString(2, cb.getDept());

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
		
	}//insertDept
	
	/* update */
	public int updateDept(CompanyBean cb) {
		//3.sql문 작성, 분석
		String sql = "update company set code=?, dept=? where deptno=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, cb.getCode());
			ps.setString(2, cb.getDept());
			ps.setInt(3, cb.getDeptno());
							
			//4.sql문 실행
			cnt = ps.executeUpdate();
			if(cnt>0)
				System.out.println("update 성공");
			else
				System.out.println("update 실패");
							
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
		
	}//updateDept
	
	/* 부서 삭제 */
	public int deleteDept(String[] num) {
		//3.sql문 작성, 분석
		String sql ="delete from company where deptno=?"; 

		for(int i=0; i<num.length-1; i++) { 
			sql += " or deptno=?";
		}

		try {
			ps = conn.prepareStatement(sql);
			for(int i=0; i<num.length; i++) {
				ps.setString(i+1,num[i]);
			}

			//4.sql문 실행
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			//5.자원 반납
			try {
				if(ps != null)
					ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	

		return cnt;
		
	}//deleteDept
	
	/* 부서번호로 코드 가져오기 */
	public String getCodebyDeptno(int deptno) {
		String code ="";
		//3.sql문 작성, 분석
		String sql = "select code from company where deptno=?";

		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setInt(1, deptno);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()){
				code = rs.getString("code");
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

		return code;
	}//getCodebyDeptno
	
	/* 코드로 부서명 가져오기 */
	public String getDeptbyCode(String code) {
		String dept = "";
		
		//3.sql문 작성, 분석
		String sql = "select dept from company where code=?";

		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, code);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()){
				dept = rs.getString("dept");
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

		return dept;
		
	}//getDeptbyCode
	
	
	
}
