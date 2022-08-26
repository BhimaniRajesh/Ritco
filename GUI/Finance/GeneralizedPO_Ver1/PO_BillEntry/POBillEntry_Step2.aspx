<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="POBillEntry_Step2.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">
        var FRM_NM = "ctl00_MyCPH1_"
        function Check_All(Grd_Name, Obj_chk_All, Obj_Chk_Ind, CalC_YN) {

            Grid_Id = Grd_Name
            var grid = document.getElementById("ctl00_MyCPH1_" + Grid_Id);
            var rows = grid.rows.length;
            var Check_One = "N"
            var Total_amount = "0.00", NetAmt = "0.00", TotalNetAmt = "0.00"
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
            if (CalC_YN == "Y") {
                // alert("hi..1")
                Check_Calc('GridDocList', 'ChkAll', 'Chk_Docno')
                // alert("hi..2")
            }
        }
        function Check_Calc(Grd_Name, Obj_chk_All, Obj_Chk_Ind) {

            Grid_Id = Grd_Name
            var grid = document.getElementById("ctl00_MyCPH1_" + Grid_Id);
            var rows = grid.rows.length;
            var Check_ALL = "N"
            var Total_amount = "0.00", NetAmt = "0.00", TotalNetAmt = "0.00"
            var Total_adv_amt = "0.00", Total_PendAmt = "0.00"
            var Total_billAmount = "0"
            for (var b = 2; b <= rows; b++) {

                if (b < 10) {
                    GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
                }
                else {
                    GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
                }
                //alert("1...."+b)
                document.getElementById("ctl00$MyCPH1$" + Grid_Id + "$ctl01$" + Chk_Docno).checked = true
                if (document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked == false) 
                {
                    Check_ALL = "Y"
                }
                if (Check_ALL == "Y") {
                    document.getElementById("ctl00$MyCPH1$" + Grid_Id + "$ctl01$" + Obj_chk_All).checked = false
                }
            }
        }
        function OnSubmit() 
        {
            var Check_YN = "N"
            Grid_Id = "GV_POList"
            var grid = document.getElementById("ctl00_MyCPH1_" + Grid_Id);
            var rows = grid.rows.length;
            for (var b = 2; b <= rows; b++) {

                if (b < 10) {
                    GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
                }
                else {
                    GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
                }
                if (document.getElementById(GV_FRM_NM + "Chk_Docno").checked == true) 
                {
                    Check_YN = "Y"
                }
            }
            if (Check_YN == "N") {
                alert("Please select the atleast one record")
                return false;
            }
        }
    </script>
    <div align="left" style="width: 9.5in;">
        <br />
        <table width="1000" border="0" cellspacing="0" cellpadding="0" align="left">
            <tr>
                <td>
                    <table border="0" cellpadding="3" width="800" cellspacing="1" align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="2">
                                <font class="blackfnt"><b>
                                    <asp:Label Font-Bold="true" ID="Trn_Title1" runat="server" CssClass="blackfnt" Text="Selected Criteria"></asp:Label>
                                </b></font>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td  ">
                                <label class="blackfnt">
                                    Date Selected :</label>
                            </td>
                            <td  >
                                &nbsp;<asp:Label ID="Lbl_Date" runat="server" CssClass="blackfnt"  Text="-" ></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Vendor Name & Code:</label></td>
                            <td  >
                                &nbsp;<asp:Label ID="Lbl_Vendor" Text="-" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Material Category:</label></td>
                            <td  >
                                &nbsp;<asp:Label ID="LblMatCat" Text="-" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td  >
                                <label class="blackfnt">
                                    PO Entry No. :</label></td>
                            <td  >
                                &nbsp;<asp:Label ID="Lbl_POno" runat="server" CssClass="blackfnt" Text="-" ></asp:Label>
                            </td>
                        </tr>
                         <tr style="background-color: #FFFFFF">
                            <td  >
                                <label class="blackfnt">
                                   Manual PO Entry No. :</label></td>
                            <td  >
                                &nbsp;<asp:Label ID="Lbl_Manual_POno" runat="server" CssClass="blackfnt" Text="-" ></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left">
                <br />
                    <asp:GridView ID="GV_POList" runat="server" align="left" BorderWidth="0"  CellSpacing="1" CellPadding="2"
                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                          FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="1"
                        Width="80%" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <HeaderTemplate>
                                    <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_POList','ChkAll','Chk_Docno','N')" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                    </asp:Label>
                                    <asp:CheckBox ID="Chk_Docno" runat="server"  />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PO No" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPOno" Text='<%# DataBinder.Eval(Container.DataItem, "pocode") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Manual PO No" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LblManualPOno" Text='<%# DataBinder.Eval(Container.DataItem, "Manual_PO_No") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PO Date" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LBLPOdt" Text='<%# DataBinder.Eval(Container.DataItem, "POdt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Vendor Code & Name" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LblVendor" Text='<%# DataBinder.Eval(Container.DataItem, "vendorcd") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PO Status" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPOSTATUS" Text='<%# DataBinder.Eval(Container.DataItem, "POSTATUS") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PO Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPaidamt" Text='<%# DataBinder.Eval(Container.DataItem, "Totalamt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pending Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPendamt" Text='<%# DataBinder.Eval(Container.DataItem, "pendamt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Advance Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblTotal" Text='<%# DataBinder.Eval(Container.DataItem, "AdvanceAmt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:Label ID="Lbltotal" Font-Bold="true" runat="server" Text="Total Amount" CssClass="blackfnt"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td><br />
                    <table align="left" cellspacing="1"  width="80%" class="boxbg" border="0" id="ON_Submit"
                        runat="server">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Button ID="btn_submit" Text="Submit" OnClick="btn_submit_Click" BorderStyle="Groove"   CssClass="blackfnt" 
                                OnClientClick="javascript:return OnSubmit()"
                                    runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
