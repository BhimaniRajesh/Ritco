<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PendingDriverBalWithoutVehicle.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_PendingDriverBalWithoutVehicle" %>

<%@ Register TagName="AutoComplete" TagPrefix="auc" Src="~/GUI/Fleet/Operations/Issue/AutoComplete/MAC.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--<script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
    <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>--%>
    <script type="text/javascript" language="javascript">
        function ValidateDate(obj) {
            if (obj.value != "") {
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }
            }
        }
    </script>
    <script language="javascript" type="text/javascript">
        function SelectSingleRadiobutton(rdbtnid) {
            var rdBtn = document.getElementById(rdbtnid);
            var rdBtnList = document.getElementsByTagName("input");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
            }
        }
    </script>
    <%--<script type="text/javascript">
        function PrintGridData() {
            var prtGrid = document.getElementById('<%=dgGeneral.ClientID %>');
            prtGrid.border = 0;
            var prtwin = window.open('', '', 'left=100,top=100,width=1000,height=1000,tollbar=0,scrollbars=1,status=0,resizable=1');
            prtwin.document.write(prtGrid.outerHTML);
            prtwin.document.close();
            prtwin.focus();
            prtwin.print();
            prtwin.close();
        }
    </script> --%>
    <script type="text/javascript">
        function PrintGridData() {
            var gridData = document.getElementById('<%= dgGeneral.ClientID %>');
            var windowUrl = 'about:blank';
            //var rowsCount = gridData.rows.length;
            //var newCount = rowsCount - 1;
            //for (i = 0; i < newCount; i++) {
            //    gridData[i].cell[7].style.display = "none";
            //}

            //set print document name for gridview
            var uniqueName = new Date();
            var windowName = 'Print_' + uniqueName.getTime();
            var prtWindow = window.open(windowUrl, windowName,
            'left=100,top=100,right=100,bottom=100,width=700,height=500');
            prtWindow.document.write('<html><head></head>');
            prtWindow.document.write('<body style="background:none !important">');
            prtWindow.document.write(gridData.outerHTML);
            prtWindow.document.write('</body></html>');
            prtWindow.document.close();
            prtWindow.focus();
            prtWindow.print();
            prtWindow.close();
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
                                                Pending Driver Balance without Vehicle
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 25%">
                                        <asp:DropDownList ID="ddlSelection" runat="server">
                                            <asp:ListItem Text="Enter Tripsheet No" Value="T" />
                                            <asp:ListItem Text="Enter Vehicle No" Value="V" />
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left" style="width: 75%" colspan="2">
                                        <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Always" runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox CssClass="input" ID="txtSelection" runat="Server" BorderStyle="Groove"></asp:TextBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4" align="center">
                                        <asp:Button ID="btnSubmit1" ValidationGroup="grpQuery" runat="server" Text="Submit" OnClick="ShowParamVice" />
                                    </td>
                                </tr>
                                <tr align="center" style="background-color: white">
                                    <td align="center" colspan="4">
                                        <asp:Label Text="OR" Font-Bold="true" runat="server" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" valign="top">
                                        <asp:Label ID="Label8" CssClass="blackfnt" runat="server" >Driver Name</asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                                            <ContentTemplate>
                                                <asp:TextBox ID="txtDriver1" runat="server" BorderStyle="Groove" MaxLength="10" CssClass="input"
                                                    Width="75px"></asp:TextBox>
                                                <asp:TextBox ID="txtDriver1Name" runat="server" CssClass="bgwhite"
                                                    Width="100px" BorderStyle="Groove"></asp:TextBox><br />
                                                <auc:autocomplete id="aucDriver" minprefixlength="1" runat="server" webxentity="Driver"
                                                    codetarget="txtDriver1" nametarget="txtDriver1Name" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
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
                                        <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Branch" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>

                                    <td align="left" colspan="2" valign="top">
                                        <asp:DropDownList ID="ddlro" AutoPostBack="True" runat="server" Width="261px" CssClass="input">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4" align="center">
                                        <asp:Button ID="btnSubmit2" ValidationGroup="grpQuery" runat="server" Text="Submit" OnClick="ShowDateVice" />
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
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Driver_Name" HeaderText="Driver Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="DriverBal" HeaderText="Driver Balance" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="VSlipNo" HeaderText="TripSheet No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="vehicleno" HeaderText="Vehicle No." HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="VSlipDt" HeaderText="Trip Sheet Open Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="EndDate" HeaderText="Financially Close Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="BalanceAmount" HeaderText="Balance Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="PaidReceivedAmount" HeaderText="Paid/Received Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="NetBalance" HeaderText="Net Balance" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:TemplateField runat="server" HeaderText="Paid/Receive" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:HyperLink runat="server" Text='<%# Eval("PayReceive") %>' NavigateUrl='<%# string.Format("~/GUI/Fleet/Operations/Issue/frmMultiDriverSettlementIssueSlip.aspx?VSlipNo={0}", HttpUtility.UrlEncode(Eval("VSlipNo").ToString())) %>'></asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField runat="server" HeaderText="Next Step" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <%--<asp:HyperLink runat="server" Text="View" NavigateUrl='<%# string.Format("~/GUI/Fleet/Operations/Issue/frmNewTripDetailsUpdateV1.aspx?id={0}", HttpUtility.UrlEncode(Eval("VSlipNo").ToString())) %>'></asp:HyperLink>--%>
                                                    <asp:HyperLink runat="server" Text="View" NavigateUrl='<%# string.Format("~/GUI/Fleet/Operations/Issue/frmDriverSettlementIssueSlipView.aspx?id={0}", HttpUtility.UrlEncode(Eval("VSlipNo").ToString())) %>'></asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>


                    <tr id="trCancel">
                        <td colspan="4" align="center">
                            <asp:Button runat="server" Text="Print" OnClientClick="PrintGridData()" ID="btnSubmitBills" />
                            <%----%>
                        </td>
                    </tr>
                </table>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
