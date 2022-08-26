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


public partial class GUI_admin_StateMaster_StateMasterAdd : System.Web.UI.Page
{
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    SqlConnection cn;
    public DataTable dt_san = new DataTable();
    public static string City_str = "", edit_yn = "", Stateid = "", txtstateid = "", cityFlg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        //lbstcd.Text = "<System Generated...>";
      //  Stateid = Request.QueryString["id"];
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        { 
           
            roww.Text = "1";
            creatgrd();
         
            City_str = getLocationStr();
        }
        
         

        if (!(Page.IsPostBack))
        {
              
                RetriveData();
                
                cityFlg = "Y";
                
            
        }
        txtStateName.Attributes.Add("onChange", "javascript:this.value=this.value.toUpperCase()");
        txtStateName.Attributes.Add("onblur", "javascript:return Citycheck(this)");
        roww.Attributes.Add("onblur", "javascript:return IsNumericWoDot(this)");
      
        
        txtUpdtState.Attributes.Add("onclick", "javascript:return validateData()");
    }

     protected void roww_TextChanged(object sender, EventArgs e)
    {

        creatgrd();
    }

    public void creatgrd()
    {

        int rowno;
        
                rowno = Convert.ToInt32(roww.Text);


                dt_san.Clear();
                Int32 i;
                DataRow drow;


                for (i = 0; i < rowno; i++)
                {
                    drow = dt_san.NewRow();
                    dt_san.Rows.Add(drow);

                }


                GV_D.DataSource = dt_san;
                GV_D.DataBind();

                //string s = "select top " + rowno + " * from sno";
                //SqlCommand c1 = new SqlCommand(s, cn);
                //DataSet ds = new DataSet();
                //SqlDataAdapter da = new SqlDataAdapter(c1);
                //da.Fill(ds);
                //GV_D.DataSource = ds;
                //GV_D.DataBind();
      
    }

    public string getCd()
    {
        string strNewStateCode = "0";
        if (cn.State != ConnectionState.Open)
        {
            cn.Open();
        }
        string spsql = "Usp_get_next_state_code";

        SqlCommand spcmd = new SqlCommand(spsql, cn);
        spcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter sqlDA = new SqlDataAdapter(spcmd);

        DataSet dsNextStateCode = new DataSet();

        sqlDA.Fill(dsNextStateCode);

        if (dsNextStateCode.Tables[0].Rows.Count > 0)
        {
            strNewStateCode = dsNextStateCode.Tables[0].Rows[0][0].ToString();
        }

        return strNewStateCode;
    }
    protected void chk11_CheckedChanged(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            CheckBox chk1 = (CheckBox)gridrow.FindControl("chk11");
            TextBox txtActive = (TextBox)gridrow.FindControl("txtActive");
          //  TextBox ODAKM = (TextBox)gridrow.FindControl("txtODA_KM");

            if (chk1.Checked == true)
            {
                txtActive.Text = "Y";
               
            }
            else
                if (chk1.Checked == false)
                {
                    txtActive.Text = "N";
                    
                    
                }
        }
    }


    public string getLocationStr()
    {


        string Citystr = "";
        //string descd = destn.Text.ToString();
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();



        string sql = "SELECT stnm FROM  webx_state";
        SqlCommand sqlCommand = new SqlCommand(sql, sqlConn);

        SqlDataReader dr_City = null;
        dr_City = sqlCommand.ExecuteReader();



        while (dr_City.Read())
        {
            if (Citystr == "")
            {
                Citystr = dr_City.GetValue(0).ToString();
            }
            else
            {
                Citystr = Citystr + "," + dr_City.GetValue(0).ToString();
            }


        }
        dr_City.Close();
        sqlConn.Close();
        return Citystr;
    }

    private void RetriveData()
    {
        /// SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
        /// 
        cn.Open();
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtDoc = (TextBox)gridrow.FindControl("txtDoc");
            DropDownList ddBound1 = (DropDownList)gridrow.FindControl("ddBound1");
            TextBox txtActive = (TextBox)gridrow.FindControl("txtActive");

            CheckBox chk11 = (CheckBox)gridrow.FindControl("chk11");

            string sql = "select * from webx_state where STCD='" + Stateid + "' ";
            SqlCommand cmd1 = new SqlCommand(sql, cn);
            SqlDataReader dr = cmd1.ExecuteReader();

            while (dr.Read())
            {

                ddBound1.SelectedValue = Convert.ToString(dr["inoutbound"]);
                txtDoc.Text = Convert.ToString(dr["stform"]);
                txtActive.Text = Convert.ToString(dr["activeflag"]);

                txtStateName.Text = Convert.ToString(dr["stnm"]);




                if (txtActive.Text == "Y")
                {
                    chk11.Checked = true;
                }
                else
                {
                    chk11.Checked = false;
                }
            }
            dr.Close();
        }
    }

    protected void txtUpdtState_Click(object sender, EventArgs e)
    {

         SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        String stcd = getCd();
        int totroww = 0;
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtDoc = (TextBox)gridrow.FindControl("txtDoc");
            DropDownList ddBound1 = (DropDownList)gridrow.FindControl("ddBound1");
            TextBox txtActive = (TextBox)gridrow.FindControl("txtActive");


            CheckBox actch = (CheckBox)gridrow.FindControl("chk11");

            CheckBox chksrno = (CheckBox)gridrow.FindControl("chksrno");


            string str = "";
            if (actch.Checked == true)
            {
                str = "Y";
            }
            else
            {
                str = "N";
            }


            if (chksrno.Checked == true)
            {
                if (txtStateName.Text != "")
                {
                    totroww = totroww + 1;
                    string spsql = "insert into webx_state(stcd,stnm,stform,activeflag,inoutbound,updtby,updton) values ";
                    spsql = spsql + "('" + stcd + "','" + txtStateName.Text + "','" + txtDoc.Text + "','" + txtActive.Text + "','" + ddBound1.SelectedValue + "','" + Session["empcd"] + "',getdate())";
                    SqlCommand valCmd = new SqlCommand(spsql, cn);
                    valCmd.ExecuteNonQuery();

                }
            }
        }
           
         

 

        Response.Redirect("../COMPANY_STRUCTURE.aspx");
        cn.Close();
    }
}
