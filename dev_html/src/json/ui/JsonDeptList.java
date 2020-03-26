package json.ui;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

public class JsonDeptList {
	
	public List<Map<String, Object>> getDeptList() {
		List<Map<String, Object>> deptList = new ArrayList<Map<String,Object>>();
		Map<String, Object> rmap = new HashMap<>(); //1번째 주소 번지가 생김
		rmap.put("rno", 1);
		rmap.put("deptno", 10);
		rmap.put("dname", "총무부");
		rmap.put("loc", "인천");
		deptList.add(rmap); //List.add 추가
		
		rmap = new HashMap<>(); //2번째 주소 번지가 생김
		rmap.put("rno", 2);
		rmap.put("deptno", 20);
		rmap.put("dname", "영업부");
		rmap.put("loc", "서울");
		deptList.add(rmap); //List.add 추가
		
		rmap = new HashMap<>(); //3번째 주소 번지가 생김
		rmap.put("rno", 3);
		rmap.put("deptno", 30);
		rmap.put("dname", "개발부");
		rmap.put("loc", "제주도");
		deptList.add(rmap); //List.add 추가
		
		return deptList;
	}
	
	public static void main(String[] args) {
		JsonDeptList jdl = new JsonDeptList();
		List<Map<String, Object>> deptList = jdl.getDeptList();
		Gson g = new Gson();
		String temp = g.toJson(deptList);
		System.out.println(temp);
	}


}
