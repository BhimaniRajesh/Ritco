<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FuelRateUpdation_SubmitForValidationPopUp.aspx.cs" Inherits="GUI_Fleet_Webadmin_FuelRateMaster_FuelRateUpdation_SubmitForValidationPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BranchList</title>
</head>
<body>
    <form id="form1" runat="server">
        
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="6" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="View Previous History"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />

            <%--*************************** Gridarea ****************************--%>
            
            <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblDCR">
                <tr style="background-color: white">
                    <td align="center" width="100%">
            
                                <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                     CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                    CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                    PagerSettings-Mode="NumericFirstLast">

                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" InsertVisible="false"
                                            ReadOnly="True" SortExpression="VendorName" />
                                        <asp:BoundField DataField="UpdationDate" HeaderText="Updation Date" InsertVisible="false"
                                            ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="DateFrom" HeaderText="Date From" InsertVisible="false"
                                            ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="DateTo" HeaderText="Date To" ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="Product" HeaderText="Product" ReadOnly="true" />
                                        <asp:BoundField DataField="Rate" HeaderText="Rate" ReadOnly="true" />
                                        <asp:BoundField DataField="ValidatedDate" HeaderText="Validated Date" InsertVisible="false"
                                            ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" InsertVisible="false"
                                            ReadOnly="True" SortExpression="" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
           
        <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
        </div>


    </form>
</body>
</html>
