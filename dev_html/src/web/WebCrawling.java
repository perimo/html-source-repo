package web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

//원래 이름은 스크레이핑(scraping) 현재는 크롤링(crawling) 이라 불린다
public class WebCrawling {
	void methodA() {
		try {
			//크롤링 할 URL 입력받기
			URL url = new URL("http://localhost:8000/day4/deptList2.jsp");
			InputStreamReader isr = new InputStreamReader(url.openStream());
			BufferedReader br = new BufferedReader(isr);
			String tags = null;
			StringBuilder sb = new StringBuilder();
			while ((tags = br.readLine()) != null) {
				sb.append(tags);
			}
			System.out.println(sb.toString());
			br.close();
			//크롤링 시작 - 키(타이틀)값 가져오기
			List<String> titleList = new ArrayList<String>();
			String strs[] = sb.toString().split("<th>");
			for (int i = 0; i < strs.length; i++) {
				System.out.println("strs["+i+"]==>"+strs[i]);
			}
			String strs2[] = null;
			for (int i = 1; i < strs.length; i++) {
				strs2 = strs[i].split("</th>");
				titleList.add("strs2["+i+"]==>"+strs2[0]);
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
