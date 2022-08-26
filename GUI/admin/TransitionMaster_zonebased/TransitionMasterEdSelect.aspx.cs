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

public partial class GUI_admin_TransitionMaster_TransitionMasterEdSelect : System.Web.UI.Page
{
    // SqlConnection cn;
    public int zoneno;
    public string[] arrzonename;
    public string[] arrzonecode;
    protected void Page_Load(object sender, EventArgs e)
    {
        //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // getstring3();

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string str = "SELECT COUNT(codeid) FROM webx_master_general WHERE codetype='zone' AND statuscode='Y'";
        SqlCommand cm = new SqlCommand(str, cn);
        zoneno = Convert.ToInt16(cm.ExecuteScalar());
        arrzonename = new string[zoneno];
        arrzonecode = new string[zoneno];

        str = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='zone' AND statuscode='Y' ORDER BY codeid";
        cm = new SqlCommand(str, cn);
        SqlDataReader dr = cm.ExecuteReader();
        int i = 0;

        while (dr.Read())
        {
            Page.RegisterArrayDeclaration("arrzonecode", "'" + Convert.ToString(dr["codeid"] + "'"));
            Page.RegisterArrayDeclaration("arrzonename", "'" + Convert.ToString(dr["codedesc"] + "'"));

            arrzonecode[i] = dr["codeid"].ToString();
            arrzonename[i] = dr["codedesc"].ToString();
            i++;

        }
        if (arrzonename == null)
        {
            arrzonename[0] = "sasas";
        }
        dr.Close();
    }

   
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Session["tOrgnBranch"] = txtOrgnBranch.Text;
        //Session["tDestBranch"] = txtDestBranch.Text;
        //Session["tTransLocCod"] = txtTransLocCod.Text;
        //Server.Transfer("TransitionMasterEdit.aspx");

        if (txtTransLocCod.Text == "") // && txtOrgnBranch.Text != "" && txtDestBranch.Text != "")
        {
            Session["tOrgnBranch"] = txtOrgnBranch.Text;
            Session["tDestBranch"] = txtDestBranch.Text;
            Session["tTransLocCod"] = "";
            Server.Transfer("TransitionMasterEdit.aspx");
        }
        else //if (txtTransLocCod.Text != "" && txtOrgnBranch.Text == "" && txtDestBranch.Text == "")
        {
            Session["tTransLocCod"] = txtTransLocCod.Text;
            Session["tOrgnBranch"] = "";
            Session["tDestBranch"] = "";
            Server.Transfer("TransitionMasterEdit.aspx");
        }
    }

     
}
