package orm.dao;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapDeptDao {
	Logger logger = Logger.getLogger(SqlMapDeptDao.class);
	String resource="orm/mybatis/Configuration.xml";
	SqlSessionFactory sqlMapper = null;
	public List<Map<String, Object>> deptList() {
		List<Map<String, Object>> dList = null;
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			dList = sqlSes.selectList("deptList");
			logger.info("조회수: "+dList.size());
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dList;
	}
	public static void main(String[] args) {
		SqlMapDeptDao smd = new SqlMapDeptDao();
		smd.deptList();
	}
}
