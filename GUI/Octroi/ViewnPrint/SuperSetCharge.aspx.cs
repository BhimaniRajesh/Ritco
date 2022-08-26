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

public partial class GUI_Octroi_ViewnPrint_DText : System.Web.UI.Page
{
    double nRecords = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string qrypos1 = "SELECT * FROM webx_docket_charges_applicable WHERE operand='+' ORDER BY srno";
        SqlCommand cmd1 = new SqlCommand(qrypos1, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        da.Fill(ds, "tb");
        nRecords = ds.Tables[0].Rows.Count;
        

       

        string qrypos = "SELECT * FROM webx_docket_charges_applicable WHERE operand='+' ORDER BY srno";
        SqlCommand cmd = new SqlCommand(qrypos,con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

       

        
        
        int i = 0;
        while (dr.Read())
        {
            
            TableRow tr = new TableRow();
            tr.BackColor = System.Drawing.Color.White;

            TableCell tc = new TableCell();
            TableCell tccheck = new TableCell();
            TableCell tc2 = new TableCell();
            TableCell tc2check = new TableCell();


             LinkButton l1=new LinkButton();
             TextBox txt1 = new TextBox();
             CheckBox chk = new CheckBox();


          



            l1.Attributes.Add("onmouseover", "this.style.cursor='pointer'");
            chk.Attributes.Add("onmouseover", "this.style.cursor='pointer'");



            l1.ID = "lbl" + dr["srno"].ToString();
            txt1.ID = "txt" + dr["srno"].ToString();
            chk.ID = "chk" + dr["srno"].ToString();


            
            
            txt1.Style.Add("display","none");
            l1.Text=dr["chargename"].ToString() + " ( " + dr["operand"].ToString() + " ) ";
            l1.Attributes.Add("onclick", "javascript:return openText(this.getAttribute('id'),'" + txt1.ClientID.ToString() + "','" + l1.Text.ToString() + "')");
          

            if (dr["Applicabl_YN"].ToString().CompareTo("Y") == 0)
            {
                chk.Checked = true;
            }


            tccheck.Controls.Add(chk);
            tc.Controls.Add(l1);
            tc.Controls.Add(txt1);
            
            tc.HorizontalAlign = HorizontalAlign.Left;
            tc.CssClass = "blackfnt";

            LinkButton l2 = new LinkButton();
            TextBox txt2 = new TextBox();
            CheckBox chk2 = new CheckBox();




            
          
            if (dr.Read())
            {
                i++;


                l2.ID = "lbl" + dr["srno"].ToString();
                txt2.ID = "txt" + dr["srno"].ToString();
                chk2.ID = "chk" + dr["srno"].ToString();


                l2.Attributes.Add("onmouseover", "this.style.cursor='pointer'");
                chk2.Attributes.Add("onmouseover", "this.style.cursor='pointer'");



                txt2.Style.Add("display", "none");
                l2.Text = dr["chargename"].ToString() + " ( " + dr["operand"].ToString() + " ) ";
                l2.Attributes.Add("onclick", "javascript:return openText(this.getAttribute('id'),'" + txt2.ClientID.ToString() + "','" + l2.Text.ToString() + "')");
          

                if (dr["Applicabl_YN"].ToString().CompareTo("Y") == 0)
                {
                    chk2.Checked = true;
                }


                tc2check.Controls.Add(chk2);
                tc2.Controls.Add(l2);
                tc2.Controls.Add(txt2);
            }
                tc2.HorizontalAlign = HorizontalAlign.Left;
                tc2.CssClass = "blackfnt";

                tr.Cells.Add(tccheck);
                tr.Cells.Add(tc);
                tr.Cells.Add(tc2check);
                tr.Cells.Add(tc2);


                tbltextboxes.Rows.Add(tr);
                i++;
           
           
        } //while

        dr.Close();


        string qryneg = "SELECT * FROM webx_docket_charges_applicable WHERE operand='-' ORDER BY srno";
        SqlCommand cmdneg = new SqlCommand(qryneg, con);
        SqlDataReader drneg;
        
        dr = cmdneg.ExecuteReader();
       
        while (dr.Read())
        {
           
            TableRow tr = new TableRow();
            tr.BackColor = System.Drawing.Color.White;

            TableCell tc = new TableCell();
            TableCell tccheck = new TableCell();
            TableCell tc2 = new TableCell();
            TableCell tc2check = new TableCell();


            LinkButton l1 = new LinkButton();
            TextBox txt1 = new TextBox();
            CheckBox chk = new CheckBox();

            //l1.Click += new EventHandler(openText);


            l1.Attributes.Add("onmouseover", "this.style.cursor='pointer'");
            chk.Attributes.Add("onmouseover", "this.style.cursor='pointer'");



            l1.ID = "lbl" + dr["srno"].ToString();
            txt1.ID = "txt" + dr["srno"].ToString();
            chk.ID = "chk" + dr["srno"].ToString();




            txt1.Style.Add("display", "none");
            l1.Text = dr["chargename"].ToString() + " ( " + dr["operand"].ToString() + " ) ";
            l1.Attributes.Add("onclick", "javascript:return openText(this.getAttribute('id'),'" + txt1.ClientID.ToString() + "','" + l1.Text.ToString() + "')");
          

            if (dr["Applicabl_YN"].ToString().CompareTo("Y") == 0)
            {
                chk.Checked = true;
            }


            
            tccheck.Controls.Add(chk);
            tc.Controls.Add(l1);
            tc.Controls.Add(txt1);
            
            tc.HorizontalAlign = HorizontalAlign.Left;
            tc.CssClass = "blackfnt";

            LinkButton l2 = new LinkButton();
            TextBox txt2 = new TextBox();
            CheckBox chk2 = new CheckBox();

            if (dr.Read())
            {
                i++;
                l2.ID = "lbl" + dr["srno"].ToString();
                txt2.ID = "txt" + dr["srno"].ToString();
                chk2.ID = "chk" + dr["srno"].ToString();


                l2.Attributes.Add("onmouseover", "this.style.cursor='pointer'");
                chk2.Attributes.Add("onmouseover", "this.style.cursor='pointer'");



                txt2.Style.Add("display", "none");
                l2.Text = dr["chargename"].ToString() + " ( " + dr["operand"].ToString() + " ) ";
                l2.Attributes.Add("onclick", "javascript:return openText(this.getAttribute('id'),'" + txt2.ClientID.ToString() + "','" + l2.Text.ToString() + "')");
          


                if (dr["Applicabl_YN"].ToString().CompareTo("Y") == 0)
                {
                    chk2.Checked=true;
                }

                tc2check.Controls.Add(chk2);
                tc2.Controls.Add(l2);
                tc2.Controls.Add(txt2);
            }
                tc2.HorizontalAlign = HorizontalAlign.Left;
                tc2.CssClass = "blackfnt";

                tr.Cells.Add(tccheck);
                tr.Cells.Add(tc);
                tr.Cells.Add(tc2check);
                tr.Cells.Add(tc2);


                tbltextboxes2.Rows.Add(tr);
                i++;
        }

        dr.Close();

        con.Close();
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string Applicabl_YN = "";
        string chargename = "";

        string updateQuery = "";
        for (int i = 1; i <= nRecords; i++)
        {

            LinkButton lbl = new LinkButton();
            lbl = (LinkButton)tbltextboxes2.FindControl("lbl" + i.ToString());


            string tid = "txt" + i.ToString();
            TextBox tb = new TextBox();
            tb = (TextBox)tbltextboxes.FindControl(tid);
            if (tb == null)
            {
                tb = (TextBox)tbltextboxes2.FindControl(tid);
            }

            
            chargename = tb.Text;
            if (chargename.CompareTo("") == 0)
            {
                chargename = lbl.Text.ToString().Substring(0, lbl.Text.ToString().Length - 7).ToString();
            }

            if (chargename.ToString().Length > 8)
            {
                if (chargename.Substring(chargename.Length - 8, 7).ToString().CompareTo(" ( + ) ") == 0 || chargename.Substring(chargename.Length - 8, 7).ToString().CompareTo(" ( - ) ") == 0)
                {
                    chargename = chargename.Substring(chargename.Length - 8, 7).ToString();
                }
            }

            CheckBox chk = new CheckBox();
            chk = (CheckBox)tbltextboxes.FindControl("chk" + i.ToString());
            if (chk == null)
            {
                chk = (CheckBox)tbltextboxes2.FindControl("chk" + i.ToString());
            }

            if (chk.Checked == true)
            {
                Applicabl_YN = "Y";
            }
            else
            {
                Applicabl_YN = "N";
            }

            

            updateQuery = "UPDATE webx_docket_charges_applicable SET chargename='" + chargename + "',applicabl_YN='" + Applicabl_YN + "' WHERE srno=" + i;
            SqlCommand cmd = new SqlCommand(updateQuery, con);
            cmd.ExecuteNonQuery();
        }

       
        con.Close();
    
    }


}
