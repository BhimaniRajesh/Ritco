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
using System.IO;

public partial class GUI_Finance_Accounts_ChartOfAccount_ChartOfAccount : System.Web.UI.Page
{
    SqlConnection con;
    SqlConnection con1;
    SqlConnection con2;
    SqlConnection con3;
    SqlCommand cmd;
    SqlDataReader dr;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        con1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con1.Open();
        con2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con2.Open();
        con3 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con3.Open();
        if (!IsPostBack)
        {
            trvAcc.ExpandDepth = 0;
            //trvAcc.ExpandAll();
            FillTree();
        }

    }
    private void FillTree()
    {
        //Method = 2.1
        string[,] ParentNode = new string[100, 2];
        int count = 0;
        string strSql = "select  * from webx_groups WITH(NOLOCK) where grouplevel= 0 order by orderno";
        cmd = new SqlCommand(strSql, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            ParentNode[count, 0] = Convert.ToString(dr["GroupCode"]);
            ParentNode[count++, 1] = Convert.ToString(dr["GroupDesc"]);
        }
        dr.Close();
        for (int loop = 0; loop < count; loop++)
        {
            TreeNode root = new TreeNode();
            root.Text = ParentNode[loop, 1];
            string strSql1 = "select GroupCode,company_GroupCode+':'+GroupDesc as GroupDescval from webx_groups  WITH(NOLOCK) where ParentCode = '" + ParentNode[loop, 0] + "'";
            //string strSql1 = "select AccCode,AccDesc from webx_acctinfo where GroupCode = '" + ParentNode[loop, 0] + "'";
            cmd = new SqlCommand(strSql1, con);
            dr = cmd.ExecuteReader();
            string grpcode="";
            while (dr.Read())
            {
                TreeNode child = new TreeNode(Convert.ToString(dr["GroupDescval"]), Convert.ToString(dr["GroupCode"]));
                root.ChildNodes.Add(child);
                grpcode= Convert.ToString(dr["GroupCode"]);
                string sql_ledger = "select acccode,COmpany_acccode+':'+accdesc as accdescval from webx_acctinfo  WITH(NOLOCK) where groupcode='" + grpcode + "'";
                SqlCommand sqlcmd_ledger = new SqlCommand(sql_ledger, con1);
                SqlDataReader  Dr_ledeger=sqlcmd_ledger.ExecuteReader();
                while (Dr_ledeger.Read())
                {
                    TreeNode child1 = new TreeNode(Convert.ToString(Dr_ledeger["accdescval"]), Convert.ToString(Dr_ledeger["acccode"]));
                    child.ChildNodes.Add(child1);
                }
                Dr_ledeger.Close();

              
                grpcode = Convert.ToString(dr["GroupCode"]);
                sql_ledger = "select GroupCode,company_GroupCode+':'+GroupDesc as GroupDescval from webx_groups  WITH(NOLOCK) where ParentCode = '" + grpcode + "'";
                sqlcmd_ledger = new SqlCommand(sql_ledger, con2);
                Dr_ledeger = sqlcmd_ledger.ExecuteReader();
                while (Dr_ledeger.Read())
                {
                    TreeNode child2 = new TreeNode(Convert.ToString(Dr_ledeger["GroupDescval"]), Convert.ToString(Dr_ledeger["GroupCode"]));
                    child.ChildNodes.Add(child2);
                   

                    grpcode = Convert.ToString(Dr_ledeger["GroupCode"]);
                    string sql_ledger1 = "select COmpany_acccode+':'+accdesc as accdescval,acccode from webx_acctinfo  WITH(NOLOCK) where groupcode='" + grpcode + "'";
                    SqlCommand sqlcmd_ledger1 = new SqlCommand(sql_ledger1, con3);
                    SqlDataReader Dr_ledeger1 = sqlcmd_ledger1.ExecuteReader();
                    while (Dr_ledeger1.Read())
                    {
                        TreeNode child3 = new TreeNode(Convert.ToString(Dr_ledeger1["accdescval"]), Convert.ToString(Dr_ledeger1["acccode"]));
                        child2.ChildNodes.Add(child3);
                    }
                    Dr_ledeger1.Close();
                }
                Dr_ledeger.Close();
                
            }
            dr.Close();
            trvAcc.Nodes.Add(root);



        }

    }
    
    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}

    protected void btnXsl_Click(object sender, EventArgs e)
    {
        
        trvAcc.ExpandAll();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=ChartOfAccout.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(lblHeading);
        frm.Controls.Add(trvAcc);
        frm.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());
        Response.End();
    }
    
}
