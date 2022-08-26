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

public partial class Issue_frmAddJourneyVehicleIssueSlip : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.RequestDetRow datarow;
    DataSet ds;
    DataView dv;

    string strOrgnCity, strOrgnLoc, strStartDt, strVehType;
    string strPassNo;
    string strReqDt, strDestnCity, strEndDt;
    string strReqId, strReqBy;

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
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            //DtCal.SetCalenderText(strrightnow);

            InitializeData();
            BindGrid();



            conn.Open();
            string sql = "usp_VehicleIssueList";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            sqlcmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            da.SelectCommand.Parameters.Add("@VSlipId", SqlDbType.VarChar).Value = "";
            da.SelectCommand.Parameters.Add("@VSlipFromDt", SqlDbType.DateTime).Value = "01/01/1900";
            da.SelectCommand.Parameters.Add("@VSlipToDt", SqlDbType.DateTime).Value = "01/01/2050";

            ds = new DataSet();
            da.Fill(ds);
            dv = ds.Tables[0].DefaultView;

            cboIssueSlipNo.DataTextField = "VSlipNo";
            cboIssueSlipNo.DataValueField = "VSlipNo";
            cboIssueSlipNo.DataSource = dv;
            cboIssueSlipNo.DataBind();
            cboIssueSlipNo.Items.Insert(0, "");

            conn.Close();



           

        }
    }

    protected void DisplayIssueDt(object sender, EventArgs e)
    {
        conn.Open();
        string sql = "usp_VehicleIssueList";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        sqlcmd.Parameters.Add("@VSlipId", SqlDbType.VarChar).Value = cboIssueSlipNo.SelectedItem.Value;
        sqlcmd.Parameters.Add("@VSlipFromDt", SqlDbType.DateTime).Value = "01/01/1900";
        if (cboIssueSlipNo.SelectedItem.Value != "")
        {
            sqlcmd.Parameters.Add("@VSlipToDt", SqlDbType.DateTime).Value = "01/01/2050";
        }
        else
        {
            sqlcmd.Parameters.Add("@VSlipToDt", SqlDbType.DateTime).Value = "01/01/1900";
        }

        SqlDataReader dr = sqlcmd.ExecuteReader();

        if (dr.Read())
        {
            lblIssueDt.Text = dr["VSlipDt"].ToString();
            lblVehno.Text = dr["VehicleNo"].ToString();
            lblDriver.Text = dr["DriverName"].ToString();
            lblLicno.Text = dr["License_No"].ToString();
            lblValidDt.Text = dr["Valdity_dt"].ToString();
        }
        else
        {
            lblIssueDt.Text = "";
            lblVehno.Text ="";
            lblDriver.Text= "";
            lblLicno.Text = "";
            lblValidDt.Text = "";
        }

        conn.Close();

    }

    

    private void BindGrid()
    {
        DataGrid1.DataSource = _dataSet.RequestDet;
        DataGrid1.DataBind();
        _lastEditedPage = DataGrid1.CurrentPageIndex;
    }

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }
    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((MyFleetDataSet.RequestDetRow)((DataRowView)e.Item.DataItem).Row);
            /*DataSet ds = new DataSet();
            string strReqId = datarow.RequestId;
            string str = "select R.Request_Id,V.vehno from webx_fleet_vehicle_request R,webx_vehicle_hdr V where 1=1 and R.Vehtype=Vehicle_type and  R.VehClass=V.Veh_class and R.AC_NONAC=V.Sub_Cat and (V.Vehicle_Status='Available' or V.Vehicle_Status is null) and Request_Id='" + strReqId + "'";
            DropDownList dlst = ((DropDownList)e.Item.FindControl("cboVehno"));
            SqlDataAdapter da = new SqlDataAdapter(str, conn);
            da.Fill(ds);
            dlst.DataSource = ds;
            dlst.DataTextField = "vehno";
            dlst.DataValueField = "vehno";
            dlst.DataBind();
            dlst.Items.Insert(0, "Select");
            dlst.Items[0].Selected = true;*/
        }


        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((MyFleetDataSet.RequestDetRow)((DataRowView)e.Item.DataItem).Row);

            if (e.Item.ItemIndex >= -1)
            {
                string strSelRadio = ((RadioButton)e.Item.FindControl("chksel")).ClientID;
                ((RadioButton)e.Item.FindControl("chksel")).Attributes.Add("onClick", "fnCheckSel('" + strSelRadio + "')");
            }
            //((CheckBox)e.Item.FindControl("chksel")).Checked = datarow.Chksel;
            ((RadioButton)e.Item.FindControl("chksel")).Checked = datarow.Chksel;
            ((TextBox)e.Item.FindControl("txtReqId")).Text = datarow.RequestId;
            ((TextBox)e.Item.FindControl("txtReqBy")).Text = datarow.Request_By;
            ((TextBox)e.Item.FindControl("txtReqDt")).Text = datarow.Request_Dt;
            ((TextBox)e.Item.FindControl("txtOrgnCity")).Text = datarow.Orgn_City;
            ((TextBox)e.Item.FindControl("txtDestnCity")).Text = datarow.Destn_City;

            ((TextBox)e.Item.FindControl("txtStDt")).Text = datarow.Start_Dt;
            ((TextBox)e.Item.FindControl("txtEdDt")).Text = datarow.End_Dt;
            ((TextBox)e.Item.FindControl("txtPassNo")).Text = datarow.Pass_No;
            ((TextBox)e.Item.FindControl("txtVehType")).Text = datarow.Vehtype;
            //((DropDownList)e.Item.FindControl("cboVehno")).SelectedItem.Value = datarow.Vehno;





        }
    }


    public void InitializeData()
    {


        lblDataError.Text = "";
        string DataFound = "N";
        strOrgnCity = ""; strOrgnLoc = ""; strStartDt = ""; strVehType = "";
        strReqDt = "";
        strDestnCity = ""; strPassNo = "0";
        strReqId = ""; strReqBy = "";
        SqlCommand cmdREQ = new SqlCommand("usp_RequestListForIssue", conn);
        cmdREQ.CommandType = CommandType.StoredProcedure;


        //strReqId = Page.Request.Form[];
        //strReqFromDt = Page.Request.Form["txtDateFrom"];
        //strReqToDt = Page.Request.Form["txtDateTo"];
        //strReqFromDt=PreviousPage.txtDateFrom;
        //strReqToDt = PreviousPage.txtDateTo;



        strStartDt = Request.QueryString["StartDt"].ToString().Trim();
        strOrgnCity = Request.QueryString["OrgnCity"].ToString().Trim();
        strOrgnLoc = Request.QueryString["OrgnLoc"].ToString().Trim();
        if (strOrgnLoc == "" || strOrgnLoc == null)
        {
            strOrgnLoc = "";
        }
        strVehType = Request.QueryString["VehType"].ToString().Trim();
        strPassNo = Request.QueryString["Pass_no"].ToString().Trim();

        cmdREQ.Parameters.AddWithValue("@StartDt", strStartDt);
        cmdREQ.Parameters.AddWithValue("@OrgnCity", strOrgnCity);
        cmdREQ.Parameters.AddWithValue("@OrgnLoc", strOrgnLoc);
        cmdREQ.Parameters.AddWithValue("@VehType", strVehType);
        cmdREQ.Parameters.AddWithValue("@Pass_No", strPassNo);
        cmdREQ.Parameters.AddWithValue("@ReqId", strReqId);

        conn.Open();
        SqlDataReader dataReadREQ = cmdREQ.ExecuteReader();


        while (dataReadREQ.Read())
        {
            DataFound = "Y";
            strReqId = dataReadREQ["Request_Id"].ToString();
            strReqBy = dataReadREQ["Request_By"].ToString();
            strReqDt = dataReadREQ["Request_dt"].ToString();
            strOrgnCity = dataReadREQ["Orgn_city"].ToString();
            strDestnCity = dataReadREQ["Destn_city"].ToString();
            strStartDt = dataReadREQ["Start_date_time"].ToString();
            strEndDt = dataReadREQ["End_dt_tm"].ToString();
            strPassNo = dataReadREQ["No_Passenger"].ToString();
            strVehType = dataReadREQ["Vehtype"].ToString();

            _dataSet.RequestDet.AddRequestDetRow(false, strReqId, strReqBy, strReqDt, strOrgnCity, strDestnCity, strStartDt, strEndDt, strPassNo, strVehType, "", "");


        }

        dataReadREQ.Close();
        conn.Close();

        if (DataFound == "N")
        {
            lblDataError.Text = "No Request Found !!!";
        }

    }

    protected void SubmitData(object sender, EventArgs e)
    {
        string ErrMsg = "";
        string strReqId = "";
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";


        DateTime righnow = System.DateTime.Today;
        dtfi.DateSeparator = "/";
        righnow = Convert.ToDateTime(righnow, dtfi);


        DateTime dtIssueDt = new DateTime();
        //dtIssueDt = Convert.ToDateTime(DtCal.CalenderText(), dtfi);
        if (dtIssueDt > righnow)
        {
            if (ErrMsg == "")
            {
                ErrMsg = "Error : Issue Date can not be greater than system date.Please check !!!";
            }
        }

        //string strcboVehno = "";
        string strSelFlag = "False";
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            bool strChkSel = ((CheckBox)(gridrow.FindControl("chksel"))).Checked;


            if (strChkSel == true)
            {
                strSelFlag = "True";
                strReqId = ((TextBox)(gridrow.FindControl("txtReqId"))).Text;
            }
        }

        if (ErrMsg == "")
        {
            if (strSelFlag == "False")
            {
                ErrMsg = "Error : Atleast on request has to be selected, please check !!!";
            }
        }


        lblError.Text = ErrMsg;
        if (lblError.Text == "")
        {






            

            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {

                


                foreach (DataGridItem gridrow in DataGrid1.Items)
                {
                    SqlCommand Detail = new SqlCommand("usp_UpdateRequestVehicleIssue", conn, trans);
                    Detail.CommandType = CommandType.StoredProcedure;

                    bool strChkSel = ((CheckBox)(gridrow.FindControl("chksel"))).Checked;
                    if (strChkSel == true)
                    {
                        strSelFlag = "True";
                        strReqId = ((TextBox)(gridrow.FindControl("txtReqId"))).Text;
                    }


                    datarow = _dataSet.RequestDet[gridrow.DataSetIndex];

                    if (strChkSel == true)
                    {
                        Detail.Parameters.Add("@ReqId", SqlDbType.VarChar).Value = strReqId.Trim();
                        Detail.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = cboIssueSlipNo.SelectedItem.Value.Trim();
                        Detail.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = lblVehno.Text.Trim();
                        Detail.Parameters.Add("@Start_km", SqlDbType.VarChar).Value = txtStartKM.Text.ToString().Trim();
                        Detail.Parameters.Add("@End_km", SqlDbType.VarChar).Value = "";
                        Detail.Parameters.Add("@End_dt", SqlDbType.DateTime).Value = Convert.ToDateTime("01/01/1900", dtfi);
                        Detail.Parameters.Add("@End_tm", SqlDbType.VarChar).Value = "";
                        Detail.Parameters.Add("@IssueMode", SqlDbType.VarChar).Value = "START";

                        _dataSet.RequestDet[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;

                        Detail.ExecuteNonQuery();
                    }
                }
                trans.Commit();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                Response.Redirect("frmAddJourneyVehicleIssueSlip_result.aspx?VSlipId=" + cboIssueSlipNo.SelectedItem.Value.Trim() + "&ReqId=" + strReqId.ToString().Trim(), true);

            }
            //Response.Redirect("frmVehicleIssueSlipNewNext.aspx?ReqId=" + strReqId + "&IssueDt=" + DtCal.CalenderText());
            
        }
    }
}
