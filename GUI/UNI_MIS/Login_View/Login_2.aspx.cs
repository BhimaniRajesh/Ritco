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

public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{

    public static string strDateRange, strloc, stremp, strlogininstence, strreptype;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["strDateRange"].ToString();
            strloc = Request.QueryString["strloc"].ToString();
            stremp = Request.QueryString["stremp"].ToString();
            strlogininstence = Request.QueryString["strlogininstence"].ToString();
            strreptype = Request.QueryString["strreptype"].ToString();
            

        }


        // lables......




        lblseldet.Text = strDateRange;
        lblloc.Text = strloc;
        lblemp.Text = stremp;
        lblli.Text = strlogininstence;
       

       

        DipsplayReport();


    }

    public void DipsplayReport()
    {

        string[] strArrDtFromTo = strDateRange.Split('-');
        string strfrmdt= strArrDtFromTo[0];
        string strtodt= strArrDtFromTo[1];
        string locval = "";
        string empval ="";
        string lival = "0";
        if (strloc != "")
        {
            lblloc.Text = "All";
            locval = "and CURRBRCD=" + strloc;
        }

        if(stremp != "")
        {
            lblemp.Text = "All";
            empval= "and empcd='" + stremp+"'";
        }
        if (strlogininstence != "")
        {
            lblli.Text = strlogininstence;
            lival = strlogininstence;
        }
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");

        string sql="";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());

        if (strreptype == "D")
        {
          sql = "select EMPCD,EMPNM,LocName,CURRBRCD,LASTLOGINDT,LOGOUTDT,Duration  from webx_login where  convert(varchar,LASTLOGINDT,106)  between convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106) " + locval + empval + "" + "order by EMPNM,LocName";
        }
        else if (strreptype == "S")
        {
            sql = "select EMPCD,EMPNM,LocName,COUNT(*) AS NOOFLOGIN from webx_login where  convert(varchar,LASTLOGINDT,106)  between convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106)  " + locval + empval + "" + " group by EMPCD,EMPNM,LocName having Count(*) >= " + lival + " order by LocName";
        }
        else
        {
            lblnull.Visible = true;
            lblnull.Text = "Please Select Valid Report Type";
            goto hi;

        }



        conn.Open();

        SqlCommand sqlCommand = new SqlCommand(sql,conn);

        

        try
        {

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet ds1 = new DataSet();
            sqlDA.Fill(ds1);
            GridView1.DataSource = ds1;


        }

        catch (Exception eee)
        {
            Label1.Text = eee.Message;


        }



        GridView1.DataBind();
        if (GridView1.Rows.Count == 0)
        {
            lblnull.Visible = true;
            lblnull.Text = "No Records Found For Given Criteria";
        }

    hi: Console.WriteLine("Please Select Valid Report Type");






    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

}
