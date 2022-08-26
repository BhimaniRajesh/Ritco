<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DDMRUpdateProcessResult.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_POViewPrint_POViewPrintResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        //var cal = new CalendarPopup("Div1"); 
	    //cal.setCssPrefix("TEST");
	    //cal.showNavigationDropdowns();
	    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var FinYear="<%=Session["FinYear"]%>";
        
        var FRM_NM = "ctl00_MyCPH1_"
        function Check_All(Grd_Name, Obj_chk_All, Obj_Chk_Ind) {

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
    
        function OnSub_DATACHECK() 
        {
            //alert("H");
            //alert(document.getElementById("ctl00_MyCPH1_GV_DDMRList"));
            var tbl = document.getElementById("ctl00_MyCPH1_GV_DDMRList");
            var Totalcount = tbl.rows.length;
            var Check_flag = "N";
            for (i = 2; i <= Totalcount; i++) 
            {
                if (i < 10) {
                    if (document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl0" + i + "_Chk_Docno").checked == true) {
                        Check_flag = "Y";
                    }
                }
                else {
                    if (document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl" + i + "_Chk_Docno").checked == true) {
                        Check_flag = "Y";
                    }
                }
            }
            if (Check_flag != "Y") {
                alert("Please Select Atleast One Records");
                return false;
            }
        }
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=GV_DDMRList.ClientID%>");
            var rbs = gv.getElementsByTagName("input");
            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        } 
    </script>
    <br />
    <br />
    <table border="0" cellpadding="3" width="700" bgcolor="#ffffff" cellspacing="1" class="boxbg"
        align="left">
        <tr class="hrow">
            <td colspan="3" align="center">
                <asp:Label ID="lblDDMR" CssClass="ffnt" Font-Bold="true" runat="server">DDMR Update Process</asp:Label>
            </td>
        </tr>
        <tr bgcolor="white" id="gridview" runat="server" visible="true">
            <td>
                <br />
                <asp:GridView ID="GV_DDMRList" runat="server" align="left" BorderWidth="0" CellSpacing="1"
                    CellPadding="2" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="1"
                    Width="100%" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="30px" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DDMR Sheet No." ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="150px" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="LblMRSNO" Text='<%# DataBinder.Eval(Container.DataItem, "DDMRNo") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dockets Given" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="100px" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="LblDOCKNO" Text='<%# DataBinder.Eval(Container.DataItem, "DocketCNT") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PKT GIVEN" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="LblPktGiven" Text='<%# DataBinder.Eval(Container.DataItem, "PktGiven") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PKT DELIVERED" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="LblDeliveredPkt" Text='<%# DataBinder.Eval(Container.DataItem, "DeliveredPkt") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PENDING PKT" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="LblPendPkt" Text='<%# DataBinder.Eval(Container.DataItem, "PendPkt") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="30px" HorizontalAlign="Center" />
                            <%--<HeaderTemplate>
                                <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_DDMRList','ChkAll','Chk_Docno')" />
                            </HeaderTemplate>--%>
                            <ItemTemplate>
                                <%--<asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>--%>
                                <asp:RadioButton  ID="Chk_Docno" onclick="RadioCheck(this);" runat="server"/>
                                <%--<asp:CheckBox ID="Chk_Docno" runat="server" />--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr align="center" bgcolor="white" id="submit" runat="server" visible="true">
            <td class="frow" colspan="3">
                <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" runat="server"
                    Text="Submit" Width="75px" CssClass="fbtn" OnClick="btnShow_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
