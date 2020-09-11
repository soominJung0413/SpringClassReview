package www.study.com.framework;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.util.UriComponentsBuilder;

@Data
@NoArgsConstructor
public class SearchCriteria extends Criteria{

    private String searchType;
    private String searchKeyword;

    public SearchCriteria(SearchCriteria searchCriteria, int total) {
        super(searchCriteria,total);
        this.searchType = searchCriteria.searchType;
        this.searchKeyword = searchCriteria.searchKeyword;
    }


    public String getQueryString(){
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("");
        builder.queryParam("pageNum",pageNum)
                .queryParam("amount",amount)
                .queryParam("searchType",searchType)
                .queryParam("searchKeyword",searchKeyword);
        return builder.toUriString();
    }

    public String[] getSearchTypeArr(){
        return searchType == null ? new String[] {} : searchType.split("");
    }

    public String makeHTMLTags(){
        StringBuilder builder = new StringBuilder();
        builder.append("<input type='hidden' name='pageNum' value='"+pageNum+"' />");
        builder.append("<input type='hidden' name='amount' value='"+amount+"' />");
        builder.append("<input type='hidden' name='searchType' value='"+searchType+"' />");
        builder.append("<input type='hidden' name='searchKeyword' value='"+searchKeyword+"' />");
        return builder.toString();
    }


}
