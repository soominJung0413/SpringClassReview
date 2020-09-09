package www.study.com.orm.party.model;

import lombok.Data;

@Data
public class PersonVO extends PartyVO {
    /*set enum*/
    private enum gender{MALE, FEMALE}

    private gender gender;


    /*private int id;
    private String name;
    private Date birthDate;
    private String partyType;*/
    @Override
    public String toString() {
        return "PersonVO{" +
                "gender=" + gender +" id"+getId()+" name="+getName()+" birthDate="+getBirthDate()
                +" partyType="+getPartyType()+'}';
    }
}
