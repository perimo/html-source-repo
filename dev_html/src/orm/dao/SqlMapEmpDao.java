package orm.dao;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapEmpDao {
	Logger logger = Logger.getLogger(SqlMapEmpDao.class);//파라미터에는 - 객체 주입을 어디에 시켜줄건가 하는것 //단위테스트로 로그 찍어보는 코드
	SqlSessionFactory sqlMapper = null;
	String resource = "orm/mybatis/Configuration.xml";//Configuration 안에 ip,port,user,pw 정보가 들어있고 그걸 resource에 담았다. 
	/*************************************************************
	 * 사원등록 구현하기.
	 * sql문 - INSERT INTO emp VALUES(?,?,?,?,?,?,?,?)
	 * @param pMap(사원번호,사원명,job,그룹코드,입사일자,급여,인센티브,부서번호)
	 * @return
	 *************************************************************/
	public int empINS(Map<String, Object> pMap) {
		logger.info("empINS 호출 성공");
		int result = 0;
		try {
			Reader reader = Resources.getResourceAsReader(resource);//inputStream느낌으로 resource(ip,port,user,pw)의 정보를 읽어와서 reader에 담았다.
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);//build는 컴파일의 느낌으로 reader정보를 받아와 인스턴스화로 SqlSessionFactory객체를 생성했다.
			//sql문을 요청하기 위한 sqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();//생성한 SqlSessionFactory 객체를 SqlSession에 담앗다.
			//result = sqlSes.update("empINS2",pMap);//insert문의 반환값을 알아보기 위한 테스트문장
			result = sqlSes.update("empINS",pMap);
			//오토커밋 모드가 꺼진 상태가 디폴트이므로 반드시 커밋 해줘야지 디비에 반영된다.
			sqlSes.commit();
			logger.info("result: "+result);//executeUpdate()은 리턴값이 무조건 int
		} catch (Exception e) {
			e.printStackTrace();//힌트가 더 많다
		}
		return result;
	}
	public List<Map<String, Object>> empList(Map<String, Object> pMap) {//파라미터 타입에 대한 변수 pMap
		logger.info("empList 호출 성공");//콘솔 로그에 자세하게 찍어준다.//info레벨이 가장 적합하다. log4j.propertise 파일에서 확인가능
		//logger.debug("debug 호출 성공");
		//logger.warn("warn 호출 성공");
		//logger.error("error 호출 성공");
		//logger.fatal("fatal 호출 성공");
		
		List<Map<String, Object>> elist = null;
		try {
			Reader reader = Resources.getResourceAsReader(resource);//inputStream느낌으로 resource(ip,port,user,pw)의 정보를 읽어와서 reader에 담았다.
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);//build는 컴파일의 느낌으로 reader정보를 받아와 인스턴스화로 SqlSessionFactory객체를 생성했다.
			//sql문을 요청하기 위한 sqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();//생성한 SqlSessionFactory 객체를 SqlSession에 담앗다.
			elist = sqlSes.selectList("empList",pMap);
			System.out.println("조회한 로우 수: "+elist.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return elist;
	}
	public static void main(String[] args) {
		SqlMapEmpDao eDao = new SqlMapEmpDao();
		//eDao.empList(null);
		Map<String,Object> pMap = new HashMap<>();
		pMap.put("empno", 9010);
		int result = eDao.empINS(pMap);
		System.out.println("result: "+result);
		
	}
}
