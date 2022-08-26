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
using System.Data.SqlClient;
using System.IO;

public partial class GUI_Octroi_ViewOctroiBill_BillDetail_TLL : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlDataReader dr;
    DataSet ds;
    string Bill_No;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        Bill_No = Request.QueryString["Bill_No"].ToString();
        lblBillNo.Text = Bill_No;

        //string strSql = "select sum(OctroiAmount + isnull(OtherCharges,0)) as Total, sum(isnull(OtherCharges,0)) as Other ";
        //strSql += " From VW_OctrioBillView where  OcBillNo = '" + Bill_No + "'";

        string strSql = "select sum(TotalAmount) as TotalAmount,sum(OtherAmount) as OtherAmount from VW_OctrioBillView_New where BILLNO='" + Bill_No + "'"; ;
        cmd = new SqlCommand(strSql, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblSubTot.Text = dr["TotalAmount"].ToString();
            lblTotal.Text = dr["TotalAmount"].ToString();
            lblOther.Text = dr["OtherAmount"].ToString();
        }
        dr.Close();

        strSql = "select top 1 PTMSNM from VW_OctrioBillView_New where BILLNO='" + Bill_No + "'"; ;
        cmd = new SqlCommand(strSql, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblPartyName.Text = dr["PTMSNM"].ToString();
        }
        dr.Close();

        //Int64 amt = Convert.ToInt64(lblTotal.Text);
        //RupeesToWords rupee = new RupeesToWords();
        //lblWordRs.Text = Convert.ToString(rupee.NumberToText(amt));

        if (lblTotal.Text != "")
        {
            double amt1 = Convert.ToDouble(lblTotal.Text);
            Int64 amt = Convert.ToInt64(amt1);
            RupeesToWords rupee = new RupeesToWords();
            lblWordRs.Text = Convert.ToString(rupee.NumberToText(amt));
        }


        XlsDownload();

    }

    private void BindGrid()
    {
        //string strSql = "select InvNo,DocketNo,DocketDate,Location1,Location2,Mode,Pcs,Weight,OctroiAmount,OtherCharges=isnull(OtherCharges,0),OctroiAmount + isnull(OtherCharges,0) as NetPay";
        //strSql += " from VW_OctrioBillView where  OcBillNo = '"+ Bill_No +"'";

        string strSql = "select * from VW_OctrioBillView_New where BILLNO='"+ Bill_No +"'";
        
        cmd = new SqlCommand(strSql, con);
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);
        grvBill.DataSource = ds;
        grvBill.DataBind();
    }

    private void XlsDownload()
    {
        grvBill.AllowPaging = false;
        grvBill.BorderWidth = 1;
        grvBill.CssClass = "blackfnt";
        grvBill.Font.Size = 10;
        grvBill.Font.Name = "Verdana";

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Bill.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(tblMain);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

}
