using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;    
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Finance_Vendor_BA_payment_Main : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    string Trn_Typ = "", Trn_Doc = "", Trn_CalledAs = "", Trn_Typ_Desc = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        Trn_Typ = Request.QueryString["Trn_Typ"];
        //Trn_Doc = Request.QueryString["Trn_Doc"];
        if (!IsPostBack && !IsCallback)
        {
            Trn_CalledAs = Convert.ToString(Request.QueryString["Trn_CalledAs"]);
        }
        if (Trn_Typ == "A")
        {
            Trn_Typ_Desc = "Advance";
        }
        else if (Trn_Typ == "B")
        {
            Trn_Typ_Desc = "Balance";
        }
        //Chk_DocType.Items[0].Text = Session["THCCalledAs"].ToString();
        Hnd_Trn_Typ.Value = Trn_Typ.ToString();
        Trn_Title.Text = "Vendor " + Trn_Typ_Desc.ToString() + " Payment";
        Trn_Title1.Text = "Vendor  Payment";
        //ddlRouteMode.Items.Clear();
        //ddlRouteMode.Items.Add(new ListItem("ALL", ""));
        //ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("1"), "A"));
        //ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("2"), "S"));
        //ddlRouteMode.Items.Add(new ListItem(fn.Gettrnmod("3"), "R"));
        //Tr_Route_Typ.Visible = true;
        fn.Fill_Vendor_Dataset();
        btnsubmit1.Attributes.Add("onclick", " javascript:return Check_Submit_Data()");
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;

        string dtFrom = VendorPayment_Utility.Get_From_To_Date("F", txtDateFrom.Text, txtDateTo.Text, rb2);
        string dtTo = VendorPayment_Utility.Get_From_To_Date("T", txtDateFrom.Text, txtDateTo.Text, rb2);

        string VendorName = "", Vendorcode = "", Vehicle_Type_Name, Vechicl_Type_Code = "", DOCNO_Str = "", ManualNo_Str = "", Trn_Doc_Typ="";
        string[] Vendor_Cls_Arr = Txt_Vendor.Text.ToString().Split('~');
        if (Txt_Vendor.Text.ToString() != "")
        {
            VendorName = Vendor_Cls_Arr[0];
            Vendorcode = Vendor_Cls_Arr[1];
        }
        //Trn_Doc_Typ = VendorPayment_Utility.Get_DocTypeList(Chk_DocType);
        DOCNO_Str = txtDocNo.Text.ToString();
        ManualNo_Str = txtManualNo.Text.ToString();
        string Qstring = "";
        Qstring = "Fromdate=" + dtFrom;
        Qstring += "&Todate=" + dtTo;
        Qstring += "&VendorName=" + VendorName;
        Qstring += "&Vendorcode=" + Vendorcode;
        Qstring += "&DOCNO_Str=" + DOCNO_Str;
        Qstring += "&ManualNo_Str=" + ManualNo_Str;
        Qstring += "&Trn_Typ=" + Trn_Typ;
        //final += "&Trn_Document=" + Trn_Doc;
        //final += "&Trn_CalledAs=" + Trn_CalledAs;
        //Qstring += "&Trn_Doc_Typ=" + Trn_Doc_Typ.ToString();

        

        if (Trn_Typ == "A")
        {
            Response.Redirect("Advance_Payment_Step1.aspx?" + Qstring);
        }
        else if (Trn_Typ == "B")
        {
            string[] ContractType_Arr = VendorPayment_Utility.GetCotractType(Vendorcode).ToString().Split('~');
            string ContractType = ContractType_Arr[0].ToString(), ContractID = ContractType_Arr[1].ToString(), ContractTypeDesc = ContractType_Arr[2].ToString();
            Qstring += "&ContractType=" + ContractType;
            Qstring += "&ContractTypeDesc=" + ContractTypeDesc;
            Qstring += "&ContractID=" + ContractID;
            
            //if (ContractType == "01")
             //   Response.Redirect("Advance_Balance_Step2.aspx?" + Qstring);
            //else
                Response.Redirect("Advance_Balance_Step1.aspx?" + Qstring);
        }

    }
}
