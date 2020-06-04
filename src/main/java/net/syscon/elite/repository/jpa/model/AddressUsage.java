package net.syscon.elite.repository.jpa.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.JoinColumnOrFormula;
import org.hibernate.annotations.JoinColumnsOrFormulas;
import org.hibernate.annotations.JoinFormula;
import org.hibernate.annotations.NotFound;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;

import static net.syscon.elite.repository.jpa.model.AddressType.*;
import static org.hibernate.annotations.NotFoundAction.IGNORE;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ADDRESS_USAGES")
@IdClass(AddressUsage.PK.class)
public class AddressUsage extends AuditableEntity {

    @NoArgsConstructor
    @AllArgsConstructor
    public static class PK implements Serializable {
        @Column(name = "ADDRESS_ID", updatable = false, insertable = false)
        private Long id;

        @Column(name = "ADDRESS_USAGE", updatable = false, insertable = false)
        private String addressUsage;
    }

    @Id
    private Long id;

    @Id
    private String addressUsage;

    private String activeFlag;

    @ManyToOne
    @NotFound(action = IGNORE)

    @JoinColumnsOrFormulas(value = {
            @JoinColumnOrFormula(formula = @JoinFormula(value = "'" + ADDRESS_TYPE + "'", referencedColumnName = "domain")),
            @JoinColumnOrFormula(column = @JoinColumn(name = "ADDRESS_USAGE", referencedColumnName = "code"))
    })
    private AddressType addressUsageType;
}
