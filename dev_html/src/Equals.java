
public class Equals {

	public static void main(String[] args) {
		String s = "안녕";
		String s1 = new String("안녕");
		//s == s1; 같니? 주소번지가 같니?
		//s.equals(s1); 같니?- 그 주소번지가 가리키는 값이 같니?
		if (s == s1) {
			System.out.println("같다.");
		}
		else {
			System.out.println("다르다.");
		}
////////////////////////////////////////////////////////		
		if (s.equals(s1)) {
			System.out.println("같다.");
		}
		else {
			System.out.println("다르다.");
		}
	}

}
