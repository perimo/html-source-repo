package project.restaurant;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;

import javax.swing.JButton;
//JDialog 는 부모창이 닫혔을떄 같이 자원 회수가 일어난다. JFrame과 다른점!
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class RestINSView extends JDialog implements ActionListener{
	JLabel 		jlb_name   = new JLabel("식당명");
	JTextField  jtf_name   = new JTextField(30);
	JLabel 	 	jlb_tel    = new JLabel("전화번호");
	JTextField  jtf_tel    = new JTextField(20);
	JLabel      jlb_addr   = new JLabel("주소");
	JTextField  jtf_addr   = new JTextField(60);
	JLabel      jlb_photo  = new JLabel("사진");
	JTextField  jtf_photo  = new JTextField(60);
	JLabel 		jlb_info   = new JLabel("식당소개");
	JTextArea 	jta_info   = new JTextArea(8,25);
	JScrollPane jsp_info   = new JScrollPane(jta_info);
	JLabel      jlb_time   = new JLabel("영업시간");
	JTextField  jtf_time   = new JTextField(60);
	JLabel      jlb_lat    = new JLabel("위도");
	JTextField  jtf_lat    = new JTextField(60);
	JLabel      jlb_lng    = new JLabel("경도");
	JTextField  jtf_lng    = new JTextField(60);
	JButton     jbtn_save  = new JButton("저장");
	JButton     jbtn_close = new JButton("닫기");
	
	public RestINSView() {
		initDisplay();
	}
	/* HTML에서 자리잡기전에 햇던 코드
	 * div#d_msg{ position: absolute;}
	 */
	public void initDisplay() {
		this.setLayout(null);//기본은 borderLayout인데 좌표값으로 배치하기 위해 null로 처리
		jbtn_save.addActionListener(this);
		jbtn_close.addActionListener(this);
		//화면에 배치할때 setBounds(x좌표,y좌표,가로길이,세로길이)
		//앞에 두자리가 시작점 좌표값  20,20 은 시작점이 되는것이다.
		//세번째 네번째가 가로 세로 결정 100,20 은 가로길이와 세로길이
		jlb_name.setBounds(20, 20, 100, 20);
		jtf_name.setBounds(120, 20, 150, 20);
		jlb_tel.setBounds(20, 45, 100, 20);
		jtf_tel.setBounds(120, 45, 120, 20);
		jlb_addr.setBounds(20, 70, 100, 20);
		jtf_addr.setBounds(120, 70, 250, 20);
		jlb_photo.setBounds(20, 95, 100, 20);
		jtf_photo.setBounds(120, 95, 150, 20);
		jlb_info.setBounds(20, 120, 100, 20);
		jsp_info.setBounds(120, 120, 300, 80);
		jlb_time.setBounds(20, 205, 100, 20);
		jtf_time.setBounds(120, 205, 250, 20);
		jlb_lat.setBounds(20, 230, 100, 20);
		jtf_lat.setBounds(120, 230, 120, 20);
		jlb_lng.setBounds(20, 255, 100, 20);
		jtf_lng.setBounds(120, 255, 120, 20);
		jbtn_save.setBounds(140, 285, 100, 20);
		jbtn_close.setBounds(250, 285, 100, 20);
		
		this.add(jlb_name);//라벨
		this.add(jtf_name);//텍스트필드
		this.add(jlb_tel);
		this.add(jtf_tel);
		this.add(jlb_addr);
		this.add(jtf_addr);
		this.add(jlb_photo);
		this.add(jtf_photo);
		this.add(jlb_info);//라벨
		this.add(jsp_info);//스크롤패인
		this.add(jlb_time);
		this.add(jtf_time);
		this.add(jlb_lat);
		this.add(jtf_lat);
		this.add(jlb_lng);
		this.add(jtf_lng);
		this.add(jbtn_save);
		this.add(jbtn_close);
		
		this.setSize(500, 500);
		this.setVisible(true);
		this.setTitle("다이얼로그창");
	}
	public static void main(String[] args) {
		new RestINSView();

	}
	@Override
	public void actionPerformed(ActionEvent e) {
		Object obj = e.getSource();
		if (obj==jbtn_close) {
			System.out.println("닫기 버튼 호출 성공");
			System.exit(0);//가상머신과 연결고리 끊기 //닫기버튼 눌렀을 떄 시스템을 종료한다.
		}
		if (obj==jbtn_save) {
			System.out.println("저장 버튼 호출 성공");
			HashMap<String, Object> pMap = new HashMap<String, Object>();
			pMap.put("res_name", jtf_name.getText()); //Map에서 가져올때는 put  //값을 읽어오니까 getText
			pMap.put("res_tel", jtf_tel.getText());
			pMap.put("res_addr", jtf_addr.getText());
			pMap.put("res_photo", jtf_photo.getText());
			pMap.put("res_info", jta_info.getText());
			pMap.put("res_time", jtf_time.getText());
			pMap.put("lat", jtf_name.getText());
			pMap.put("lng", jtf_name.getText());

			RestaurantDao rest = new RestaurantDao();
			int result = 0;
			result = rest.restINS(pMap);
			if (result == 1) {
				JOptionPane.showMessageDialog(this, "등록되었습니다.");
				this.dispose(); //자원 회수 
				this.setVisible(false); //메모리에는 남아있지만 시각적으로는 닫아준다.
			}
		}
	}
}
