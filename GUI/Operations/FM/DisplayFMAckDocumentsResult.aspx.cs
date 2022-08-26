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

public partial class GUI_Operations_FM_DisplayFMAckDocumentsResult : System.Web.UI.Page
{
    public string strFMNo;
    public string strFMID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strFMNo = HttpUtility.UrlDecode(Request.QueryString["FMNo"].ToString());
            strFMID = HttpUtility.UrlDecode(Request.QueryString["FMID"].ToString());
            HidFMNo.Value = strFMNo;
            HidFMID.Value = strFMID;
        }

        strFMNo = HidFMNo.Value;
        strFMID = HidFMID.Value;

        //ID will be used for View
    }
}
