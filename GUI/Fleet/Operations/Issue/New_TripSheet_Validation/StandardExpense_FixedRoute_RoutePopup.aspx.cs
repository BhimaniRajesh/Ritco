﻿using System;
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
using WebX.Controllers;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRoute_RoutePopup : System.Web.UI.Page
{
    //SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string strQSParam;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        hdnstrQSParam.Value = HttpUtility.UrlDecode(Request.QueryString.ToString());
        //cn.Open();
        //string sql = "Select RouteNo, RouteName from StandardExpense_FixedRoute_HDR";
        //SqlCommand cmd = new SqlCommand(sql, cn);
        //SqlDataAdapter adp = new SqlDataAdapter(cmd);
        //DataTable dt = new DataTable();
        //adp.Fill(dt);
        //GridView1.DataSource = dt;
        //GridView1.DataBind();
        //cn.Close();

        if (!Page.IsPostBack)
        {
            VehicleMasterController objVehicleMaster = new VehicleMasterController();
            DataTable dtRoute = new DataTable();
            dtRoute = objVehicleMaster.getAllRoutes();

            if (dtRoute != null && dtRoute.Rows.Count > 0)
            {
                GridView1.DataSource = dtRoute;
                GridView1.DataBind();
            }

        }

    }
}




