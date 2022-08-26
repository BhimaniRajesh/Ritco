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
public partial class GUI_admin_Reports_acess_rights : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        OpenPopUp(btnPopup, "../popups/popup_employees.aspx?sender=" + txtEmpCode.ClientID, "MyWind", 600, 300);
        if (!IsPostBack)
        {
            BindGrid();
        }

        //----------------------------------------
        //if(JavaUpdate.IsUpdate == "true"){
        //    switch (JavaUpdate.strSender){
        //        case "txtEmpCode":
        //            //Update control here
        //            txtEmpCode.Text = "chai";
        //            break;
        //    }        
        //}
        //------------------------------------------
    }

    public void OpenPopUp(System.Web.UI.WebControls.WebControl opener, String PagePath, String windowName, int Width, int Height)
    {
        string clientScript;
        string windowAttribs;

        //Building Client side window attributes with width and height.
        //Also the the window will be positioned to the middle of the 
        windowAttribs = "resizable=no, scrollbars=auto,width=" + Width.ToString() + "px," + "height=" + Height.ToString() + "px," + "left='+((screen.width -" + Width.ToString() + ") / 2)+'," + "top='+ (screen.height - " + Height.ToString() + ") / 2+'";
        //Building the client script- window.open , with additional parameters
        clientScript = "window.open('" + PagePath + "','" + windowName + "','" + windowAttribs + "');return false;";
        //register the script to the clientside click event of the opener control
        opener.Attributes.Add("onClick", clientScript);
    }

    protected void JavaAlert(string alertmsg)
    {
        //Part 1 the same code as before
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        //sb.Append("<");
        //sb.Append("script language='javascript'>");

        sb.Append("function AlertMsg()");
        sb.Append("{");
        sb.Append("alert('" + alertmsg + "');");
        sb.Append("}");


        sb.Append("AlertMsg();");
        //sb.Append("<");
        //sb.Append("/script>");

        //Part 2 Registering The ClientScriptBlock
        //Type t = this.GetType();

        //Check whether they are already registered
        if (!this.IsStartupScriptRegistered("JavaAlertScript"))
        {
            //Register the script
            this.RegisterStartupScript("JavaAlertScript", sb.ToString());
        }
    }

    protected void BindGrid()
    {
        SetDataSet();
        dgGeneral.DataSource = ds;
        dgGeneral.DataBind();
    }

    protected void SetDataSet()
    {
        //Make & Open Connection
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        //--------------------------------

        //string sql = "Select Level0Text=L0_Text, Level1Text=L1_Text, Level2Text=[Text] From vw_Menu_All_Levels";

        //string sql = "Select Chk=(Case When IsNull(UserId,'')='' then 'false' Else 'true' End),Level0Text=(case when title='O' then 'Operations Reports' when title='F' then 'Finance Reports' when title='S' then 'Specific Reports' end),  Level1Text=(case when subtitle='O1' then 'Redister Reports' when subtitle='O2' then 'Summary Reports '  when subtitle='O3' then 'Movement Summary Reports ' when subtitle='F1' then 'Register Reports' when subtitle='F2' then 'Summary Reports' when subtitle='F3' then 'Cash & Bank  Reports' when subtitle='F4' then 'Accounts Statements  Reports' when subtitle='F5' then 'Regulatory Filings Reports' end ), Level2Text=Report_Name,'' as L0_App_Module,srno as L1_App_Module,'' as App_Module From webx_reports_acess_net with(NOLOCK) Left Outer Join Webx_Master_ReportsAccess with(NOLOCK)  On srno = ReportID and HasAccess='Y' and UserId='" + txtEmpCode.Text.Trim() + "'  where activeflag='Y' order by title,subtitle";
        //string sql = "Select Chk=(Case When IsNull(UserId,'')='' then 'false' Else 'true' End),Level0Text=(case when title='O' then 'Operations Reports' when title='A' then 'Accounts Reports' when title='F' then 'Finance Reports' when title='S' then 'Specific Reports' end),  Level1Text=(case when subtitle='O1' then 'Register Reports' when subtitle='O2' then 'Summary Reports '  when subtitle='O3' then 'Movement Summary Reports ' when subtitle='F1' then 'Register Reports' when subtitle='F2' then 'Summary Reports' when subtitle='A1' then 'Register Reports' when subtitle='A2' then 'Summary Reports ' when subtitle='F3' then 'Cash & Bank  Reports' when subtitle='F4' then 'Accounts Statements  Reports' when subtitle='F5' then 'Regulatory Filings Reports' end ), Level2Text=Report_Name,'' as L0_App_Module,srno as L1_App_Module,'' as App_Module From Webx_Reports_Ver1 with(NOLOCK) Left Outer Join Webx_Master_ReportsAccess_ver1 with(NOLOCK)  On srno = ReportID and HasAccess='Y' and UserId='" + txtEmpCode.Text.Trim() + "'  where activeflag='Y' order by color,title,subtitle";
        string sql = "Select Chk=(Case When IsNull(UserId,'')='' then 'false' Else 'true' End),Level0Text=(case when title='O' then 'Operations Reports' when title='A' then 'Accounts Reports' when title='F'then 'Finance Reports' when title='S' then 'Specific Reports' when title = 'FT' then 'Fleet Report' when title = 'OCF' then 'One Click Report'    end),Level1Text=(case when subtitle='O1' then 'Register Reports' when subtitle='O2' then 'Summary Reports '  when subtitle='O3' then 'Movement Summary Reports ' when subtitle='F1' then 'Register Reports' when subtitle='F2' then 'Summary Reports' when subtitle='A1' then 'Register Reports' when subtitle='A2' then 'Summary Reports ' when subtitle='F3' then 'Cash & Bank  Reports' when subtitle='F4' then 'Accounts Statements  Reports' when subtitle='F5' then 'Regulatory Filings Reports' when subtitle = 'FT1' then 'Driver Reports' when subtitle = 'FT2' then 'Fuel Reports' when subtitle = 'FT3' then 'Maintenance Reports' when subtitle = 'FT4' then 'Tripsheet Reports' when subtitle = 'FT5' then 'Tyre Reports' when subtitle = 'FT6' then 'Vehicle Reports'when subtitle = 'FT7' then 'Vendor Reports' when subtitle = 'OCF1' then 'Vehicle Maintanance Reports' when subtitle = 'OCF2' then 'Trip Operation Reports' end ), Level2Text=Report_Name,'' as L0_App_Module,srno as L1_App_Module,'' as App_Module From Webx_Reports_Ver1 with(NOLOCK) Left Outer Join Webx_Master_ReportsAccess_ver1 with(NOLOCK)  On srno = ReportID and HasAccess='Y' and UserId='" + txtEmpCode.Text.Trim() + "'  where activeflag='Y' order by title,subtitle";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlConn);
        sqlCmd.CommandType = CommandType.Text;
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Close Connection
        sqlConn.Close();
        sqlConn = null;
        //--------------------------------
    }

    //----------------------------------

    protected void CheckAll_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in dgGeneral.Rows)
        {
            CheckBox cb = (CheckBox)gvr.FindControl("chkRights");
            cb.Checked = true;
        }

    }

    protected void UnCheckAll_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in dgGeneral.Rows)
        {
            CheckBox cb = (CheckBox)gvr.FindControl("chkRights");
            cb.Checked = false;
        }

    }

    //string prod = dgOrderHeader.DataKeys[index].Values[0].ToString(); prod = prod.Trim().ToString();
    //string tariff = dgOrderHeader.DataKeys[index].Values[1].ToString(); tariff = tariff.Trim().ToString();
    //string quantity = dgOrderHeader.DataKeys[index].Values[2].ToString(); quantity = quantity.Trim().ToString();
    //string basicval = dgOrderHeader.DataKeys[index].Values[3].ToString(); basicval = basicval.Trim().ToString();

    //protected void dg_RowCreated(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        DataRowView drv = ((DataRowView)e.Row.DataItem);
    //        try
    //        {
    //            CheckBox chk = (CheckBox)dgGeneral.Rows[e.Row.RowIndex].FindControl("chkRights");
    //            chk.Checked = false;
    //            //e.Row.Cells[0].Checked = false;
    //            if (drv["Chk"].ToString() == "true")
    //            {
    //                chk.Checked = true;
    //                //e.Row.Cells[0].Checked = true;
    //            }
    //        }
    //        catch (Exception ex) { }
    //    }
    //}

    protected void SetAllLevel0(object sender, CommandEventArgs e)
    {
        string prev = "";
        string tmp = "";
        string level0 = dgGeneral.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[1].ToString().Trim();
        bool firstBool = false;
        //BindGrid();
        for (int index = Convert.ToInt32(e.CommandArgument.ToString()); index <= dgGeneral.Rows.Count - 1; index++)
        {
            tmp = dgGeneral.DataKeys[index].Values[1].ToString().Trim();
            if ((tmp == prev || prev == "") && tmp == level0) //
            {
                CheckBox cb = (CheckBox)dgGeneral.Rows[index].FindControl("chkRights");
                if (prev == "") { firstBool = cb.Checked; }
                //if (e.CommandName.ToString().Trim() == "Plus")
                //{
                cb.Checked = !firstBool;
                //}

                //if (e.CommandName.ToString().Trim() == "Minus")
                //{
                //    cb.Checked = false;
                //}

            }
            prev = dgGeneral.DataKeys[index].Values[1].ToString().Trim();
        }
        lblDone1.Visible = false;
        lblDone2.Visible = false;
    }

    protected void SetAllLevel1(object sender, CommandEventArgs e)
    {
        string prev = "";
        string tmp = "";
        string level1 = dgGeneral.DataKeys[Convert.ToInt32(e.CommandArgument.ToString())].Values[2].ToString().Trim();
        bool firstBool = false;
        //BindGrid();
        for (int index = Convert.ToInt32(e.CommandArgument.ToString()); index <= dgGeneral.Rows.Count - 1; index++)
        {
            tmp = dgGeneral.DataKeys[index].Values[2].ToString().Trim();
            if ((tmp == prev || prev == "") && tmp == level1) //
            {
                CheckBox cb = (CheckBox)dgGeneral.Rows[index].FindControl("chkRights");
                if (prev == "") { firstBool = cb.Checked; }
                //if (e.CommandName.ToString().Trim() == "Plus")
                //{
                cb.Checked = !firstBool;
                //}

                //if (e.CommandName.ToString().Trim() == "Minus")
                //{
                //    cb.Checked = false;
                //}

            }
            prev = dgGeneral.DataKeys[index].Values[2].ToString().Trim();
        }
        lblDone1.Visible = false;
        lblDone2.Visible = false;
    }

    protected void CurrentAccessRights(object sender, EventArgs e)
    {
        string tmp = "";
        BindGrid();
        for (int index = 0; index <= dgGeneral.Rows.Count - 1; index++)
        {
            tmp = dgGeneral.DataKeys[index].Values[0].ToString().Trim();
            CheckBox cb = (CheckBox)dgGeneral.Rows[index].FindControl("chkRights");
            cb.Checked = false;
            if (tmp == "true")
            {
                cb.Checked = true;
            }
        }
        lblDone1.Visible = false;
        lblDone2.Visible = false;

        //foreach (GridViewRow gvr in dgGeneral.Rows)
        //{
        //    if (gvr.RowType == DataControlRowType.DataRow)
        //    {
        //        try
        //        {
        //            tmp = dgGeneral.DataKeys[gvr.RowIndex].Values[0].ToString().Trim();
        //            CheckBox cb = (CheckBox)gvr.FindControl("chkRights");
        //            cb.Checked = false;
        //            if (tmp == "true")
        //            {
        //                cb.Checked = true;
        //            }
        //        }
        //        catch (Exception ex) { }
        //    }
        //}
    }

    protected void AssignRights(object sender, EventArgs e)
    {
        string lvl0 = "";
        string lvl1 = "";
        string lvl2 = "";

        //Reset Rights for given Employee
        ResetRightsProc(txtEmpCode.Text.Trim());

        for (int index = 0; index <= dgGeneral.Rows.Count - 1; index++)
        {
            CheckBox cb = (CheckBox)dgGeneral.Rows[index].FindControl("chkRights");
            if (cb.Checked)
            {
                lvl0 = dgGeneral.DataKeys[index].Values[1].ToString().Trim();
                lvl1 = dgGeneral.DataKeys[index].Values[2].ToString().Trim();
                lvl2 = dgGeneral.DataKeys[index].Values[3].ToString().Trim();
                //Assign Rights for Given Employee one by one
                AssignRightsProc(txtEmpCode.Text.Trim(), lvl0, lvl1, lvl2);
            }
        }
        lblDone1.Visible = true;
        lblDone2.Visible = true;

        lblDone1.Text = "Done";
        lblDone2.Text = "Done";
        //foreach (GridViewRow gvr in dgGeneral.Rows)
        //{
        //    if (gvr.RowType == DataControlRowType.DataRow)
        //    {
        //        try
        //        {
        //            lvl0 = dgGeneral.DataKeys[gvr.RowIndex].Values[1].ToString().Trim();
        //            lvl1 = dgGeneral.DataKeys[gvr.RowIndex].Values[2].ToString().Trim();
        //            lvl2 = dgGeneral.DataKeys[gvr.RowIndex].Values[3].ToString().Trim();
        //            CheckBox cb = (CheckBox)gvr.FindControl("chkRights");

        //            if (cb.Checked)
        //            {
        //                //Assign Rights for Given Employee one by one
        //                AssignRightsProc(txtEmpCode.Text.Trim(), lvl0, lvl1, lvl2);
        //            }
        //        }
        //        catch (Exception ex) { }
        //    }
        //}
        //JavaAlert("Access Rights Assigned succesfully...");
        //MsgBox1.alert("Access Rights Assigned succesfully...");
    }

    protected void ResetRightsProc(string empcode)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_Reset_ReportsRights_ver1";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        sqlcmd.Parameters.Add("@empcode", SqlDbType.VarChar).Value = empcode.Trim();
        sqlcmd.ExecuteNonQuery();

        //Close the connection
        conn.Close();
    }

    protected void AssignRightsProc(string empcode, string level0, string level1, string level2)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_Assign_ReportsRights_ver1";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        sqlcmd.Parameters.Add("@empcode", SqlDbType.VarChar).Value = empcode.Trim();
        sqlcmd.Parameters.Add("@level0", SqlDbType.VarChar).Value = level0.Trim();
        sqlcmd.Parameters.Add("@level1", SqlDbType.VarChar).Value = level1.Trim();
        sqlcmd.Parameters.Add("@level2", SqlDbType.VarChar).Value = level2.Trim();

        try
        {
            sqlcmd.ExecuteNonQuery();
        }
        catch (Exception ex) { }
        //Close the connection
        conn.Close();
    }

    string previousCat = "";
    int firstRow = -1;
    string previousCat2 = "";
    int firstRow2 = -1;
    string tmp = "";
    protected void dg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            //We're only interested in Rows that contain data    
            //get a reference to the data used to databound the row    
            DataRowView drv = ((DataRowView)e.Row.DataItem);
            tmp = drv["Chk"].ToString();

            //thisRow = thisRow + 1;

            //LEVEL 0
            if (previousCat == drv["Level0Text"].ToString())
            {

                ////If it's the same category as the previous one      
                ////Increment the rowspan      
                //if (dgGeneral.Rows[firstRow].Cells[1].RowSpan == 0)
                //{
                //    dgGeneral.Rows[firstRow].Cells[1].RowSpan = 2;
                //}
                //else
                //{
                //    try
                //    {
                //        dgGeneral.Rows[firstRow].Cells[1].RowSpan += 1;
                //    }
                //    catch (Exception ex)
                //    {
                //    }
                //}
                ////Remove the cell      
                //e.Row.Cells.RemoveAt(1);
                try
                {
                    //e.Row.Cells[e.Row.RowIndex].ForeColor = System.Drawing.Color.White;
                    //Response.Write(thisRow.ToString() + "--" + firstRow.ToString() + "--" + previousCat + "--" + drv["Level0Text"].ToString() + "<br>"); 
                    //dgGeneral.Rows[thisRow+1].Cells[1].ForeColor = System.Drawing.Color.White;
                    e.Row.Cells[1].Text = "";
                }
                catch (Exception ex) { }
            }
            else //It's a new category    
            {
                //Set the vertical alignment to top      
                e.Row.VerticalAlign = VerticalAlign.Top;
                //Maintain the category in memory      
                previousCat = drv["Level0Text"].ToString();
                firstRow = e.Row.RowIndex;
                e.Row.Cells[1].BackColor = System.Drawing.Color.AliceBlue;
            }


            //LEVEL 1
            if (previousCat2 == drv["Level1Text"].ToString())
            {
                try
                {
                    e.Row.Cells[2].Text = "";
                }
                catch (Exception ex) { }

            }
            else //It's a new category    
            {
                //Set the vertical alignment to top      
                e.Row.VerticalAlign = VerticalAlign.Top;
                //Maintain the category in memory      
                previousCat2 = drv["Level1Text"].ToString();
                firstRow2 = firstRow; // e.Row.RowIndex;
                if (drv["Level1Text"].ToString() != "")
                {
                    e.Row.Cells[2].BackColor = System.Drawing.Color.AliceBlue;
                }
            }

            if (drv["Level2Text"].ToString() != "")
            {
                e.Row.Cells[3].BackColor = System.Drawing.Color.AliceBlue;
            }

        }
    }

}
