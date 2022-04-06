package vo;
// category 테이블 VO(도메인객체) : VO, DTO, Domain
public class Category {
	public Category() {}
	private String categoryName; // create_name
	private String createDate; //create_date
	private String updateDate; // update_date
	
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	
	
}
