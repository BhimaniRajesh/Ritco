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

public partial class GUI_MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["logofile"] = "webxpress_logo.gif";
        string logo = Session["logofile"].ToString();
        imgLogo.ImageUrl = "~/CustomerLogin/GUI/images/" + logo;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();

        XMLMenu();
        //------------------------------------------------

        if (Request.Params["Sel"] != "" && Request.Params["Sel"] != null)
            Response.Redirect(Request.Params["Sel"]);
        //Page.Controls.Add(new System.Web.UI.LiteralControl("You selected " + Request.Params["Sel"]));

        //lblDateTime.Text = DateTime.Now.Date.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();
        lblEmployee.Text = Session["empcd"].ToString().Trim();
        lblEmpNameVal.Text = Session["empnm"].ToString().Trim();
        //if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        //{
        //    lblEmpBranch.Text = Session["mainbrcd"].ToString().Trim() + " (Working Location: " + Session["brcd"].ToString().Trim() + ")";
        //}
        //else
        //{
        //    lblEmpBranch.Text = Session["mainbrcd"].ToString().Trim();
        //}
        //lblFinYear.Text = "Financial Year: " + Session["FinYear"].ToString().Trim();
        //if (!IsPostBack)
        ////{
        ////    DateFunction DAccess = new DateFunction();
        ////    DataSet ds = new DataSet();
        ////    string str = "usp_Get_Finacial_Years";
        ////    ds = DAccess.getdataset(str);
        ////    dlstFinYear.DataSource = ds;
        ////    dlstFinYear.DataValueField = "YearVal";
        ////    dlstFinYear.DataTextField = "FinYear";
        ////    dlstFinYear.DataBind();
        ////    Year();
        //}
    }


    protected void XMLMenu()
    {
        DataSet ds = new DataSet();
        ds = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "WebxNet_Customer_Menu_Access", new SqlParameter("@userid", Session["empcd"].ToString().Trim()));
        ds.DataSetName = "Menus";
        ds.Tables[0].TableName = "Menu";
        DataRelation relation = new DataRelation("ParentChild",
                ds.Tables["Menu"].Columns["MenuID"],
                ds.Tables["Menu"].Columns["ParentID"],
                true);

        relation.Nested = true;
        try
        {
            ds.Relations.Add(relation);
        }
        catch (Exception ex)
        {
        }
        xmlDataSource.Data = ds.GetXml();
    }


    //public void Fin_Year_Change(object sender, EventArgs e)
    //{
    //    Session["FinYear_Change"] = dlstFinYear.SelectedItem.Value;
    //    Session["FinYear"] = dlstFinYear.Items[dlstFinYear.SelectedIndex].Text.Trim().Substring(0, 4);
    //}
    //public void Year()
    //{
    //    if (Session["FinYear_Change"] == null)
    //    {
    //        Session["FinYear_Change"] = "";
    //    }
    //    string MCODE = Session["FinYear_Change"].ToString();
    //    if (MCODE == "")
    //    {

    //        DateFunction DAccess = new DateFunction();
    //        DataSet ds = new DataSet();
    //        string str = "usp_Get_Finacial_Years";
    //        ds = DAccess.getdataset(str);
    //        dlstFinYear.DataSource = ds;
    //        dlstFinYear.DataValueField = "YearVal";
    //        dlstFinYear.DataTextField = "FinYear";
    //        dlstFinYear.DataBind();
    //        Session["FinYear_Change"] = dlstFinYear.SelectedItem.Value;
    //    }
    //    else
    //    {
    //        dlstFinYear.SelectedValue = Session["FinYear_Change"].ToString();
    //    }

    //}
}
