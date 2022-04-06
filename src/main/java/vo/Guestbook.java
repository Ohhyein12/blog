package vo;

public class Guestbook {
	public Guestbook() {}
	private int guestbookNo; // guest_no
	private String guestbookContent; // guestbook_content
	private String writer; // writer
	private String createDate; // create_date
	private String updateDate; // update_date
	private String guestbookPw; // guestbook_pw
	
	public int getGuestbookNo() {
		return guestbookNo;
	}
	public void setGuestbookNo(int guestbookNo) {
		this.guestbookNo = guestbookNo;
	}
	public String getGuestbookContent() {
		return guestbookContent;
	}
	public void setGuestbookContent(String guestbookContent) {
		this.guestbookContent = guestbookContent;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getGuestbookPw() {
		return guestbookPw;
	}
	public void setGuestbookPw(String guestbookPw) {
		this.guestbookPw = guestbookPw;
	}
	
	
}
