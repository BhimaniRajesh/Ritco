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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.IO;

public partial class GUI_View_Track_Operation_Result_LS_MF_PDRS_PFM : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }
    public void BindGrid()
    {
        string RO = "", LO = "", RO_TO = "", LO_TO = "", DateType = "", fromdt = "", todt = "";
        string st_Docnolist = "", St_Manualnolist = "", st_Vehnolist = "", st_Freetext = "", st_doctyp = "";// DWN_XLS = "";
        int pagecnt = 0;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        RO = Request.QueryString.Get("RO");
        LO = Request.QueryString.Get("LO");
        RO_TO = Request.QueryString.Get("RO_TO");
        LO_TO = Request.QueryString.Get("LO_TO");
        DateType = Request.QueryString.Get("DateType");
        fromdt = Request.QueryString.Get("fromdt");
        todt = Request.QueryString.Get("todt");
        st_Docnolist = Request.QueryString.Get("st_Docnolist");
        St_Manualnolist = Request.QueryString.Get("St_Manualnolist");
        st_Vehnolist = Request.QueryString.Get("st_Vehnolist");
        st_Freetext = Request.QueryString.Get("st_Freetext");
        st_doctyp = Request.QueryString.Get("st_doctyp");
        string DWN_XLS = Request.QueryString.Get("DWN_XLS");
        pagecnt = Convert.ToInt32(Request.QueryString.Get("pagecnt"));
        string str_doctyp = Request.QueryString.Get("str_doctyp");


        lblseldet.Text = fromdt + " - " + todt;
        lblro.Text = RO + " - " + RO_TO;
        lblloc.Text = LO + " - " + LO_TO;
        lblflow.Text = str_doctyp;


        if (RO == "" || RO == "All")
        {
            RO = "%%";
        }
        if (LO == "" || LO == "All")
        {
            LO = "%%";
        }
        if (RO_TO == "" || RO_TO == "All")
        {
            RO_TO = "%%";
        }
        if (LO_TO == "" || LO_TO == "All")
        {
            LO_TO = "%%";
        }

        if(RO==LO)
            RO = "%%";

        if (RO_TO == LO_TO)
            RO_TO = "%%";

        string sql_st = "exec webxNet_Tracking '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + RO_TO + "','" + LO_TO + "','" + st_Docnolist + "','" + St_Manualnolist + "','" + st_Vehnolist + "','" + st_Freetext + "','" + st_doctyp + "','0','0'";
       // Response.Write("<br>sql_st : " + sql_st);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();
        da.Fill(ds);
        if (st_doctyp == "MF")
        {          
            dgMenifest.DataSource = ds;
            dgMenifest.DataBind();
            dgMenifest.Visible = true;            
        }
        else if (st_doctyp == "LS")
        {
            dgLS.DataSource = ds;
            dgLS.DataBind();
            dgLS.Visible = true;
        }
        else if (st_doctyp == "PRS" || st_doctyp == "DRS")
        {
            dgPDC.DataSource = ds;
            dgPDC.DataBind();
            dgPDC.Visible = true;
        }
        else if (st_doctyp == "PFM")
        {
            dgPFM.DataSource = ds;
            dgPFM.DataBind();
            dgPFM.Visible = true;
        }



    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
       string st_doctyp = Request.QueryString.Get("st_doctyp");
       if (st_doctyp == "MF")
       {
           dgMenifest.PageIndex = e.NewPageIndex;
       }
       else if (st_doctyp == "LS")
       {
           dgLS.PageIndex = e.NewPageIndex;
       }
       else if (st_doctyp == "PRS" || st_doctyp == "DRS")
       {
           dgPDC.PageIndex = e.NewPageIndex;
       }
       else if (st_doctyp == "PFM")
       {
           dgPFM.PageIndex = e.NewPageIndex;
       }

       BindGrid();

    }
}
