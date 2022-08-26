<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Distance_Based_Contract.aspx.cs" Inherits="GUI_admin_Vendor_contract_Ver1_Distance_Based_Contract" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="Vendor_Contract.js"></script>
    <script type="text/javascript" language="javascript">
        function checkOnSubmit() {
            var grid = document.getElementById("ctl00_MyCPH1_GV_Distance_Matrix");
            var len = parseInt(grid.rows.length);
            var pref = "";
            var cnt = 0;
            for (var i = 2; i <= len; i++) {
                if (i < 10)
                    pref = "ctl00_MyCPH1_GV_Distance_Matrix_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_GV_Distance_Matrix_ctl" + i + "_";

                var ChkInd = document.getElementById(pref + "ChkInd");
                var Ddl_VehNo = document.getElementById(pref + "Ddl_VehNo");
                var Ddl_Veh_Type = document.getElementById(pref + "Ddl_Veh_Type");
                var Ddl_FTL_Type = document.getElementById(pref + "Ddl_FTL_Type");

                var Txt_MinChg = document.getElementById(pref + "Txt_MinChg");
                var Txt_Km = document.getElementById(pref + "Txt_Km");
                var Txt_Ext_Km = document.getElementById(pref + "Txt_Ext_Km");
                var Txt_MaxPayment = document.getElementById(pref + "Txt_MaxPayment");
                var Txt_Trip = document.getElementById(pref + "Txt_Trip");

                if (ChkInd.checked == true) {
                    cnt++;
                    if (Ddl_FTL_Type.value == "") {
                        alert("Please Select FTL Type");
                        Ddl_FTL_Type.focus();
                        return false;
                    }
                    if (Ddl_Veh_Type.value == "") {
                        alert("Please Select From Vehicle Type");
                        Ddl_Veh_Type.focus();
                        return false;
                    }
                    if (Ddl_VehNo.value == "") {
                        alert("Please Select Vehicle");
                        Ddl_VehNo.focus();
                        return false;
                    }

                    if (Txt_MinChg.value == "") {
                        alert("Please Enter Min. Amt. Committed");
                        Txt_MinChg.focus();
                        return false;
                    }
                    if (Txt_Km.value == "") {
                        alert("Please Enter Committed Km.");
                        Txt_Km.focus();
                        return false;
                    }
                    if (Txt_Ext_Km.value == "") {
                        alert("Please Enter Charge Per Additional Km.");
                        Txt_Ext_Km.focus();
                        return false;
                    }

                    if (Txt_MaxPayment.value == "") {
                        alert("Please Enter Max. Payment");
                        Txt_MaxPayment.focus();
                        return false;
                    }
                    if (Txt_Trip.value == "") {
                        alert("Please Enter Committed No. Of Trips/Month");
                        Txt_Trip.focus();
                        return false;
                    }

                    for (var j = 2; j < len; j++) {
                        var jref = "";
                        if (j < 10)
                            jref = "ctl00_MyCPH1_GV_Distance_Matrix_ctl0" + j + "_";
                        else
                            jref = "ctl00_MyCPH1_GV_Distance_Matrix_ctl" + j + "_";

                        if (i != j) {
                            var jDdl_VehNo = document.getElementById(jref + "Ddl_VehNo");
                            var jDdl_Veh_Type = document.getElementById(jref + "Ddl_Veh_Type");
                            var jDdl_FTL_Type = document.getElementById(jref + "Ddl_FTL_Type");
                            if (jDdl_VehNo.value != "" && jDdl_FTL_Type.value != "") {
                                if (jDdl_VehNo.value == Ddl_VehNo.value && jDdl_FTL_Type.value == Ddl_FTL_Type.value) {
                                    alert("Record Already Exist. Please Select Another Type of Movement or Vehicle ");
                                    jDdl_FTL_Type.focus();
                                    return false;
                                }
                            }
                        } // i!=j

                    } //  J loop

                } // Check of YES/NO        

            } // I loop   
            if (cnt == 0) {
                alert("No Record Selected To Save.");
                return false;
            }
            else
                return true;
        }
    </script>
    <div>
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <br />
                            <table border="0" style="width: 5.0in" align="left" cellpadding="3" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <asp:Label ID="Lbl_Contract_title" runat="server" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td colspan="2" align="Left">
                                        <asp:Label ID="Lbl_ADD_Edit" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">Vendor Type:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_VendorType" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">Vendor Code & Name:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_Vendor" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" style="width: 5.0in" align="left" cellpadding="3" cellspacing="1"
                                class="boxbg" id="TB_Matrix" runat="server">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <asp:Label ID="Lbl_Contract_For" runat="server" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff" id="TB_NOOFROW" runat="server">
                                    <td align="Left">
                                        <font class="blackfnt">Enter No. Of Rows</font>
                                    </td>
                                    <td align="Left">
                                        <asp:TextBox ID="Txt_TotRows" runat="server" Text="1" CssClass="blackfnt" BorderStyle="Groove"
                                            Width="60" Style="text-align: right" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                                        <asp:Button ID="Btn_AddRow" OnClick="AddGridRow" runat="server" CssClass="blackfnt"
                                            Text="Add ROW" UseSubmitBehavior="False" />
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left" colspan="2">
                                        <asp:GridView Visible="true" align="left" ID="GV_Distance_Matrix" runat="server"
                                            BorderWidth="0" CellPadding="5" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey"
                                            AllowSorting="false" AllowPaging="false" CssClass="boxbg" AutoGenerateColumns="false"
                                            FooterStyle-CssClass="boxbg" OnRowDataBound="GV_Distance_Matrix_RowDataBound" EmptyDataText="No Records Found...">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_Distance_Matrix','ChkAll','ChkInd','N')" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                            runat="server">
                                                        </asp:Label>
                                                        <asp:CheckBox ID="ChkInd" runat="server" onclick="javascript:Check_Ind('GV_Distance_Matrix','ChkAll','ChkInd')" />
                                                        <asp:HiddenField ID="hidID" runat="server" Value="0" />
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Type of Movement" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_FTL_Type" runat="server" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Vehicle Type" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_Veh_Type" runat="server" CssClass="blackfnt" AutoPostBack="true" OnSelectedIndexChanged="Ddl_Veh_Type_OnSelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Vehicle Number" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_VehNo" runat="server" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Min. Amt. Committed" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_MinChg" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="12"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Committed Km." ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_Km" Text="0" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="9"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Charge Per Additional Km." ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_Ext_Km" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="9"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Max. Payment" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_MaxPayment" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="12"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Committed No. Of Trips/Month" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_Trip" Text="0" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="9"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                                                Width="200" />
                                            <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                                            <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                                Mode="NumericFirstLast" />
                                            <FooterStyle CssClass="boxbg" Wrap="false" Width="200" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <asp:Button ID="Btn_Submit" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Text="Submit Distance Based Matrix Data" OnClientClick="javascript:return checkOnSubmit();" OnClick="Submit_Data" />
                                        &nbsp;
                                        <asp:Button ID="Btn_SubmitWithoutSave" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Text="Continue without saving >>" OnClick="Submit_WithoutSaving" />
                                        <uc1:ProgressBar ID="ProgressBar1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
