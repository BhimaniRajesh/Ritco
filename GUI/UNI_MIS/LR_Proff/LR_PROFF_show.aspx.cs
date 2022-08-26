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

public partial class MR_show : System.Web.UI.Page
{



    public static string strro, strdockno;
    public static string strloc;
    public static string strDateRange, dttype, mrno, servtyp;



    //uni_mis/lr_proff/lr_proff.aspx


    //   /UNI_MIS/lr_proff/LR_PROFF_show.aspx?MRDate=02%20Apr%2008%20-%2009%20Apr%2008&RO=All&Location=All&dockno=
    protected void Page_Load(object sender, EventArgs e)
    {



        if (!IsPostBack)
        {
            //Date Range display preparation

            strDateRange = Request.QueryString["MRDate"].ToString();
            strro = Request.QueryString["RO"].ToString();
            if (strro == "-All-" || strro == "")
            {
                strro = "ALL";
            }
            strloc = Request.QueryString["Location"].ToString();
            if (strloc == "-All-" || strloc == "")
            {
                strloc = "ALL";
            }



            strdockno = Request.QueryString["dockno"].ToString();

        }



        lblro.Text = strro;
        lblloc.Text = strloc;
        lbldno.Text = strdockno;

        bindgrd();


    }




    private void bindgrd()
    {


        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "wex_THC_TC_dockets";

        string[] strArrDtFromTo = strDateRange.Split('-');

        sqlCommand.Parameters.AddWithValue("@fromdt", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@todt", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@fromRo", strro);
        sqlCommand.Parameters.AddWithValue("@fromloc", strloc);
        sqlCommand.Parameters.AddWithValue("@docklist", strdockno);




        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();


        sqlDA.Fill(ds);

        foreach (DataRow dr in ds.Tables[0].Rows)
        { 
            string s=Convert.ToDouble(dr["profit_per"]).ToString("F2");

            dr["profit_per"] = s;
        
        }

        GV_MR.DataSource = ds;
        GV_MR.DataBind();

        if (GV_MR.Rows.Count == 0)
        {
            ttt1.Visible = false;
        }




    }

    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_MR.PageIndex = e.NewPageIndex;

        //  DisplayMrDetails();


    }

     

      

    public void lst(object sender, EventArgs e)
    {
        int i = GV_MR.PageCount;
        GV_MR.PageIndex = i;

        bindgrd();


    }
    public void fst(object sender, EventArgs e)
    {
        GV_MR.PageIndex = 0;

        bindgrd();


    }
    private void InitializeComponent()
    {

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            GV_MR.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=LR_PROFF.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            bindgrd();
            p1.RenderControl(hw);


            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }

}

