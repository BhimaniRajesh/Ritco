<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectApproval3_Approved.aspx.cs" Inherits="SFM_ProspectApproval3_Approved" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">

function OpenWindow(prospectcode)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "StatusSubmission_View1.aspx?strProspectCode="+prospectcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        </script>
<div align="center">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Approved - Customer Code" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
            
            
            
            <asp:GridView align="center" ID="ProspectApproved" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"

            EmptyDataText="No Records Found..." Width="100%">
                <Columns>

                    <asp:TemplateField HeaderText="Id*" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass = "blackfnt">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                     <ItemStyle CssClass="blackfnt" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "ProspectCode")%>
                                            <asp:Label ID="lblProspect" Text='<%#DataBinder.Eval(Container.DataItem, "ProspectCode")%>' runat="server" CssClass="blackfnt" Visible="false"></asp:Label>  
                                        </a>
                                    </ItemTemplate>
                                    
                                    
                                    </asp:TemplateField>
                                    
                                    
                                    
                                    <asp:TemplateField HeaderText="Company*" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass = "blackfnt">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt"  />
                                     <ItemStyle CssClass="blackfnt" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "companyName")%>
                                            
                                        </a>
                                    </ItemTemplate>
                                    
                                    
                                    
                                    </asp:TemplateField>
                                    
                          
                    <asp:BoundField DataField="compCity" HeaderText="City" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="contPerson" HeaderText="Sales Manager" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="industryCode" HeaderText="Industry" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="RegisterDt" HeaderText="Registration date" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="LastVisitDt" HeaderText="Approval Date" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <%--<asp:TemplateField HeaderText="Submission Status" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass="blackfnt">
                    <ItemTemplate>
                    <asp:Label ID="lblsubmission" Text='<%#DataBinder.Eval(Container.DataItem, "statesub")%>' runat="server" CssClass="blackfnt"></asp:Label>  
                    </ItemTemplate> 
                    </asp:TemplateField> --%>
                         
                    <asp:BoundField DataField="EntryBy" HeaderText="Approved By" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="CustCode" HeaderText="Customer Code" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                     
                </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                    />
                    <FooterStyle CssClass="boxbg" />
            </asp:GridView>
<br />
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <%--<tr>
                    <td align="center" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../../images/back.gif" /></a>
                    </td>
                </tr>--%>
                
                <tr>
                    <td align="center" style="height: 33px">
                        <a href="../Main.aspx" title="back">
                        <img border="0" src="../../images/back.gif" /></a>
                    </td>
                </tr>
                
            </table>

            </div>
</asp:Content>

