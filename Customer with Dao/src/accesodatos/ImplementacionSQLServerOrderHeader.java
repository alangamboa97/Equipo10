/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package accesodatos;
import Connection.Conexion;
import domain.SalesOrderHeader;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * @author alang
 */
public class ImplementacionSQLServerOrderHeader implements IAccessoDatosOrderHeader {
    
    PreparedStatement ps = null;
    ResultSet rs = null;
    ResultSetMetaData md = null;
    
    
    @Override
    public List<SalesOrderHeader> listar() {
        System.out.println("Listar desde SqlServer");
        List<SalesOrderHeader> lista = null;
        SalesOrderHeader salOrd = null;

        try {
            Conexion con = new Conexion();
            ps = con.Conectar().prepareStatement("{call sp_RecuperarSalesOrderHeader}");

            rs = ps.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                salOrd = new SalesOrderHeader();
                salOrd.setSalesOrderID(rs.getInt(1));
                salOrd.setCustomerID(rs.getInt(2));
                salOrd.setSalesPersonID(rs.getInt(3));
                salOrd.setTerritoryID(rs.getInt(4));
                salOrd.setBillToAddressID(rs.getInt(5));
                salOrd.setShipToAddress(rs.getInt(6));
                salOrd.setShipMethodID(rs.getInt(7));
                salOrd.setCreditCardID(rs.getInt(8));
                salOrd.setRowguid(rs.getString(9));
      
                lista.add(salOrd);
            }

            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }

        return lista;
    }

    @Override
    public void insertar(SalesOrderHeader objeto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void actualizar(SalesOrderHeader objeto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void eliminar(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
