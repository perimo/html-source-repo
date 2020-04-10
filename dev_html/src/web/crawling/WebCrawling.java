package web.crawling;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

//원래 이름은 스크래핑(scraping) 현재는 크롤링(crawling) 이라 불린다
//웹 페이지의 페이지 소스 보기로 보이는 코드중 원하는 코드를 발췌하는 것이 웹크롤링.
public class WebCrawling {
	void methodA() {
		try {
			//크롤링 할 URL 입력받기
			URL url = new URL("http://localhost:8000/day4/deptList2.jsp");//jsp파일을 만들고 실행시킨뒤  페이지소스보기에서 코드를 가져올거기때문에jsp파일 실행 뒤  url을 복사해온다
			InputStreamReader isr = new InputStreamReader(url.openStream());//url을 실행한 뒤 보이는 소스를 읽어오기 위한 코드//우선 읽어만 온다.
			BufferedReader br = new BufferedReader(isr);//라인 단위로 소스를 읽어오는 클래스. 위에서 읽어온 소스를 라인단위로 읽어온다.
			String tags = null;
			StringBuilder sb = new StringBuilder();//문자열을 담기위한 클래스
			while ((tags = br.readLine()) != null) {//BufferedReader클래스의 readLine 기능으로 읽어온 소스코드를 라인 단위로 tags변수에 담는다.
				sb.append(tags);//라인 단위의 문자열을 sb에 붙인다. 
			}
			System.out.println("sb.toString()출력하면? => "+sb.toString());
			br.close();//사용한 자원 반납한다.
		
			//크롤링 시작 - 키(타이틀)값 가져오기
			List<String> titleList = new ArrayList<String>();//문자열타입의 타이틀을 담을 List배열을 선언 및 생성
			String strs[] = sb.toString().split("<th>");//첫번째 <th>에서 잘라서 배열에 담을거다.
			for (int i = 0; i < strs.length; i++) {//반복문으로 <th> 자른 값들을 담는다.
				System.out.println("strs["+i+"]==>"+strs[i]);
			}
			String strs2[] = null;//</th>에서 한번 더 잘라서 배열에 담기 위해 다시 배열 선언.
			for (int i = 1; i < strs.length; i++) {//위에 잘라서 담아둔 배열의 크기만큼 반복.
				strs2 = strs[i].split("</th>"); //</th>에서 잘라서 다시 배열에 담기
				titleList.add("strs2["+i+"]==>"+strs2[0]);//timeList배열에 위에서 자른 배열값들을 붙인다.
				System.out.println("strs2["+i+"]==>"+strs2[0]);
				//System.out.println("titleList: "+titleList);
			}
			for (String title : titleList) {
				System.out.println("title==> "+title);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	public static void main(String[] args) {
		WebCrawling wc = new WebCrawling();
		wc.methodA();

	}

}
