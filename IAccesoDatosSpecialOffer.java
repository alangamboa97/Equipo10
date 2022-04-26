

package accesodatos;

import domain.*;
import java.util.List;


public interface IAccesoDatosSpecialOffer extends ICrud<SalesSpecialOffer>{
    List<SalesSpecialOffer>listar();
    
    void actualizar(SalesSpecialOffer objeto);
}
