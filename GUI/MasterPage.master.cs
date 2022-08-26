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
using System.Diagnostics;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
		Page.Header.DataBind();
        if (string.IsNullOrEmpty(Convert.ToString(Session["logofile"])))
            Response.Redirect("~/login.aspx", false);
        string logo = Session["logofile"].ToString();
        imgLogo.ImageUrl = "~/GUI/images/" + logo;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();

        //DataSet ds = new DataSet();
        ////ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString, CommandType.StoredProcedure, "usp_User_Menu_Access", new SqlParameter("@userid", Session["empcd"].ToString().Trim()), new SqlParameter("@branchid", Session["brcd"].ToString().Trim()));
        //ds = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_User_Menu_Access", new SqlParameter("@userid", Session["empcd"].ToString().Trim()), new SqlParameter("@branchid", Session["brcd"].ToString().Trim()));
        ////using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString))
        ////{
        ////    string sql = "usp_User_Menu_Access";
        ////    SqlCommand sqlcmd = new SqlCommand(sql, conn);
        ////    sqlcmd.CommandType = CommandType.StoredProcedure;
        ////    sqlcmd.Parameters.Add("@userid", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();
        ////    sqlcmd.Parameters.Add("@branchid", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();

        ////    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        ////    //string sql = "Select MenuID, Text, Description, NavigationURL,ParentID from WMS_Master_Menu";
        ////    ////string sql = "Select MenuID, Text, Description, NavigationURL,ParentID from WMS_Master_Menu Where MenuID not in (2,3) and (ParentID not in (2,3) Or ParentId is Null)";
        ////    //SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        ////    da.Fill(ds);
        ////    da.Dispose();
        ////}
        //ds.DataSetName = "Menus";
        //ds.Tables[0].TableName = "Menu";
        //DataRelation relation = new DataRelation("ParentChild",
        //        ds.Tables["Menu"].Columns["MenuID"],
        //        ds.Tables["Menu"].Columns["ParentID"],
        //        true);

        //relation.Nested = true;
        //try
        //{
        //    ds.Relations.Add(relation);
        //}
        //catch (Exception ex)
        //{
        //}

        //xmlDataSource.Data = ds.GetXml();

        //--Create Menu according to Login ID & Branch----
        XMLMenu();
        //------------------------------------------------

        if (Request.Params["Sel"] != "" && Request.Params["Sel"] !=null)
            Response.Redirect(Request.Params["Sel"]);
            //Page.Controls.Add(new System.Web.UI.LiteralControl("You selected " + Request.Params["Sel"]));

        //lblDateTime.Text = DateTime.Now.Date.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();
        lblEmployee.Text = Session["empcd"].ToString().Trim();
        lblEmpNameVal.Text = Session["empnm"].ToString().Trim();
        if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            lblEmpBranch.Text = Session["mainbrcd"].ToString().Trim() + " (Working Location: " + Session["brcd"].ToString().Trim() + ")";
        }
        else
        {
            lblEmpBranch.Text = Session["mainbrcd"].ToString().Trim();
        }
        //lblFinYear.Text = "Financial Year: " + Session["FinYear"].ToString().Trim();
        if (!IsPostBack)
        {
            DateFunction DAccess = new DateFunction();
            DataSet ds = new DataSet();
            string str = "usp_Get_Finacial_Years";
            ds = DAccess.getdataset(str);
            dlstFinYear.DataSource = ds;
            dlstFinYear.DataValueField = "YearVal";
            dlstFinYear.DataTextField = "FinYear";
            dlstFinYear.DataBind();

            if (Session["empcd"].ToString() == "AUDIT")
            {
                dlstFinYear.Items[0].Enabled = false;
                dlstFinYear.Items[1].Enabled = false;
                dlstFinYear.Items[2].Enabled = true;
                dlstFinYear.Items[3].Enabled = true;
                dlstFinYear.Items[4].Enabled = false;
                dlstFinYear.Items[5].Enabled = false;
                dlstFinYear.Items[6].Enabled = false;
		dlstFinYear.Items[7].Enabled = false;
                dlstFinYear.Items[8].Enabled = false;
                dlstFinYear.Items[9].Enabled = false;
		dlstFinYear.Items[10].Enabled = false;
                dlstFinYear.Items[11].Enabled = false;
                dlstFinYear.Items[12].Enabled = false;
            }

            Year();
        }

    }

    protected void XMLMenu()
    {
        DataSet ds = new DataSet();
        if (Session["Menu"] == null)
        {
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

            Session["Menu"] = ds;
        }
        else
        {
            ds = (DataSet)Session["Menu"];
        }
        xmlDataSource.Data = ds.GetXml();
    }

    /*
     * Commented on 06 Nov 2007
    protected void onFinYearDataBound(object sender, EventArgs e)
    {
        if (Session["FinYear"] != null)
        {
            DropDownList cbo = (DropDownList)sender;
            for (int i = 0; i <= cbo.Items.Count - 1; i++)
            {
                if (cbo.Items[i].Value == Session["FinYear"].ToString().Trim()) cbo.Items[i].Selected = true;
            }
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
            lblCurrLoc.Text = " / " + Session["brcd"].ToString().Trim();
        }
        else
        {
            lblCurrLoc.Text = "";
        }
        XMLMenu();


        cboLoc.DataSource = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_WorkingLocations", new SqlParameter("@curr_brcd", Session["brcd"].ToString().Trim()), new SqlParameter("@main_brcd", Session["mainbrcd"].ToString().Trim()));
        cboLoc.DataBind();

        Server.Transfer("~/GUI/welcome.aspx");
        //MyCPH1.Visible = false;
    }

    protected void onFinYearChange(object sender, EventArgs e)
    {
        Session["FinYear"] = cboFinYear.Items[cboFinYear.SelectedIndex].Value;
    }
     */
    public void Fin_Year_Change(object sender, EventArgs e)
    {
        Session["FinYear_Change"] = dlstFinYear.SelectedItem.Value;
        Session["FinYear"] = dlstFinYear.Items[dlstFinYear.SelectedIndex].Text.Trim().Substring(0, 4);
    }
    public void Year()
    {
        if (Session["FinYear_Change"] == null)
        {
            Session["FinYear_Change"] = "";
        }
        string MCODE = Session["FinYear_Change"].ToString();
        if (MCODE == "")
        {

            DateFunction DAccess = new DateFunction();
            DataSet ds = new DataSet();
            string str = "usp_Get_Finacial_Years";
            ds = DAccess.getdataset(str);
            dlstFinYear.DataSource = ds;
            dlstFinYear.DataValueField = "YearVal";
            dlstFinYear.DataTextField = "FinYear";
            dlstFinYear.DataBind();

            if (Session["empcd"].ToString() == "AUDIT")
            {
                dlstFinYear.Items[0].Enabled = false;
                dlstFinYear.Items[1].Enabled = false;
                dlstFinYear.Items[2].Enabled = true;
                dlstFinYear.Items[3].Enabled = true;
                dlstFinYear.Items[4].Enabled = false;
                dlstFinYear.Items[5].Enabled = false;
                dlstFinYear.Items[6].Enabled = false;
		dlstFinYear.Items[7].Enabled = false;
                dlstFinYear.Items[8].Enabled = false;
                dlstFinYear.Items[9].Enabled = false;
		dlstFinYear.Items[10].Enabled = false;
                dlstFinYear.Items[11].Enabled = false;
                dlstFinYear.Items[12].Enabled = false;
            }

            Session["FinYear_Change"] = dlstFinYear.SelectedItem.Value;
        }
        else
        {
            dlstFinYear.SelectedValue = Session["FinYear_Change"].ToString();
        }

    }
	
	protected void lnkNewSite_Click(object sender, EventArgs e)
    {
        string userid = SessionUtilities.CurrentEmployeeID;
        string pass = SessionUtilities.CurrentEmployeeID;
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string Query = "SELECT UserPwd FROM webx_master_users WHERE UserId='"+ userid + "' AND Status='100'";
        SqlCommand c = new SqlCommand(Query, cn);
        SqlDataReader d = c.ExecuteReader();
        while (d.Read()) { pass = d["UserPwd"].ToString(); }
        d.Close();
        cn.Close();
        string url = "http://ritco-tms.southeastasia.cloudapp.azure.com/RitcoLog_LiveMVC/LoginUser/TMSLogin?UserId=" + userid + "&Password=" + HttpContext.Current.Server.UrlEncode(pass);
        Process.Start("chrome", @"" + url);

    }
}
