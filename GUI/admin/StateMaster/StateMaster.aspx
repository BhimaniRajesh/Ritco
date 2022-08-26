<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="StateMaster.aspx.cs" Inherits="GUI_admin_StateMaster_StateMaster" %>

<%@ Register TagName="ProgressBar" Src="~/GUI/Common_UserControls/ProgressBar.ascx"
    TagPrefix="probar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
        /*****************************************************************************************************************
        THIS FUCNTION IS USED TO TEST VALID STATE NAME
        *****************************************************************************************************************/

        function validAlfa(e) {

            var code;
            if (!e) var e = window.event;
            if (e.keyCode)
                code = e.keyCode;
            else if (e.which)
                code = e.which;
            else
                return true;

            if (code == 13 || code == 8 || code == 9)
                return true;

            if ((code >= 65 && code <= 90) || (code >= 97 && code <= 122) || code == 32) {
                code = 1; return true;
            }
            else {
                code = 0; return false;
            }


        }

        function checkStateName(id) {
            var hdnStateName = document.getElementById("ctl00_MyCPH1_hdnStateName");

            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");

            var txtStateName = document.getElementById(id);

            var hdnstatnm = document.getElementById("ctl00_MyCPH1_hdnstatnm");

            if (hdnstatnm.value == txtStateName.value)
                return;


            txtStateName.value = txtStateName.value.toUpperCase();


            hdnajaxstate.value = "1";

            if (hdnStateName.value != txtStateName.value) {
                if (txtStateName.value == "") {
                    hdnajaxstate.value = "0";
                    return false;
                }

                var findobj = false;
                findobj = GetXMLHttpObject();
                if (findobj) {
                    var strpg = "../AjaxResponse.aspx?mode=check&code1=state&code2=" + txtStateName.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                    findobj.open("GET", strpg);

                    findobj.onreadystatechange = function () {
                        if ((findobj.readyState == 4) && (findobj.status == 200)) {
                            var res = findobj.responseText.split("|");
                            if (res[0] == "true") {
                                alert(res[1]);
                                txtStateName.value = "";
                                txtStateName.focus();
                                hdnajaxstate.value = "0";
                                return false;
                            }
                            else if (res[0] == "false") {
                                hdnajaxstate.value = "0";
                            }
                        }
                    }
                    findobj.send(null);
                }
            }
            return true;
        }
        /****************************************************************************************************************/

        function btnsubmitClick() {
            var txtstatename = document.getElementById("ctl00_MyCPH1_txtstatename")
            if (txtstatename.value == "") {
                alert("Please Enter State Name.");
                txtstatename.focus();
                return false;
            }

            var txtfreightrate = document.getElementById("ctl00_MyCPH1_txtfreightrate")
            if (txtfreightrate.value == "") {
                alert("Please Enter State Freight Rate.");
                txtfreightrate.focus();
                return false;
            }
            var ddlratetype = document.getElementById("ctl00_MyCPH1_ddlratetype")
            if (ddlratetype.value == "" || ddlratetype.value == "0") {
                alert("Please Enter State Freight Rate Type..");
                ddlratetype.focus();
                return false;
            }

            var txtStateCode = document.getElementById("ctl00_MyCPH1_txtStateCode")
            if (txtStateCode.value == "") {
                alert("Please Enter State Code.");
                txtStateCode.focus();
                return false;
            }

            var grid = document.getElementById("ctl00_MyCPH1_grvstate");
            var rows = grid.rows.length;
            var cnt = 0;

            for (var i = 2; i <= rows; i++) {
                var pref = "";
                if (i < 10)
                    pref = "ctl00_MyCPH1_grvstate_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_grvstate_ctl" + i + "_";

                var chkyes = document.getElementById(pref + "chkyes");
                var txtDocument = document.getElementById(pref + "txtDocument");
                var ddlbound = document.getElementById(pref + "ddlbound");

                if (chkyes.checked == true) {
                    cnt++;
                    if (txtDocument.value == "") {
                        alert("Please Enter Document Name.");
                        txtDocument.focus();
                        return false;
                    }

                    if (ddlbound.value == "0" || ddlbound.value == "") {
                        alert("Please Select I/O Bound.");
                        ddlbound.focus();
                        return false;
                    }
                }
            } // END OF for

            //            if (cnt == 0) {
            //                alert("Please select atleast one document.");
            //                return false;
            //            }

            if (!confirm("Are you sure you want to Submit this Record ?"))
                return false;

            return true;
        } // END OF btnsubmitClick   
    </script>

    <br />
    <br />
    <asp:Panel runat="server" Width="10in">
        <asp:UpdatePanel runat="server" ID="updtFilter" RenderMode="Inline" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:HiddenField ID="hdnstatnm" runat="server" />
                <asp:Table runat="server" CssClass="boxbg" HorizontalAlign="left" CellSpacing="1"
                    Width="75%" ID="tblMain">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell Font-Bold="true" HorizontalAlign="center" CssClass="blackfnt" ColumnSpan="4"
                            Style="height: 20px;">
                            STATE MASTER</asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell>
                            State Code 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left">
                            <asp:Label ID="lblStateCode" runat="server" CssClass="redfnt">&lt;System Generated&gt;</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <font color="red">*</font> State Name 
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtstatename" Width="150px" MaxLength="49" onkeypress="javascript:return validAlfa(event);"
                                onblur="javascript:return checkStateName(this.getAttribute('id'))" runat="server"
                                TabIndex="1" BorderStyle="Groove" CssClass="blackfnt">
                            </asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell Width="25%">
                                 Freight Rate
                        </asp:TableCell>
                        <asp:TableCell Width="25%">
                            <asp:TextBox ID="txtfreightrate" onblur="javascript:this.value = roundNumber(this.value, 2)"
                                TabIndex="2" Style="text-align: right;" Width="100px" MaxLength="10" runat="server"
                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" CssClass="blackfnt"
                                BorderStyle="Groove">
                            </asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell Width="25%">
                                <font color="red">*</font> Freight Rate Type
                        </asp:TableCell>
                        <asp:TableCell Width="25%">
                            <asp:DropDownList ID="ddlratetype" runat="server" CssClass="blackfnt" TabIndex="3"
                                Width="150px">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell HorizontalAlign="left" CssClass="blackfnt" ColumnSpan="0" Style="height: 20px;">
                    Service Tax Exempted
                        </asp:TableCell>
                        <asp:TableCell Width="25%" ColumnSpan="0">
                            <asp:CheckBox ID="chkSTaxFlag" Checked="true" runat="server" CssClass="blackfnt"
                                TabIndex="4" />
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" CssClass="blackfnt" ColumnSpan="0" Style="height: 20px;">
                    Active Flag
                        </asp:TableCell>
                        <asp:TableCell Width="25%" ColumnSpan="0">
                            <asp:CheckBox ID="chkStateactiveflag" Checked="true" runat="server" TabIndex="5"
                                CssClass="blackfnt" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell HorizontalAlign="left" CssClass="blackfnt" ColumnSpan="0" Style="height: 20px;">
                        State Type
                        </asp:TableCell>
                        <asp:TableCell Width="25%" ColumnSpan="0">
                            <asp:DropDownList runat="server" ID="ddlStatetype" Width="140px">
                                <asp:ListItem Text="State" Value="ST" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Union territory" Value="UT"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" CssClass="blackfnt" ColumnSpan="0" Style="height: 20px;">
                        State Code
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" CssClass="blackfnt" ColumnSpan="0" Style="height: 20px;">
                            <asp:TextBox ID="txtStateCode" runat="server" CssClass="blackfnt" Width="80px" MaxLength="10"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>


                    <asp:TableRow HorizontalAlign="center" CssClass="bgwhite">
                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                            Enter No of Rows
                        </asp:TableCell>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Left">
                            <asp:TextBox ID="txtnorows" runat="server" CssClass="blackfnt" Width="40px" MaxLength="2"
                                onkeypress="javascript:return validInt(event)" Style="text-align: right;" BorderStyle="Groove"
                                TabIndex="6">
                            </asp:TextBox>
                            <asp:Button ID="btnaddrows" runat="server" Text="Add Rows" OnClick="btnaddrows_Click"
                                CssClass="nbtn" TabIndex="7" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow HorizontalAlign="center" CssClass="bgwhite">
                        <asp:TableCell HorizontalAlign="center" ColumnSpan="4">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="grvstate" runat="server" HorizontalAlign="center" HeaderStyle-CssClass="bgbluegrey"
                                        OnRowDataBound="grvstate_RowDataBound" PagerStyle-HorizontalAlign="center" CellSpacing="1"
                                        BorderWidth="0" CssClass="boxbg" FooterStyle-CssClass="boxbg" AutoGenerateColumns="False"
                                        Width="100%">
                                        <Columns>
                                            <asp:TemplateField HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle CssClass="bgwhite" />
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkyes" runat="server" CssClass="blackfnt" TabIndex="8" />
                                                    <asp:HiddenField ID="hdfSrNo" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Document Name">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                                <ItemStyle CssClass="bgwhite" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDocument" MaxLength="30" Width="90%" TabIndex="9" CssClass="blackfnt"
                                                        onkeypress="javascript:return withoutQuote(event)" onblur="javascript:return this.value=this.value.toUpperCase();"
                                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="InBound/OutBound.">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle CssClass="bgwhite" />
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlbound" TabIndex="10" runat="server" CssClass="blackfnt"
                                                        Height="22px" Width="150px">
                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                        <asp:ListItem Value="I">Inbound</asp:ListItem>
                                                        <asp:ListItem Value="O">Outbound</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:TemplateField HeaderText="Active Flag">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="bgwhite" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkactiveflag" Checked="true" runat="server" CssClass="blackfnt" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnaddrows" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Center">
                            <asp:Button ID="btnsumit" runat="server" Text="Submit" OnClientClick="javascript:return btnsubmitClick()"
                                TabIndex="11" CssClass="fbtn" OnClick="btnsubmit_Click" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
    <asp:HiddenField ID="hdnStateName" runat="server" />
    <probar:ProgressBar ID="ProgressBar" runat="server" />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>
