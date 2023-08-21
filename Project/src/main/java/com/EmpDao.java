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

import com.oreilly.servlet.MultipartRequest;


public class EmpDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	EmpBean user = null;
	int cnt = -1;
	
	//싱글톤 패턴으로 객체 생성
	private static EmpDao edao;
	
	//DBCP 접속
	private EmpDao() {
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
	
	public static EmpDao getInstance() {
		if(edao==null)
			edao = new EmpDao();
		return edao;
	}//getInstance
	
	/* 이메일 중복검사 (emailProc.jsp) */
	public boolean searchEmail(String inputemail) {
		boolean result = true;
		
		//3.sql문 작성, 분석
		String sql = "select * from emp where email=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, inputemail);
			
			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");
			
			if(rs.next()) {
				result = false;
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
		
		return result;
		
	}//searchEmail
	
	/* 회원가입 */
	public int insertEmp(EmpBean eb) {
		//3.sql문 작성, 분석
		String sql = "insert into emp(empno,name,code,id,pw,email) values(empseq.nextval, ?, ?, 'co'||?||empseq.nextval, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, eb.getName());
			ps.setString(2, eb.getCode());
			ps.setString(3, eb.getCode());	//아이디
			ps.setString(4, eb.getPw());
			ps.setString(5, eb.getEmail());
			
			//4.sql문 실행
			cnt = ps.executeUpdate();
			System.out.println("cnt: "+cnt);
			if(cnt > 0)
				System.out.println("insert 성공");
			else
				System.out.println("insert 실패");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5.자원 반납
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
		
	}//insertMember
	
	/* 아이디 찾기 */
	public EmpBean getIdbyPwEmail(EmpBean eb){
		//3.sql문 작성, 분석
		String sql = "select * from emp where pw=? and email=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, eb.getPw());
			ps.setString(2, eb.getEmail());
			
			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");
			
			if(rs.next()) {
				user = getEmpBean(rs);
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
		
		return user;
		
	}//getIdbyPwEmail
	
	private EmpBean getEmpBean(ResultSet rs2) throws SQLException {
		
		EmpBean eb = new EmpBean();
		eb.setEmpno(rs2.getInt("empno"));
		eb.setCurlog(rs2.getString("curlog"));
		eb.setLastlog(rs2.getString("lastlog"));
		eb.setImage(rs2.getString("image"));
		eb.setName(rs2.getString("name"));
		eb.setCode(rs2.getString("code"));
		eb.setId(rs2.getString("id"));
		eb.setPw(rs2.getString("pw"));
		eb.setBirth(rs2.getDate("birth"));
		eb.setEmail(rs2.getString("email"));
		eb.setPosition(rs2.getString("position"));
		eb.setSalary(rs2.getInt("salary"));
		eb.setAuthority(rs2.getString("authority"));
		
		return eb;
		
	}//getEmpBean
	
	/* 아이디로 로그인 */
	public EmpBean getUserAccount(String id, String pw) {
		//3.sql문 작성, 분석
		String sql = "select * from emp where id=? and pw=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, id);
			ps.setString(2, pw);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()) {
				user = getEmpBean(rs);
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

		return user;
		
	}//getUserAccount
	
	/* 이메일로 로그인 */
	public EmpBean getUserAccountbyEmail(String email, String pw) {
		//3.sql문 작성, 분석
		String sql = "select * from emp where email=? and pw=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, email);
			ps.setString(2, pw);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()) {
				user = getEmpBean(rs);
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

		return user;
		
	}//getUserAccountbyEmail
	
	/* 비밀번호 찾기 */
	public EmpBean getPwbyIdEmail(EmpBean eb) {
		//3.sql문 작성, 분석
		String sql = "select * from emp where id=? and email=?";

		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, eb.getId());
			ps.setString(2, eb.getEmail());
			
			System.out.println("inputid: "+eb.getId());
			System.out.println("inputemail: "+eb.getEmail());
			
			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()) {
				user = getEmpBean(rs);
				System.out.println("user: "+user);
			}
		} catch (SQLException e) {
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
		
		return user;
		
	}//getPwbyIdEmail
	
	/* 비밀번호 일치 확인 */
	public boolean searchMatchPw(String oripw) {
		boolean result = false;
		
		//3.sql문 작성, 분석
		String sql = "select * from emp where pw=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, oripw);
			
			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");
			
			if(rs.next()) {
				result = true;
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
		
		return result;
		
	}//searchMatchPw
	
	/* 비밀번호 변경하기 */
	public int updatePw(String pw, String sid) {
		//3.sql문 작성, 분석
		String sql = "update emp set pw=? where id=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, pw);
			ps.setString(2, sid);

			///4.sql문 실행
			cnt = ps.executeUpdate();
			if(cnt>0)
				System.out.println("update 성공");
			else
				System.out.println("update 실패");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5.자원 반납
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
		
	}//updatePw
	
	/* 세션 설정한 id로 authority 가져오기 */
	public String getAuthority(String sid) {
		String authority = "";
		
		//3.sql문 작성, 분석
		String sql = "select * from emp where id=?";
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
				user = new EmpBean();
				user.setAuthority(rs.getString("authority"));
				authority = user.getAuthority();
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

		return authority;
		
	}//getAuthority
	
	/* 부서별 사원 수 구하기 */
	public int cntEmpbyCode(String code) {
		int cnt = 0;
		
		//3.sql문 작성, 분석
		String sql = "select count(empno) as cnt from emp where code=?";
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

			if(rs.next()) {
				cnt = rs.getInt("cnt");
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

		return cnt;
	}//cntEmpbyCode
	
	/* 전체 사원 수 구하기 */
	public int cntallEmp(){
		int cntall = 0;
		
		//3.sql문 작성, 분석
		String sql = "select count(empno) as cntall from emp";
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

			if(rs.next()) {
				cntall = rs.getInt("cntall");
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

		return cntall;
	}//cntallEmp
	
	/* 전체 사원 목록 */
	public ArrayList<EmpBean> getAllEmp(){
		ArrayList<EmpBean> lists = new ArrayList<EmpBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from emp order by empno";

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
				EmpBean eb = getEmpBean(rs);
				lists.add(eb);
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
		
	}//getAllEmp
	
	/* 아이디로 사원 정보 가져오기 */
	public EmpBean getUserProfile(String id) {
		//3.sql문 작성, 분석
		String sql = "select * from emp where id=?";
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

			if(rs.next()) {
				user = getEmpBean(rs);
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

		return user;
		
	}//getUserProfile
	
	/* 부서 코드로 사원 리스트 가져오기 */
	public ArrayList<EmpBean> getEmpbyCode(String code) {
		ArrayList<EmpBean> lists = new ArrayList<EmpBean>();
		//3.sql문 작성, 분석
		String sql = "select * from emp where code=?";
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

			while(rs.next()) {
				EmpBean eb = getEmpBean(rs);
				lists.add(eb);
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

		return lists;
		
	}//getEmpbyCode
	
	/* 사원 프로필 수정 */
	public int updateProfile(MultipartRequest mr, String img, String sid){
		//3.sql문 작성, 분석
		String sql="update emp set image=?,name=?,birth=?,email=? where id=?";

		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, img);
			ps.setString(2, mr.getParameter("name"));
			ps.setString(3,mr.getParameter("birth"));
			ps.setString(4, mr.getParameter("email"));
			ps.setString(5, sid);

			//4.sql문 실행
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5.자원 반납
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
		
	}//updateProfile
	
	/* 사원 프로필 수정 (관리자) */
	public int updateEmp(String id, EmpBean eb){
		//3.sql문 작성, 분석
		String sql="update emp set position=?,salary=?,authority=? where id=?";

		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, eb.getPosition());
			ps.setInt(2, eb.getSalary());
			ps.setString(3, eb.getAuthority());
			ps.setString(4, id);

			//4.sql문 실행
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5.자원 반납
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
		
	}//updateEmp
	
	/* 사원 리스트 테이블(+조회기능) */
	public ArrayList<EmpBean> searchEmp(String code, String keyword){
		ArrayList<EmpBean> lists = new ArrayList<EmpBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from emp ";

		if(code == null && keyword==null) {
			sql += "order by empno";
		}else if(code == "" && keyword !=null) {
			sql += "where name like '%"+keyword+"%' order by empno";
		}else if(code != "" && keyword == null) {
			sql += "where code='"+code+"' order by empno";
		}else if(code != "" && keyword != null) {
			sql += "where code='"+code+"' and name like '%"+keyword+"%' order by empno";
		}else if(code == ""  && keyword==null){
			sql += "order by empno";
		}
		
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
				EmpBean eb = getEmpBean(rs);
				lists.add(eb);
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
		
	}//searchEmp
	
	/* 사원 채팅 찾기 */
	public ArrayList<EmpBean> searchEmpChat(String keyword){
		ArrayList<EmpBean> lists = new ArrayList<EmpBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from emp ";

		if(keyword !=null) {
			sql += "where name like '%"+keyword+"%' order by empno";
		}
		
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
				EmpBean eb = getEmpBean(rs);
				lists.add(eb);
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
		
	}//searchEmpChat
	
	/* 사원 계정 삭제 */
	public int deleteEmp(String[] num) {
		//3.sql문 작성, 분석
		String sql ="delete from emp where empno=?"; 

		for(int i=0; i<num.length-1; i++) { 
			sql += " or empno=?";
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
		
	}//deleteEmp
	
	public int updateLog(String curlog, String lastlog, String id) {
		System.out.println(curlog+"/"+lastlog);
		//3.sql문 작성, 분석
		String sql = "update emp set curlog=?, lastlog=? where id=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, curlog);
			ps.setString(2, lastlog);
			ps.setString(3, id);
							
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
		
	}//updateLog
	
}
