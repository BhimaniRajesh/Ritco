<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Prospect_RegisterReport2.aspx.cs" Inherits="REPORT_Prospect_RegisterReport2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <script language="javascript" type="text/javascript">

        function OpenWindow(prospectcode)
                {
                    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                    var strURL = "pros_reg_detail.aspx?prospectcode="+prospectcode    
                    winNew = window.open(strURL,"_blank",strWinFeature)
                }
</script>
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Register Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />

<asp:GridView ID="dgProspectRegister" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="boxbg"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"                             
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="false"
                            CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" OnPageIndexChanging="pgChange" Width="100%">
                            <Columns>
                                
                                 <asp:TemplateField HeaderText="SRNo." >
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                                </ItemTemplate>
                                </asp:TemplateField>   
                                <asp:TemplateField HeaderText="Prospect" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass="bgbluegrey">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey"  />
                                     <ItemStyle CssClass="blackfnt"  Font-Bold="true"/>
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "prospectcode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "ProspectCode") + ":" + DataBinder.Eval(Container.DataItem, "CompanyName")%>
                                            
                                        </a>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                               <asp:BoundField DataField="RegisterDt" HeaderText="Registration Date" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="empcd" HeaderText="Sales Person" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="LocCode" HeaderText="Location" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <%--<asp:BoundField DataField="no_calls" HeaderText="Calls till date" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                                <asp:TemplateField HeaderText="Calls till date" HeaderStyle-Font-Bold="true">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="120" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                    <label class="blackfnt">
                                                                                        <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"Prospect_RegisterReport3.aspx?pro=" +DataBinder.Eval(Container.DataItem, "prospectCode")+"&location=" +DataBinder.Eval(Container.DataItem, "loccode")+"&entryby="+DataBinder.Eval(Container.DataItem, "entryby")%>' Text= '<%#DataBinder.Eval(Container.DataItem, "no_calls")%>' ID="Hyperlink3"/>
                                                                                    </label>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                <asp:BoundField DataField="compCity" HeaderText="City" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <%--<asp:BoundField DataField="acctcategory" HeaderText="Last Call Status" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="calldt" HeaderText="Last Call Duration" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                <%--<asp:BoundField DataField="valpmonth" HeaderText="Last Call Order Value" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="lastorderdt" HeaderText="Expected Order Date" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="compaddr" HeaderText="Address" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="compCity" HeaderText="City" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="comppin" HeaderText="Pin" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="compphone" HeaderText="Phone" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="compwebsite" HeaderText="Website" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="contperson" HeaderText="Contact Person" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="contdesign" HeaderText="Designation" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="compemail" HeaderText="Email" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="comment" HeaderText="Comments" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>


</asp:Content>
