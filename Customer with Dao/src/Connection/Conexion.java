
package Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    Connection con = null;
    String url="jdbc:sqlserver://DESKTOP-V2U3HSL\\SERVER1;database=AdventureWorks2019;integratedSecurity=true";
    
    public Conexion() 
    {
        try{
            con = DriverManager.getConnection(url);
        }catch (SQLException e){
            System.out.println("Error de Conexion" + e.getMessage());
        } 
    }

    public Connection Conectar() 
    {
        return con;
    }
    
    public void cerrar() throws SQLException {
        if(con!=null){
            if(!con.isClosed())
                con.close();
        }
    }
}
