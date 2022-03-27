package test;

import accesodatos.*;
import domain.SalesCustomer;
import domain.SalesOrderHeader;
import java.util.*;

public class TestInterfaces {
    public static void main(String[] args) {

        //INSERTAR
        ICrud datos = new ImplementacionSqlServerCustomer();
        ICrud4 datos2 = new ImplementacionSQLServerOrderHeader();
        
        
        List<SalesOrderHeader> lista=datos2.listar();
        
        lista.forEach(elemento->{
            System.out.println(" "+elemento);
        });
        
        
        //UPDATE
//        ICrud datos = new ImplementacionSqlServerCustomer();
//        
//        SalesCustomer salCust = new SalesCustomer();
//        
//        System.out.print("Actualizar. \nIngresa el id: ");
//        Scanner lect = new Scanner(System.in);
//        int id=Integer.parseInt(lect.nextLine());
//        System.out.print("Ingresa el PersonID: ");
//        int personId=Integer.parseInt(lect.nextLine());
//        
//        salCust.setCustomerID(id);
//        salCust.setPersonID(personId);
//        
//        datos.actualizar(salCust);

//INSERT
        SalesOrderHeader salOrd = new SalesOrderHeader();
        salOrd.setSalesOrderID(1);
        salOrd.setCustomerID(1);
        salOrd.setSalesPersonID(1);
        salOrd.setTerritoryID(1);
        salOrd.setBillToAddressID(1);
        salOrd.setShipToAddress(1);
        salOrd.setShipMethodID(1);
        salOrd.setCustomerID(1);
        datos2.insertar(salOrd);
    }
    
    public static void imprimir(ICrud datos){
        datos.listar();
    }
    
   
}
