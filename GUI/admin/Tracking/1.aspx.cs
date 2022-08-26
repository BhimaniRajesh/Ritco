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
using Telerik.WebControls;


public partial class Tracking_1 : System.Web.UI.Page
{
    protected System.Web.UI.WebControls.Label PageContent;
    protected System.Web.UI.WebControls.Repeater BuildingSummary;
    protected Telerik.WebControls.PageView PageView1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Tab tab = new Tab();
            Tab tab1 = new Tab();
            Tab tab2 = new Tab();
            tab.Text = string.Format("Summary", 1);
            tab1.Text = string.Format("View & Print", 2);
            tab2.Text = string.Format("Operation Life Cycle", 3);
           
            RadTabStrip1.Tabs.Add(tab);
            RadTabStrip1.Tabs.Add(tab1);
            RadTabStrip1.Tabs.Add(tab2);


            PageView pageView = new PageView();
            RadMultiPage1.PageViews.Add(pageView);

            BuildPageViewContents(pageView, RadTabStrip1.Tabs.Count);
            RadTabStrip1.SelectedIndex = 0;
                        
        }
    }

   
    private void BuildPageViewContents(PageView pageView, int index)
    {
        pageView.ID = "Page " + index.ToString();
        pageView.Controls.Add(new LiteralControl(" <B>New page</B>" + (index).ToString()));

        string dockno = Request.QueryString.Get("strDckNo");
        Response.Write("<br> dockno : " + dockno);

    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
    }

    private void InitializeComponent()
    {
        this.Load += new System.EventHandler(this.Page_Load);
        //this.RadMultiPage1.PageViewItemCreated += new PageViewItemCreatedDelegate(this.RadMultiPage1_PageViewItemCreated);
        //this.RadTabStrip1.TabClick += new Telerik.WebControls.TabStripEventHandler(this.RadTabStrip1_Click);
    }


   
    

    

}
