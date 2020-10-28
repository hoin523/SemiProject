package com.lec.beans;

public class SellDataDTO {

	int cus_num;
	int pro_num;
	String sell_date;
	int sell_cnt;
	int sell_sum;
	
	public SellDataDTO() {
		super();
		System.out.println("SellDataDTO() 객체 생성");
	}
	
	public SellDataDTO(int cus_num, int pro_num, String sell_date, int sell_cnt, int sell_sum) {
		super();
		this.cus_num = cus_num;
		this.pro_num = pro_num;
		this.sell_date = sell_date;
		this.sell_cnt = sell_cnt;
		this.sell_sum = sell_sum;
	}
	
	public int getCus_num() {
		return cus_num;
	}
	public void setCus_num(int cus_num) {
		this.cus_num = cus_num;
	}
	public int getPro_num() {
		return pro_num;
	}
	public void setPro_num(int pro_num) {
		this.pro_num = pro_num;
	}
	public String getSell_date() {
		return sell_date;
	}
	public void setSell_date(String sell_date) {
		this.sell_date = sell_date;
	}
	public int getSell_cnt() {
		return sell_cnt;
	}
	public void setSell_cnt(int sell_cnt) {
		this.sell_cnt = sell_cnt;
	}
	public int getSell_sum() {
		return sell_sum;
	}
	public void setSell_sum(int sell_sum) {
		this.sell_sum = sell_sum;
	}
	
	@Override
	public String toString() {
		return "SellDataDTO [cus_num=" + cus_num + ", pro_num=" + pro_num + ", sell_date=" + sell_date + ", sell_cnt="
				+ sell_cnt + ", sell_sum=" + sell_sum + "]";
	}
	
	
	
}
