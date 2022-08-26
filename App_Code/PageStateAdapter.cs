using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;
using System.Web;

namespace PAB.Web
{
    public class PageStateAdapter : System.Web.UI.Adapters.PageAdapter
    {
        //public override PageStatePersister GetStatePersister()
        //{
        //    return new SessionPageStatePersister(this.Page);
        //}

        public override PageStatePersister GetStatePersister()
        {
            
            if (HttpContext.Current.Request.RawUrl.IndexOf("404.aspx") > -1)
            {
                return new HiddenFieldPageStatePersister(this.Page);
            }
            else
            {
                return new SessionPageStatePersister(this.Page);
            }
        }
    }
}

