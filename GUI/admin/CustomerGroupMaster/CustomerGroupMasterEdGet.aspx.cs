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

public partial class GUI_admin_CustomerGroupMaster_CustomerGroupMasterEdGet : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    SqlCommand cmd = new SqlCommand();
    SqlDataReader drGrpcd, drBrcd;
    string grpcd = "";
    object[] b = null;

    public static string tCstGrpCd;
    public static string dCstGrp;

    public static string scriptStr, EmpCode, Emp, cd, pass2, p1;

    protected void Page_Load(object sender, EventArgs e)
    {

        
        getstring();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        if (IsPostBack == false)
        {
            pass2 = "************";
            string para = Request.QueryString["para"].ToString();
            if (para == "2")
            {
                dCstGrp = Request.QueryString["gname"].ToString();
                tCstGrpCd = Request.QueryString["grpcd"].ToString();
                getData();
            
            }
            else
            {
                dCstGrp = Session["dCstGrp"].ToString();
                tCstGrpCd = Session["tCstGrpCd"].ToString();
                getData();
            }

        }

    }


    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "select GRPNM from webx_GRPMST where grpcd <> '" + tCstGrpCd +"' ";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["GRPNM"] + "'"));
        }
        dr_Location.Close();
    }
    
    protected void chk1_CheckedChanged(object sender, EventArgs e)
    {
        if (chk1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }
    
    public void getData()
    {
        string sqlstrVal;
        cn.Open();
        if (tCstGrpCd != "")
        {
            sqlstrVal = "select GRPCD,GRPNM,GRP_Pwd,locregion,ActiveFlag from webx_GRPMST where GRPCD = '" + tCstGrpCd + "'";
        }
        else
        {
            sqlstrVal = "select GRPCD,GRPNM,GRP_Pwd,locregion,ActiveFlag from webx_GRPMST where GRPCD = '" + tCstGrpCd + "'";
        }
        SqlCommand cmdVal = new SqlCommand(sqlstrVal, cn);
        SqlDataReader drVal = cmdVal.ExecuteReader();
        if (drVal.Read())
        {
            lblGrpCd.Text = drVal[0].ToString();
            txtGroupName.Text = drVal[1].ToString();
            txtPwd.Text = drVal[2].ToString();

            p1 = drVal["GRP_Pwd"].ToString();
                    pass2 = pass2.Substring(0, p1.Length);
                    
                    txtPwd.Text = pass2;



            txtActFlag.Text = drVal[4].ToString();
            if (txtActFlag.Text == "Y" || txtActFlag.Text == "y")
            {
                chk1.Checked = true;
            }
            else
            {
                chk1.Checked = false;
            }
        }
        cn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cn.Open();
        cmd.Connection = cn;
        //cmd.CommandText = "update webx_GRPMST set GRPCD='" + lblGrpCd.Text + "', GRPNM='" + txtGroupName.Text + "',GRP_Pwd='" + txtPwd.Text + "',locregion='" + ddRgLoc.SelectedValue.ToString() + "',ActiveFlag='" + txtActFlag.Text + "' where GRPCD = '" + tCstGrpCd + "'";

        string pw = "";
        if (txtPwd.Text == pass2)
        {
            pw = p1;
        }
        else
        {
            pw = txtPwd.Text;
        }


        cmd.CommandText = "update webx_GRPMST set GRPCD='" + lblGrpCd.Text + "', GRPNM='" + txtGroupName.Text + "',GRP_Pwd='" + pw+ "',ActiveFlag='" + txtActFlag.Text + "' where GRPCD = '" + tCstGrpCd + "'";
        cmd.ExecuteNonQuery();
        cn.Close();
        Response.Redirect("CustomerGroupMasterEdit.aspx");

        //string[] strLocCode = dLoc.ToString().Split(':');

    }
    protected void ln1_Click(object sender, EventArgs e)
    {
        txtPwd.Text = "";
        txtPwd.ReadOnly = false;
        txtPwd.TextMode = TextBoxMode.Password;
        
    }
}

