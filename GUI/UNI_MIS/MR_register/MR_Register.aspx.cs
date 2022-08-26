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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;


public partial class MR_Register : System.Web.UI.Page
{
    protected Int32 _currentPageNumber = 1;
    public byte byteRadButtonSelection;
     
    public static int intPageSize = 2;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        
        // UCB code starts from here....

        if (!IsPostBack)
        {
            //txtDateFrom.Text = DateTime.Now.Day.ToString() + "/" + DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString();
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;

            popRO();
        }

        // UCB code ends from here....
    }


    public void popRO()
    {


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string s = Session["SqlProvider"].ToString().Trim();
        // conn = new SqlConnection(sConn);
        conn.Open();

        string brcd = Session["brcd"].ToString();

        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";

        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);


        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();


        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl <= 2)
        {

            if (loclvl == 1)
            {
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";

                SqlCommand sqlcmd = new SqlCommand(sql, conn);

                DataSet ds = new DataSet();

                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


                da.Fill(ds, "tab");
                ddlro.DataSource = ds;
                ddlro.DataTextField = "c1";
                ddlro.DataValueField = "c2";
                ddlro.DataBind();
                ddlloc.Items.Add("All");



            }
            else
            {
                string concat = brcd + " : " + locnm;


                ddlro.Items.Clear();

                ddlro.Items.Add(concat);
                ddlro.DataBind();
                ddlro.SelectedItem.Value = brcd;

                popLOC();




            }





        }
        else
        {
            ddlro.Enabled = false;
            ddlloc.Items.Clear();
            ddlloc.Items.Add(brcd);


        }





    }

    public void popLOC()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string strro = ddlro.SelectedValue.ToString();
        string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.Text;
        //select loccode+':'+locname c1 from webx_location
        //ddlro.DataTextField = "-ALL-";
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        ddlloc.DataSource = ds;
        ddlloc.DataTextField = "c1";
        ddlloc.DataValueField = "loccode";
        ddlloc.DataBind();
    }





    
   

    protected void btnXLS_Click(object sender, EventArgs e)
    {

    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {

    }

   

    protected void btnShow_Click(object sender, EventArgs e)
    {
        //Generate Query String parameter for the page

       
    }
    protected void btnShow_Click1(object sender, EventArgs e)
    {


        if (Page.IsValid == true)
        {

            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
            string strro = ddlro.SelectedValue.ToString();
            string strloc = ddlloc.SelectedValue.ToString();
            string strmrparty = txtPartyCode.Text;
            string strmrtype = ddlmrtype.SelectedValue.ToString();
            string strstatus = ddlstatus.SelectedValue.ToString();
            string strcash = ddlcash.SelectedValue.ToString();
            string stramtgr = txtamtgrt.Text;


            string strFinalQS = "?MRDate=" + strQSMRDate;
            strFinalQS = strFinalQS + "&RO=" + strro;
            strFinalQS = strFinalQS + "&Location=" + strloc;
            strFinalQS = strFinalQS + "&MRParty=" + strmrparty;
            strFinalQS = strFinalQS + "&MRType=" + strmrtype;
            strFinalQS = strFinalQS + "&Status=" + strstatus;
            strFinalQS = strFinalQS + "&cash=" + strcash;
            strFinalQS = strFinalQS + "&AmtGrThan=" + stramtgr;

            strFinalQS = strFinalQS + "&dttype=" + ddldttype.SelectedValue.ToString();
            strFinalQS = strFinalQS + "&mrno=" + txtmrno.Text;
            strFinalQS = strFinalQS + "&dockno=" + txtdock.Text;
            strFinalQS = strFinalQS + "&servtyp=" + ddlmrlittype.SelectedValue.ToString();




            Response.Redirect("MR_show.aspx" + strFinalQS);
        }



    }
    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {
      popLOC();
    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

       
    }

    public void daterange(object source, ServerValidateEventArgs value)
    {

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

        System.TimeSpan diffResult = dt2.Subtract(dt1);
        //if (diffResult.Days > 31)
        //{
        //    value.IsValid = false;
        //}

         if (dt1 > dt2)
        {
            value.IsValid = false;
            CustomValidator1.ErrorMessage = "From Date Can not Be Greater Than To Date.";
        }
        else
        {
            value.IsValid = true;

        }
    }
     
}
