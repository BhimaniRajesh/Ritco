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


public partial class GUI_Operations_UpdateDocketArrivalStatus_StockUpdateList : System.Web.UI.Page
{
    public  string dtToday = "";
    public  string dtLastWeek = "";
    public  DateTime dt1, dt2;
    DataTable dt = new DataTable("table1");
    public  string THCNo = "";
    public  string THCDate = "";
    public  string THCArrivalDate = "";
    public  string vehicleno = "";
    public  string MFKount = "";
    public  string DocketKount = "";
   // static string brcd = "";
    static bool flag = false;
    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();
    DataSet ds = new DataSet();
        
    public  bool updated = false;

    
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        dtToday = DateTime.Now.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();
        if (!IsPostBack)
        {
            txtStockUpdateDate.Text = "";// dtToday;
            hTHCNo.Value = Request.QueryString["THCNO"];
            hBrCd.Value = Session["brcd"].ToString().Trim();


            for (int i = 0; i < 3; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
            MSRDKTList.Value =dt.Rows.Count.ToString().Trim(); 
        }

        THCNo = hTHCNo.Value.Trim();
         string brcd = Session["brcd"].ToString().Trim();
        MySQLDataSource_DelyReasons.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Godowns.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_ArrivalConditions.ConnectionString = Session["SqlProvider"].ToString().Trim();

        if (!IsPostBack)
        {
            GetTHCInfo();

            if (updated)
            {
                btnStockUpdate.Text = "<< Stock Already Updated >>";
                btnStockUpdate.Enabled = false;
                
            }
            ShowStockUpdateList();
        }
        hTHCArrvDate.Value = THCArrivalDate.Trim();
        hSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");

       // Response.Write(" MSRDKTList" + MSRDKTList.Value);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtRows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtRows.Text);
            }
            catch (Exception ex)
            {
                txtRows.Text = "";
                txtRows.Focus();
            }
        }
        else
        {
            maxrows = 5;
        }
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();

        MSRDKTList.Value = dt.Rows.Count.ToString().Trim(); 
    }

    protected void GetTHCInfo()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        string strSQL = "Exec  usp_StockUpdateSummary '" + hTHCNo.Value.Trim() + "','" + hBrCd.Value.Trim() + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlCommand.CommandType = CommandType.Text;
        SqlDataReader dr = sqlCommand.ExecuteReader();
       
        while (dr.Read())
        {
            THCDate = dr["THCDT"].ToString().Trim();
          //  flag = Convert.ToBoolean(dr["chkms"]);
            THCArrivalDate = dr["THCArrivalDate"].ToString().Trim();
            vehicleno = dr["VEHNO"].ToString().Trim().ToUpper();
            DocketKount = dr["DocketKount"].ToString().Trim();
            MFKount = dr["ManifestKount"].ToString().Trim();
        }
        dr.Close();

        if (THCDate == "") { updated = true; }
    }



    protected void ShowStockUpdateList()
    {

        SetDataSet();
        rptDocketList.DataSource = ds;
        rptDocketList.DataBind();
    
    }

    protected void StockUpdate(object sender, EventArgs e)
    {
    }

    protected void ShowFirstGodown(object sender, EventArgs e)
    {
        DropDownList cbo = (DropDownList)sender;
        if (cbo.Items.Count > 1)
        {
            cbo.SelectedIndex = 1;
        }
    }

    protected void SetDataSet()
    {
        int RecFound = 0;

        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        string sql = "usp_StockUpdateList";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        sqlCmd.Parameters.AddWithValue("@thcno", THCNo.Trim());
        sqlCmd.Parameters.AddWithValue("@brcd", Session["brcd"].ToString().Trim());

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Find RecCount From Dataset
        RecFound = ds.Tables[0].Rows.Count;
        hStockList.Value = RecFound.ToString().Trim();
        //tblSubmitBtn.Visible = true;
        if (RecFound == 0)  //If RecCount is 0 then Display No Records Found
        {
            //tblSubmitBtn.Visible = false;
        }

        //Close Connection
        sqlCon.Close();
        sqlCon = null;
        //--------------------------------
    }

    protected void rptDocketList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            CheckBox CHKSTUP = (CheckBox)e.Item.FindControl("CHKSTUP");
            if (DataBinder.Eval(e.Item.DataItem, "docksf").ToString().CompareTo(".") == 0)
            {
                //CHKSTUP.Checked = false;
                //CHKSTUP.Enabled = true;
                CHKSTUP.Checked = true;
                CHKSTUP.Enabled = false;
            }
            else
            {
                CHKSTUP.Checked = true;
                CHKSTUP.Enabled = false;
            }

            
            if (DataBinder.Eval(e.Item.DataItem, "chkms").ToString().CompareTo("true") == 0)
                CHKSTUP.Enabled= false;
            //else
            //    CHKSTUP.Enabled = true;


          

        }
    
    }

}
