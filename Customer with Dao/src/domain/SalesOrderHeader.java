/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domain;

import java.util.Date;

/**
 *
 * @author alang
 */
public class SalesOrderHeader {
    
    private int salesOrderID;
    private int customerID;
    private int salesPersonID;
    private int territoryID;
    private int billToAddressID;
    private int shipToAddressID;
    private int shipMethodID;
    private int creditCardID;
    private String rowguid;


    public int getSalesOrderID() {
        return salesOrderID;
    }
    @Override
    public String toString() {
        return "SalesOrderID{" + salesOrderID+ "customerID=" + customerID + ", SalesPersonID=" + salesPersonID + ", territoryID=" + territoryID + ", billtoAddressID=" + billToAddressID + ", shiptoAddressID=" + shipToAddressID+ "ShipMethoID=" + shipMethodID + "CreditCardID=" + creditCardID +", rowguid=" + rowguid +  '}';
    }


    public void setSalesOrderID(int salesOrderID) {
        this.salesOrderID = salesOrderID;
    }
    

    public int getCustomerID() {
        return customerID;
    }
    
    

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getSalesPersonID() {
        return salesPersonID;
    }

    public void setSalesPersonID(int salesPersonID) {
        this.salesPersonID = salesPersonID;
    }

    public int getTerritoryID() {
        return territoryID;
    }

    public void setTerritoryID(int territoryID) {
        this.territoryID = territoryID;
    }

    public int getBillToAddressID() {
        return billToAddressID;
    }

    public void setBillToAddressID(int billToAddressID) {
        this.billToAddressID = billToAddressID;
    }

    public int getShipToAddressID() {
        return shipToAddressID;
    }

    public void setShipToAddress(int shipToAddressID) {
        this.shipToAddressID = shipToAddressID;
    }

    public int getShipMethodID() {
        return shipMethodID;
    }

    public void setShipMethodID(int shipMethodID) {
        this.shipMethodID = shipMethodID;
    }

    public int getCreditCardID() {
        return creditCardID;
    }

    public void setCreditCardID(int creditCardID) {
        this.creditCardID = creditCardID;
    }

    public String getRowguid() {
        return rowguid;
    }

    public void setRowguid(String rowguid) {
        this.rowguid = rowguid;
    }


   
}
