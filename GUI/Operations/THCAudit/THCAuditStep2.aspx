<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="THCAuditStep2.aspx.cs" Inherits="GUI_Operations_THCAudit_THCAuditStep2" %>


<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="HR_To" TagPrefix="Location_To" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="JavaScript" src="../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        $(document).ready(function () {
            $("[id*=tblTHCDetail] tr").each(function () {
          //      $(this).find("input[id$=rdbPending]").prop('checked', 'false')
                $(this).find("input[id$=txtRemark]").val("");
               // $(this).find("input[id$=rdbSelect]").prop('checked', 'checked')
            });
        });
        function OnSelectRadioButton(radio) {
            
            var data = radio.value;
            if (data == "select") {

                var grid = $(radio).closest("table");


                $("td", grid).find("input[type=text]").each(function () {
                    var td = $("td", $(radio).closest("tr"));
                    
                    $("input[type=text]", td).attr("disabled", "disabled");
                    $("input[type=text]", td).css({ "background-color": "#FFF" });

                });

            } else {

                var grid = $(radio).closest("table");
                    $("td", grid).find("input[type=text]").each(function () {
                        var td = $("td", $(radio).closest("tr"));
                            $("input[type=text]", td).removeAttr("disabled");
                            $("input[type=text]", td).css({ "background-color": "#D8EBF2" });
                    });

            }
        }
        function ValidateTHCSelect() {
            var returnval = true;
            $("[id*=tblTHCDetail] tr").each(function () {
              
                try {
                    if ($(this).find("input[id$=rdbPending]").is(":checked") == true && $(this).find("input[id$=txtRemark]").val()=="") {
                        returnval = false;
                        throw "Please enter remark for Pending THC !";
                    }
                } catch (e) {
                    alert(e)
                    returnval= false;
                }
            });
            return returnval;
        }
        function OpenWindowTHC(strTHC,view)
        {
            strTHC = strTHC + ".,0";
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=125"
            var strURL = "./../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strTHC
            winNew = window.open(strURL,"_blank",strWinFeature)
           
        }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Oprations</strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>THC Audit Module</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" alt="" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>

                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2">
                                <font class="blackfnt"></font>
                            </td>
                            <td colspan="2">
                                <font class="blackfnt"><b>You selected</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Selected Date</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:Label Text="" Font-Bold="true" ID="lblSelectedDate" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white;">
                            <td align="left" colspan="2">
                                <font class="blackfnt">THC No.</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:Label runat="server" Font-Bold="true" Text="" ID="lblTHCno"> </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white;">
                            <td align="left" colspan="2">
                                <asp:Label class="blackfnt" ID="lblRecord" runat="server"></asp:Label>
                            </td>
                            <td align="left" colspan="2">
                              
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td><br /></td>
            </tr>
            
            <tr>
                <td valign="top">
                    <asp:Repeater runat="server" ID="rptThcDetail" >
                        <HeaderTemplate>
                            <table width="100%"  class="boxbg" border="0"
                                cellpadding="3" cellspacing="1" id="tblTHCDetail" >
                                <tr class="bgbluegrey">
                                    <th>Select
                                    </th>
                                    <th>Deviation
                                    </th>
                                    <th>Branch Name
                                    </th>
                                    <th>THC No
                                    </th>
                                    <th>Manual THC No
                                    </th>
                                    <th>THC Date
                                    </th>
                                    <th>VehicleNo
                                    </th>
                                    <th>From
                                    </th>
                                    <th>To
                                    </th>
                                    <th>Customer Name
                                    </th>
                                    <th>PAN No
                                    </th>
                                    <th>Contract Amount
                                    </th>
                                    <th>Other Amount
                                    </th>
                                    <th>Advance Amount
                                    </th>
                                    <th>Balance Amount
                                    </th>
                                    <th>Balance Payable At
                                    </th>
                                    <th>No of GR
                                    </th>
                                    <th>Total Charged Weight
                                    </th>
                                    <th>Total Actual Weight
                                    </th>
                                    <th>Rate
                                    </th>
                                    <th>Total Freight
                                    </th>
                                    <th>Dep Date
                                    </th>
                                    <th>No Of Package
                                    </th>
                                    <th>Remark
                                    </th>
                                    <th>Audit User Name
                                    </th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>

                            <tr style="background-color: white">
                                <td>
                                    <asp:RadioButton GroupName="THC"  Value="select" ID="rdbSelect" runat="server" onclick="javascript: OnSelectRadioButton(this);" />
                                </td>
                                <td>
                                    <asp:RadioButton GroupName="THC" Value="pending" ID="rdbPending" runat="server" onclick="javascript: OnSelectRadioButton(this);" />

                                </td>

                                <td>

                                    <%# DataBinder.Eval(Container.DataItem, "BranchName") %>
                                </td>
                                <td>
                                    <asp:HiddenField ID="hdnTHCNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"THCNo") %>' />                                      
                                    <a href="JavaScript:OpenWindowTHC('<%# DataBinder.Eval(Container.DataItem,"THCNo") %>')"><%# DataBinder.Eval(Container.DataItem,"THCNo") %>  </a>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "ManualTHCNo") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "THCDate") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "VehicleNo") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "fromcity") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "tocity") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "CustomerName") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "PANNo") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "ContractAmount") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "OtherAdvance") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "AdvanceAmount") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "BalanceAmount") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "BalancePayableAt") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "No_of_Gr") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "TotalChargedWeight") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "TotalActualWeight") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "Rate", "{0:0.00}") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "TotalFreight") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "DepDate") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "NoOfPackage") %>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" Text="" ID="txtRemark" />
                                </td>
                                 <td>
                                    <%# DataBinder.Eval(Container.DataItem, "audited_by") %>
                                </td>
                            </tr>
                        </ItemTemplate>

                        <FooterTemplate>
                            </Table>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
            <tr>
                <td><br /></td>
            </tr>
             <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" OnClientClick="javascript: return ValidateTHCSelect();" Visible="false" runat="server" Text="Submit" Width="100px" />
                            </td>
                        </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
