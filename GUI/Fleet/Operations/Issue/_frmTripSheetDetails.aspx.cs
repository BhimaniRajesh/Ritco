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




public partial class GUI_Fleet_Operations_Issue_frmTripSheetDetails : System.Web.UI.Page
{

   // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
 
   string strVSlipNo="";
    protected void Page_Load(object sender, EventArgs e)
 

    
      {


          strVSlipNo = Request.QueryString["id"].Trim();



          strVSlipNo = Session["VSlipNo"].ToString();


        if(!IsPostBack)
        {

            BindGrid();

         }




    }






    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        
        conn.Open();

        SqlCommand cmd = new SqlCommand("usp_Webx_Get_TripSheetDetails", conn);



        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = strVSlipNo;
        DataSet ds = new DataSet();


        da.Fill(ds);


        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();

     //   Session["VSlipNo"] = null;

    }


}
