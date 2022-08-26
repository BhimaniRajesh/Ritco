<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Accounts.aspx.cs" Inherits="GUI_admin_Accounts_masters_Accounts_Add_Accounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../Js/add_accounts.js"></script>
    <script language="javascript" type="text/javascript">
        function openLocation(flag) {
            window.open("frmLocation.aspx?flag=" + flag + "", 'myWindow', 'height=440,width=450,resizable=yes,scrollbars=yes,left=310,top=15');
        }
        function valid(obj, dlstCategory, dlstGroup, txtAcctDesc, dlstAcctCategory) {
            var hdnmancoderule = document.getElementById("ctl00_MyCPH1_hdnmancoderule");
            var hdnbrcdrule = document.getElementById("ctl00_MyCPH1_hdnbrcdrule");

            if (dlstCategory.value == "") {
                alert("Please Select Main Category !!")
                dlstCategory.focus();
                return false;
            }
            if (dlstGroup.value == "Select") {
                alert("Please Select Account Group !!")
                dlstGroup.focus();
                return false;
            }
            if (hdnmancoderule.value == "N") {
                var txtManCode = document.getElementById("ctl00_MyCPH1_txtManCode");
                if (txtManCode.value == "") {
                    alert("Please Enter Manual Account Code !!")
                    txtManCode.focus();
                    return false;
                }
            }
            if (hdnbrcdrule.value == "Y") {
                var chkallbrcd = document.getElementById("ctl00_MyCPH1_chkallbrcd");
                if (chkallbrcd.checked == false) {
                    var txtbrcd = document.getElementById("ctl00_MyCPH1_txtbrcd");
                    if (txtbrcd.value == "") {
                        alert("Please Enter Applicable to Accounting Locations !!")
                        txtbrcd.focus();
                        return false;
                    }
                }
            }
            if (txtAcctDesc.value == "") {
                alert("Please Enter Account Description !!")
                txtAcctDesc.focus();
                return false;
            }
            if (dlstAcctCategory.value == "") {
                alert("Please Select Account Category !!")
                dlstAcctCategory.focus();
                return false;
            }
            if (dlstAcctCategory.value == "BANK") {
                var txtAcctNumber = document.getElementById("ctl00_MyCPH1_txtAcctNumber");
                var txtLocation = document.getElementById("ctl00_MyCPH1_txtLocation");

                if (txtAcctNumber.value == "") {
                    alert("Please Enter Account Number !!")
                    txtAcctNumber.focus();
                    return false;
                }
                else if (txtLocation.value == "") {
                    alert("Please Enter Applicable to Locations !!")
                    txtLocation.focus();
                    return false;
                }
            }
            return true;
        }
        function CompAccBlur(id, accode, val) {
            document.getElementById(id).value = document.getElementById(id).value.toUpperCase()
            var txtManCode = document.getElementById(id);
            var acode = accode;
            var value = val;

            var ManCode = txtManCode.value.toUpperCase();

            if (ManCode == "")
                return false;

            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {

                var strpg = "CheckExist.aspx?mode=AccCode&val=" + value + "&accode=" + acode + "&Code=" + ManCode + "&sid=" + Math.random();
                findobj.open("GET", strpg, true);
                findobj.onreadystatechange = function () {

                    if (findobj.readyState == 4 && findobj.status == 200) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "true") {
                            alert(res[1]);
                            txtManCode.value = "";
                            txtManCode.focus();
                            return false;
                        }
                    }
                }

                findobj.send(null);
            }
            return false;
        }
    </script>
    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <br />
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                            <tr>
                                <td align="right">
                                    <img src="../../../images/loading.gif" alt="" /></td>
                                <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                            </tr>
                        </table>
                        <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                            runat="server">
                            <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                                ID="Panel2" runat="server">
                            </asp:Panel>
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <br />
                <table border="0" width="100%">
                    <tr>
                        <td style="width: 10%"></td>
                        <td width="90%">
                            <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width: 720px;">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <font class="blackfnt"><b>Add/Edit Accounts</b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left" style="width: 284px">
                                        <font class="blackfnt">&nbsp;Account Code</font></td>
                                    <td align="left">
                                        <font class="redfnt">
                                            <asp:Label ID="lblId" runat="server" CssClass="redfnt"
                                                Text="Label"></asp:Label></font></td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left" style="width: 284px">
                                        <font class="blackfnt">&nbsp;Select Main Category</font></td>
                                    <td align="left">
                                        <font class="blackfnt">
                                            <asp:DropDownList ID="dlstCategory" CssClass="blackfnt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Change_Group" Width="100px">
                                                <asp:ListItem Value="">Select</asp:ListItem>
                                                <asp:ListItem Value="ASSET">ASSET</asp:ListItem>
                                                <asp:ListItem Value="EXPENSE">EXPENSE</asp:ListItem>
                                                <asp:ListItem Value="INCOME">INCOME</asp:ListItem>
                                                <asp:ListItem Value="LIABILITY">LIABILITY</asp:ListItem>
                                            </asp:DropDownList>
                                        </font></td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left" style="width: 284px">
                                        <font class="blackfnt">&nbsp;Select Group</font></td>
                                    <td align="left">
                                        <asp:DropDownList ID="dlstGroup" CssClass="blackfnt" runat="server" Width="300px">
                                            <asp:ListItem>Select</asp:ListItem>
                                        </asp:DropDownList></td>
                                </tr>
                                <tr id="trManualAccCode" bgcolor="white" runat="server">
                                    <td align="left" style="width: 284px">
                                        <font class="blackfnt">&nbsp;Manual Account Code</font></td>
                                    <td align="left">
                                        <asp:TextBox ID="txtManCode" BorderStyle="Groove" runat="server" Width="300px" MaxLength="10"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trbrcd" bgcolor="white" runat="server">
                                    <td align="left" style="width: 284px">
                                        <font class="blackfnt">&nbsp;Applicable Accounting Locations</font></td>
                                    <td align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="100%">
                                            <tr bgcolor="white">
                                                <td align="left">
                                                    <asp:CheckBox ID="chkallbrcd" runat="server" Checked="true" Text="Check Here For Select All Branch" OnCheckedChanged="VisibleBrcdTextBox" AutoPostBack="true" />
                                                </td>
                                            </tr>
                                            <tr id="trAllbrcd" runat="server" bgcolor="white" visible="false">
                                                <td align="left">
                                                    <font class="blackfnt">
                                                        <asp:TextBox ID="txtbrcd" BorderStyle="Groove" runat="server" MaxLength="1000" TextMode="MultiLine" Width="375px" Height="80"></asp:TextBox>
                                                        &nbsp;
                                                        <button name="submit1" text="Submit" onclick="openLocation('Y')">...</button>
                                                    </font>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left" style="width: 284px">
                                        <font class="blackfnt">&nbsp;Account Description</font></td>
                                    <td align="left">
                                        <font class="blackfnt">
                                            <asp:TextBox ID="txtAcctDesc" BorderStyle="Groove" runat="server" Width="269px" MaxLength="100"></asp:TextBox></font></td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left" style="width: 284px">
                                        <font class="blackfnt">&nbsp;Account Category</font></td>
                                    <td align="left">
                                        <font class="blackfnt">
                                            <asp:DropDownList CssClass="blackfnt" ID="dlstAcctCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="change_cat_table" Width="100px">
                                            </asp:DropDownList>

                                            <label class="blackfnt" style="margin-left:150px;">Exception Leger</label>
                                            <asp:CheckBox ID="chkExceptionLeger" runat="server" Checked="false" align="right" />
                                        </font>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left" style="width: 284px">
                                        <font class="blackfnt">&nbsp;Active</font></td>
                                    <td align="left">
                                        <asp:CheckBox ID="chkActive" runat="server" Checked="false" />
                                    </td>
                                </tr>
                            </table>
                            <asp:UpdatePanel ID="up4" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <table id="Table1" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 720px; height: 89px;" runat="server">
                                        <tr class="bgbluegrey">
                                            <td align="center" colspan="2">
                                                <font class="blackfnt"><b>Provide Location detail for a Bank account</b></font>
                                            </td>
                                        </tr>
                                        <tr bgcolor="white">
                                            <td align="left" style="width: 284px">
                                                <font class="blackfnt">&nbsp;Account Number</font></td>
                                            <td align="left">
                                                <font class="blackfnt">&nbsp;<asp:TextBox ID="txtAcctNumber" BorderStyle="Groove" runat="server" MaxLength="25"></asp:TextBox>
                                                </font>
                                            </td>
                                        </tr>
                                        <tr bgcolor="white">
                                            <td align="left" style="width: 284px">
                                                <font class="blackfnt">&nbsp;Applicable to Locations</font></td>
                                            <td align="left">
                                                <font class="blackfnt">&nbsp;<asp:TextBox ID="txtLocation" BorderStyle="Groove" runat="server" MaxLength="1000" TextMode="MultiLine" Width="380px" Height="80"></asp:TextBox>
                                                    &nbsp;
                                                    <button name="submit" text="Submit" onclick="openLocation('N')">...</button>
                                                </font>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="dlstAcctCategory" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                            &nbsp;<br />
                            <br />
                            <table border="0" cellpadding="0" cellspacing="0" class="boxbg" style="width: 607px">
                                <tr bgcolor="white">
                                    <td align="center" style="height: 24px">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                                        <asp:HiddenField ID="hdnmancoderule" runat="server" />
                                        <asp:HiddenField ID="hdnbrcdrule" runat="server" />
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
