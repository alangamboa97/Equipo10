/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domain;

/**
 *
 * @author ville
 */
public class SalesSpecialOffer {

private int SpecialOfferID;
private String Description;
private int DiscountPct;
private String Type;
private String Category;
private String StarDate;
private String EndDate;
private int MinQty;
private int MaxQty;
private String ModifiedDate;
@Override
    public String toString() {
        return "SalesSpecialOffer{" + "SpecialOfferID=" + SpecialOfferID + ", Description=" + Description + ", DiscountPct=" + DiscountPct + ", Type=" + Type + ", Category=" + Category + ", StarDate=" + StarDate + ", EndDate=" + EndDate +", MinQty=" + MinQty +", MaxQty=" + MaxQty +", ModifiedDate=" + ModifiedDate + '}';
    }
    public int getSpecialOfferID() {
        return SpecialOfferID;
    }

    public void setSpecialOfferID(int SpecialOfferID) {
        this.SpecialOfferID = SpecialOfferID;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public int getDiscountPct() {
        return DiscountPct;
    }

    public void setDiscountPct(int DiscountPct) {
        this.DiscountPct = DiscountPct;
    }

    public String getType() {
        return Type;
    }

    public void setType(String Type) {
        this.Type = Type;
    }

    public String getCategory() {
        return Category;
    }

    public void setCategory(String Category) {
        this.Category = Category;
    }

    public String getStarDate() {
        return StarDate;
    }

    public void setStarDate(String StarDate) {
        this.StarDate = StarDate;
    }

    public String getEndDate() {
        return EndDate;
    }

    public void setEndDate(String EndDate) {
        this.EndDate = EndDate;
    }

    public int getMinQty() {
        return MinQty;
    }

    public void setMinQty(int MinQty) {
        this.MinQty = MinQty;
    }

    public int getMaxQty() {
        return MaxQty;
    }

    public void setMaxQty(int MaxQty) {
        this.MaxQty = MaxQty;
    }

    public String getModifiedDate() {
        return ModifiedDate;
    }

    public void setModifiedDate(String ModifiedDate) {
        this.ModifiedDate = ModifiedDate;
    }


    
}
