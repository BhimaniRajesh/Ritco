<%@ Page Language="C#"  CodeFile="docket_tracking.aspx.cs" Inherits="docket_tracking"  AutoEventWireup="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">



<script type="text/javascript" src="ajaxtabs/ajaxtabs.js" ></script>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link href="../../GUI/Images/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .menuTabs
        {
            position:relative;
            top:1px;
            left:10px;
        }
        .tab
        {
            border:Solid 1px black;
            border-bottom:none;
            padding:0px 10px;
            background-color:#eeeeee;
            
        }
        .selectedTab
        {
            border:Solid 1px black;
            border-bottom:Solid 1px white;
            padding:0px 10px;
            background-color:white;
        }
        .tabBody
        {
            border:Solid 1px black;
            padding:20px;
            background-color:white;
        }
    
    </style>
    <title>Menu Tab Strip</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="menuTabs"
        CssClass="menuTabs"
        StaticMenuItemStyle-CssClass="tab"
        StaticSelectedStyle-CssClass="selectedTab"
        Orientation="Horizontal"
        
        OnMenuItemClick="menuTabs_MenuItemClick"
        Runat="server">
        <Items>
        <asp:MenuItem
            Text="Summary"
            Value="0" 
             
            Selected="true" />
        <asp:MenuItem
            Text="Tab 2" 
              Value="1"
           />
        <asp:MenuItem
            Text="Tab 3"
            Value="2" />
            
        </Items>
    </asp:Menu>    
    
    
    <div class="tabBody">
    <asp:MultiView
        id="multiTabs"
        ActiveViewIndex="0"
        Runat="server">
        <asp:View ID="view1" runat="server">
        
       <% string dockno = Request.QueryString.Get("strDckNo");
        Response.Write("<br> dockno 1: " + dockno);
           
           
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
 
           
        //string sql = "USP_QTRACK";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.StoredProcedure;  
           
           %>
        <!--#include file="Docket_Summary.aspx"--> 
        </asp:View>
        
        <asp:View ID="view2"  runat="server">
        
        Contents of second tab
        
        </asp:View>
        <asp:View ID="view3" runat="server">
        
        Contents of third tab
        
        </asp:View>
    </asp:MultiView>   
  
    </div>
    
    </div>
    
    </form>
</body>
</html>

