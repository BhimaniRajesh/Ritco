<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="CallRegister_CompanywiseReport2.aspx.cs" Inherits="REPORT_CallRegister_CompanywiseReport2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Visit Register-Company Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
         <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
        
    <div align="left">
    
    
    <%--<p align="center"><font class="blackfnt"><b>You Selected</b></font></p>--%>
  <table border="0" cellpadding="3" cols="1" width="50%" bgcolor="#808080" cellspacing="1" class="boxbg">
      
      
       <tr bgcolor="#ffffff"> 
        <td> <div>
         <font class="blackfnt">Company </font></div>
        </td>
        <td   align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblCompanyName" runat="server" Text="Label"></asp:Label></font></div>
        </td>
       </tr>
       <tr bgcolor="#ffffff"> 
        <td> 
         <div><font class="blackfnt">Call Date </font></div>
        </td>
        <td   align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblCallDate" runat="server" Text="Label"></asp:Label></font></div>
        </td>
       </tr>
        </table> 
 
  <br />
  
    
    
    
    
    
<asp:GridView ID="dgCallCompany" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="bgbluegrey"
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
                               <asp:BoundField DataField="companyName" HeaderText="CompanyName" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="callCode" HeaderText="CallCode" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="callDt" HeaderText="CallDate" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CallTime" HeaderText="CallTime" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="callDuration" HeaderText="CallDuration" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CallType" HeaderText="CallType" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="contPerson" HeaderText="Cont.Person" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PersonCalled" HeaderText="Person Met" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="discPoint" HeaderText="DiscPoint" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AcctCategory" HeaderText="AccCategory" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        </div>
</asp:Content>
