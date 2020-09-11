package www.study.com.framework;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class Criteria {

    private static final int PageNumberAmount = 10;

    protected int pageNum, amount;

    private int startPageNum, endPageNum, realEndPageNum;

    private boolean prev, next;

    public Criteria() {
        this(1,10);
    }

    public Criteria(int pageNum, int amount) {//단순 페이지 정보 생성자
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public Criteria(Criteria criteria,int total) {//
       this(criteria.getPageNum(),criteria.getAmount());
        this.calcPagination(total);
    }



    protected void calcPagination(int total){

        endPageNum = pageNum + (int)(PageNumberAmount * 0.1 / 2 - 1 ); //

//        endPageNum= (int)(Math.ceil(pageNum * 1.0 / PageNumberAmount));

        startPageNum = endPageNum - (PageNumberAmount -1);

        realEndPageNum = (int)(Math.ceil( (total * 1.0) / amount));

        if( startPageNum < 1 ){
            startPageNum = 1;
        }
        if(realEndPageNum < endPageNum){
            endPageNum = realEndPageNum;
        }

        prev = startPageNum > 1;
        next = endPageNum < realEndPageNum;
    }

}
