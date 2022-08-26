using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WebX.Entity;
using WebX.Controllers;
/// <summary>
/// Summary description for ViewPrint
/// </summary>
namespace WebX.Entity
{
    public class ViewPrint
    {
        private string code, url, desc, activeflag;
        public ViewPrint()
        {
            code = ""; url = ""; desc = ""; activeflag = "";
        }

        public string Code
        {
            get { return code; }
            set { code = value; }
        }

        public string Url
        {
            get { return url; }
            set { url = value; }
        }

        public string Description
        {
            get { return desc; }
            set { desc = value; }
        }

        public string FlagActive
        {
            get { return activeflag; }
            set { activeflag = value; }
        }

    }

}
