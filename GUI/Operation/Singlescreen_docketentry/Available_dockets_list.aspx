<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Available_dockets_list.aspx.cs"
    Inherits="GUI_Operation_Singlescreen_docketentry_Available_dockets_list" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script type="text/javascript" language="JavaScript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <link href="../../images/style.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
	function OpenPopupWindow(strDocketNo)
        {
          
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=350,height=200,status=no,left=60,top=270"
          
            var strPopupURL = "./UnUsed_dkts.aspx?series=" + strDocketNo    
           
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
	
    </script>

    <title>Untitled Page</title>
</head>


<body leftmargin="0" topmargin="0">
<%--<atlas:ScriptManager ID="scmn1" runat="server"  >

</atlas:ScriptManager>--%>
    <form id="form1" runat="server">
    
                   <table align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                <tr bgcolor="white">
                    <td nowrap>
                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text="From: "></asp:Label>
                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                            MaxLength="10"></asp:TextBox>
                        <a href="#" onclick="cal.select(txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                            name="anchor1" id="anchor1">
                            <img src="../../images/calendar.jpg" border="0"></img>
                        </a>
                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                        <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                            MaxLength="10"></asp:TextBox>
                        <a href="#" onclick="cal.select(txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                            name="anchor2" id="a1">
                            <img src="../../images/calendar.jpg" border="0"></img>
                        </a>
                    </td>
                    <td rowspan="3">
                       <%-- <asp:UpdatePanel ID="upShowList"   UpdateMode="Conditional" runat="server">
                            <ContentTemplate>--%>
                                <asp:Button runat="server" ID="btnSubmit" OnClick="btnShowList_Click" Text="Submit" />
                            <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>
                    </td>
                </tr>
                <tr bgcolor="white" align="center">
                    <td>
                        <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Text=" OR  "></asp:Label>
                        </a>
                    </td>
                </tr>
                <tr bgcolor="white" align="center">
                    <td>
                        <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Text=" Enter Dockno : "></asp:Label>
                        <asp:TextBox ID="txtdockno" runat="Server"  Width="80" MaxLength="15"></asp:TextBox>
                       
                    </td>
                </tr>
            </table>
             <%--<asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                        
                         <center>
                      
                                <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressArea">
                                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                          <%--  </ContentTemplate>
                        </asp:UpdatePanel>
                    </center>--%>
                       
                            <asp:GridView align="center" ID="dgDocket" runat="server" CellSpacing="1" CellPadding="0"
                                HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true" PageSize="5"
                                PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                                Width="300px" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                               OnPageIndexChanging="pgChange">
                                <Columns>
                                    
                                        
                                     
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lbldkttot"  Text="Series"  runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldkttot_val"  Text='<% #DataBinder.Eval(Container.DataItem, "Series_From")+" - "+DataBinder.Eval(Container.DataItem, "Series_To")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lbldkttot"  Text="Used"  runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldkttot_val"  Text='<% #DataBinder.Eval(Container.DataItem, "used")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="center"  />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-CssClass="balckfnt" HeaderText="" HeaderStyle-Width="15">
                                        <ItemTemplate>
                                            <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "Series_From")+" - " +DataBinder.Eval(Container.DataItem, "Series_To") %>')">
                                                <font cssclass="Blackfnt">
                                                    View</a>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="bgpink" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="white" />
                                <PagerStyle HorizontalAlign="Center" BackColor="white" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                            </asp:GridView>
                       <%-- </ContentTemplate>
                        <Triggers>
                           
                            <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>--%>
        
    </form>
</body>
</html>
<div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
    layer-background-color: white; z-index: 99;">
</div>
