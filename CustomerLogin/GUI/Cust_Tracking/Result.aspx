<%@ Page Language="C#" MasterPageFile="~/CustomerLogin/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_Cust_Tracking_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="./../images/dropdowncontent.js"> </script>

    <script language="JavaScript" type="text/javascript">
    function OpenPopupWindow(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "DocketView_xls.aspx?dockno=" + strDocketNo + "&docksf=" + strDocketsf 
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function OpenPopupWindow1(dockno)
        {
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL1 = "../../../GUI/Operations/FM/ViewFMScannedDocument.aspx?DocName=" + dockno
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
        }
        
        </script>

    <div align="left">
    
        <table id = "sd" style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0" runat = "server" >
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"></font><font class="bluefnt"><strong>&gt; </strong><strong>Tracking</strong>
                        </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <%--<center>--%>
                    <table border="0" id="tblGl" runat="server" cellpadding="3" width="565" cellspacing="1"
                        align="left" class="boxbg">
                        <tr style="background-color: #ffffff">
                            <td align="center" class="bgbluegrey" colspan="2">
                                <label class="blackfnt">
                                    <b>You Selected</b></label></td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td style="height: 10px">
                                <label class="blackfnt">
                                    Date :</label></td>
                            <td style="height: 10px">
                                &nbsp;
                                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205; height: 15px;">
                                <label class="blackfnt">
                                    RO :</label></td>
                            <td style="width: 343; height: 15px;">
                                &nbsp;
                                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Location :</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Document Type :
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Customer:
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblCust" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                         <tr style="background-color: #ffffff">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Paybas:
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblpaybas" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                         <tr style="background-color: #ffffff">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Mode:
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblMode" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                         <tr style="background-color: #ffffff">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Type:
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblTypem" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="2" align="left">
                    <br />
                    <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
            <tr>
                <td>
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
                        <Columns>
                            <asp:TemplateField HeaderText="View" HeaderStyle-Width="40">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "docno") %>','<%#DataBinder.Eval(Container.DataItem, "docsf") %>')">
                                        <font cssclass="Blackfnt"><u>View </u></a>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            </asp:TemplateField>
                        </Columns>
                        <Columns>
                            <asp:TemplateField HeaderText="View POD" HeaderStyle-Width="40">
                                <ItemTemplate>
                                    <asp:Label ID="hypPODDoc" runat="server"></asp:Label>                                    
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                            Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    <br />
                    <br />
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="2" align="left">
                    <br />
                    <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
        
    </div>
    <%--<script type="text/javascript">
//
dropdowncontent.init("contentlink", "right-top", 300, "mouseover")
dropdowncontent.init("contentlink1", "left-top", 300, "mouseover")
dropdowncontent.init("contentlink2", "left-bottom", 300, "mouseover")
dropdowncontent.init("contentlink3", "right-bottom", 300, "mouseover")
    </script>--%>
</asp:Content>
