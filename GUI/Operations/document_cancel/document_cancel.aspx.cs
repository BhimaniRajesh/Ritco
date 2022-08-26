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

public partial class GUI_Operations_document_cancel_document_cancel : System.Web.UI.Page
{
    public string documentno,documenttype;
    protected void Page_Load(object sender, EventArgs e)
    {
        btnGo.Attributes.Add("onclick","javascript:return cancel_doc(" + txtCNno.ClientID + "," + txtManifiest.ClientID + "," + btnGo.ClientID + "," + rdCN.ClientID + "," + rdManifiest.ClientID + ")");
        txtCNno.Attributes.Add("onblur", "javascript:return docBlur('" + txtCNno.ClientID.ToString() + "')");
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        if (rdCN.Checked == true)
        {
            documentno = txtCNno.Text;
            documenttype = "Docket";
        }
        else if (rdManifiest.Checked == true)
        {
            documentno = txtManifiest.Text;
            documenttype = "Manifiest";
        }
        //else if (rdTHC.Checked == true)
        //{
        //    documentno = txtTHC.Text;
        //    documenttype = "THC";
        //}
        string final = "?documentno=" + documentno;
        final += "&documenttype=" + documenttype;

        Response.Redirect("document_cancel_list.aspx" + final);
    }
}
