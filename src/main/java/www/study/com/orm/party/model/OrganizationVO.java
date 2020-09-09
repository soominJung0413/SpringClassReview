package www.study.com.orm.party.model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class OrganizationVO extends PartyVO{

    private Long salesTot;

    @Override
    public String toString() {
        return "OrganizationVO{" +
                "salesTot=" + salesTot +" id"+getId()+" name="+getName()+" birthDate="+getBirthDate()
                +" partyType="+getPartyType()+
                '}';
    }
}
