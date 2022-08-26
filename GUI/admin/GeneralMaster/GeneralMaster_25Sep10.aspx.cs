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

public partial class GUI_admin_GenralMaster_GenralMaster : System.Web.UI.Page
{
    string mastercode = "", mastertype = "", headeraccess = "", statuscode = "", flag = "";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        mastercode = Request.QueryString["mastercode"].ToString();

        

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        /***************************************************************************************************************
                                    LOADING MASTER PERSONAL SETTINGS
        ****************************************************************************************************************/
        string s = "SELECT * FROM webx_master_codetypes WHERE headercode='" + mastercode + "'";
        s = s + "  AND activeflag_YN='Y'";
        con.Open();
        SqlCommand cd = new SqlCommand(s, con);
        SqlDataReader dr = cd.ExecuteReader();
        dr.Read();
        lblmasterheader.Text = dr["headerdesc"].ToString();
        lblcodedisc.Text = dr["id_desc"].ToString();
        lblprimarytext.Text = dr["name_desc"].ToString();
        headeraccess = dr["headeraccess"].ToString();
        // statuscode = dr["single_screen"].ToString();
        mastertype = dr["id_desc"].ToString();
        flag = dr["activeflag_YN"].ToString();
        dr.Close();

        trcode.Style["display"] = "block";
        btnone.Text = "Save";
        txtprimary.Width = 300;
        txtprimary.Attributes.Add("onblur", "caps(this.getAttribute('id'))");
        lblautocode.Text = Convert.ToString(newCode());
    }


    protected void btnone_Click(object sender, EventArgs e)
    {
        data_Save();
    }

    protected void btntwo_Click(object sender, EventArgs e)
    {
        Response.Redirect("GeneralMasterEdit.aspx?mastercode=" + mastercode);
    }

    public string newCode()
    {
        int nwCd = 0;
        //string sqlCode = "SELECT max(codeid)+1 FROM webx_master_general WHERE codetype='" + mastercode +"'";
        string sqlCode = "SELECT MAX(codeid) FROM webx_master_general WHERE codetype='" + mastercode + "'";

        SqlCommand cmd = new SqlCommand(sqlCode, con);
        string codeid = Convert.ToString(cmd.ExecuteScalar());
        string codealfa = "", codenum = "";
        for (int i = 0; i < codeid.Length; i++)
        {
            if (!IsNumeric(codeid.Substring(i, 1)))
            {
                codealfa = codealfa + codeid.Substring(i, 1);
            }
            else
            {
                codenum = codenum + codeid.Substring(i, 1);
            }
        }

        int codeidnum = 0;
        try
        {
            codeidnum = Convert.ToInt16(codenum);
        }
        catch (Exception ex)
        {
            codeidnum = 0;
        }
        codeidnum++;

        codeid = codealfa + codeidnum.ToString();

        if (codeid.CompareTo("") == 0)
            codeid = "1";

        string flag_exist = "", strsql = "";
        int ncode = 0;
        bool flag = true;
        while (flag)
        {
            strsql = "SELECT codeid FROM webx_master_general WHERE codetype='" + mastercode + "' AND codeid='" + codeid + "'";
            cmd = new SqlCommand(strsql, con);
            flag_exist = Convert.ToString(cmd.ExecuteScalar());
            if (flag_exist.CompareTo("") != 0)
            {
                try
                {
                    ncode = Convert.ToInt16(codeid);
                }
                catch (Exception ex)
                {
                    ncode = 0;
                }
                ncode++;
                codeid = ncode.ToString();
                flag_exist = "";
            }
            else
            {
                flag = false;
            }
        }
        return codeid;
    }


    protected void data_Save()
    {
        if (txtprimary.Text.CompareTo("") == 0)
        {
            Response.Write("<script>alert('Enter " + mastertype + " Properly...');</script>");
            return;
        }

        string sql = "SELECT codedesc FROM webx_master_general WHERE codetype='" + mastercode + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        string codedesc = "";
        while (dr.Read())
        {
            if (dr["codedesc"].ToString().CompareTo(txtprimary.Text) == 0)
            {
                Response.Write("<script>alert('This " + mastertype + " Already Exists.....Enter Another');</script>");
                txtprimary.Text = "";
                txtprimary.Focus();
                return;
            }
        }
        dr.Close();

        int nodigs = 0, nochars = 0, ncode = 0;
        bool flag = true;
        string strsql = "", newcode = "", flag_exist = "";
        newcode = newCode();


        string sqlAdd = "INSERT INTO webx_master_general VALUES('" + mastercode + "','" + newcode + "','" + txtprimary.Text + "','" + headeraccess + "','Y','" + DateTime.Now + "','ADMIN','" + DateTime.Now + "',''," + nodigs + "," + nochars + ",'')";
        cmd = new SqlCommand(sqlAdd, con);

        cmd.ExecuteNonQuery();
        Response.Write("<script>alert('Data Entered Successfully.......');</script>");
        txtprimary.Text = "";
        txtprimary.Focus();

        Response.Redirect("GeneralMaster.aspx?mastercode=" + mastercode);
    }

    // NUMERIC COMPARATOR
    private bool IsNumeric(object ValueToCheck)
    {
        double Dummy = new double();
        string InputValue = Convert.ToString(ValueToCheck);

        bool Numeric = double.TryParse(InputValue, System.Globalization.NumberStyles.Any, null, out Dummy);

        return Numeric;
    }
}
