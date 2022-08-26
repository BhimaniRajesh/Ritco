<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GRNSelectionResult.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_POViewPrint_POViewPrintResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        /*************************************************************************************************************
        FUNCTION FOr Check All
        *************************************************************************************************************/
        var FRM_NM = "ctl00_MyCPH1_"
        function Check_All(Grd_Name, Obj_chk_All, Obj_Chk_Ind, CalC_YN) {
            //debugger;
            Grid_Id = Grd_Name
            var grid = document.getElementById("ctl00_MyCPH1_" + Grid_Id);
            var rows = grid.rows.length;
            var Check_One = "N"
            var Total_amount = "0.00", NetAmt = "0.00", TotalNetAmt = "0.00"
            if (document.getElementById("ctl00$MyCPH1$" + Grid_Id + "$ctl01$" + Obj_chk_All).checked) {
                for (var b = 2; b <= rows ; b++) {
                    if (b < 10)
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
                    else
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";

                    document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = true

                }
            }
            else {
                for (var b = 2; b <= rows; b++) {
                    if (b < 10)
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
                    else
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";

                    document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = false

                }
            }
        }

        function CheckDocketSelection(txtdocketlist, txtdocketlist_count) {
            var mTotalRecords = "<%=intTotalRecords %>"
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";

            for (var i = 0; i < mTotalRecords; i++) {
                j = i + 2;
                if (j < 10) {
                    mDerivedControlName = "ctl00$MyCPH1$dgPODetails$ctl" + "0" + j + "$chkDock"
                }
                else {
                    mDerivedControlName = "ctl00$MyCPH1$dgPODetails$ctl" + j + "$chkDock"
                }
                if (document.getElementById(mDerivedControlName)) {
                    if (document.getElementById(mDerivedControlName).checked == true) {
                        if (mSelection == 0) {
                            mSelection = 1;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }
            if (mSelection == 0) {
                alert("Select atleast one GRN For Accounting!");
                return false;
            }
            txtdocketlist_count.value = mSelection
            txtdocketlist.value = mSelectedDockets;

            return true;
        }

        function Popup(Path) {
            window.open(Path, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }

        function PopupNew(GRNNo, Status, printyn) {
            var typ = Status.toUpperCase();
            if (typ == "GPO") {
                window.open("../ViewPrint/GRNView.aspx?Type=PO&GRNNO=" + GRNNo + "," + printyn + "", "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            }
            else if (typ == "STN") {
                window.open("../ViewPrint/GRNView.aspx?Type=STN&GRNNO=" + GRNNo + "," + printyn + "", "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            }
            else
                window.open("../GRNGeneration/GRNSKUView.aspx?GRNNO=" + GRNNo + "", "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            //window.open(Path, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    
    </script>

    <table border="0" cellpadding="3" width="600" bgcolor="#ffffff" cellspacing="1" class="boxbg"
        align="left">
        <tr class="nrow" align="center">
            <td align="left" colspan="2">
                <table border="0" cellpadding="3" width="600" bgcolor="#ffffff" cellspacing="1" class="boxbg"
                    align="left">
                    <tr class="hrow" align="center">
                        <td align="center" colspan="2">
                            <asp:Label ID="lblWelcome" runat="server" Text="GRN Details" CssClass="blackfnt"
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
                            <font class="blackfnt"><b>GRN Code</b></font>
                        </td>
                        <td align="left">
                            <font class="blackfnt">
                                <asp:Label ID="lblGRNCode" runat="server"></asp:Label></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="left">
                            <font class="blackfnt"><b>Manual GRN Code</b></font>
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
        <tr class="nrow" align="center">
            <td align="left" colspan="2">
                <table border="0" cellpadding="3" width="600" bgcolor="#ffffff" cellspacing="1" class="boxbg"
                    align="left">
                    <tr class="nrow" align="center">
                        <td align="left" colspan="2">
                            <asp:GridView ID="dgPODetails" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5"
                                HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AutoGenerateColumns="false"
                                CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8ba0e5"
                                Width="600">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('dgPODetails','ChkAll','chkDock','N')" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center>
                                                <asp:CheckBox ID="chkDock" runat="server" />
                                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>
                                            </center>
                                        </ItemTemplate>
                                        <FooterStyle CssClass="Blackfnt" BackColor="white" />
                                        <FooterTemplate>
                                            <center>
                                                <asp:Label CssClass="blackfnt" ID="dktamt_final" Text='' runat="server">
                                                </asp:Label>
                                            </center>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GRN No">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="120" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPOCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"GRNNO") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manual GRN No">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="120" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblManPOCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ManualGRNNO") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GRN Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPODate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"GRNDT") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vendor Name">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="170" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblVendorName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VENDORCD") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Total Qty.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalQty" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"QTY") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <%--<asp:TemplateField HeaderText="Received Qty.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblBalanceQty" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ReceivedQTY") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Total Amount">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalAmt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"TOTALAMT") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="GRN Status">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalAmt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"GRNSTATUS") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="50" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <a href="JavaScript:PopupNew('<%#DataBinder.Eval(Container.DataItem,"GRNNO") %>','<%#DataBinder.Eval(Container.DataItem,"Status") %>',0)">
                                                <font class="blackfnt">View</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Print">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="50" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <a href="JavaScript:PopupNew('<%#DataBinder.Eval(Container.DataItem,"GRNNO") %>','<%#DataBinder.Eval(Container.DataItem,"Status") %>',1)">
                                                <font class="blackfnt">Print</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                </Columns>
                                <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                <PagerStyle HorizontalAlign="Left" />
                                <HeaderStyle CssClass="dgHeaderStyle" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td colspan="3">
                            <table border="0" cellpadding="3" cellspacing="1" style="width: 100%" align="left" >
                                <tr bgcolor="white" align="center">
                                    <td>
                                        <asp:Button ID="Button1" runat="server" CssClass="blackfnt" Text="Submit" 
                                            onclick="Button1_Click"/>
                                    </td>
                                </tr>
                            </table>
                            <asp:HiddenField ID="txtdocketlist" runat="server" />
                            <asp:HiddenField ID="txtdocketlist_count" runat="server" />
                            <asp:HiddenField ID="hidSelectGRN" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
