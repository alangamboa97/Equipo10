package test;

import accesodatos.*;
import domain.SalesCustomer;
import java.util.*;

public class TestInterfaces {
    public static void main(String[] args) {
        
        ICrud datos; //Pa todos, pa todo.
        
        
        //CUSTOMER ------------------------------------------------
        
        //LISTAR
        datos = new ImplementacionSqlServerCustomer();

        imprimir(datos);
        
        
        //UPDATE
//         datos = new ImplementacionSqlServerCustomer();
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
        

        //ORDERDETAIL ------------------------------------------------
        
        //LISTAR
//        datos = new OrderDetailImp();
//        
//        imprimir(datos);
        
    }
    
    //Para polimorfisar pero hasta despues.
    public static void insertar(ICrud datos){
        datos.listar();
    }
    
    public static void imprimir(ICrud datos){
        List lista=null; //pa todos.
        
        if(datos instanceof  OrderDetailImp){
            lista=((OrderDetailImp)datos).listar();
            
	} 
	else if(datos instanceof  ImplementacionSqlServerCustomer){
            lista=((ImplementacionSqlServerCustomer)datos).listar();
	} 
        
        lista.forEach(elemento->{
            System.out.println(" "+elemento);
        });
    }
    
    public static void actualizar(ICrud datos){
        datos.listar();
    }
    
    public static void eliminar(ICrud datos){
        datos.listar();
    }
}
