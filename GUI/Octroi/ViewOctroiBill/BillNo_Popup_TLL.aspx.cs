using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;

public partial class GUI_Octroi_ViewOctroiBill_BillNo_Popup_TLL : System.Web.UI.Page
{
    string strQuery;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblBillNo.Text = Request.QueryString["Bill_No"];
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        strQuery = "select b.BILLNO,b.Manualbillno,Convert(Varchar,b.BGNDT,106) as BGNDT,b.PTMSCD,b.PTMSNM,c.CustAddress from webx_BillMST b,webx_CUSTHDR c where c.CustCd=b.PTMSCD and BillNo='" + lblBillNo.Text + "'";

        SqlCommand cmd = new SqlCommand(strQuery, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblCompName.Text = Convert.ToString(dr["PTMSNM"]);
            lblCompAddress.Text = Convert.ToString(dr["CustAddress"]);
            lblManualBillNo.Text = Convert.ToString(dr["Manualbillno"]);
            lblBillDate.Text = Convert.ToString(dr["BGNDT"]);
            lblCustCode.Text = Convert.ToString(dr["PTMSCD"]);
        }
        dr.Close();

        strQuery = "select sum(OctrioAmount) as OctrioAmount,sum(OctrioCharge) as OctrioCharge,sum(ServiceTax) as ServiceTax,sum(TotalAmount) as TotalAmount,sum(OtherAmount) as OtherAmount from VW_OctrioBillView_New where BILLNO='" + lblBillNo.Text + "'";
        SqlCommand cmd1 = new SqlCommand(strQuery, con);
        SqlDataReader dr1 = cmd1.ExecuteReader();
        while (dr1.Read())
        {
            lblOAmt.Text = Convert.ToString(dr1["OctrioAmount"]);
            lblOCharge.Text = Convert.ToString(dr1["OctrioCharge"]);
            lblSerViceTax.Text = Convert.ToString(dr1["ServiceTax"]);
            lblOthCharges.Text = Convert.ToString(dr1["OtherAmount"]);
            lblNetPay.Text = Convert.ToString(dr1["TotalAmount"]); 

        }
        dr1.Close();
        if (lblNetPay.Text != "")
        {
            double amt1 = Convert.ToDouble(lblNetPay.Text);
            Int64 amt = Convert.ToInt64(amt1);
            RupeesToWords rupee = new RupeesToWords();
            lblWordRs.Text = Convert.ToString(rupee.NumberToText(amt));
        }
        


    }
}
