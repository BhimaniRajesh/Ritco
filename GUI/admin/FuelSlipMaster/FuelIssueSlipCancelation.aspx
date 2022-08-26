<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FuelIssueSlipCancelation.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_FuelIssueSlipCancelation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>

           <%-- <script language="javascript" type="text/javascript">
                window.onload = function () { 
                    var div = document.getElementById('ctl00_MyCPH1_trCancel');
                    div.style.display = 'none';
                }

                function HideBlock() {  
                    var button = document.getElementById('ctl00_MyCPH1_btnSubmit');
                    var div = document.getElementById('ctl00_MyCPH1_trCancel');
                   
                        if (div.style.display == 'none') {
                            div.style.display = 'block';
                        }
                        else {
                            div.style.display = 'none';
                        } 
                }
            </script>--%>

            <table border="0" cellspacing="1" cellpadding="3" width="500px" class="boxbg" id="tblDCRCriteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="4" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Fuel Issue Slip Cancelation"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="right" id="tdVendorlbl" width="25%">
                        <font class="blackfnt">Enter Fuel Slip No:</font>&nbsp;&nbsp;
                    </td>
                    <td align="left" id="tdVendortxt">
                        <asp:TextBox ID="txtFuelSlipNo" CssClass="input" BorderStyle="Groove" Width="200px" runat="server" TabIndex="1"></asp:TextBox>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="right" colspan="2">
                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" runat="server" Text="Submit" OnClick="GetFuelIssueSlipCancellation"/>
                    </td>
                </tr>
            </table>
            <br />
            <%--*************************** Gridarea ****************************--%>
            <table border="0" cellspacing="1" cellpadding="3" width="900px">
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblDCR">
                <tr style="background-color: white">
                    <td align="center" width="100%">
                        <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                     CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                    CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                    PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" > <%--DataSourceID="SqlDataSource1" OnRowCommand="dgGeneral_RowCommand"--%>
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" ItemStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkbxSelect" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="UserSlipNo" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="200px" HeaderText="Fuel Issue Slip No." ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="UserSlipNo" />

                                        <asp:TemplateField HeaderText="View Details" ItemStyle-Width="200px">
                                            <ItemTemplate>
                                                <asp:HyperLink runat="server" Target="_blank" NavigateUrl='<%# string.Format("~/GUI/admin/FuelSlipMaster/FuelIssueSlipCancelationView.aspx?UserSlipNo={0}", HttpUtility.UrlEncode(Eval("UserSlipNo").ToString())) %>' Text="View" />
                                            </ItemTemplate> 
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Remarks" ItemStyle-Width="300px">
                                            <ItemTemplate>
                                                <asp:TextBox CssClass="input" Width="250px" BorderStyle="Groove" runat="server" ID="txtbxRemarks"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr id="trCancel">
                    <td align="right">
                        <asp:Button runat="server" Text="Submit for Cancellation" ID="btnSubmit_Cancel" OnClick="btnSubmit_Cancel_Click" />
                    </td>
                </tr> 
            </table>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>


