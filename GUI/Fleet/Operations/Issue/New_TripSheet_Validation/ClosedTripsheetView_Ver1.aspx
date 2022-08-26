<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ClosedTripsheetView_Ver1.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_ClosedTripsheetView_Ver1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript">

        $(function () {
    
        });

        function ValidateDate(obj) {
            if (obj.value != "") {
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }
            }
        }
    </script>

  
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" /></td>
                    <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                    ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div align="left" style="width: 75%">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table cellspacing="1" border="0" style="width: 100%">
                    <tr align="left">
                        <td colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="left" style="height: 21px">
                                        <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                Closed Tripsheet View
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" >
                                        <font class="blackfnt">Branch Name</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <asp:DropDownList ID="cboLoc" runat="server" AutoPostBack="false" EnableViewState="true"
                                            DataTextField="LocName" DataValueField="LocCode" />
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                    <td valign="top" align="left">
                                        <asp:Label ID="Label6" CssClass="blackfnt" Text="Select Date Range" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 259px" valign="top">
                                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                            Width="244px">
                                            <asp:ListItem Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                            <asp:ListItem Selected="True" Value="2" Text=" Today:"></asp:ListItem>
                                            <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                        </asp:RadioButtonList></td>
                                    <td valign="top" align="left" style="width: 359px">
                                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtDateFrom" runat="server" />

                                        </a>
                                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtDateTo" runat="server" />

                                        <br />
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                            OnServerValidate="daterange"></asp:CustomValidator>
                                    </td>
                                </tr>
                                 <tr align="center" style="background-color: white">
                                    <td align="center" colspan="4">
                                        <asp:Label Text="OR" Font-Bold="true" runat="server" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 25%">
                                        Vehicle No
                                    </td>
                                    <td align="left" style="width: 75%" colspan="2">
                                                <asp:TextBox CssClass="input" ID="txtVehicleNo" runat="Server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr align="center" style="background-color: white">
                                    <td align="center" colspan="4">
                                        <asp:Label Text="OR" Font-Bold="true" runat="server" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 25%">
                                        <asp:DropDownList ID="ddlSelection" runat="server">
                                            <asp:ListItem Value="T" Text="Enter Trip Sheet No.:" Selected="true"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left" style="width: 75%" colspan="2">
                                        <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Always" runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox CssClass="input" ID="txtTripsheetNo" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove"></asp:TextBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>

                                <tr style="background-color: white">
                                    <td colspan="4" align="center">
                                        <asp:Button ID="btnSubmit2" ValidationGroup="grpQuery" runat="server" Text="Submit" OnClick="btnSubmit2_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <%--*************************** Gridarea ****************************--%>
                <table border="0" cellspacing="1" cellpadding="3" width="900px">
                    <tr>
                        <td align="center">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
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
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" OnRowCreated="dgGeneral_RowCreated">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="vehicleno" HeaderText="VehicleNo" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="VSlipNo" HeaderText="TripSheetNo" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="StartDate" HeaderText="Open Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="SubmitDate" HeaderText="Submit Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="isApprovedDate" HeaderText="Approval Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="FinacialClosureDate" HeaderText="Financial Closure Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="Distance" HeaderText="Distance" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="AddBlueRatio" HeaderText="AddBlue Ratio" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="VehicleFuelEconomy" HeaderText="Fuel Economy" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="FuelEconomy" HeaderText="Actual Fuel Economy" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TotalRevenue" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TotalRevenuePerKm" HeaderText="Per KM" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TotalExpense" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TotalExpensePerKm" HeaderText="Per KM" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TotalFixedExpense" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TotalFixedExpensePerKm" HeaderText="Per KM" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TotalIncome" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TotalIncomePerKm" HeaderText="Per KM" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="Cash_BF" HeaderText="B/F" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="Cash_CF" HeaderText="C/F" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />

                                            <asp:BoundField DataField="Diesel_BF" HeaderText="B/F" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="Diesel_CF" HeaderText="C/F" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />

                                            <asp:BoundField DataField="DriverSettlement" HeaderText="Driver Settlement Done/Pending" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="TripDetention" HeaderText="Trip Detention" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />

                                            <asp:TemplateField runat="server" HeaderText="Vehicle Wise Details" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink runat="server" Target="_blank" Text="View" NavigateUrl='<%# string.Format("~/GUI/Fleet/Operations/Issue/New_TripSheet_Validation/ClosedTripsheetView_Details_Ver1.aspx?VSlipNo={0}", HttpUtility.UrlEncode(Eval("VSlipNo").ToString())) %>'></asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>


                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>
