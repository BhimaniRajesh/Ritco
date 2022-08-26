<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="MIS_FuelBillVendor.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_MIS_FuelBillVendor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
    <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>


    <script type="text/javascript" language="javascript">
        var TYPE='';
        function Edit_Alert() {
            if (confirm('Do you want to send for Date Entry?')) {
                return true;
            }
            else {
                return false;
            }
        }
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
                                                    MIS for Fuel Bill Vendor Total Detail 
                                        </asp:Label>
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
                                <tr style="background-color: white">


                                    <td valign="top" align="left">
                                        <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Vendor" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>

                                    <td align="left" colspan="2" valign="top">
                                        <asp:DropDownList ID="ddVendorName" AutoPostBack="True" runat="server" Width="261px" CssClass="input">
                                        </asp:DropDownList>
                                    </td>
                                </tr>

                                <tr style="background-color: white">


                                    <td valign="top" align="left">
                                        <asp:Label ID="lblStatus" CssClass="blackfnt" Text="Select Status" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>

                                    <td align="left" colspan="2" valign="top">
                                        <asp:DropDownList ID="ddlStatus" AutoPostBack="false" runat="server" Width="261px" CssClass="input">
                                            <asp:ListItem Value="Paid" Selected="True">Paid</asp:ListItem>
                                            <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                            <%--<asp:ListItem Value="All">All</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4">
                                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" runat="server" Text="Submit" OnClick="ShowBillDetails" />
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
                                    <asp:GridView ID="gvPending" runat="server" AutoGenerateColumns="False"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" Visible="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"
                                                 HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                            <asp:HyperLinkField HeaderStyle-Width="75px" DataTextField="Bill_No" Target="_blank" ItemStyle-HorizontalAlign="Center" DataNavigateUrlFields="Bill_No" DataNavigateUrlFormatString="~/GUI/admin/FuelSlipMaster/PendingFuelView.aspx?QBillNo={0}" InsertVisible="false" HeaderText="Fuel Bill No" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="BillDate" HeaderText="Bill Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  SortExpression="Vendor Code" />
                                            <asp:BoundField DataField="NetBillAmount" HeaderText="Net Bill Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  SortExpression="City" />
                                            <asp:BoundField HeaderStyle-Width="75px" DataField="TotalSlips" HeaderText="No. of Slips" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  SortExpression="PeriodTo" />
                                            <asp:BoundField NullDisplayText="NA" DataField="InstrumentNo" HeaderText="Cheque No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="InstrumentDate" HeaderText="Cheque Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="PaidAmount" HeaderText="Paid Amount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="PendingAmount" HeaderText="Balance" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />


                                            
                                            <asp:TemplateField HeaderText="Download: Pdf Format">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txttype" runat="server" Visible="false"></asp:TextBox>
                                                    <asp:HyperLink runat="server" Text="Download" NavigateUrl='<%# string.Format("Download.aspx?DocNo={0}&TYPE=PDF&Status=Pending", HttpUtility.UrlEncode(Eval("Bill_No").ToString())) %>'></asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                           <asp:TemplateField HeaderText="Download: XLS Format">
                                                <ItemTemplate>
                                                   <%-- <asp:HyperLink runat="server" Text="Download" NavigateUrl='<%# string.Format("Download.aspx?Bill_No={0}", HttpUtility.UrlEncode(Eval("Bill_No").ToString())) %>'></asp:HyperLink>--%>
                                                     <asp:HyperLink runat="server" Text="Download" NavigateUrl='<%# string.Format("Download.aspx?DocNo={0}&TYPE=XLS&Status=Pending", HttpUtility.UrlEncode(Eval("Bill_No").ToString())) %>'></asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center" width="100%">
                            <asp:UpdatePanel ID="u2" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gvPaid" runat="server" AutoGenerateColumns="False"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" Visible="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"
                                                 HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                            <asp:BoundField DataField="VoucherNo" HeaderText="Voucher No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="NoOfBills" HeaderText="No of Bills" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  SortExpression="Vendor Code" />
                                            <asp:BoundField HeaderStyle-Width="75px" DataField="TotalSlips" HeaderText="No. of Slips" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                            <asp:BoundField NullDisplayText="NA" DataField="TotalBillAmount" HeaderText="Total Bill Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="TotalDiscount" HeaderText="Total Discount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="TotalSpecialDiscount" HeaderText="Special Discount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="TotalNetBillAmount" HeaderText="Total Net Bill Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="PaidAmount" HeaderText="Paid Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="BalanceAmount" HeaderText="Balance Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            
                                            <asp:TemplateField HeaderText="Download: Pdf Format">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txttype" runat="server" Visible="false"></asp:TextBox>
                                                    <asp:HyperLink runat="server" Text="Download" NavigateUrl='<%# string.Format("Download.aspx?DocNo={0}&TYPE=PDF&Status=Paid", HttpUtility.UrlEncode(Eval("VoucherNo").ToString())) %>'></asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                           <asp:TemplateField HeaderText="Download: XLS Format">
                                                <ItemTemplate>
                                                   <%-- <asp:HyperLink runat="server" Text="Download" NavigateUrl='<%# string.Format("Download.aspx?Bill_No={0}", HttpUtility.UrlEncode(Eval("Bill_No").ToString())) %>'></asp:HyperLink>--%>
                                                     <asp:HyperLink runat="server" Text="Download" NavigateUrl='<%# string.Format("Download.aspx?DocNo={0}&TYPE=XLS&Status=Paid", HttpUtility.UrlEncode(Eval("VoucherNo").ToString())) %>'></asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                   <%-- <tr id="trCancel">
                        <td align="right">
                            <asp:Button runat="server" Text="Submit" ID="btnSubmitBills" OnClick="btnSubmitBills_Click" />
                        </td>
                    </tr>

                    <tr>
                        <td align="right">
                            <asp:Label runat="server" ID="lblSuccess" ForeColor="Blue" Text=""></asp:Label>
                        </td>
                    </tr>--%>
                </table>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>

       
<%--        <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tbldownload">
            <tr style="background-color: white">
                <td align="center" width="100%">
                    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="grddownload" runat="server" AutoGenerateColumns="False"
                                CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"  HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                    <asp:BoundField DataField="VehicleNo" ItemStyle-HorizontalAlign="Left" HeaderText="Truck No" InsertVisible="false"  HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="UserSlipNo" HeaderText="Slip No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                    <asp:BoundField DataField="FillingDate" HeaderText="Filling Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                    <asp:BoundField DataField="Quantity" HeaderText="Ltrs" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                    <asp:BoundField DataField="Rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                </Columns>
                                <Columns>
                                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"  />
                                </Columns>
                                <Columns>
                                    <asp:BoundField DataField="InstrumentNo" HeaderText="Instrument No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"  />
                                    <asp:BoundField DataField="InstrumentDate" HeaderText="InstrumentDate" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                    <asp:BoundField DataField="BankName" HeaderText="Bank Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                   
                                </Columns>


                            </asp:GridView>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label runat="server" ID="Label2" ForeColor="Blue" Text=""></asp:Label>
                </td>
            </tr>
        </table>--%>
           
    </div>
</asp:Content>





