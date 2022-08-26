<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectApproval2.aspx.cs" Inherits="SFM_ProspectApproval2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">



function abc(btnSubmit)
{
var totrecord = "<%=intTotalRecords %>"
//alert(totrecord)
if(totrecord == "0")
{
alert("There are no Record...")
return false;
}
}


</script>

<div align="center">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Approval" CssClass="blackfnt" Font-Bold="true"></asp:Label>
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
            <asp:UpdatePanel ID="UpdatePanel1" RenderMode="Inline"      UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
            
            <asp:GridView align="center" ID="ProspectStatus" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" 

            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" Width="100%" OnRowDataBound="ProspectStatus_RowDataBound">
                <Columns>
                   <asp:TemplateField>
                                <ItemTemplate>
                                    <center>
                                    <asp:CheckBox ID="chkDock" runat="server" AutoPostBack="false" value='<%# DataBinder.Eval(Container.DataItem,"ProspectCode") %>' />
                                    </center>
                                </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Id*" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass = "blackfnt">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                     <ItemStyle CssClass="blackfnt" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "ProspectCode")%>
                                            <asp:Label ID="lblProspect" Text='<%#DataBinder.Eval(Container.DataItem, "ProspectCode")%>' runat="server" CssClass="blackfnt" Visible="false"></asp:Label>  
                                        </a>
                                    </ItemTemplate>
                                    <%--<FooterTemplate>
                                    <asp:RadioButton ID="rd1" runat="server" Text="Apporved" CssClass="blackfnt" />
                                    </FooterTemplate> --%>
                                    
                                    </asp:TemplateField>
                                    
                                    
                                    
                                    <asp:TemplateField HeaderText="Company*" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass = "blackfnt">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt"  />
                                     <ItemStyle CssClass="blackfnt" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "companyName")%>
                                            
                                        </a>
                                    </ItemTemplate>
                                    
                                    <%--<FooterTemplate>
                                    <asp:RadioButton ID="rd2" runat="server" Text="Rejected"  CssClass="blackfnt"/>
                                    </FooterTemplate> --%>
                                    
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

                    <asp:BoundField DataField="LastVisitDt" HeaderText="Last Visit Date" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <asp:TemplateField HeaderText="Submission Status" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass="blackfnt">
                    <ItemTemplate>
                    <asp:Label ID="lblsubmission" Text='<%#DataBinder.Eval(Container.DataItem, "statesub")%>' runat="server" CssClass="blackfnt"></asp:Label>  
                    </ItemTemplate> 
                    </asp:TemplateField> 
                         
                    <asp:BoundField DataField="comment" HeaderText="Remarks" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="acctCategory" HeaderText="Status" HeaderStyle-Font-Bold="true">
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
            </ContentTemplate>
            </asp:UpdatePanel>
<br />
<%--<table style="width: 63%">

        <tr>
            <td align="center">
            <asp:UpdatePanel ID="up" runat="server">
                         <ContentTemplate>
                <asp:RadioButton ID="rd1" runat="server" Text="Apporved" CssClass="blackfnt"  OnCheckedChanged="rd1_CheckedChanged" />
                 </ContentTemplate>
                          </asp:UpdatePanel>
            </td>
            
            <td align="center">
            <asp:UpdatePanel ID="up2" runat="server">
                         <ContentTemplate>
                <asp:RadioButton ID="rd2" runat="server" Text="Rejected" CssClass="blackfnt" OnCheckedChanged="rd2_CheckedChanged" />
                 </ContentTemplate>
                          </asp:UpdatePanel>
            </td>
        </tr>
        </table>--%>
        <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline"   UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
    <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="true" RepeatDirection="Horizontal" Width="459px" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
        <asp:ListItem Value="rd1">Approved</asp:ListItem>
        <asp:ListItem Value="rd2">Rejected</asp:ListItem>
    </asp:RadioButtonList>
    </ContentTemplate>
    </asp:UpdatePanel>
    <br />

            <div align="center">
            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
            <asp:Panel ID="reason" runat="server" Visible="false" Width="100%">
            <font class="blackfnt"><asp:Label ID="lblReason" runat="server" Text="Reason For Reject"></asp:Label></font>
            <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" AutoPostBack="true"></asp:TextBox>
            </asp:Panel>
            </ContentTemplate>
            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="RadioButtonList1" EventName="SelectedIndexChanged" />
            </Triggers>
            </asp:UpdatePanel>
            </div>

        <asp:HiddenField ID="txtdocketlist" runat="server" />
        <asp:HiddenField ID="txtdocketlist_count" runat="server" />
<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"/>
            </div>
            

</asp:Content>
