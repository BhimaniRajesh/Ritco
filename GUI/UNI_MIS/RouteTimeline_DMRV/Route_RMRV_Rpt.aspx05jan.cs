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

public partial class GUI_UNI_MIS_RouteTimeline_DMRV_Route_RMRV_Rpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    static DataSet ds, dsPages;
    public static int intCurrentPageNo;
    public static int intPageSize = 10;
    static string sql, i, THCNO, Status, Loc, EndLoc, StartLoc, Trans, Stat, FromDt, ToDt;
    string Mode;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (HIDCurrentPageNo.Value == "")
        {
            HIDCurrentPageNo.Value = "1";
        }
        intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);

        if (!(IsPostBack))
        {
            From = Convert.ToDateTime(Request.QueryString["dateFrom"]);
            FromDt = From.ToString("dd MMM yyyy");
            To = Convert.ToDateTime(Request.QueryString["dateTo"]);
            ToDt = To.ToString("dd MMM yyyy");
            THCNO = Request.QueryString["THCNO"];            
            Loc = Request.QueryString["Loc"];
            EndLoc = Request.QueryString["EndLoc"];
            StartLoc = Request.QueryString["StartLoc"];
            Trans = Request.QueryString["Trans"];

            BindGrid();
        }
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        if (THCNO.ToString() == "")
        {
            sqlCommand.CommandText = "webx_UNI_rut_DMVR";

            sqlCommand.Parameters.AddWithValue("@FROMDT", FromDt);
            sqlCommand.Parameters.AddWithValue("@TODT", ToDt);
            sqlCommand.Parameters.AddWithValue("@thcno", "All");
            sqlCommand.Parameters.AddWithValue("@startloc", StartLoc);
            sqlCommand.Parameters.AddWithValue("@endloc", EndLoc);
            sqlCommand.Parameters.AddWithValue("@TRN_MOD", Trans);
            sqlCommand.Parameters.AddWithValue("@enrutloc", Loc);
            sqlCommand.Parameters.AddWithValue("@rutnno", "All");
        }
        else
        {
            sql = "select distinct thcno,thcdt,thcbr,thcsf,certify_by,ROUTECD,ROUTENAMe,SOURCEHB,TOBH_CODE,SeHEDEPT_DT,SCHEDEPT_TM,ACTDEPT_DT,ACTDEPT_TM, scharrv_dt,scharrv_tm,actarrv_dt,actarrv_tm,vehno,actload,veh_type,routecost,pcamt,(routecost/actload) as cost_kg,CLOSEKM,OPENKM,vendor_name,rut_cat,vendor_code from vw_thc_DMRC m   with(NOLOCK) where  thcno='" + THCNO.ToString() + "'";
            sqlCommand = new SqlCommand(sql, conn);
        }
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        ds = new DataSet();
        dsPages = new DataSet();

        sqlDA.Fill(ds, ((intCurrentPageNo - 1) * intPageSize), intPageSize, "dtMRDetails");
        sqlDA.Fill(dsPages);

        if (CurrentPage.Text == "")
        {
            CurrentPage.Text = "1";
            intCurrentPageNo = 1;
            HIDCurrentPageNo.Value = "1";
            FirstPage.Enabled = false;
            PreviousPage.Enabled = false;
        }
        else
        {
            CurrentPage.Text = intCurrentPageNo.ToString();
        }

        if (ds.Tables[0].Rows.Count == 0)
        {
            tblNoRecords.Visible = true;

            // trForTotalValues.Visible = false;
            tblPageNavigation.Visible = false;
            tblButtons.Visible = false;
        }
        else
        {
            double dblTotalRecords = dsPages.Tables[0].Rows.Count;
            double dblTotalPages = Convert.ToDouble(System.Math.Ceiling(Convert.ToDecimal(dblTotalRecords / intPageSize)));

            if (dblTotalPages <= 1)
            {
                tblPageNavigation.Visible = false;
            }
            //Logic for Managing Page Navigation Links
            if (intCurrentPageNo == 1)
            {
                FirstPage.Enabled = false;
                PreviousPage.Enabled = false;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }
            else if (intCurrentPageNo == dblTotalPages)
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = false;
                LastPage.Enabled = false;
            }
            else
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }

            ddlPages.Items.Clear();

            ListItem lItem;

            for (int i = 1; i <= dblTotalPages; i++)
            {
                lItem = new ListItem();

                lItem.Text = i.ToString();
                lItem.Value = lItem.Text;

                ddlPages.Items.Add(lItem);

                if (i == Convert.ToInt32(HIDCurrentPageNo.Value))
                {
                    ddlPages.SelectedIndex = ddlPages.Items.Count - 1;
                }

                lItem = null;
            }

            TotalPages.Text = dblTotalPages.ToString();

            DataTable dt = new DataTable();

            dt.Columns.Add("RowCounter", typeof(string));            
            dt.Columns.Add("Route_Code", typeof(string));
            dt.Columns.Add("Route_Name", typeof(string));
            dt.Columns.Add("Route_Mode", typeof(string));
            dt.Columns.Add("THC_No", typeof(string));
            dt.Columns.Add("THC_Dt", typeof(string));
            dt.Columns.Add("Sche_Dt", typeof(string));
            dt.Columns.Add("Sche_Time", typeof(string));
            dt.Columns.Add("Actual_Dt", typeof(string));
            dt.Columns.Add("Actual_Time", typeof(string));
            dt.Columns.Add("Delay_Hour", typeof(string));
            dt.Columns.Add("Vendor", typeof(string));
            dt.Columns.Add("Vehical_No", typeof(string));
            dt.Columns.Add("Vehical_Type", typeof(string));
            dt.Columns.Add("Payload", typeof(string));
            dt.Columns.Add("Actual_Load", typeof(string));
            dt.Columns.Add("Capacity", typeof(string));
            dt.Columns.Add("Actual_Route", typeof(string));
            dt.Columns.Add("Actual_Cost", typeof(string));
            dt.Columns.Add("Srd_Route_Cost", typeof(string));
            dt.Columns.Add("Srd_Cost", typeof(string));
            dt.Columns.Add("Tot_Doc", typeof(string));
            dt.Columns.Add("Doc_Frt", typeof(string));
            dt.Columns.Add("Doc_Frt_Kg", typeof(string));
            dt.Columns.Add("THC_Profit", typeof(string));
            dt.Columns.Add("Profit", typeof(string));
            dt.Columns.Add("THC_Profit_Per", typeof(string));
            dt.Columns.Add("Profit_Per", typeof(string));            
            dt.Columns.Add("Travel", typeof(string));            

            DataRow dr;
            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;
            double THC_Amt = 0;
            double Doc_Frt = 0;
            double Str_Amt = 0;
            double Profit = 0;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Route_Code"] = drRows["ROUTECD"].ToString();
                dr["Route_Name"] = drRows["ROUTENAMe"].ToString();


                Mode = drRows["rut_cat"].ToString().Trim();
                if (drRows["rut_cat"].ToString().Trim() == "S")
                {
                    Mode = "Surface";
                }
                if (drRows["rut_cat"].ToString().Trim() == "R")
                {
                    Mode = "Rail";
                }
                if (drRows["rut_cat"].ToString().Trim() == "A")
                {
                    Mode = "Air";
                }
                dr["Route_Mode"] = Mode.ToString();

                dr["THC_No"] = drRows["thcno"].ToString();
                if (drRows["thcdt"] is DBNull)
                {
                    dr["THC_Dt"] = "-";
                }
                else
                {
                    dr["THC_Dt"] =Convert.ToDateTime(drRows["thcdt"]).ToString("dd MMM yyyy");
                }
                if (drRows["thcdt"] is DBNull)
                {
                    dr["Sche_Dt"] = "-";
                }
                else
                {
                    dr["Sche_Dt"] = Convert.ToDateTime(drRows["thcdt"]).ToString("dd MMM yyyy");
                }

                dr["Sche_Time"] =Convert.ToDateTime(drRows["thcdt"]).ToString("HH:MM");

                if (drRows["ACTDEPT_DT"] is DBNull)
                {
                    dr["Actual_Dt"] = "-";
                }
                else
                {
                    dr["Actual_Dt"] = Convert.ToDateTime(drRows["ACTDEPT_DT"]).ToString("dd MMM yyyy");
                }
                dr["Actual_Time"] = drRows["ACTDEPT_TM"].ToString();

                dr["Delay_Hour"] = "E" + drRows["ACTDEPT_TM"].ToString();
                
                dr["Vendor"] = drRows["vendor_code"].ToString() + " : " + drRows["vendor_name"].ToString();
                dr["Vehical_No"] = drRows["vehno"].ToString();

                //string VehType = Convert.ToString(drRows["veh_type"] == "" ? "2" : drRows["veh_type"]);
                string VehType =Convert.ToString(drRows["veh_type"]).Trim();
                if (VehType.ToString().Trim() == "" || VehType.ToString().Trim() == null)
                {
                    VehType = "2";                        
                }
                SqlCommand sqlCommand1 = new SqlCommand();
                sqlCommand1.Connection = conn;
                string sql = "select Type_Name,payload from webx_VEHICLE_type  where payload is not null and type_code='" + VehType + "'";
                sqlCommand1 = new SqlCommand(sql, conn);

                SqlDataReader dr1 = sqlCommand1.ExecuteReader();

                while (dr1.Read())
                {
                    dr["Vehical_Type"] = dr1["Type_Name"];
                    dr["Payload"] = dr1["payload"];
                }
                dr1.Close();

                dr["Actual_Load"] = (Convert.ToDouble(drRows["actload"] is DBNull ? "0" : drRows["actload"])) / 1000;
                if (dr["Payload"] is DBNull)
                {
                    dr["Capacity"] = Convert.ToDouble(drRows["actload"]) / 1000;
                }
                else
                {
                    double Capacity = (Convert.ToDouble(drRows["actload"] is DBNull ? "0" : drRows["actload"])) / (Convert.ToDouble(dr["Payload"]) * 10);
                    dr["Capacity"] = Capacity.ToString("0.00");
                }
                
                dr["Actual_Route"] = drRows["routecost"].ToString();
                dr["Actual_Cost"] = Convert.ToDouble(drRows["cost_kg"] is DBNull ? "0.00" : drRows["cost_kg"]);

                string STR1 = "select sum(d.freight) as Total_freight,count(n.dockno) as Total_docket from WebX_Trans_Docket_Status n with(NOLOCK) ,webx_master_docket_charges d with(NOLOCK)  where n.thc='" + dr["THC_No"].ToString() + "' and d.dockno=n.dockno";

                SqlCommand cmd1 = new SqlCommand(STR1, conn);
                SqlDataReader dr2 = cmd1.ExecuteReader();
                while (dr2.Read())
                {
                    if(dr2["Total_freight"] is DBNull)
                    {
                        dr["Doc_Frt"]="0";
                    }
                    else
                    {
                        dr["Doc_Frt"] = dr2["Total_freight"].ToString();
                    }
                    dr["Tot_Doc"] = dr2["Total_docket"].ToString();
                }
                dr2.Close();
                
                string STR2 = "select rutkm,schdep_hr,schdep_min,rutmod,std_contamt from webx_rutmas  with(NOLOCK)  where rutcd='" + dr["Route_Code"].ToString() + "'";
                SqlCommand cmd2 = new SqlCommand(STR2, conn);
                SqlDataReader dr3 = cmd2.ExecuteReader();
                while (dr3.Read())
                {
                    dr["Travel"] = dr3["rutkm"].ToString();
                    dr["Srd_Route_Cost"] = dr3["std_contamt"].ToString();                    
                }
                dr3.Close();

                Doc_Frt = Convert.ToDouble(dr["Doc_Frt"]);
                if (dr["Srd_Route_Cost"] is DBNull)
                {
                    dr["Srd_Route_Cost"] = "0";
                }
                Str_Amt = Convert.ToDouble(dr["Srd_Route_Cost"]);
                THC_Amt = Doc_Frt - Str_Amt;

                dr["THC_Profit"] = THC_Amt.ToString();

                if (drRows["actload"].ToString() != "" && drRows["actload"].ToString() != "")
                {
                    dr["Srd_Cost"] = "0";
                }
                else
                {
                    dr["Srd_Cost"] = Str_Amt / (Convert.ToDouble(dr["Actual_Load"]) * 1000);
                }
                if (drRows["actload"] is DBNull || drRows["actload"].ToString()!="0")
                {
                    dr["Doc_Frt_Kg"] = Convert.ToDouble(dr["Doc_Frt"]) / (Convert.ToDouble(dr["Actual_Load"]) * 1000);
                }
                else
                {
                    dr["Doc_Frt_Kg"] = "0";
                    //dr["Doc_Frt_Kg"] = Convert.ToDouble(dr["Doc_Frt"]) / (Convert.ToDouble(dr["Actual_Load"]) * 1000);
                }

                dr["THC_Profit_Per"] = Convert.ToDouble(dr["Doc_Frt"]) - Convert.ToDouble(dr["Actual_Cost"]);

                if (dr["Srd_Route_Cost"].ToString() == "0")
                {
                    dr["Profit"] = "0";
                }
                else
                {
                    Profit = (Convert.ToDouble(dr["THC_Profit"]) * 100) / Str_Amt;
                    dr["Profit"] = Profit.ToString("0.00");
                }

                if (dr["Actual_Route"] is DBNull || dr["Actual_Route"].ToString() == "0")
                {
                    dr["Profit_Per"] = dr["THC_Profit_Per"].ToString();
                }
                else
                {
                    if (dr["THC_Profit_Per"].ToString() == "0")
                    {
                        dr["Profit_Per"] = dr["THC_Profit_Per"].ToString();
                    }
                    else
                    {
                       
                        double Profit_Per = (Convert.ToDouble(dr["THC_Profit_Per"]) * 100) / Convert.ToDouble(dr["Actual_Route"]);
                        dr["Profit_Per"] = Profit_Per.ToString("0.00");

                    }
                }
                dt.Rows.Add(dr);

                rptBillDetails.DataSource = dt;
                rptBillDetails.DataBind();
            }
            conn.Close();
        }
    }
    protected void NavigationLink_Click(Object sender, CommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "First":
                intCurrentPageNo = 1;
                break;
            case "Last":
                intCurrentPageNo = Int32.Parse(TotalPages.Text);
                break;
            case "Next":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) + 1;
                break;
            case "Prev":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) - 1;
                break;
        }
        HIDCurrentPageNo.Value = intCurrentPageNo.ToString();
        BindGrid();
    }
    protected void btnXLS_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("DMRV_Summary.csv"), false);

        //DataTable dt = ds.Tables[0];
        //int iColCount = dt.Columns.Count;
        //for (int i = 0; i < iColCount; i++)
        //{
        //    sw.Write(ds.Tables[0].Columns[i]);
        //    if (i < iColCount - 1)
        //    {
        //        sw.Write(",");
        //    }
        //}
        //sw.Write(sw.NewLine);

        //foreach (DataRow dr in dt.Rows)
        //{
        //    for (int i = 0; i < iColCount; i++)
        //    {
        //        if (!Convert.IsDBNull(dr[i]))
        //        {
        //            sw.Write(dr[i].ToString());
        //        }
        //        if (i < iColCount - 1)
        //        {
        //            sw.Write(",");
        //        }
        //    }
        //    sw.Write(sw.NewLine);
        //}
        //sw.Close();

        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("DMRV_Summary.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "DMRV_Summary.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        Response.ClearContent();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Route_DMRV_Rpt.xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Route_DMRV_Rpt.RenderControl(hw);
        Response.Write(sw.ToString());
        Response.End();
    }
}
