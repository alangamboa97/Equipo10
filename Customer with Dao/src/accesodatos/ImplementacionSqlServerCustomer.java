package accesodatos;

import Connection.Conexion;
import domain.SalesCustomer;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class ImplementacionSqlServerCustomer implements IAccesoDatosCustomer {

    PreparedStatement ps = null;
    ResultSet rs = null;
    ResultSetMetaData md = null;

    @Override
    public List<SalesCustomer> listar() {
        System.out.println("Listar desde SqlServer");
        List<SalesCustomer> lista = null;
        SalesCustomer salCust = null;

        try {
            Conexion con = new Conexion();
            ps = con.Conectar().prepareStatement("{call sp_RecuperarCustomer}");

            rs = ps.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                salCust = new SalesCustomer();
                salCust.setCustomerID(rs.getInt(1));
                salCust.setPersonID(rs.getInt(2));
                salCust.setStoreID(rs.getInt(3));
                salCust.setTerritoryID(rs.getInt(4));
                salCust.setAccountNumber(rs.getString(5));
                salCust.setRowguid(rs.getString(6));
                salCust.setModifiedDate(rs.getString(7));

                lista.add(salCust);
            }

            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }

        return lista;
    }

    @Override
    public void actualizar(SalesCustomer salCust) {
        System.out.println("\nActualizar desde SqlServer");

        try {
            Conexion con = new Conexion();
            ps = con.Conectar().prepareStatement("{call sp_ActualizarCustomer(?,?)}");

            ps.setInt(1, salCust.getCustomerID());
            ps.setInt(2, salCust.getPersonID());

            ps.execute();
            System.out.println("Actualizacion Exitosa");
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
