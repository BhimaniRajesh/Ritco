<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmMenifestView.aspx.cs"
    Inherits="GUI_Operations_TCS_PrintTCS_FrmMenifestView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <script src="../../../Js/jquery-1.11.1.js"></script>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
<!--

    function TABLE1_onclick() {

    }


    function DocketView(ctrl) {
        var lblfunction1 = $(ctrl);
        var DocketNo = $("#" + lblfunction1.attr('id').replace("lblfunction1", "hdnDocketNo")).val();
        var hdnDocketSf = $("#" + lblfunction1.attr('id').replace("lblfunction1", "hdnDocketSf")).val();

        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
        var strPopupURL = "./../../../Operation/DocketEntry/DocketPrint/DocketView_Xls.aspx?dockno=" + DocketNo + "&docksf=" + hdnDocketSf
        winNew = window.open(strPopupURL, "_blank", strWinFeature)

        }

        function PODView(ctrl) {
            var lblPOD = $(ctrl);
            var POD = $("#" + lblPOD.attr('id').replace("lblPOD", "hdnPOD")).val();
            if (POD != "") {
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
				var strPopupURL = "https://ritcoblob.blob.core.windows.net/"+$("#hdnContainerName").val()+"/" + POD;
                winNew = window.open(strPopupURL, "_blank", strWinFeature);
            }
        }

// -->
    </script>

