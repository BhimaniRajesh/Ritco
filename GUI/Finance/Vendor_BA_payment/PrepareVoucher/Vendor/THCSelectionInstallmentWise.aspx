<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="THCSelectionInstallmentWise.aspx.cs"
    Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCSelectionInstallmentWise"
    EnableEventValidation="false" EnableViewStateMac="False" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        var checkSelection = 0;
        //*************Comminted by sandeep Maurya on 30 Dec 2016*******************************//
        var thcNumber = "";
        // document.getElementById(ctl00_MyCPH1_txtdocketlist).value = thcNumber;
        function CheckDocketSelection(txtdocketlist, txtdocketlist_count) {
            //Get count of records fetched

            var mTotalRecords = "<%=intTotalRecords %>"

            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
            //alert(mTotalRecords)
            for (var i = 0; i < mTotalRecords; i++) {
                j = i + 2;

                if (j < 10) {

                    mDerivedControlName = "ctl00_MyCPH1_GridTHCList_ctl" + "0" + j + "_chkDock"

                }
                else {
                    mDerivedControlName = "ctl00_MyCPH1_GridTHCList_ctl" + j + "_chkDock"

                }

                if (document.getElementById(mDerivedControlName)) {
                    if (document.getElementById(mDerivedControlName).checked == true) {
                        mSelection = mSelection + 1;
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }

            if (mSelection == 0) {
                alert("Select atleast one Document....!");
                return false;
            }

            document.getElementById("ctl00_MyCPH1_txtdocketlist").value = mSelection;
            document.getElementById("ctl00_MyCPH1_txtdocketlist_count").value = mSelectedDockets;
            //txtdocketlist.value = mSelection
            //txtdocketlist_count.value = mSelectedDockets;

            return true;
        }
        //**************************End*****************************************//
        //*************Added by sandeep Maurya on 30 Dec 2016*******************************//
        //function CheckDocketSelection()
        //{
        //    if (checkSelection == 0) {
        //        alert("Select atleast one Document ....!");
        //        return false;
        //    }
        //    else
        //        return true;
        //}

        <%-- function RadioCheck(rb) {
            document.getElementById("ctl00_MyCPH1_hdnTHCNo").value = rb.value;
            checkSelection = 1;
            var gv = document.getElementById("<%=GridTHCList.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "checkbox") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }--%>
        //**************************End*****************************************//

    </script>

    <br />
    <div align="center">
        <form id="form1">
            <div align="left">
                <p align="left">
                    <font class="blackfnt"><b>You Selected</b></font>
                </p>
                <table border="0" cellpadding="3" cols="1" style="width: 9.5in" bgcolor="#808080"
                    cellspacing="1" align="left" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td width="205" align="left">
                            <div align="left">
                                <font class="blackfnt">Document Date</font>
                            </div>
                        </td>
                        <td width="343" align="left">
                            <div align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocDate" runat="server" Text="Label"></asp:Label></font>
                            </div>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="205" align="left">
                            <div align="left">
                                <font class="blackfnt">Document Type</font>
                            </div>
                        </td>
                        <td width="343" align="center">
                            <div align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocType" runat="server" Text="Label"></asp:Label></font>
                            </div>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="205" align="left">
                            <div align="left">
                                <font class="blackfnt">Advance/Balance</font>
                            </div>
                        </td>
                        <td width="343" align="center">
                            <div align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblAdvanceBalance" runat="server" Text="Label"></asp:Label></font>
                            </div>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <br />
                <br />
                <p align="left">
                    <font class="blackfnt"><b>Select THC for prepare Payment</b></font>
                </p>
                <br />
                <%--Data Grid --%>
                <asp:GridView ID="GridTHCList" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                    AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false"
                    EmptyDataText="No Records Found..." Style="width: 9.5in">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <center>
                                    <input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"THCNO") %>' />
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="thcno" HeaderText="THC Number ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="vehno" HeaderText="Vehicle Number ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="thcdt" HeaderText="THC Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="thcbr" HeaderText="Start Branch">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="routecd" HeaderText="Route Code">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="routename" HeaderText="Route Name">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VendorCode" HeaderText="Vendor Code">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor Name">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
            </div>
            <br />
            <asp:HiddenField ID="hdnTHCNo" runat="server" Value="" />
            <asp:HiddenField ID="txtdocketlist" runat="server" Value="" />
            <asp:HiddenField ID="txtdocketlist_count" runat="server" />
            <div align="left">
                <asp:Button ID="Button1" runat="server" Visible="false" CssClass="blackfnt" Text="Submit" OnClick="Button1_Click" />
            </div>
        </form>
    </div>
</asp:Content>
