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

public partial class GUI_admin_Extra_QuickEditSheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void loadTable(int rows)
    {
        for (int i = 0; i < rows; i++)
        {
            TableRow tr = new TableRow();
            TableCell tc1 = new TableCell();
            TableCell tc2 = new TableCell();
            TableCell tc3 = new TableCell();
            TableCell tc4= new TableCell();
            TableCell tc5= new TableCell();

            TextBox tb1 = new TextBox();
            tb1.ID = "txtinvoiceno" + i.ToString();

            TextBox tb2 = new TextBox();
            tb2.ID = "txtinvoicedate" + i.ToString();
            
            

            tr.Cells.Add(tc1);
            tr.Cells.Add(tc2);
            tr.Cells.Add(tc3);
            tr.Cells.Add(tc4);
            tr.Cells.Add(tc5);

            tblinvoice.Rows.Add(tr);
        }
    }
}
