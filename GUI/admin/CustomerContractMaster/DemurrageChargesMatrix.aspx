<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DemurrageChargesMatrix.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_DemurrageChargesMatrix" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
      <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

   <script type="text/javascript" language="javascript">

        function windowPopUp(mode, ctlid, tbl) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var url = "";
            url = "DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=4row";
            confirmWin = window.open(url, "", winOpts);
            return false;
        }
function Roundval(data){
if ($(data).val().length == 0) {
    $(data).val("0");
};
}

        function locTest(txtid, testtype) {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            hdnajaxstate.value = "1";

            var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
            var txt = document.getElementById(txtid);
            if (txt.value == "") {
                hdnajaxstate.value = "0";
                return false;
            }

            txt.value = txt.value.toUpperCase();
            var strpg = "";
            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                if (testtype == "citytest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=citytest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                else if (testtype == "loctest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                else if (testtype == "zonetest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=zonetest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

                findobj.open("GET", strpg);
                findobj.onreadystatechange = function () {
                    if ((findobj.readyState == 4) && (findobj.status == 200)) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false") {
                            if (testtype == "citytest")
                                alert("City doesn't Exists...");
                            else if (testtype == "loctest")
                                alert("Location doesn't Exists...");
                            else if (testtype == "zonetest")
                                alert("Region doesn't Exists...");
                            txt.value = "";
                            txt.focus();
                            hdnajaxstate.value = "0";
                            return false;
                        }
                        else if (res[0] == "true") {
                            hdnajaxstate.value = "0";
                        }
                    }
                }

                findobj.send(null);
            }

            return true;
        }


        function submitValidation() {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            if (hdnajaxstate.value == "1") {
                alert("Let the Internal Processes over. Please wait 5-10 seconds or LogOut.");
                return false;
            }

            var grid = document.getElementById("ctl00_MyCPH1_grvcharges");
            var len = parseInt(grid.rows.length);
            var pref = "";
            var cnt = 0;
            for (var i = 2; i <= len; i++) {
                if (i < 10)
                    pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";

                var txtfrom = document.getElementById(pref + "txtfrom");
                var txtto = document.getElementById(pref + "txtto");
                var chkyes = document.getElementById(pref + "chkyes");
                var txtFreeStorageDay = document.getElementById(pref + "txtFreeStorageDay");
                var txtrate1 = document.getElementById(pref + "txtrate1");
                var txtrate2 = document.getElementById(pref + "txtrate2");
                var txtrate3 = document.getElementById(pref + "txtrate3");
                var ddlProductType = document.getElementById(pref + "ddlProductType");
                if (chkyes.checked == true) {
                    cnt++;

                    if (txtfrom.value == "") {
                        alert("Please Enter From Location");
                        txtfrom.focus();
                        return false;
                    }

                    if (txtto.value == "") {
                        alert("Please Enter To Location");
                        txtto.focus();
                        return false;
                    }

                    if (ddlProductType.value == "") {
                        alert("Please Enter Product Type");
                        ddlProductType.focus();
                        return false;
                    }

                    for (var j = 2; j < len; j++) {
                        var jref = "";
                        if (j < 10)
                            jref = "ctl00_MyCPH1_grvcharges_ctl0" + j + "_";
                        else
                            jref = "ctl00_MyCPH1_grvcharges_ctl" + j + "_";

                        var txtjfrom = document.getElementById(jref + "txtfrom");
                        var txtjto = document.getElementById(jref + "txtto");
                        var ddljProductType = document.getElementById(jref + "ddlProductType");
                        var chkjyes = document.getElementById(jref + "chkyes");

                        if (chkjyes.checked == true) {

                            if (i != j) {

                                if (txtjfrom.value == "") {
                                    alert("Please Enter From Location");
                                    txtjfrom.focus();
                                    return false;
                                }

                                if (txtjto.value == "") {
                                    alert("Please Enter To Location");
                                    txtto.focus();
                                    return false;
                                }
                                if (ddljProductType.value == "") {
                                    alert("Please Enter Product Type");
                                    ddlProductType.focus();
                                    return false;
                                }

                                if (txtto.value == txtjto.value && txtfrom.value == txtjfrom.value && txtfrom.value == ddljProductType.value) {
                                    alert("No Two  pair should be same.Please Enter Another Location");
                                    txtto.value = "";
                                    txtto.focus();
                                    return false;
                                }

                            } // i!=j
                        }// chk j yes
                    } //  J loop


                    for (var j = 1; j <=3; j++) {
                      
                        var txtIfrom = document.getElementById(pref+"txtfrom" + j);
                        var txtIto = document.getElementById(pref + "txtto" + j);

                        if (isNaN(txtIfrom.value) || txtIfrom.value == "")
                            txtIfrom.value = "0";

                        if (isNaN(txtIto.value) || txtIto.value == "")
                            txtIto.value = "0";

                        var cmbIratetype = document.getElementById(pref + "txtrate"+j);
                        if (cmbIratetype.value != "0") {
                            if (parseInt(txtIto.value) <= parseInt(txtIfrom.value)) {
                                alert("To Value for Slab " + j + " is Not less than From Value for Slab " + j);
                                return false;
                            }
                         
                        }

                        for (var k = j + 1; k<= 3; k++) {
                            var txtJfrom = document.getElementById(pref+"txtfrom" + k);
                            var txtJto = document.getElementById(pref + "txtto" + k);

                            if (isNaN(txtJfrom.value) || txtJfrom.value == "")
                                txtJfrom.value = "0";

                            if (isNaN(txtJto.value) || txtJto.value == "")
                                txtJto.value = "0";

                            var cmbJratetype = document.getElementById(pref + "txtrate" + k);
                            if (cmbJratetype.value == "0")
                                continue;



                            if (parseInt(txtJfrom.value) <= parseInt(txtIfrom.value) || parseInt(txtJfrom.value) <= parseInt(txtIto.value)) {
                                alert("From Value for Slab " + k+ " is Not less than From Value for Slab " + j);
                                return false;
                            }

                            if (parseInt(txtJto.value) <= parseInt(txtIto.value) || parseInt(txtJto.value) <= parseInt(txtIto.value)) {
                                alert("To Value for Slab " + k + " is Not less than To Value for Slab " + j);
                                return false;
                            }
                        }
                    }

                } // Check of YES/NO        

            } // I loop

            if (cnt == 0) {
                alert("Please Select Atleast one Record........");
                return false;
            }
            return true;
        }
    </script>

    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
            <cust:CustInfo runat="server" ID="cstheader" />
            <br />
            <asp:Panel ID="Panel1" runat="server" width="10in">
                <Table ID="Table1" runat="server" width="100%">
                    <tr class="bgwhite">
                        <td colspan="2" class="blackfnt">
                            Please Note : &nbsp;<font class='redfnt'>Existing Data will be Replaced, if any</font>
                        </td>
                    </tr>
                    <tr CssClass="bgwhite">
                        <td colspan="2" class="blackfnt">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <Table ID="Table2"  runat="server" cellspacing="1" class="boxbg"
                                width="500px">
                                <tr class="bgwhite">
                                    <td  align="Left">Charge Name
                                    </td>
                                    <td width="50%" align="Left">
                                        <asp:Label ID="lblchargename" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>&nbsp;
                                        <asp:Label ID="lblinstance" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td width="50%" align="Left">Matrix Type
                                    </td>
                                    <td width="50%" align="Left">
                                        <asp:Label ID="lblmatrixtype" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td width="50%" align="Left">Trans Mode
                                    </td>
                                    <td width="50%" align="Left">
                                        <asp:Label ID="lbltransmode" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td width="50%" align="Left">From Location Filter
                                    </td>
                                    <td width="50%" align="Left">
                                        <asp:Label ID="lblfilterfrom" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td width="50%" align="Left">To Location Filter
                                    </td>
                                    <td width="50%" align="Left">
                                        <asp:Label ID="lblfilterto" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                            </Table>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <Table ID="tblmain" cellspacing="1" class="boxbg" runat="server">
                                <tr class="bgbluegrey">
                                    <td colspan="2"><b>Delivery Point Charges</b>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td width="20%">Enter No of Rows
                                    </td>
                                    <td width="80%">
                                        <asp:TextBox ID="txtrows" width="40px" Style="text-align: right;" onkeypress="javascript:return validInt(event)"
                                            BorderStyle="Groove" MaxLength="2" CssClass="blackfnt" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnaddrows" runat="server" OnClick="btnaddrows_Click" CssClass="blackfnt"
                                            Text="Add New Rows" />
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td colspan="2">
                                        <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" Borderwidth="0"
                                            CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                            HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                                            AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" EmptyDataText="No Records Found..."
                                            OnRowDataBound="grvcharges_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkyes" runat="server" />
                                                        <asp:HiddenField ID="hdnSrno" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"Srno") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                    <HeaderTemplate>
                                                        From 
                                                        <input type="button" id="btnfrom" runat="server" class="blackfnt" value="...." />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtfrom" width="50px" Text='<%# DataBinder.Eval( Container.DataItem,"FromLocation") %>'
                                                                        BorderStyle="Groove" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <input type="button" id="btnfrom" runat="server" onclick="return false;" class="blackfnt"
                                                                        value="...." />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                    <HeaderTemplate>
                                                        To
                                                        <input type="button" id="btnto" runat="server" class="blackfnt" value="...." />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtto" width="50px" Text='<%# DataBinder.Eval( Container.DataItem,"ToLocation") %>'
                                                                        BorderStyle="Groove" CssClass="blackfnt" runat="server"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <input type="button" id="btnto" runat="server" onclick="return false;" class="blackfnt"
                                                                        value="...." />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                   <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                       Product (Say to Contain)
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlProductType" runat="server" CssClass="blackfnt" BackColor="white">
                                                                                                                    
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Free Storage Days
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtFreeStorageDay" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"FreeStorageDay") %>'
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                          width="50px"
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt GridHeadPadding"  />
                                                    <HeaderTemplate>
                                                       Slab 1 (in days)
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtFrom1" BorderStyle="Groove" Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            width="50px"
                                                            runat="server"></asp:TextBox>
                                                         <asp:TextBox ID="txtTo1" BorderStyle="Groove" Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            width="50px"
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Rate of Demurrage 

                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White"/>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtrate1" BorderStyle="Groove" Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            onblur="javascript:Roundval(this)" width="50px"
                                                            runat="server" autocomplete="off" onpaste="return false"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                  <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt GridHeadPadding" />
                                                    <HeaderTemplate>
                                                       Slab 2 (in days)
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White"  />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtFrom2" BorderStyle="Groove"  Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            width="50px"
                                                            runat="server"></asp:TextBox>
                                                         <asp:TextBox ID="txtTo2" BorderStyle="Groove" Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            width="50px"
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Rate of Demurrage 

                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtrate2" BorderStyle="Groove" Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            onblur="javascript:Roundval(this)" width="50px"
                                                            runat="server" autocomplete="off" onpaste="return false"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt GridHeadPadding" />
                                                    <HeaderTemplate>
                                                       Slab 3 (in days)
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtFrom3" BorderStyle="Groove" Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            width="50px"
                                                            runat="server"></asp:TextBox>
                                                         <asp:TextBox ID="txtTo3" BorderStyle="Groove" Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            width="50px"
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Rate of Demurrage 

                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtrate3" BorderStyle="Groove" Text=""
                                                            Style="text-align: right;" CssClass="blackfnt" MaxLength="9" onkeypress="javascript:return validInt(event)"
                                                            onblur="javascript:Roundval(this)" width="50px"
                                                            runat="server" autocomplete="off" onpaste="return false"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Rate Type
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlratetype" runat="server" CssClass="blackfnt" BackColor="white">
                                                            <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                                            <asp:ListItem Value="W" Text="PerKG"></asp:ListItem>
                                                            <asp:ListItem Value="P" Text="PerPKG"></asp:ListItem>
                                                            <asp:ListItem Value="T" Text="PerTon"></asp:ListItem>
                                                            <asp:ListItem Value="F" Text="Flat(in RS)"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                      Demurrage Calculation Basis
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlCalculationBasis" runat="server" CssClass="blackfnt" BackColor="white">
                                                          
                                                            <asp:ListItem Text="Inclusive of free storage days" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Exclusive of free storage days " Value="2"></asp:ListItem>
                                                           </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                               
                                              
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey" align="center" >
                                    <td colspan="2">
                                        <asp:Button ID="btnsubmit" CssClass="blackfnt" Text="Submit" runat="server" OnClick="btnsubmit_Click" 
                                     OnClientClick="javascript:return submitValidation()" />
                                    </td>
                                </tr>
                            </Table>
                        </td>
                    </tr>
                </Table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hdncustcode" runat="server" />
    <asp:HiddenField ID="hdncontractid" runat="server" />
    <asp:HiddenField ID="hdnmatrixtype" runat="server" />
    <asp:HiddenField ID="hdnchargecode" runat="server" />
    <asp:HiddenField ID="hdntransmode" runat="server" />
    <asp:HiddenField ID="hdnchargetype" runat="server" />
    <asp:HiddenField ID="hdnbasedon1" runat="server" />
    <asp:HiddenField ID="hdnbasecode1" runat="server" />
    <asp:HiddenField ID="hdnbasedon2" runat="server" />
    <asp:HiddenField ID="hdnbasecode2" runat="server" />
    <asp:HiddenField ID="hdnfrom" runat="server" />
    <asp:HiddenField ID="hdnto" runat="server" />
    <asp:HiddenField ID="hdnajaxstate" runat="server" />
</asp:Content>

