package accesodatos;

import Connection.Conexion;
import domain.SalesSpecialOffer;
import java.sql.*;
import java.util.*;

public class SpecialOfferImp implements IAccesoDatosSpecialOffer{
    
    PreparedStatement ps = null;
    ResultSet rs = null;
    ResultSetMetaData md = null;
    
    @Override
    public List<SalesSpecialOffer> listar() {
    System.out.println("Listar desde SqlServer");
        List<SalesSpecialOffer> lista = null;
        SalesSpecialOffer salSO = null;

        try {
            Conexion con = new Conexion();
            ps = con.Conectar().prepareStatement("{call sp_RecuperarCustomer}");

            rs = ps.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                salSO = new SalesSpecialOffer();
                salSO.setSpecialOfferID(rs.getInt(1));
                salSO.setDescription(rs.getString(2));
                salSO.setDiscountPct(rs.getInt(3));
                salSO.setType(rs.getString(4));
                salSO.setCategory(rs.getString(5));
                salSO.setStartDate(rs.getString(6));
                salSO.setEndDate(rs.getString(7));
                salSO.setMinQty(rs.getInt(8));
                salSO.setMaxQty(rs.getInt(9));
                salSO.setModifiedDate(rs.getString(10));
                
                lista.add(salSO);
            }

            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }

        return lista;
    }

    @Override
    public void actualizar(SalesSpecialOffer objeto) {
           System.out.println("\nActualizar desde SqlServer");

        try {
            Conexion con = new Conexion();
            ps = con.Conectar().prepareStatement("{call sp_ActualizarCustomer(?,?,?,?,?,?,?,?,?,?)}");

            ps.setInt(1, objeto.getSpecialOfferID());
            ps.setString(2, objeto.getDescription());
            ps.setInt(3, objeto.getDiscountPct());
            ps.setString(4, objeto.getType());
            ps.setString(5, objeto.getCategory());
            ps.setString(6, objeto.getStartDate());
            ps.setString(7, objeto.getEndDate());
            ps.setInt(8, objeto.getMinQty());
            ps.setInt(9, objeto.getMaxQty());
            ps.setString(10, objeto.getModifiedDate());
          
            ps.execute();
            System.out.println("Actualizacion Exitosa");
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
}
