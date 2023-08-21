package edu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.EmpBean;


public class LectureDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	LectureBean lb = null;
	int cnt = -1;
	
	//싱글톤 패턴으로 객체 생성
	private static LectureDao ldao;
	
	//DBCP 접속
	private LectureDao() {
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
	
	public static LectureDao getInstance() {
		if(ldao==null)
			ldao = new LectureDao();
		return ldao;
	}//getInstance
	
	/* 전체 강의 목록 */
	public ArrayList<LectureBean> getAllLecture(){
		ArrayList<LectureBean> lists = new ArrayList<LectureBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from lecture order by lecno";

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
				int lecno = rs.getInt("lecno");
				String code = rs.getString("code");
				String title = rs.getString("title");
				String thumbnail = rs.getString("thumbnail");
				int lectime = rs.getInt("lectime");
				String contents = rs.getString("contents");
				
				lb = new LectureBean(lecno,code,title,thumbnail,lectime,contents);
				
				lists.add(lb);
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
		
	}//getAllLecture
	
	/* 부서 코드로 강의 목록 가져오기 */
	public ArrayList<LectureBean> getLlistbyCode(String ccode) {
		ArrayList<LectureBean> lists = new ArrayList<LectureBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from lecture where code=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setString(1, ccode);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			while(rs.next()) {
				int lecno = rs.getInt("lecno");
				String code = rs.getString("code");
				String title = rs.getString("title");
				String thumbnail = rs.getString("thumbnail");
				int lectime = rs.getInt("lectime");
				String contents = rs.getString("contents");
				
				lb = new LectureBean(lecno,code,title,thumbnail,lectime,contents);
				
				lists.add(lb);
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
		
	}//getLlistbyCode
	
	/* lecno로 해당 강의 정보 가져오기 */
	public LectureBean getLecturebyNo(int lecno){
		//3.sql문 작성, 분석
		String sql = "select * from lecture where lecno=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setInt(1, lecno);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()) {
				lb = new LectureBean();
				
				lb.setLecno(lecno);
				lb.setCode(rs.getString("code"));
				lb.setTitle(rs.getString("title"));
				lb.setThumbnail(rs.getString("thumbnail"));
				lb.setLectime(rs.getInt("lectime"));
				lb.setContents(rs.getString("contents"));
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

		return lb;
		
	}//getLecturebyNo
	
	
}
