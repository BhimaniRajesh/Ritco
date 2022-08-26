<%@ Page Language="C#"  MasterPageFile="~/CustomerLogin/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="LocationList.aspx.cs" Inherits="GUI_LocationList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


    <script type="text/javascript" src="./images/dropdowncontent.js">
/***********************************************
* Drop Down/ Overlapping Content- � Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

    </script>

<table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"></font><font class="bluefnt"><strong>&gt; </strong><strong>Location Listing</strong>
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
                        <img alt="Back" src="./images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
             <tr bgcolor="white">
                <td colspan="2" align="left">
                    <br />
                    <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
             <tr>
                <td align="right"><br />
 <asp:GridView Visible="false" align="Left" ID="dgDocket" runat="server" BorderWidth="0"
                        CellPadding="4" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="false"   CssClass="boxbg"
                        FooterStyle-CssClass="boxbg"  AutoGenerateColumns="false"                        
                        EmptyDataText="No Records Found..." OnRowDataBound="dgDocket_RowDataBound" >
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
                            <asp:TemplateField HeaderText="Region "   HeaderStyle-Font-Bold="false"   ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblRO"    runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Report_loc")%>'
                                    CssClass="bluefnt"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle BackColor="white"  Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Location">
                             <itemtemplate>
                                   <a href="#" id="<%# Container.DataItemIndex+1 %>contentlink2" rel="<%# Container.DataItemIndex+1 %>subcontent2"> 
                                    <asp:Label      Font-Underline="true" CssClass="blackfnt" ID="Labcurr" runat="server"  Text='<%#DataBinder.Eval(Container.DataItem, "loc")%>'  ></asp:Label></a>
                                                     <div align="left"  id="<%# Container.DataItemIndex+1 %>subcontent2" style='position:absolute; visibility: hidden; border: 2px solid black; background-color: AliceBlue; width: 250px; height: 120; padding: 1px;'>
                                                     <div style='width: 100%; float: left'>
                                                     <%#DataBinder.Eval(Container.DataItem, "locstr")%>
                                                     </div>     </div> 
                            
                                                     <script type="text/javascript">
                                                            dropdowncontent.init("<%# Container.DataItemIndex+1 %>contentlink2", "right-top", 300, "mouseover")   
                                                           
                                                    </script>    
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" Wrap="false" />
                                <HeaderStyle CssClass="blackfnt" Wrap="False"  />
                            </asp:TemplateField>
                            <asp:BoundField DataField="LocAddr" HeaderText=" Address ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                             </Columns>
                        <RowStyle />
                        
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
</td>
            </tr>
             <tr bgcolor="white">
                <td colspan="2" align="left">
                    <br />
                    <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
            </table>
             <br />
</asp:Content>
