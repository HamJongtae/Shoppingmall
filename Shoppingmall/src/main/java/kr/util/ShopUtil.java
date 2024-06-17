package kr.util;

public class ShopUtil {
	public static String getGrade(int mem_grade) {
		String grade = "";
		if(mem_grade==1) {
			grade = "Bronze";
		} else if (mem_grade==2) {
			grade = "Silver";
		} else if (mem_grade==3) {
			grade = "Gold";
		} else if (mem_grade==4) {
			grade = "Platinum";
		} else if (mem_grade==5) {
			grade = "Diamond";
		}
		return grade;
	}
    public static int getDiscount(int mem_grade, int car_price) {
    	double discount;
        switch(mem_grade) {
            case 1: discount = car_price * 0.9341; break;
            case 2: discount = car_price * 0.9441; break;
            case 3: discount = car_price * 0.9541; break;
            case 4: discount = car_price * 0.9641; break;
            default: discount = car_price * 0.9741;
        }
        return (int)discount;
    }
    
    public static int getDiscountFee(int mem_grade, int car_price) {
    	double discount;
    	switch(mem_grade){
    		case 1: discount = car_price * 0.01; break;
    		case 2: discount = car_price * 0.02; break;
    		case 3: discount = car_price * 0.03; break;
    		case 4: discount = car_price * 0.04; break;
    		default: discount = car_price * 0.05;
    	}
    	return (int)discount;
    }
    
    public static int getGradeUp(int mem_grade, int mem_total) {
    	double needUp;
        switch(mem_grade) {
            case 1: needUp = 2000 - mem_total; break;
            case 2: needUp = 4000 - mem_total; break;
            case 3: needUp = 6000 - mem_total; break;
            case 4: needUp = 8000 - mem_total; break;
            case 5: 
            	if(mem_total <= 10000) {
            		needUp = 10000 - mem_total; break;
            	}
            default :needUp = 0;
        }
        return (int)needUp;
    }
}
