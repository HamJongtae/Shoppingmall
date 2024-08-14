package kr.qa.vo;

public class Qa_CommentVo {
	private int qa_comm_num;
	private int qa_num;
	private String qa_comm_content;
	private String qa_comm_reg;
	private String qa_comm_modify;
	public int getQa_comm_num() {
		return qa_comm_num;
	}
	public void setQa_comm_num(int qa_comm_num) {
		this.qa_comm_num = qa_comm_num;
	}
	public int getQa_num() {
		return qa_num;
	}
	public void setQa_num(int qa_num) {
		this.qa_num = qa_num;
	}
	public String getQa_comm_content() {
		return qa_comm_content;
	}
	public void setQa_comm_content(String qa_comm_content) {
		this.qa_comm_content = qa_comm_content;
	}
	public String getQa_comm_reg() {
		return qa_comm_reg;
	}
	public void setQa_comm_reg(String qa_comm_reg) {
		this.qa_comm_reg = qa_comm_reg;
	}
	public String getQa_comm_modify() {
		return qa_comm_modify;
	}
	public void setQa_comm_modify(String qa_comm_modify) {
		this.qa_comm_modify = qa_comm_modify;
	}
	@Override
	public String toString() {
		return "Qa_CommentVo [qa_comm_num=" + qa_comm_num + ", qa_num=" + qa_num + ", qa_comm_content="
				+ qa_comm_content + ", qa_comm_reg=" + qa_comm_reg + ", qa_comm_modify=" + qa_comm_modify + "]";
	}
}
