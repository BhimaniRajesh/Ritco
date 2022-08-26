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
using System.Text;
using System.IO;
public partial class Request_RequestFollowReport : System.Web.UI.Page
{

  //  SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    
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

            //Do Work
        }
    }

    //private void ExportToExcel(string strFileName, GridView dg)
    //{
    //    Response.Clear();
    //    Response.Buffer = true;
    //    Response.ContentType = "application/vnd.ms-excel";
    //    Response.AddHeader("content-disposition",
    //    "attachment;filename=" + strFileName);
    //    Response.Charset = "";
    //    this.EnableViewState = false;
    //    System.IO.StringWriter sw = new StringWriter();
    //    System.Web.UI.HtmlTextWriter htw = new HtmlTextWriter(sw);
    //    GridView1.RenderControl(htw);
    //    Response.Write(sw.ToString());
    //    Response.End();
    //}


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


    //id=" + Request + "&id1=" + RouteCode + " &AddEditMode=" + AddEditMode



    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;


        BindGrid();
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
    
        
        
        
        string dtFrom = txtDateFrom.Text.ToString();
        string dtTo = txtDateTo.Text.ToString();
        string status = ddlStatus.SelectedItem.Text;
        if (Session["dtFrom"] == null)
        {
            Session["dtFrom"] = dtFrom;
        }
        else
        {
            dtFrom = Session["dtFrom"].ToString();
        }



        if (Session["dtTo"] == null)
        {
            Session["dtTo"] = dtTo;
        }
        else
        {
            dtTo = Session["dtTo"].ToString();
        }

        if (Session["status"] == null)
        {
            Session["status"] = status;
        }
        else
        {
            status = Session["status"].ToString();
        }

        
        
        
        BindGrid();


        //if (GridView1.Rows.Count != 0)
        //{
        //    LinkButton1.Visible = true;

        //}

        //else
        //{
        //    LinkButton1.Visible = false;
        //}
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlcmd = new SqlCommand("usp_RequestFollowReport", conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        //  string prodtype = cboProdType.SelectedItem.Value;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        {
            dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
            dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
        }

        da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@createdto", SqlDbType.DateTime).Value = dtTo;
        da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = ddlStatus.Text;

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        //ExportToExcel("Report.xls", GridView1);
        PrepareGridViewForExport(GridView1);
        ExportGridView();
    }
}
