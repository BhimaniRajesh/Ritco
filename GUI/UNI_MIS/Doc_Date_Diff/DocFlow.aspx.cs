using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page 
{

    public byte byteRadButtonSelection;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtDateFrom.Text = DateTime.Now.Day.ToString() + "/" + DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString();
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;


            popRO();
        }

    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }

    }
    protected void btnShow_Click1(object sender, EventArgs e)
    {
        string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        string[] strArrDtTo = txtDateTo.Text.Split('/');

        DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        string strro = ddlro.SelectedValue.ToString();
        string strloc = ddlloc.SelectedValue.ToString();
        string strcust = txtPartyCode.Text;
        string strflowtype = radFlow.SelectedValue.ToString();
        string strdttype = ddlbookdt.SelectedValue.ToString();


        string strFinalQS = "?DOCDate=" + strQSMRDate;
        strFinalQS = strFinalQS + "&RO=" + strro;
        strFinalQS = strFinalQS + "&Location=" + strloc;
        strFinalQS = strFinalQS + "&Cust=" + strcust;
        strFinalQS = strFinalQS + "&Flow=" + strflowtype;
        strFinalQS = strFinalQS + "&DateType=" + strdttype;


        Response.Redirect("Show_DocFlow.aspx" + strFinalQS);
    }


    public void popRO()
    {
        //string sConn;
        //SqlConnection conn;

        // sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
        //  sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";


       // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // conn = new SqlConnection(sConn);


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
        //string sConn;
        //SqlConnection conn;
        ////sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
        //sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
      //  conn = new SqlConnection(sConn);
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
    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {
      
        popLOC();
    }
    protected void ddlloc_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
