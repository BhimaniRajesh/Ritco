<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="StockUpdateMain.aspx.cs" Inherits="GUI_Operations_UpdateDocketArrivalStatus_StockUpdateMain" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="./Js/StockUpdate.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>
    
    <script type="text/css">
    
    .WrapperDiv {
        width:800px;height:400px;border: 1px solid black;
    }        
    .WrapperDiv TH {
        position:relative;
    }
    .WrapperDiv TR 
    {
        /* Needed for IE */
        height:0px;
    }     
    
    
//    function onLoad()
//    {
//        //FreezeGridViewHeader('dgTHC','WrapperDiv');
//    }    

    </script>

    <asp:UpdatePanel ID="upStockUpdate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Stock Update:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                    <td align="left">
                        <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    &nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblSUCreteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: left">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select Stock Update Criteria"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" rowspan="4" valign="Top">
                        <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" Text="THC Arrival Date :">
                        </asp:Label>
                    </td>
                    <td align="left">
                        <asp:HiddenField ID="hDateRange" runat="server" Value="2" />
                        <asp:HiddenField ID="hTHCSelected" runat="server" />
                        <input type="radio" name="radDate"" />
                        <asp:Label ID="lblFromDate" runat="server" CssClass="blackfnt" Text="From :" />
                        <asp:TextBox ID="txtFrom" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtFrom,'a1','dd/MM/yyyy'); return false;"
                            id="a1">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>&nbsp;
                        <asp:Label ID="lblToDate" runat="server" CssClass="blackfnt" Text=" To " />
                        &nbsp;
                        <asp:TextBox ID="txtTo" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtTo,'a2','dd/MM/yyyy'); return false;"
                            id="a2">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:Label ID="lblddmmyyyy" runat="server" CssClass="blackfnt" Text=" [dd/mm/yyyy] " />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblToday" runat="server" CssClass="blackfnt">Today's - <%=dtToday%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblLastWeek" runat="server" CssClass="blackfnt">Last Week's - <%=dtLastWeek%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <input type="radio" name="radDate" disabled="disabled" />
                        <asp:Label ID="lblTillDate" runat="server" CssClass="blackfnt">Till Date</asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">THC No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTHCList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">MF No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMFList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Docket No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDocketList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>


                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Destination(s):</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtToHubList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="right" colspan="2">
                        <asp:Button ID="btnShowTHC" Text="Show THCs for Stock Update >>" runat="server" OnClientClick="return ValidateData()"
                            OnClick="ShowTHCForStockUpdate" />
                    </td>
                </tr>
            </table>
            <br />
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblTHCList" runat="server"
                width="900" visible="false">
                <tr style="background-color: White">
                    <td align="center">
                        <font class="blackfnt"><b>THCs available for Stock Update</b></font>
                        
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:GridView ID="dgTHC" EnableViewState="true" runat="server" CellSpacing="1" CellPadding="3"
                            HeaderStyle-CssClass="StaticColumn" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%" OnRowDataBound="GVRowDB">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <input type="radio" runat="server" id="rdo" onclick="SelectOne(this,'dgTHC')" 
                                        value='<%#DataBinder.Eval(Container.DataItem, "THCNO")%>'
                                        />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField  HeaderText="Sr. #" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <font class="blackfnt"><%# Container.DataItemIndex + 1%></font>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="THC Branch" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk0" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THCBR")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="THC #" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THCNO")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="THC Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THC_Date")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText='THC Arrival Date' ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Arrival_Date")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Total MFs. in THC" ItemStyle-HorizontalAlign="right"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ManifestKount")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Total Dockets in THC" ItemStyle-HorizontalAlign="right"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketKount")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>                        
                           </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:Button ID="btnUpdateDRS" runat="server" Text="Proceed to stock update for selected THC >>"
                            OnClientClick="return PassSelectedTHCForStockUpdate()" OnClick="PassSelectedTHCForStockUpdate"/>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 100;">
    </div>

</asp:Content>

