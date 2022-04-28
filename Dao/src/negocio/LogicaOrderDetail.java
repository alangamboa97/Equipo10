
package negocio;

import accesodatos.SalesOrderDetailImp;
import domain.OrderDetail;
import java.util.*;


public class LogicaOrderDetail {
   
    private SalesOrderDetailImp datos;
    
    public LogicaOrderDetail(){
        this.datos = new SalesOrderDetailImp();
    }
    
    public int procesamientoInsercion(){
        
        Scanner lect = new Scanner(System.in);
        int orderId, id, cantidad, opcion;
        List<OrderDetail> ordenes = new ArrayList();
        
        orderId = (int)(Math.random()*(5000-1)+1);
        System.out.println("Numero de orden = " + orderId);
        
//        do{
            opcion = 1;
                    
            System.out.println("\nIngresa el producto id: ");
            id = Integer.parseInt(lect.nextLine());
            System.out.println("Ingresa la cantidad de productos que desea: ");
            cantidad = Integer.parseInt(lect.nextLine());

            OrderDetail order = new OrderDetail(orderId, cantidad, id);
            int respues = this.datos.validar(order);

            if( respues == 0){
                System.out.println("No existe el producto que solicita. ");
                
            }
            else if( respues == -1){
                System.out.println("No hay la cantidad de stock del producto que solicita.");
                 
            }
            //else{

            ordenes.add(order);
            System.out.println("¿Desea comprar otro producto?\n1. Si.\n2. No.");
            opcion = Integer.parseInt(lect.nextLine());
            
//        }while(opcion == 1);
//        
//        //Aqui se mandaria a llamar un buen de veces su insercion.
//        //Retornar orderId
//        
//        ordenes.forEach( elemento ->{
//            this.datos.insertar(elemento);
//        });
//        
        return orderId;
    }
}
