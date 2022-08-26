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

public partial class GUI_Octroi_ViewnPrint_TypeMast : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        btnsubmit.Attributes.Add("onclick","javascript:return validateFields()");
        txtpaytypecode.Attributes.Add("onblur","javascript:return typeCheck()");
        btnreset.Attributes.Add("onclick", "javascript:return resetFields();");
        chkflag.Attributes.Add("onclick", "javascript:return ticTac(this);");
    }



    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        
        string sql="INSERT INTO webx_typemst(codetype_new,abbr_type,typedesc,activeflag) VALUES('" + txtpaytypecode.Text + "','" + txtshortdesc.Text + "','" + txtdetdesc.Text + "','" + txtflag.Text + "')";
        SqlCommand cmd = new SqlCommand(sql,con);

        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("PaymentTypeMasterEdit.aspx");
    }
}
