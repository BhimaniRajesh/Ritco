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

public partial class GUI_Print_MF_PrintinTextFormate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String strDestinationFile;
        strDestinationFile = "C:\\output.txt";
        TextWriter tw = new StreamWriter(strDestinationFile);

        //writing the header
        for (int x = 0; x < dataGridView1.Columns.Count; x++)
        {
            tw.Write(dataGridView1.Columns[x].HeaderText);
            if (x != dataGridView1.Columns.Count - 1)
            {
                tw.Write(", ");
            }

        }
        tw.WriteLine();

        //writing the data
        for (int x = 0; x < dataGridView1.Rows.Count - 1; x++)
        {
            for (int y = 0; y < dataGridView1.Columns.Count; y++)
            {
                tw.Write(dataGridView1.Rows[x].Cells.Value);
                if (y != dataGridView1.Columns.Count - 1)
                {
                    tw.Write(", ");
                }
            }
            tw.WriteLine();
        }
        tw.Close();


    }
}
