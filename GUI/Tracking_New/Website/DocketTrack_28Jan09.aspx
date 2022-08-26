<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocketTrack.aspx.cs" Inherits="GUI_Tracking_New_Webxsite_DocketTrack" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <LINK rel="stylesheet" type="text/css" href="../../../GUI/images/style.css" />
        <script language="JavaScript" type="text/javascript" src="../../images/dropdowncontent.js"> </script>
     <script language="javascript" >


        function topWindowPOD(strDocketNo1)
        {
        
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
             
              var client="<%=Session["Client"]%>"
            var strPopupURL1 = "../../../GUI/Operations/FM/FMDocuments/"+client+"/" + strDocketNo1   
           
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
        }
     </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    <br />
   
    <img id="imgLogo" height="60" width="100" runat="server" />

    <br />
     <br />
    <asp:GridView Visible="false" align="Left" ID="dgDocket" runat="server" BorderWidth="0"
                        CellPadding="4" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="true" PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
                        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "doc_no")%>'
                                        runat="server">
                                    </asp:Label>
                                    <asp:HiddenField ID="dktst" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "Docket_Status")%>' />
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField Visible="false" DataField="doc_no" HeaderText="Docket No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColDockdt" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "doc_dt")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:BoundField Visible="false" DataField="Dockdt" HeaderText="Docket Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Deldt" HeaderText=" EDD - ADD ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <%-- <asp:BoundField DataField="Origin_dest" HeaderText="Origin - Destination">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>--%>
                            <asp:TemplateField HeaderText="Origin - Destination">
                                <ItemTemplate>
                                    <a href="#" id="<%# Container.DataItemIndex+1 %>contentlink1" rel="<%# Container.DataItemIndex+1 %>subcontent1">
                                        <asp:Label Font-Underline="true" CssClass="blackfnt" ID="Label1" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "orgncd")%>'></asp:Label></a>
                                    <div align="left" id="<%# Container.DataItemIndex+1 %>subcontent1" style='position: absolute;
                                        visibility: hidden; border: 2px solid black; background-color: AliceBlue; width: 250px;
                                        height: 120px; padding: 1px;'>
                                        <div style='width: 100%; float: left'>
                                            <%#DataBinder.Eval(Container.DataItem, "Org_ToolTip")%>
                                        </div>
                                    </div>
                                    <font class="blackfnt">: </font><a href="#" id="<%# Container.DataItemIndex+1 %>contentlink"
                                        rel="<%# Container.DataItemIndex+1 %>subcontent">
                                        <asp:Label Font-Underline="true" CssClass="blackfnt" ID="lbldest" runat="server"
                                            Text='<%#DataBinder.Eval(Container.DataItem, "reassign_destcd")%>'></asp:Label></a>
                                    <div align="left" id="<%# Container.DataItemIndex+1 %>subcontent" style='position: absolute;
                                        visibility: hidden; border: 2px solid black; background-color: AliceBlue; width: 250px;
                                        height: 120px; padding: 1px;'>
                                        <div style='width: 100%; float: left'>
                                            <%#DataBinder.Eval(Container.DataItem, "Dest_ToolTip")%>
                                        </div>
                                    </div>

                                    <script type="text/javascript">
                                                            dropdowncontent.init("<%# Container.DataItemIndex+1 %>contentlink1", "left-top", 300, "mouseover")   
                                                            dropdowncontent.init("<%# Container.DataItemIndex+1 %>contentlink", "right-top", 300, "mouseover")           
                                    </script>

                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                <HeaderStyle CssClass="blackfnt" Wrap="False" />
                            </asp:TemplateField>
                            <%--   <asp:BoundField DataField="Curr_Next" HeaderText="Curr. Loc. - Next Loc.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>--%>
                            <asp:TemplateField HeaderText="Curr. Loc. - Next Loc.">
                                <ItemTemplate>
                                    <a href="#" id="<%# Container.DataItemIndex+1 %>contentlink2" rel="<%# Container.DataItemIndex+1 %>subcontent2">
                                        <asp:Label Font-Underline="true" CssClass="blackfnt" ID="Labcurr" runat="server"
                                            Text='<%#DataBinder.Eval(Container.DataItem, "Curr_loc")%>'></asp:Label></a>
                                    <div align="left" id="<%# Container.DataItemIndex+1 %>subcontent2" style='position: absolute;
                                        visibility: hidden; border: 2px solid black; background-color: AliceBlue; width: 250px;
                                        height: 120px; padding: 1px;'>
                                        <div style='width: 100%; float: left'>
                                            <%#DataBinder.Eval(Container.DataItem, "Curr_ToolTip")%>
                                        </div>
                                    </div>
                                    <font class="blackfnt">: </font><a href="#" id="<%# Container.DataItemIndex+1 %>contentlink3"
                                        rel="<%# Container.DataItemIndex+1 %>subcontent3">
                                        <asp:Label Font-Underline="true" CssClass="blackfnt" ID="lblNext" runat="server"
                                            Text='<%#DataBinder.Eval(Container.DataItem, "NextLoc")%>'></asp:Label></a>
                                    <div align="left" id="<%# Container.DataItemIndex+1 %>subcontent3" style='position: absolute;
                                        visibility: hidden; border: 2px solid black; background-color: AliceBlue; width: 250px;
                                        height: 120px; padding: 1px;'>
                                        <div style='width: 100%; float: left'>
                                            <%#DataBinder.Eval(Container.DataItem, "Next_ToolTip")%>
                                        </div>
                                    </div>

                                    <script type="text/javascript">
                                                            dropdowncontent.init("<%# Container.DataItemIndex+1 %>contentlink2", "left-bottom", 300, "mouseover")   
                                                            dropdowncontent.init("<%# Container.DataItemIndex+1 %>contentlink3", "right-bottom", 300, "mouseover")           
                                    </script>

                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                <HeaderStyle CssClass="blackfnt" Wrap="False" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Type" HeaderText="Paybas | Mode | Type">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cnor" HeaderText="Consignor">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cnee" HeaderText="Consignee">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <%--<asp:BoundField DataField="docket_mode" HeaderText="Type">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>--%>
                        </Columns>
                        <%-- <Columns>
                            <asp:TemplateField HeaderText="Track" HeaderStyle-Width="40">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "docno") %>','<%#DataBinder.Eval(Container.DataItem, "docsf") %>')">
                                        <font cssclass="Blackfnt">Track </a>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            </asp:TemplateField>
                        </Columns>--%>
                       <%-- <Columns>
                            <asp:TemplateField HeaderText="View" HeaderStyle-Width="40">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "docno") %>','<%#DataBinder.Eval(Container.DataItem, "docsf") %>')">
                                        <font cssclass="Blackfnt"><u>View </u></a>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            </asp:TemplateField>
                        </Columns>--%>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                            Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
               <%-- <asp:TemplateField HeaderText="View POD" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:topWindowPOD('<%#DataBinder.Eval(Container.DataItem, "PODName") %>')">
                            <font cssclass="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "POD")%> </a>
                       
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>--%>
    </div>
    </form>
</body>
</html>
