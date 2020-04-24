package orm.dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapBookDao {
	Logger logger = Logger.getLogger(SqlMapBookDao.class);//단위 테스트로 로그를 확인시켜주는 코드
	SqlSessionFactory sqlMapper = null;
	String resource = "orm/mybatis/Configuration.xml";//오라클에 다녀오기위해 ip,port,user,pw를 가지고 있는 Configuration.xml 파일의 정보를 담았다.
	/********************************************
	 * 도서정보 구현하기 구현
	 * @param pmap - 사용자가 자동완성 textbox에 입력한 도서제목 정보
	 * @return - 사용자가 입력한 도서 정보를 선분조건(Like 패턴)으로 검색하여 결과 반환
	 ********************************************/
	public List<Map<String, Object>> bookList(Map<String, Object> pmap){
		logger.info("book_title: "+pmap.get("book_title")+", choMode: "+pmap.get("choMode"));
		//아래에서 선언만 되어있다. 따라서 검색결과가 존재하지 않을 경우 NullPointerException의 원인이 될 수 도 있다.
		//가급적이면 에러를 피해갈 수 있도록 코딩을 전개한다.
		List<Map<String, Object>> bList = new ArrayList<>();
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlses = sqlMapper.openSession();//여기서 의존성 객체주입이 일어난다.
			bList = sqlses.selectList("bookList",pmap);////첫번째 파라미터는 사용할 SQL문이 있는 xxx.xml파일의 id, 두번쨰 파라미터는  xxx.xml파일 셀렉트문의 파라미터 타입 
			logger.info("bList.size() ===> "+bList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bList;//여기서의 bList는 session.selectList(“getBookList”, pmap)이다 // pmap은 파라미터로 받아온 값
	}				 //selectList는 조회 된 결과를 로우 별로 Map에 담고, 그 Map으로 List를 만들어주는 메소드이다.
					//첫 번째 파라미터는 수행할 sql문의 id값이고, 두 번째 파라미터는 수행할 sql문의 파라미터로 보낼 값이다. ‘getBookList라는 메소드를 pMap이라는 파라미터로 호출한다.’ 라고 이해해도 된다.
					//그러면 이제 getBookList라는 sql문을 찾아가보자. 이것은 book.xml에 있다

	public static void main(String[] args) {
		SqlMapBookDao bDao = new SqlMapBookDao();
		bDao.bookList(null);
	}
}
