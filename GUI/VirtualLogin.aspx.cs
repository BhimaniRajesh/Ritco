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

public partial class GUI_VirtualLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!Page.IsPostBack)
        {
            cboLoc.DataSource = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_MVC_WorkingLocations", new SqlParameter("@UserID", Session["empcd"].ToString().Trim()), new SqlParameter("@SearchText", Session["mainbrcd"].ToString().Trim()));
            cboLoc.DataBind();
        }

    }

    protected void onLocationDataBound(object sender, EventArgs e)
    {
        if (Session["brcd"] != null)
        {
            DropDownList cbo = (DropDownList)sender;
            for (int i = 0; i <= cbo.Items.Count - 1; i++)
            {
                if (cbo.Items[i].Value == Session["brcd"].ToString().Trim()) cbo.Items[i].Selected = true;
            }
        }
    }

    protected void onLocationChange(object sender, EventArgs e)
    {
        Session["brcd"] = cboLoc.Items[cboLoc.SelectedIndex].Value;
        cboLoc.Items.Clear();

        if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            //lblCurrLoc.Text = " / " + Session["brcd"].ToString().Trim();
        }
        else
        {
            //lblCurrLoc.Text = "";
        }
        //XMLMenu();


        cboLoc.DataSource = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_MVC_WorkingLocations", new SqlParameter("@UserID", Session["empcd"].ToString().Trim()), new SqlParameter("@SearchText", Session["mainbrcd"].ToString().Trim()));
        cboLoc.DataBind();

        Server.Transfer("~/GUI/welcome.aspx");
    }

    /*
    protected void XMLMenu()
    {
        DataSet ds = new DataSet();
        ds = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_User_Menu_Access", new SqlParameter("@userid", Session["empcd"].ToString().Trim()), new SqlParameter("@branchid", Session["brcd"].ToString().Trim()));
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
     */ 
}
