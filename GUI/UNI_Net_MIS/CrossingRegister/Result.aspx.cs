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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;

public partial class GUI_UNI_NET_MIS_CrossingRegister_Result : System.Web.UI.Page
{
    public string dkt_call, CrossingChallanNo = "";
    string RPT_no = "";
    double pkgs = 0.0, weight = 0.0, ToPay = 0.0, varCrossing = 0.0, Bulky = 0.0, NetAmt = 0.0, TruckAmt = 0.0, Advamt = 0.0, SVCTAX = 0.00, CESS = 0.00, HEDUCESS = 0.00; 
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            BindGrid();
            DWN_XLS();

        }
        dkt_call = Session["DocketCalledAs"].ToString();
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string RO, LO, DateType, fromdt, todt, Vendor;

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        CrossingChallanNo = Request.QueryString["CrossingChallanNo"].ToString();
        Vendor = Request.QueryString["Vendor"].ToString();

        string dtFrom = fromdt;
        string dtTo = todt;

        lblseldet.Text = dtFrom + " - " + dtTo;
        lblloc.Text = LO;
        lblro.Text = RO;
        lblChallanNo.Text = CrossingChallanNo.ToString();

        string sqlLoc = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + LO + "'";
        SqlCommand cmdLoc = new SqlCommand(sqlLoc, conn);
        SqlDataReader drLoc;
        drLoc = cmdLoc.ExecuteReader();

        while (drLoc.Read())
        {
            lblloc.Text = Convert.ToString(drLoc["Loccode"]) + ":" + Convert.ToString(drLoc["Locname"]);
        }
        drLoc.Close();

        string sqlRegion = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + RO + "'";
        SqlCommand cmdRegion = new SqlCommand(sqlRegion, conn);
        SqlDataReader drRegion;
        drRegion = cmdRegion.ExecuteReader();

        while (drRegion.Read())
        {
            lblro.Text = Convert.ToString(drRegion["Loccode"]) + ":" + Convert.ToString(drRegion["Locname"]);
        }
        drRegion.Close();

        

        string sql_st = "exec webx_CrossingRegister '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + Vendor + "','" + CrossingChallanNo + "'";
        //Response.Write(sql_st);
        //Response.End();
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgChallan.DataSource = ds;
        dgChallan.DataBind();
        dgChallan.Visible = true;
        conn.Close();


    }
    

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    protected void btn_csv1_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    public void DWN_XLS()
    {
        pkgs = 0.0; weight = 0.0; ToPay = 0.0; varCrossing = 0.0; Bulky = 0.0; NetAmt = 0.0; TruckAmt = 0.0; Advamt = 0.0;
        dgChallan.BorderWidth = 1;
        dgChallan.Font.Size = 8;
        dgChallan.Font.Name = "verdana";
        dgChallan.AllowPaging = false;
        BindGrid();

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=CrossingRegister.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        Response.Write("CROSSING REGISTER");
        frm.Controls.Add(dgChallan);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {          

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblPackages = (Label)e.Row.FindControl("lblPackages");
            pkgs = pkgs + Convert.ToDouble(lblPackages.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotPackages = (Label)e.Row.FindControl("lblTotPackages");
            lblTotPackages.Text = pkgs.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblWeight = (Label)e.Row.FindControl("lblWeight");
            weight = weight + Convert.ToDouble(lblWeight.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotWeight = (Label)e.Row.FindControl("lblTotWeight");
            lblTotWeight.Text = weight.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblToPay = (Label)e.Row.FindControl("lblToPay");
            ToPay = ToPay + Convert.ToDouble(lblToPay.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotToPay = (Label)e.Row.FindControl("lblTotToPay");
            lblTotToPay.Text = ToPay.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblCrossing = (Label)e.Row.FindControl("lblCrossing");
            varCrossing = varCrossing + Convert.ToDouble(lblCrossing.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotCrossing = (Label)e.Row.FindControl("lblTotCrossing");
            lblTotCrossing.Text = varCrossing.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblBulkyChrg = (Label)e.Row.FindControl("lblBulkyChrg");
            Bulky = Bulky + Convert.ToDouble(lblBulkyChrg.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotBulkyChrg = (Label)e.Row.FindControl("lblTotBulkyChrg");
            lblTotBulkyChrg.Text = Bulky.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblNetPayable = (Label)e.Row.FindControl("lblNetPayable");
            NetAmt = NetAmt + Convert.ToDouble(lblNetPayable.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotNetPayable = (Label)e.Row.FindControl("lblTotNetPayable");
            lblTotNetPayable.Text = NetAmt.ToString();
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblTruckChrg = (Label)e.Row.FindControl("lblTruckChrg");
            TruckAmt = TruckAmt + Convert.ToDouble(lblTruckChrg.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotTruckChrg = (Label)e.Row.FindControl("lblTotTruckChrg");
            lblTotTruckChrg.Text = TruckAmt.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblAdvanceChrg = (Label)e.Row.FindControl("lblAdvanceChrg");
            Advamt = Advamt + Convert.ToDouble(lblAdvanceChrg.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotAdvanceChrg = (Label)e.Row.FindControl("lblTotAdvanceChrg");
            lblTotAdvanceChrg.Text = Convert.ToString(Advamt);
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblSVCTAX = (Label)e.Row.FindControl("lblSVCTAX");
            SVCTAX = SVCTAX + Convert.ToDouble(lblSVCTAX.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotServiceTax = (Label)e.Row.FindControl("lblTotServiceTax");
            lblTotServiceTax.Text = Convert.ToString(SVCTAX);
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblCess = (Label)e.Row.FindControl("lblCess");
            CESS = CESS + Convert.ToDouble(lblCess.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotCESS = (Label)e.Row.FindControl("lblTotCESS");
            lblTotCESS.Text = Convert.ToString(CESS);
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblHEduCess = (Label)e.Row.FindControl("lblHEduCess");
            HEDUCESS = HEDUCESS + Convert.ToDouble(lblHEduCess.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotHEduCess = (Label)e.Row.FindControl("lblTotHEduCess");
            lblTotHEduCess.Text = Convert.ToString(HEDUCESS);
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgChallan.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

