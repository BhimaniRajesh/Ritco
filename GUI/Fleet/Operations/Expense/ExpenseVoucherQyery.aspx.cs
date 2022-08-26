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

public partial class GUI_Fleet_Operations_Expense_ExpenseVoucherQyery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        Session["Flag"] = null;
        if (!IsPostBack)
        {


        }  
    }


    protected void CheckValid(object sender, EventArgs e)
    {
        //txtDateFrom.Text = "";
        //txtDateTo.Text = "";
        txtDateFrom.CalendarDate = "";
        txtDateTo.CalendarDate = "";


        radDate.Items[0].Selected = true;
        radDate.Items[1].Selected = false;
        radDate.Items[2].Selected = false;
        radDate.Items[3].Selected = false;
    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {


        txtVoucherNo.Text = "";
        //txtDateFrom.ReadOnly = false;
        //txtDateTo.ReadOnly = false;





        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.CalendarDate = strrightnow;
            txtDateTo.CalendarDate = strrightnow;
            //  txtDateFrom.ReadOnly = true;
            // txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.CalendarDate = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.CalendarDate = strrightnow;
        }
    }


    protected void btnShowMultiple_Click(object sender, EventArgs e)
    {

        RetrieveGridData();
    }


    public void RetrieveGridData()
    {


        string VoucherNo = "";
        string Type = "";

        if (txtVoucherNo.Text != "")
        {
            VoucherNo = txtVoucherNo.Text;
        }

        Type = cboType.SelectedValue;
        if (Type == "V")
        {
            Session["Flag"] = "V";

        }
        if (Type == "F")
        {
            Session["Flag"] = "F";

        }
        if (Type == "B")
        {
            Session["Flag"] = "";

        }



        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_ExpenseVoucherList";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        {
            if (txtDateFrom.CalendarDate != "")
            {
                dtFrom = Convert.ToDateTime(txtDateFrom.CalendarDate, dtfi);
                dtTo = Convert.ToDateTime(txtDateTo.CalendarDate, dtfi);
            }
            else
            {
                System.DateTime righnow = System.DateTime.Today;
                string strrightnow = righnow.ToString("dd/MM/yyyy");
                dtFrom = Convert.ToDateTime("01/01/1900", dtfi);
                dtTo = Convert.ToDateTime(strrightnow, dtfi);

            }
        }


        da.SelectCommand.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = VoucherNo.ToString();
        da.SelectCommand.Parameters.Add("@FromDt", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@ToDt", SqlDbType.DateTime).Value = dtTo;
        da.SelectCommand.Parameters.Add("@Type", SqlDbType.VarChar).Value = Type.ToString().Trim();
        DataSet  ds= new DataSet();
  
        da.Fill(ds);

        DataGrid1.DataSource = ds;
        DataGrid1.DataBind();


        conn.Close();
    }
  
    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        if (Session["Flag"].ToString().Trim() == "V")
        {
            e.Item.Cells[6].Visible = true;
            e.Item.Cells[7].Visible = true;

            e.Item.Cells[8].Visible = false;
            e.Item.Cells[9].Visible = false;

        }
        if (Session["Flag"].ToString().Trim() == "F")
        {
            e.Item.Cells[6].Visible = false;
            e.Item.Cells[7].Visible = false;

            e.Item.Cells[8].Visible = true;
            e.Item.Cells[9].Visible = true;

        }
    }





}
