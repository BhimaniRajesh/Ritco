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
using System.Configuration;


public partial class GUI_Finance_GeneralizedPO_AssetMaster_AssetMasterAdd : System.Web.UI.Page
{
    public static string straccd, p;
    protected void Page_Load(object sender, EventArgs e)
    {
        p = Request.QueryString["Operation"].ToString();
        if (!IsPostBack)
        {
            straccd = "";
            if (p == "ADD")
            {
                GroupCode();
            }
            else
            {
                GroupCode();
                straccd = Request.QueryString["accode"].ToString();
                FillData();
            }
        }
        btn_submit.Attributes.Add("onclick", "javascript:return ValidateData()");
    }
    public void GroupCode()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Qry = "Select '--Select--' AS Accdesc,'' as Acccode UNION Select Accdesc,Acccode from webx_acctinfo where Groupcode in (select distinct Groupcode from webx_groups where main_category='EXPENSE')order by Accdesc";
        SqlCommand sqlcmd = new SqlCommand(Qry, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        ddlCreditAccount.DataSource = ds;
        ddlCreditAccount.DataTextField = "Accdesc";
        ddlCreditAccount.DataValueField = "Acccode";
        ddlCreditAccount.DataBind();
        ddlCreditAccount.CssClass = "blackfnt";
    }
    public void FillData()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string q = "SELECT * FROM WEBX_GENERAL_ASSETMASTER WHERE ASSETCD='" + straccd + "'";
        SqlCommand c = new SqlCommand(q, cn);
        SqlDataReader dr = c.ExecuteReader();
        while (dr.Read())
        {
            txtdesc.Text = dr["assetname"].ToString();
            txtprefix.Text = dr["prefix"].ToString();
            l1.Text = straccd;
            ddlCreditAccount.SelectedValue = dr["AccCode"].ToString();
        }
        dr.Close();
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string acd = GenerateNextCode();
        string ResponseStr = "";
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            string sql = "";
            string ActiveChk = "";
            ActiveChk = ((ChkActive.Checked == true) ? "Y" : "N");
            if (p == "ADD")
            {

                sql = "INSERT INTO WEBX_GENERAL_ASSETMASTER(ASSETCD,ASSETNAME,ENTRYBY,ENTRYON,prefix,AccCode,AccDesc,Active) values('" + acd + "','" + txtdesc.Text + "','" + Session["empcd"].ToString() + "',getdate(),'" + txtprefix.Text + "','" + ddlCreditAccount.SelectedValue + "','" + ddlCreditAccount.SelectedItem + "','" + ActiveChk + "')";
                ResponseStr = "&ASSETCODE=" + acd;
            }
            else
            {
                sql = "UPDATE WEBX_GENERAL_ASSETMASTER SET ASSETNAME='" + txtdesc.Text + "',UPDTBY='" + Session["empcd"].ToString() + "',UPDTON=getdate(),PREFIX='" + txtprefix.Text + "',AccCode='" + ddlCreditAccount.SelectedValue + "',AccDesc='" + ddlCreditAccount.SelectedItem + "',Active='" + ActiveChk + "' WHERE assetcd='" + straccd + "'";
                ResponseStr = "&ASSETCODE=" + straccd;
            }
            SqlCommand sqlcmd = new SqlCommand(sql, conn, trans);
            sqlcmd.ExecuteNonQuery();
            trans.Commit();
            conn.Close();
            Response.Redirect("AssetMasterDone.aspx?DocTypeFlag=" + p + ResponseStr, false);
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.End();
        }
    }
    public string GenerateNextCode()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "SELECT ISNULL(MAX(CONVERT(INT,SUBSTRING(ASSETCD,3,6))),0)+1 AS MAXOCAGCD FROM WEBX_GENERAL_ASSETMASTER";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        int cd1 = (int)sqlcmd.ExecuteScalar();
        string cd = Convert.ToString(cd1);
        if (cd.Length == 1)
        {
            cd = "GA" + "0000" + cd;
        }
        else if (cd.Length == 2)
        {
            cd = "GA" + "000" + cd;
        }
        else if (cd.Length == 3)
        {
            cd = "GA" + "00" + cd;
        }
        else if (cd.Length == 4)
        {
            cd = "GA" + "0" + cd;
        }
        else if (cd.Length == 5)
        {
            cd = "GA" + cd;
        }
        return cd;
    }
   
}
