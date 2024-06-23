package kr.member.vo;

public class MemberVO {
	private int mem_num;			//회원 번호
	private String mem_id;			//아이디
	private int mem_auth;			//회원등급
	private String mem_name;		//이름
	private String mem_email;		//이메일
	private String mem_passwd; 		//비밀번호
	private String mem_birth;		//생년월일
	private String mem_phone;		//전화번호
	private String mem_zipcode;		//우편번호
	private String mem_address1;	//주소
	private String mem_address2;	//상세 주소
	private String mem_photo;		//프로필사진
	private String mem_reg;			//가입일
	private String mem_modify;		//수정일
	private int mem_grade;			//등급
	private int mem_total;			//총 누적 구매 금액
	
	//비밀번호 일치 여부 확인 
	public boolean isCheckedPassword(String userPasswd) {
		if(mem_auth > 1 && mem_passwd.equals(userPasswd)) {
			return true;
		}		
		return false;
	}
		
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getMem_auth() {
		return mem_auth;
	}
	public void setMem_auth(int mem_auth) {
		this.mem_auth = mem_auth;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_passwd() {
		return mem_passwd;
	}
	public void setMem_passwd(String mem_passwd) {
		this.mem_passwd = mem_passwd;
	}
	public String getMem_birth() {
		return mem_birth;
	}
	public void setMem_birth(String mem_birth) {
		this.mem_birth = mem_birth;
	}
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getMem_zipcode() {
		return mem_zipcode;
	}
	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}
	public String getMem_address1() {
		return mem_address1;
	}
	public void setMem_address1(String mem_address1) {
		this.mem_address1 = mem_address1;
	}
	public String getMem_address2() {
		return mem_address2;
	}
	public void setMem_address2(String mem_address2) {
		this.mem_address2 = mem_address2;
	}
	public String getMem_photo() {
		return mem_photo;
	}
	public void setMem_photo(String mem_photo) {
		this.mem_photo = mem_photo;
	}
	public String getMem_reg() {
		return mem_reg;
	}
	public void setMem_reg(String mem_reg) {
		this.mem_reg = mem_reg;
	}
	public String getMem_modify() {
		return mem_modify;
	}
	public void setMem_modify(String mem_modify) {
		this.mem_modify = mem_modify;
	}
	public int getMem_grade() {
		return mem_grade;
	}
	public void setMem_grade(int mem_grade) {
		this.mem_grade = mem_grade;
	}
	public int getMem_total() {
		return mem_total;
	}
	public void setMem_total(int mem_total) {
		this.mem_total = mem_total;
	}
	
}
