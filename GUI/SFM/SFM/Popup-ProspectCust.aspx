<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Popup-ProspectCust.aspx.cs" Inherits="_Default" %>
<%@ Reference Control="~/include/menu.ascx"%>
<%@ Register TagPrefix="menu" TagName="Header" Src="~/include/menu.ascx" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../include/Styles.css" rel="stylesheet" type="text/css" />

</head>



<body>
    <form id="form1" runat="server">
    <menu:header id="Header1" runat="server" ></menu:header>
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <div>
        <br />
       
            &nbsp;<p>
            </p>
            <center>
                <table border="0" cellpadding="0" cellspacing="1" style="font-size: 12pt; font-family: Times New Roman; width: 47%;">
                    <tr>
                        <td>
                            <font class="blackfnt"><b><u>Note:</u></b><strong>
                                <!--<br>- Please enter Customer Name start with 'S' as 'S'-->
                                <br />
                                - For All Prospect/Customer list,keep blank both the input box. </strong></font>
                        </td>
                    </tr>
                </table>
                <table border="1" cellpadding="2" cellspacing="1" style="font-weight: bold; font-size: 12pt;
                    font-family: Times New Roman; width: 45%;" >
                    <tr class="bgbluegrey">
                        <td align="middle" colspan="2" style="height: 20px">
                            <font class="blackfnt">Search by parameter</font></td>
                    </tr>
                    <tr>
                        <td style="width: 239px; height: 27px">
                            <font class="blackfnt">Customer Code</font></td>
                        <td style="height: 27px">
                            <font class="blackfnt">
                                <asp:TextBox ID="CustCode" runat="server"></asp:TextBox>&nbsp;</font></td>
                    </tr>
                    <tr>
                        <td style="width: 239px; height: 24px">
                            <font class="blackfnt">Customer Name</font></td>
                        <td style="height: 24px">
                            <font class="blackfnt">
                                <asp:TextBox ID="CustName" runat="server"></asp:TextBox></font></td>
                    </tr>
                    <tr style="font-size: 12pt; font-family: Times New Roman">
                        <td align="middle" colspan="2" style="height: 26px">
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Submit" /></td>
                    </tr>
                </table>
                
                <table border="0" cellpadding="0" cellspacing="1" width="270">
                    <tr>
                        <td  align="center" width="200">
        <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
            <ContentTemplate>
            <asp:GridView ID="dgSelect" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle"
                            AllowSorting="true" AllowPaging="true" PageSize="5" PagerStyle-HorizontalAlign="left"                             
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="false" 
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" OnPageIndexChanging="pgChange" Width="429px">
                    <Columns>
                        <asp:HyperLinkField DataNavigateUrlFields="ProspectCode" DataNavigateUrlFormatString="callreg_inter.aspx?ProspectCode={0}"
                            DataTextField="ProspectCode" DataTextFormatString="select">
                            <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                        </asp:HyperLinkField>
                        
                        
                       <asp:BoundField DataField="ProspectCode" HeaderText="Customer Code">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CompanyName" HeaderText="Company">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                        </asp:BoundField>
                        
                       
                        
                    </Columns>
                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                    <PagerStyle HorizontalAlign="Left" />
                    <HeaderStyle CssClass="dgHeaderStyle" />
                </asp:GridView>
            </ContentTemplate>
            
        </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
                <br />
            </center>
            <p>
                &nbsp;<table style="width: 712px">
                    <tr>
                       
                    </tr>
                   
                </table>
                <!-- Script Size:  0.56 KB  --></p>
      
       <br />
        <br />




        
        
    </div>
    </form>
</body>

</html>
