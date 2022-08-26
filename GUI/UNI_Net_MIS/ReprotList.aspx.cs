using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_NET_MIS_ReprotList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MySQLDataSource_GeneralMaster.ConnectionString = Session["SqlProvider"].ToString().Trim();
    }

    protected void grvRank_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
}
