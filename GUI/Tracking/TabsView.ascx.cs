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

[ParseChildren(true)]
public partial class TabsView : System.Web.UI.UserControl
{
    private ITemplate _view1;
    private ITemplate _view2;
    private ITemplate _view3;
    private ITemplate _view4;
    private ITemplate _view5;
    private ITemplate _view6;

    #region ITemplate Accessors

    [PersistenceMode(PersistenceMode.InnerProperty), TemplateContainer(typeof(TemplateControl))]
    public ITemplate Tab1
    {
        get { return _view1; }
        set { _view1 = value; }
    }
    [PersistenceMode(PersistenceMode.InnerProperty), TemplateContainer(typeof(TemplateControl))]
    public ITemplate Tab2
    {
        get { return _view2; }
        set { _view2 = value; }
    }
    [PersistenceMode(PersistenceMode.InnerProperty), TemplateContainer(typeof(TemplateControl))]
    public ITemplate Tab3
    {
        get { return _view3; }
        set { _view3 = value; }
    }
    [PersistenceMode(PersistenceMode.InnerProperty), TemplateContainer(typeof(TemplateControl))]
    //public ITemplate Tab4
    //{
    //    get { return _view4; }
    //    set { _view4 = value; }
    //}
    //[PersistenceMode(PersistenceMode.InnerProperty), TemplateContainer(typeof(TemplateControl))]
    //public ITemplate Tab5
    //{
    //    get { return _view5; }
    //    set { _view5 = value; }
    //}
    //[PersistenceMode(PersistenceMode.InnerProperty), TemplateContainer(typeof(TemplateControl))]
    //public ITemplate Tab6
    //{
    //    get { return _view6; }
    //    set { _view5 = value; }
    //}

    #endregion

    #region Exposed PlaceHolders

    // These are exposed so you can access the controls in the ITemplates on each tab
    // There may well be a better way to do this but nothing come to mind.

    public PlaceHolder Tab1Controls
    {
        get { return PlaceHolder1; }
    }

    public PlaceHolder Tab2Controls
    {
        get { return PlaceHolder2; }
    }

    public PlaceHolder Tab3Controls
    {
        get { return PlaceHolder3; }
    }

    //public PlaceHolder Tab4Controls
    //{
    //    get { return PlaceHolder4; }
    //}

    //public PlaceHolder Tab5Controls
    //{
    //    get { return PlaceHolder5; }
    //}

    //public PlaceHolder Tab6Controls
    //{
    //    get { return PlaceHolder6; }
    //}

    #endregion

    #region Link Button Text Property Accessors

    public string Tab1Title
    {
        get { return btnTab1.Text; }
        set { btnTab1.Text = value; }
    }
    public string Tab2Title
    {
        get { return btnTab2.Text; }
        set { btnTab2.Text = value; }
    }
    public string Tab3Title
    {
        get { return btnTab3.Text; }
        set { btnTab3.Text = value; }
    }
    //public string Tab4Title
    //{
    //    get { return btnTab4.Text; }
    //    set { btnTab4.Text = value; }
    //}
    //public string Tab5Title
    //{
    //    get { return btnTab5.Text; }
    //    set { btnTab5.Text = value; }
    //}

    //public string Tab6Title
    //{
    //    get { return btnTab6.Text; }
    //    set { btnTab6.Text = value; }
    //}
    #endregion

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        
        // Check that the ITemplates have content for each tab and then put in place holder.
        if (_view1 != null)
            _view1.InstantiateIn(PlaceHolder1);
        if (_view2 != null)
            _view2.InstantiateIn(PlaceHolder2);
        if (_view3 != null)
            _view3.InstantiateIn(PlaceHolder3);
        //if (_view4 != null)
        //    _view4.InstantiateIn(PlaceHolder4);
        //if (_view5 != null)
        //    _view5.InstantiateIn(PlaceHolder5);
        //if (_view6 != null)
        //    _view6.InstantiateIn(PlaceHolder6);
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // Delegate to represent TabChanged event signature.
    public delegate void TabChangedEventHandler(object sender, CommandEventArgs e);

    // Event using the above handler.
    public event TabChangedEventHandler TabChanged;

    #region Tab Command

    protected void btnTabs_Command(object sender, CommandEventArgs e)
    {
        // Change ActiveViewIndex for MulitView control.
        MultiViewContent.ActiveViewIndex = Convert.ToInt32(e.CommandArgument);

        if (TabChanged != null) {
            // TabChanged..send event to calling webform.
            TabChanged(this, e);
        }
    }

    #endregion
}
