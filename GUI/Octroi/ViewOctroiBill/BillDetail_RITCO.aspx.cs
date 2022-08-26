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

public partial class GUI_Octroi_ViewOctroiBill_BillDetail_RITCO : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlDataReader dr;
    DataSet ds;
    string Bill_No, newTotal;
    public double totAmount1 = 0.0;

    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        //if (Session["Client"].ToString() == "RITCO")
        //{
        //    imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        //}
        Bill_No = Request.QueryString["Bill_No"].ToString();
        lblBillNo.Text = Bill_No;
        SqlCommand cmd = new SqlCommand("select Convert(varchar,h.bgndt,106) as bgndt,ptmsnm,c.custnm as CustomerName,c.CustAddress as CustAddress,bbrcd +':'+ BBRNM as bbrcd,* from Webx_billmst h,webx_custhdr c where c.custcd=h.ptmscd and billno='" + Bill_No + "'",con);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblBillNo.Text = Bill_No;
            lblBillDt.Text = Convert.ToString(dr["bgndt"]);
            //lblBranch.Text = Convert.ToString(dr["bbrcd"]);
            lblCustCode.Text = Convert.ToString(dr["ptmscd"]);
            lblCustName.Text = Convert.ToString(dr["CustomerName"]);
            lblAddress.Text = Convert.ToString(dr["PTMSADDR"]);

        }
        dr.Close();
        //string strSql = "select sum(OctroiAmount + isnull(OtherCharges,0)) as Total, sum(isnull(OtherCharges,0)) as Other ";
        //strSql += " From VW_OctrioBillView where  OcBillNo = '" + Bill_No + "'";
        //VW_OctrioBillRITCO


        //string strSql = "select sum(TotalAmount) as TotalAmount,sum(OtherAmount) as OtherAmount from VW_OctrioBillView_New where BILLNO='" + Bill_No + "'"; ;
        //cmd = new SqlCommand(strSql, con);
        //dr = cmd.ExecuteReader();
        //while (dr.Read())
        //{
        //    lblSubTot.Text = dr["TotalAmount"].ToString();
        //    lblTotal.Text = dr["TotalAmount"].ToString();
        //    lblOther.Text = dr["OtherAmount"].ToString();
        //}
        //dr.Close();

        string strSql = "select sum(total) as total from VW_OctrioBillRITCO where BILLNO='" + Bill_No + "'"; ;
        cmd = new SqlCommand(strSql, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            newTotal = dr["total"].ToString();
        }
        dr.Close();

        //Int64 amt = Convert.ToInt64(lblTotal.Text);
        //RupeesToWords rupee = new RupeesToWords();
        //lblWordRs.Text = Convert.ToString(rupee.NumberToText(amt));

        if (newTotal != "")
        {
            double amt1 = Convert.ToDouble(newTotal);
            Int64 amt = Convert.ToInt64(amt1);
            RupeesToWords rupee = new RupeesToWords();
            lblWordRs.Text = Convert.ToString(rupee.NumberToText(amt));
        }

        XlsDownload();
    }
    private void BindGrid()
    {
        string strSql = "select * from VW_OctrioBillRITCO where BILLNO='" + Bill_No + "'";

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
        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=Bill.xls");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.ms-xls";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);

        //frm.Controls.Add(tblMain);

        //frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();
        //imgLogo.ImageUrl = "";

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=BillDeatail_new.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblMain);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();


    }
    protected void GrdXLS1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbltot11 = (Label)e.Row.FindControl("lblFooTotal11");
            totAmount1 = totAmount1 + Convert.ToDouble(lbltot11.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotal11 = (Label)e.Row.FindControl("lblFooTotal");
            lblTotal11.Text = totAmount1.ToString();
        }
    }

}
