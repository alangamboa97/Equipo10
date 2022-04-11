
package accesodatos;

import conexion.Conexion;
import domain.OrderDetail;
import java.sql.*;
import java.util.*;


public class SalesOrderDetailImp implements ICrud4{
    
    PreparedStatement ps = null;
    ResultSet rs = null;
    ResultSetMetaData md = null;
    
    @Override
    public void insertar(Object objeto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void eliminar(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<OrderDetail> listar() {
        
        System.out.println("Listar desde SqlServer");
        List<OrderDetail> lista = null;
        OrderDetail orderDet = null;

        try {
            Conexion con = new Conexion();
            ps = con.Conectar().prepareStatement("{call sp_RecuperarSalesOrderDetail}");

            rs = ps.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                orderDet = new OrderDetail();
                
                orderDet.setSalesOrderID(rs.getInt(1));
                orderDet.setSalesOrderDetailID(rs.getInt(2));
                orderDet.setCarrierTrackingNumber(rs.getString(3));
                orderDet.setOrderQty(rs.getInt(4));
                orderDet.setProductID(rs.getInt(5));
                orderDet.setSpecialOfferID(rs.getInt(6));
                orderDet.setUnitPrice(rs.getDouble(7));
                orderDet.setUnitPriceDiscount(rs.getDouble(8));
                orderDet.setLineTotal(rs.getDouble(9));
                orderDet.setRowguid(rs.getString(10));
                orderDet.setModifiedDate(rs.getString(11));

                lista.add(orderDet);
            }

            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }

        return lista; 
    }

    @Override
    public void actualizar(Object objeto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
