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

    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    SqlConnection conn;
    
    string DocketNo = "", mDocNo="",Suffix = "", NonDel = "", Short = "", Dam = "", Leakage = "", Pilferage = "", Other = "";
    string  COF = "";
    string ClaimParty = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        cmdGo.Attributes.Add("onClick", "javascript:return checkEvent();");
        if (!IsPostBack)
        {

            //Do Work
        }
    }
    protected void cmdGo_Click(object sender, EventArgs e)
    {
        if (chkNonDelivery.Checked == true)
        {
            NonDel = "Y";
        }
        else
        {
            NonDel = "N";
        }

        if (chkShortage.Checked == true)
        {
            Short = "Y";

        }
        else
        {
            Short = "N";
        }


        if (chkDamage.Checked == true)
        {
            Dam = "Y";
        }
        else
        {
            Dam = "N";
        }

        if (chkLeakage.Checked == true)
        {
            Leakage = "Y";

        }
        else
        {
            Leakage="N";
        }

        if (chkPilferage.Checked == true)
        {
            Pilferage = "Y";
        }
        else
        {
            Pilferage="N";
        }

        if (chkOther.Checked == true)
        {
            Other = "Y";
        }
        else
        {
            Other = "N";
        }

        if (rdBill.Checked == true)
        {
            COF="B";
        }
       
        if (rdCash.Checked == true)
        {

            COF = "C";
        }

       

        if (rdCOF.Checked == true)
        {
            COF = "CF";
        }
       
        if (rdConsignor.Checked == true)
        {
            ClaimParty = "Consignor";
        }

        if (rdConsignee.Checked == true)
        {
            ClaimParty = "Consignee";
        }

        if (rdOther.Checked == true)
        {
            ClaimParty = "Others";
        }


        lblError.Text = "";
        lblError1.Text = "";
        string DataFound = "N";

       
        
        if (txtDocketNo.Text.ToString().Trim() != "")
        {
            conn.Open();
          
            SqlCommand cmd = new SqlCommand("usp_getDocketNo", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = txtDocketNo.Text.ToString().Trim();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {

                    mDocNo = Convert.ToString(dr["DOCKNO"]);

                    DataFound = "Y";
                }

            }
            dr.Close();
            conn.Close();

        }

        string DataFoundFLAG = "N";

        if (DataFound == "Y")
        {
            conn.Open();
            string sql = "select * from WEBX_CIR_HDR where DOCKNO='"+txtDocketNo.Text+"' ";
            SqlCommand cmd = new SqlCommand(sql, conn);
            
          
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {

                    mDocNo = Convert.ToString(dr["DOCKNO"]);

                    DataFoundFLAG = "Y";
                }

            }
            dr.Close();
            conn.Close();

        }

        if (DataFoundFLAG == "Y")
        {
            Response.Redirect("CIRAdded.aspx");
           
        }
      
        

        
        if (DataFound == "N")
        {
            if (txtDocketNo.Text != "")
            {
                lblError1.Text = "Docket No.Does not Exist!!";
            }

        }

        else
        {
            // AddEdit();


            Session["DocketNo"] = txtDocketNo.Text;
            Session["DocketSf"] = txtSiffix.Text;

            Session["NonDel"] = NonDel;
            Session["Short"] = Short;
            Session["Dam"] = Dam;
            Session["Leak"] =Leakage;
            Session["Pil"] = Pilferage;
            Session["Other"] = Other;


            if (rdBill.Checked == true)
            {
                COF="B";
            }
            if (rdCash.Checked == true)
            {
                COF = "C";
            }
            if (rdCOF.Checked == true)
            {
                COF = "CF";
            }

            Session["COF"] = COF;
            Session["ClaimParty"] = ClaimParty;
           
         //   usp_CIR_generate
            conn.Open();
            string mCIRNo="";
             SqlCommand cmd1 = new SqlCommand("usp_CIR_generate", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["mainbrcd"].ToString().Trim();
            
            SqlDataReader  dr1= cmd1.ExecuteReader();
            if(dr1.HasRows)
            {
                while(dr1.Read())
                {

                    mCIRNo=Convert.ToString(dr1[0]);



                }

            }

            dr1.Close();
            conn.Close();
            
            
            Session["CIRNO"] = mCIRNo;
            Session["CIRBR"] = Session["mainbrcd"];
            Session["BR_PrePBy"] = Session["empcd"];
            Session["BR_PreName"] = Session["empnm"];
          











         //   Response.Redirect("ClaimsInvstReport.aspx?DocketNo?DocketNo=" + DocketNo + "&DocketSf=" + DocketSf + "&NonDel=" +Short+"&Short" +Damage="&Dam" + Leakage="&Leakage" + Pilferage="&Pilferage" + Other="&Other" );
            Response.Redirect("ClaimsInvstReport.aspx");
        }

     

        
    }

    //public void AddEdit()
    //{
    //    conn.Open();
    //    SqlCommand cmd = new SqlCommand("usp_getDocketNo", conn);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = txtDocketNo.Text ;
    //    cmd.Parameters.Add("@DocketSf", SqlDbType.VarChar).Value = txtSiffix.Text ;
    //    cmd.Parameters.Add("@NonDel", SqlDbType.VarChar).Value = NonDel ;
    //    cmd.Parameters.Add("@Shortage", SqlDbType.VarChar).Value =  Short;
    //    cmd.Parameters.Add("@Damage", SqlDbType.VarChar).Value =  Dam;
    //    cmd.Parameters.Add("@Leakage", SqlDbType.VarChar).Value =  Leakage;
    //    cmd.Parameters.Add("@Pilferage", SqlDbType.VarChar).Value =  Pilferage;
    //    cmd.Parameters.Add("@Other", SqlDbType.VarChar).Value = Other ;


    //    cmd.Parameters.Add("@Bill", SqlDbType.VarChar).Value =  Bill;
    //    cmd.Parameters.Add("@Cash", SqlDbType.VarChar).Value =Cash  ;
    //    cmd.Parameters.Add("@COF", SqlDbType.VarChar).Value = COF ;

    //    cmd.Parameters.Add("@ClmParty", SqlDbType.VarChar).Value = Consignor;
    //  //  cmd.Parameters.Add("@Consignee", SqlDbType.VarChar).Value = Consignee;
    //  // cmd.Parameters.Add("@Other1", SqlDbType.VarChar).Value =Other1;
    //    cmd.ExecuteNonQuery();

    //}



}
