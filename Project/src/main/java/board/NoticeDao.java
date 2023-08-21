package board;

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


public class NoticeDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	NoticeBean nb = null;
	int cnt = -1;
	
	//싱글톤 패턴으로 객체 생성
	private static NoticeDao ndao;
	
	//DBCP 접속
	private NoticeDao() {
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
	
	public static NoticeDao getInstance() {
		if(ndao==null)
			ndao = new NoticeDao();
		return ndao;
	}//getInstance
	
	/* 전체 공지 목록 */
	public ArrayList<NoticeBean> getAllNotice(){
		ArrayList<NoticeBean> lists = new ArrayList<NoticeBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from notice order by impor, regdate";

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
				
				int seqno = rs.getInt("seqno");
				int impor = rs.getInt("impor");
				String code = rs.getString("code");
				String id = rs.getString("id");
				String subject = rs.getString("subject");
				String regdate = rs.getString("regdate");
				String content = rs.getString("content");
				
				nb = new NoticeBean(seqno,impor,code,id,subject,regdate,content);
				
				lists.add(nb);
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
		
	}//getAllNotice
	
	/* 부서 코드로 강의 목록 가져오기 */
	public ArrayList<NoticeBean> getNoticebyCode(String ccode) {
		ArrayList<NoticeBean> lists = new ArrayList<NoticeBean>();
		
		//3.sql문 작성, 분석
		String sql = "select * from notice where code=? order by impor, regdate";
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
				int seqno = rs.getInt("seqno");
				int impor = rs.getInt("impor");
				String code = rs.getString("code");
				String id = rs.getString("id");
				String subject = rs.getString("subject");
				String regdate = rs.getString("regdate");
				String content = rs.getString("content");
				
				nb = new NoticeBean(seqno,impor,code,id,subject,regdate,content);
				
				lists.add(nb);
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
		
	}//getNoticebyCode
	
	/* seqno로 해당 공지 가져오기 */
	public NoticeBean getNoticebyNo(int seqno){
		//3.sql문 작성, 분석
		String sql = "select * from notice where seqno=?";
		try {
			ps = conn.prepareStatement(sql);
			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			ps.setInt(1, seqno);

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			if(rs.next()) {
				nb = new NoticeBean();
				
				nb.setSeqno(seqno);
				nb.setImpor(rs.getInt("impor"));
				nb.setCode(rs.getString("code"));
				nb.setId(rs.getString("id"));
				nb.setSubject(rs.getString("subject"));
				nb.setRegdate(rs.getString("regdate"));
				nb.setContent(rs.getString("content"));
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

		return nb;
		
	}//getNoticebyNo
	
}
