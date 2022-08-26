<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="POFinalized.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_POViewPrint_POViewPrintResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("Div1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var FinYear="<%=Session["FinYear"]%>"
        var FinYear_to=parseInt(FinYear)+1
    
        function Popup(Path) {
            window.open(Path, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }

        function Checkall(obj) {
            Str = "";
            var pref = "ctl00_MyCPH1_dgPODetails";
            var tbl = document.getElementById("ctl00_MyCPH1_dgPODetails");
            var Totalcount = tbl.rows.length;
            var chkPOno;
            if (obj.checked == true) {
                for (i = 2; i <= Totalcount; i++) {
                    if (i < 10) {
                        chkPOno = document.getElementById(pref + "_ctl0" + i + "_chkPOno");
                    }
                    else {
                        chkPOno = document.getElementById(pref + "_ctl" + i + "_chkPOno");
                    }

                    chkPOno.checked = true;
                }
            }
            else if (obj.checked == false) {
                for (i = 2; i <= Totalcount; i++) {
                    if (i < 10) {
                        chkPOno = document.getElementById(pref + "_ctl0" + i + "_chkPOno");
                    }
                    else {
                        chkPOno = document.getElementById(pref + "_ctl" + i + "_chkPOno");
                    }

                    chkPOno.checked = false;
                }
            }
        }
        function CheckData() {
            var prefix = "ctl00_MyCPH1_";
            var grvcontrol = "ctl00_MyCPH1_dgPODetails";
            var txtApprovaldt = document.getElementById(prefix + "txtApprovaldt");
            var click_count = parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)

            if (txtApprovaldt.value == "") {
                alert("Please Enter PO Approval Date");
                txtMRdt.focus();
                return false;
            }
            
            //if (!isValidDate(txtApprovaldt.value, "PO Approval")) {
            //    txtApprovaldt.value = "";
            //    txtApprovaldt.focus();
            //    return false;
           // }
            var dateflag = CheckFinacialYear(txtApprovaldt, "PO Approval");
            if (!dateflag)
                return false;

            var tbl = document.getElementById("ctl00_MyCPH1_dgPODetails");
            var Totalcount = tbl.rows.length;
            var chkPOno, hdnPOdt;
            var non = 0;
            for (i = 2; i <= Totalcount; i++) {
                if (i < 10) {
                    hdnPOdt = document.getElementById(grvcontrol + "_ctl0" + i + "_hdnPOdt");
                    chkPOno = document.getElementById(grvcontrol + "_ctl0" + i + "_chkPOno");
                }
                else {
                    hdnPOdt = document.getElementById(grvcontrol + "_ctl" + i + "_hdnPOdt");
                    chkPOno = document.getElementById(grvcontrol + "_ctl" + i + "_chkPOno");
                }

                if (chkPOno.checked == true) {
                    non = 1;
                    var chq_dt = hdnPOdt.value
                    var voucher_dt = txtApprovaldt.value

                    var vdt_dd = voucher_dt.substring(0, 2)
                    var vdt_mm = voucher_dt.substring(3, 5)
                    var vdt_yy = voucher_dt.substring(6, 10)

                    var cdt = chq_dt
                    var cdt_dd = cdt.substring(0, 2)
                    var cdt_mm = cdt.substring(3, 5)
                    var cdt_yy = cdt.substring(6, 10)

                    voucher_dt = new Date(months[parseFloat(vdt_mm)] + " " + parseFloat(vdt_dd) + ", " + parseFloat(vdt_yy))
                    chq_dt = new Date(months[parseFloat(cdt_mm)] + " " + parseFloat(cdt_dd) + ", " + parseFloat(cdt_yy))

                    if (voucher_dt < chq_dt) {
                        alert("PO Approval Date Should Not Be Less than PO Generation Date!!!")
                        txtApprovaldt.value = "";
                        txtApprovaldt.focus();
                        return false;
                    }
                }
            }
            if (non == 0) {
                alert("Plz Select Atleast One PO Number!!!");
                return false;
            }
            if (click_count > 0) {
                alert("Sorry... You cannot click twice !!!")
                return false;
            }
            else {
                click_count = click_count + 1
                document.getElementById("ctl00_MyCPH1_click_count").value = click_count
            }
            return true;
        } 
    </script>

    <table border="0" cellpadding="3" width="600" bgcolor="#ffffff" cellspacing="1" class="boxbg"
        align="left">
        <tr style="background-color: white" align="center">
            <td align="left" colspan="2">
                <table border="0" cellpadding="3" width="825" bgcolor="#ffffff" cellspacing="1" class="boxbg"
                    align="left">
                    <tr style="background-color: white" align="center">
                        <td align="center" colspan="2">
                            <asp:Label ID="lblWelcome" runat="server" Text="General PO Details" CssClass="blackfnt"
                                Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="left">
                            <font class="blackfnt"><b>Date Selection</b></font>
                        </td>
                        <td align="left">
                            <font class="blackfnt">
                                <asp:Label ID="lblDate" runat="server"></asp:Label></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="left">
                            <font class="blackfnt"><b>Vendor Code & Name</b></font>
                        </td>
                        <td align="left">
                            <font class="blackfnt">
                                <asp:Label ID="lblVendorCode" runat="server"></asp:Label></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="left">
                            <font class="blackfnt"><b>Purchase Order No</b></font>
                        </td>
                        <td align="left">
                            <font class="blackfnt">
                                <asp:Label ID="lblGRNCode" runat="server"></asp:Label></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="left">
                            <font class="blackfnt"><b>Manual Purchase Order No</b></font>
                        </td>
                        <td align="left">
                            <font class="blackfnt">
                                <asp:Label ID="lblManualGRNCode" runat="server">
                                </asp:Label>
                            </font>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" colspan="2">
                <table border="0" cellpadding="3" width="825" bgcolor="#ffffff" cellspacing="1" class="boxbg"
                    align="left">
                    <tr style="background-color: white">
                        <td align="center" colspan="2">
                            <asp:Label ID="lbl" CssClass="blackfnt" Text="Enter PO Approval Date : " runat="server"
                                Width="202px"></asp:Label>
                        <asp:TextBox ID="txtApprovaldt" Width="80px" runat="server"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtApprovaldt, 'alnkdt', 'dd/MM/yyyy'); return false;"
                                id="alnkdt">
                                <img src="../../../images/calendar.jpg" border="0" alt="" /></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: white" align="center">
            <td align="left" colspan="2">
                <table border="0" cellpadding="3" width="600" bgcolor="#ffffff" cellspacing="1" class="boxbg"
                    align="left">
                    <tr style="background-color: white" align="center">
                        <td align="left" colspan="2">
                            <asp:GridView ID="dgPODetails" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5"
                                HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AutoGenerateColumns="false"
                                CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8ba0e5"
                                Width="800">
                                <Columns>
                                    <asp:TemplateField ControlStyle-Width="50px">
                                        <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            <input name="chkall" type="checkbox" onclick="Checkall(this);" value='ALL'>
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="5%" />
                                        <ItemTemplate>
                                            <input type="checkbox" id="chkPOno" runat="server" value='<%# DataBinder.Eval(Container.DataItem,"pocode")%>' />
                                            <asp:HiddenField ID="hdnPOdt" Value='<%# DataBinder.Eval(Container.DataItem,"podate1")%>'
                                                runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PO Code">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="120" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPOCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"pocode") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manual PO Code">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="400" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblManPOCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Manual_PO_No") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Credit Days">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="200" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreditDays" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"CreditDay") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PO Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPODate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"PODT") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vendor Name">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="370" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblVendorName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VENDORCD") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Qty.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalQty" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"QTY") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PO Amount">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblBalanceQty" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Amount") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PO Status">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="100" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPOSTATUS" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"POSTATUS") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="50" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <a href="JavaScript:Popup('../ViewPrint/PO_GenerationView.aspx?PONumber=<%#DataBinder.Eval(Container.DataItem,"pocode") %>,0')">
                                                <font class="blackfnt">
                                                    View</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Print">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="50" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <a href="JavaScript:Popup('../ViewPrint/PO_GenerationView.aspx?PONumber=<%#DataBinder.Eval(Container.DataItem,"pocode") %>,1')">
                                                <font class="blackfnt">
                                                    Print</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                <PagerStyle HorizontalAlign="Left" />
                                <HeaderStyle CssClass="dgHeaderStyle" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="center" colspan="2">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="75px" CssClass="fbtn"
                    OnClick="btnSubmit_Click" OnClientClick="javascript:return CheckData();" />
                <asp:HiddenField ID="click_count" runat="server" Value="0" />
            </td>
        </tr>
    </table>
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
