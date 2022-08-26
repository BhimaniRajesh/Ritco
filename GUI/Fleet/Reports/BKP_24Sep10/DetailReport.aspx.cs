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
using System.Text;


public partial class Reports_DetailReport : System.Web.UI.Page
{

    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    string Value = ""; //DateTime dtFrom; DateTime dtTo;

    string mValue = ""; string RouteCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {
            Value = Request.QueryString["id"].Trim();
            RouteCode = Request.QueryString["id1"].Trim();
            getReportName();
            lblHeading.Text = "Detail Report of  " + mValue + " ";
            BindGrid();

            //Session["dtFrom"] = null;
            //Session["dtTo"] = null;
            //Session["status"] = null;
            
            
            //Do Work

            //if (GridView1.Rows.Count != 0)
            //{
            //    LinkButton1.Visible = true;

            //}

            //else
            //{
            //    LinkButton1.Visible = false;
            //}

        }

       
        //Do Work
        //if (GridView1.Rows.Count != 0)
        //{
        //    LinkButton1.Visible = true;

        //}

        //else
        //{
        //    LinkButton1.Visible = false;
        //}

      

       
    }

    public void getReportName()
    {
        if (Value == "Request")
        {
            mValue = " Total Requests";
        }
        if (Value == "Issue")
        {
            mValue = "Total Requests Issued";

        }
        if (Value == "JCNo")
        {
            mValue = "Journey/Trips Completed ";
        }
        if (Value == "JTNo")
        {
            mValue = "Journey/Trips in Transit ";
        }

        lblHeading.Text = "Detail Repoprt of  " + mValue + "";


    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }


    public void BindGrid()
    {
        //usp_RequestDetailReport

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "usp_RequestDetailReport";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        //  string prodtype = cboProdType.SelectedItem.Value;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        //DateTime dtFrom = new DateTime();
        //DateTime dtTo = new DateTime();

        //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //dtfi.ShortDatePattern = "dd/MM/yyyy";
        //dtfi.DateSeparator = "/";

        //{
        //    dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
        //    dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
        //}

        da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.VarChar).Value = Session["dtFrom"];
        da.SelectCommand.Parameters.Add("@createdto", SqlDbType.VarChar).Value = Session["dtTo"];
        da.SelectCommand.Parameters.Add("@Param", SqlDbType.VarChar).Value = Value;
        da.SelectCommand.Parameters.Add("@RouteCode", SqlDbType.VarChar).Value =  RouteCode;


        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();



        //Session["dtFrom"] = null;
        //Session["dtTo"] = null;
        //Session["status"] = null;
    }

    private void PrepareGridViewForExport(Control gv)
    {

        LinkButton lb = new LinkButton();

        Literal l = new Literal();

        string name = String.Empty;

        for (int i = 0; i < gv.Controls.Count; i++)
        {

            if (gv.Controls[i].GetType() == typeof(LinkButton))
            {

                l.Text = (gv.Controls[i] as LinkButton).Text;

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);

            }

            else if (gv.Controls[i].GetType() == typeof(DropDownList))
            {

                l.Text = (gv.Controls[i] as DropDownList).SelectedItem.Text;

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);

            }

            else if (gv.Controls[i].GetType() == typeof(CheckBox))
            {

                l.Text = (gv.Controls[i] as CheckBox).Checked ? "True" : "False";

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);

            }

            if (gv.Controls[i].HasControls())
            {

                PrepareGridViewForExport(gv.Controls[i]);

            }

        }

    }


    private void ExportGridView()
    {

        string attachment = "attachment; filename=Contacts.xls";

        Response.ClearContent();

        Response.AddHeader("content-disposition", attachment);

        Response.ContentType = "application/ms-excel";

        StringWriter sw = new StringWriter();

        HtmlTextWriter htw = new HtmlTextWriter(sw);



        // Create a form to contain the grid

        HtmlForm frm = new HtmlForm();

        GridView1.Parent.Controls.Add(frm);

        frm.Attributes["runat"] = "server";

        frm.Controls.Add(GridView1);



        frm.RenderControl(htw);

        //GridView1.RenderControl(htw);

        Response.Write(sw.ToString());

        Response.End();

    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {

        PrepareGridViewForExport(GridView1);
        ExportGridView();
        //ExportToExcel("Report.xls", GridView1);
    }

}


