<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Advance_Payment_Step1.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCSelection"
    EnableEventValidation="false" EnableViewStateMac="False" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../VendorPayment.js"></script>

    <script language="javascript" type="text/javascript">

        /*************************************************************************************************************
        FUNCTION FOr Check All
        *************************************************************************************************************/
        var FRM_NM = "ctl00_MyCPH1_"
        function Check_All(Grd_Name, Obj_chk_All, Obj_Chk_Ind,YN) {

            Grid_Id = Grd_Name
            var grid = document.getElementById("ctl00_MyCPH1_" + Grid_Id);
            var rows = grid.rows.length;

            if (document.getElementById("ctl00$MyCPH1$" + Grid_Id + "$ctl01$" + Obj_chk_All).checked) {
                for (var b = 2; b <= rows; b++) {
                    // alert(b)
                    if (b < 10) {
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
                    }
                    else {
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
                    }

                    document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = true
                    //alert("hi..")
                }
            }
            else {
                for (var b = 2; b <= rows; b++) {
                    //alert(b)
                    if (b < 10) {
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
                    }
                    else {
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
                    }

                    document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = false

                }
            }
        }
        
        function CheckDocketSelection()
        {
            var tbl = document.getElementById("ctl00_MyCPH1_GridDocList");
            var Totalcount = tbl.rows.length;
            var Check_flag = "N";
            for (i = 2; i <= Totalcount; i++) {
                if (i < 10) {
                    if (document.getElementById("ctl00_MyCPH1_GridDocList_ctl0" + i + "_Chk_Docno").checked == true) {
                        Check_flag = "Y";
                    }
                }
                else {
                    if (document.getElementById("ctl00_MyCPH1_GridDocList_ctl" + i + "_Chk_Docno").checked == true) {
                        Check_flag = "Y";
                    }
                }
            }
            if (Check_flag != "Y") {
                alert("Please Select Atleast One Records");
                return false;
            }
        }
    </script>

    <br />
    <div align="left">
        <font class="blackfnt"><b>You Selected</b></font>
        <table border="0" width="900">
            <tr>
                <td>
                    <table border="0" cols="1" width="90%" cellspacing="1" cellpadding="3" align="left"
                        class="boxbg" bgcolor="#808080">
                        <tr bgcolor="#ffffff">
                            <td width="205" align="left">
                                <div align="left">
                                    <font class="blackfnt">Document Date</font></div>
                            </td>
                            <td width="343" align="left">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblDocDate" runat="server" Text="Label"></asp:Label></font></div>
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
                                        <asp:Label ID="lblDocType" runat="server" Text="Label"></asp:Label></font></div>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td width="205" align="left">
                                <div align="left">
                                    <font class="blackfnt">Vendor Code~Name</font>
                                </div>
                            </td>
                            <td width="343" align="center">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="Lbl_Vendor" runat="server" Text="Label"></asp:Label></font></div>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td width="205" align="left">
                                <div align="left">
                                    <font class="blackfnt">Payment Type</font>
                                </div>
                            </td>
                            <td width="343" align="center">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblAdvanceBalance" runat="server" Text="-"></asp:Label></font></div>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td width="205" align="left">
                                <div align="left">
                                    <font class="blackfnt">Document No.</font>
                                </div>
                            </td>
                            <td width="343" align="center">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="Lbl_Docno" runat="server" Text="-"></asp:Label></font></div>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td width="205" align="left">
                                <div align="left">
                                    <font class="blackfnt">Manual Document No.</font>
                                </div>
                            </td>
                            <td width="343" align="center">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="Lbl_Manual_Docno" runat="server" Text="-"></asp:Label></font></div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <p align="left">
                        <font class="blackfnt"><b>
                            <asp:Label ID="LBL_Select" runat="server" Text="-"></asp:Label>
                        </b></font>
                    </p>
                    <%--Data Grid --%>
                    <asp:GridView ID="GridDocList" runat="server" BorderWidth="0" HeaderStyle-CssClass="bgbluegrey"
                        AllowSorting="true" AllowPaging="false" PageSize="100" PagerStyle-HorizontalAlign="left"
                        CssClass="boxbg" FooterStyle-CssClass="bgbluegrey" CellSpacing="1" CellPadding="3"
                        AutoGenerateColumns="false" EmptyDataText="No Records Found..." Width="100%">
                        <Columns>
                            <asp:TemplateField ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GridDocList','ChkAll','Chk_Docno','Y')" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                        <asp:CheckBox ID="Chk_Docno" runat="server" />
                                        <asp:HiddenField runat="server" ID="Hnd_docno" Value='<%# DataBinder.Eval(Container.DataItem, "DDMRNo") %>' />
                                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        <%--  <asp:CheckBox id="chkDock" runat="server"  onclick="javascript:Check_Calc('GridDocList','ChkAll','Chk_Docno')"  />--%>
                                    </center>
                                </ItemTemplate>
                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DDMRNo" HeaderText="DocNO." ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ManualDDMRNo" HeaderText="Manual DocNO." ItemStyle-Wrap="false"
                                ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DocType" HeaderText="Document Type" ItemStyle-HorizontalAlign="Center"
                                ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Vehicle" HeaderText="Vehicle No. " ItemStyle-Wrap="false"
                                ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                             <asp:BoundField DataField="FtlTypeDesc" HeaderText="FTL Type" ItemStyle-Wrap="false"
                                ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DocDt" HeaderText="Doc Date" ItemStyle-Wrap="false"
                                ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Brcd" HeaderText="Start Branch" ItemStyle-Wrap="false"
                                ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                            <%--<asp:BoundField DataField="routecd" HeaderText="Route Code" ItemStyle-Wrap="false"
                                ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" ItemStyle-Wrap="false"
                                ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
            <tr class="bgbluegrey" align="center">
                <td>
                    <%--<asp:HiddenField ID="txtdocketlist" runat="server" />
                    <asp:HiddenField ID="txtdocketlist_count" runat="server" />--%>
                    <asp:Button ID="ButSubmit" runat="server" CssClass="blackfnt" Text="Submit" 
                        onclick="ButSubmit_Click" OnClientClick="Javascript:return CheckDocketSelection();"/>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
