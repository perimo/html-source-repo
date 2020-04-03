package com.dept;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

public class DeptDao {
	DBConnectionMgr   dbMgr = null;
	Connection        con   = null;
	PreparedStatement pstmt = null;
	ResultSet         rs    = null;
	
	public List<Map<String, Object>> deptList() {
		dbMgr = DBConnectionMgr.getInstance();//싱글톤 패턴으로 객체 가져다 쓰기
		List<Map<String, Object>> dList = null;
		StringBuilder sql = new StringBuilder();
		try {
			sql.append("SELECT deptno, dname, loc FROM dept");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery(); //select문은 executeQuery(), 입력,수정,삭제는 executeUpdate(), create(테이블생성) 할떄는 execute()
			//parsing - DBMS 실행계획 - 옵티마이저 - Open..Fetch..Close
			//세개 컬럼은 Map에 담고 여러개의 로우는 List에 담기
			dList = new ArrayList<>();
			Map<String, Object> rMap = null;
			while (rs.next()) {
				rMap = new HashMap<>();
				rMap.put("deptno", rs.getInt("deptno"));
				rMap.put("dname", rs.getString("dname"));
				rMap.put("loc", rs.getString("loc"));
				dList.add(rMap);//컬럼 3개가, 로우 한개가
			}
			System.out.println(dList.size());
		} catch (SQLException se) {
			System.out.println("[[query]]"+sql.toString());
		} catch (Exception e) {
			System.out.println("[[Exception]]"+e.toString());
		} finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return dList;
	}
//////////////////////////////////////////////////////////////////////////////////
	public List<DeptVO> deptVOList() {
		dbMgr = DBConnectionMgr.getInstance();//싱글톤 패턴으로 객체 가져다 쓰기
		List<DeptVO> dList = null;
		StringBuilder sql = new StringBuilder();
		
		try {
			sql.append("SELECT deptno, dname, loc FROM dept");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery(); //select문은 executeQuery(), 입력,수정,삭제는 executeUpdate(), create(테이블생성) 할떄는 execute()
			//parsing - DBMS 실행계획 - 옵티마이저 - Open..Fetch..Close
			//세개 컬럼은 Map에 담고 여러개의 로우는 List에 담기
			dList = new ArrayList<>();
			DeptVO dVO = null;
			while (rs.next()) {
				dVO = new DeptVO();
				dVO.setDeptno(rs.getInt("deptno"));
				dVO.setDname(rs.getString("dname"));
				dVO.setLoc(rs.getString("loc"));
				dList.add(dVO);//컬럼 3개가, 로우 한개가
			}
			System.out.println(dList.size());
		} catch (SQLException se) {
			System.out.println("[[query]]"+sql.toString());
		} catch (Exception e) {
			System.out.println("[[Exception]]"+e.toString());
		} finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return dList;
	}
}
