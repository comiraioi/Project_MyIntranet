package work;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import edu.LectureBean;


public class ProjectDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	ProjectBean pb = null;
	int cnt = -1;
	
	//싱글톤 패턴으로 객체 생성
	private static ProjectDao pdao;
	
	//DBCP 접속
	private ProjectDao() {
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

	public static ProjectDao getInstance() {
		if(pdao==null)
			pdao = new ProjectDao();
		return pdao;
	}//getInstance
	
	/* 전체 프로젝트 리스트 */
	public ArrayList<ProjectBean> getAllProject(){
		ArrayList<ProjectBean> lists = new ArrayList<ProjectBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from project order by prono";
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

			while(rs.next()) {

				int prono = rs.getInt("prono");
				String code = rs.getString("code");
				String id = rs.getString("id");
				String pname = rs.getString("pname");
				String todo = rs.getString("todo");
				int progress = rs.getInt("progress");
				
				pb = new ProjectBean(prono,code,id,pname,todo,progress);
				
				lists.add(pb);
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
		
	}//getAllProject
	
	/* 부서별 프로젝트 리스트 */
	public ArrayList<ProjectBean> getProjectbyCode(String pcode){
		ArrayList<ProjectBean> lists = new ArrayList<ProjectBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from project where code=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, pcode);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			while(rs.next()) {

				int prono = rs.getInt("prono");
				String code = rs.getString("code");
				String id = rs.getString("id");
				String pname = rs.getString("pname");
				String todo = rs.getString("todo");
				int progress = rs.getInt("progress");
				
				pb = new ProjectBean(prono,code,id,pname,todo,progress);
				
				lists.add(pb);
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
		
	}//getProjectbyCode
	
	/* 로그인한 사원의 프로젝트 리스트 */
	public ArrayList<ProjectBean> getUserProject(String sid){
		ArrayList<ProjectBean> lists = new ArrayList<ProjectBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from project where id=?";
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

			while(rs.next()) {

				int prono = rs.getInt("prono");
				String code = rs.getString("code");
				String id = rs.getString("id");
				String pname = rs.getString("pname");
				String todo = rs.getString("todo");
				int progress = rs.getInt("progress");
				
				pb = new ProjectBean(prono,code,id,pname,todo,progress);
				
				lists.add(pb);
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
		
	}//getUserProject
	
	/* 프로젝트 번호로 프로젝트 내용 가져오기 */
	public ProjectBean getProjectbyNo(int prono) {
		//3.sql문 작성, 분석
		String sql = "select * from project where prono=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setInt(1, prono);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()) {
				pb = new ProjectBean();
				
				pb.setProno(prono);
				pb.setCode(rs.getString("code"));
				pb.setId(rs.getString("id"));
				pb.setPname(rs.getString("pname"));
				pb.setTodo(rs.getString("todo"));
				pb.setProgress(rs.getInt("progress"));
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

		return pb;
		
	}//getProjectbyNo
	
	/* 새 프로젝트 추가하기 */
	public int insertProject(ProjectBean pb){
		//3.sql문 작성, 분석
		String sql = "insert into project values(proseq.nextval,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, pb.getCode());
			ps.setString(2, pb.getId());
			ps.setString(3, pb.getPname());
			ps.setString(4, pb.getTodo());
			ps.setInt(5, pb.getProgress());

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
		
	}//insertProject
	
	public int updateProject(int prono, ProjectBean pb){
		//3.sql문 작성, 분석
		String sql = "update project set id=?, pname=?, todo=?, progress=? where prono=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");
			
			ps.setString(1, pb.getId());
			ps.setString(2, pb.getPname());
			ps.setString(3, pb.getTodo());
			ps.setInt(4, pb.getProgress());
			ps.setInt(5, prono);
			
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
		
	}//updateProject
	
	
}
