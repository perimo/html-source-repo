package project.restaurant;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

import oracle.jdbc.OracleCallableStatement;//오라클 회사가 지원함.
import oracle.jdbc.OracleTypes;

public class RestaurantDao {
	DBConnectionMgr   dbMgr = DBConnectionMgr.getInstance();// 싱글톤 패턴
	Connection 		  con   = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	CallableStatement cstmt = null;
	//
	OracleCallableStatement ocstmt = null;
	
	/****************************************************************************************
	 * 프로시저를 활용하여 로그인 처리하기.
	 * @param mem_id : 사용자가 입력한 아이디
	 * @param mem_pw : 사용자가 입력한 비번
	 * @return msg : proc_login2020(u_id IN varchar2, u_pw IN varchar2, msg OUT varchar2)
	 ****************************************************************************************/
	public String login(String mem_id, String mem_pw) {
		String msg = null;
		int result = 0;
		try {
			con = dbMgr.getConnection();
			cstmt = con.prepareCall("{ call proc_login2020(?,?,?)}");
			cstmt.setString(1, mem_id);//메소드의 파라미터로 사용자가 입력한 아이디를 받아옴.
			cstmt.setString(2, mem_pw);//IN 속성일때 setString으로 가져오기
			cstmt.registerOutParameter(3, OracleTypes.VARCHAR);//OUT 속성일때만
			//cstmt.execute();//boolean
			result = cstmt.executeUpdate();//int
			msg = cstmt.getString(3);//OUT 속성일때는 get으로
			System.out.println("result: "+result+", msg: "+msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	//프로시저 활용하는 방법(셀렉트문이 필요없다.)
	public List<Map<String, Object>> procRestList() {
		List<Map<String, Object>> rList = null;
		StringBuilder sql = new StringBuilder();
		try {
			//con전에 오라클사가 배포하는 드라이버 클래스를 스캔한다.
			con = dbMgr.getConnection();//물리적으로 떨어져있는 서버에 연결통로 확보
			//pstmt = con.prepareStatement(sql.toString());//프로시저는 pstmt 대신 CallableStatement를 사용
			//DML을 요청할 떈 PreparedStatement 사용
			//프로시저를 요청할 땐 CallableStatement 사용
			cstmt = con.prepareCall("{call proc_restaurant(?)}");//여기에서 프로시저 이름을 불러준거고
			//프로시저의 OUT속성을 지정함.
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.execute();//여기에서 오라클에 살고있는 옵티마이저에게 처리해달라고한다.
			ocstmt = (OracleCallableStatement)cstmt;
			rs = ocstmt.getCursor(1);//커성[ OUT속성 하나니까 (1)
			rList = new ArrayList<>();
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
	
	public List<Map<String, Object>> restList() {  //식당 정보를 조회하는 메소드 
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
	
	public List<Map<String, Object>> mapRestList() {  //식당 정보를 조회하는 메소드 
		List<Map<String, Object>> mrList = null;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT res_num, res_name, res_tel, res_hate, res_like, res_photo, lat, lng ");
		sql.append(" FROM restaurant");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			mrList = new ArrayList<Map<String,Object>>();
			Map<String, Object> rmap = null;
			while (rs.next()) {
				rmap = new HashMap<>();
				rmap.put("res_num", rs.getInt("res_num"));
				rmap.put("res_name", rs.getString("res_name"));
				rmap.put("res_tel", rs.getString("res_tel"));
				rmap.put("res_hate", rs.getInt("res_hate"));
				rmap.put("res_like", rs.getInt("res_like"));
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
		
	public int restINS(Map<String, Object> pMap) {//식당 정보를 입력하는 메소드
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
	
	public static void main(String[] args) {
		RestaurantDao rdao = new RestaurantDao();
		//rdao.procRestList();
		String msg = rdao.login("test", "123");
		System.out.println("msg: "+msg);
	}
}
