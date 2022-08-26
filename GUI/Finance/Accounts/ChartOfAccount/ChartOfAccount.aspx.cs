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
    SqlConnection con4;
    SqlConnection con5;
    SqlConnection con6;
    SqlConnection con7;
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
        con4 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con4.Open();
        con5 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con5.Open();
        con6 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con6.Open();
        con7 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con7.Open();
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
                    string Sub_grpcode = Convert.ToString(dr["GroupCode"]);

                    string sql_ledger2 = "select GroupCode,company_GroupCode+':'+GroupDesc as GroupDescval from webx_groups  WITH(NOLOCK) where ParentCode = '" + grpcode + "'";
                    SqlCommand sqlcmd_SUB_ledger = new SqlCommand(sql_ledger2, con4);

                    SqlDataReader Dr_Sub_ledeger = sqlcmd_SUB_ledger.ExecuteReader();
                    while (Dr_Sub_ledeger.Read())
                    {

                        TreeNode child4 = new TreeNode(Convert.ToString(Dr_Sub_ledeger["GroupDescval"]), Convert.ToString(Dr_Sub_ledeger["GroupCode"]));
                        child2.ChildNodes.Add(child4);
                        Sub_grpcode = Convert.ToString(Dr_Sub_ledeger["GroupCode"]);
                        string sql_ledger3 = "select COmpany_acccode+':'+accdesc as accdescval,acccode from webx_acctinfo  WITH(NOLOCK) where groupcode='" + Sub_grpcode + "'";
                        SqlCommand sqlcmd_ledger2 = new SqlCommand(sql_ledger3, con5);
                        SqlDataReader Dr_ledeger2 = sqlcmd_ledger2.ExecuteReader();
                        while (Dr_ledeger2.Read())
                        {
                            TreeNode child5 = new TreeNode(Convert.ToString(Dr_ledeger2["accdescval"]), Convert.ToString(Dr_ledeger2["acccode"]));
                            child4.ChildNodes.Add(child5);
                        }
                        Dr_ledeger2.Close();

                        Sub_grpcode = Convert.ToString(Dr_Sub_ledeger["GroupCode"]);

                        sql_ledger3 = "select GroupCode,company_GroupCode+':'+GroupDesc as GroupDescval from webx_groups  WITH(NOLOCK) where ParentCode = '" + Sub_grpcode + "'";
                        SqlCommand sqlcmd_SUB_ledger1 = new SqlCommand(sql_ledger3, con6);

                        SqlDataReader Dr_Sub_ledeger1 = sqlcmd_SUB_ledger1.ExecuteReader();
                        while (Dr_Sub_ledeger1.Read())
                        {

                            TreeNode child6 = new TreeNode(Convert.ToString(Dr_Sub_ledeger1["GroupDescval"]), Convert.ToString(Dr_Sub_ledeger1["GroupCode"]));
                            child4.ChildNodes.Add(child6);
                            Sub_grpcode = Convert.ToString(Dr_Sub_ledeger1["GroupCode"]);
                            string sql_ledger4 = "select COmpany_acccode+':'+accdesc as accdescval,acccode from webx_acctinfo  WITH(NOLOCK) where groupcode='" + Sub_grpcode + "'";
                            SqlCommand sqlcmd_ledger3 = new SqlCommand(sql_ledger4, con7);
                            SqlDataReader Dr_ledeger3 = sqlcmd_ledger3.ExecuteReader();
                            while (Dr_ledeger3.Read())
                            {
                                TreeNode child7 = new TreeNode(Convert.ToString(Dr_ledeger3["accdescval"]), Convert.ToString(Dr_ledeger3["acccode"]));
                                child6.ChildNodes.Add(child7);
                            }
                            Dr_ledeger3.Close();

                        }
                        Dr_Sub_ledeger1.Close();
                        
                    }
                    Dr_Sub_ledeger.Close();
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
