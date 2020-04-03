package project.restaurant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

public class RestaurantDao {
	DBConnectionMgr   dbMgr = DBConnectionMgr.getInstance();// 싱글톤 패턴
	Connection 		  con   = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public List<Map<String, Object>> restList() {  //조회하는 메소드 
		List<Map<String, Object>> rList = null;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT res_num, res_name, res_tel, res_addr, res_hate");
		sql.append("	  ,res_like, res_photo, res_info, res_time");
		sql.append("	  ,lat, lng");
		sql.append(" FROM restaurant");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			rList = new ArrayList<Map<String,Object>>();
			Map<String, Object> rmap = null;
			while (rs.next()) {
				rmap = new HashMap<>();
				rmap.put("res_num", rs.getInt("res_num"));
				rmap.put("res_name", rs.getString("res_name"));
				rmap.put("res_tel", rs.getString("res_tel"));
				rmap.put("res_addr", rs.getString("res_addr"));
				rmap.put("res_hate", rs.getInt("res_hate"));
				rmap.put("res_like", rs.getInt("res_like"));
				rmap.put("res_photo", rs.getString("res_photo"));
				rmap.put("res_info", rs.getString("res_info"));
				rmap.put("res_time", rs.getString("res_time"));
				rmap.put("lat", rs.getDouble("lat"));
				rmap.put("lng", rs.getDouble("lng"));
				rList.add(rmap);
			}
			System.out.println(rList.size()); //컬럼정보들이 모두 들어간 하나의 로우가 rList의 방 하나에 들어간다.따라서  오라클의 restaurant테이블에 5개의 정보가 있으니 5가찎히면 맞다
		} catch (SQLException e) {
			System.out.println("[[query]]: "+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rList;
	}
	
		public List<Map<String, Object>> mapRestList() {  //조회하는 메소드 
			List<Map<String, Object>> mrList = null;
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT res_name, res_photo, lat, lng ");
			sql.append(" FROM restaurant");
			try {
				con = dbMgr.getConnection();
				pstmt = con.prepareStatement(sql.toString());
				rs = pstmt.executeQuery();
				mrList = new ArrayList<Map<String,Object>>();
				Map<String, Object> rmap = null;
				while (rs.next()) {
					rmap = new HashMap<>();
					rmap.put("res_name", rs.getString("res_name"));
					rmap.put("res_photo", rs.getString("res_photo"));
					rmap.put("lat", rs.getDouble("lat"));
					rmap.put("lng", rs.getDouble("lng"));
					mrList.add(rmap);
				}
				System.out.println(mrList.size());
				
			} catch (SQLException e) {
				System.out.println("[[query]]: "+sql.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return mrList;
	}
		
	public int restINS(Map<String, Object> pMap) {
		int result = 0;
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO restaurant(res_num, res_name, res_tel, res_addr ");
        sql.append("        ,res_hate, res_like, res_photo                      ");
        sql.append("        ,res_info, res_time, lat, lng)                      ");
		sql.append("VALUES(seq_restaurant_num.nextval,?,?,?,0,0,?,?,?,?,?)      ");
		
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			pstmt.setString(++i, pMap.get("res_name").toString());
			pstmt.setString(++i, pMap.get("res_tel").toString());
			pstmt.setString(++i, pMap.get("res_addr").toString());
			pstmt.setString(++i, pMap.get("res_photo").toString());
			pstmt.setString(++i, pMap.get("res_info").toString());
			pstmt.setString(++i, pMap.get("res_time").toString());
			pstmt.setDouble(++i, Double.parseDouble(pMap.get("lat").toString()));//위도는 소수점있으니 Double타입으로 받아야한다.
			pstmt.setDouble(++i, Double.parseDouble(pMap.get("lng").toString()));
			result = pstmt.executeUpdate();
			System.out.println("result값: "+result); //성공시 1, 실패시 0
		} catch (SQLException se) {
			System.out.println("[[query]]: "+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbMgr.freeConnection(con, pstmt);
			
		}
		return result;
	}
}
