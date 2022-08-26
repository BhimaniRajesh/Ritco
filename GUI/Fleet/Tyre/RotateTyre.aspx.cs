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
public partial class TYRE1_MountTyre : System.Web.UI.Page
{
 //   SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.TyreIssueRow datarow;
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
       
        if (!IsPostBack)
        {
            //btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../GUI/popups/VehicleNo.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km="+ hfkm.ClientID.ToString() +"',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../GUI/popups/VehicleNo_TyreRotate.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km=" + txtKm.ClientID.ToString() + "&vehcat=" + hfVehcate.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            //img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDate.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDate.ClientID + @"\')')");
            txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo("+ txtVehNo.ClientID.ToString() +","+ hfVehIntId.ClientID.ToString() +","+ txtKm.ClientID.ToString()  +");");
        }
        string script;
        script = @"<SCRIPT language='javascript'> func();" + "</SCRIPT>";
        this.RegisterStartupScript("MyAlert", script);
    }

    public void BindGrid()
    {
        string strSQL = "SELECT TM.TYRE_ID,TM.TYREPOS_ID,TP.TYREPOS_CODE,(SELECT CODEDESC FROM Webx_Master_General WHERE CODETYPE='TYPOS' AND CODEID=TP.POS_ALLOWED) AS POSALLOWED,TP.POS_ALLOWED,(SELECT CODEDESC FROM Webx_Master_General WHERE CODETYPE='TYCAT' AND CODEID=TYRE_CATEGORY) AS TYRE_CATEGORY,* FROM WEBX_FLEET_TYREMST AS TM INNER JOIN WEBX_FLEET_TYREPOS AS TP ON TM.TYREPOS_ID=TP.TYREPOS_ID WHERE TM.[TYRE_STATUS]='Mounted' AND VEH_INTERNAL_NO =" + hfVehIntId.Value + "";
        SqlDataAdapter adp = new SqlDataAdapter(strSQL, conn);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count != 0)
        {
            gvTyreRoate.DataSource = ds;
            gvTyreRoate.DataBind();
            foreach (GridViewRow row in gvTyreRoate.Rows)
            {
                HiddenField hfCurrentTyrePos = (HiddenField)row.FindControl("hfCurrentTyrePos");
                hfCurrentTyrePos.Value = ds.Tables[0].Rows[row.RowIndex]["TYREPOS_ID"].ToString();
                HiddenField hfTyrePosAllowed = (HiddenField)row.FindControl("hfTyrePosAllowed");
                hfTyrePosAllowed.Value = ds.Tables[0].Rows[row.RowIndex]["POSALLOWED"].ToString();
                DropDownList ddlNewTyrePos = (DropDownList)row.FindControl("ddlNewTyrePos");
                BindDropDown("usp_Bind_TyrePos_TyreMst", "TYREPOS_CODE", "TYREPOS_ID", ddlNewTyrePos, "");
            }
        }
        else
        {
            gvTyreRoate.DataSource = ds;
            gvTyreRoate.DataBind();
        }
    }
   
    protected void gvTyreRoate_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (gvTyreRoate.Rows.Count != 0)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlNewTyrePos = (DropDownList)e.Row.FindControl("ddlNewTyrePos");
                HiddenField hfTyreId = (HiddenField)e.Row.FindControl("hfTyreId");
                HiddenField hfTyrePosAllowed = (HiddenField)e.Row.FindControl("hfTyrePosAllowed");
                //BindDropDown("USP_TYREPOSITION", "TYREPOS_CODE", "TYREPOS_ID", ddlNewTyrePos);
                BindDropDown("usp_Bind_TyrePos_TyreMst", "TYREPOS_CODE", "TYREPOS_ID", ddlNewTyrePos, "");


                HiddenField hfTyreCategory = (HiddenField)e.Row.FindControl("hfTyreCategory");
                ddlNewTyrePos.Attributes.Add("onChange", "return CheckTyrePosFront(" + e.Row.RowIndex + "," + ddlNewTyrePos.ClientID.ToString() + "," + hfTyrePosAllowed.ClientID.ToString() + "," + hfTyreId.ClientID.ToString() + "," + hfTyreCategory.ClientID.ToString() + ");");


            }
        }
    }   
    public void BindDropDown(string strProc, string text, string value, DropDownList d,string strValue)
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        d.Items.Clear();
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (strProc == "usp_Bind_TyrePos_TyreMst")
        {
            cmd.Parameters.AddWithValue("@VEHNO", hfVehIntId.Value);
            cmd.Parameters.AddWithValue("@POS_ALLOWED", strValue.ToString().Trim());
        }
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_TYREROTATE_INSERTUPDATE", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@ROTATE_DATE", SqlDbType.VarChar).Value = txtDate.Text;
        da.SelectCommand.Parameters.Add("@VEH_NO", SqlDbType.Int).Value = hfVehIntId.Value;
        da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToUpper().Trim();

        cmd.ExecuteNonQuery();
        conn.Close();

        foreach (GridViewRow row in gvTyreRoate.Rows)
        {
            DropDownList ddlNewTyrePos = (DropDownList)gvTyreRoate.Rows[row.RowIndex].FindControl("ddlNewTyrePos");
            HiddenField hfCurrentTyrePos = (HiddenField)gvTyreRoate.Rows[row.RowIndex].FindControl("hfCurrentTyrePos");
            HiddenField hfTyreId = (HiddenField)gvTyreRoate.Rows[row.RowIndex].FindControl("hfTyreId");
            Label lbl_Tread_Depth = (Label)gvTyreRoate.Rows[row.RowIndex].FindControl("lbl_Tread_Depth");
            conn.Open();
            SqlCommand cmd1 = new SqlCommand("USP_TYREROTATE_DET_INSERTUPDATE", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da1 = new SqlDataAdapter(cmd1);

            //da1.SelectCommand.Parameters.Add("@INS", SqlDbType.VarChar).Value = "WEBX_FLEET_TYRE_ROTATE_DET";
            da1.SelectCommand.Parameters.Add("@ROTATE_DATE", SqlDbType.VarChar).Value = txtDate.Text;
            da1.SelectCommand.Parameters.Add("@VEH_NO", SqlDbType.Int).Value = Convert.ToInt32(hfVehIntId.Value);

            da1.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = hfTyreId.Value.ToString().Trim();
            da1.SelectCommand.Parameters.Add("@TYREPOS_ID_NEW", SqlDbType.Int).Value = Convert.ToInt32(ddlNewTyrePos.SelectedValue.ToString().Trim());
            da1.SelectCommand.Parameters.Add("@TYREPOS_ID_OLD", SqlDbType.Int).Value = Convert.ToInt32(hfCurrentTyrePos.Value.ToString().Trim());
            da1.SelectCommand.Parameters.Add("@Tread_Depth", SqlDbType.VarChar).Value = lbl_Tread_Depth.Text.ToString().Trim();
            cmd1.ExecuteNonQuery();
            conn.Close();
        }
        clear();
    }
    public void clear()
    {
        txtVehNo.Text = "";
        txtDate.Text = "";
        gvTyreRoate.DataBind();
        gvTyreRoate.EmptyDataText = "";
        btnSubmit.Visible = false;
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        BindGrid();
        if (gvTyreRoate.Rows.Count != 0)
        {
            btnSubmit.Visible = true;
        }
        else
        {
            btnSubmit.Visible = false;
        }
    }
}
