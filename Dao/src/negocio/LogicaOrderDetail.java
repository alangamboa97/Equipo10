
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
        String opcionS;
        List<OrderDetail> ordenes = new ArrayList();
        
        orderId = (int)(Math.random()*(5000-1)+1);
        System.out.println("Numero de orden = " + orderId);
        
        do{
            opcion = 1;
                    
            System.out.print("\nIngresa el producto id: ");
            id = Integer.parseInt(lect.nextLine());
            System.out.print("Ingresa la cantidad de productos que desea: ");
            cantidad = Integer.parseInt(lect.nextLine());

            OrderDetail order = new OrderDetail(orderId, cantidad, id);
            int respues = this.datos.validar(order);

            if( respues == 0){
                System.out.println("No existe el producto que solicita.\n");
                
            }
            else if( respues == -1){
                System.out.println("No hay la cantidad de stock del producto que solicita.\n");
                 
            }
            else{
                System.out.println("¡Producto Agregado a su compra correctamente!\n");
                ordenes.add(order);
            }
            
            do{
                System.out.println("¿Desea comprar otro producto?\n1. Si.\n2. No.");
                opcionS = lect.nextLine();
                if( opcionS.isEmpty() || (!opcionS.equals("1") && !opcionS.equals("2")) ){
                    System.out.println("\nOpcion invalida. Intente otra vez.");
                } 
            }while( opcionS.isEmpty() || (!opcionS.equals("1") && !opcionS.equals("2")) );
            
            opcion = Integer.parseInt(opcionS);
        }while(opcion == 1);
        
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
