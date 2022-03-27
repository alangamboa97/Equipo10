/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package accesodatos;


import domain.*; 
import java.util.List;

/**
 *
 * @author alang
 */
public interface IAccessoDatosOrderHeader extends ICrud4<SalesOrderHeader> {
    
    List<SalesOrderHeader> listar();
    
    void insertar (SalesOrderHeader objeto);
    
    void actualizar(SalesOrderHeader objeto);
    
    void eliminar (int id);
    
    
}
