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
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Operations_THC_ArrivalUpdate_THCResult_ArrivalUpdate : System.Web.UI.Page
{
    string process = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        process = Request.QueryString["process"].ToString();
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        lblPageHead.Text = Session["THCCalledAs"] + " Arrival/Update";
        MySQLDataSource_THCAvailableForUpdate.ConnectionString = Session["SqlProvider"].ToString().Trim();
    }

    protected void dgTHC_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label THC_colname = (Label)e.Row.FindControl("lblColname");
            Label THC_colname1 = (Label)e.Row.FindControl("lblColname1");
            THC_colname.Text = Session["THCCalledAs"] + " No.";
            THC_colname1.Text = "Man. " + Session["THCCalledAs"] + " No.";
            if (process == "A")
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = true;
            }
            else
            {
                e.Row.Cells[2].Visible = true;
                e.Row.Cells[3].Visible = false;
            }
           
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField HdArr = (HiddenField)e.Row.FindControl("HdArr");
            HiddenField HdStock = (HiddenField)e.Row.FindControl("HdStock");

            Label lblarrst = (Label)e.Row.FindControl("lblarrst");
            Label lblarrst1 = (Label)e.Row.FindControl("lblarrst1");

            Label lblstockst = (Label)e.Row.FindControl("lblstockst");
            Label lblstockst1 = (Label)e.Row.FindControl("lblstockst1");

            Label lblarrupdt1 = (Label)e.Row.FindControl("lblarrupdt1");
            Label lblarrupdt2 = (Label)e.Row.FindControl("lblarrupdt2");
            if (HdArr.Value == "Arrival")
            {
                lblarrst.Text = HdArr.Value;
                lblarrst1.Text = "";
            }
            else
            {
                lblarrst.Text ="";
                lblarrst1.Text = HdArr.Value;
                lblarrst1.Font.Bold = true;
                lblarrst1.ForeColor = System.Drawing.Color.Green;
            }

            if (HdStock.Value == "Stock Update")
            {
                lblstockst.Text = HdStock.Value;
                lblstockst1.Text = "";
            }
            else
            {
                lblstockst.Text = "";
                lblstockst1.Text = HdStock.Value;
                lblstockst1.Font.Bold = true;
                lblstockst1.ForeColor = System.Drawing.Color.Red;
            }
            lblarrupdt2.Text = "--";
            if (HdArr.Value == "Arrival")
            {
                lblstockst.Text = "";
                lblstockst1.Text = HdStock.Value;
                lblstockst1.Font.Bold = true;
                lblstockst1.ForeColor = System.Drawing.Color.Red;
                lblarrupdt2.Text = "";
                lblarrupdt1.Text = "Arrival+Update";
            }
            if(process=="A")
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = true;
            }
            else
            {
                e.Row.Cells[2].Visible = true;
                e.Row.Cells[3].Visible = false;
            }
        }

    }
}
