using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.IO;
public partial class GUI_Fleet_Operations_Issue_ExternalThcAudit_ExternalThcCriteriaDetails : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    string Party_code;
    string orgncd;
    string tripsheetNo;
    string fromdt;
    string Todt;
    string TRN_MOD;
    string sqlmain;
    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;
    string PTMSCD, PTMSNM;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["SqlProvider"] = "Data Source=13.76.131.1;Initial Catalog=Ritco_Test;UID=anupam;pwd=anupam@123;Connect Timeout=120;Connection Lifetime=40;Max Pool Size=80000";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        btnExternalThcAudit.Attributes.Add("onclick", "javascript:return CheckExternalThcSelection(" + txtExternalThclist.ClientID + "," + txtExternalThclist_count.ClientID + ")");
        Party_code = Request.QueryString.Get("Party_code");
        PTMSCD = Request.QueryString.Get("Party_code");
        tripsheetNo = Request.QueryString.Get("TripsheetNo");
        fromdt = Request.QueryString.Get("fromtdate");
        Todt = Request.QueryString.Get("todate");
        if (!IsPostBack)
        {
            string fincmplbr;
            if (tripsheetNo != "")
            {
                string sql = "SELECT (CASE WHEN ISNULL((SELECT CUSTCD FROM webx_CUSTHDR WHERE CustomerType=CUSTCD),'')<>'' THEN ISNULL((SELECT CUSTCD FROM webx_CUSTHDR WHERE CustomerType=CUSTCD),'') ELSE '8888' END) AS PTMSCD,(CASE WHEN ISNULL((SELECT  CUSTNM FROM webx_CUSTHDR WHERE CustomerType=CUSTCD),'')<>'' THEN ISNULL((SELECT  CUSTNM FROM webx_CUSTHDR WHERE CustomerType=CUSTCD),'') ELSE CustomerType END)   AS PTMSNM FROM WEBX_FLEET_ExternalTHC where otripsheetno='" + tripsheetNo + "'";
                SqlCommand cmd = new SqlCommand(sql, conn);
                SqlDataReader dr = null;
                conn.Open();
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    PTMSCD = Convert.ToString(dr["PTMSCD"]);
                    PTMSNM = Convert.ToString(dr["PTMSNM"]);
                }

                dr.Close();
                conn.Close();
            }
            Hnd_PTMSCD.Value = PTMSCD;
            orgncd = "All";
            fincmplbr = Session["brcd"].ToString();
            if (fromdt == "")
            {
                fromdt = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            if (Todt == "")
            {
                Todt = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            if (tripsheetNo == "")
            {
                lbldaterange.Text = fromdt.Trim() + "-" + Todt.Trim();
            }
            else
            {
                lbldaterange.Text = "-";
                lblparty.Text = "-";
                lblTripsheetNo.Text = tripsheetNo.Trim();
            }
            BindGrid();
        }
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string fincmplbr;
        fincmplbr = Session["brcd"].ToString();
        string sql = "Webx_ExternalTHC_ExternalThcAudit";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;
        myAdapter.SelectCommand.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = tripsheetNo.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Party_code", SqlDbType.VarChar).Value = Party_code.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Fromdt", SqlDbType.DateTime).Value = fromdt.Trim();
        myAdapter.SelectCommand.Parameters.Add("@Todt", SqlDbType.DateTime).Value = Todt.Trim();
        myAdapter.SelectCommand.Parameters.Add("@loccode", SqlDbType.VarChar).Value = fincmplbr.Trim();
        DataSet ds = new DataSet();
        myAdapter.Fill(ds, "billdata");
        intTotalRecords = ds.Tables[0].Rows.Count;
        gvExternalThcData.DataSource = ds;
        gvExternalThcData.DataBind();
        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        BindGrid();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string ExternalThcnos = "";
        string ExternalThclist = txtExternalThclist.Value.ToString();
        string[] ExternalThclist_arr;
        ExternalThclist_arr = ExternalThclist.Split(',');
        string checkedExternalThc = txtExternalThclist_count.Value.ToString();
        int total_checked = Convert.ToInt32(checkedExternalThc);
        //Session["SqlProvider"] = "Data Source=13.76.131.1;Initial Catalog=Ritco_Test;UID=anupam;pwd=anupam@123;Connect Timeout=120;Connection Lifetime=40;Max Pool Size=80000";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        bool success = false;
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            foreach (GridViewRow gridrow in gvExternalThcData.Rows)
            {
                CheckBox chkExternalThc = (CheckBox)gridrow.FindControl("chkExternalThc");
                Label ExternalTHCNo = (Label)gridrow.FindControl("ExternalTHCNo");
                if (chkExternalThc.Checked)
                {
                    if (ExternalThcnos == "")
                    {
                        ExternalThcnos = ExternalTHCNo.Text.ToString();
                    }
                    else
                    {
                        ExternalThcnos = ExternalThcnos + "," + ExternalTHCNo.Text.ToString();
                    }
                    SqlCommand sql_insert_ExternalTHCAudit = new SqlCommand("USP_FLEETExternalTHC_AuditExternalTHC", conn, trans);
                    sql_insert_ExternalTHCAudit.CommandType = CommandType.StoredProcedure;
                    sql_insert_ExternalTHCAudit.Parameters.Add("@ExternalTHCNo", SqlDbType.VarChar, 50).Value = ExternalTHCNo.Text.ToString().Trim();
                    sql_insert_ExternalTHCAudit.ExecuteNonQuery();

                }

            }
            trans.Commit();
            success = true;
        }
        catch (Exception e1)
        {
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
            trans.Rollback();
            Response.End();
        }
        finally
        {
            conn.Close();
        }
        if (success)
        {
            Response.Redirect("ExternalThcDone.aspx?ExternalThcnos=" + ExternalThcnos + "&fromdt=" + fromdt + "&Todt=" + Todt, true);
        }
        Session["ExternalThcnos"] = ExternalThcnos;
    }
    protected void dockdata_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void DownloadFile(object sender, EventArgs e)
    {
        string filePath = (sender as LinkButton).CommandArgument;
        if (filePath != "")
        {

            string filePaths = Server.MapPath("~/GUI/Fleet/Operations/Issue/UploadedImages/Ritco" + "//" + filePath);
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePaths));
            Response.WriteFile(filePaths);
            Response.End();
        }
        else
        {
            //ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage","alert('No Transport Document Is Attached!!!');", true);
            // System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert('No Transport Document Is Attached!!!')</SCRIPT>");
            (sender as LinkButton).Text = "No Document Attached!!!";
            // (sender as LinkButton).Text

        }
    }
}