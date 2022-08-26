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

public partial class GUI_admin_BLanceSheet_Category : System.Web.UI.Page
{
    SqlConnection Conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblStatus.Visible = false;
    }
    protected void Balcat_SelectedIndexChanged(object sender, EventArgs e)
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string BSCAT = Balcat.SelectedValue.ToString();
        string SQL = "";
        if (BSCAT == "1")
        {
            SQL = "select groupcode,groupdesc=isnull(g.company_groupcode,g.groupcode)+' : '+groupdesc,bstype,bstypeno,CAT1=(case when bstype='AF' then 'Y' else 'N' end ),CAT2=(case when bstype='CA' then 'Y' else 'N' end ) from webx_groups g with(NOLOCK) where  main_category='ASSET'";
           
            TR1.Style["display"] = "block";
        }
        else if (BSCAT == "2")
        {
            SQL = "select groupcode,groupdesc=isnull(g.company_groupcode,g.groupcode)+' : '+groupdesc,bstype,bstypeno,CAT1=(case when bstype='SF' then 'Y' else 'N' end ),CAT2=(case when bstype='CL' then 'Y' else 'N' end ) from webx_groups g with(NOLOCK) where  main_category='LIABILITY'";
            TR1.Style["display"] = "block";
        }
        else 
        {
            TR1.Style["display"] = "none";
        }
        SqlCommand CMD = new SqlCommand(SQL, Conn);
        SqlDataAdapter da = new SqlDataAdapter(CMD);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GV_D.DataSource = ds;
        GV_D.DataBind();

        Conn.Close();
    }
    protected void GV_D_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
                  if (e.Row.RowType == DataControlRowType.Header)
                  {
                      //string BSCAT = Balcat.SelectedValue.ToString();
                      //if (BSCAT == "1")
                      //{
                      //    e.Row.Cells[2].Text = "Application Of Funds";
                      //    e.Row.Cells[3].Text = "Current Assets, Loans & Advances";
                      //}
                      //else
                      //{
                      //    e.Row.Cells[2].Text = "Source Of Funds";
                      //    e.Row.Cells[3].Text = "Current Liabilities & Provisions";
                      //}

                  }
                  if (e.Row.RowType == DataControlRowType.DataRow)
                  {
                      Label lbBASCAT1 = (Label)e.Row.FindControl("lblChkCat1");
                      Label lbBASCAT2 = (Label)e.Row.FindControl("lblChkCat2");

                      //CheckBox BSChkcat1 = (CheckBox)e.Row.FindControl("ChkCat1");
                      //CheckBox BSChkcat2 = (CheckBox)e.Row.FindControl("ChkCat2");

                      string BSCAT = Balcat.SelectedValue.ToString();
                      DropDownList DLLBalCat = (DropDownList)e.Row.FindControl("DLLBalCat");

                      if (BSCAT == "1")
                      {
                          DLLBalCat.Items.Clear();
                          DLLBalCat.Items.Add(new ListItem("--Select--", ""));
                          DLLBalCat.Items.Add(new ListItem("Application Of Funds", "AF"));
                          DLLBalCat.Items.Add(new ListItem("Current Assets, Loans & Advances", "CA"));             
                             
                         
                      }
                      else
                      {
                          DLLBalCat.Items.Clear();
                          DLLBalCat.Items.Add(new ListItem("--Select--", ""));
                          DLLBalCat.Items.Add(new ListItem("Source Of Funds", "SF"));
                          DLLBalCat.Items.Add(new ListItem("Current Liabilities & Provisions", "CL"));
                      }

                      DLLBalCat.SelectedValue = lbBASCAT2.Text;

                      //if (lbBASCAT1.Text.ToString() == "Y")
                      //{
                      //    BSChkcat1.Checked = true;
                      //}
                      //else
                      //{
                      //    BSChkcat1.Checked = false;
                      //}

                      //if (lbBASCAT2.Text.ToString() == "Y")
                      //{
                      //    BSChkcat2.Checked = true;
                      //}
                      //else
                      //{
                      //    BSChkcat2.Checked = false;
                      //}


                      
                  }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        SqlTransaction trans;
        trans = Conn.BeginTransaction();
         try
         {
             foreach (GridViewRow gridrow in GV_D.Rows)
             {
                 DropDownList DLLBalCat = (DropDownList)gridrow.FindControl("DLLBalCat");
                 Label lblgroupcode = (Label)gridrow.FindControl("lblgroupcode");
                    string BSCATno="";
                    if (DLLBalCat.SelectedValue.ToString() == "SF")
                        BSCATno = "A";
                    else if (DLLBalCat.SelectedValue.ToString() == "AF")
                        BSCATno = "B";
                    else if (DLLBalCat.SelectedValue.ToString() == "CA")
                        BSCATno = "C";
                    else if (DLLBalCat.SelectedValue.ToString() == "CL")
                        BSCATno = "D";


                    string SQL = "update webx_groups set bstype='" + DLLBalCat.SelectedValue.ToString() + "',bstypeno='" + BSCATno + "' where groupcode='" + lblgroupcode.Text.ToString() + "'";
                 SqlCommand CMD = new SqlCommand(SQL, Conn);
                 CMD.Transaction = trans;
                 CMD.ExecuteNonQuery();
             }

             trans.Commit();
             lblStatus.Visible = true;
             lblStatus.Text = "Done";
         }
         catch (Exception e1)
         {
             Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
             trans.Rollback();

         }
         finally
         {
             Conn.Close();
         }


       

    }
}
