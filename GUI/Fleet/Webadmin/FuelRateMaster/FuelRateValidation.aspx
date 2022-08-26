<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FuelRateValidation.aspx.cs" Inherits="GUI_Fleet_Webadmin_FuelRateMaster_FuelRateValidation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>


            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="6" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Submit for Validation"
                            Font-Bold="true"></asp:Label>
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
                                    DataSourceID="SqlDataSource1" CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                    CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                    PagerSettings-Mode="NumericFirstLast">

                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                        </asp:TemplateField>
                                       <%-- <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" InsertVisible="false"
                                         ReadOnly="True" SortExpression="VendorName" ItemStyle-HorizontalAlign="Left" /> 
                                        <asp:BoundField DataField="" HeaderText="Vendor City" ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="" HeaderText="Vendor Code" ReadOnly="True" SortExpression="" /> 
                                        <asp:BoundField DataField="DateFrom" HeaderText="Date From" ItemStyle-HorizontalAlign="Left" InsertVisible="false"
                                        ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="DateTo" HeaderText="Date To" ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="Product" HeaderText="Product" ReadOnly="true" />
                                        <asp:BoundField DataField="Rate" HeaderText="Rate" ReadOnly="true" /> --%>



                                        <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"
                                         ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" /> 
                                        <asp:BoundField DataField="VendorCity" HeaderText="Vendor City" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="City" /> 
                                        <asp:BoundField DataField="VendorCode" HeaderText="Vendor Code" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Vendor Code" />
                                        <asp:BoundField DataField="DateFrom" HeaderText="Period From" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="PeriodTo" />
                                        <asp:BoundField DataField="DateTo" HeaderText="Period To" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="false" /> 
                                        <asp:BoundField DataField="Product" HeaderText="Product" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                        <asp:BoundField DataField="Rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ReadOnly="true" /> 

                                        <%--<asp:BoundField DataField="" HeaderText="Action Y" ReadOnly="True" SortExpression="" /> 
                                            <asp:BoundField DataField="" HeaderText="Action N" ReadOnly="True" SortExpression="" />--%>

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnSrNo" runat="server" Value='<%# Eval("SrNo") %>'/>
                                                <asp:RadioButton ID="rdbtnYes" GroupName="action" Text="Yes" runat="server" />
                                                  <asp:RadioButton ID="rdbtnNo" GroupName="action" Text="No" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView> 
                               <tr>
                                   <td align="right">
                                       <asp:Button ID="btnSubmit" runat="server" Text="Submit for Validation" OnClick="btnSubmit_Click" />
                                   </td>
                               </tr> 
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>

                 <tr>
                    <td align="right">
                       <asp:Label runat="server" ID="lblSuccess" ForeColor="Blue" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>



