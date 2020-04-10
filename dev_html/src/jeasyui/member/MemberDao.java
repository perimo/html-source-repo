package jeasyui.member;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/*
 * DML(기본) - 프로시저 - MyBatis[ORM솔루션-코드가 30%이상 줄어듬]
 */

import com.util.DBConnectionMgr;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;
public class MemberDao {
	DBConnectionMgr 		dbMgr  = DBConnectionMgr.getInstance();
	Connection 				con    = null;//물리적으로 떨어져있는 오라클 서버와 연결통로를 만든다.
	PreparedStatement 		pstmt  = null;
	ResultSet 				rs 	   = null;//커서를 이동시킨다//rs.next(), rs.previous(), rs.absolute(3)
	CallableStatement 		cstmt  = null;//프로시저 전담 요원
	OracleCallableStatement ocstmt = null;//REFCURSOR 조작
	
	//회원 목록 조회 실습1 - SELECT문 활용
	public List<Map<String, Object>> memberList() {
		List<Map<String, Object>> mList = new ArrayList<Map<String,Object>>();
		
		StringBuilder sql = new StringBuilder();
		try {
			sql.append("SELECT mem_no,mem_id,mem_pw,mem_name,zipcode,mem_addr,mem_email FROM member_t");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			Map<String, Object> rmap = null;
			while (rs.next()) {//커서의 위치에 데이터가 존재하니? 
				rmap = new HashMap<String, Object>();//true면 rmap을 생성
				rmap.put("mem_no", rs.getInt("mem_no"));
				rmap.put("mem_id", rs.getString("mem_id"));
				rmap.put("mem_pw", rs.getString("mem_pw"));
				rmap.put("mem_name", rs.getString("mem_name"));
				rmap.put("zipcode", rs.getString("zipcode"));
				rmap.put("mem_addr", rs.getString("mem_addr"));
				rmap.put("mem_email", rs.getString("mem_email"));
				mList.add(rmap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mList;
	}
	
	//회원 목록 조회 실습2 - 프로시저 활용(금융, 회계 분야에서 자주 사용)
	public List<Map<String, Object>> procMemberList() {
		List<Map<String, Object>> mList = null;
		try {
			//DBConnectionMgr 공통 코드를 작성 했으므로 드라이버명,계정정보,orcl11[SID] 생략가능
			con = dbMgr.getConnection();
			cstmt = con.prepareCall("{call proc_memberList(?)}");
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.execute();//프로시저 처리 요청 메소드 호출
			//오라클에서만 제공되는 REFCURSOR이므로 오라클에서 제공하는 인터페이스로 형전환하기
			ocstmt = (OracleCallableStatement)cstmt;
			rs = ocstmt.getCursor(1);
			Map<String, Object> rmap = null;
			mList = new ArrayList<Map<String,Object>>();
			while (rs.next()) {//커서의 위치에 데이터가 존재하니?
				rmap = new HashMap<>();//true면 rmap을 생성
				rmap.put("mem_no", rs.getInt("mem_no"));
				rmap.put("mem_id", rs.getString("mem_id"));
				rmap.put("mem_pw", rs.getString("mem_pw"));
				rmap.put("mem_name", rs.getString("mem_name"));
				rmap.put("zipcode", rs.getString("zipcode"));
				rmap.put("mem_addr", rs.getString("mem_addr"));
				rmap.put("mem_email", rs.getString("mem_email"));
				mList.add(rmap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mList;
	}
	
	public static void main(String[] args) {
		MemberDao mdao = new MemberDao();
		List<Map<String, Object>> mList = null;
		mList = mdao.memberList();
		if (mList != null) {
			System.out.println("mList.size() ==> "+mList.size());//3
		}
		mList = mdao.procMemberList();//프로시저 사용한 메소드 출력
		if (mList != null) {
			System.out.println("mList.size() ==> "+mList.size());//3
		}
	}
}
