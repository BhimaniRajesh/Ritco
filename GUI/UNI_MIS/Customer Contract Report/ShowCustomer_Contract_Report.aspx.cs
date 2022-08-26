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

    public static string strDateRange, strloc, strro, strcontract_type, stract_dact, sqlorg, strcust;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
          
 

                strDateRange = Request.QueryString["strDateRange"].ToString();
                //Session["dt"] = strDateRange;
                strloc = Request.QueryString["strloc"].ToString();
                strro = Request.QueryString["strro"].ToString();
                strcontract_type = Request.QueryString["strcontract_type"].ToString();
                stract_dact = Request.QueryString["stract_dact"].ToString();

                strcust = Request.QueryString["cust"].ToString();
           




        }



       
        

       
        
        
        // lables......
        lblseldet.Text = strDateRange;
        lblloc.Text = strloc;
        lblro.Text = strro;



        DipsplaySumm();
    }


    public void DipsplaySumm()
    {


        //SqlConnection sqlConn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;


        sqlCommand.CommandText = "webx_CUST_Contract_San2";




        // Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strDateRange.Split('-');

        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@loccode", strloc);
        sqlCommand.Parameters.AddWithValue("@RO", strro);
        sqlCommand.Parameters.AddWithValue("@stract_dact", stract_dact);
        sqlCommand.Parameters.AddWithValue("@strcontract_type", strcontract_type);
        sqlCommand.Parameters.AddWithValue("@Cust", strcust);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        foreach (DataRow dr in ds.Tables[0].Rows)
        {

            if (dr["Contract_type"].ToString().Length > 3)
            {
                String myString = dr["Contract_type"].ToString();
                String[] split = myString.Split(',');
                dr["Contract_type"] = "";
                for (int x = 0; x < split.Length; x++)
                {


                    switch (split[x])
                    {
                        case "P02":
                            dr["Contract_type"] += " TBB";
                            break;

                        case "P03":
                            dr["Contract_type"] += ", To Pay";
                            break;

                        case "P01":
                            dr["Contract_type"] += ", Paid";
                            break;

                        case "P08":
                            dr["Contract_type"] += ", BOD";
                            break;

                        case "P06":
                            dr["Contract_type"] += ", To Pay Billing";
                            break;

                        case "P04":
                            dr["Contract_type"] += ", FOC";
                            break;

                        case "P09":
                            dr["Contract_type"] += ", National";
                            break;




                    }

                }
            }







            else
            {
                switch (dr["Contract_type"].ToString())
                {
                    case "P02":
                        dr["Contract_type"] = " TBB";
                        break;

                    case "P03":
                        dr["Contract_type"] = "To Pay";
                        break;

                    case "P01":
                        dr["Contract_type"] = " Paid";
                        break;

                    case "P08":
                        dr["Contract_type"] = " BOD";
                        break;

                    case "P06":
                        dr["Contract_type"] = " To Pay Billing";
                        break;

                    case "P04":
                        dr["Contract_type"] = " FOC";
                        break;

                    case "P09":
                        dr["Contract_type"] = " National";
                        break;




                }


            }



            GV_Summ.DataSource = ds;
            GV_Summ.DataBind();
            if (GV_Summ.Rows.Count <= 25)
            {
                LinkButton1.Visible = false;
                LinkButton2.Visible = false;
            }

        }
    }



    
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Summ.PageIndex = e.NewPageIndex;

        DipsplaySumm();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Summ.PageCount;
        GV_Summ.PageIndex = i;

        DipsplaySumm();



    }
    public void fst(object sender, EventArgs e)
    {
        GV_Summ.PageIndex = 0;

        DipsplaySumm();

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
            GV_Summ.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Customer_Contrant_Report.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DipsplaySumm();
            GV_Summ.RenderControl(hw);


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
