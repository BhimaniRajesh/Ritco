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

public partial class octroi_OctCustBillStep2 : System.Web.UI.Page
{
  
   //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);


    public static string vencode;
    public static DataSet ds_san = new DataSet();
  int _lastEditedPage;
    string custcd, octroipaid_by;
    string custcls = "";
     public string dockno;
    public string bno = "";

    public string s1, s2, s3;

    protected void Page_Load(object sender, EventArgs e)
    {
        getstring();
        
        string billdate;

        string para = Request.QueryString["para"].ToString();

        if (para == "1")
        {
            vencode = Session["vencd"].ToString();
        }
        else
        {
            vencode = Request.QueryString["vno"].ToString();
        }

        
         
        btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit(" + PanNo.ClientID + "," + servtaxno.ClientID + "," + vendorbstno.ClientID + "," + vendorcstno.ClientID + "," + txtContractStartDate.ClientID + "," + txtContractEndDt.ClientID + "," + txtOpenDt.ClientID + "," + txtOpnCrdt.ClientID + "," + ddVendorType.ClientID + "," + txtvenname.ClientID + ")");

        txtContractStartDate.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtContractStartDate.ClientID + ")");
        txtContractEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtContractEndDt.ClientID + ")");


        //txtOpenDt.Attributes.Add("onblur", "javascript:check2(" + txtOpenDt.ClientID + "," + txtOpnCrdt.ClientID + ")");
        //txtOpnCrdt.Attributes.Add("onblur", "javascript:check2(" + txtOpenDt.ClientID + "," + txtOpnCrdt.ClientID + ")");


        
        if (!IsPostBack)
        {
            ds_san.Clear();
            getGRDData();

            roww.Text = "3";

            popVentype();
            Validation();
            filltxt();

        }
        else
        {
         
            
        }
        

    }
    protected void BlankRow()
    {

        
    }

    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT loccode FROM  webx_location";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["loccode"] + "'"));
        }
        dr_Location.Close();
    }


    private void GV_D_PageIndexChanged(object source, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
    {
        //GV_D.PageIndex = e.NewPageIndex;
        //BindGrid();
    }
    

    
    
    
    protected void roww_TextChanged(object sender, EventArgs e)
    {

               Int32 i;
       DataRow drow;
            if (ds_san.Tables[0] != null)
            {
                i = Convert.ToInt32(roww.Text) - Convert.ToInt32(ds_san.Tables[0].Rows.Count);
                if (i > 0)
                {
                    for (Int32 j = i; j > 0; j--)
                    {
                        drow = ds_san.Tables[0].NewRow();
                        ds_san.Tables[0].Rows.Add(drow);
                    }
                }
            }
            //GrdPaidFollow.DataSource = null;
            GV_D.DataSource = ds_san;
            GV_D.DataBind();
       

        Validation();
    }

    public void Validation()
    {
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtblack = ((TextBox)gridrow.FindControl("txtblack"));
            CheckBox chkblk = ((CheckBox)gridrow.FindControl("chkblk"));
            TextBox txtactflag = ((TextBox)gridrow.FindControl("txtactflag"));
            CheckBox chkact = ((CheckBox)gridrow.FindControl("chkact"));

            TextBox txtloc = (TextBox)gridrow.FindControl("txtloc");
            TextBox txtcontper = (TextBox)gridrow.FindControl("txtcontper");
            TextBox txtadr = (TextBox)gridrow.FindControl("txtadr");
            TextBox txtcity = (TextBox)gridrow.FindControl("txtcity");
            TextBox txtpin = (TextBox)gridrow.FindControl("txtpin");
            TextBox txttel = (TextBox)gridrow.FindControl("txttel");
            TextBox txtmob = (TextBox)gridrow.FindControl("txtmob");
            TextBox txtemail = (TextBox)gridrow.FindControl("txtemail");

            txtpin.Attributes.Add("onblur", "javascript:check(" + txtpin.ClientID + "," + txttel.ClientID + "," + txtmob.ClientID + "," + txtemail.ClientID + ")");
            txttel.Attributes.Add("onblur", "javascript:check(" + txtpin.ClientID + "," + txttel.ClientID + "," + txtmob.ClientID + "," + txtemail.ClientID + ")");
            txtmob.Attributes.Add("onblur", "javascript:check(" + txtpin.ClientID + "," + txttel.ClientID + "," + txtmob.ClientID + "," + txtemail.ClientID + ")");
            txtemail.Attributes.Add("onblur", "javascript:check(" + txtpin.ClientID + "," + txttel.ClientID + "," + txtmob.ClientID + "," + txtemail.ClientID + ")");


           

            if (txtactflag.Text == "Y")
            {
                chkact.Checked = true;
            }
            else
            {
                chkact.Checked = false;
            }


            if (txtblack.Text == "Y")
            {
                chkblk.Checked = true;
            }
            else
            {
                chkblk.Checked = false;
            }



        }
    }
     
    

    

    protected void OnchkChange(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in GV_D.Rows)
        {

            TextBox txtactflag = ((TextBox)gridrow.FindControl("txtactflag"));
            CheckBox chkact = ((CheckBox)gridrow.FindControl("chkact"));

            if (chkact.Checked == true)
            {
                txtactflag.Text = "Y";

            }
            else
            {
                txtactflag.Text = "N";

            }



        }
    }

        protected void Onchk2Change(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in GV_D.Rows)
        {

            TextBox txtblack = ((TextBox)gridrow.FindControl("txtblack"));
            CheckBox chkblk = ((CheckBox)gridrow.FindControl("chkblk"));

            if (chkblk.Checked == true)
            {
                txtblack.Text = "Y";

            }
            else
            {
                txtblack.Text = "N";
            
            }
        
        
        
        }

        
 

    }
     
     
    public void popVentype()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            ddVendorType.Items.Add("--Select--");
            cn.Open();
            string sqldd = "select type_name, type_code from webx_VENDOR_type";
            SqlCommand cmd = new SqlCommand(sqldd, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddVendorType.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }
            dr.Close();
            cn.Close();

        }
    }
    public string getNewCd()
    {
        int intCustCode = 1;
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        cn.Open();

        SqlCommand cmdGet = new SqlCommand("select cast(right(max(vendorcode), 5) as numeric(18, 0)) + 1 from webx_VENDOR_DET", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();

        if (drGet.Read())
        {
            intCustCode = Convert.ToInt32(drGet[0].ToString());
        }

        drGet.Close();

        return "V" + intCustCode.ToString().PadLeft(5, '0');
        cn.Close();
    }

    protected void Button11_Click(object sender, EventArgs e)
    {
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {

       // string venno = getNewCd();

        //Session["billno"] = venno;



        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        


      string sqldel = "DELETE webx_VENDOR_DET where VENDORCODE='" + vencode + "'";


        //insert into webx_VENDOR_DET(VENDORCODE, VENDORBRCD,VENDORCONTACT, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE,VENDORMOBILE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED) 
        //values('" + venno + "','" + txtloc.Text + "','" + txtcontper.Text + "','" + txtadr.Text + "','" + txtcity.Text + "','" + txtpin.Text + "','" + txttel.Text + "','" + txtmob.Text + "','" + txtemail.Text + "','" + txtactflag.Text + "','" + txtblack.Text + "')";

      SqlCommand cmddDEL = new SqlCommand(sqldel, conn);

        cmddDEL.ExecuteNonQuery();

        foreach (GridViewRow gridrow in GV_D.Rows)
        { 
            TextBox txtloc = (TextBox)gridrow.FindControl("txtloc");
            TextBox txtcontper = (TextBox)gridrow.FindControl("txtcontper");
            TextBox txtadr = (TextBox)gridrow.FindControl("txtadr");
            TextBox txtcity = (TextBox)gridrow.FindControl("txtcity");
            TextBox txtpin = (TextBox)gridrow.FindControl("txtpin");
            TextBox txttel = (TextBox)gridrow.FindControl("txttel");
            TextBox txtmob = (TextBox)gridrow.FindControl("txtmob");
            TextBox txtemail = (TextBox)gridrow.FindControl("txtemail");
            TextBox txtactflag = (TextBox)gridrow.FindControl("txtactflag");
            TextBox txtblack = (TextBox)gridrow.FindControl("txtblack");
              
            if (txtloc.Text=="")
            {

            }
            else
            {  

                try
                {
                     
                    string sql = "";


                  //  sql = "update webx_VENDOR_DET set VENDORBRCD='" + txtloc.Text + "',VENDORCONTACT='" + txtcontper.Text + "',VENDORADDRESS='" + txtadr.Text + "',VENDORCITY='" + txtcity.Text + "',VENDORPIN='" + txtpin.Text + "',VENDORPHONE='" + txttel.Text + "',VENDORMOBILE='" + txtmob.Text + "',VENDOREMAIL='" + txtemail.Text + "',ACTIVEFLAG='" + txtactflag.Text + "',BLACKLISTED='" + txtactflag.Text + "' where VENDORCODE='" + vencode + "'";
                    
                    
                 sql = "insert into webx_VENDOR_DET(VENDORCODE, VENDORBRCD,VENDORCONTACT, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE,VENDORMOBILE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED) "+
                    "values('" + vencode + "','" + txtloc.Text + "','" + txtcontper.Text + "','" + txtadr.Text + "','" + txtcity.Text + "','" + txtpin.Text + "','" + txttel.Text + "','" + txtmob.Text + "','" + txtemail.Text + "','" + txtactflag.Text + "','" + txtblack.Text + "')";
            
                    SqlCommand cmdd = new SqlCommand(sql, conn);

                    cmdd.ExecuteNonQuery();

 
                }
                catch (Exception ee1)
                {
                    lblQry.Text = ee1.Message;


                }

            }


        }


        string sql3 = "update webx_VENDOR_HDR set vendor_type='" +
        Convert.ToInt32(ddVendorType.SelectedValue) + "'," +
        "VENDORNAME='" + txtvenname.Text + "'" +
        ",CONTRACTSTDT='" + txtContractStartDate.Text + "'," +
        "CONTRACTENDDT='" + txtContractEndDt.Text + "'," +
        "VENDORREMARKS='" + txtRemarks.Text + "'," +
        "UPDTBY='" + Session["empcd"].ToString().Trim() + "'," +
        "UPDTON='" + System.DateTime.Now.ToShortDateString() + "'," +
        "VENDCAT='" + Convert.ToInt32(ddVendorType.SelectedValue) + "'," +
        "servtaxno='" + servtaxno.Text + "'," +
        "pan_no='" + PanNo.Text + "'," +
        "vendorbstno='" + vendorbstno.Text + "'," +
        "vendorcstno='" + vendorcstno.Text + "'," +
        "opencredit='" + txtOpenDt.Text + "'," +
        "opendebit='" + txtOpnCrdt.Text + "',dEFAULT_aDDR='"+txtAddress.Text+"' where VENDORCODE='" + vencode + "'";
        
        /*insert into webx_VENDOR_HDR(vendor_type,VENDORCODE,VENDORNAME,CONTRACTSTDT," +
        "CONTRACTENDDT,VENDORREMARKS,UPDTBY,UPDTON,VENDCAT,servtaxno,pan_no,vendorbstno," +
        "vendorcstno,opencredit,opendebit) values('" +
        Convert.ToInt32(ddVendorType.SelectedValue) + "','" + venno + "','" + txtvenname.Text +
        "','" + txtContractStartDate.Text + "','" + txtContractEndDt.Text + "','" + txtRemarks.Text +
        "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() +
        "','" + Convert.ToInt32(ddVendorType.SelectedValue) + "','" + servtaxno.Text + "','" +
        PanNo.Text + "','" + vendorbstno.Text + "','" + vendorcstno.Text + "','" +
        txtOpenDt.Text + "','" + txtOpnCrdt.Text + "')";
        */


        SqlCommand cmdd3 = new SqlCommand(sql3, conn);

        cmdd3.ExecuteNonQuery();
        
        Response.Redirect("../business_partners.aspx");
    }

    public void filldata()
    {

        string msg;
      //  SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string dno = dockno;

        string sql = "select * from webx_oct_det where dockno='" + dno + "'";

        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2;
        conn.Open();

        //dno2= cmd.ExecuteScalar().ToString();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        da.Fill(ds);


        foreach (DataRow ddr in ds.Tables[0].Rows)
        {
            s1 = ddr["octamt"].ToString();
            s2 = ddr["recptno"].ToString();
            s3 = ddr["recptdt"].ToString();
            
        }

 

    }




    public void filltxt()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sqlGet = "select vendor_type,dEFAULT_aDDR,VENDORNAME,CONTRACTSTDT,CONTRACTENDDT,VENDORREMARKS,servtaxno,pan_no,vendorbstno,vendorcstno,opencredit,opendebit from webx_VENDOR_HDR where VENDORCODE = '" + vencode + "'";
        SqlCommand cmdGet = new SqlCommand(sqlGet, cn);
        SqlDataReader getDr = cmdGet.ExecuteReader();
        if (getDr.Read())
        {

           // ddVendorType.Text = getDr["vendor_type"].ToString();
            txtvenname.Text = getDr["VENDORNAME"].ToString();
            txtContractStartDate.Text = getDr["CONTRACTSTDT"].ToString();
            txtContractEndDt.Text = getDr["CONTRACTENDDT"].ToString();
            txtRemarks.Text = getDr["VENDORREMARKS"].ToString();
            servtaxno.Text = getDr["servtaxno"].ToString();
            PanNo.Text = getDr["pan_no"].ToString();
            vendorbstno.Text = getDr["vendorbstno"].ToString();
            vendorcstno.Text = getDr["vendorcstno"].ToString();
            txtOpnCrdt.Text = getDr["opencredit"].ToString();
            txtOpnCrdt.Text = getDr["opendebit"].ToString();
            txtAddress.Text = getDr["dEFAULT_aDDR"].ToString();
            
        }
        getDr.Close();
        cn.Close();
    }
    public void getGRDData()
    {
        //string sqlGet;
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sqlGetLoop = "select VENDORBRCD,VENDORCONTACT, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE,VENDORMOBILE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED from webx_VENDOR_DET where VENDORCODE='" + vencode + "'";
        SqlCommand cmdGet = new SqlCommand(sqlGetLoop, cn);
        SqlDataAdapter da = new SqlDataAdapter(cmdGet);
  
        da.Fill(ds_san);

        GV_D.DataSource = ds_san;
        GV_D.DataBind();

 

    }
     
}
