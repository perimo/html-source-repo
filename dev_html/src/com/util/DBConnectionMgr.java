package com.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
	
public class DBConnectionMgr {
	Connection          con = null; //전역변수 선언하기 - 클래스() 전역에서 사용가능함.
	//이 클래스를 읽어야 오라클 제품인것을 확인 가능함.
	public static final String _DRIVER = "oracle.jdbc.driver.OracleDriver";
	//물리적으로 떨어져있는 오라클 서버에URL정보 추가
	public static final String _URL = "jdbc:oracle:thin:@192.168.0.28:1521:orcl11";
	public static String _USER = "SCOTT"; //아이디나 비번은 바뀌는값이라 final 뺸다.
	public static String _PW = "tiger";
	//static은 클래스급이다.-공유(여러개가 아니라 하나를 접근하는것이다-정적변수)
	private static DBConnectionMgr dbMgr = null;
	private DBConnectionMgr() {} //생성자를 프라이빗으로 숨겨두면서 한번만 생성한다. : 싱글톤패턴
	
	//싱글톤 패턴으로 객체 관리하기 - 하나의 객체를 여러명이 관리할 수 있다  -인스턴스화 과정이다.
	public static DBConnectionMgr getInstance() {
		if(dbMgr == null) {
			dbMgr = new DBConnectionMgr();
		}
		return dbMgr;   //null일떄는 인스턴스화 null이 아니면 그대로 쓰라는것
	}
	//물리적으로 떨어져있는 오라클 서버와 연결통로 만들기
	//인스턴스화 해주는 메소드 구현
	public Connection getConnection() { //import해야함
		System.out.println("getConnection 호출성공");
		//오라클 회사 정보를 수집함
		try {
			Class.forName(_DRIVER); //오라클 제조사 제품정보 드라이버 이름이 런타임 에러가 날수있으니 예외처리 해야함
			//con = new Connection(); 반드시 구현체 클래스가 있어야한다.
			con = DriverManager.getConnection(_URL     //자바에서 제공해주는 API
											 ,_USER
											 ,_PW);
		} catch (ClassNotFoundException ce) {
			System.out.println("드라이버 클래스 이름을 찾을 수 없어요.");
		} catch (Exception e) {
			System.out.println("예외가 발생했음. 정상적으로 처리가 안됨.");
		}
		return con;
	}
	/*
	 * DBConnectionMgr은 여러 업무에서 공통으로 사용하는 클래스 입니다.
	 * 사용한 자원(Connection, preparedStatement, ResultSet)은 반드시 반납을 하도록 합니다.
	 * 동시 접속자 수가 많은 시스템에서 자원 사용은 곧 메모리랑 직결되므로
	 * 서버가 다운되거나 시스템 장애 발생에 원인이 됩니다.
	 */
	public void freeConnection(Connection con
							 , PreparedStatement pstmt
							 , ResultSet rs) {
		try {
		//사용자원의 생성 역순으로 반환할것	
			if(rs != null) {
				rs.close();
			}
			if(pstmt != null) {
				pstmt.close();
			}
			if(con != null) {
				con.close();
			}
		}
		catch(Exception e) {
			System.out.println("Exception : "+e.toString());
		}
	}
	//자바에서는 같은 이름의 메소드를 여러개 만들 수 있다.
	//1번째 방법: 메소드 오버로딩 - 파라미터 갯수
	//2번째 방법: 메소드 오버라이딩
	public void freeConnection(Connection con
							 , PreparedStatement pstmt) { //여기서 파라미터 갯수를 하나 없애면 메소드 오버로딩(같은이름의 메소드 중복정의) 가능
		try {
			//사용자원의 생성 역순으로 반환할것	
			if(pstmt != null) {
				pstmt.close();
			}
			if(con != null) {
				con.close();
			}
		}
		catch(Exception e) {
			System.out.println("Exception : "+e.toString());
		}
	}
	public void freeConnection(Connection con
							 , CallableStatement cstmt) { //여기서 파라미터 갯수를 하나 없애면 메소드 오버로딩(같은이름의 메소드 중복정의) 가능
		try {
			//사용자원의 생성 역순으로 반환할것	
			if(cstmt != null) {
				cstmt.close();
			}
			if(con != null) {
				con.close();
			}
		}
		catch(Exception e) {
			System.out.println("Exception : "+e.toString());
		}
	}
}
