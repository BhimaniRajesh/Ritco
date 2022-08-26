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

public partial class GUI_admin_CustomerMaster_CustomerMasterAdd : System.Web.UI.Page
{
    public static string strGrpCd;
    public static string strCustCd;
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            strGrpCd = Session["strGrpCdS"].ToString().Trim();
            lblGrpCd.Text = strGrpCd;
        }
        
        txtMblNo.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this);lenthless(this)");
        txtStNo.Attributes.Add("onblur", "javascript:return Falphanum(this)");
        txtCstNo.Attributes.Add("onblur", "javascript:return Falphanum(this)");
        txtOpnDbt.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this)");
        txtOpnCrdt.Attributes.Add("onblur", "javascript:return Nagative_Chk_wDecimal(this)");
        

        txtCstLoc.ForeColor = System.Drawing.Color.Black;



    }
    protected void c1_CheckedChanged(object sender, EventArgs e)
    {
        if (c1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }
    protected void c2_CheckedChanged(object sender, EventArgs e)
    {
        if (c2.Checked == true)
        {
            txtMblSer.Text = "Y";
        }
        else
        {
            txtMblSer.Text = "N";
        }
    }
    public string getNewCd(string strGrpCd)
    {
        int intCustCode = 1;

        //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        SqlCommand cmdGet = new SqlCommand("select cast(right(max(custcd), 4) as numeric(18, 0)) + 1 from webx_CUSTHDR where grpcd='" + strGrpCd + "'", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();
        
        if (drGet.Read())
        {
            intCustCode = Convert.ToInt32(drGet[0].ToString());
        }
        
        drGet.Close();
         
        cn.Close();

        return strGrpCd + intCustCode.ToString().PadLeft(4, '0');
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        string locstr = txtCstLoc.Text;
        string locvalid = loc_validcheck(locstr);

        if (locvalid == "1")
        {
            strCustCd = getNewCd(strGrpCd);
            cn.Open();
            string sqlAdd = "insert into webx_CUSTHDR(GRPCD,CUSTCD,CUSTNM,CUSTPASS,CUSTCAT,CUST_ACTIVE,MOBSERV_ENABLED,MOBILENO,STNUM,CSTNO,UPDTBY,UPDTON,opendebit,opencredit,CUSTLOC,CustAddress) values('" + strGrpCd + "','" + strCustCd + "','" + txtCstNm.Text.Trim() + "','" + strCustCd + "','" + ddCstCat.SelectedValue + "','" + txtActFlag.Text + "','" + txtMblSer.Text.Trim() + "','" + txtMblNo.Text.Trim() + "','" + txtStNo.Text.Trim() + "','" + txtCstNo.Text.Trim() + "','" + Session["empcd"].ToString().Trim() + "','" + getDateInddMMMyyyFormat(System.DateTime.Today.ToString("dd/MM/yyyy")) + "'," + (txtOpnDbt.Text.Trim() == "" ? "0" : txtOpnDbt.Text.Trim()) + "," + (txtOpnCrdt.Text.Trim() == "" ? "0" : txtOpnCrdt.Text.Trim()) + ",'" + txtCstLoc.Text.Trim() + "','" + txtCstAddress.Text.Trim() + "')";
            SqlCommand cmdAdd = new SqlCommand(sqlAdd, cn);
            cmdAdd.ExecuteNonQuery();
            cn.Close();
            Response.Redirect("CustomerMaster.aspx");
        }
        else
        {
            txtCstLoc.ForeColor = System.Drawing.Color.Red;
            txtCstLoc.Text = "Enter Valid Location";

        }
    }


    public string loc_validcheck(string loc)
    {
        string loc2=loc;
        string[] loc3=loc2.Split(',');
        string result="";
        int len = loc3.Length;
        for(int i=0;i<len;i++)
        {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

          string l = loc3[i];

         string sql = "select* from webx_location where Loccode='" + l + "'";


           SqlCommand cmd = new SqlCommand(sql, conn);

           string dno2;
           conn.Open();

           SqlDataAdapter da = new SqlDataAdapter(cmd);

           DataSet ds = new DataSet();

           da.Fill(ds);
 
           if (ds.Tables[0].Rows.Count == 0)
           {
              result="0";
               return result;
               break;
           }
           else
           {
              result="1";
           }
       }


        return result;
        
        }




  

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Server.Transfer("CustomerMaster.aspx");
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        //if (TextBox1.Text != "")
        //{
        //    Session["tLocCod"] = TextBox1.Text;
        //    //Session["tCstCd"] = "";
        //    //Session["popCustCd"] = "";
        //    Server.Transfer("AddCustLocwithDiffAddressEdit.aspx");
        //}
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session["t1LocCod"] = "";
        Server.Transfer("AddCustLocwithDiffAddress.aspx");
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        lblGrpCd.Text = strGrpCd;
        txtCstNm.Text = "";
        ddCstCat.Text = "";
        txtActFlag.Text = "";
        txtMblSer.Text = "";
        txtMblNo.Text = "";
        txtStNo.Text = "";
        txtCstNo.Text = "";
        txtOpnDbt.Text = "";
        txtOpnCrdt.Text = "";
        txtCstLoc.Text = "";
        txtCstAddress.Text = "";
    }

    private string getDateInddMMMyyyFormat(string strDate)
    {
        string[] strDateParts = strDate.Split('/');

        return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }
}
