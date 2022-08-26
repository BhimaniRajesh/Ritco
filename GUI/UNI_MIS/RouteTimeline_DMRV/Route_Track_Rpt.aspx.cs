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

public partial class GUI_UNI_MIS_RouteTimeline_DMRV_Route_Track_Rpt : System.Web.UI.Page
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
            sqlCommand.CommandText = "webx_rut_timeline_first";

            sqlCommand.Parameters.AddWithValue("@FROMDT", FromDt);
            sqlCommand.Parameters.AddWithValue("@TODT", ToDt);
            sqlCommand.Parameters.AddWithValue("@thcno", "All");
            sqlCommand.Parameters.AddWithValue("@startloc", StartLoc);
            sqlCommand.Parameters.AddWithValue("@endloc", EndLoc);            
            sqlCommand.Parameters.AddWithValue("@enrutloc", Loc);
            sqlCommand.Parameters.AddWithValue("@rutnno", "All");
        }
        else
        {
            sql = "Select distinct thcno as THC_Number,routecd,routename,thcdt as thc_date,thcbr,thcsf,certify_by,(select top 1 trtime_hr + ':' + trtime_min from webx_ruttran where rutcd= v.routecd) as tr_time From vw_thc_summary V  with(NOLOCK)  where  thcno='" + THCNO.ToString() + "'";
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
            dt.Columns.Add("Transit_Hrs", typeof(string));
            dt.Columns.Add("THC_No", typeof(string));
            dt.Columns.Add("THC_Dt", typeof(string));

            dt.Columns.Add("Loc_Start", typeof(string));
            dt.Columns.Add("Transit_Start", typeof(string));
            dt.Columns.Add("STA_Arr_Start", typeof(string));
            dt.Columns.Add("ETA_Arr_Start", typeof(string));
            dt.Columns.Add("ATA_Arr_Start", typeof(string));
            dt.Columns.Add("Late_Arr_Start", typeof(string));
            dt.Columns.Add("STA_Dep_Start", typeof(string));
            dt.Columns.Add("ETA_Dep_Start", typeof(string));
            dt.Columns.Add("ATA_Dep_Start", typeof(string));
            dt.Columns.Add("Late_Dep_Start", typeof(string));

            dt.Columns.Add("Loc_1", typeof(string));
            dt.Columns.Add("Transit_1", typeof(string));
            dt.Columns.Add("STA_Arr_1", typeof(string));
            dt.Columns.Add("ETA_Arr_1", typeof(string));
            dt.Columns.Add("ATA_Arr_1", typeof(string));
            dt.Columns.Add("Late_Arr_1", typeof(string));
            dt.Columns.Add("STA_Dep_1", typeof(string));
            dt.Columns.Add("ETA_Dep_1", typeof(string));
            dt.Columns.Add("ATA_Dep_1", typeof(string));
            dt.Columns.Add("Late_Dep_1", typeof(string));

            dt.Columns.Add("Loc_2", typeof(string));
            dt.Columns.Add("Transit_2", typeof(string));
            dt.Columns.Add("STA_Arr_2", typeof(string));
            dt.Columns.Add("ETA_Arr_2", typeof(string));
            dt.Columns.Add("ATA_Arr_2", typeof(string));
            dt.Columns.Add("Late_Arr_2", typeof(string));
            dt.Columns.Add("STA_Dep_2", typeof(string));
            dt.Columns.Add("ETA_Dep_2", typeof(string));
            dt.Columns.Add("ATA_Dep_2", typeof(string));
            dt.Columns.Add("Late_Dep_2", typeof(string));

            dt.Columns.Add("Loc_3", typeof(string));
            dt.Columns.Add("Transit_3", typeof(string));
            dt.Columns.Add("STA_Arr_3", typeof(string));
            dt.Columns.Add("ETA_Arr_3", typeof(string));
            dt.Columns.Add("ATA_Arr_3", typeof(string));
            dt.Columns.Add("Late_Arr_3", typeof(string));
            dt.Columns.Add("STA_Dep_3", typeof(string));
            dt.Columns.Add("ETA_Dep_3", typeof(string));
            dt.Columns.Add("ATA_Dep_3", typeof(string));
            dt.Columns.Add("Late_Dep_3", typeof(string));

            dt.Columns.Add("Loc_4", typeof(string));
            dt.Columns.Add("Transit_4", typeof(string));
            dt.Columns.Add("STA_Arr_4", typeof(string));
            dt.Columns.Add("ETA_Arr_4", typeof(string));
            dt.Columns.Add("ATA_Arr_4", typeof(string));
            dt.Columns.Add("Late_Arr_4", typeof(string));
            dt.Columns.Add("STA_Dep_4", typeof(string));
            dt.Columns.Add("ETA_Dep_4", typeof(string));
            dt.Columns.Add("ATA_Dep_4", typeof(string));
            dt.Columns.Add("Late_Dep_4", typeof(string));

            dt.Columns.Add("Loc_5", typeof(string));
            dt.Columns.Add("Transit_5", typeof(string));
            dt.Columns.Add("STA_Arr_5", typeof(string));
            dt.Columns.Add("ETA_Arr_5", typeof(string));
            dt.Columns.Add("ATA_Arr_5", typeof(string));
            dt.Columns.Add("Late_Arr_5", typeof(string));
            dt.Columns.Add("STA_Dep_5", typeof(string));
            dt.Columns.Add("ETA_Dep_5", typeof(string));
            dt.Columns.Add("ATA_Dep_5", typeof(string));
            dt.Columns.Add("Late_Dep_5", typeof(string));

            dt.Columns.Add("Loc_6", typeof(string));
            dt.Columns.Add("Transit_6", typeof(string));
            dt.Columns.Add("STA_Arr_6", typeof(string));
            dt.Columns.Add("ETA_Arr_6", typeof(string));
            dt.Columns.Add("ATA_Arr_6", typeof(string));
            dt.Columns.Add("Late_Arr_6", typeof(string));
            dt.Columns.Add("STA_Dep_6", typeof(string));
            dt.Columns.Add("ETA_Dep_6", typeof(string));
            dt.Columns.Add("ATA_Dep_6", typeof(string));
            dt.Columns.Add("Late_Dep_6", typeof(string));

            DataRow dr;
            TimeSpan ts;
            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;

                dr["Route_Code"] = drRows["routecd"].ToString();
                dr["Route_Name"] = drRows["routename"].ToString();
                dr["Transit_Hrs"] = drRows["tr_time"].ToString();
                dr["THC_No"] = drRows["THC_Number"].ToString();                
                dr["THC_Dt"] =Convert.ToDateTime(drRows["thc_date"]).ToString("dd MMM yyyy");

                SqlCommand sqlCommand1 = new SqlCommand();
                sqlCommand1.Connection = conn;
                sqlCommand1.CommandType = CommandType.StoredProcedure;
                sqlCommand1.CommandText = "webx_UNI_rut_timeline";                

                sqlCommand1.Parameters.AddWithValue("@thcno", dr["THC_No"].ToString());
                sqlCommand1.Parameters.AddWithValue("@rutnno", "1");

                SqlDataReader dr1 = sqlCommand1.ExecuteReader();

                while (dr1.Read())
                {
                    dr["Loc_Start"] = dr1["sourcehb"];
                    dr["Transit_Start"] = dr1["Transit_Time"];
                    if (dr1["STA"] is DBNull)
                    {
                        dr["STA_Arr_Start"] = "-";
                    }
                    else
                    {
                        dr["STA_Arr_Start"] =dr1["STA"].ToString();
                    }
                    if (dr1["ETA"] is DBNull)
                    {
                        dr["ETA_Arr_Start"] = "-";
                    }
                    else
                    {
                        dr["ETA_Arr_Start"] = dr1["ETA"].ToString();
                    }
                    if (dr1["ATA"] is DBNull)
                    {
                        dr["ATA_Arr_Start"] = "-";
                    }
                    else
                    {
                        dr["ATA_Arr_Start"] = dr1["ATA"].ToString();
                    }
                    if (dr1["STD"] is DBNull)
                    {
                        dr["STA_Dep_Start"] = "-";
                    }
                    else
                    {
                        dr["STA_Dep_Start"] = dr1["STD"].ToString();
                    }
                    if (dr1["ETD"] is DBNull)
                    {
                        dr["ETA_Dep_Start"] = "-";
                    }
                    else
                    {
                        dr["ETA_Dep_Start"] = dr1["ETD"].ToString();
                    }
                    if (dr1["ATD"] is DBNull)
                    {
                        dr["ATA_Dep_Start"] = "-";
                    }
                    else
                    {
                        dr["ATA_Dep_Start"] = dr1["ATD"].ToString();
                    }
                }
                dr1.Close();

                if (dr["STA_Arr_Start"].ToString() == "-" || dr["STA_Arr_Start"].ToString().Trim()=="")
                {
                    dr["Late_Arr_Start"] = "-";
                }
                else
                {
                    SqlCommand sqlCommandt1 = new SqlCommand();
                    sqlCommandt1.Connection = conn;
                    string sqlt1 = "Select round(convert(decimal(12,2),datediff(minute,convert(datetime,'" + dr["STA_Arr_Start"] + "',106),convert(datetime,'" + dr["ATA_Arr_Start"] + "',106))/60.0),2) as Time_Diff";
                    sqlCommandt1 = new SqlCommand(sqlt1, conn);
                    SqlDataReader drt = sqlCommandt1.ExecuteReader();

                    while (drt.Read())
                    {
                        dr["Late_Arr_Start"] = drt["Time_Diff"];
                    }
                    drt.Close();
                }

                if (dr["STA_Dep_Start"].ToString() == "-" || dr["STA_Dep_Start"].ToString() == "")
                {
                    dr["Late_Dep_Start"] = "-";
                }
                else
                {
                    SqlCommand sqlCommandt2 = new SqlCommand();
                    sqlCommandt2.Connection = conn;
                    string sqlt2 = "Select round(convert(decimal(12,2),datediff(minute,'" + dr["STA_Arr_Start"] + "','" + dr["ATA_Arr_Start"] + "')/60.0),2) as Time_Diff";
                    sqlCommandt2 = new SqlCommand(sqlt2, conn);
                    SqlDataReader drt2 = sqlCommandt2.ExecuteReader();

                    while (drt2.Read())
                    {
                        dr["Late_Dep_Start"] = drt2["Time_Diff"];
                    }
                    drt2.Close();

                }

                SqlCommand sqlCommand2 = new SqlCommand();
                sqlCommand2.Connection = conn;
                sqlCommand2.CommandType = CommandType.StoredProcedure;                
                sqlCommand2.CommandText = "webx_rut_timeline";

                sqlCommand2.Parameters.AddWithValue("@thcno", dr["THC_No"].ToString());
                sqlCommand2.Parameters.AddWithValue("@rutnno", "2");
                SqlDataReader dr2 = sqlCommand2.ExecuteReader();

                while (dr2.Read())
                {
                    dr["Loc_1"] = dr2["sourcehb"];
                    dr["Transit_1"] = dr2["Transit_Time"];
                    if (dr2["STA"] is DBNull)
                    {
                        dr["STA_Arr_1"] = "-";
                    }
                    else
                    {
                        dr["STA_Arr_1"] = dr2["STA"].ToString();
                    }
                    if (dr2["ETA"] is DBNull)
                    {
                        dr["ETA_Arr_1"] = "-";
                    }
                    else
                    {
                        dr["ETA_Arr_1"] = dr2["ETA"].ToString();
                    }
                    if (dr2["ATA"] is DBNull)
                    {
                        dr["ATA_Arr_1"] = "-";
                    }
                    else
                    {
                        dr["ATA_Arr_1"] = dr2["ATA"].ToString();
                    }
                    if (dr2["STD"] is DBNull)
                    {
                        dr["STA_Dep_1"] = "-";
                    }
                    else
                    {
                        dr["STA_Dep_1"] = dr2["STD"].ToString();
                    }
                    if (dr2["ETD"] is DBNull)
                    {
                        dr["ETA_Dep_1"] = "-";
                    }
                    else
                    {
                        dr["ETA_Dep_1"] = dr2["ETD"].ToString();
                    }
                    if (dr2["ATD"] is DBNull)
                    {
                        dr["ATA_Dep_1"] = "-";
                    }
                    else
                    {
                        dr["ATA_Dep_1"] = dr2["ATD"].ToString();
                    }
                    
                }
                dr2.Close();
                dr["Late_Arr_1"] = "";
                dr["Late_Dep_1"] = "";

                SqlCommand sqlCommand3 = new SqlCommand();
                sqlCommand3.Connection = conn;
                sqlCommand3.CommandType = CommandType.StoredProcedure;                
                sqlCommand3.CommandText = "webx_rut_timeline";

                sqlCommand3.Parameters.AddWithValue("@thcno", dr["THC_No"].ToString());
                sqlCommand3.Parameters.AddWithValue("@rutnno", "3");
                SqlDataReader dr3 = sqlCommand3.ExecuteReader();

                while (dr3.Read())
                {
                    dr["Loc_2"] = dr3["sourcehb"];
                    dr["Transit_2"] = dr3["Transit_Time"];
                    if (dr3["STA"] is DBNull)
                    {
                        dr["STA_Arr_2"] = "-";
                    }
                    else
                    {
                        dr["STA_Arr_2"] = dr3["STA"].ToString();
                    }
                    if (dr3["ETA"] is DBNull)
                    {
                        dr["ETA_Arr_2"] = "-";
                    }
                    else
                    {
                        dr["ETA_Arr_2"] = dr3["ETA"].ToString();
                    }
                    if (dr3["ATA"] is DBNull)
                    {
                        dr["ATA_Arr_2"] = "-";
                    }
                    else
                    {
                        dr["ATA_Arr_2"] = dr3["ATA"].ToString();
                    }
                    if (dr3["STD"] is DBNull)
                    {
                        dr["STA_Dep_2"] = "-";
                    }
                    else
                    {
                        dr["STA_Dep_2"] = dr3["STD"].ToString();
                    }
                    if (dr3["ETD"] is DBNull)
                    {
                        dr["ETA_Dep_2"] = "-";
                    }
                    else
                    {
                        dr["ETA_Dep_2"] = dr3["ETD"].ToString();
                    }
                    if (dr3["ATD"] is DBNull)
                    {
                        dr["ATA_Dep_2"] = "-";
                    }
                    else
                    {
                        dr["ATA_Dep_2"] = dr3["ATD"].ToString();
                    }
                   
                }
                dr3.Close();
                dr["Late_Arr_2"] = "";
                dr["Late_Dep_2"] = "";


                SqlCommand sqlCommand4 = new SqlCommand();
                sqlCommand4.Connection = conn;
                sqlCommand4.CommandType = CommandType.StoredProcedure;                
                sqlCommand4.CommandText = "webx_rut_timeline";

                sqlCommand4.Parameters.AddWithValue("@thcno", dr["THC_No"].ToString());
                sqlCommand4.Parameters.AddWithValue("@rutnno", "4");
                SqlDataReader dr4 = sqlCommand4.ExecuteReader();

                while (dr4.Read())
                {
                    dr["Loc_3"] = dr4["sourcehb"];
                    dr["Transit_3"] = dr4["Transit_Time"];
                    if (dr4["STA"] is DBNull)
                    {
                        dr["STA_Arr_3"] = "-";
                    }
                    else
                    {
                        dr["STA_Arr_3"] = dr4["STA"].ToString();
                    }
                    if (dr4["ETA"] is DBNull)
                    {
                        dr["ETA_Arr_3"]="-";
                    }
                    else
                    {
                        dr["ETA_Arr_3"] = dr4["ETA"].ToString();
                    }
                    if (dr4["ATA"] is DBNull)
                    {
                        dr["ATA_Arr_3"] = "-";
                    }
                    else
                    {
                        dr["ATA_Arr_3"] = dr4["ATA"].ToString();
                    }
                    if (dr4["STD"] is DBNull)
                    {
                        dr["STA_Dep_3"] = "-";
                    }
                    else
                    {
                        dr["STA_Dep_3"] = dr4["STD"].ToString();
                    }
                    if (dr4["ETD"] is DBNull)
                    {
                        dr["ETA_Dep_3"] = "-";
                    }
                    else
                    {
                        dr["ETA_Dep_3"] = dr4["ETD"].ToString();
                    }
                    if (dr4["ATD"] is DBNull)
                    {
                        dr["ATA_Dep_3"] = "-";
                    }
                    else
                    {
                        dr["ATA_Dep_3"] = dr4["ATD"].ToString();
                    }                    
                }
                dr4.Close();
                dr["Late_Arr_3"] = "";
                dr["Late_Dep_3"] = "";

                SqlCommand sqlCommand5 = new SqlCommand();
                sqlCommand5.Connection = conn;
                sqlCommand5.CommandType = CommandType.StoredProcedure;                
                sqlCommand5.CommandText = "webx_rut_timeline";

                sqlCommand5.Parameters.AddWithValue("@thcno", dr["THC_No"].ToString());
                sqlCommand5.Parameters.AddWithValue("@rutnno", "5");
                SqlDataReader dr5 = sqlCommand5.ExecuteReader();

                while (dr5.Read())
                {
                    dr["Loc_4"] = dr5["sourcehb"];
                    dr["Transit_4"] = dr5["Transit_Time"];
                    if (dr5["STA"] is DBNull)
                    {
                        dr["STA_Arr_4"] = "-";
                    }
                    else
                    {
                        dr["STA_Arr_4"] = dr5["STA"].ToString();
                    }
                    if (dr5["ETA"] is DBNull)
                    {
                        dr["ETA_Arr_4"] = "-";
                    }
                    else
                    {
                        dr["ETA_Arr_4"] = dr5["ETA"].ToString();
                    }
                    if (dr5["ATA"] is DBNull)
                    {
                        dr["ATA_Arr_4"] = "-";
                    }
                    else
                    {
                        dr["ATA_Arr_4"] = dr5["ATA"].ToString();
                    }
                    if (dr5["STD"] is DBNull)
                    {
                        dr["STA_Dep_4"] = "-";
                    }
                    else
                    {
                        dr["STA_Dep_4"] = dr5["STD"].ToString();
                    }
                    if (dr5["ETD"] is DBNull)
                    {
                        dr["ETA_Dep_4"] = "-";
                    }
                    else
                    {
                        dr["ETA_Dep_4"] = dr5["ETD"].ToString();
                    }
                    if (dr5["ATD"] is DBNull)
                    {
                        dr["ATA_Dep_4"] = "-";
                    }
                    else
                    {
                        dr["ATA_Dep_4"] = dr5["ATD"].ToString();
                    }
                    
                }
                dr5.Close();
                dr["Late_Arr_4"] = "";
                dr["Late_Dep_4"] = "";

                SqlCommand sqlCommand6 = new SqlCommand();
                sqlCommand6.Connection = conn;
                sqlCommand6.CommandType = CommandType.StoredProcedure;                
                sqlCommand6.CommandText = "webx_rut_timeline";

                sqlCommand6.Parameters.AddWithValue("@thcno", dr["THC_No"].ToString());
                sqlCommand6.Parameters.AddWithValue("@rutnno", "6");
                SqlDataReader dr6 = sqlCommand6.ExecuteReader();

                while (dr6.Read())
                {
                    dr["Loc_5"] = dr6["sourcehb"];
                    dr["Transit_5"] = dr6["Transit_Time"];
                    if (dr6["STA"] is DBNull)
                    {
                        dr["STA_Arr_5"] = "-";
                    }
                    else
                    {
                        dr["STA_Arr_5"] = dr6["STA"].ToString();
                    }
                    if (dr6["ETA"] is DBNull)
                    {
                        dr["ETA_Arr_5"] = "-";
                    }
                    else
                    {
                        dr["ETA_Arr_5"] = dr6["ETA"].ToString();
                    }
                    if (dr6["ATA"] is DBNull)
                    {
                        dr["ATA_Arr_5"] = "-";
                    }
                    else
                    {
                        dr["ATA_Arr_5"] = dr6["ATA"].ToString();
                    }
                    if (dr6["STD"] is DBNull)
                    {
                        dr["STA_Dep_5"] = "-";
                    }
                    else
                    {
                        dr["STA_Dep_5"] = dr6["STD"].ToString();
                    }
                    if (dr6["ETD"] is DBNull)
                    {
                        dr["ETA_Dep_5"] = "-";
                    }
                    else
                    {
                        dr["ETA_Dep_5"] = dr6["ETD"].ToString();
                    }
                    if (dr6["ATD"] is DBNull)
                    {
                        dr["ATA_Dep_5"] = "-";
                    }
                    else
                    {
                        dr["ATA_Dep_5"] = dr6["ATD"].ToString();
                    }
                }
                dr6.Close();
                dr["Late_Arr_5"] = "";
                dr["Late_Dep_5"] = "";


                SqlCommand sqlCommand7 = new SqlCommand();
                sqlCommand7.Connection = conn;
                sqlCommand7.CommandType = CommandType.StoredProcedure;                
                sqlCommand7.CommandText = "webx_rut_timeline";

                sqlCommand7.Parameters.AddWithValue("@thcno", dr["THC_No"].ToString());
                sqlCommand7.Parameters.AddWithValue("@rutnno", "7");
                SqlDataReader dr7 = sqlCommand7.ExecuteReader();

                while (dr7.Read())
                {
                    dr["Loc_6"] = dr7["sourcehb"];
                    dr["Transit_6"] = dr7["Transit_Time"];
                    if (dr7["STA"] is DBNull)
                    {
                        dr["STA_Arr_6"] = "-";
                    }
                    else
                    {
                        dr["STA_Arr_6"] = dr7["STA"].ToString();
                    }
                    if (dr7["ETA"] is DBNull)
                    {
                        dr["ETA_Arr_6"] = "-";
                    }
                    else
                    {
                        dr["ETA_Arr_6"] = dr7["ETA"].ToString();
                    }
                    if (dr7["ATA"] is DBNull)
                    {
                        dr["ATA_Arr_6"] = "-";
                    }
                    else
                    {
                        dr["ATA_Arr_6"] = dr7["ATA"].ToString();
                    }
                    if (dr7["STD"] is DBNull)
                    {
                        dr["STA_Dep_6"] = "-";
                    }
                    else
                    {
                        dr["STA_Dep_6"] = dr7["STD"].ToString();
                    }
                    if (dr7["ETD"] is DBNull)
                    {
                        dr["ETA_Dep_6"] = "-";
                    }
                    else
                    {
                        dr["ETA_Dep_6"] = dr7["ETD"].ToString();
                    }
                    if (dr7["ATD"] is DBNull)
                    {
                        dr["ATA_Dep_6"] = "-";
                    }
                    else
                    {
                        dr["ATA_Dep_6"] = dr7["ATD"].ToString();
                    }                    
                }
                dr7.Close();
                dr["Late_Arr_6"] = "";
                dr["Late_Dep_6"] = "";

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