</head>
<body style="margin-top: 0; margin-left: 5px">
    <form id="form1" runat="server">
        <% string strMFNO = Request.QueryString.Get("MFNo");
            string[] Split = strMFNO.Split(new Char[] { ',' });
            string mfno = Convert.ToString(Split[0]);
            string print_yn = Convert.ToString(Split[1]);
            string boxbg = "boxbg";
            string bgbluegrey = "bgbluegrey";
            string strborder = "0";
            string strspace = "1";
            if (print_yn == "1")
            {
                boxbg = "";
                bgbluegrey = "bgwhite";
                strborder = "1";
                strspace = "1";
            }

        %>
        <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
            style="width: 7.0in">
            <tr bgcolor="white">
                <td align="left" rowspan="3" style="width: 62%">
                    <asp:Image Height="50" ID="imgLogo" runat="server" /><br />
                    <%--<asp:Image ID="imgLogo" ImageUrl="~/GUI/images/webxpress_logo.gif" runat="server" />--%>
                    <asp:Label ID="txtLocAddress" runat="server" CssClass="blackfnt" Wrap="true"></asp:Label><br />
                    <asp:Label ID="lblGstNo" runat="server" CssClass="blackfnt"></asp:Label><br />
                    <%-- <asp:Label ID="lblPinCode" runat="server" CssClass="blackfnt"></asp:Label><br />--%>
                    <asp:Label ID="lblPhone" runat="server" CssClass="blackfnt"></asp:Label>
                    <br />
                    <strong><span style="font-size: 8pt; font-family: Verdana">MANIFEST</span></strong></td>
                <td align="left">
                    <font class="blackfnt"><b><span>MF No</span></b></font></td>
                <td align="left" style="font-size: 8pt; font-family: Verdana; width: 210px;">
                    <font class="blackfnt"><strong>&nbsp;<asp:Label ID="lblMFNo" runat="server" Width="97%"
                        Font-Bold="False"></asp:Label></strong></font></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                <td align="left" style="width: 16%">
                    <font class="blackfnt"><b>MF Date</b></font></td>
                <td align="left" style="width: 210px">
                    <font class="blackfnt">&nbsp;<asp:Label ID="lblMFDate" runat="server" Width="97%"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width: 16%">
                    <font class="blackfnt"><b>Manual MF No</b></font></td>
                <td align="left" style="width: 210px">
                    <font class="blackfnt">&nbsp;<asp:Label ID="lblMMFNo" runat="server" Width="97%"></asp:Label></font>
					<asp:HiddenField ID="hdnContainerName" Value="" runat="server"></asp:HiddenField>
					</td>
            </tr>
        </table>
        <br />
        <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
            id="TABLE1" language="javascript" onclick="return TABLE1_onclick()" style="width: 7.0in">
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt"><b>Route</b></font></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="LblRoute" runat="server" Width="97%" CssClass="blackfnt"></asp:Label></font></td>
                <td align="left" class="blackfnt">
                    <b>From-To&nbsp;</b></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="LblFromTo" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></font></td>
                <td align="left">
                    <font class="blackfnt"><b>THC Start Location</b></font></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="LblTHCLocation" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt"><b>THC No</b></font></td>
                <td align="left">
                    <asp:Label ID="LblTHCNo" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
                <td align="left" class="blackfnt">
                    <b>THC Date</b></td>
                <td align="left">
                    <asp:Label ID="LblTHCDate" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
                <td align="left">
                    <b><font class="blackfnt"><b>Vehicle</b></font></b></td>
                <td align="left">
                    <b>
                        <asp:Label ID="LblVehicle" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></b></td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="GrdPaidFollow" GridLines="None" Style="width: 7.0in" ShowFooter="True" EmptyDataText="No Records Found....."
            PagerStyle-Mode="NumericPages" AutoGenerateColumns="False"
            BackColor="White" runat="server" BorderColor="Black" BorderWidth="1" SelectedIndex="1" CellSpacing="0"
            OnRowDataBound="GrdPaidFollow_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Docket No./Pay Basis">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle />
                    <ItemTemplate>
                        <asp:Label ID="lblfunction1" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"dockno")) + "" + Convert.ToString(DataBinder.Eval( Container.DataItem,"docksf")) +" - "+ Convert.ToString(DataBinder.Eval( Container.DataItem,"Payment_Basis")) %>'
                            onclick="DocketView(this);" runat="server" style="text-decoration:underline"></asp:Label>
                        <asp:HiddenField ID="hdnDocketNo" Value='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"dockno")).Trim()%>' runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="hdnDocketSf" Value='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"docksf")).Trim()%>' runat="server"></asp:HiddenField>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <%-- <asp:BoundField HeaderText="Mode/ServiceType" DataField="Mode">
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>--%>
                <asp:BoundField DataFormatString="{0:dd-MMM-yy}" HeaderText="Booking Date" DataField="BookingDate">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Contents" DataField="Contents">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Packaging Type" DataField="PackaginType">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Origin - Delivery Location" DataField="Location">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="From - To" DataField="LocationTo">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <%--<asp:BoundField HeaderText="Consignor" DataField="Cnor_Name">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Consignee" DataField="Cnee_name">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>--%>
                <asp:BoundField HeaderText="Packages L/B" DataField="Pkgs_LB">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Weight L/B -- kg-Total" DataField="Freight">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Invoice Amt" DataField="invamt">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Private Mark" DataField="privatemark">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="POD">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle />
                    <ItemTemplate>
                        <asp:Label ID="lblPOD" CssClass="blackfnt" Text='' onclick="PODView(this);" runat="server" style="text-decoration:underline"></asp:Label>
                        <asp:HiddenField ID="hdnPOD" Value='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"POD")).Trim()%>' runat="server"></asp:HiddenField>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />

            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <br />
        <table border='<%=strborder %>' cellpadding="0" class='<%=boxbg %>'
            style="border-bottom: none; border-top: none; width: 7.0in">
            <tr class="bgbluegrey" bgcolor="#ffffff">
                <td align="center" style="width: 210px">
                    <font class="blackfnt"><b>Prepared At - Date</b></font>
                </td>
                <td align="center" style="width: 169px">
                    <font class="blackfnt"><b>Prepared by Staff Name</b></font>&nbsp;</td>
                <td align="center" style="width: 120px">
                    <font class="blackfnt"><b>Approval Sign</b></font></td>
                <td align="center" style="width: 104px">
                    <font class="blackfnt"><b>Driver Sign</b></font></td>
                <td align="center" style="width: 167px">
                    <font class="blackfnt"><b>Entered At - Date</b></font></td>
                <td align="center" class="blackfnt">
                    <b>Entered by</b>
                </td>
            </tr>
            <tr align="center" bgcolor="#ffffff">
                <td align="center" style="width: 210px">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblPreparedAt" runat="server" Font-Bold="False" Width="94%"></asp:Label></b></font></td>
                <td align="center" style="width: 169px">
                    <asp:Label ID="LblStaffName" CssClass="blackfnt" runat="server" Width="88%"></asp:Label></td>
                <td align="center" style="width: 120px">
                    <asp:Label ID="LblSign" runat="server" CssClass="blackfnt" Width="89%"></asp:Label></td>
                <td align="center" style="width: 104px">
                    <asp:Label ID="LblDriverSign" CssClass="blackfnt" runat="server" Width="88%"></asp:Label></td>
                <td align="center" style="width: 167px">
                    <font class="blackfnt">
                        <asp:Label ID="LblAt" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></font></td>
                <td align="center">
                    <asp:Label ID="LblPreparedBy" runat="server" CssClass="blackfnt" Width="87%"></asp:Label></td>
            </tr>
        </table>
        <br />
        <asp:Label ID="LblMFLocation" CssClass="blackfnt" runat="server" Width="100%" Visible="False"></asp:Label><br />
        <asp:Label ID="LblNextLocation" CssClass="blackfnt" runat="server" Width="100%" Visible="False"></asp:Label>
        <%
            if (print_yn == "1")
            {

        %>

        <script language="javascript" type="text/javascript">

            function loadme() {
                window.print();
            }
            window.load = loadme()
        </script>

        <%} %>
    </form>
</body>
</html>
