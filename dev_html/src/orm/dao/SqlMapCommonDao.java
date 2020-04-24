package orm.dao;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapCommonDao {
	Logger logger = Logger.getLogger(SqlMapDeptDao.class);
	SqlSessionFactory sqlMapper = null;
	/**********************************
	 * 주소 검색 - 도 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>>
	 * 업무설명 :
	 * 작성자 : 강감찬
	 * 202년 4월 24일
	 **********************************/
	public  List<Map<String, Object>> getZDOList(Map<String, Object> pmap){
		logger.info("getZDOList 호출 성공");
		String resource = "orm/mybatis/Configuration.xml";//Configuration 안에 ip,port,user,pw 정보가 들어있고 그걸 resource에 담았다.
		List<Map<String, Object>> zdoList = null;
		try {
			Reader reader = Resources.getResourceAsReader(resource);//inputStream느낌으로 resource(ip,port,user,pw)의 정보를 읽어와서 reader에 담았다.
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);//build는 컴파일의 느낌으로 reader정보를 받아와 인스턴스화로 SqlSessionFactory객체를 생성했다.
			//sql문을 요청하기 위한 sqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();//생성한 SqlSessionFactory 객체를 SqlSession에 담앗다.
			zdoList = sqlSes.selectList("getZDOList",pmap);
			System.out.println("조회한 로우 수: "+zdoList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return zdoList;
	}
	/**********************************
	 * 주소 검색 - 구 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>>
	 * 업무설명 :
	 * 작성자 : 강감찬
	 * 202년 4월 24일
	 **********************************/
	public  List<Map<String, Object>> getSiGuList(Map<String, Object> pmap){
		logger.info("getSiGuList 호출 성공");
		List<Map<String, Object>> siguList = null;
		return siguList;
	}
	/**********************************
	 * 주소 검색 - 동 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>>
	 * 업무설명 :
	 * 작성자 : 강감찬
	 * 202년 4월 24일
	 **********************************/
	public  List<Map<String, Object>> getDongList(Map<String, Object> pmap){
		logger.info("getDongList 호출 성공");
		List<Map<String, Object>> dongList = null;
		return dongList;
	}
}
