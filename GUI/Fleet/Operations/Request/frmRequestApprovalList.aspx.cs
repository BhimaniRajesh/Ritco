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

public partial class Request_frmRequestApprovalList : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.RequestDetRow datarow;
    string strReqId, strReqBy, strReqFromDt, strReqToDt, strOrgnCity, strOrgnLoc, strStartDt, strVehType;
    string strReqDt, strDestnCity, strPassNo, strEndDt;
        
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            

            btnConfirm.Attributes.Add("onclick", "return confirm('Are you sure you want to Confirm requests?')");
            btnReject.Attributes.Add("onclick", "return confirm('Are you sure you want to Reject requests?')");


            
            
            InitializeData();
            BindGrid();
        }
        else
        {
            //ReverseBind();
        }
    }
    private void ReverseBind()
    {
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            datarow.Chksel = ((CheckBox)gridrow.FindControl("chksel")).Checked;
            datarow.RequestId=((TextBox)gridrow.FindControl("txtReqId")).Text;
            datarow.Request_By=((TextBox)gridrow.FindControl("txtReqBy")).Text;
            datarow.Request_Dt=((TextBox)gridrow.FindControl("txtReqDt")).Text;
            datarow.Orgn_City=((TextBox)gridrow.FindControl("txtOrgnCity")).Text  ;
            datarow.Destn_City=((TextBox)gridrow.FindControl("txtDestnCity")).Text;

            datarow.Start_Dt=((TextBox)gridrow.FindControl("txtStDt")).Text;
            datarow.End_Dt=((TextBox)gridrow.FindControl("txtEdDt")).Text;
            datarow.Pass_No=((TextBox)gridrow.FindControl("txtPassNo")).Text;
            datarow.Vehtype=((TextBox)gridrow.FindControl("txtVehType")).Text;
        }
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

    public void InitializeData()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        lblError.Text = "";
        string DataFound = "N";
        strReqId = ""; strReqBy = ""; strReqFromDt = ""; strReqToDt = ""; strOrgnCity = ""; strOrgnLoc = ""; strStartDt = ""; strVehType = "";
        strReqDt = "";
        strDestnCity = ""; strPassNo = "";
        SqlCommand cmdREQ = new SqlCommand("usp_RequestList", conn);
        cmdREQ.CommandType = CommandType.StoredProcedure;


        //strReqId = Page.Request.Form[];
        //strReqFromDt = Page.Request.Form["txtDateFrom"];
        //strReqToDt = Page.Request.Form["txtDateTo"];
        //strReqFromDt=PreviousPage.txtDateFrom;
        //strReqToDt = PreviousPage.txtDateTo;


        strReqId = Request.QueryString["RequestId"].ToString().Trim();
        strReqFromDt = Request.QueryString["FromDt"].ToString().Trim();
        strReqToDt = Request.QueryString["ToDt"].ToString().Trim();
        strReqBy = Request.QueryString["RequestBy"].ToString().Trim();
        strStartDt = Request.QueryString["StartDt"].ToString().Trim();
        strOrgnCity = Request.QueryString["OrgnCity"].ToString().Trim();
        strOrgnLoc = Request.QueryString["OrgnLoc"].ToString().Trim();
        strVehType = Request.QueryString["VehType"].ToString().Trim();
        //strval = "FromDt=" + txtDateFrom.Text.Trim() + "&ToDt=" + txtDateTo.Text.Trim() + "&RequestId=" + txtRequestID.Text.Trim() + "&RequestBy=" + txtRequestBy.Text.Trim() + "&StartDt=" + DtCal.ToString() + "&OrgnCity=" + cboOrgnCity.SelectedItem.Value + "&OrgnLoc=" + cboOrgnLoc.SelectedItem.Value + "&VehType=" + cboVehType.SelectedItem.Value;



        cmdREQ.Parameters.AddWithValue("@ReqId", strReqId);
        cmdREQ.Parameters.AddWithValue("@ReqBy", strReqBy);
        cmdREQ.Parameters.AddWithValue("@ReqFromDt", strReqFromDt);
        cmdREQ.Parameters.AddWithValue("@ReqToDt", strReqToDt);
        cmdREQ.Parameters.AddWithValue("@OrgnCity", strOrgnCity);
        cmdREQ.Parameters.AddWithValue("@OrgnLoc", strOrgnLoc);
        cmdREQ.Parameters.AddWithValue("@StartDt", strStartDt);
        cmdREQ.Parameters.AddWithValue("@VehType", strVehType);
   
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

                _dataSet.RequestDet.AddRequestDetRow(false, strReqId, strReqBy, strReqDt, strOrgnCity, strDestnCity, strStartDt, strEndDt, strPassNo, strVehType,"","");
                
                
            }
        
        dataReadREQ.Close();
        conn.Close();

        if (DataFound == "N")
        {
            btnConfirm.Visible = false;
            btnReject.Visible = false;
            lblError.Text = "No Data Found !!!";
        }

    }


    protected void DataGrid1_ItemCommand(object source, DataGridCommandEventArgs e)
    {

    }

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((MyFleetDataSet.RequestDetRow)((DataRowView)e.Item.DataItem).Row);
            ((CheckBox)e.Item.FindControl("chksel")).Checked = datarow.Chksel;
            ((TextBox)e.Item.FindControl("txtReqId")).Text = datarow.RequestId;
            ((TextBox)e.Item.FindControl("txtReqBy")).Text = datarow.Request_By;
            ((TextBox)e.Item.FindControl("txtReqDt")).Text = datarow.Request_Dt;
            ((TextBox)e.Item.FindControl("txtOrgnCity")).Text = datarow.Orgn_City;
            ((TextBox)e.Item.FindControl("txtDestnCity")).Text = datarow.Destn_City;

            ((TextBox)e.Item.FindControl("txtStDt")).Text = datarow.Start_Dt;
            ((TextBox)e.Item.FindControl("txtEdDt")).Text = datarow.End_Dt;
            //((TextBox)e.Item.FindControl("txtPassNo")).Text = datarow.Pass_No;
            ((TextBox)e.Item.FindControl("txtVehType")).Text = datarow.Vehtype;

            
        } 
    }

    protected void SubmitData_Confirm(object sender, EventArgs e)
    {

        string mSelectionFlag = "N";
        MyFleetDataSet.RequestDetRow datarow;
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {

            bool strChkSel = ((CheckBox)(gridrow.FindControl("chksel"))).Checked;
            datarow = _dataSet.RequestDet[gridrow.DataSetIndex];

            if (strChkSel == true)
            {
                mSelectionFlag = "Y";
            }
        }

        if (mSelectionFlag == "Y")
        {
            string tmpRequest_Mode = "C";
            SubmitData_Confirm_Reject(tmpRequest_Mode);
            Response.Redirect("frmRequestApprovalDone.aspx?Request_Mode=" + tmpRequest_Mode);
        }
        else
        {
            lblError.Text = "Please select atleast one request to confirm !!!";
        }
        
        
    }

    protected void SubmitData_Reject(object sender, EventArgs e)
    {
        string mSelectionFlag = "N";
        MyFleetDataSet.RequestDetRow datarow;
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {

            bool strChkSel = ((CheckBox)(gridrow.FindControl("chksel"))).Checked;
            datarow = _dataSet.RequestDet[gridrow.DataSetIndex];

            if (strChkSel == true)
            {
                mSelectionFlag = "Y";
            }
        }

        if (mSelectionFlag == "Y")
        {
                string tmpRequest_Mode = "R";
                SubmitData_Confirm_Reject(tmpRequest_Mode);
                Response.Redirect("frmRequestApprovalDone.aspx?Request_Mode=" + tmpRequest_Mode);
         }
        else
         {
                lblError.Text = "Please select atleast one request to reject !!!";
          }
        
    }

    public void SubmitData_Confirm_Reject(string mRequest_Mode)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        MyFleetDataSet.RequestDetRow datarow;
        
        conn.Open();

        foreach (DataGridItem gridrow in DataGrid1.Items)
        {

            bool strChkSel = ((CheckBox)(gridrow.FindControl("chksel"))).Checked;
            string strReqId = ((TextBox)(gridrow.FindControl("txtReqId"))).Text;
            datarow = _dataSet.RequestDet[gridrow.DataSetIndex];

            if (strChkSel == true)
            {
                SqlCommand sqlcmdCR = new SqlCommand("usp_Request_Confirm_Reject", conn);
                sqlcmdCR.CommandType = CommandType.StoredProcedure;

                sqlcmdCR.Parameters.Add("@Request_Id", SqlDbType.VarChar).Value = strReqId;
                sqlcmdCR.Parameters.Add("@Request_Mode", SqlDbType.VarChar).Value = mRequest_Mode;
                sqlcmdCR.ExecuteNonQuery();

                _dataSet.RequestDet[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
            }
        }
        conn.Close();
        
    }
}


