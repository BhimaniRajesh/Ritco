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

public partial class GUI_Finance_MoneyRecipt_UpdateMR_Done : System.Web.UI.Page
{
    public static string StrMrsno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        StrMrsno = Request.QueryString["Mrsnos"].ToString();
        string[] StrMrsno_arr = StrMrsno.Split('~');

        TableRow tr = new TableRow();
        TableCell tc1 = new TableCell();
        TableCell tc2 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "<b>Mrs. Updated Successfully !!!</b>";
        tc1.ColumnSpan = 2;
        tc1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
       // tc2.Text = "Particulars";
        tr.CssClass = "bgbluegrey";
    //    tc2.CssClass = "blackfnt";
        tr.Cells.Add(tc1);
      //  tr.Cells.Add(tc2);
        //for (int i = 0; i < StrMrsno_arr.Length; i++)
        //{
        //    TableCell tc = new TableCell();
        //    tc.Text = StrMrsno_arr[i];

        //    tr.Cells.Add(tc);
        //    tc.CssClass = "blackfnt";
        //}

        documentdetail.Rows.Add(tr);
        
        for (int i = 0; i < StrMrsno_arr.Length; i++)
        {
            tr = new TableRow();
            tc1 = new TableCell();
            tc2 = new TableCell();
       
            TableCell tc = new TableCell();
            tc.Text = "<b>" + StrMrsno_arr[i] + "</b>";

            tr.Cells.Add(tc);

            tc.CssClass = "blackfnt";
            tc1.CssClass = "blackfnt";
           // tc1.Text = "<a href=\"MR_Summ_Popup.aspx?mrsno='" + StrMrsno_arr[i] + "'\"> View</a> /Print";
            tc1.Text = "<a href=\"javascript:popupmenu1('" + StrMrsno_arr[i] + "')\"> View</a> /Print";
            
            // tc2.Text = "Particulars";
           // tr.CssClass = "bgbluegrey";
            tr.BackColor = System.Drawing.Color.White;
            tr.Cells.Add(tc1);
            documentdetail.Rows.Add(tr);
        }
        tr = new TableRow();
        tc1 = new TableCell();
        tc2 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "-";
        tc1.ColumnSpan = 2;
        tc1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
        // tc2.Text = "Particulars";
        tr.CssClass = "bgbluegrey";
        tr.BackColor = System.Drawing.Color.White;
        //    tc2.CssClass = "blackfnt";
        tr.Cells.Add(tc1);
        documentdetail.Rows.Add(tr);
        tr = new TableRow();
        tc1 = new TableCell();
        tc2 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "<b>Your Next Step !!!</b>";
        tc1.ColumnSpan = 2;
        tc1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
        // tc2.Text = "Particulars";
        tr.CssClass = "bgbluegrey";
        tr.BackColor = System.Drawing.Color.White;
        //    tc2.CssClass = "blackfnt";
        tr.Cells.Add(tc1);
        documentdetail.Rows.Add(tr);
        tr = new TableRow();
        tc1 = new TableCell();
        tc2 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "<a href='Updatemr_step1.aspx'><font class=blklnkund>Click Here Update More Mrs.</font></a>";
        tc1.ColumnSpan = 2;
        tc1.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
        // tc2.Text = "Particulars";
        tr.CssClass = "blklnkund";
        tr.BackColor = System.Drawing.Color.White;
        //    tc2.CssClass = "blackfnt";
        tr.Cells.Add(tc1);
        documentdetail.Rows.Add(tr);
    }
}
