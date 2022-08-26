using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for VendorContractCharges
/// </summary>
public class VendorContractCharges
{
    public VendorContractCharges()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    private string vendorcode, matrixcode, chargebasis, docname, fixed_yn;
    private string rate_yn, contractcd, vehtype, routecd, calmethod, chargetype, veh_ftl;

    double slabrate, slabvalue, slabfrom, slabto, minval, maxval;
    
    public string VendorCode
    {
        set { vendorcode = value; }
        get { return vendorcode; }
    }
    public string ContractID
    {
        set { contractcd = value; }
        get { return contractcd; }
    }
    public string MatrixCode
    {
        set { matrixcode = value; }
        get { return matrixcode; }
    }
    public string VehicleType
    {
        set { vehtype = value; }
        get { return vehtype; }
    }
    public double SlabFrom
    {
        set { slabfrom = value; }
        get { return slabfrom; }
    }
    public double SlabTo
    {
        set { slabto = value; }
        get { return slabto; }
    }
    public string ChargeBasis
    {
        set { chargebasis = value; }
        get { return chargebasis; }
    }
    public string ChargeType
    {
        set { chargetype = value; }
        get { return chargetype; }
    }
    public string DocumentName
    {
        set { docname = value; }
        get { return docname; }
    }
    public string Fixed_YN
    {
        set { fixed_yn = value; }
        get { return fixed_yn; }
    }
    public string Rate_YN
    {
        set { rate_yn = value; }
        get { return rate_yn; }
    }
    public string RouteCode
    {
        set { routecd = value; }
        get { return routecd; }
    }
    public string CallMethod
    {
        set { calmethod = value; }
        get { return calmethod; }
    }
    public string Veh_FTL
    {
        set { veh_ftl = value; }
        get { return veh_ftl; }
    }
    public double SlabRate
    {
        set { slabrate = value; }
        get { return slabrate; }
    }
    public double SlabValue
    {
        set { slabvalue = value; }
        get { return slabvalue; }
    }
    public double MinValue
    {
        set { minval = value; }
        get { return minval; }
    }
    public double MaxValue
    {
        set { maxval = value; }
        get { return maxval; }
    }

}
